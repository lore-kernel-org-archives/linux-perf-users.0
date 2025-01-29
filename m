Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17919155321
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110279; cv=none; b=FQY71zbMJWrlImloRjM1pNWOeJ0kScIVySGTMrSTcTPlmjBql2dZwRsFCOIajmeywlfnqo0U7uppOQpyGoeoMbOy9hgu/sFahQVfkxoU3Nil4V2ZjLySsKereh53/Qblp2geCehUm+HE5TVqZwqRydRz0qftM01EfaKiaaQuNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110279; c=relaxed/simple;
	bh=Tye1ZieSPZQmo1mo8HoGA/TZnzVuj35yU1agRawQNig=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=enIhEtkDBahrSY6UBlFlBqUtjpMwmBI6X4JI/FrHo/R4v4/X9a6C8Ut2qehDbRQ0gfC+txsn8HqlTJDe3excY9lKrIQksG1MyhehNzgZiqPFPWNFQTA+s+2YRRm3zjakWAkPqmctNA3GAsfY5CRG5T3JaF44GxP9dCqyX+UWMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsGmjapE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsGmjapE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2164861e1feso121080905ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 16:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738110277; x=1738715077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ss8IRXPQuROgaPFI2n/Tn6B8Bw+CUwUeulj0ny/+twg=;
        b=GsGmjapEEJ/0wGZtTJxA+D1u9QFOr1MF34ClDsqzNCV0X6lsB6sY3j8m8p60OWDK6R
         9u4SY+WKn6d+OilWjmXBPsP7xDZfZcXCOmCsz1uE3RkgjKK/YpSXVIoe7DqPp4D7hGgQ
         rqQ5s0rqeIkVeRvjk8JnQmrI6/acMBTBx4UWJNWsPiMk4w/1RmL+6WyaXLIZyjf6e05O
         fJ047JFb7n7W4B9ys9K38Z2wRGinzt+UVqoLc9+sArv4XrnZO8vL8SWUPWvBhqHrOqq2
         OB/vS22OmNhzIRgLGHTQ3iuwFWQ9mF+y4g/nbcKq8zJq8/bSrODIMiLGmU7vcUCcy1Ol
         feLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738110277; x=1738715077;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ss8IRXPQuROgaPFI2n/Tn6B8Bw+CUwUeulj0ny/+twg=;
        b=TrEZq/P1xNYmHsJjSckK51oe1X64s+hsJyUY0fm1BWUtshn2W1ss4UKJlo0nY3a0n1
         ppE30TFsesFYax2bNJ7TKhPpFnerW+Kt14X/Spjig6mkUw5rsd6Pgu5EiRzHqn1575YU
         kRVDd6t7hpOk0jbIrKDqj18YYj3Cwv6Ib+nr8FL7tyKFKlzCQcrdIMyDE0ICPS/UxggK
         Icw5IfmnfdQxtMabds+06yTAoANwx5m2dEdfSBkTfDn84DWnpqic5+7pfzKwlYKT94jf
         ZHmg+Zd716JLHrG2mEfgoZ26QgMDFgSrrAn7zvGHQXno8sztBZL7vgNE1XlcJt2DWIkY
         Gu0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw4vWNCV6q0WkkmnDIyYq6oJIuoU600UHuDOvbnT/65/CXo5xtGTuf2L0w8ruRlbnI/vJuAZRxm+NsPVkHJJ4O@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKQ5ReVcyl68K5P/b01ZTMBCdOkEA5Al/s8jGXF4hzXT+M53X
	PdhWgGsHrbRPBFH/B8Fut0T3hhvgbtAVxPBqDkNYeidbYGPHY7HRrHQDU3ywJ48KgpHiXozzxcH
	joQ==
X-Google-Smtp-Source: AGHT+IECz3VTxLM4O986OseoNSxZB/C8h78XB8HxPSOGl8b2+z2HK2SySwPs7DImzJI+zObNWYsOE+c8sYo=
X-Received: from pgbcl4.prod.google.com ([2002:a05:6a02:984:b0:a88:3e2b:cada])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0e:b0:1e2:2e4:689a
 with SMTP id adf61e73a8af0-1ed7a6e183bmr1992091637.41.1738110277341; Tue, 28
 Jan 2025 16:24:37 -0800 (PST)
Date: Tue, 28 Jan 2025 16:14:56 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129001905.619859-1-ctshao@google.com>
Subject: [PATCH v3 0/5] Tracing contention lock owner call stack
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
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

v3: Edit based on Namhyung's review.

v2: Fix logic deficit in patch 2/4.
Chun-Tse Shao (4):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode
Chun-Tse Shao (5):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode
  perf lock: Update documentation for -o option in contention mode

 tools/perf/builtin-lock.c                     |  60 +++-
 tools/perf/util/bpf_lock_contention.c         |  70 ++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 277 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   7 +
 tools/perf/util/lock-contention.h             |   7 +
 5 files changed, 398 insertions(+), 23 deletions(-)

--
2.48.1.262.g85cc9f2d1e-goog

