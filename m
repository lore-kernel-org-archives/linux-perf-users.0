Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751F14BF9B;
	Fri,  5 Jul 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185651; cv=none; b=Hf8gYUzJFdqgL5bcdyPa0j87nxqntlIfAvvS1G+qhL7Cj+dzJba4m0Lkslf70BLGPV1LwK4Iau99lXygkI9i3yfuJGhv55EafChzsMnabutS7HW93MKEPbHI4JeSF7MZVWxwftRiXIMUS0vie1CBmNk7BHMdZwoh/UvxE7cu9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185651; c=relaxed/simple;
	bh=sHaxqYXHG2HLaIB+D8RhPhiyDt9yrXC/8xpBdkP4nLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjqXtmhtHz5mGTotAFpGQpBDUDwVVTJHncT4l0i+Dqlh9/fjYLDZ1O77noBt2/YyJHyYRZQ1O2++4zwM+Ua77M9QZrB1acdSuksyLOcEv8tkUoQ6n0EXbNX2crZYH5mLqNqLPJZnk1ipg62CDHzLS8gN+WQ8PgH8E8roNcv+0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFRFCh24; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFRFCh24"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso1109503a12.2;
        Fri, 05 Jul 2024 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720185649; x=1720790449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdV0v22yUm/xQxD/kVPFe9jly3facK8iEM4rioFXbJA=;
        b=YFRFCh2487e+BrAV3ecFbEF1H9Gr0oV8H2KZJZp+yXVBHTPuGpdCANCr9vTP9x+rZT
         /Z0/Ij9C7C3km6To6FmeWxVHOga1qtdYp3SMG+33RE0Kuo4ZTSZ2u1Z7y7OVPjs3PXXS
         w6DyrvMd0kvSkli2/Dkp/gm9J76rYLsPP8Oykb3uNhjpIpkKfCMXIRdoABVJEUPiADaL
         uJmqfqGvKmJS7c3VZKuRBX3637nE5ZsXKUBaWX0zPWJkrDV4nnpp6bFF+XIoRYchzz+p
         m64zNSXkAf69/pZ06v8VEfzw2fDHthBAcSsss5BEB7m4/4OZYxK58cejFXoCf5UFCLiZ
         aIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720185649; x=1720790449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdV0v22yUm/xQxD/kVPFe9jly3facK8iEM4rioFXbJA=;
        b=ltSioHntVOTIwQKbSLanNO8mQBiZzgJxw+lG//D9K1C39+FWPbdCojxuho9JJY3CVI
         S8tcVr8im4T3KPA2UfS7/Xm0NqK2UJxK2+tpHEqPGH2oNRXx4S+ihjXQgZPvhCPeIO4D
         Hqtf+Jsz1DBJQfoR9T+WF3EB+fs1c4ea/xeUFpYCvK5AaWArCQ1ZtHCfM9OaYWyHmFyT
         Db8pVcNF7u7IXjhh+nFXrP9V+CMxPHdXI8lrjNCDwhSdv1ly8jmX8rpD1wSiiibXmtGe
         1qw2izPsAhjXwrRR+rZxCGpg4FCKa1+gUMeCxSoIfQcs3g9VTfb/zQG/aAJaZ636bLMu
         iF6A==
X-Forwarded-Encrypted: i=1; AJvYcCUbznXe/l13lIP8xoLZxAGmu49BrgjxOx3bVwCk0Ge9cXGoraPF8S6iKUvQlTSWmQkZx9RaPtc4BzqjCxNxuHqNBduIxKdwXwzF+UUT0TGPWO9MWcaRtd/X2zClr2vdT5N+clPiNSRq0JqgkOU6HA==
X-Gm-Message-State: AOJu0YyhOG2XXSGNvybO52Neib8vEF/P8ABXf/19ZXqjFL7ZXRcGZfM1
	OwBiEC6QZW9KDo+IGlXMo0nMxeNm2i/rQZXHZR/FSUTYCVu/FKFN
X-Google-Smtp-Source: AGHT+IHbXhgz6hXL3vXtUwswf/FgOMe23CpsW5q44P2Xt+VydFM3gA8qlpIIjA5oV2i0Gaeo5lM9mg==
X-Received: by 2002:a17:90a:b88d:b0:2c9:81ab:237d with SMTP id 98e67ed59e1d1-2c99c5042c3mr3419090a91.7.1720185648929;
        Fri, 05 Jul 2024 06:20:48 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a956260sm3328974a91.19.2024.07.05.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:20:48 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v5 1/8] perf trace: Fix iteration of syscall ids in syscalltbl->entries
