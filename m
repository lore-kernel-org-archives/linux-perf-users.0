Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910214502D;
	Tue, 18 Jun 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724364; cv=none; b=DYfBt/6tUvkRJWpiWZ5e2TWUb4dgwN3N4Znl2IrhwgGDPT61IUJWNKD4SmjAWJTUZeogL7HJAI+7dfNZJYZntYR6kPBzKL2k/qpEPVagXf0LhaIakV8yI4ZnOzakW0sEo8Y/CjK8nzEEIHbTsl3TEmy6W0MusAGMeTZgCHLEnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724364; c=relaxed/simple;
	bh=GPYYtacLEM3yqElaCBzMe4/DGGia7xVwg4cZbV/pbSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLrVzb3BjRvjHAgx8u2O6MZdRLctp9y8+V2hGQs0S2wzpyCYxghKoeihH1Xh5/xshSZfZ01nEVQXl0OIEVuf8FQGto6rFU4+O0aZxxsO+r2nWWJDuc7dSXsTMohouLql0fXxIok4ZZZPFHe/ku7cNv5SmUk7VA0gAlfsbJoMXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvJuSzc7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvJuSzc7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7042882e741so4571870b3a.2;
        Tue, 18 Jun 2024 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718724362; x=1719329162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0Vd/De1J9Bo8JQWZ7RX5Hl6z5NNgyu4XF00AImPHKw=;
        b=NvJuSzc7ta3h95r7CCkHNTDJhXNTnsmYp/VRa5nSzAy1cX9L7grLh4jysvKjNTPo6m
         /OtFbQbLZJ9BVGQ75QxXQ9XnWeTGJi60V+nnicYL8Fqvsahpm+e2M8CUZX0T6LJ38yVY
         CRF+51BtPzMrhCvYzrwaeNj36dmBC1tZBXzoWo756Fwqj6eLlK0BEIT92Cdp6IszAIjL
         WAaiNBbA5KTVmmys+frM0//nj9RXDymKHU9Rz+j5njCWYgDvCRhdKhpfkjF2vkWmJ/NT
         IPs7ZuUrl9Z/jaDIWQM6Lun79UjxodPhh4pZkVejCjjOkMZxHOZmOOLv0aCWsMB3bZjw
         ZzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724362; x=1719329162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0Vd/De1J9Bo8JQWZ7RX5Hl6z5NNgyu4XF00AImPHKw=;
        b=BQfuvVygC91KKTYBeLMeujsDEcePQZ4DDuFYHMSd8a6uyKiQRbg3LvacJyL7sfMeYr
         ZZIsBxOo/At8V9LrT0PaPWdalUJIdWfShuBFxcVNyyyK/5WcIu8l0i9YKhNTe3XPwIjf
         3EtG0cLD1V6z0S8c2CjOL0U4QKvpAWRwNWRvCVOntYLzndR6jDSIegI0TbLMck191Uzw
         DV+vgGEpQq72hHb3ieXrf9sTz99NW7Rrq7YKRoNLbPomrf/qJxETYaUbfliIMHhPI5YT
         e18rcZ0Q2Ja8DmMkfPzy1zHb8Qe2YMj4KdpK4u/RfMyri9GAYAYAZHSAGy1RzghcEU2g
         d3eA==
X-Forwarded-Encrypted: i=1; AJvYcCXdZC5GRPcewfqvlmot6i+E9M6T7lhiWBYsSr7MF59DoyugX2Yb8JrDL22l7y8DJeqQEHgCfQM+SApsSnOpUvcS6SkY7L9+j1hxoBcI8TgClzs1VSIv5eI6H8BiNVTsrYuiCnQ9tYHHZ6w/4I6/Og==
X-Gm-Message-State: AOJu0YyZzTyLdkdmT8mwFA+TxOcS4qT56paHswiSU1iBJAZcQ9JOfoPY
	POybNajqoT/ULnhulLc9irTuzcjpqTyntj13AeifLt22er9i7ePB
X-Google-Smtp-Source: AGHT+IFXewjYElfmcsYowsQhZQhMETSajqO/FaaKBMs4EcEM1SB8020To4gALYu3en+3MdTCNxVQbA==
X-Received: by 2002:a05:6a20:6a21:b0:1b7:bdb3:7bc7 with SMTP id adf61e73a8af0-1bae7ec6a23mr12732401637.20.1718724361642;
        Tue, 18 Jun 2024 08:26:01 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4265esm9071388b3a.116.2024.06.18.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:26:01 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v1 1/5] perf trace: Fix iteration of syscall ids in syscalltbl->entries
Date: Tue, 18 Jun 2024 23:26:48 +0800
Message-ID: <20240618152652.3446472-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618152652.3446472-1-howardchu95@gmail.com>
References: <20240618152652.3446472-1-howardchu95@gmail.com>
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
index c42bc608954e..c4fa8191253d 100644
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

