Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7B1E47A8;
	Tue, 11 Feb 2025 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299755; cv=none; b=Av3dHznBouS1HbBeR9ZKIULR1JfWLgVSVFIBEKY+F3P2VKUtoXtK26S1CK4r7s5L6aoQMBmN57TH3+pCjLsqS3qTKOxyWMHx8oz/luW0x+VwnTULDnkdD4qmLY57EWK/o4uEwtZPxVAAhpYb8tlbOd97XHMM5IIJ4FhgVHlqfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299755; c=relaxed/simple;
	bh=1fSp9O78MatFqFQr2w/MPuTzexQ8JPLX3xFindEdAr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv9SUmmCXdlN6kgnB9Q0W9+ql9YmsB304UHzl0FdbdBVR6lVZsqadW59BaUNNnayGWxSl1rc3EL5y9O+ZBdxONI95dy0eBB7l7rUm2MKsV4N55vZj/5EgZqc5LcnA5a++92qQK5QDGEYZRi6HHZhOT2LTrKeXnn6n462z4ui2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdGNcXXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdGNcXXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CB1C4CEDD;
	Tue, 11 Feb 2025 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739299754;
	bh=1fSp9O78MatFqFQr2w/MPuTzexQ8JPLX3xFindEdAr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdGNcXXua31qk+70FnANdqYehm2pnj6Dwig7yxiUTed03KSjuNvMdYkm22LgCDEKL
	 D8O0Y5bMZVwn8XFqwW1hMLNnI7yIbViHUghDwl0WhP8awyY481B/CyWuP3ERFElbVA
	 Mnt1k3/ShwfTEl2NhyfuGxCMZXcQFtQygf1VjGXTwbSyl0XwF8GBQkHfOQie2xk1iC
	 a7+pMZmW0ssAA0HeK0p0VlRmy8pkucwtVP5aEzsxB9OprFP1DZXEhYl3RxNUhjrhW7
	 LJVEowE1frBEHRsMEC9TypdKVjJU1ddoEZgcn+j+lEKZzGGqmC2f5vPHcw7VBeb9A6
	 aTae2la6Av90Q==
Date: Tue, 11 Feb 2025 19:49:11 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <Z6ubp1k2_bm2pKf1@x1>
References: <20241215181220.754822-1-howardchu95@gmail.com>
 <Z2CJW0vFT005gmIe@google.com>
 <Z6uQmcLllm1wR3-h@x1>
 <CAH0uvog9x1eD4P=hyU5eO+c9z5dNDfffMiZOBwTgdwLhfPi06w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvog9x1eD4P=hyU5eO+c9z5dNDfffMiZOBwTgdwLhfPi06w@mail.gmail.com>

On Tue, Feb 11, 2025 at 10:30:16AM -0800, Howard Chu wrote:
> On Tue, Feb 11, 2025 at 10:02 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > When running just one workload:

> > root@number:~# for a in `seq 10` ; do perf record --off-cpu sleep 1s ; perf script | grep offcpu-time ; done
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (13 samples) ]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (16 samples) ]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (14 samples) ]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (12 samples) ]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
> > root@number:~#

> > Have you tested it like that? Is this a known issue/current limitation?

> With your command:
> Tuel $ for a in `seq 10` ; do sudo perf record --off-cpu sleep 1s ;
> sudo perf script | grep offcpu-time ; done
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (8 samples) ]
> :56645   56645 18446744069.414584: 1000127411 offcpu-time:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (8 samples) ]
> :56723   56723 18446744069.414584: 1000058038 offcpu-time:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (8 samples) ]
> :56778   56778 18446744069.414584: 1000230651 offcpu-time:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (9 samples) ]
> :56810   56810 18446744069.414584: 1000140263 offcpu-time:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (17 samples) ]
> :56877   56877 18446744069.414584: 1001209864 offcpu-time:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (9 samples) ]
> :56919   56919 18446744069.414584: 1000230734 offcpu-time:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (9 samples) ]
> :56975   56975 18446744069.414584: 1000080484 offcpu-time:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (9 samples) ]
> :57008   57008 18446744069.414584: 1000057996 offcpu-time:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (9 samples) ]
> :57040   57040 18446744069.414584: 1000084270 offcpu-time:
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.017 MB perf.data (8 samples) ]
> :57072   57072 18446744069.414584: 1000081663 offcpu-time:
> 
> It works for me... I'm trying to think of a reason. I have no perf config btw.

