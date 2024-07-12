Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC8514EC5E;
	Fri, 12 Jul 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803091; cv=none; b=jqwqlnrXYp+T7EY10/JcFNS+wHLsuyGmJCak5YpqP0aqHGbiVWv4YOyj07b5CEfn5onpoOs4gJTTY9drrEmobf+SpC1oSBV54F2RYiGUM4lIqOIp6ZMlEZ4ozqNaP0rwjfEIW3+ObBPfU1GT/6TyoY8RJXPCg/EgUyjBJI9Vf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803091; c=relaxed/simple;
	bh=eQWK6P1hraC6/oPrunxa3xr40XitJClxMI1FywNk7I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZxaoeusiedy2d08Ge2qV/oFb7HHCEb9l2wqg3fMFvS5Xk+G2TI974R1cOptNhgvUTGfW5MY0a0UfvvOCLVw1k5I447fdbMGBnUYhLz5dUEBkuyMNB5AJPlrhIULjI4NASZ5DYe0ECYt17DJSdmLRag35+FpJA45OXO8co2uYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBdzwffL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBdzwffL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C31C32782;
	Fri, 12 Jul 2024 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720803091;
	bh=eQWK6P1hraC6/oPrunxa3xr40XitJClxMI1FywNk7I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBdzwffLK/H8HNZbLk5wAookmOqCoUp86tjH3/iu1pXq0QU6ntQbmD5j8OtIpYGDK
	 zVyXzNUZc1vwNAVKQNB17llVc2n/jj2YEZaoD8pE0Yzxx/GVmeqlevQrG4dKXgMPl0
	 Ai8g9i8x+hGccBYLRpGLhwaXZ7JAGJWLSzqhvKmdhUzHEeVqMHry8BHiJmD57UaYyZ
	 mncq9ZriJun9T/B8SPON26uH0XKhbFrAaBotqMTBukvjzc/n4iELNUF8li/Uzzyaa6
	 Hy1BGtBPA3PWJOojwkfL7ZVBd62Awp7mIFrzSNKB7UX+pHxypv+r/vCn4mYS8iCt9t
	 WWcB9XL6LY/Bw==
Date: Fri, 12 Jul 2024 09:51:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, irogers@google.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 1/8] perf trace: Fix iteration of syscall ids in
 syscalltbl->entries
Message-ID: <ZpFfDi6aNGzDjE8O@google.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705132059.853205-2-howardchu95@gmail.com>

Hello Howard,

On Fri, Jul 05, 2024 at 09:20:51PM +0800, Howard Chu wrote:
> This is a bug found when implementing pretty-printing for the
> landlock_add_rule system call, I decided to send this patch separately
> because this is a serious bug that should be fixed fast.

I'll pick up this from the series separately for v6.11.

Thanks,
Namhyung

