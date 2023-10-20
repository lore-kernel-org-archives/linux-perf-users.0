Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2E249FF
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5N/3Vsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66C0C433C7;
	Fri, 20 Oct 2023 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697833930;
	bh=4gcbCVldBqv13HwyWncnUbVgIxvEAM6vWbNe5FdwbzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5N/3VspUfptQF2Q8sSj4M06jjU6kst2InC8Rood0yAjrYZat/BhK/c5Ot51N41nf
	 ebalsmLk2sWmra8/NhmLZj1c4s+r6ZjI5K5gjAfLQBlEQjo9ATehL7BRE8e4rQrTuZ
	 weKSzJ2LX7eKaNIzx0hFc9IZfEUxBiurCtnHUQxQPveck/Vvy6xZzYYvzaM+tGQWtC
	 4BcZqz+jHQ0QBzNYRTHEB0/P2IOIt3+h+VpvkikbNgbA17yiYwFpmND+Up3BpsSas5
	 L4hsIttQCmrAiPIElnHoeNsmpUqvxT1pVdjeACh0ehouw4I/xZi4dmG3SDU3tT00qG
	 t1PIRcgKr4P6A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 493954035D; Fri, 20 Oct 2023 17:32:07 -0300 (-03)
Date: Fri, 20 Oct 2023 17:32:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZTLjx3A8LBQMYWHJ@kernel.org>
References: <20231017202342.1353124-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017202342.1353124-1-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Tue, Oct 17, 2023 at 01:23:42PM -0700, Namhyung Kim escreveu:
> The -G/--cgroups option is to put sender and receiver in different
> cgroups in order to measure cgroup context switch overheads.
<SNIP>
>   > taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB > /dev/null
 
>    Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':
> 
>               20,001      context-switches
>               20,001      cgroup-switches

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

[root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000
# Running 'sched/pipe' benchmark:
# Executed 10000 pipe operations between two processes

     Total time: 0.063 [sec]

       6.367500 usecs/op
         157047 ops/sec

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000':

            20,004      context-switches
                 4      cgroup-switches

       0.084191842 seconds time elapsed

       0.008332000 seconds user
       0.067193000 seconds sys


[root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB
# Running 'sched/pipe' benchmark:
no access to cgroup /sys/fs/cgroup/BBB
Failed to open cgroup file in BBB
 Hint: create the cgroup first, like 'mkdir /sys/fs/cgroup/BBB'
no access to cgroup /sys/fs/cgroup/AAA
Failed to open cgroup file in AAA
 Hint: create the cgroup first, like 'mkdir /sys/fs/cgroup/AAA'

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':

                 2      context-switches
                 1      cgroup-switches

       0.010356533 seconds time elapsed

       0.003209000 seconds user
       0.007122000 seconds sys


[root@five ~]# vim /tmp/bla
[root@five ~]#
[root@five ~]# mkdir /sys/fs/cgroup/BBB /sys/fs/cgroup/AAA
[root@five ~]# perf stat -e context-switches,cgroup-switches taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB
# Running 'sched/pipe' benchmark:
# Executed 10000 pipe operations between two processes

     Total time: 0.079 [sec]

       7.987800 usecs/op
         125190 ops/sec

 Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 10000 -G AAA,BBB':

            20,008      context-switches
            20,007      cgroup-switches

       0.089361029 seconds time elapsed

       0.009004000 seconds user
       0.065376000 seconds sys


[root@five ~]#