Date: Fri,  5 Jul 2024 21:20:51 +0800
Message-ID: <20240705132059.853205-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705132059.853205-1-howardchu95@gmail.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a bug found when implementing pretty-printing for the
landlock_add_rule system call, I decided to send this patch separately
because this is a serious bug that should be fixed fast.

I wrote a test program to do landlock_add_rule syscall in a loop,
yet perf trace -e landlock_add_rule freezes, giving no output.

This bug is introduced by the false understanding of the variable "key"
below:
```
for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
	struct syscall *sc = trace__syscall_info(trace, NULL, key);
	...
}
```
The code above seems right at the beginning, but when looking at
syscalltbl.c, I found these lines:

```
for (i = 0; i <= syscalltbl_native_max_id; ++i)
	if (syscalltbl_native[i])
		++nr_entries;

entries = tbl->syscalls.entries = malloc(sizeof(struct syscall) * nr_entries);
...

for (i = 0, j = 0; i <= syscalltbl_native_max_id; ++i) {
	if (syscalltbl_native[i]) {
		entries[j].name = syscalltbl_native[i];
		entries[j].id = i;
		++j;
	}
}
```

meaning the key is merely an index to traverse the syscall table,
instead of the actual syscall id for this particular syscall.

So if one uses key to do trace__syscall_info(trace, NULL, key), because
key only goes up to trace->sctbl->syscalls.nr_entries, for example, on
my X86_64 machine, this number is 373, it will end up neglecting all
the rest of the syscall, in my case, everything after `rseq`, because
the traversal will stop at 373, and `rseq` is the last syscall whose id
is lower than 373

in tools/perf/arch/x86/include/generated/asm/syscalls_64.c:
```
	...
	[334] = "rseq",
	[424] = "pidfd_send_signal",
	...
```

The reason why the key is scrambled but perf trace works well is that
key is used in trace__syscall_info(trace, NULL, key) to do
trace->syscalls.table[id], this makes sure that the struct syscall returned
actually has an id the same value as key, making the later bpf_prog
matching all correct.

After fixing this bug, I can do perf trace on 38 more syscalls, and
because more syscalls are visible, we get 8 more syscalls that can be
augmented.

before:

perf $ perf trace -vv --max-events=1 |& grep Reusing
Reusing "open" BPF sys_enter augmenter for "stat"
Reusing "open" BPF sys_enter augmenter for "lstat"
Reusing "open" BPF sys_enter augmenter for "access"
Reusing "connect" BPF sys_enter augmenter for "accept"
Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
Reusing "connect" BPF sys_enter augmenter for "bind"
Reusing "connect" BPF sys_enter augmenter for "getsockname"
Reusing "connect" BPF sys_enter augmenter for "getpeername"
Reusing "open" BPF sys_enter augmenter for "execve"
Reusing "open" BPF sys_enter augmenter for "truncate"
Reusing "open" BPF sys_enter augmenter for "chdir"
Reusing "open" BPF sys_enter augmenter for "mkdir"
Reusing "open" BPF sys_enter augmenter for "rmdir"
Reusing "open" BPF sys_enter augmenter for "creat"
Reusing "open" BPF sys_enter augmenter for "link"
Reusing "open" BPF sys_enter augmenter for "unlink"
Reusing "open" BPF sys_enter augmenter for "symlink"
Reusing "open" BPF sys_enter augmenter for "readlink"
Reusing "open" BPF sys_enter augmenter for "chmod"
Reusing "open" BPF sys_enter augmenter for "chown"
Reusing "open" BPF sys_enter augmenter for "lchown"
Reusing "open" BPF sys_enter augmenter for "mknod"
Reusing "open" BPF sys_enter augmenter for "statfs"
Reusing "open" BPF sys_enter augmenter for "pivot_root"
Reusing "open" BPF sys_enter augmenter for "chroot"
Reusing "open" BPF sys_enter augmenter for "acct"
Reusing "open" BPF sys_enter augmenter for "swapon"
Reusing "open" BPF sys_enter augmenter for "swapoff"
Reusing "open" BPF sys_enter augmenter for "delete_module"
Reusing "open" BPF sys_enter augmenter for "setxattr"
Reusing "open" BPF sys_enter augmenter for "lsetxattr"
Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
Reusing "open" BPF sys_enter augmenter for "getxattr"
Reusing "open" BPF sys_enter augmenter for "lgetxattr"
Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
Reusing "open" BPF sys_enter augmenter for "listxattr"
Reusing "open" BPF sys_enter augmenter for "llistxattr"
Reusing "open" BPF sys_enter augmenter for "removexattr"
Reusing "open" BPF sys_enter augmenter for "lremovexattr"
Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
Reusing "open" BPF sys_enter augmenter for "mq_open"
Reusing "open" BPF sys_enter augmenter for "mq_unlink"
Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
Reusing "open" BPF sys_enter augmenter for "symlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
Reusing "connect" BPF sys_enter augmenter for "accept4"
Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
Reusing "open" BPF sys_enter augmenter for "memfd_create"
Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
Reusing "fremovexattr" BPF sys_enter augmenter for "statx"

