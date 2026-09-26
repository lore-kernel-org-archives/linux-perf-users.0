Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318D39A040
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449500; cv=none; b=C+wZisTjS8zEC4FcmIp7zzsksUm8qu70b+6p59QXRoQ2S+8YOUtFJwn3Hz6vu8c7A0/N3BCeQb35BHIakwI47CDeBLljjLBiFraCXqrSE78rFw8YL7EEKB+5gogJYEcHUpv4S0WdXeGSosreM1HAsCZcrji8JKoJ8FFH8lC1KXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449500; c=relaxed/simple;
	bh=RX4nwyELfmwIRjg1MBxOEtabF7Q1HWgtEeAld58J4Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1RJ20BSPEGLP1+EcOdsbZMdTjlWXqxEc6rN93mBkZWkvsfBOj+GRXuNS/+B6OfEd0h0YHsgv5lnAO1lv4ZQDMFFrqm2HdGOUObzIyBt/BeW1N/lsKghENvFk1qWLhtYl0BGWAEfubym14I6OnJ/O269ebMkW9KLnf9r2Qt+9ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+pw6yDk; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+pw6yDk"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso16835245e9.3
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 12:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790449497; x=1791054297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5iTVzENHmH8E+tGDDLg1C5DZkkVqVy4ul1lxizkFIDs=;
        b=U+pw6yDkmxqg0HTQ/elWELON/stDYemNxdZ/r+Jnr8xdhudh6XRnoZqO1GdG+EI9r+
         +OmsmuWle966l2PGrSKZyTRo2MvUXHAz6n+XLCFJbrZjxVnzaQ0BPrnYa+nsjrRCZRIp
         yVC5j+kMYF88ojjESAshxDyXK6EZihLwrEWfbWoyiTzIcxolU1FkNSJwxwbjF98tFHhi
         eerrqIDUNb9VKB5na18Yp17UX+vi3KJapXTafj7fXqNwXz47JJBKinVcdz0ZLcqpfLnB
         UBu5srt3aiQgV1S4zpsGVn67frV2CK4hw/nqA++SHpRhgXWmsp7pct5JZOQAZthXW6C8
         M8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790449497; x=1791054297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5iTVzENHmH8E+tGDDLg1C5DZkkVqVy4ul1lxizkFIDs=;
        b=bW/hIVi7NCDFqEhR6KJPlA/TVHmFCqRZGK6sGEc0dIDovHBOvNoA7Qy4wtxTgmIbLx
         ssFRkAueYjbIpM9QmxveMN4B247GMnoqAUhNpBipeSi6AP6mMBhXI0fMjEr/5QgPztsW
         B+OIHY/vUtUQJnHQnlprLrriVWcGOG78V+xmDGkTiB3UGdataZZ/tat9Go5cTECOYSx8
         kM76SPE9F8ej2QAVsltURYE1KV5eTMaB6mwusbZjPYWX2V8M1Tjc2XzXSU/fnG95AWIM
         HYCbraqSWZLRFZxp0GkSKn2o7d60v7vUv/xmoou4eepUAY/00EE+E0fGVoN0caKhnt2+
         yzFQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2KGDOMCqtVZOt0QP66lzD4ZzFLwMZmSyTaIr4jWyh32z5kLuB6T2cJp41jS/1bE6KWPoD5iz22TSMEJ6neD9H@vger.kernel.org
X-Gm-Message-State: AFuF++mPYiphcBokkfLYSbtoadtz4fyrKwXgk0EMocEaRfTUMdDeFYmf
	l71+K/PTZ5UYkHZHGCSsZrOfyumDpEGHA17Cb0DpcQU43nOwK1mG5Wq0
