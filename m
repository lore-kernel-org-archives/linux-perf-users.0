Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AE2837A
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616454; cv=none; b=GETwCJR1AiWFPFXcNZJmd5vU2slUNOgbAQd56vzb7fFSIB4FH1LGgPmozYMBFVJCr6jEOHZwXDRGRTwmOr+OX6HeGj8Cdh2NQsLIk4mNk32756te8hr7x5CSqFx7MegDuiSIEAnN12lR+q629kW8alnUKxxtlgbdb7drBmyw7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616454; c=relaxed/simple;
	bh=nU3y6YFsyIHN1dmjBlB/Wl3ngK6IdRrA1IoHzKQzagI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zy3VcOgkfNNI8F+Qca1sXyO1T5O3J3iz3KQBl17gYthITSBRSX/dOYDtZTBvtoEt1MMXrFI3KP0ngMuZOpRm0KKus0SOUuYAxzuC1/MwvIFJN8VqC6NCxWtz4u9TVkDMwe5o8EYTsBZRE5SuL4YKSeMK/hZ6qreXmLX2FL8Mgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJGNsDd4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJGNsDd4"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1a4c14d4so871883a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 16:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740616452; x=1741221252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUI6/1gyibvrTbWNNqX1qF+Ovy2PNmTRwmWu1BHDQsE=;
        b=tJGNsDd4UQqaOUBjs7F3CpZelhQDaj3fW7BWfmUdKXHADURkk3RVKFwl+KUqmmovty
         JdOjuHilYkHbff82Tbc7F+gRuL4cVBh/D7pc7yhutFqsp42LsLT3rDEyUhDxwimKBMYy
         KtvqNMRup+Ycmqot92kIKlr5u9Bp932y9ox3jZ4K9GnXjX+EG0JZHPtf47ZK2EruTy6G
         E/9KSgECtY6ZLih+mypFMSb2ckt5Z1XgQbbNIY2iLTezvUvhI2UBhr7H2lgWsdjLG+XF
         MyrMQctISgrDGebABO1FopAdPgtNRAXDswi/gcXIg8Sh9Oz/XYahPFu31LqIDF6rA72L
         8nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616452; x=1741221252;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUI6/1gyibvrTbWNNqX1qF+Ovy2PNmTRwmWu1BHDQsE=;
        b=gWEKP9wTKFKfJt74UN7EnEEJT26gzNL0Vnoly99v6olxK/SypgDRqwKbnE1Yyqc30b
         2hnRqJ22hsVaobapYTi3bsjnpYS3W8HO8blLzfV2pkksyYE8uPnb4lEFm/Y4d/XbMJnk
         XMzSN8v/cMaMPmyn9jWx6fqmguPbVfcS/NKLAi2e5G7YyxO/KVgpX45mTB45VhoqWahC
         iMLIqGsZt3qiz4u75qTmvm3JGUEckvefZf1wHB6jHU5ZsTqy1y5OFDTt3HzIxPUor2gA
         l77kjpTx8DeDC10hy+c/gttJa9BXEDTm3GmE4Ze86G1ej302wpLW5WbGgRproKcppGfd
         q19g==
X-Forwarded-Encrypted: i=1; AJvYcCWvn4Dx6TOyFlLfm7UCAyZ7eNf821BebwDtpHrKx9U30GwWScoAZcCIWF0T9Rd9vnladTQvpEqDD/MciWJ10agp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsa+/dvEL/dCGqBrMI5qJyMj6xgUl2oRifbqNJRrCmsPWVh47/
	ZrPV/NUzyaCxI0U59zM4oUvIc1QXN7gWGZZzyOYys4+c77B8qLDd4CoVf58KlUrRB4hXjtfkq23
	l+A==
X-Google-Smtp-Source: AGHT+IHDAQK/BsvI6mzuilkbqC4HRSy4qcc5tMuIfa3jBRAGH5Fcp4vFyNJuSfyPfVtwa/ebYbFuN9eV1F4=
X-Received: from pfbf4.prod.google.com ([2002:a05:6a00:ad84:b0:730:94db:d304])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a103:b0:1ee:de1d:5abc
 with SMTP id adf61e73a8af0-1f0fc78bfe1mr13706786637.33.1740616451981; Wed, 26
 Feb 2025 16:34:11 -0800 (PST)
