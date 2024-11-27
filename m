Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764541F9EDA;
	Wed, 27 Nov 2024 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713133; cv=none; b=m3Qsy87TlqusBJ/aWD0iFYKKcKbfVCxVb89ExSR+l80OBqWiVKTmwx9duYPFlvSkoaBxJAWzHdBys2z6W5ER+sSmmbvbIwU5R2ZK52yUeuogxBhDRGvJizZ9GLIRYxwCfpQmcQiesHM1oEF6P3MzEkSLPm5fqbFeHnEuYnohgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713133; c=relaxed/simple;
	bh=dYrm+k6RGObVK84t+jbDB2M2YlrWnTGkz9T+js20HG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZfq68u4l0pIlvbh7TX8DfQPjErG2/7WOkcRagm087KXuLORAJHKo2rGT8IgrxTjYPlVQJ6WwI9OFQtbqPOH4OhoQxcnnMYc43ww+fzLkw7pWiWPBLJ7q5kvqRYBgqxPwdFj9YkY5KYXBesoHOxY5oBEk6jEGj7pQ5/ahT2vk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6oSX/RG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6oSX/RG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D03AC4CECC;
	Wed, 27 Nov 2024 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732713133;
	bh=dYrm+k6RGObVK84t+jbDB2M2YlrWnTGkz9T+js20HG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6oSX/RGEFU+12UfwH+viEY0izVbsqPN5u1xG45EDY0Z/jjnjxKijaBCnSdibOrrz
	 8pf9ZTWzNdMIYvwCJ/0yEEhQY1AIJ0izCGP9ix81GjGPEkKC8Ow5lKPX9DeCI7L6py
	 ABTDlKxIBA14a8+hqPV2eHCs9jpAePDk4DKU/zVw7x5KX3kizD4CSS23jNk6ho7AUd
	 g0PrOoGkWWhXOXGA8lYMuZ7F8TUgwJcvlAWK3t9KF48tMG8SmN7gVE3o0W0GSIQqd+
	 OvqmjsxEhO43O9u32QrrHduIZbxRGZJKL2jp8ueJ+B2dYfM8R6DUWtv3/RZFkiCyHP
	 6KiVwbZeZlYUw==
Date: Wed, 27 Nov 2024 10:12:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] perf-tools changes for v6.13
Message-ID: <Z0caqvFFmkL9I6lk@x1>
References: <20241125071653.1350621-1-namhyung@kernel.org>
 <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
 <Z0ZhDHXxHKoE2Nrl@google.com>
 <Z0ZvAB0vcL-D-a6f@x1>
 <Z0aRFFW9xMh3mqKB@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0aRFFW9xMh3mqKB@google.com>

On Tue, Nov 26, 2024 at 07:25:08PM -0800, Namhyung Kim wrote:
> On Tue, Nov 26, 2024 at 09:59:44PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Nov 26, 2024 at 04:00:12PM -0800, Namhyung Kim wrote:
> > > On Tue, Nov 26, 2024 at 03:33:10PM -0800, Linus Torvalds wrote:
> > > > Hmm. Has the default search path for the vmlinux image changed?

> > > I don't think so.

> > > > Doing profiling with this, I get

> > > >     openat(AT_FDCWD, "vmlinux", O_RDONLY)   = 5

> > > > which is very very wrong for my kernel build - it basically picks up
> > > > the vmlinux image from the build directory, which has absolutely
> > > > *nothign* to do with the image that is being run at the moment.

> > > Sure, at least it should match the build-id before use.

> > I tried it here and at first I reproduced Linus results, which I found

I understand it now, first, when I tried to reproduce Linus case I did a
'perf record' with the most recent code, the one failing for Linus, but
then when I tried to test it with v6.1, trying to bisect it, perf v6.1
couldn't process the perf.data file generated "in the future", by
v6.12-rc6 + perf-tools:

# perf report -v
file uses a more recent and unsupported ABI (8 bytes extra)
incompatible file format (rerun with -v to learn more)
#

So I did another 'perf record' and used that perf.data, that had no
problems all the way to v6.12-rc6, it works, the bug was introduced
recently making it not able to checking the build-id in the vmlinux
file, as there is nothing to compare it with, no build-id in the
perf.data file.

root@number:/home/acme/git/perf-tools# perf -v
perf version 6.12.gb50ecc5aca4d
root@number:/home/acme/git/perf-tools# perf record -a sleep 2s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.442 MB perf.data (8953 samples) ]
root@number:/home/acme/git/perf-tools# perf -v ; strace -e openat -o /tmp/strace.output perf report -vv |& grep -A5 "^Looking at the vmlinux_path" ; grep '"vmlinux"' -B1 -A10 /tmp/strace.output 
perf version 6.12.gb50ecc5aca4d
Looking at the vmlinux_path (8 entries long)
Using vmlinux for symbols
<SNIP>
root@number:/home/acme/git/perf-tools#

So I redid the bisection, this time doing a fresh perf record at each
step and got to:

