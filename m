Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72511233955
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438672; cv=none; b=dsqMMa9ihKIQ+A8M7JeWGaTM5QcZC9niSmkProhFaRStbgF/gG3KqutP7P3L83yHqAxky/Mju1ACg/8L9QIgNfXVNPm4gEKZSD13Wqgbx+OEuRW55/vR2R+9NVr/HTWJxrrJ434pIOiF0VEGohxdlahakYYZER1RHf6Te9ddVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438672; c=relaxed/simple;
	bh=UDhBcy8UopcmOudo5nCjj/OcYUEQq4tOCj1qE7hb+1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u0E+avcdQEwFow3zJR+rS9nmm8HOSiS5RxiK90MJahtYzho8CWSbYtFOVAXM9VkJwAnQdw6T+47e8ityU/Flj5Q725z73mpCHpZ5z+O3g07bya5KGsCkEvH3rJM8W7W7afS9z1vwe2eYOdioLyVjHLZWPlOZiwEjZ278vc6vLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAgekMlu; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAgekMlu"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2cc8ed77bbcso19725045ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jul 2026 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783438671; x=1784043471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jUE12U0ZtKD/R5fHUWrML9k5S58+wFk0Rczl2WIByXA=;
        b=gAgekMluZj/wE/g1fU9tIr7iQCfzDSbPP5M2mZfYA8w8tPOH4oXj7LaGFpCAKkE+9o
         BlucJc55IifKsER+YRbYCD+cYZqqKsAg1tD0oBeekTr0I+NfThOylsLh1JaVNGSoAy0p
         GOq5LiH1kXcUvMntyqsnnmENR6jOxjPWQEggEiF/9p/2xAiQkH5vV1pAT6eo93dRAmlS
         W72xmQUCjfXAarZnxQ6bv78O8PRqzmS/ZCNO4x1lepWfd4WcnSxpM/m9ez/UGx/qu525
         Lj8zAGIzJZJ6qRD+4Ap+m6MoOp16t5f48nqIfev92dZc11GohdHTL9ZH3qhv4oItItJ4
         b3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438671; x=1784043471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUE12U0ZtKD/R5fHUWrML9k5S58+wFk0Rczl2WIByXA=;
        b=AGz+QOlt8oCvhs//GVdbVEAOKFcAgSIfsNinGum21WojSHosUTW/CMn+yybjE4ohyR
         IHmP6ABsi7AitZKcyRpFQ2N8WmIi0qh4NpcKLcTfdde4yuKmgzzJCY0ecgTHNpS61xfG
         NKixAWoGDhLPoW401livzwasfHsGVz6i8tmVZzniQDgktpvkjMbn2tix3AS0MGvxVypy
         9sW80hC5HgU/f0IdWvPXRQm/vIN53PNlRGFeF8rNEeJe/8AJs6AXpH+SZK6OMW98wUAb
         yL6aQTF1+ECs1ZgIIChe/541BqmjBCmAyX/4jkxwHae56rOdB6iC559m9SGIfGRODweE
         Ru2g==
X-Gm-Message-State: AOJu0YziykRapfoQwesQdZd7S9ZFh7hKaxmSWFFaDgi/JAAIfxiLjpY4
	zrir4VYyOeaG4WchLVGAA9Lnc9C0w4daAiFcVEM+bqRF166ZpEAZGYS3UaDsxrBkwng=
X-Gm-Gg: AfdE7cmKCkk3OVPSUxiPVUA06g5cW5UDZiH1t+llMbF06BjAeZWWDy2vkjeaCHu1SA+
	P8b/tU/jrchmPQclBf6Izn4R+HM42QiDUvwlkY8NK+w56/jNHVTqCMghKb2QNNHyN90nX33gsr/
	TEJGxTNHMCboby5JtLHuym+zBDIrdUVic24FpG9/s2bcNXe5ePkT94vgV5MyfAD/SUFSFBdYIzl
	EWZ8aF1iffkvPhYw0njs2bL8RzC1zkBbUm03zktXiaCfQBdU3YqkAfXD4+4sd9h708qivgCwnew
	8TdNQAOb7SjB5hkV1tWP8CVXXUiCafNDmcEnilL9sm+ESidV/kQQkTh+rNXxGxk5UfHwRR2iFVa
	SQDFgwCb8dN+SreF+kNk9ssxnCzByPw+pO8lJX/FW07X80G5HNpYXZIAFjMfNi4vtEkuYNpKcxg
	S3DsuG7YXvpbYXGkaMS1fAE/M5
X-Received: by 2002:a17:902:dac8:b0:2ca:f20f:4c50 with SMTP id d9443c01a7336-2ccbf184f9bmr54706725ad.38.1783438670757;
        Tue, 07 Jul 2026 08:37:50 -0700 (PDT)