root@number:~# uname -a
Linux number 6.12.11-100.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Jan 23 22:07:15 UTC 2025 x86_64 GNU/Linux
root@number:~# cat ~/.perfconfig 
# this file is auto-generated.
[report]
	children = no
root@number:~# rm -f ~/.perfconfig 
root@number:~# for a in `seq 10` ; do perf record --off-cpu sleep 1s ; perf script | grep offcpu-time ; done
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (14 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (13 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
root@number:~#

Some more data:

root@number:~# perf record --off-cpu sleep 1s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.037 MB perf.data (7 samples) ]
root@number:~# perf evlist
cpu_atom/cycles/P
cpu_core/cycles/P
offcpu-time
dummy:u
root@number:~# perf evlist -v
cpu_atom/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0xa00000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
cpu_core/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, inherit: 1, freq: 1, enable_on_exec: 1, precise_ip: 3, sample_id_all: 1
offcpu-time: type: 1 (software), size: 136, config: 0xa (PERF_COUNT_SW_BPF_OUTPUT), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|PERIOD|RAW|IDENTIFIER, read_format: ID|LOST, disabled: 1, enable_on_exec: 1, sample_id_all: 1
dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|IDENTIFIER, read_format: ID|LOST, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
root@number:~# perf report -D | grep PERF_RECORD_SAMPLE
4294967295 20129389592917 0x9240 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a376ff1 period: 1 addr: 0
4294967295 20129389596787 0x9270 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a01e8b6 period: 1 addr: 0
4294967295 20129389598447 0x92a0 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a053e64 period: 13 addr: 0
4294967295 20129389599368 0x92d0 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a00f052 period: 398 addr: 0
4294967295 20129389600270 0x9300 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8b401fad period: 15226 addr: 0
4294967295 20129389604095 0x9360 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a405930 period: 607346 addr: 0
4294967295 20129389739536 0x94e8 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4002): 474261/474261: 0x7f9bf499fe7c period: 5436975 addr: 0
root@number:~#

root@number:~# perf report -D | grep PERF_RECORD_SAMPLE -A2
4294967295 20129389592917 0x9240 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a376ff1 period: 1 addr: 0
 ... thread: perf-exec:474261
 ...... dso: /proc/kcore
--
4294967295 20129389596787 0x9270 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a01e8b6 period: 1 addr: 0
 ... thread: perf-exec:474261
 ...... dso: /proc/kcore
--
4294967295 20129389598447 0x92a0 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a053e64 period: 13 addr: 0
 ... thread: perf-exec:474261
 ...... dso: /proc/kcore
--
4294967295 20129389599368 0x92d0 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a00f052 period: 398 addr: 0
 ... thread: perf-exec:474261
 ...... dso: /proc/kcore
--
4294967295 20129389600270 0x9300 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8b401fad period: 15226 addr: 0
 ... thread: perf-exec:474261
 ...... dso: /proc/kcore
--
4294967295 20129389604095 0x9360 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 474261/474261: 0xffffffff8a405930 period: 607346 addr: 0
 ... thread: sleep:474261
 ...... dso: /proc/kcore
--
4294967295 20129389739536 0x94e8 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4002): 474261/474261: 0x7f9bf499fe7c period: 5436975 addr: 0
 ... thread: sleep:474261
 ...... dso: /usr/lib64/ld-linux-x86-64.so.2
root@number:~# 

- Arnaldo
