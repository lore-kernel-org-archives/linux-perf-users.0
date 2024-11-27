Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871A11713;
	Wed, 27 Nov 2024 03:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732677911; cv=none; b=iIphFed1ZMNwC+N3xOwfu/NbEbvv9Tacqkn+dFWawljwixGWdldML4QBj6fBYceTg+7KBO7xhgoG0ZKroqsJ0boC5yXeULKRwIYPlgr4rXQ8rVogZvbS3CRKvzafrvfSz6Kp9if5QM0r4IixwvSWyzuN1bw+haykH4ZfvkIPqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732677911; c=relaxed/simple;
	bh=Nt+qRwBre/tMaFXQVXIA1hP+U+Vo7L3Jk/R7KRL6iII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmwmx2dC99rRy2oDptk2SsiZxBBJdhpj/J8r7xT/W+YOsvFeA1xJrXmo8RfzcHddao2+woR9jw7TH/GR7uUETOTd3fNqXJhCiFf9oXjHKxmDoP2ujQ7seiEuQG5lcEzmShUPSQi7s0zlS1mRXtmU0P2UxQiACsbNE2+n4FyFL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWrmdKks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWrmdKks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C7C4CECF;
	Wed, 27 Nov 2024 03:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732677910;
	bh=Nt+qRwBre/tMaFXQVXIA1hP+U+Vo7L3Jk/R7KRL6iII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWrmdKksgGgUszP44bpY5I2DLDfmJYSeFtDdEddnq+SEUBOBzrU9y6PZcYGRHbni3
	 U5W4EIM8H7le/ynWyo9HRBgYOgeXpu3YtVINuujPMclR21fKZBIG/GjVSeBCvRwyKZ
	 PUr16qXqbODtBStv1zPHgzaygjhQAeE0mgN3mvLo7kOJxmfAgZQ0gBsHZmuxsUQDZw
	 yAcSDyIHyudbCQYDMiEErwP0pjSBnuP7tSJJcAdsHcpW16Y72F0G1dTGNbwFyAhTYc
	 NezsSbGRnj/6WoRbcTY7KNGhrVd5IfCfDRreyHHAyVCyXfUgSQ8pmzGxPqU9cvXitT
	 +pnSAwTD9OqPA==
Date: Tue, 26 Nov 2024 19:25:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] perf-tools changes for v6.13
Message-ID: <Z0aRFFW9xMh3mqKB@google.com>
References: <20241125071653.1350621-1-namhyung@kernel.org>
 <CAHk-=whQ_yeRDh_zZjhz-4q8G=vu5Ypb-Y3f=efHQSwd5Kas3w@mail.gmail.com>
 <Z0ZhDHXxHKoE2Nrl@google.com>
 <Z0ZvAB0vcL-D-a6f@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0ZvAB0vcL-D-a6f@x1>