⬢ [acme@toolbox linux]$ git bisect bad
ae39ba16554eb4a2d97f752847e93aa428438912 is the first bad commit
commit ae39ba16554eb4a2d97f752847e93aa428438912 (HEAD)
Author: Ian Rogers <irogers@google.com>
Date:   Mon Sep 9 13:37:37 2024 -0700

    perf inject: Fix build ID injection
    
    Build ID injection wasn't inserting a sample ID and aligning events to
    64 bytes rather than 8. No sample ID means events are unordered and two
    different build_id events for the same path, as happens when a file is
    replaced, can't be differentiated.
    
    Add in sample ID insertion for the build_id events alongside some
    refactoring. The refactoring better aligns the function arguments for
    different use cases, such as synthesizing build_id events without
    needing to have a dso. The misc bits are explicitly passed as with
    callchains the maps/dsos may span user and kernel land, so using
    sample->cpumode isn't good enough.
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Acked-by: Namhyung Kim <namhyung@kernel.org>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Anne Macedo <retpolanne@posteo.net>
    Cc: Casey Chen <cachen@purestorage.com>
    Cc: Colin Ian King <colin.i.king@gmail.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Sun Haiyong <sunhaiyong@loongson.cn>
    Link: https://lore.kernel.org/r/20240909203740.143492-2-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

⬢ [acme@toolbox linux]$ git tag --contains ae39ba16554eb4a2d97f752847e93aa428438912 | grep ^v6.
v6.12
v6.12-rc1
v6.12-rc2
v6.12-rc3
v6.12-rc4
v6.12-rc5
v6.12-rc6
v6.12-rc7
⬢ [acme@toolbox linux]$

Which matches what Namhyung found. A plain revert doesn't work,
Namhyung's patch below fixes it for me, with it:

# perf -v ; perf record -a sleep 2s ; perf buildid-list | grep 'vmlinux\|kallsyms' ; perf report -vv |& grep -A2 "^Looking at the vmlinux_path"
perf version 6.12.g25425b03a8d7
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.095 MB perf.data (3738 samples) ]
55152ddca5da77ca62deb3dd0db105e82b3711e0 [kernel.kallsyms]
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for vmlinux.
symsrc__init: cannot get elf header.
#

It refuses that bogus "vmlinux" in the current directory, and since my
machine has no matching vmlinux, it fallbacks to recording the running
kernel build id as "[kernel.kallsyms]" and will use it for resolving
symbols.

If I install the matching vmlinux using 'dnf debuginfo-install kernel':

# perf -v ; perf record -a sleep 2s ; perf report -vv |& grep -A2 "^Looking at the vmlinux_path"
perf version 6.12.g25425b03a8d7
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.116 MB perf.data (4278 samples) ]
Looking at the vmlinux_path (8 entries long)
symsrc__init: build id mismatch for vmlinux.
Using /usr/lib/debug/lib/modules/6.11.8-200.fc40.x86_64/vmlinux for symbols
# file /usr/lib/debug/lib/modules/6.11.8-200.fc40.x86_64/vmlinux
/usr/lib/debug/lib/modules/6.11.8-200.fc40.x86_64/vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=55152ddca5da77ca62deb3dd0db105e82b3711e0, with debug_info, not stripped
# perf buildid-list -h -k

 Usage: perf buildid-list [<options>]

    -k, --kernel          Show current kernel build id

root@number:/home/acme/git/perf-tools# perf buildid-list -k
55152ddca5da77ca62deb3dd0db105e82b3711e0
root@number:/home/acme/git/perf-tools#

It will find the right file and use it.

So, for Namhyung's patch below:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Now to write another 'perf test' to cover this...

- Arnaldo

