Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB81B960
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jul 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720051346; cv=none; b=ZU8HCsHEnp1yEfOgdujneEIp3IHA3qZOh3l5mgzV0MJDKlxj7qv9kTOo1zAgKjAyuvR2IOdPxLhKe9+6bRcFU7A7CLcft4GwmAB1cl7KnNAh6z/ZmkXGt7SsC9ofSF9HLHuiPNfCoNLeH2gD+TpHUnZLVdQHWEadL+SfTNSUu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720051346; c=relaxed/simple;
	bh=RrqnEqaSZ3p3P1VnTG5ptb59EJoCUzlM2Os8y1xyzfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwqltaghyi+8VoYDWAEHaxg0dLmFkjbiPuULwZsOCaKPgJkCTFVSkoPlI0yk36cCJm6PHYoULPQ8S4rDTEf/eG34gyWOCQhUUVV6q0zT2doAu5GjRLJ9N5Z3/JD1+/sLikYnMx+LuJj033nFVlVAL9+x/iNjMP22miiJqUxMrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D696Ivn7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D696Ivn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849C5C2BD10;
	Thu,  4 Jul 2024 00:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720051345;
	bh=RrqnEqaSZ3p3P1VnTG5ptb59EJoCUzlM2Os8y1xyzfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D696Ivn7xVDLIlmKEj3iFtkB1A5gfPZnyfHgwwheePcS7SIPxrZkuOtp3xrEG3YfZ
	 MOiBIIxm3V1K4zr4Pva/NvbcEvAsEOKlg6WG93En4nzjj+7PIZIEDOJ4O7CdXTbigg
	 4A0EnMXiT7l0z4xaTGmfU6xvUbas+YLLz9c6CCfC34Fyr6xpkAt3LHeh31SXuCFTmV
	 LzGMB74J8NjuV9cGBwv3/K+39m3yBnV06kB8yKL31i9mim/zqPXMpyhMs7qtWbyOyM
	 loDVju5GBlTGZ0c4IAIRW2BhQOczO0Cl4YJc2AXOAvGoXtHOIZmfNFdLg+sNIUCNDu
	 r5BYxUgPqsfrQ==
Date: Wed, 3 Jul 2024 17:02:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jakob Jarmar <jakob@jarm.ar>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Bug with --buildid-mmap?
Message-ID: <ZoXmkKDe4rAovosW@google.com>
References: <c98ac733-0610-4305-8efb-046fe398131a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c98ac733-0610-4305-8efb-046fe398131a@app.fastmail.com>

Hello,

On Wed, Jul 03, 2024 at 05:03:27PM +0200, Jakob Jarmar wrote:
> Hi,
> 
> I believe I may have found a bug in the --buildid-mmap flag for perf record,
> where it hangs trying to read from /dev/dri/renderD128 trying to look up a
> build ID. I can reliably reproduce it with:
> 
> perf record -p 12345 -g --call-graph=dwarf --buildid-mmap
> 
> (where 12345 is some process such that /proc/12345/maps contains
> /dev/dri/renderD218)

Thanks for the report!  For some reason, it seems to have an executable
mapping on the /dev/dri/renderD218.

> 
> See example backtrace (produced with GDB on the hung perf process) below.
> This backtrace is from a slightly old version of perf, but the issue is present
> in master on torvalds/linux (I got some compiler errors from perf-tools-next).

Ok, glad to tested it on the latest version.

Can you please share the compiler error you saw from perf-tools-next?


> Apologies in advance if Fastmail lied to me and sent this as HTML.

It seems ok. :)
 
> 
> #0  0x00007f91dc500d95 in __libc_pread64 (fd=43, buf=0x7ffda9164310, count=0, offset=<optimized out>)
>     at ../sysdeps/unix/sysv/linux/pread64.c:25
> #1  __libc_pread64 (fd=fd@entry=43, buf=buf@entry=0x7ffda9164310, count=count@entry=0, 
>     offset=offset@entry=0) at ../sysdeps/unix/sysv/linux/pread64.c:23
> #2  0x00007f91dc53824e in __pread_chk (fd=fd@entry=43, buf=buf@entry=0x7ffda9164310, 
>     nbytes=nbytes@entry=0, offset=offset@entry=0, buflen=buflen@entry=64) at pread_chk.c:28
> #3  0x00007f91dd40ac7c in pread (__fd=43, __buf=0x7ffda9164310, __nbytes=0, __offset=<optimized out>)
>     at /usr/include/bits/unistd.h:38
> #4  pread_retry (fd=43, buf=0x7ffda9164310, len=0, off=0) at ../lib/system.h:192

I don't know what happened in the libelf but it seems to try to read 0
bytes (maybe repeatedly?).  Looks like a bug in the libelf when it reads
special files but I think we can detect the ELF header in the file and
bail out early.

