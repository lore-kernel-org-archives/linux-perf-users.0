Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3512E632
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Y7O9an"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F301C433C8;
	Mon, 16 Oct 2023 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697471736;
	bh=sHaRlwbWssWeJYQh6HQwKzauVvxDIFF0zkURvlGW/8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/Y7O9anXNZ6iq65xrYIz16QXcmlXdrngD+JzDIXRVvPvUcU4SmZel5cdMQRyR3iL
	 Ww7JDzUhDXDYhRvYGHDFgPvMtqRpC/MOT1K84EBL7rYYQFAntWCDwtUxvoZTDNCe5B
	 mXNPtPtqLpNG6rzM3rBryJphtWEAYoL4aiCGJ1YubMdfo7Ug1rvqguypj8E2c6ymIJ
	 dsKKtcWMiurayU/XHKIdvHnJkCpXLQWk+CiDsCJhhldvPLb9zlOi3QcnJ/FEJvaI5P
	 26WagFY0jgfUx177BzRQG9lojiAbILaHoTpL1f0Dw0x0snB+dKW8opuix1ucWKU7CD
	 L32sE1hmVhRaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id EB66040016; Mon, 16 Oct 2023 12:55:33 -0300 (-03)
Date: Mon, 16 Oct 2023 12:55:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS1c9RCh9MkzPbFG@kernel.org>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org>
 <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS1cGMgyEDJQbwq9@kernel.org>
X-Url: http://acmel.wordpress.com

Em Mon, Oct 16, 2023 at 12:51:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> Now back at testing with with cgroups.


Humm, even without the -G I get:

[root@five ~]# perf stat -e context-switches,cgroup-switches perf bench sched pipe  -l 10000
# Running 'sched/pipe' benchmark:
# Executed 10000 pipe operations between two processes

     Total time: 0.082 [sec]

       8.246400 usecs/op
         121265 ops/sec

 Performance counter stats for 'perf bench sched pipe -l 10000':

            20,002      context-switches
            20,002      cgroup-switches

       0.091228041 seconds time elapsed

       0.007122000 seconds user
       0.087700000 seconds sys


[root@five ~]#

- Arnaldo
