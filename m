Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE52046A5
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 05:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736486038; cv=none; b=MJSesNAYTo32qZ6N0gFp4T9ZD7FfcDE/A0wX9PetI6OdFaqIp8XMxOCrvn1HHraIEZ799fiy4/dJloVJaNEXi6miDCAvSApT3vNbtSkrRtGQ4QXT1KtAGpopqeUWnA2r0v7CsMPvJt3BWaP1fZrCoX5XjcQOIBDlbhML3NjH1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736486038; c=relaxed/simple;
	bh=slXJnd44zykQM6Ny+pdk7SNyYIz26u28jByG4PgsBrk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OBR2BQValYM9MhqQNjKMDM7wZ8YX+Rtu41SWu5PF2PKb1jKs9O628X7kEmJoht2zVwGLoG+iYbWoN0ugvpDln3Y1XgQdYLSI+U5YlZBR3iUSlv2HWB7kwRP743WsPGEQdP4/U3NlVh724pdAHTKHO+d0TzemPkYHY6uZ+oUtaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=szFK2ulW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="szFK2ulW"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163dc0f5dbso32333235ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 21:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736486036; x=1737090836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=blP3qUW1zAZ81VuDJCt7lJik7KORrQPlPvK969LS39g=;
        b=szFK2ulWR1XP4+36ud3AZ+6KjangZg4FygIrP/gAIJryUT4ySgjiCKiMd9XsQGbdKh
         +WjtEZ5oII9ztADzF+iyJimxocU9jwCHw48/Kv2RCBzzSLrVaJO0Y+oWyjauwbC1+w+p
         nPKkeFYh7RnL6SKVoVdxJPEMfwdLXF6uurl9WIjoLc+S28yaLu6OKJmd62xG3fnWiL5F
         C9PKn6wFn/UheD9SLAg/7dsDs5OjIQ3NJzSPvYcuWAgWeoCaDLCLS7zD22y/Kwh3l3y+
         swgDgWVafSRut4VlLQl3Y/1JTl3YFH91qre7tW57ibjEhIGgtGRy5gYoXBXBLlHkKv0D
         Eneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736486036; x=1737090836;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blP3qUW1zAZ81VuDJCt7lJik7KORrQPlPvK969LS39g=;
        b=QZ386jgP2W68l5Yr74Jj0b9V640GtQ2iP4U1jCX/FLXqdQhYjkxHikFHl5VfkFCriR
         fcT7Y5rxP95nW5mtfy48jhFwAWU2MPfdYhKN46bD3Ns0T4duH7uMQ4wY+KXgNW/X7Oi7
         NWweTT087uh6YUGdxC0n1EhFG1/tffA1kpAMjB4Wp230BU8jwOa/Beoe872VmYZoy6+W
         KAG/bFdWF2YyYQoR/QYjv/JIHlQNgTmV5p4hDsuMtoy3Arp/kJcoMQUqsRpWqaYFvOpX
         wpuhbqHfpRZ1bcaQNzYWI2t/JXO+yV0dg4TEcsivuHRjLIuv+yll4F6oRCXzwhZsyUA9
         gyJg==
X-Forwarded-Encrypted: i=1; AJvYcCXJH7o1nqDcQON7VtvCDgpYbqbigtKsclAyEtEqAr3NYrlwjGxeFkIXB3/z6hiecgXNOSRh6K7559IdLSmyVwgJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QW0GzWdMVUjQYAhf5ewV141WRG61s9MuxSSGv1KdpDdk5fkC
	kKalSVLybjIgG2WVJ1J6NqXQUUaD5xxg1psuEaSd0ixR0F85hKwuLT2zphV1AflJEv0ryRu5i4e
	z9w==
X-Google-Smtp-Source: AGHT+IH0Ei5gmc9/UKfOPVRdw1TevO8tp0MWg7nqnILImIxo9F7p5b2S63f7075CvI1N+QUliiIkh+qyPHA=
X-Received: from pfbcz5.prod.google.com ([2002:aa7:9305:0:b0:72a:bc6b:89ad])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244d:b0:1d9:fbc:457c
 with SMTP id adf61e73a8af0-1e88d0a4770mr16871431637.36.1736486036508; Thu, 09
 Jan 2025 21:13:56 -0800 (PST)
Date: Thu,  9 Jan 2025 21:11:40 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250110051346.1507178-1-ctshao@google.com>
Subject: [PATCH 0/4] perf lock: Tracing contention lock owner call stack
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

Chun-Tse Shao (4):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode

 tools/perf/builtin-lock.c                     |  55 +++--
 tools/perf/util/bpf_lock_contention.c         |  58 +++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 189 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   6 +
 tools/perf/util/lock-contention.h             |   2 +
 5 files changed, 290 insertions(+), 20 deletions(-)

--
2.47.1.688.g23fc6f90ad-goog

