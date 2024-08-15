Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B25DF5C;
	Thu, 15 Aug 2024 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685799; cv=none; b=YECOqQpnTerMjMToTzrkaYVnQFEuQs0AJ1qrFSsema6PLjIspNVpIp19tOWgdRRIzdjfukZ5Z8Hx8RCHIgA2QmI/n0js8DWgoFiK7HpoXrAJBVIqvwJZNuA1grFvKiSdAMNv+7EFqUm0Jb9VZ09e7/uf1kbe/naA4LrhCzuPGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685799; c=relaxed/simple;
	bh=IFi8uvn52QdYmt6ggaKmxuLsi+NR6UsiUWW9c9Wzv3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmYMzTw0HBjLuDIv3Uk544qY476+UddBnacEcGu9DAFBo0BCZoxrHJMLgAQLYvkRKGAnRdR3CK2/9WZAojbEVQ/jiFEBoBEB2XrciejS6FzDjkT8W9McTB6zMgzoNEPgduqG34jmVIqosqKVUnlpg7KK6e8yPgBvzD8HKzAy+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czPd5aU0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czPd5aU0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d399da0b5so339867b3a.3;
        Wed, 14 Aug 2024 18:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685797; x=1724290597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRLKb0rmcXp13Q50D18RGznr+MFWvb7LZRgjYz1SnTw=;
        b=czPd5aU0meBeZQAxEM4OPU0UQlYr8IydB6ZYdUv1qub0uUpEDMnuTluDZn3X9PXxP6
         nK4L/FHFFsV3CW5xiv3oAy/D09m1haoaP5T60+RVhgcKJC2JZqXNxXT4PJF3tQPQXaVo
         o5J0mlgVltfJpcNsrRLdB1O49xruWmLrX7k/6tHlpQsVdk6Sbsg8+DmVWFpicqbH954I
         57NhIern2LTYrQoQsw9Py+t1aLUusf1I+b8iKWov0nAbxS1iLKc4ancK0XcHykEe33Yo
         8bDrNin6vcNzF7SZEno+AsfzJRg6+k9OWa9swHEjDtZNal+Xv/+EREPKwfmBQLPHVwSR
         TU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685797; x=1724290597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRLKb0rmcXp13Q50D18RGznr+MFWvb7LZRgjYz1SnTw=;
        b=QiV1vhts9EU+/KUzgCbVl6IHSCjizf8CUwSwUtoI6T7OwLslV8kJPFN8rJtyOnnV2n
         yGYbIa5wWsSqbUV6AjH69WNRmU2Ekt2i31m4K2wwRcsDpDQHuWjuRNo/3L7I6cRENgCc
         NYCv65n6yktYW18grmdYzleeSr84qWSXEt9BTOVnTuIxC6SLY0Qd2BkXRBAbWFTMseWa
         R5505Y0S03s5sh7InugbtcC+FRekah+85VipvxqEhz3Gs1gJSf3i5b9j+LQcptr91lCW
         wvxL5K1NeX7e4egst54ZtS3OBLFNjbvE5pxJu14FN8PRKozcqvVUKnqt7SRvbVbfJDPt
         he6w==
X-Forwarded-Encrypted: i=1; AJvYcCXpYeoSnK7adUJ2BlT4u4QXRcyoERJbpSYuWUucGwLRX+o7f9gXORZTztsKGNR6Hs11AXJEJ72p2vqa+CENy1vIt9EdzVgU6sa7D3pmRJQuChnzbwA0+Jrpyv0yytEM31hJmq5saoyx0QCuNXXcEQ==
X-Gm-Message-State: AOJu0YyrLhRkUdHpVEHSsPqQB5EdGIw7ZBE7iCNYIme6rSJjjbnbs2LQ
	5fSQBhcv/31a26wLELPApGpv7yA2JPyjNkzloEONyQpQVnYqzV7D
X-Google-Smtp-Source: AGHT+IEYscdqVdr/3O3mv1a/K8DDC6sjcHBlB/ERXE2lVwuqroRNPlBOr2hts5sggvNeNfKAzeHqHg==
X-Received: by 2002:a05:6a00:1ad1:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-712670fa392mr6674255b3a.5.1723685797228;
        Wed, 14 Aug 2024 18:36:37 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:36:36 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] perf trace: Enhanced augmentation for pointer arguments
Date: Thu, 15 Aug 2024 09:36:16 +0800
Message-ID: <20240815013626.935097-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Please save them, compile and trace them using perf trace <workload>.
Reminder: For the third script, you can't trace it with -e clone, please
use -e clone3.

Howard Chu (10):
  perf trace: Fix perf trace -p <PID>
  perf trace: Change some comments
  perf trace: Add trace__bpf_sys_enter_beauty_map() to prepare for
    fetching data in BPF
  perf trace: Add some string arguments' name in
    syscall_arg_fmt__init_array()
  perf trace: Add a new argument to trace__btf_scnprintf()
  perf trace: Pretty print struct data
  perf trace: Pretty print buffer data
  perf trace: Add pids_allowed and rename pids_filtered
  perf trace: Collect augmented data using BPF
  perf trace: Add general tests for augmented syscalls

 tools/perf/builtin-trace.c                    | 279 +++++++++++++++++-
 tools/perf/tests/shell/trace_btf_general.sh   |  59 ++++
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 153 +++++++++-
 tools/perf/util/evlist.c                      |  14 +-
 tools/perf/util/evlist.h                      |   1 +
 tools/perf/util/trace_augment.h               |   6 +
 6 files changed, 492 insertions(+), 20 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
 create mode 100644 tools/perf/util/trace_augment.h

-- 
2.45.2

