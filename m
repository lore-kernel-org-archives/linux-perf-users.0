Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244653B1A2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815241; cv=none; b=L8OCIHhZJgYdldzbKXs/uRPAnH0FT5msXWSKbGcRvHV6afRrL8VXwq5cV2ndAWyKubsPJiXwZyAPLe2mIroY09cli2O5UWZDA6dGALfOVfTztbWXxVCEKd05Gx/9Bf1eBXQf6Eciy+feordBvSiKgyOS8J81/OLFoGMlqro7rUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815241; c=relaxed/simple;
	bh=9BqfvShDKHo5r/LM0aj1AzgH/cXiklmGhCCJVllXrG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHRlM7cO5EW2eoDcl+2uMrzwbwm3vmJBrlGWfcpSR/I6hq7SOQIcsYcOhhEqcMsPd4Q+gocZ91QauD0kVd+2FVUBL4D47lp3GTGg3UBa80ejbf0Ff/tflxI4dEb1hmXscVaHsHXmyxRgio29YoeYUJl0Y2ELwGOh61KesbdQWK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT3vH+U0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT3vH+U0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F65C4AF07;
	Fri, 12 Jul 2024 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720815240;
	bh=9BqfvShDKHo5r/LM0aj1AzgH/cXiklmGhCCJVllXrG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fT3vH+U0sh7NaHPSaYPqeDK7rldxrCoKVOZ6JyRmkQOi6uE6yikpDHhYfwcA/c+P5
	 ZQSslA+tj/3VRjzCqmBBoVHUOs84607LKkere/x5BunncupJ3aCeHP75YtpnWBUcbu
	 bPMDDl5B3mQapBtEIlJEOIt6n3m/5QIT6SiSHkXsVuPsrlMeNiPVLcRiTDRmXNsYfu
	 pKRMScUJcfLj+iAyxFXUN/kfNWj7IGGRVv50diGnUZosntypQGQ9B0Xo2KmU8UFpp5
	 aJo4ktNVvLIeLwdhmsrYfjZJIifSUAWo8MMoWHKxlxh+SpeYdmTq23uO+aEIMKLeBs
	 CYCn8zti93mcA==
Date: Fri, 12 Jul 2024 15:13:57 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Ze Xia <xiaze2017@stu.xjtu.edu.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@red-hat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Bug with 'perf script --symfs'?
Message-ID: <ZpGOhXCAdz8ks6Y2@google.com>
References: <1a8b2c39.69b.1909152714b.Coremail.xiaze2017@stu.xjtu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a8b2c39.69b.1909152714b.Coremail.xiaze2017@stu.xjtu.edu.cn>

Hello,