> > very strange, then I tried to bisect it, and all the previous versions
> > were producing this:
> > 
> > root@number:/home/acme/git/perf-tools# perf -v ; perf report -vv |& grep -A5 "^Looking at the vmlinux_path"
> > perf version 6.12.gb50ecc5aca4d
> > Looking at the vmlinux_path (8 entries long)
> > symsrc__init: build id mismatch for vmlinux.
> > symsrc__init: cannot get elf header.
> > overlapping maps:
> >  ffffffffc034b75c-ffffffffc034b89b 0 bpf_prog_40ddf486530245f5_sd_devices
> >  ffffffffc0000000-ffffffffff000000 7fffc0004000 vmlinux
> > root@number:/home/acme/git/perf-tools#
> > 
> > Which is what I got from the perf-tools branch you asked him to pull.
> > 
> > The algorithm in perf is similar to the one in pahole (that stole it
> > from perf):
> > 
> > root@number:/home/acme/git/perf-tools# strace -e openat pahole --running_kernel_vmlinux |& tail -12
> > openat(AT_FDCWD, "/sys/kernel/notes", O_RDONLY) = 3
> > openat(AT_FDCWD, "vmlinux", O_RDONLY)   = 3
> > openat(AT_FDCWD, "/boot/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/boot/vmlinux-6.11.8-200.fc40.x86_64", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.11.8-200.fc40.x86_64", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/lib/modules/6.11.8-200.fc40.x86_64/build/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/lib/debug/lib/modules/6.11.8-200.fc40.x86_64/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.11.8-200.fc40.x86_64.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/root/.cache/debuginfod_client/55152ddca5da77ca62deb3dd0db105e82b3711e0/debuginfo", O_RDONLY) = -1 ENOENT (No such file or directory)
> > pahole: couldn't find a vmlinux that matches the running kernel
> > HINT: Maybe you're inside a container or missing a debuginfo package?
> > +++ exited with 1 +++
> > root@number:/home/acme/git/perf-tools#
> > 
> > The one in perf does very much the same:
> > 
> > root@number:/home/acme/git/perf-tools# perf -v ; strace -e openat -o /tmp/strace.output perf report -vv |& grep -A5 "^Looking at the vmlinux_path" ; grep '"vmlinux"' -B1 -A10 /tmp/strace.output 
> > perf version 6.12.gb50ecc5aca4d
> > Looking at the vmlinux_path (8 entries long)
> > symsrc__init: build id mismatch for vmlinux.
> > symsrc__init: cannot get elf header.
> > overlapping maps:
> >  ffffffffc034b75c-ffffffffc034b89b 0 bpf_prog_40ddf486530245f5_sd_devices
> >  ffffffffc0000000-ffffffffff000000 7fffc0004000 vmlinux
> > openat(AT_FDCWD, "/root/.debug/.build-id/55/152ddca5da77ca62deb3dd0db105e82b3711e0/elf", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "vmlinux", O_RDONLY)   = 142
> > openat(AT_FDCWD, "/boot/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/boot/vmlinux-6.11.8-200.fc40.x86_64", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.11.8-200.fc40.x86_64", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/lib/modules/6.11.8-200.fc40.x86_64/build/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/lib/debug/lib/modules/6.11.8-200.fc40.x86_64/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.11.8-200.fc40.x86_64.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
> > openat(AT_FDCWD, "/root/.debug/.build-id/55/152ddca5da77ca62deb3dd0db105e82b3711e0/kallsyms", O_RDONLY) = 142
> > openat(AT_FDCWD, "/sys/kernel/notes", O_RDONLY) = 142
> > openat(AT_FDCWD, "/proc/kcore", O_RDONLY) = 142
> > openat(AT_FDCWD, "/proc/kallsyms", O_RDONLY) = 142
> > root@number:/home/acme/git/perf-tools# 
> > root@number:/home/acme/git/perf-tools# perf buildid-list -h -k
> > 
> >  Usage: perf buildid-list [<options>]
> > 
> >     -k, --kernel          Show current kernel build id
> > 
> > root@number:/home/acme/git/perf-tools# perf buildid-list -k
> > 55152ddca5da77ca62deb3dd0db105e82b3711e0
> > root@number:/home/acme/git/perf-tools# file vmlinux 
> > vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=e86cad482822bd4b4caabb01e7cd00161fd51a38, with debug_info, not stripped
> > root@number:/home/acme/git/perf-tools#
> > 
> > And it ends up using /proc/kallsyms
> > 
> > Today I did some bisects, etc, but even with at first reproducing what
> > Linus described, i.e. it used the non-matching vmlinux in the current
> > directory to resolve symbols, I couldn't reproduce it after trying to
> > bisect it :-\
> >  
> > > > So now I need to point "perf report" at the actual image, which I
> > > > didn't need to do before.
> > > 
> > > Ok, I'll try to reproduce it and take a look.
> > 
> > Hope you root cause this, late in this part of the world, going AFK now.
> 
> I think it's a bug in perf record since v6.12.  I found the build-id
> event in the header area is broken.  Can you verify if this works?
> 
> Thanks,
> Namhyung
> 
> ---8<---
> >From 62ebc7de4c306d99f39af847bee4a2aab05b0f93 Mon Sep 17 00:00:00 2001
> From: Namhyung Kim <namhyung@kernel.org>
> Date: Tue, 26 Nov 2024 19:13:31 -0800
> Subject: [PATCH] perf tools: Fix build-id event recording
> 
> The build-id events written at the end of the record session are broken
> due to unexpected data.  The write_buildid() writes the fixed length
> event first and then variable length filename.
> 
> But a recent change made it write more data in the padding area
> accidentally.  So readers of the event see zero-filled data for the
> next entry and treat it incorrectly.   This resulted in wrong kernel
> symbols because the kernel DSO loaded a random vmlinux image in the
> path as it didn't have a valid build-id.
> 
> Fixes: ae39ba16554e ("perf inject: Fix build ID injection")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/build-id.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 8982f68e7230cd64..e763e8d99a4367d7 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -277,7 +277,7 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
>  	struct perf_record_header_build_id b;
>  	size_t len;
>  
> -	len = sizeof(b) + name_len + 1;
> +	len = name_len + 1;
>  	len = PERF_ALIGN(len, sizeof(u64));
>  
>  	memset(&b, 0, sizeof(b));
> @@ -286,7 +286,7 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
>  	misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
>  	b.pid = pid;
>  	b.header.misc = misc;
> -	b.header.size = len;
> +	b.header.size = sizeof(b) + len;
>  
>  	err = do_write(fd, &b, sizeof(b));
>  	if (err < 0)
> -- 
> 2.47.0.338.g60cca15819-goog
> 
