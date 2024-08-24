Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743224430;
	Sat, 24 Aug 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724517207; cv=none; b=dCjVagKfM2vEXs7U3eSCWwYHyJzlgfelLZLhkTDHl0ykT2LwzCfb5I2bgdyzzVxKlSX+RZPL9/gIj6uej2qiR7MvzgoQCoppLRbfLzb88VjCgj41jyc7KOQZR4mTPhpyvmoDMEFEgNoLJ3lNAQmv5yitt8g/Vd0H/4WiT7UbYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724517207; c=relaxed/simple;
	bh=ycABlzuDVSFSFJtOUr4WXvNFgy9OJ2JP4Y6iFpnMG8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXxlBU1VXiknsYpjAnVn11U6Vdt2/GYJH8Tgvv2r3V5JLBPZONZ+BaIbvrVn9p9IgqV9upfL4AbpCoO73dpFLWMTr3rH6Xtwy6XIvm9aLK+C7MLIeu37tYjNtlyccyAVp5xRzn+ur8q1JVCdz4yMMSF5HKtaD17o64c0+g48c3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HanYBYP2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HanYBYP2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso2260814a91.2;
        Sat, 24 Aug 2024 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724517205; x=1725122005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dM8CcuX7++y5SJ6qny9ROmrU6rNXnLsy6WhwhKunxw=;
        b=HanYBYP2KNXiielxCMI/uBdzCQK5MBi71YlD6cglvvDmqvBvQ61cNGhFDrLdOEnvNl
         J4Jdq9y6/kXASNXyah+ZPouO2Fk2a2NMG8t5Bq6mZNdZokyKqmSGIewgLxy9yq3pHeEV
         3JnAe24WxymuEXJwItZC0rhh5DKcQgRAQHBhd2Ox8AYLvncRLJ5ArJjO2u1OpTw3MFg7
         I+Wmtg7l9Ituy/JKgCFYw7aG63aIe9nZlxCZTCSYIhXBtGrzOi/JQyVpQXvybkkHi8vl
         jaDwNlm38t8q2FNsLKhG4R4vlFYatI7Omq5KKZE15ZDBPBQ78yBLwRxpMo1IgOCiCV5y
         GbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724517205; x=1725122005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dM8CcuX7++y5SJ6qny9ROmrU6rNXnLsy6WhwhKunxw=;
        b=C5TTIjf9R+AlvZ8KRfl9EVT4fX2koCdkej7G+SLGZwTS52UzRRpZP5RWGinCffbiNJ
         V08dPgNCT7oGASN02gp3bUv8EP7Gzpy7wmyg051zAJP+DGtrxXIdHroaPP8k6w6+Au9z
         i+G9+YN4DtaLZ0Nj8n85dZaNQj8PSyLWd/3ltWTSrCIrZepSLWBGH+fXRPYBgaP2tDVL
         fdAAq4SvnSzRrxykbjrsDcruJ0vWoX4oaScZUC8xckxmGk7e9VrhNskDWnKh8G7fCND1
         Bl3uVNE4fiaUjPzLrpi2L6+dFvtGZQB85RQ4x3pCPdqkjy3r8KYAZ3ayKUBY6c3w+6xT
         t5hA==
X-Forwarded-Encrypted: i=1; AJvYcCUArFVl2DXJXkLiFlvVX/RFG2kxDLk4VtAecoNQdkuLcXs3ed1raZhjbEyH35yLa0V7z00FKPF1s76DlMg=@vger.kernel.org, AJvYcCVK4yTJbqCWq+ctTJeLC84BPhLTvOxGBwMG906jAXfHW19GTqk118L4HYX5aYx86G1wS4hYHz4ugya/aRubiPLa4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKl7BvY8KwDFvkh2Q4v7dS6iTz5ZMI7/sg5XQa/TqhtTf0gSC
	TjCJOe8AbSI2P2HdNABeotPSyMi+kJtwYtbX7+2EdC1STYCsHx+x
X-Google-Smtp-Source: AGHT+IEOtBnAxw5CffKRUcl7L5f4DAq7GlJyAO8rhn7+XniCZlpnXy/o6Y5OEIBg2sri0EixtiPs3A==
X-Received: by 2002:a17:90a:4e02:b0:2d3:b357:7859 with SMTP id 98e67ed59e1d1-2d646bf63f7mr7097502a91.13.1724517204458;
        Sat, 24 Aug 2024 09:33:24 -0700 (PDT)
