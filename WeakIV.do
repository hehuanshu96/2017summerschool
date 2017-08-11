cap program drop weakiv
program define weakiv, rclass
        version 15
        syntax [, obs(integer 100) gamma(real 0) b(real 1)]
        drop _all
        set obs `obs'
        tempvar u v
        gen u=rnormal()
		gen v=rnormal()/sqrt(2)+u
		gen z=rnormal()
		gen x=z*`gamma'+v
		gen y=`b'*x+u
		ivreg y (x=z)
		matrix b_temp=e(b)
		matrix se_temp=e(V)
		return scalar b=b_temp[1,1]
		return scalar se=sqrt(se_temp[1,1])
end
simulate b=r(b) se=r(se), reps(100): weakiv, obs(100) gamma(0) b(1)
su
simulate b=r(b) se=r(se), reps(100): weakiv, obs(100) gamma(0.1) b(1)
su
simulate b=r(b) se=r(se), reps(100): weakiv, obs(100) gamma(0.5) b(1)
su
simulate b=r(b) se=r(se), reps(100): weakiv, obs(100) gamma(1) b(1)
su