Received: from h74server.game.ntes ([103.126.92.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bcc0sm14130875ad.67.2026.07.07.08.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:37:50 -0700 (PDT)
From: Jiawei Sun <abyssmystery@gmail.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiawei Sun <abyssmystery@gmail.com>,
	namhyung@kernel.org,
	acme@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	james.clark@linaro.org,
	alexey.budankov@linux.intel.com
Subject: [PATCH] perf record: fix poll storm when monitored threads exit
Date: Tue,  7 Jul 2026 23:38:00 +0800
Message-Id: <20260707153801.315352-1-abyssmystery@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `perf record` samples a multi-threaded process and one of the
target threads exits during the session, perf itself may start burning
100% CPU (up to 200% across two cores) until the session ends.  A
single dead fd is sufficient to trigger this; it can be reproduced with
15 pthreads in a compute loop where one thread exits halfway through.

The root cause is two independent instances of the same defect: dead
perf_event ring-buffer fds are left in a pollfd array.  When a monitored
thread exits, the kernel closes its ring-buffer fd, which then returns
POLLHUP.  POSIX specifies that poll() always reports POLLHUP and POLLERR
regardless of the events mask, so any dead fd left in the array makes
poll() return immediately every time, spinning in a tight loop:

  3 seconds: 256,600 poll() calls, 0 context switches, only 21 write()
  Woken up count goes from ~0 to 1,300,000+

There are two affected poll paths, fixed together here:

1. Record main loop, via fdarray__filter() (tools/lib/api/fd/array.c).
   Since commit 59b4412f27f1 ("libperf: Avoid internal moving of
   fdarray fds") it only zeroes events/revents without setting fd to
   -1, so poll() keeps reporting POLLHUP for the entry.  Setting
   fd = -1 makes poll() skip it, matching the pattern already used in
   the control-fd path at tools/perf/builtin-record.c:1673.

2. BPF sideband thread, perf_evlist__poll_thread()
   (tools/perf/util/sideband_evlist.c).  This thread polls for
   PERF_RECORD_BPF_EVENT but, unlike the main record loop, never calls
   fdarray__filter() at all, so dead fds accumulate forever and it
   spins at 100% CPU:

     Before fix: dJiffies=101, wchan=0 (running)
     After fix:  dJiffies=0,   wchan=do_sys_poll (blocking)

   Fixed by calling the existing evlist__filter_pollfd() helper after
   evlist__poll(), mirroring the main record loop.  <poll.h> is
   included for the POLLERR/POLLHUP macros (previously unused there).

The two fixes compose: fix 1 makes poll() ignore dead fds (fd=-1); fix
2 ensures the sideband thread actually performs the filtering.  Both
paths are affected in all kernels from v5.1/v5.9 to the current master
(7.2-rc1); the source of both functions is byte-identical across them.

BPF event recording is preserved: after the fix, perf.data still
contains PERF_RECORD_BPF_EVENT records and bpf_prog_info entries.

Verified on perf 6.1.76, 6.6.143 and 7.2-rc1 with a minimal reproducer
(Woken up 1,300,000 -> 3, CPU 100% -> 0%) and an A/B orthogonal test:
keeping the unpatched binary but preventing the target thread from
exiting also makes the storm disappear, confirming the trigger.

Fixes: 59b4412f27f1 ("libperf: Avoid internal moving of fdarray fds")
Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
Signed-off-by: Jiawei Sun <abyssmystery@gmail.com>
---
 tools/lib/api/fd/array.c          |  6 ++++++
 tools/perf/util/sideband_evlist.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index f0f195207..ffe8272af 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -122,6 +122,12 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			if (entry_destructor)
 				entry_destructor(fda, fd, arg);
 
+			/*
+			 * Set fd to -1 so poll() ignores this entry; otherwise
+			 * POLLHUP/POLLERR are still reported for events=0 fds
+			 * (POSIX: always checked), causing a poll storm.
+			 */
+			fda->entries[fd].fd = -1;
 			fda->entries[fd].revents = fda->entries[fd].events = 0;
 			continue;
 		}
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
index c07dacf3c..ba043db6c 100644
--- a/tools/perf/util/sideband_evlist.c
+++ b/tools/perf/util/sideband_evlist.c
@@ -8,6 +8,7 @@
 #include <perf/mmap.h>
 #include <linux/perf_event.h>
 #include <limits.h>
+#include <poll.h>
 #include <pthread.h>
 #include <sched.h>
 #include <stdbool.h>
@@ -55,6 +56,19 @@ static void *perf_evlist__poll_thread(void *arg)
 		if (!draining)
 			evlist__poll(evlist, 1000);
 
+		/*
+		 * When a thread of the monitored target exits, its per-cpu
+		 * ring-buffer fd is closed and starts returning POLLHUP. Such
+		 * dead fds are never requested for POLLIN, but poll() reports
+		 * POLLHUP/POLLERR unconditionally, so leaving them in the
+		 * pollfd array makes the following evlist__poll() return
+		 * immediately forever, spinning this thread at 100% CPU.
+		 *
+		 * Filter them out here, mirroring what the 'perf record' main
+		 * loop does after fdarray__poll().
+		 */
+		evlist__filter_pollfd(evlist, POLLERR | POLLHUP);
+
 		for (i = 0; i < evlist__core(evlist)->nr_mmaps; i++) {
 			struct mmap *map = &evlist__mmap(evlist)[i];
 			union perf_event *event;
-- 
2.39.5

