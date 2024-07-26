Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884E368
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721957073; cv=none; b=oRT4Q4B+BPRa3Dkgs7MHhTXCG+gx6AMFc9qvaVIhrnJsbv8YBtSQLSwFJK2EqzUv7+2he/+eqogyJDSYVJ+b6Y+MEurCpGJeeGRHYLOvjUaGzwFDI+hkq3Bv852BbnIdq7Zca69r/R0oIQzkp27/9mOWGk1+eXZqR0BCjxo+4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721957073; c=relaxed/simple;
	bh=l9z5J/UGftNJ2CKDNI/AaTc7QFIgm0YANy0AuhdVYww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idiDB3/Mc8l81MON2WiiayEsVGzvT/ZlkQ93NMxOrtSuNIhCsVGAv/1J5sVMGLfy/aQGLrsTV7t8PnzOcDnKbaE5ZOYKwQ04rtBpLxkvyrHP6tifulKg7ypbZyyULWfsI3fWfsVYzS3Thcly7g46guyAhjA7Fb5kjByvYMKylM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlUJ0UwQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlUJ0UwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E29CC32782;
	Fri, 26 Jul 2024 01:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721957073;
	bh=l9z5J/UGftNJ2CKDNI/AaTc7QFIgm0YANy0AuhdVYww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlUJ0UwQn4gwsZy6DIew4Zb5Bh+OBcsYWz2OCrNe7cJCOzpKQGifEK1sUSNGlZduT
	 UoC6J8Nwsnkx1P6EQ6HzwrhyLhKEjNdVvORhXU5Mxbkj9TWxrYpioYBBa44uEctGA/
	 KRJENcqqQegkp7bIvFuKr0kMfaq6cLpcPZq4Bsq02ZpbmjUp6SqEWNd6uhp0X/pjqZ
	 aX6mobyHNakjt+63ixiXiFlHSP08uaQoh5HR9GG/gChEh5faZh7yzguxHhYNTh6hiZ
	 Nxbk/fbYGrYZjvIjIUjifDT2Duz1iOTnhJLMlP8aa01m4IWegu7bmrR+pgPuinMwqh
	 o93yQkKH0GFbw==
Date: Thu, 25 Jul 2024 18:24:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: bbhtt.zn0i8@slmail.me
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Perf is crashing inside Flatpak runtime
Message-ID: <ZqL6z5WwJKeFf9FW@google.com>
References: <a69b8aca-9b37-4a72-a657-f708696c192b@slmail.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a69b8aca-9b37-4a72-a657-f708696c192b@slmail.me>

Hello,

On Thu, Jul 25, 2024 at 07:07:09PM +0530, bbhtt wrote:
> Hello,
> 
> We were reported by a user that perf is crashing inside the
> `org.freedesktop.Sdk` Flatpak runtime.
> 
> To reproduce, please install Flatpak for your distribution [1] and
> then install the `org.freedesktop.Sdk` runtime using the command
> `flatpak install org.freedesktop.Sdk//23.08`. Then get a working shell
> inside the sandbox using
> `flatpak run --command=sh --devel org.freedesktop.Sdk//23.08`.
> 
> Once inside the sandbox, run `perf record -v -- ls` and see that it
> crashes.
> 
> The output and a backtrace is below. Any help is appreciated. The
> downstream issue can be found at [2].

Thanks for the report.  I tried to reproduce it with v6.9.9 but my
system worked fine.  Is there anything special on your system?
I guess you're running on x86..

Btw I'm not familiar with Flatpak, does it run on the host kernel?

> 
> ```
> perf --version
> perf version 6.9.9
> 
> perf record -v -- ls
> DEBUGINFOD_URLS=
> No PMU found for 'cycles:Pu'
> Failed to read max cpus, using default of 4096

Maybe this is the problem.

> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> Problems creating module maps, continuing anyway...
> No PMU found for 'cycles:u'
> No PMU found for 'instructions:u'
> No PMU found for 'cpu-clock:u'

Hmm.. no PMUs?  Is it running a guest kernel or is sysfs mounted
correctly?

Thanks,
Namhyung


> mmap size 528384B
> libperf: Miscounted nr_mmaps 0 vs 1
> Control descriptor is not initialized
> WARNING: No sample_id_all support, falling back to unordered processing
> Couldn't start the BPF side band thread:
> BPF programs starting from now on won't be annotatable
> perf: Segmentation fault
> Obtained 13 stack frames.
> perf(sighandler_dump_stack+0x48) [0x55fab63072a8]
> /usr/lib/x86_64-linux-gnu/libc.so.6(+0x3ee80) [0x7f2f4ac51e80]
> perf(perf_cpu_map__max+0x4) [0x55fab63f3104]
> perf(+0x1de854) [0x55fab635d854]
> perf(perf_event__synthesize_cpu_map+0x56) [0x55fab6360c76]
> perf(+0x854cf) [0x55fab62044cf]
> perf(+0x88e2c) [0x55fab6207e2c]
> perf(cmd_record+0xf95) [0x55fab620b155]
> perf(+0x12e8b1) [0x55fab62ad8b1]
> perf(main+0x687) [0x55fab61f30e7]
> /usr/lib/x86_64-linux-gnu/libc.so.6(+0x2808a) [0x7f2f4ac3b08a]
> /usr/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x8b) [0x7f2f4ac3b14b]
> perf(_start+0x25) [0x55fab61f3425]
> Segmentation fault (core dumped)
> ```
> 
> ```
> perf_cpu_map__max (map=0x0) at cpumap.c:382
> 382		return __perf_cpu_map__nr(map) > 0
> (gdb) bt
> #0  perf_cpu_map__max (map=0x0) at cpumap.c:382
> #1  0x0000555555732854 in cpu_map_data__alloc (syn_data=syn_data@entry=0x7fffffff7c80, header_size=header_size@entry=8) at util/synthetic-events.c:1289
> #2  0x0000555555735c76 in cpu_map_event__new (map=<optimized out>) at util/synthetic-events.c:1337
> #3  perf_event__synthesize_cpu_map (tool=tool@entry=0x555555eb4b80 <record>, map=<optimized out>, 
>     process=process@entry=0x5555555db480 <process_synthesized_event>, machine=machine@entry=0x0) at util/synthetic-events.c:1357
> #4  0x00005555555d94cf in record__synthesize (tail=tail@entry=false, rec=0x555555eb4b80 <record>) at builtin-record.c:2103
> #5  0x00005555555dce2c in __cmd_record (argc=argc@entry=1, argv=argv@entry=0x7fffffffd880, rec=0x555555eb4b80 <record>) at builtin-record.c:2536
> #6  0x00005555555e0155 in cmd_record (argc=<optimized out>, argv=<optimized out>) at builtin-record.c:4257
> #7  0x00005555556828b1 in run_builtin (p=p@entry=0x555555eb7728 <commands+264>, argc=argc@entry=4, argv=argv@entry=0x7fffffffd880) at perf.c:349
> #8  0x00005555555c80e7 in handle_internal_command (argv=<optimized out>, argc=4) at perf.c:402
> #9  run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at perf.c:446
> #10 main (argc=<optimized out>, argv=0x7fffffffd880) at perf.c:562
> ```
> 
> [1]: https://flatpak.org/setup/
> [2]: https://gitlab.com/freedesktop-sdk/freedesktop-sdk/-/issues/1739
> 
> - bbhtt
> 
> https://bbhtt.github.io/
> 
