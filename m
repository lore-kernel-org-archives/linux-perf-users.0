Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B818A943
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271583; cv=none; b=pXM00BgFFM89IZNNvX2c/XlxHF1MLfD7AK6h8XfDVCKYN7s/1kulP6X3GWlCJoKY9eYss98Zh/x2WL0EVdv2W/Q4pwTXVVDd9aiv87/6jOEaX6XbJikEOqnbLF/n4CdSH7k5wCX3Z++PptV9LAGD/0PNQZJIl+4i9JvyTNzeBXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271583; c=relaxed/simple;
	bh=vcEzXouSW5qhs+WKWJ6j7BThr5Umszy0VJSt4R3KWXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNzG/7TxYJ53cm/Ms9+JVvVmHMhPOTvuDOdGWsV8roJL0ZK5UypFs9KatcvP8WE30ykREaAiMEoBJ2k/NZyH/Vy/HfQZDbA11VPiBLvYFchKy//Df4dQed8IVy5ZxTkBwpL3bMj8/3Z15JisQ38u8NjaYdJMvSk1fg36QjSyTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P6zz1nS1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P6zz1nS1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc4fccdd78so20572725ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722271580; x=1722876380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BW7CGRA85beDZYynJOG3K+o2YMpxrF+HMxsvS/Z8BLI=;
        b=P6zz1nS1Qk6Oh+bA2gtESUKV0MFqo0sGW6ESrThezO3r8j2MjGd+lofOCCGbUF/dwa
         ETo0w5q6T8iRFn1kZjwph9A9dd4ODJ377xXiXrNxF6j5A1Y0xhUMbmtk+SQpHIqRxy/0
         CUQPgYPdFIV4biOdmMyPOHS9GkVyWCH6C7nF52tuLAr/PmD05i8MCg1HBxXb0+67xmBL
         HcGtAMzRYcDVmPkJ76hwO+EEWH4vSJrr1fcvQOZ6PXkzBu0v10ZEtNikGmpks0h9b49H
         HfQjfDzuBOZlXUaPkR716dz/Y/KrQeVj0M+052DE/a3E9YWmxoaSpGBUbSghCmnYXVsY
         U9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271580; x=1722876380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW7CGRA85beDZYynJOG3K+o2YMpxrF+HMxsvS/Z8BLI=;
        b=FlbwQ4jK+fVGTbYtQ8a/Khb7jDMGfMaYB7D79E3mzPFQiLLRUUWAgcgc/bhCMGOrbv
         k1rNCpZiBj/MY9HKewEux1o+IDJeG0E9/1o97ykYx6LKS4QMl6ZwW4d9CDu4W/CnqpL9
         PIQ70ukAcnBAW3Fj1W/txxZK4U0bK017ZC1ZPeEx4ftBDizZR1h7ruy+fkWzRRxt1jxd
         8SLSBvOSUa89rUZlnb60py26GWyp/S8d5/v7caVyfr6oFpx8kYplKCr0ObsswmtcCXp8
         K9gyy2y4aqt/Bnssf7U97hqAYHaFAenRu7vopnzPQmMwI4fOdM8VARYefDrzwWuNQEwl
         sL/A==
X-Gm-Message-State: AOJu0YzRgb8N9XM4Orycj5UQjsoYyWMkpaxKrEzBxRbnkMwxD6t+zVjG
	Jp8QfMj9FIUxmLPoano70lVsqvGuz6fTDpo3ukM9XeqWEXF6Ra8eSxR8bHzd7KA=
X-Google-Smtp-Source: AGHT+IGT68p/2k5fQAsQJYVblnXyBTkymlHklXNAKKlhKSCjLI+wrBNoURLMQpu2s75WaRqmrTJs/A==
X-Received: by 2002:a17:903:4298:b0:1fd:3cf9:c7d1 with SMTP id d9443c01a7336-1ff0482be69mr57426615ad.19.1722271579966;
        Mon, 29 Jul 2024 09:46:19 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d401c6sm85480545ad.117.2024.07.29.09.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:46:19 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 26 Jul 2024 22:29:38 -0700