after

perf $ perf trace -vv --max-events=1 |& grep Reusing
Reusing "open" BPF sys_enter augmenter for "stat"
Reusing "open" BPF sys_enter augmenter for "lstat"
Reusing "open" BPF sys_enter augmenter for "access"
Reusing "connect" BPF sys_enter augmenter for "accept"
Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
Reusing "connect" BPF sys_enter augmenter for "bind"
Reusing "connect" BPF sys_enter augmenter for "getsockname"
Reusing "connect" BPF sys_enter augmenter for "getpeername"
Reusing "open" BPF sys_enter augmenter for "execve"
Reusing "open" BPF sys_enter augmenter for "truncate"
Reusing "open" BPF sys_enter augmenter for "chdir"
Reusing "open" BPF sys_enter augmenter for "mkdir"
Reusing "open" BPF sys_enter augmenter for "rmdir"
Reusing "open" BPF sys_enter augmenter for "creat"
Reusing "open" BPF sys_enter augmenter for "link"
Reusing "open" BPF sys_enter augmenter for "unlink"
Reusing "open" BPF sys_enter augmenter for "symlink"
Reusing "open" BPF sys_enter augmenter for "readlink"
Reusing "open" BPF sys_enter augmenter for "chmod"
Reusing "open" BPF sys_enter augmenter for "chown"
Reusing "open" BPF sys_enter augmenter for "lchown"
Reusing "open" BPF sys_enter augmenter for "mknod"
Reusing "open" BPF sys_enter augmenter for "statfs"
Reusing "open" BPF sys_enter augmenter for "pivot_root"
Reusing "open" BPF sys_enter augmenter for "chroot"
Reusing "open" BPF sys_enter augmenter for "acct"
Reusing "open" BPF sys_enter augmenter for "swapon"
Reusing "open" BPF sys_enter augmenter for "swapoff"
Reusing "open" BPF sys_enter augmenter for "delete_module"
Reusing "open" BPF sys_enter augmenter for "setxattr"
Reusing "open" BPF sys_enter augmenter for "lsetxattr"
Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
Reusing "open" BPF sys_enter augmenter for "getxattr"
Reusing "open" BPF sys_enter augmenter for "lgetxattr"
Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
Reusing "open" BPF sys_enter augmenter for "listxattr"
Reusing "open" BPF sys_enter augmenter for "llistxattr"
Reusing "open" BPF sys_enter augmenter for "removexattr"
Reusing "open" BPF sys_enter augmenter for "lremovexattr"
Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
Reusing "open" BPF sys_enter augmenter for "mq_open"
Reusing "open" BPF sys_enter augmenter for "mq_unlink"
Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
Reusing "open" BPF sys_enter augmenter for "symlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
Reusing "connect" BPF sys_enter augmenter for "accept4"
Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
Reusing "open" BPF sys_enter augmenter for "memfd_create"
Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
Reusing "fremovexattr" BPF sys_enter augmenter for "statx"

TL;DR:

These are the new syscalls that can be augmented
Reusing "openat" BPF sys_enter augmenter for "open_tree"
Reusing "openat" BPF sys_enter augmenter for "openat2"
Reusing "openat" BPF sys_enter augmenter for "mount_setattr"
Reusing "openat" BPF sys_enter augmenter for "move_mount"
Reusing "open" BPF sys_enter augmenter for "fsopen"
Reusing "openat" BPF sys_enter augmenter for "fspick"
Reusing "openat" BPF sys_enter augmenter for "faccessat2"
Reusing "openat" BPF sys_enter augmenter for "fchmodat2"

as for the perf trace output:

before

perf $ perf trace -e faccessat2 --max-events=1
[no output]

after

perf $ ./perf trace -e faccessat2 --max-events=1
     0.000 ( 0.037 ms): waybar/958 faccessat2(dfd: 40, filename: "uevent")                               = 0