On Mon, Jul 08, 2024 at 03:50:17PM +0800, Ze Xia wrote:
> Hi,
> 
> I think I found that `perf script --symfs` option and automatic namespace attaching seems to conflict.
> 
> Environment: kernel version `6.5.0-41-generic`, distribution `ubuntu22.04`, arch `x86_64`
> 
> Behavior: In `perf script`, if a process is inside another namespace than the default (e.g. inside a docker container), perf script will try to attach to that namespace to read debug info. However, if `--symfs` option is provided, then it will search for debug files with `symfs` prefix *inside the namespace*. Usually the symfs directory isn't present in the namespace, thus I see this behavior as inappropriate.
> 
> To reproduce: I run commands below on a ubuntu machine with docker installed. Any glibc based distro without musl installed should also reproduce the issue, as musl isn't present at host but present in the docker container.
> 
> In one terminal (create the process to be profiled):
> 
>     $ docker run -it --rm --name test-symfs --net=host alpine
>     # now we're inside the container
>     $ apk add musl-dbg
>     $ dd if=/dev/zero of=/dev/null
>     # it stucks here, don't kill it yet
> 
> In another terminal (profiling):
> 
>     $ perf record -a -g sleep 1
>     $ perf script > success.perf
>     $ grep musl success.perf | head -n 10
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
> 
> Thanks to automatic namespace attaching, this works. Problem comes with `--symfs` option:
> 
>     $ docker cp test-symfs:/ ./symfs
>     $ perf script --symfs ./symfs > fail.perf
>     $ grep musl fail.perf | head -n 10
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 [unknown] (/lib/ld-musl-x86_64.so.1)
> 
> We can't find the symbol any more.
> 
> Rerun the `perf script` with `strace`:
> 
>     $ strace -o fail.strace perf script --symfs ./symfs > fail.perf
>     $ grep musl fail.strace | grep stat
>     newfstatat(AT_FDCWD, "./symfs//lib/ld-musl-x86_64.so.1", 0x7ffce53b7030, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//lib/ld-musl-x86_64.so.1", 0x7ffce53b2140, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//usr/lib/debug/lib/ld-musl-x86_64.so.1.debug", 0x7ffce53b41a0, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//usr/lib/debug/lib/ld-musl-x86_64.so.1", 0x7ffce53b41a0, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//lib/ld-musl-x86_64.so.1", 0x7ffce53b41a0, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//lib/.debug/ld-musl-x86_64.so.1", 0x7ffce53b41a0, 0) = -1 ENOENT (No such file or directory)
> 
> Note how `./symfs/` is included in all those calls.
> 
> Rerun the success case with strace:
> 
>     $ strace -o success.strace perf script > success.perf
>     $ grep musl success.strace | grep stat
>     newfstatat(AT_FDCWD, "/lib/ld-musl-x86_64.so.1", {st_mode=S_IFREG|0755, st_size=649832, ...}, 0) = 0
>     newfstatat(AT_FDCWD, "ld-musl-x86_64.so.1.debug", 0x7ffe0949a350, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "/lib/ld-musl-x86_64.so.1.debug", 0x7ffe0949a350, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "/lib/.debug/ld-musl-x86_64.so.1.debug", 0x7ffe0949a350, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "/usr/lib/debug/lib/ld-musl-x86_64.so.1.debug", {st_mode=S_IFREG|0755, st_size=2892848, ...}, 0) = 0
>     newfstatat(AT_FDCWD, "/usr/lib/debug/lib/ld-musl-x86_64.so.1.debug", {st_mode=S_IFREG|0755, st_size=2892848, ...}, 0) = 0
> 
> Note that the calls without `./symfs/` worked, because perf is inside the container's namespace.
> 
> To prove that our symfs indeed contains the debug info, we can stop the `dd` command inside docker and rerun `perf script` without `--symfs` option, it also succeeds:
> 
>     $ strace -o success2.strace perf script --symfs ./symfs > success2.perf
>     $ grep musl success2.perf | head -n 10
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>             75fbf5143992 __cp_end+0x0 (/lib/ld-musl-x86_64.so.1)
>     $ grep musl success2.strace | grep stat
>     newfstatat(AT_FDCWD, "./symfs//lib/ld-musl-x86_64.so.1", 0x7ffe14d3d6a0, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//lib/ld-musl-x86_64.so.1", {st_mode=S_IFREG|0755, st_size=649832, ...}, 0) = 0
>     newfstatat(AT_FDCWD, "ld-musl-x86_64.so.1.debug", 0x7ffe14d387a0, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//lib/ld-musl-x86_64.so.1.debug", 0x7ffe14d387a0, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//lib/.debug/ld-musl-x86_64.so.1.debug", 0x7ffe14d387a0, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "/usr/lib/debug./symfs//lib/ld-musl-x86_64.so.1.debug", 0x7ffe14d387a0, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//usr/lib/debug/lib/ld-musl-x86_64.so.1.debug", {st_mode=S_IFREG|0755, st_size=2892848, ...}, 0) = 0
>     newfstatat(AT_FDCWD, "./symfs//usr/lib/debug/lib/ld-musl-x86_64.so.1", 0x7ffe14d3a810, 0) = -1 ENOENT (No such file or directory)
>     newfstatat(AT_FDCWD, "./symfs//lib/ld-musl-x86_64.so.1", {st_mode=S_IFREG|0755, st_size=649832, ...}, 0) = 0
> 
> As the `dd` process is dead now, `perf script` will not attach to its namespace. It reads debug info from our symfs, and it worked.
> 
> Expected Behavior: `symfs` is prefixed only if no namespace attaching happened. Or, to be conversative, try twice, with or without `--symfs`.

I'm not sure if it's the reasonable expectation.  With --symfs, you can
expect it will prefix the path to all DSO paths.  The namespace makes
things complicated but I think the symfs behaivor is simple.  There's no
guarantee if the symfs is always out of the namespace, right?

Thanks,
Namhyung

