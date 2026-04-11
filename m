Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F463368B7
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890706; cv=none; b=HpuA5aE4xS7zi1riGX06u5AXHuiNT2BJ2BwmPL8zeGr7hQbknmiegIQNC/rBzIWKIfoMCdLT6xjqntPoDtRAWCpvIsRraxdiLJeIlBt1X6ZNS+UwO85i+HzdKFwdFqFdFS1Gl6B1qQCb0OcaKnC7Nl5FM1n+K86msM9GMvsuqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890706; c=relaxed/simple;
	bh=moKkcKdSEu19e/q+50B07OpiehZVXQ3LLnG7Jm0vwro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lN29DeoZPdWLAMbX1sSlkzNFSEQslVRNGrdojGVA1yqwli9tzSJoPXwOmK4QtYlEY1a1997jIYTePqYxKj8jC4D7FcQpZdKQfWxjirHpK+BQmzIXt57nyIPzefPt8NjBqyuXGzkA+yMw2FnhQ8PM/LiCSaTRlct8vEyEw0azcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fONH/n1i; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fONH/n1i"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d443c3b094so5364779eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890705; x=1776495505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5sYhz+wseL1n0Ydo74NmT1c/e6l8CKceKTSKAzWJeI=;
        b=fONH/n1iu1hJ0xjtbddcMNx2drh+e5Sl0whVs+jMagwirtel+E3M8ZEPEvZZDpF4c6
         /2jkwxhPr5+nuwsExeGLgVjzTCZ75At10q/pQTuBIm6UGcrbDW4p976JcWY/l3goRq3N
         JJLR4pQ4cP92s8uzgqkQM1Hb0RlNpSrOKgBaa5DksAotsv0N4eqgTsE9NCEwlCzN1DoG
         OU02Pwz0M8Clp8qLdwkE2nIhecyGZGllQ8AHAATw89uQEhB8Q9VrhqD4P4IAfeZrfqpA
         8Gd7WuYhwGaH8UgMjzQ6lfvPOD8H0BIUcjGAZr/EB97AkBgXG+63AVnqAZhm/3gQM3Dp
         79BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890705; x=1776495505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5sYhz+wseL1n0Ydo74NmT1c/e6l8CKceKTSKAzWJeI=;
        b=ZQQ6gDPs4CmwjnLf71jeARTMM6l9KJg2pLE2RizpZYs7y5ezvIjZvJCMe3ec6IJIPk
         PDMbNZC3D39Zy3YSOH68N0thfgJ4ai0upQPru1/CIhE2FAqArHlgb4hjwFjqiHJBPSS3
         ghmRtFhM0cdu+gbwJdtqAFuaJTI6LiVpMnimPT4atFiFGiq/lifB3iYDFYzPaiR2Y8LB
         uQSZOzFXmUAZCq3E9ustj8DVzFtRGlTpF76kY/nKGzy5M5uH7eoyJ83LxePJvMdHEXAG
         SmB6T9DSryhXcUuahMTXvgRfQNnvmc0lXKbildg5pAC/NiWAtWSn+acAeCDarrgOXXjp
         suDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFF0Sj//LhaTiNX4lM40nvk6kF3Wg5sqFeyJdiqamAJ1InqiKoeUffsoaZFA6S903KggD5GpOD02O5Aa/5FKep@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1OAdo5WGbaICBoo60KNyDBuFK+D7x9t4yd7dgJWr7GpktEEQm
	q9pTl1EIA1Zp8epm67pSc40wHaB2V2Ecz1uAyy/o2L8WzGOd/Okj7vME1GfTs1nphqlJ7xt75zA
	VEGvytl143A==
X-Received: from dlbvg3.prod.google.com ([2002:a05:7022:7f03:b0:12c:195e:1f6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6725:b0:128:d219:e169
 with SMTP id a92af1059eb24-12c34ea5555mr3492770c88.10.1775890704562; Fri, 10
 Apr 2026 23:58:24 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:15 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-27-irogers@google.com>
Subject: [PATCH v8 26/29] perf timechart: Bounds check CPU
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Ensure the CPU is within expected bounds to avoid out of bound memory
accesses in arrays tracking CPU state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 64f69bd67c6b..0db2a9bd5b91 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -607,6 +607,10 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		return -1;
+	}
 	if (state == (u32)PWR_EVENT_EXIT)
 		c_state_end(tchart, cpu_id, sample->time);
 	else
@@ -622,6 +626,10 @@ process_sample_cpu_frequency(struct timechart *tchart,
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %u\n", cpu_id);
+		return -1;
+	}
 	p_state_change(tchart, cpu_id, sample->time, state);
 	return 0;
 }
@@ -662,6 +670,10 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		return -1;
+	}
 	c_state_start(cpu_id, sample->time, value);
 	return 0;
 }
@@ -683,6 +695,10 @@ process_sample_power_frequency(struct timechart *tchart,
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
 
+	if (cpu_id >= MAX_CPUS) {
+		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		return -1;
+	}
 	p_state_change(tchart, cpu_id, sample->time, value);
 	return 0;
 }
-- 
2.53.0.1213.gd9a14994de-goog