Date: Wed, 26 Feb 2025 16:28:52 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227003359.732948-1-ctshao@google.com>
Subject: [PATCH v8 0/4] Tracing contention lock owner call stack
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For perf lock contention, the current owner tracking (-o option) only
works with per-thread mode (-t option). Enabling call stack mode for
owner can be useful for diagnosing why a system running slow in
lock contention.

Example output:
  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex -E16 perf bench sched pipe
   ...
   contended   total wait     max wait     avg wait         type   caller

         171      1.55 ms     20.26 us      9.06 us        mutex   pipe_read+0x57
                          0xffffffffac6318e7  pipe_read+0x57
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
          36    193.71 us     15.27 us      5.38 us        mutex   pipe_write+0x50
                          0xffffffffac631ee0  pipe_write+0x50
                          0xffffffffac6241db  vfs_write+0x3bb
                          0xffffffffac6244ab  ksys_write+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           4     51.22 us     16.47 us     12.80 us        mutex   do_epoll_wait+0x24d
                          0xffffffffac691f0d  do_epoll_wait+0x24d
                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
                          0xffffffffac693ba5  __x64_sys_epoll_pwait+0x95
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           2     20.88 us     11.95 us     10.44 us        mutex   do_epoll_wait+0x24d
                          0xffffffffac691f0d  do_epoll_wait+0x24d
                          0xffffffffac693943  __x64_sys_epoll_wait+0x73
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           1      7.33 us      7.33 us      7.33 us        mutex   do_epoll_ctl+0x6c1
                          0xffffffffac692e01  do_epoll_ctl+0x6c1
                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           1      6.64 us      6.64 us      6.64 us        mutex   do_epoll_ctl+0x3d4
                          0xffffffffac692b14  do_epoll_ctl+0x3d4
                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76

  === owner stack trace ===

           3     31.24 us     15.27 us     10.41 us        mutex   pipe_read+0x348
                          0xffffffffac631bd8  pipe_read+0x348
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
  ...

v8:
  Fix compilation error found by Athira Rajeev and Namhyung Kim.

v7: lore.kernel.org/20250224184742.4144931-1-ctshao@google.com
  Remove duplicate contention records.

v6: lore.kernel.org/20250219214400.3317548-1-ctshao@google.com
  Free allocated memory in error patch.
  Add description in man page.

v5: lore.kernel.org/20250212222859.2086080-1-ctshao@google.com
  Move duplicated code into function.
  Remove code to retrieve undesired callstack at the end of `contention_end()`.
  Other minor fix based on Namhyung's review.

v4: lore.kernel.org/20250130052510.860318-1-ctshao@google.com
  Use `__sync_fetch_and_add()` to generate owner stackid automatically.
  Use `__sync_fetch_and_add(..., -1)` to workaround compiler error from
    `__sync_fetch_and_sub()`
  Remove unnecessary include headers.
  Dedicate on C-style comment.
  Other minor fix based on Namhyung's review.

v3: lore.kernel.org/20250129001905.619859-1-ctshao@google.com
  Rename/shorten multiple variables.
  Implement owner stackid.
  Add description for lock function return code in `contention_end()`.
  Other minor fix based on Namhyung's review.

v2: lore.kernel.org/20250113052220.2105645-1-ctshao@google.com
  Fix logic deficit in v1 patch 2/4.

v1: lore.kernel.org/20250110051346.1507178-1-ctshao@google.com

Chun-Tse Shao (4):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode

 tools/perf/Documentation/perf-lock.txt        |   5 +-
 tools/perf/builtin-lock.c                     |  56 +++-
 tools/perf/util/bpf_lock_contention.c         |  85 +++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 245 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   7 +
 tools/perf/util/lock-contention.h             |   7 +
 6 files changed, 372 insertions(+), 33 deletions(-)

--
2.48.1.658.g4767266eb4-goog