Received: from localhost.localdomain (104-58-203-241.lightspeed.sntcca.sbcglobal.net. [104.58.203.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm6376216a91.24.2024.08.24.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:33:24 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] perf trace: Enhanced augmentation for pointer arguments
Date: Sun, 25 Aug 2024 00:33:14 +0800
Message-ID: <20240824163322.60796-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- Prefer customized pretty printers to BTF general pretty printer
- Add --force-btf for debugging purpose (use BTF printer instead of the
customized ones that already exist)
- Add trap-handling cleanup to tests

Changes in v2:
- Fix perf trace workload bug.
- Rename pids_filtered to pids_filtered_out, and add pids_allowed to
avoid confusion.
- Add tests.

Forgot to add some before & afters in v1, here they are:

before:

# struct
perf $ perf trace -e epoll_wait
     0.068 (500.192 ms): Hyprland/539 epoll_wait(epfd: 3, events: 0x7ffd9f6f1730, maxevents: 32, timeout: 4294967295) = 1

# string 
perf $ perf trace -e renameat2 -- mv /tmp/f1 /tmp/f2
     0.024 ( 0.012 ms): mv/294902 renameat2(olddfd: CWD, oldname: "/tmp/f1", newdfd: CWD, newname: "")  = 0

# buffer
perf $ perf trace -e write echo "Hikawa Sayo"
Hikawa Sayo
     0.000 ( 0.011 ms): echo/928215 write(fd: 1, buf: 0x5b292f307410, count: 12)                          = 12

after:

# struct
perf $ perf trace -e epoll_wait
     0.023 (500.128 ms): Hyprland/539 epoll_wait(epfd: 3, events: {1,102459045712424,}, maxevents: 32, timeout: 4294967295) = 1

# string 
perf $ perf trace -e renameat2 -- mv /tmp/f1 /tmp/f2
     0.039 ( 0.018 ms): mv/295046 renameat2(olddfd: CWD, oldname: "/tmp/f1", newdfd: CWD, newname: "/tmp/f2") = 0

# buffer
perf $ perf trace -e write echo "Hikawa Sayo"
Hikawa Sayo
     0.000 ( 0.013 ms): echo/929159 write(fd: 1, buf: "Hikawa Sayo\10", count: 12)                        = 12

Still debugging read-like syscalls augmentation such as read, readlinkat
and gettimeofday. The support for read-like syscalls will be added in a
separated patch.




v1:

This patch series adds augmentation feature to struct pointer, string
and buffer arguments all-in-one. It also fixes 'perf trace -p <PID>'.

With this patch series, perf trace will augment struct pointers well, it
can be applied to syscalls such as clone3, epoll_wait, write, and so on.
But unfortunately, it only collects the data once, when syscall enters.
This makes syscalls that pass a pointer in order to let it get
written, not to be augmented very well, I call them the read-like
syscalls, because it reads from the kernel, using the syscall. This
patch series only augments write-like syscalls well.

Unfortunately, there are more read-like syscalls(such as read,
readlinkat, even gettimeofday) than write-like syscalls(write, pwrite64,
epoll_wait, clone3).

Here are three test scripts that I find useful:

pwrite64
```
 #include <unistd.h>
 #include <sys/syscall.h>

int main()
{
	int i1 = 1, i2 = 2, i3 = 3, i4 = 4;
	char s1[] = "DI\0NGZ\0HE\1N", s2[] = "XUEBAO";

	while (1) {
		syscall(SYS_pwrite64, i1, s1, sizeof(s1), i2);
		sleep(1);
	}

	return 0;
}
```

epoll_wait
```
 #include <unistd.h>
 #include <sys/epoll.h>
 #include <stdlib.h>
 #include <string.h>

#define MAXEVENTS 2

int main()
{
	int i1 = 1, i2 = 2, i3 = 3, i4 = 4;
	char s1[] = "DINGZHEN", s2[] = "XUEBAO";

	struct epoll_event ee = {
		.events = 114,
		.data.ptr = NULL,
	};

	struct epoll_event *events = calloc(MAXEVENTS, sizeof(struct epoll_event));
	memcpy(events, &ee, sizeof(ee));

	while (1) {
		epoll_wait(i1, events, i2, i3);
		sleep(1);
	}

	return 0;
}
```

clone3
```
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <linux/sched.h>
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>

int main()
{
	int i1 = 1, i2 = 2, i3 = 3, i4 = 4;
	char s1[] = "DINGZHEN", s2[] = "XUEBAO";

	struct clone_args cla = {
		.flags = 1,
		.pidfd = 1,
		.child_tid = 4,
		.parent_tid = 5,
		.exit_signal = 1,
		.stack = 4,
		.stack_size = 1,
		.tls = 9,
		.set_tid = 1,
		.set_tid_size = 9,
		.cgroup = 8,
	};

	while (1) {
		syscall(SYS_clone3, &cla, i1);
		sleep(1);
	}

	return 0;
}
```

Arnaldo Carvalho de Melo (1):
  perf trace: Pass the richer 'struct syscall_arg' pointer to
    trace__btf_scnprintf()

Howard Chu (7):
  perf trace: Fix perf trace -p <PID>
  perf trace: Add trace__bpf_sys_enter_beauty_map() to prepare for
    fetching data in BPF
  perf trace: Pretty print struct data
  perf trace: Pretty print buffer data
  perf trace: Collect augmented data using BPF
  perf trace: Add --force-btf for debugging
  perf trace: Add general tests for augmented syscalls

 tools/perf/builtin-trace.c                    | 217 +++++++++++++++++-
 tools/perf/tests/shell/trace_btf_general.sh   |  67 ++++++
 tools/perf/trace/beauty/perf_event_open.c     |   2 +-
 tools/perf/trace/beauty/sockaddr.c            |   2 +-
 tools/perf/trace/beauty/timespec.c            |   2 +-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 114 ++++++++-
 tools/perf/util/evlist.c                      |   2 +-
 tools/perf/util/trace_augment.h               |   6 +
 8 files changed, 399 insertions(+), 13 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
 create mode 100644 tools/perf/util/trace_augment.h

-- 
2.45.2

