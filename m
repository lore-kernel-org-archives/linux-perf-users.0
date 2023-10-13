Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F4107AD
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2023 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG4W2RMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DC1C433C7;
	Fri, 13 Oct 2023 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697236862;
	bh=w5/NPLmu7MtZsZVVLte85Zwy4WqEOc54OWUu9qmyrvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hG4W2RMUHsaEqwOCNz9stfK3ICMpL0xfiA9ZCgXuk8FIXM3kbo5nGojmEyK9sl0Ve
	 TnUhs/Zc+bCg+zc7bDqgcRs5td6gA73tzZ1yK3AadQFKGiP/uA3Xk7gp01CDs9bKwM
	 6oHEF/nSrFGVz62YyXvkJCLGVpUr2nBcpGFvw5x2mRnSkwsGy2W9R9a27LHau64i7m
	 6qQ8INPJ4lRW/o3NljNqUV735NSWWnuVj0rDHyjMsONa0Y0QOcDCFLa5zHuLS/8XZN
	 fjLbN9+pIftaXA0nFJXkELV7wfRw4l+TBJn1qQ8EMoWY4LCl5ypmYRfSQ5aUVF2sko
	 hbkgbJUskQRKw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 7A01A40016; Fri, 13 Oct 2023 19:40:58 -0300 (-03)
Date: Fri, 13 Oct 2023 19:40:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZSnHek1HlQTkfjhG@kernel.org>
References: <20231004204741.985422-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004204741.985422-1-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Oct 04, 2023 at 01:47:41PM -0700, Namhyung Kim escreveu:
> The -G/--cgroups option is to put sender and receiver in different
> cgroups in order to measure cgroup context switch overheads.
> 
> Users need to make sure the cgroups exist and accessible.
> 
>   # perf stat -e context-switches,cgroup-switches \
>   > taskset -c 0 perf bench sched pipe -l 10000 > /dev/null
> 
>    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':
> 
>               20,001      context-switches
>                    2      cgroup-switches
> 
>          0.053449651 seconds time elapsed
> 
>          0.011286000 seconds user
>          0.041869000 seconds sys
> 
>   # perf stat -e context-switches,cgroup-switches \
>   > taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB > /dev/null
> 
>    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
> 
>               20,001      context-switches
>               20,001      cgroup-switches
> 
>          0.052768627 seconds time elapsed

So I tried with:

[root@quaco ~]# perf bench sched pipe -G system.slice,user.slice
# Running 'sched/pipe' benchmark:
cannot enter to cgroup: system.slice
cannot enter to cgroup: user.slice
# Executed 1000000 pipe operations between two processes

     Total time: 6.301 [sec]

       6.301478 usecs/op
         158692 ops/sec
[root@quaco ~]#

Should't it bail out when not managing to enter the cgroups?

Also:

[root@quaco ~]# mkdir /sys/fs/cgroup/AAA
[root@quaco ~]# mkdir /sys/fs/cgroup/BBB
[root@quaco ~]#
[root@quaco ~]# perf bench sched pipe -G AAA,BBB
# Running 'sched/pipe' benchmark:
cannot enter to cgroup: AAA
cannot enter to cgroup: BBB
# Executed 1000000 pipe operations between two processes

     Total time: 6.397 [sec]

       6.397830 usecs/op
         156302 ops/sec
[root@quaco ~]#

-rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.procs
[root@quaco ~]# ls -la /sys/fs/cgroup/AAA/cgroup.threads
-rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/AAA/cgroup.threads
[root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.threads
-rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.threads
[root@quaco ~]# ls -la /sys/fs/cgroup/BBB/cgroup.procs
-rw-r--r--. 1 root root 0 Oct 13 19:22 /sys/fs/cgroup/BBB/cgroup.procs
[root@quaco ~]#

[root@quaco ~]# perf bench sched pipe -G AAA,BBB
# Running 'sched/pipe' benchmark:
cannot enter to cgroup: AAA (written=-1, len=6, errno=Operation not supported)
cannot enter to cgroup: BBB (written=-1, len=6, errno=Operation not supported)
# Executed 1000000 pipe operations between two processes

     Total time: 6.303 [sec]

       6.303221 usecs/op
         158649 ops/sec
[root@quaco ~]#

I'm certainly missing something here :-\

- Arnaldo
