Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BF21129D
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399346; cv=none; b=Ui+t1KVkHX7bQH96r7twu8QLUq+9b6GK7N1uZmrbCSppVm9tM9EAHFW31Uw2+b1r1lsQ7lefRtnKjUxTFPm61po6z62+2FH8ynbxHK/pXkqHlDBURsseGXmXOtJJ8ReDjaA032YJ2sHdiM6k3RXH4H1L89H9K6Iqc8DaJfhAgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399346; c=relaxed/simple;
	bh=vrXQBzZLHyWqS64CTDiirsBQO9JgZrbt74ofDZ59COY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BmDdgqZROOS0U5gycDqMpNLcT96NeZ/kzmBqANJ9U/eVUc3fEoeM35VHEOrPlOJfOE7wmpsQ+w2PxA57E6eDNGhp0fhbk86hwOlpGBSqGbHSOZYrC3RstT9DDLydyTKYouAm8D4KnFdUvI1Pzy13V6NmGH1LVfmk53DP/2o17hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luCO68Ut; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luCO68Ut"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso762675a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 14:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399344; x=1740004144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ops18fMc+NWzGSM8vJwyhsQmNBMs6kMxdvy3bOSxpxk=;
        b=luCO68UtekvwfoCXDjQOwav+xU0DGiNE3MoO5frc8qL6hstfKyg7p4IvrBpHbIqBec
         uvhIlmIxYhaag+qEKwMzhqYRWjV+oLMCznlCHqVQKxqc2h11imilYF6qdCoGOgLKDvge
         gWhRyLr4na+XPldHXYRbT1VzL7j8vrldt94Ro8qEyRGJvtb95CM+ETS3nshAPyLvHnVJ
         q8jp4J7DJw4waoT+gH0RrsueKZVKE0UiFiEJliV9dV+H7P+rP9hF9AyL6nmwJ29y46Lz
         CfY6STH8A21tdBS2YtvE5miTlveL/9T1hISUIGwP2gKrMnz00ARui6jwKWrqviOWvRaa
         L/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399344; x=1740004144;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ops18fMc+NWzGSM8vJwyhsQmNBMs6kMxdvy3bOSxpxk=;
        b=i450WosYfVkK1090fFwQnC4uawJ9ujeHxGeJsUgohqPXSIlyt9y/7UZYILMyaFKomd
         F4J66vNcjaA19i/b06a+hElyWHYIZd4oCIa3HwvH64kUUUdMnex2uVEomYYD299G0D0G
         xRKWmOLm0ZYRvETKKP9sYR8tXA7kXItg9tOxNUlBlLMyiyX2xuqBe4y3TJlR3XMEVnti
         /ZXR9yMJ39KIRR+qWRNDg1XFP2tjpI8/FpBnHiZ9h6CB25VJhsYvxP/75e4/gHMyYmqY
         BmThOfDi8hnKhz191Y1IBjR1v31ZcdL1eC0WALfLZx50cAE/zUb80Vk3IwUrCYzDAHWJ
         JsGA==
X-Forwarded-Encrypted: i=1; AJvYcCVLkk4+b0rpnSpmy2BPFZ5VBlGnKasgrvfwLUCBAeU6y51zHMZNt8Xa7AwjpgI4sfd3ioz68azWUze8ZvLy1PkH@vger.kernel.org
X-Gm-Message-State: AOJu0YzdChjRlKpazJyuPVl6hdF509+8qZhWZ6MYAcYo6TBYvKR5zhux
	R0NonS3UL6mWLVESdXOf18Bz27EKWSLSDcpe/pSYFK0fIHQG6mB5ulTz9yd8Nlw2Auv05Lgq+Cu
	xsg==
X-Google-Smtp-Source: AGHT+IF3ZXoEyE4KPjh18j6I0r1uGq7qRrUlWVGa2SDtefltt/F2NlHzYljpGmfH3tjOGVfJWZFHSk9U+0o=
X-Received: from pjbpl10.prod.google.com ([2002:a17:90b:268a:b0:2fc:11a0:c53f])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e183:b0:2ee:d63f:d71
 with SMTP id 98e67ed59e1d1-2fbf5bec92bmr8716045a91.14.1739399343897; Wed, 12
 Feb 2025 14:29:03 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:51 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-1-ctshao@google.com>
Subject: [PATCH v5 0/5] Tracing contention lock owner call stack
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
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

v5:
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

Chun-Tse Shao (5):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode
  perf lock: Update documentation for -o option in contention mode

 tools/perf/builtin-lock.c                     |  59 +++-
 tools/perf/util/bpf_lock_contention.c         |  68 ++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 251 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   7 +
 tools/perf/util/lock-contention.h             |   7 +
 5 files changed, 367 insertions(+), 25 deletions(-)

--
2.48.1.502.g6dc24dfdaf-goog