P.S. The reason why this bug was not found in the past five years is
probably because it only happens to the newer syscalls whose id is
greater, for instance, faccessat2 of id 439, which not a lot of people
care about when using perf trace.

Commiter notes:

That and the fact that the BPF code was hidden before having to use -e,
that got changed kinda recently when we switched to using BPF skels for
augmenting syscalls in 'perf trace':

⬢[acme@toolbox perf-tools-next]$ git log --oneline tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
a9f4c6c999008c92 perf trace: Collect sys_nanosleep first argument
29d16de26df17e94 perf augmented_raw_syscalls.bpf: Move 'struct timespec64' to vmlinux.h
5069211e2f0b47e7 perf trace: Use the right bpf_probe_read(_str) variant for reading user data
33b725ce7b988756 perf trace: Avoid compile error wrt redefining bool
7d9642311b6d9d31 perf bpf augmented_raw_syscalls: Add an assert to make sure sizeof(augmented_arg->value) is a power of two.
262b54b6c9396823 perf bpf augmented_raw_syscalls: Add an assert to make sure sizeof(saddr) is a power of two.
1836480429d173c0 perf bpf_skel augmented_raw_syscalls: Cap the socklen parameter using &= sizeof(saddr)
cd2cece61ac5f900 perf trace: Tidy comments related to BPF + syscall augmentation
5e6da6be3082f77b perf trace: Migrate BPF augmentation to use a skeleton
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$ git show --oneline --pretty=reference 5e6da6be3082f77b | head -1
5e6da6be3082f77b (perf trace: Migrate BPF augmentation to use a skeleton, 2023-08-10)
⬢[acme@toolbox perf-tools-next]$

I.e. from August, 2023.

One had as well to ask for BUILD_BPF_SKEL=1, which now is default if all
it needs is available on the system.

I simplified the code to not expose the 'struct syscall' outside of
tools/perf/util/syscalltbl.c, instead providing a function to go from
the index to the syscall id:

  int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx);

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/ZmhlAxbVcAKoPTg8@x1
Link: https://lore.kernel.org/r/20240624181345.124764-2-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c   | 14 +++++++-------
 tools/perf/util/syscalltbl.c |  7 +++++++
 tools/perf/util/syscalltbl.h |  1 +
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a547ccfa92c9..8449f2beb54d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3354,8 +3354,6 @@ static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
 {
 	struct tep_format_field *field, *candidate_field;
-	int id;
-
 	/*
 	 * We're only interested in syscalls that have a pointer:
 	 */
@@ -3367,7 +3365,8 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 	return NULL;
 
 try_to_find_pair:
-	for (id = 0; id < trace->sctbl->syscalls.nr_entries; ++id) {
+	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
+		int id = syscalltbl__id_at_idx(trace->sctbl, i);
 		struct syscall *pair = trace__syscall_info(trace, NULL, id);
 		struct bpf_program *pair_prog;
 		bool is_candidate = false;
@@ -3456,10 +3455,10 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 {
 	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
 	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
-	int err = 0, key;
+	int err = 0;
 
-	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		int prog_fd;
+	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
+		int prog_fd, key = syscalltbl__id_at_idx(trace->sctbl, i);
 
 		if (!trace__syscall_enabled(trace, key))
 			continue;
@@ -3505,7 +3504,8 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 	 * first and second arg (this one on the raw_syscalls:sys_exit prog
 	 * array tail call, then that one will be used.
 	 */
-	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
+	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
+		int key = syscalltbl__id_at_idx(trace->sctbl, i);
 		struct syscall *sc = trace__syscall_info(trace, NULL, key);
 		struct bpf_program *pair_prog;
 		int prog_fd;
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 63be7b58761d..0dd26b991b3f 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -123,6 +123,13 @@ int syscalltbl__id(struct syscalltbl *tbl, const char *name)
 	return sc ? sc->id : -1;
 }
 
+int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx)
+{
+	struct syscall *syscalls = tbl->syscalls.entries;
+
+	return idx < tbl->syscalls.nr_entries ? syscalls[idx].id : -1;
+}
+
 int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
 {
 	int i;
diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
index a41d2ca9e4ae..2b53b7ed25a6 100644
--- a/tools/perf/util/syscalltbl.h
+++ b/tools/perf/util/syscalltbl.h
@@ -16,6 +16,7 @@ void syscalltbl__delete(struct syscalltbl *tbl);
 
 const char *syscalltbl__name(const struct syscalltbl *tbl, int id);
 int syscalltbl__id(struct syscalltbl *tbl, const char *name);
+int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx);
 
 int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
 int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
-- 
2.45.2