X-Gm-Gg: AYBFou0rI+TH8Az57eCiKp4Frdo+eQuanuieoi77VBiI8sXJ2cw6GSHi8ZFuMzBhYxq
	vPQs2WldDxgbMRiI33DovaUGDuTzPdtu4bzbd8IOoV2hKBrOKpywWow89vuZvFc20nX+RF65/k4
	kzXNMAhUv+10m47XBIy77tHEXAQFmcUKctmPOjlVGdYh+hNpqZ+f3njCIgpnWhMThs4Ns/Qx4KW
	GaZGxQOCSzM7IzBOg1HDDGhlbt6pZsfGyl3Z+knpXU8XZxSGyLDskangE+p02pjz0S5S1h5Nt9t
	bPfn3nahmWGE1UzyBmNPBfJMYwArtE1lxdjVi9wgZP3EaR4APo6HJgt+WnxKcOd0ZWGPmV+DChG
	Ffsw8EvHijwXf5nOwMA/UU8mrgTZBCnhVOJLy6XQ3wX9yUvZ54jdx4k7iWBwPcaRWkFnhR1u7TX
	o4xqael+6z+G6JA5pu+dhLkidDLbH4LvGC7PIm+TAH3ohVhsn3HCGCPcnuXwjEUM1JkOVstEAdh
	LG2UOvY6DuBgRnYctIn6yrkHaowuKUJ2U+cBaCFgfY0YK6NvWJi3je8lBfa/UlrzG/FEW2Maqqt
	4Fn0T8t9WnnTn607AsnP/TNOamdh6j+7txryW883hwi7eVR6uB4=
X-Received: by 2002:a05:600c:3e06:b0:49f:f099:6f9b with SMTP id 5b1f17b1804b1-49ff0997088mr95131405e9.13.1790449496675;
        Sat, 26 Sep 2026 12:04:56 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm15216880f8f.9.2026.09.26.12.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:04:56 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 6/8] perf bench futex: Use a 64-bit operation counter in hash and lock-pi
Date: Sat, 26 Sep 2026 20:04:05 +0100
Message-ID: <20260926190407.1106421-7-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926190407.1106421-1-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-thread operation counters in 'futex hash' and 'futex lock-pi'
are unsigned longs, which could overflow on 32-bit systems. Use u64
instead.

Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/bench/futex-hash.c    | 6 +++---
 tools/perf/bench/futex-lock-pi.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 710c253cfe17..e18d98664d27 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -46,7 +46,7 @@ struct worker {
 	int tid;
 	u_int32_t *futex;
 	pthread_t thread;
-	unsigned long ops;
+	u64 ops;
 };
 
 static struct bench_futex_parameters params = {
@@ -76,7 +76,7 @@ static void *workerfn(void *arg)
 	int ret;
 	struct worker *w = (struct worker *) arg;
 	unsigned int i;
-	unsigned long ops = w->ops; /* avoid cacheline bouncing */
+	u64 ops = w->ops; /* avoid cacheline bouncing */
 
 	mutex_lock(&thread_lock);
 	threads_starting--;
@@ -238,7 +238,7 @@ int bench_futex_hash(int argc, const char **argv)
 
 	for (i = 0; i < params.nthreads; i++) {
 		unsigned long t = runtime_us ?
-			(u64)worker[i].ops * USEC_PER_SEC / runtime_us : 0;
+			worker[i].ops * USEC_PER_SEC / runtime_us : 0;
 		update_stats(&throughput_stats, t);
 		if (!params.silent) {
 			if (params.nfutexes == 1)
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 7190f5102e09..8016a31b198d 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -29,7 +29,7 @@ struct worker {
 	int tid;
 	u_int32_t *futex;
 	pthread_t thread;
-	unsigned long ops;
+	u64 ops;
 };
 
 static u_int32_t global_futex = 0;
@@ -86,7 +86,7 @@ static void toggle_done(int sig __maybe_unused,
 static void *workerfn(void *arg)
 {
 	struct worker *w = (struct worker *) arg;
-	unsigned long ops = w->ops;
+	u64 ops = w->ops;
 
 	mutex_lock(&thread_lock);
 	threads_starting--;
@@ -239,7 +239,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 
 	for (i = 0; i < params.nthreads; i++) {
 		unsigned long t = runtime_us ?
-			(u64)worker[i].ops * USEC_PER_SEC / runtime_us : 0;
+			worker[i].ops * USEC_PER_SEC / runtime_us : 0;
 
 		update_stats(&throughput_stats, t);
 		if (!params.silent)
-- 
2.43.0

