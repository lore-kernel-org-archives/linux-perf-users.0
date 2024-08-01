Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD3D13E024
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488355; cv=none; b=QdaNgDVveO9OnE6kgYW5JJwLvY07n8e+O4U7b3/ZMrLWpxiEGl4c9SF7UNzO5bEgMVw7qwRh7Y9pYRxAFx8cO3TR04bTp/JuEcHpL2+I4zuiolJKMrswzPjKaQhLuS9a9pnPElwC2aDl4LdX8EIHK5SRZiRkq30GFo7f5nEwupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488355; c=relaxed/simple;
	bh=EJkw76iAldXs8IDGX6eZpFuF0CjLD+JdIskJg3lIASc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DED/RaDWYeK0Y/JQ7eqyMlRhe8jPAIWWR93GGZV+jFyrN5pNQk6I++7u10GO1DIjt6ciWOwyrtbLC6dFBn6jlTpIXnPxFmdRwSu/s2k5QuTZpqp5Ko0d9KL+rAAt2xu8zWM/UUNn7aKv4FnxHuGY0N3L6A1JarazMVf0A7knttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxQLDvUF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxQLDvUF"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cfe41af75eso1032039a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488353; x=1723093153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tm5RaV+/pBsHkRX5KjcoF4je7qI2HY3dp2o/9i3k7x4=;
        b=DxQLDvUFaa+X0cD66TrFfX9wk95GXJjhNeL53k3yUzdO45UvSTkGTgTa20ICi7PyK5
         jfCIgcWlEE01pCDMCrdAqJttdb7VylGbSt170SzeabQFixCfU83Iq6J65jUZprUOw1Xo
         ZeJOamsmUU0sqHF0rFjKtmwgPJwxrLdccprfVPtUURm4OThoQ36dU5zAQKDcestg2RdM
         aoG1kW4Q0CLDxebjZD69cTxEO34xrvjOGaqESeDHx2BvdwSXkzS1DFF4fZgNEN+UCEsI
         u0LoaKu7gVq/cgMlEajKVa/SynGIhKI9prqj6sX1Ektpmre4vYOVFiO4y0pXsIeFcfvv
         o8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488353; x=1723093153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm5RaV+/pBsHkRX5KjcoF4je7qI2HY3dp2o/9i3k7x4=;
        b=aQdAhCWdUO2uhKtnEkzTgsBrKeJL6MJM7w3XcwCvSs8vcrc0Qvgod6C0XKVkuGaoux
         i4OgnWBmnzXFa9zpAmYLD1JTPaexTQDF5blHeLBzVu0GGZAwf5JYrf83FDVHnaR4N8u3
         f6eGpBN3wnoq2MIgl5arBzeXUFG+KD9E+P47FGR8HAUsySZiGQloizBOatTuPuxBTguX
         OOoH/1Vq6CyfdYBnrc9OvUL7Aw50HONSiwNV1yT1mQn+k/dCjJxRW06bb4OWs3qCca8O
         EoKc8JWky7Vs//tZdyceDLPvUsW8CO8r8gsxt7bCUxL6PtfVbvNrc8bsAzr8q2VjBa4z
         jSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1H9ZJw3/5V8JScfHPgbRNovbmHEXvrVF/8+7aBZpOMVonC71kK9c741UU1wPWrRTDUV1NiI9Af1+TFVEeaDvc5g+HCw1lPXK2ya5OkZnh1A==
X-Gm-Message-State: AOJu0YzpMW6KWHtJIjUWWMZlX0Mf1RWtU3P66vrOhvnyMT5ytB6PqY00
	eXlAp3N6DoolzQggiZhn0KcS/UbcpuEHIS0H8IPht9iUIpfiDlIxR6ITPjU6NoboFujaRD8z6Kz
	iSxbNvg==
X-Google-Smtp-Source: AGHT+IE/W6WkgcA+8Zbv/MP0qycRKD57qXfVH139pmKdChk/+QPD8tNaOz1bgp6b1YFc086V3snnnjvAtMiq
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:9c3:b0:2c8:b576:2822 with SMTP id
 98e67ed59e1d1-2cfe7ba7df8mr25621a91.8.1722488352924; Wed, 31 Jul 2024
 21:59:12 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:10 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-2-mizhang@google.com>
Subject: [RFC PATCH v3 01/58] sched/core: Move preempt_model_*() helpers from
 sched.h to preempt.h
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Move the declarations and inlined implementations of the preempt_model_*()
helpers to preempt.h so that they can be referenced in spinlock.h without
creating a potential circular dependency between spinlock.h and sched.h.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 include/linux/preempt.h | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h   | 41 -----------------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7233e9cf1bab..ce76f1a45722 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -481,4 +481,45 @@ DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
 DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+extern bool preempt_model_none(void);
+extern bool preempt_model_voluntary(void);
+extern bool preempt_model_full(void);
+
+#else
+
+static inline bool preempt_model_none(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_NONE);
+}
+static inline bool preempt_model_voluntary(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
+}
+static inline bool preempt_model_full(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT);
+}
+
+#endif
+
+static inline bool preempt_model_rt(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_RT);
+}
+
+/*
+ * Does the preemption model allow non-cooperative preemption?
+ *
+ * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
+ * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
+ * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
+ * PREEMPT_NONE model.
+ */
+static inline bool preempt_model_preemptible(void)
+{
+	return preempt_model_full() || preempt_model_rt();
+}
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6..90691d99027e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2064,47 +2064,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-extern bool preempt_model_none(void);
-extern bool preempt_model_voluntary(void);
-extern bool preempt_model_full(void);
-
-#else
-
-static inline bool preempt_model_none(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_NONE);
-}
-static inline bool preempt_model_voluntary(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
-}
-static inline bool preempt_model_full(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT);
-}
-
-#endif
-
-static inline bool preempt_model_rt(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_RT);
-}
-
-/*
- * Does the preemption model allow non-cooperative preemption?
- *
- * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
- * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
- * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
- * PREEMPT_NONE model.
- */
-static inline bool preempt_model_preemptible(void)
-{
-	return preempt_model_full() || preempt_model_rt();
-}
-
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
-- 
2.46.0.rc1.232.g9752f9e123-goog

