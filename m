Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9DC1AD9D9;
	Thu,  4 Jul 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097036; cv=none; b=QnLas262N+3iwez5gV1yrMr3qdd4BjrWmu2qQd2R/5XtbCjdKy65rpp5IwA9t2tj2jw5dH5pTqS2IRAXcR7+FL6GfxU9Rgh8AP3PlYIjXyfvq3B2UlNzHnpbWmg8Boi5Do4PITCKR+qHMuEEqIqyWvvtq4vuP7ixWbwDFB9rAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097036; c=relaxed/simple;
	bh=TcMIJ/JpDkilQ3Dd6EFQj4a/Zjx58vavsGUf62pcv2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTKvL2PuehBqdRxBdjil2neYZFc0jt2c/SzUxfMdcLgv3HZ4vFJtWtzrpmwK0Hsc4w8VJ9jSomuYTGhXHp8TXup2LUqSx0jXZgMKKix+nYYsTPu/Y91WNs9w9AtdfnN8LXtv/7/qGruGDpV4xIjy0mOIdIsyp5PsBDZkQttYHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3lytZZw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3lytZZw"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-656d8b346d2so342055a12.2;
        Thu, 04 Jul 2024 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720097034; x=1720701834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjZ5Tc84T8zrmuIv+QLMZoeIPrxCO7uOMh+7TR/hRAQ=;
        b=T3lytZZw9TduzqZ2bmTFWIzB/fALlsrpDQe62tSbg/pkJUatP6pb4+tRA7HzdvuF0i
         6x7miIPjbL+Hq37JGp4ZfPpJ7wU9GksRPMLl5lU6wBZRMgZNn4tnfaxi9ldWQOkztnG+
         VJudrzAwRjtnxycsgo6jPyXWzwdID6rEpEhHI5H0GQ27Ewgzo9K/Xw/UVb7er4FvAIcq
         0LH9aZ6r7+1ddvNM55aYpLpQW+6IkcG8fi6f83FWyiZ1I8UZt6phqHEh+g0EU3DaqVxX
         YP851X6opELrsx86mxboQUvbSScArrygRcJLz5t5gZVtF9wm+HhZWmdywZaeUnetZ5kV
         wIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097034; x=1720701834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjZ5Tc84T8zrmuIv+QLMZoeIPrxCO7uOMh+7TR/hRAQ=;
        b=SFKejb+y2HdIEsSkTkEUr2FXgVssoOLFuku0bTMueDcRW6SOI95DoCt6sRgF5oKAhe
         g/Gph3M/CSatwNAkZSKZn4HyfRCxSTpTqSi5/XiSNIhmpQouE1dERO9wAYMrrx/pF84s
         1QeztY1SSMIEdpoQZ5yDA3tpgklF38C1w5edlommkqz2UJl22/gG7VlhGurW979Qiob+
         UoYPh3CvUcmHhJkcl3QD3SZOgWdssTdnvCKeyUOxbIja5JuC8qql6hn2wjJX3ycofklv
         DXbqEKkARaPRP0XLvin909s8onOZV6yFyEH7RlI3QIuNBf25MXPa/y/n/HsMyKy6NViY
         j5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWFhfrCK4mRr2sAihMaMONJPOD4B9yGlAVKnksGpbmMKW4xmo9fX4NQVqHs0AYCg42DCOIZvu2jw/tCcEWVeJuFvcmxveOf7QqmhSHqFqlHtwWUCCgSCoLLIUSnjpBLJoMacxGdodVEbl2zz6JoDQ==
X-Gm-Message-State: AOJu0YzsrlvN4dbsf+7c0+zUgMBZJwgjTKOKivB2hatK5Lk69tuI++y1
	F35ATSrT376Cpm7GEQAtjSthdRsuLhOWn6ujlbUkk+wA78GYXxp4
X-Google-Smtp-Source: AGHT+IHLVo+ZErpdJM4ep4tZQ1/IIU7cGYXLkQ4xUFbdXcfJFJZSPAeeaLf9W7dSLtWEnkMnVDBb/g==
X-Received: by 2002:a05:6a21:6d9d:b0:1bd:91aa:79a6 with SMTP id adf61e73a8af0-1c0cc727deemr1581273637.9.1720097033520;
        Thu, 04 Jul 2024 05:43:53 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598d35sm121578245ad.285.2024.07.04.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:43:53 -0700 (PDT)
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
Subject: [PATCH v4 1/8] perf trace: Fix iteration of syscall ids in syscalltbl->entries
Date: Thu,  4 Jul 2024 20:43:47 +0800
Message-ID: <20240704124354.904540-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704124354.904540-1-howardchu95@gmail.com>
References: <20240704124354.904540-1-howardchu95@gmail.com>
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

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/ZmhlAxbVcAKoPTg8@x1
Signed-off-by: Howard Chu <howardchu95@gmail.com>
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