> 
> I wrote a test program to do landlock_add_rule syscall in a loop,
> yet perf trace -e landlock_add_rule freezes, giving no output.
> 
> This bug is introduced by the false understanding of the variable "key"
> below:
> ```
> for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
> 	struct syscall *sc = trace__syscall_info(trace, NULL, key);
> 	...
> }
> ```
> The code above seems right at the beginning, but when looking at
> syscalltbl.c, I found these lines:
> 
> ```
> for (i = 0; i <= syscalltbl_native_max_id; ++i)
> 	if (syscalltbl_native[i])
> 		++nr_entries;
> 
> entries = tbl->syscalls.entries = malloc(sizeof(struct syscall) * nr_entries);
> ...
> 
> for (i = 0, j = 0; i <= syscalltbl_native_max_id; ++i) {
> 	if (syscalltbl_native[i]) {
> 		entries[j].name = syscalltbl_native[i];
> 		entries[j].id = i;
> 		++j;
> 	}
> }
> ```
> 
> meaning the key is merely an index to traverse the syscall table,
> instead of the actual syscall id for this particular syscall.
> 
> So if one uses key to do trace__syscall_info(trace, NULL, key), because
> key only goes up to trace->sctbl->syscalls.nr_entries, for example, on
> my X86_64 machine, this number is 373, it will end up neglecting all
> the rest of the syscall, in my case, everything after `rseq`, because
> the traversal will stop at 373, and `rseq` is the last syscall whose id
> is lower than 373
> 
> in tools/perf/arch/x86/include/generated/asm/syscalls_64.c:
> ```
> 	...
> 	[334] = "rseq",
> 	[424] = "pidfd_send_signal",
> 	...
> ```
> 
> The reason why the key is scrambled but perf trace works well is that
> key is used in trace__syscall_info(trace, NULL, key) to do
> trace->syscalls.table[id], this makes sure that the struct syscall returned
> actually has an id the same value as key, making the later bpf_prog
> matching all correct.
> 
> After fixing this bug, I can do perf trace on 38 more syscalls, and
> because more syscalls are visible, we get 8 more syscalls that can be
> augmented.
> 
> before:
> 
> perf $ perf trace -vv --max-events=1 |& grep Reusing
> Reusing "open" BPF sys_enter augmenter for "stat"
> Reusing "open" BPF sys_enter augmenter for "lstat"
> Reusing "open" BPF sys_enter augmenter for "access"
> Reusing "connect" BPF sys_enter augmenter for "accept"
> Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
> Reusing "connect" BPF sys_enter augmenter for "bind"
> Reusing "connect" BPF sys_enter augmenter for "getsockname"
> Reusing "connect" BPF sys_enter augmenter for "getpeername"
> Reusing "open" BPF sys_enter augmenter for "execve"
> Reusing "open" BPF sys_enter augmenter for "truncate"
> Reusing "open" BPF sys_enter augmenter for "chdir"
> Reusing "open" BPF sys_enter augmenter for "mkdir"
> Reusing "open" BPF sys_enter augmenter for "rmdir"
> Reusing "open" BPF sys_enter augmenter for "creat"
> Reusing "open" BPF sys_enter augmenter for "link"
> Reusing "open" BPF sys_enter augmenter for "unlink"
> Reusing "open" BPF sys_enter augmenter for "symlink"
> Reusing "open" BPF sys_enter augmenter for "readlink"
> Reusing "open" BPF sys_enter augmenter for "chmod"
> Reusing "open" BPF sys_enter augmenter for "chown"
> Reusing "open" BPF sys_enter augmenter for "lchown"
> Reusing "open" BPF sys_enter augmenter for "mknod"
> Reusing "open" BPF sys_enter augmenter for "statfs"
> Reusing "open" BPF sys_enter augmenter for "pivot_root"
> Reusing "open" BPF sys_enter augmenter for "chroot"
> Reusing "open" BPF sys_enter augmenter for "acct"
> Reusing "open" BPF sys_enter augmenter for "swapon"
> Reusing "open" BPF sys_enter augmenter for "swapoff"
> Reusing "open" BPF sys_enter augmenter for "delete_module"
> Reusing "open" BPF sys_enter augmenter for "setxattr"
> Reusing "open" BPF sys_enter augmenter for "lsetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
> Reusing "open" BPF sys_enter augmenter for "getxattr"
> Reusing "open" BPF sys_enter augmenter for "lgetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
> Reusing "open" BPF sys_enter augmenter for "listxattr"
> Reusing "open" BPF sys_enter augmenter for "llistxattr"
> Reusing "open" BPF sys_enter augmenter for "removexattr"
> Reusing "open" BPF sys_enter augmenter for "lremovexattr"
> Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
> Reusing "open" BPF sys_enter augmenter for "mq_open"
> Reusing "open" BPF sys_enter augmenter for "mq_unlink"
> Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
> Reusing "open" BPF sys_enter augmenter for "symlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
> Reusing "connect" BPF sys_enter augmenter for "accept4"
> Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
> Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
> Reusing "open" BPF sys_enter augmenter for "memfd_create"
> Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
> 
> after
> 
> perf $ perf trace -vv --max-events=1 |& grep Reusing
> Reusing "open" BPF sys_enter augmenter for "stat"
> Reusing "open" BPF sys_enter augmenter for "lstat"
> Reusing "open" BPF sys_enter augmenter for "access"
> Reusing "connect" BPF sys_enter augmenter for "accept"
> Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
> Reusing "connect" BPF sys_enter augmenter for "bind"
> Reusing "connect" BPF sys_enter augmenter for "getsockname"
> Reusing "connect" BPF sys_enter augmenter for "getpeername"
> Reusing "open" BPF sys_enter augmenter for "execve"
> Reusing "open" BPF sys_enter augmenter for "truncate"
> Reusing "open" BPF sys_enter augmenter for "chdir"
> Reusing "open" BPF sys_enter augmenter for "mkdir"
> Reusing "open" BPF sys_enter augmenter for "rmdir"
> Reusing "open" BPF sys_enter augmenter for "creat"
> Reusing "open" BPF sys_enter augmenter for "link"
> Reusing "open" BPF sys_enter augmenter for "unlink"
> Reusing "open" BPF sys_enter augmenter for "symlink"
> Reusing "open" BPF sys_enter augmenter for "readlink"
> Reusing "open" BPF sys_enter augmenter for "chmod"
> Reusing "open" BPF sys_enter augmenter for "chown"
> Reusing "open" BPF sys_enter augmenter for "lchown"
> Reusing "open" BPF sys_enter augmenter for "mknod"
> Reusing "open" BPF sys_enter augmenter for "statfs"
> Reusing "open" BPF sys_enter augmenter for "pivot_root"
> Reusing "open" BPF sys_enter augmenter for "chroot"
> Reusing "open" BPF sys_enter augmenter for "acct"
> Reusing "open" BPF sys_enter augmenter for "swapon"
> Reusing "open" BPF sys_enter augmenter for "swapoff"
> Reusing "open" BPF sys_enter augmenter for "delete_module"
> Reusing "open" BPF sys_enter augmenter for "setxattr"
> Reusing "open" BPF sys_enter augmenter for "lsetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
> Reusing "open" BPF sys_enter augmenter for "getxattr"
> Reusing "open" BPF sys_enter augmenter for "lgetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
> Reusing "open" BPF sys_enter augmenter for "listxattr"
> Reusing "open" BPF sys_enter augmenter for "llistxattr"
> Reusing "open" BPF sys_enter augmenter for "removexattr"
> Reusing "open" BPF sys_enter augmenter for "lremovexattr"
> Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
> Reusing "open" BPF sys_enter augmenter for "mq_open"
> Reusing "open" BPF sys_enter augmenter for "mq_unlink"
> Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
> Reusing "open" BPF sys_enter augmenter for "symlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
> Reusing "connect" BPF sys_enter augmenter for "accept4"
> Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
> Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
> Reusing "open" BPF sys_enter augmenter for "memfd_create"
> Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
> 
> TL;DR:
> 
> These are the new syscalls that can be augmented
> Reusing "openat" BPF sys_enter augmenter for "open_tree"
> Reusing "openat" BPF sys_enter augmenter for "openat2"
> Reusing "openat" BPF sys_enter augmenter for "mount_setattr"
> Reusing "openat" BPF sys_enter augmenter for "move_mount"
> Reusing "open" BPF sys_enter augmenter for "fsopen"
> Reusing "openat" BPF sys_enter augmenter for "fspick"
> Reusing "openat" BPF sys_enter augmenter for "faccessat2"
> Reusing "openat" BPF sys_enter augmenter for "fchmodat2"
> 
> as for the perf trace output:
> 
> before
> 
> perf $ perf trace -e faccessat2 --max-events=1
> [no output]
> 
> after
> 
> perf $ ./perf trace -e faccessat2 --max-events=1
>      0.000 ( 0.037 ms): waybar/958 faccessat2(dfd: 40, filename: "uevent")                               = 0
> 
> P.S. The reason why this bug was not found in the past five years is
> probably because it only happens to the newer syscalls whose id is
> greater, for instance, faccessat2 of id 439, which not a lot of people
> care about when using perf trace.
> 
> Commiter notes:
> 
> That and the fact that the BPF code was hidden before having to use -e,
> that got changed kinda recently when we switched to using BPF skels for
> augmenting syscalls in 'perf trace':
> 
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> a9f4c6c999008c92 perf trace: Collect sys_nanosleep first argument
> 29d16de26df17e94 perf augmented_raw_syscalls.bpf: Move 'struct timespec64' to vmlinux.h
> 5069211e2f0b47e7 perf trace: Use the right bpf_probe_read(_str) variant for reading user data
> 33b725ce7b988756 perf trace: Avoid compile error wrt redefining bool
> 7d9642311b6d9d31 perf bpf augmented_raw_syscalls: Add an assert to make sure sizeof(augmented_arg->value) is a power of two.
> 262b54b6c9396823 perf bpf augmented_raw_syscalls: Add an assert to make sure sizeof(saddr) is a power of two.
> 1836480429d173c0 perf bpf_skel augmented_raw_syscalls: Cap the socklen parameter using &= sizeof(saddr)
> cd2cece61ac5f900 perf trace: Tidy comments related to BPF + syscall augmentation
> 5e6da6be3082f77b perf trace: Migrate BPF augmentation to use a skeleton
> ⬢[acme@toolbox perf-tools-next]$
> 
> ⬢[acme@toolbox perf-tools-next]$ git show --oneline --pretty=reference 5e6da6be3082f77b | head -1
> 5e6da6be3082f77b (perf trace: Migrate BPF augmentation to use a skeleton, 2023-08-10)
> ⬢[acme@toolbox perf-tools-next]$
> 
> I.e. from August, 2023.
> 
> One had as well to ask for BUILD_BPF_SKEL=1, which now is default if all
> it needs is available on the system.
> 
> I simplified the code to not expose the 'struct syscall' outside of
> tools/perf/util/syscalltbl.c, instead providing a function to go from
> the index to the syscall id:
> 
>   int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx);
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/ZmhlAxbVcAKoPTg8@x1
> Link: https://lore.kernel.org/r/20240624181345.124764-2-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-trace.c   | 14 +++++++-------
>  tools/perf/util/syscalltbl.c |  7 +++++++
>  tools/perf/util/syscalltbl.h |  1 +
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index a547ccfa92c9..8449f2beb54d 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3354,8 +3354,6 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
>  static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
>  {
>  	struct tep_format_field *field, *candidate_field;
> -	int id;
> -
>  	/*
>  	 * We're only interested in syscalls that have a pointer:
>  	 */
> @@ -3367,7 +3365,8 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  	return NULL;
>  
>  try_to_find_pair:
> -	for (id = 0; id < trace->sctbl->syscalls.nr_entries; ++id) {
> +	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> +		int id = syscalltbl__id_at_idx(trace->sctbl, i);
>  		struct syscall *pair = trace__syscall_info(trace, NULL, id);
>  		struct bpf_program *pair_prog;
>  		bool is_candidate = false;
> @@ -3456,10 +3455,10 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
>  {
>  	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
>  	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
> -	int err = 0, key;
> +	int err = 0;
>  
> -	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
> -		int prog_fd;
> +	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> +		int prog_fd, key = syscalltbl__id_at_idx(trace->sctbl, i);
>  
>  		if (!trace__syscall_enabled(trace, key))
>  			continue;
> @@ -3505,7 +3504,8 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
>  	 * first and second arg (this one on the raw_syscalls:sys_exit prog
>  	 * array tail call, then that one will be used.
>  	 */
> -	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
> +	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> +		int key = syscalltbl__id_at_idx(trace->sctbl, i);
>  		struct syscall *sc = trace__syscall_info(trace, NULL, key);
>  		struct bpf_program *pair_prog;
>  		int prog_fd;
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 63be7b58761d..0dd26b991b3f 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -123,6 +123,13 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
>  	return sc ? sc->id : -1;
>  }
>  
> +int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx)
> +{
> +	struct syscall *syscalls = tbl->syscalls.entries;
> +
> +	return idx < tbl->syscalls.nr_entries ? syscalls[idx].id : -1;
> +}
> +
>  int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
>  {
>  	int i;
> diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
> index a41d2ca9e4ae..2b53b7ed25a6 100644
> --- a/tools/perf/util/syscalltbl.h
> +++ b/tools/perf/util/syscalltbl.h
> @@ -16,6 +16,7 @@ void syscalltbl__delete(struct syscalltbl *tbl);
>  
>  const char *syscalltbl__name(const struct syscalltbl *tbl, int id);
>  int syscalltbl__id(struct syscalltbl *tbl, const char *name);
> +int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx);
>  
>  int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
>  int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
> -- 
> 2.45.2
> 