Subject: [PATCH v2 8/8] libperf test: Add test_stat_overflow_event()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-overflow_check_libperf-v2-8-7d154dcf6bea@rivosinc.com>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
In-Reply-To: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Shunsuke Nakamura <nakamura.shun@fujitsu.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722271564; l=7556;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=NX8BD2CX09iOEogiAZJc+2h9Y+GaCDx2QBL9DE7jL6c=;
 b=vj4XrZPx2rKNLrg7qQ9zQkLdR+6nTeAcc3FVWqgcDvl00wCiU8f0eW84vn9pbovF0dF0LBn7o
 BXCM/LpaJu1DMdDywG4WOfEvQVKgPjHU1FyIEX12mh4eKyAnU8EZExi
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Add a test to check overflowed events.

Committer testing:

  $ sudo make tests -C ./tools/lib/perf V=1
  make: Entering directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=. obj=libperf
  make -C /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/api/ O= libapi.a
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./fd obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./fs obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=. obj=tests
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./tests obj=tests
  running static:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  Event  0 -- overflow flag = 0x1, POLL_HUP = 1, other signal event = 0
  Event  1 -- overflow flag = 0x2, POLL_HUP = 1, other signal event = 0
  Event  2 -- overflow flag = 0x4, POLL_HUP = 1, other signal event = 0
  Event  3 -- overflow flag = 0x8, POLL_HUP = 1, other signal event = 0
  OK
  - running tests/test-evsel.c...

  <SNIP>

  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  Event  0 -- overflow flag = 0x1, POLL_HUP = 1, other signal event = 0
  Event  1 -- overflow flag = 0x2, POLL_HUP = 1, other signal event = 0
  Event  2 -- overflow flag = 0x4, POLL_HUP = 1, other signal event = 0
  Event  3 -- overflow flag = 0x8, POLL_HUP = 1, other signal event = 0
  OK
  - running tests/test-evsel.c...

  <SNIP>

  OK
  make: Leaving directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/lib/perf/tests/test-evlist.c | 111 +++++++++++++++++++++++++++++++++++++
 tools/lib/perf/tests/test-evsel.c  |  20 +++----
 2 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index 3a833f0349d3..7bfceb8e0c66 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -5,6 +5,8 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
 #include <linux/perf_event.h>
 #include <linux/limits.h>
 #include <sys/types.h>
@@ -24,6 +26,13 @@
 #define EVENT_NUM 15
 #define WAIT_COUNT 100000000UL
 
+static unsigned int overflow_flag;
+static struct signal_counts {
+	int hup;
+	int others;
+} sig_count;
+static struct perf_evlist *s_evlist;
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -570,6 +579,107 @@ static int test_stat_multiplexing(void)
 	return 0;
 }
 
