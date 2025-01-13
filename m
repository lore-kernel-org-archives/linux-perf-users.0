Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE821BD014
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745747; cv=none; b=BPRvkN1bzUjrK2tRdKyngaf3hetk8Owg4F+jA3NWDic2qEuJWAc3GElE6NkzbkZPL6XDHx6VoZiwJ+xoTdP1YlbmM+n0zEMzzSxcGnzuATI9PzrE8zqPsLnlfoCwDFCYhAFxSk6VTll+IFzGF8Zf6KmU1pzZmoBSmjH5FqtP0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745747; c=relaxed/simple;
	bh=r9N0xK3Vmhlars0O2eO30dwlxQQcuWOaWELHbi43MvM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qC9d+wds+o5MxJDrSFZBMM8iiZ+r/sHGDyJesCgI/dYQwiuzr8Ry8Q5rgC1NL0qCuUUK1OlyUgxqFY6QaljhX2L80a8O3PjxPfqQt42ElFs7TSrTeSfGRmAx1onX+kxoFXHQP5Ly8LhlegFNRZQBporvMGZQOLs/TYkfl/d+8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdU/+kih; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdU/+kih"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163dc0f689so102691615ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Jan 2025 21:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736745745; x=1737350545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2SODDUU/4by30C8cH2MnStzrDco9M/M3NU9sKNQSG6A=;
        b=TdU/+kih/A1itaS/IC0T3mwuRGgU/yapUQMvFVe4qRMv30/jF4JBD6LKREqRSgCxhH
         COjEguOUUBlNT96ncKQ8RsCwyxrdXsewhszIIDnwLdFIa97t/nhMhf1j1BIbE92lfT8l
         OuiinhECwL2GjF4Dqssj2eZh3yYEI12iTZm1c4eqkx9JdkhrQNH0ptWyEPiCC8edzqzv
         yylJQUDsbPqL185lQ8kxQfvYqqza0xpTudDTVKjfmgnJEZj7kBlp3QlJVOKIlayTQz7m
         vanicFdnfgy+w0AGr20lzYyNdDsaTwK73GBKTv74XdVaeUHSEG20qzUJN0ZoP1g4mXhH
         1b4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745745; x=1737350545;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SODDUU/4by30C8cH2MnStzrDco9M/M3NU9sKNQSG6A=;
        b=JC/J0H6tT8DiljjbgmpjQR7Esb06djDTpD41mnUZD0cVhskt5MH8iwhGyCl4nGDcWV
         aVlVzspCG2NwhYRdUWJftWLuJd+liRgJK81cFEwkfzBWLkXfPT1f+FnpubXAUJcDLKnC
         /BLcmwyt1dZ/FTV8oJqEkzeYIaHJ7BI7oW6PGhpCQm7xpzWVr2JmDM825/f6SjttGZOj
         6+PfEAV7DfhTfsush1HJ4ZL+tpbKDC3neNSKd3nCRFWiBULe2efOf+NfGCMjxiksBYWd
         h4CrdmNVsy8oSbbkXXTCU/ayueVoXU47zQdaXREX+vAMaG+fJWtAD+uyES1pxeH+U9kL
         ieog==
X-Forwarded-Encrypted: i=1; AJvYcCUgQBukt3wleANQ9lZdPsbyn60f8DG68LJKAwUPK1zbMHV245KFShLoNL2LSZAIyaUiau+YTmOYZAvytFj2Mc0l@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjzf3EavOtY4L3ws96Un+rcUcRWKt1zc0Sy3Ew1u5jY7x0A98
	yb0jTPw8xcaYrbJduiWPQaNTD/XAB8eEUDLXuv4+ayhXDcywUP0zKEvMjMIzyosJPvLrV1IHtuh
	afg==
X-Google-Smtp-Source: AGHT+IGzKx5p7Rir4jhTnwW5HLnSafYS5KkR9v5qyIi4os9QTsqm3PJ9CrGVU2u+/4KcctucmJydyBAqMPs=
X-Received: from plbkx4.prod.google.com ([2002:a17:902:f944:b0:21a:8a37:37db])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234a:b0:215:8f2e:eeda
 with SMTP id d9443c01a7336-21a84012c27mr284934195ad.52.1736745745490; Sun, 12
 Jan 2025 21:22:25 -0800 (PST)
Date: Sun, 12 Jan 2025 21:20:13 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250113052220.2105645-1-ctshao@google.com>
Subject: [PATCH v2 0/4] Tracing contention lock owner call stack
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
  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex-spin -E16 perf bench sched pipe
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

v2: Fix logic deficit in patch 2/4.
Chun-Tse Shao (4):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode

 tools/perf/builtin-lock.c                     |  54 +++--
 tools/perf/util/bpf_lock_contention.c         |  58 +++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 192 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   6 +
 tools/perf/util/lock-contention.h             |   2 +
 5 files changed, 292 insertions(+), 20 deletions(-)

--
2.47.1.688.g23fc6f90ad-goog