On Tue, Nov 26, 2024 at 09:59:44PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 26, 2024 at 04:00:12PM -0800, Namhyung Kim wrote:
> > Hello,
> > 
> > On Tue, Nov 26, 2024 at 03:33:10PM -0800, Linus Torvalds wrote:
> > > On Sun, 24 Nov 2024 at 23:17, Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Please consider pulling the following changes in perf tools for v6.13.
> > > 
> > > Hmm. Has the default search path for the vmlinux image changed?
> > 
> > I don't think so.
>  
> > > Doing profiling with this, I get
> > > 
> > >     openat(AT_FDCWD, "vmlinux", O_RDONLY)   = 5
> > > 
> > > which is very very wrong for my kernel build - it basically picks up
> > > the vmlinux image from the build directory, which has absolutely
> > > *nothign* to do with the image that is being run at the moment.
> > 
> > Sure, at least it should match the build-id before use.
> 
> I tried it here and at first I reproduced Linus results, which I found
> very strange, then I tried to bisect it, and all the previous versions
> were producing this:
> 
> root@number:/home/acme/git/perf-tools# perf -v ; perf report -vv |& grep -A5 "^Looking at the vmlinux_path"
> perf version 6.12.gb50ecc5aca4d
> Looking at the vmlinux_path (8 entries long)
> symsrc__init: build id mismatch for vmlinux.
> symsrc__init: cannot get elf header.
> overlapping maps:
>  ffffffffc034b75c-ffffffffc034b89b 0 bpf_prog_40ddf486530245f5_sd_devices
>  ffffffffc0000000-ffffffffff000000 7fffc0004000 vmlinux
> root@number:/home/acme/git/perf-tools#
> 
> Which is what I got from the perf-tools branch you asked him to pull.
> 
> The algorithm in perf is similar to the one in pahole (that stole it
> from perf):
> 
> root@number:/home/acme/git/perf-tools# strace -e openat pahole --running_kernel_vmlinux |& tail -12
> openat(AT_FDCWD, "/sys/kernel/notes", O_RDONLY) = 3
> openat(AT_FDCWD, "vmlinux", O_RDONLY)   = 3
> openat(AT_FDCWD, "/boot/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/boot/vmlinux-6.11.8-200.fc40.x86_64", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.11.8-200.fc40.x86_64", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/lib/modules/6.11.8-200.fc40.x86_64/build/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/debug/lib/modules/6.11.8-200.fc40.x86_64/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.11.8-200.fc40.x86_64.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/root/.cache/debuginfod_client/55152ddca5da77ca62deb3dd0db105e82b3711e0/debuginfo", O_RDONLY) = -1 ENOENT (No such file or directory)
> pahole: couldn't find a vmlinux that matches the running kernel
> HINT: Maybe you're inside a container or missing a debuginfo package?
> +++ exited with 1 +++
> root@number:/home/acme/git/perf-tools#
> 
> The one in perf does very much the same:
> 
> root@number:/home/acme/git/perf-tools# perf -v ; strace -e openat -o /tmp/strace.output perf report -vv |& grep -A5 "^Looking at the vmlinux_path" ; grep '"vmlinux"' -B1 -A10 /tmp/strace.output 
> perf version 6.12.gb50ecc5aca4d
> Looking at the vmlinux_path (8 entries long)
> symsrc__init: build id mismatch for vmlinux.
> symsrc__init: cannot get elf header.
> overlapping maps:
>  ffffffffc034b75c-ffffffffc034b89b 0 bpf_prog_40ddf486530245f5_sd_devices
>  ffffffffc0000000-ffffffffff000000 7fffc0004000 vmlinux
> openat(AT_FDCWD, "/root/.debug/.build-id/55/152ddca5da77ca62deb3dd0db105e82b3711e0/elf", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "vmlinux", O_RDONLY)   = 142
> openat(AT_FDCWD, "/boot/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/boot/vmlinux-6.11.8-200.fc40.x86_64", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.11.8-200.fc40.x86_64", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/lib/modules/6.11.8-200.fc40.x86_64/build/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/debug/lib/modules/6.11.8-200.fc40.x86_64/vmlinux", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.11.8-200.fc40.x86_64.debug", O_RDONLY) = -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "/root/.debug/.build-id/55/152ddca5da77ca62deb3dd0db105e82b3711e0/kallsyms", O_RDONLY) = 142
> openat(AT_FDCWD, "/sys/kernel/notes", O_RDONLY) = 142
> openat(AT_FDCWD, "/proc/kcore", O_RDONLY) = 142
> openat(AT_FDCWD, "/proc/kallsyms", O_RDONLY) = 142
> root@number:/home/acme/git/perf-tools# 
> root@number:/home/acme/git/perf-tools# perf buildid-list -h -k
> 
>  Usage: perf buildid-list [<options>]
> 
>     -k, --kernel          Show current kernel build id
> 
> root@number:/home/acme/git/perf-tools# perf buildid-list -k
> 55152ddca5da77ca62deb3dd0db105e82b3711e0
> root@number:/home/acme/git/perf-tools# file vmlinux 
> vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=e86cad482822bd4b4caabb01e7cd00161fd51a38, with debug_info, not stripped
> root@number:/home/acme/git/perf-tools#
> 
> And it ends up using /proc/kallsyms
> 
> Today I did some bisects, etc, but even with at first reproducing what
> Linus described, i.e. it used the non-matching vmlinux in the current
> directory to resolve symbols, I couldn't reproduce it after trying to
> bisect it :-\
>  
> > > So now I need to point "perf report" at the actual image, which I
> > > didn't need to do before.
> > 
> > Ok, I'll try to reproduce it and take a look.
> 
> Hope you root cause this, late in this part of the world, going AFK now.

I think it's a bug in perf record since v6.12.  I found the build-id
event in the header area is broken.  Can you verify if this works?

Thanks,
Namhyung

---8<---
From 62ebc7de4c306d99f39af847bee4a2aab05b0f93 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Nov 2024 19:13:31 -0800
Subject: [PATCH] perf tools: Fix build-id event recording

The build-id events written at the end of the record session are broken
due to unexpected data.  The write_buildid() writes the fixed length
event first and then variable length filename.

But a recent change made it write more data in the padding area
accidentally.  So readers of the event see zero-filled data for the
next entry and treat it incorrectly.   This resulted in wrong kernel
symbols because the kernel DSO loaded a random vmlinux image in the
path as it didn't have a valid build-id.

Fixes: ae39ba16554e ("perf inject: Fix build ID injection")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/build-id.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 8982f68e7230cd64..e763e8d99a4367d7 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -277,7 +277,7 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	struct perf_record_header_build_id b;
 	size_t len;
 
-	len = sizeof(b) + name_len + 1;
+	len = name_len + 1;
 	len = PERF_ALIGN(len, sizeof(u64));
 
 	memset(&b, 0, sizeof(b));
@@ -286,7 +286,7 @@ static int write_buildid(const char *name, size_t name_len, struct build_id *bid
 	misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
 	b.pid = pid;
 	b.header.misc = misc;
-	b.header.size = len;
+	b.header.size = sizeof(b) + len;
 
 	err = do_write(fd, &b, sizeof(b));
 	if (err < 0)
-- 
2.47.0.338.g60cca15819-goog

