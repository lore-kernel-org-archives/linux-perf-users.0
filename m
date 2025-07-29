Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40627A46E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776802; cv=none; b=H8j82r1JvyXUAKvU2V2VoNGZ0Fy1kGgpHXzlhl88leHsbdq0jWTwZ2GBlv9Lh8CUXMnKN4z3F4Fe/vmlPUkxJLP0w+2ACunT7E2p4dxe18yeITJNDPRKSo32dIgNRMB78mHVpUzQ0Et1kUF7zkG3fkxwfua2/jSYynwJSUTHQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776802; c=relaxed/simple;
	bh=71gbI6OjDsDmEknBgmdcYUx3bHKLr6/JDNXFwhVg5xw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PXGrfUzz/6nwluHSuL7HMrPEll5OJAuObejECm6cdqJGLAgZlTiISREwLeE6zrLPHTRF46Dkp/X2eebGv8Axs5+WnhCGOxem0/okta9jejSr4rTJuBXCr+W4cLlgxlYQ15k+rXGIm2QokSWvAFqGBxqyD0i03NKF1ZetCTyEbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDFxErFO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDFxErFO"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3928ad6176so4872155a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753776800; x=1754381600; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pppra4qoUIASFj11vi7hdy6H5kU0GOjurpfaQQiON1E=;
        b=LDFxErFOuHwrAncmaLwtHbes4xPbjsjnlvjUHgFZB341VYtf2eDNWNlCbGadsl91sS
         utEC4I94hswOW/2z9e4w7/hJlwegij1gxKdNiacSWM7nHv22ObHpN2ibeQbo85y1cYV+
         Tp7t30AOPleQ/Rwh5LK3NJYMx0PU5ahqTbDhBQNBhAvs4jFwm7Pu7hT3Bey9MoYCgP6Y
         meBmwWqwC70tus9NM/LDWYLtfTeiqi63WPk73cdRaDRVAeT6+6p49xvoj51nNbG1WTv2
         /os/vkLQ/cFClBjaKKrW8PpCT4PkeDp5qPYH35VrbGLAj/yelXl3r+Y26GQ5QYUpCqtm
         4epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753776800; x=1754381600;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pppra4qoUIASFj11vi7hdy6H5kU0GOjurpfaQQiON1E=;
        b=FrR2KdW2iySNgmR3gvt2+rukKALS7ZmW89K/aXUAr5yiKFPE/7jR2kHmUakzT/xpy0
         juMmPCx3yBbpJeXKnFLX/9hXf5NGtQ5JqfQiAJh5DI542awTF8FzsoXGggJBdnS4QBWk
         zB1tjhelfLZC8Lm78JRqK8Q2NJ/LJOdV4vo2klbwjSl6andssPtrL9egyFuSK+NB9TQk
         4R/5JeoUP8sUONXv7tLLpnUjkeIDj4BpaCFbXmuMKnGQS/hf+TXe56s5b7ASRnNbIIKS
         bGrnNhUr5hg5Jc5EckuQ5fIsyF6og54C5d2bMZIAUzt60ix7y30jkpLCGLjyup8ZOVks
         2Y1g==
X-Forwarded-Encrypted: i=1; AJvYcCVfoKf6jcXqUeF3SEBSnsx7qMAIBazFeWjrwV7x7sm78JeERkSJPjII17CGCBiSNbStT4O2lqwYMqXv90E3x+1Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbDNJIj/KPjvBReIaw8U3MTObOpwqhPxHl6Cj7Bl8ww6eSS0x
	N21iNrYC52qwWmwY2Rc1At3yIM1YjmACb3EojmD2n0lfz6A36v75a5+2bBj1rID+p5rIiax7gP9
	5mzu39g==
X-Google-Smtp-Source: AGHT+IEfcbCRh+gitWFUzwBX0TsCAZa6VaftFKxPs2lYtcqrCg750iVws+VPQQvAfHwiipfHwgOZPPrL9vU=
X-Received: from pfbfh5.prod.google.com ([2002:a05:6a00:3905:b0:749:d28:4ca2])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1a:b0:21f:4ecc:11ab
 with SMTP id adf61e73a8af0-23d6ffdc7bemr23243429637.9.1753776800054; Tue, 29
 Jul 2025 01:13:20 -0700 (PDT)
Date: Tue, 29 Jul 2025 01:12:56 -0700
In-Reply-To: <20250729081256.3433892-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729081256.3433892-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729081256.3433892-4-yuzhuo@google.com>
Subject: [PATCH v1 3/3] perf bench: Add 'bench sync ticket' subcommand
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yuzhuo Jing <yzj@umich.edu>, Yuzhuo Jing <yuzhuo@google.com>, 
	Guo Ren <guoren@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Benchmark kernel ticket spinlock implementation in user space.

In resolution of arch_spin_* redefinition conflicts due to importing
qspinlock and ticket spinlock together, the sync.c defines
__no_arch_spinlock_redefine, following the usage in
arch/riscv/include/asm/spinlock.h.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/bench.h   |  1 +
 tools/perf/bench/sync.c    | 17 +++++++++++++++++
 tools/perf/builtin-bench.c |  1 +
 3 files changed, 19 insertions(+)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index dd6c8b6126d3..42c0696b05fb 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -23,6 +23,7 @@ int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_sched_seccomp_notify(int argc, const char **argv);
 int bench_sync_qspinlock(int argc, const char **argv);
+int bench_sync_ticket(int argc, const char **argv);
 int bench_syscall_basic(int argc, const char **argv);
 int bench_syscall_getpgid(int argc, const char **argv);
 int bench_syscall_fork(int argc, const char **argv);
diff --git a/tools/perf/bench/sync.c b/tools/perf/bench/sync.c
index c85e9853c72a..581835451e5f 100644
--- a/tools/perf/bench/sync.c
+++ b/tools/perf/bench/sync.c
@@ -17,7 +17,9 @@
 #include "bench.h"
 #include "../util/tsc.h"
 
+#define __no_arch_spinlock_redefine
 #include "include/qspinlock.h"
+#include "include/ticket_spinlock.h"
 
 #define NS 1000000000ull
 #define CACHELINE_SIZE 64
@@ -67,6 +69,7 @@ static const struct option options[] = {
 
 static const char *const bench_sync_usage[] = {
 	"perf bench sync qspinlock <options>",
+	"perf bench sync ticket <options>",
 	NULL
 };
 
@@ -106,6 +109,20 @@ int bench_sync_qspinlock(int argc, const char **argv)
 	return bench_sync_lock_generic(&ops, argc, argv);
 }
 
+/*
+ * Benchmark of linux kernel ticket spinlock in user land.
+ */
+int bench_sync_ticket(int argc, const char **argv)
+{
+	arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
+	struct lock_ops ops = {
+		.lock = (lock_fn)ticket_spin_lock,
+		.unlock = (lock_fn)ticket_spin_unlock,
+		.data = &lock,
+	};
+	return bench_sync_lock_generic(&ops, argc, argv);
+}
+
 /*
  * A busy loop to acquire and release the given lock N times.
  */
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index cfe6f6dc6ed4..8d945b846321 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -54,6 +54,7 @@ static struct bench sched_benchmarks[] = {
 
 static struct bench sync_benchmarks[] = {
 	{ "qspinlock",	"Benchmark for queued spinlock",		bench_sync_qspinlock	},
+	{ "ticket",	"Benchmark for ticket spinlock",		bench_sync_ticket	},
 	{ "all",	"Run all synchronization benchmarks",		NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.50.1.487.gc89ff58d15-goog