+static void sig_handler(int signo, siginfo_t *info, void *uc)
+{
+	struct perf_evsel *evsel;
+	int i = 0;
+
+	perf_evlist__for_each_evsel(s_evlist, evsel) {
+		if (perf_evsel__has_fd(evsel, info->si_fd)) {
+			if (info->si_code == POLL_HUP)
+				sig_count.hup++;
+			else
+				sig_count.others++;
+
+			overflow_flag = (1U << i);
+			return;
+		}
+		i++;
+	}
+
+	__T_VERBOSE("Failed to get fd of overflowed event");
+}
+
+static int test_stat_overflow_event(void)
+{
+	static struct sigaction sigact;
+
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_SOFTWARE,
+		.config		= PERF_COUNT_SW_CPU_CLOCK,
+		.sample_type	= PERF_SAMPLE_PERIOD,
+		.sample_period	= 100000,
+		.disabled	= 1,
+	};
+	int err, i, event_num = 4;
+
+	LIBPERF_OPTS(perf_evsel_open_opts, opts,
+		     .open_flags	= PERF_FLAG_FD_CLOEXEC,
+		     .fcntl_flags	= (O_RDWR | O_NONBLOCK | O_ASYNC),
+		     .signal		= SIGRTMIN + 1,
+		     .owner_type	= F_OWNER_PID,
+		     .sigact		= &sigact);
+
+	/* setup signal handler */
+	memset(&sigact, 0, sizeof(struct sigaction));
+	sigact.sa_sigaction = (void *)sig_handler;
+	sigact.sa_flags = SA_SIGINFO;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	s_evlist = perf_evlist__new();
+	__T("failed to create evlist", s_evlist);
+
+	for (i = 0; i < event_num; i++) {
+		evsel = perf_evsel__new(&attr);
+		__T("failed to create evsel", evsel);
+
+		perf_evlist__add(s_evlist, evsel);
+	}
+
+	perf_evlist__set_maps(s_evlist, NULL, threads);
+
+	err = perf_evlist__open_opts(s_evlist, &opts);
+	__T("failed to open evlist", err == 0);
+
+	i = 0;
+	perf_evlist__for_each_evsel(s_evlist, evsel) {
+		volatile unsigned int wait_count = WAIT_COUNT;
+
+		overflow_flag = 0;
+		sig_count.hup = 0;
+		sig_count.others = 0;
+
+		err = perf_evsel__refresh(evsel, 1);
+		__T("failed to refresh evsel", err == 0);
+
+		while (wait_count--)
+			;
+
+		__T_VERBOSE("Event %2d -- overflow flag = %#x, ",
+			    i, overflow_flag);
+		__T_VERBOSE("POLL_HUP = %d, other signal event = %d\n",
+			    sig_count.hup, sig_count.others);
+
+		__T("unexpected event overflow detected", overflow_flag && (1U << i));
+		__T("unexpected signal event detected",
+		    sig_count.hup == 1 && sig_count.others == 0);
+
+		i++;
+	}
+
+	perf_evlist__close(s_evlist);
+	perf_evlist__delete(s_evlist);
+	perf_thread_map__put(threads);
+
+	return 0;
+}
+
 int test_evlist(int argc, char **argv)
 {
 	__T_START;
@@ -582,6 +692,7 @@ int test_evlist(int argc, char **argv)
 	test_mmap_thread();
 	test_mmap_cpus();
 	test_stat_multiplexing();
+	test_stat_overflow_event();
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index b27dd65f2ec9..56f4ae20e922 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -15,7 +15,7 @@
 #include <internal/tests.h>
 #include "tests.h"
 
-#define WAIT_COUNT 10000000UL
+#define WAIT_COUNT 100000000UL
 static struct signal_counts {
 	int in;
 	int hup;
@@ -380,7 +380,7 @@ static void sig_handler(int signo, siginfo_t *info, void *uc)
 
 static int test_stat_overflow(int owner)
 {
-	static struct sigaction sig;
+	static struct sigaction sigact;
 	u64 period = 1000000;
 	int overflow_limit = 3;
 
@@ -396,16 +396,16 @@ static int test_stat_overflow(int owner)
 	int err = 0, i;
 
 	LIBPERF_OPTS(perf_evsel_open_opts, opts,
-		     .open_flags = PERF_FLAG_FD_CLOEXEC,
-		     .flags	 = (O_RDWR | O_NONBLOCK | O_ASYNC),
-		     .signal	 = SIGRTMIN + 1,
-		     .owner_type = owner,
-		     .sig	 = &sig);
+		     .open_flags	= PERF_FLAG_FD_CLOEXEC,
+		     .fcntl_flags	= (O_RDWR | O_NONBLOCK | O_ASYNC),
+		     .signal		= SIGRTMIN + 1,
+		     .owner_type	= owner,
+		     .sigact		= &sigact);
 
 	/* setup signal handler */
-	memset(&sig, 0, sizeof(struct sigaction));
-	sig.sa_sigaction = (void *)sig_handler;
-	sig.sa_flags = SA_SIGINFO;
+	memset(&sigact, 0, sizeof(struct sigaction));
+	sigact.sa_sigaction = (void *)sig_handler;
+	sigact.sa_flags = SA_SIGINFO;
 
 	threads = perf_thread_map__new_dummy();
 	__T("failed to create threads", threads);

-- 
2.44.0