Thanks,
Namhyung


> #5  read_unmmaped_file (fildes=43, offset=0, maxsize=0, cmd=ELF_C_READ, parent=0x0)
>     at /usr/src/debug/elfutils-0.191-4.fc40.x86_64/libelf/elf_begin.c:601
> #6  read_file (fildes=fildes@entry=43, offset=offset@entry=0, maxsize=<optimized out>, 
>     maxsize@entry=18446744073709551615, cmd=cmd@entry=ELF_C_READ, parent=parent@entry=0x0)
>     at /usr/src/debug/elfutils-0.191-4.fc40.x86_64/libelf/elf_begin.c:716
> #7  0x00007f91dd40fd6f in elf_begin (fildes=fildes@entry=43, cmd=cmd@entry=ELF_C_READ, ref=ref@entry=0x0)
>     at /usr/src/debug/elfutils-0.191-4.fc40.x86_64/libelf/elf_begin.c:1212
> #8  0x0000560146879b86 in read_build_id (filename=0x560159d97b48 "/dev/dri/renderD128", 
>     bid=0x7ffda9165490) at util/symbol-elf.c:980
> #9  filename__read_build_id (filename=filename@entry=0x560159d97b48 "/dev/dri/renderD128", 
>     bid=bid@entry=0x7ffda9165490) at util/symbol-elf.c:1025
> #10 0x000056014682f40f in perf_record_mmap2__read_build_id (event=event@entry=0x560159d97b00, 
>     machine=<optimized out>, is_kernel=is_kernel@entry=false) at util/synthetic-events.c:397
> #11 0x0000560146830e2b in perf_event__synthesize_mmap_events (tool=tool@entry=0x560146fbf420 <record>, 
>     event=event@entry=0x560159d97b00, pid=pid@entry=1066149, tgid=tgid@entry=1066149, 
>     process=process@entry=0x5601466d07c0 <process_synthesized_event>, 
>     machine=machine@entry=0x560159d72a58, mmap_data=true) at util/synthetic-events.c:529
> #12 0x000056014683141c in __event__synthesize_thread (comm_event=comm_event@entry=0x560159d97ab0, 
>     mmap_event=mmap_event@entry=0x560159d97b00, fork_event=fork_event@entry=0x560159d98b70, 
>     namespaces_event=namespaces_event@entry=0x560159dc5bb0, pid=1066149, full=full@entry=1, 
>     process=0x5601466d07c0 <process_synthesized_event>, tool=0x560146fbf420 <record>, 
>     machine=0x560159d72a58, needs_mmap=true, mmap_data=true) at util/synthetic-events.c:841
> #13 0x000056014683167e in __perf_event__synthesize_threads (tool=tool@entry=0x560146fbf420 <record>, 
>     process=process@entry=0x5601466d07c0 <process_synthesized_event>, 
>     machine=machine@entry=0x560159d72a58, needs_mmap=needs_mmap@entry=true, 
>     mmap_data=mmap_data@entry=true, dirent=0x560159da0210, start=0, num=510)
>     at util/synthetic-events.c:978
> #14 0x0000560146831ef9 in perf_event__synthesize_threads (tool=tool@entry=0x560146fbf420 <record>, 
>     process=process@entry=0x5601466d07c0 <process_synthesized_event>, 
>     machine=machine@entry=0x560159d72a58, needs_mmap=true, mmap_data=<optimized out>, 
>     nr_threads_synthesize=nr_threads_synthesize@entry=1) at util/synthetic-events.c:1049
> #15 0x0000560146833864 in perf_event__synthesize_threads (tool=0x560146fbf420 <record>, 
>     process=0x5601466d07c0 <process_synthesized_event>, machine=0x560159d72a58, 
>     needs_mmap=<optimized out>, mmap_data=<optimized out>, nr_threads_synthesize=1)
>     at util/synthetic-events.c:1960
> #16 0x00005601466cea47 in record__synthesize (tail=tail@entry=false, rec=0x560146fbf420 <record>)
>     at builtin-record.c:2135
> #17 0x00005601466d21f5 in __cmd_record (argc=argc@entry=0, argv=argv@entry=0x7ffda916fe70, 
>     rec=0x560146fbf420 <record>) at builtin-record.c:2536
> #18 0x00005601466d567e in cmd_record (argc=<optimized out>, argv=<optimized out>)
>     at builtin-record.c:4257
> #19 0x000056014677edcf in run_builtin (p=p@entry=0x560146fc20e8 <commands+264>, argc=argc@entry=8, 
>     argv=argv@entry=0x7ffda916fe70) at perf.c:349
> #20 0x00005601466bd717 in handle_internal_command (argc=8, argv=<optimized out>) at perf.c:402
> #21 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:446
> #22 main (argc=<optimized out>, argv=0x7ffda916fe70) at perf.c:562
