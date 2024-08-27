Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693211C5795
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770302; cv=none; b=pUYhOxG0ViiY5UO/sU0w9em1oy1llol/urJViqaPaIntUs52S9osPT4KNGsqf3JYN1wOqH+P+3sAPvlpf2wGD0mSHM04nMAyAdK+DVgLzV6ze5FQj6Pb7Q6iPAFxFLK9XQjvtOBZKs83K/cgCsAquHavIwo3MnavFJx/hkQZk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770302; c=relaxed/simple;
	bh=gC60MF3wJBkqk2ofUma6GBNFVbeoVIxqEgaTfAzTt1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lj91izV9S4tkGU1yHboc7vVx1eqrg6lsPA0n82V3ZLtEXu+9YTY311QpPXgf1UOhmSgzpQzFmonpSlGbTSDW78u9WQOlGzzPB04q82kLIUJxJdI6YOCRZi8hPbrCPBOB1vM0uBbufcWFelbp6TLFO3p4tU2V+ypJHLI5fbmvqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bEsYdFrG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEsYdFrG"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa086b077so501857566b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724770299; x=1725375099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6O7GfpMrqTz0lBd8UHCZ0XN6KCNGlbZvNorb5xx4MUM=;
        b=bEsYdFrGzQ09F2pBTz0VGQ5vyNr9YWqnOPYzm6ltbSTDFTupH6+jwdXeihmQuVShD2
         0km4vVE/lI2+di9isEhzXWDtZAg7JdlUjCgP9GSB5eclN+PKOTQFGQHOUIcSvOGRMau+
         jpCMiJcSGh06fu0GdTI2+bCVu8OXki1gGZYhNnbs0eDf6A5K+YXl/GrEcDDCQ6GRx8k0
         D3gZgsL9tll809l+ZAKcHVjolfXssGK3b70c74s5N1xBRY9EX/ppq7lsq38LvW3Fpmny
         UFa4CLcC4vh5rCty/cZqgKjbwkXIYOmYqOVP9pRjXgNw+UY8iJoZUJ8J6EF0imXyQCDf
         MUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770299; x=1725375099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6O7GfpMrqTz0lBd8UHCZ0XN6KCNGlbZvNorb5xx4MUM=;
        b=uAm77thWYSlAwPT2PjDok+S8ot/mlqE+RJjgBlasAFwCY+jwdQJJcJGWK7Z75KcZRo
         5zhyXvlvDvpV38gzLsPmZPihExHPc1frBMnjV3c0L0ta+NiEQabjEyItjd5zeTn+qVj7
         BhvqUly+NjlAP+BFgRALaHdNJzxwYYPh1Hu+DCEpNNunC9SSkRNDoXSZA+a4/RvjoROs
         O07dlTJqjGjbEu8dn89ogtr4VzmNZgcOxGA9zXJE5+6j0FIH49xAdEFtQu7RdkazWCbk
         +Oit5wSELSaYlE2CpDd552MfvsI2eJEa7b32v2H5Z2AIeA9tCRBYU8cswW6W4mw8ob3e
         1eNA==
X-Forwarded-Encrypted: i=1; AJvYcCV5v5xNp8AZP6malFeQm+Z9v2+BYdhj8EhABcojaLRAhuV+i9lT6G4k0X4QjpFTwVYjCsXpH937259XfBPk1LFo@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHBA3ArvczkMMc2TN+XoTp96rtxkI6gedbd300NY5wc/jugG2
	kKcjon3renLaICIaFWWStivKSw2QHBWqoUznBwRlz3xCcOccNFeu1bYOd/AQNsI=
X-Google-Smtp-Source: AGHT+IGgaD4kXyKN+cc4pBxFMEALMVM9k502KHZkWzUp+EoGr7FiXWJQecknaSUi5WgoQnItfi7y7w==
X-Received: by 2002:a17:907:9496:b0:a7a:ab1a:2d64 with SMTP id a640c23a62f3a-a86a54ddc58mr922313066b.58.1724770298234;
        Tue, 27 Aug 2024 07:51:38 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e590a6f2sm117727666b.188.2024.08.27.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:51:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	will@kernel.org
Cc: peterz@infradead.org,
	James Clark <james.clark@linaro.org>,
	Al Grant <al.grant@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
Date: Tue, 27 Aug 2024 15:51:12 +0100
Message-Id: <20240827145113.1224604-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use perf_allow_kernel() for 'pa_enable' (physical addresses),
'pct_enable' (physical timestamps) and context IDs. This means that
perf_event_paranoid is now taken into account and LSM hooks can be used,
which is more consistent with other perf_event_open calls. For example
PERF_SAMPLE_PHYS_ADDR uses perf_allow_kernel() rather than just
perfmon_capable().

This also indirectly fixes the following error message which is
misleading because perf_event_paranoid is not taken into account by
perfmon_capable():

  $ perf record -e arm_spe/pa_enable/

  Error:
  Access to performance monitoring and observability operations is
  limited. Consider adjusting /proc/sys/kernel/perf_event_paranoid
  setting ...

Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes since v2:
  * Change commit message to better reflect the actual changes to all
    the options

Changes since v1:
  * Export perf_allow_kernel() instead of sysctl_perf_event_paranoid

 drivers/perf/arm_spe_pmu.c | 9 ++++-----
 include/linux/perf_event.h | 8 +-------
 kernel/events/core.c       | 9 +++++++++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9100d82bfabc..3569050f9cf3 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -41,7 +41,7 @@
 
 /*
  * Cache if the event is allowed to trace Context information.
- * This allows us to perform the check, i.e, perfmon_capable(),
+ * This allows us to perform the check, i.e, perf_allow_kernel(),
  * in the context of the event owner, once, during the event_init().
  */
 #define SPE_PMU_HW_FLAGS_CX			0x00001
@@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
 
 static void set_spe_event_has_cx(struct perf_event *event)
 {
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
 		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
 }
 
@@ -745,9 +745,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
-	if (!perfmon_capable() &&
-	    (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)))
-		return -EACCES;
+	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
+		return perf_allow_kernel(&event->attr);
 
 	return 0;
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..e336306b8c08 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1602,13 +1602,7 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline int perf_allow_kernel(struct perf_event_attr *attr)
-{
-	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
-}
+int perf_allow_kernel(struct perf_event_attr *attr);
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..ae7d63c0c593 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13351,6 +13351,15 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
 	return &event->attr;
 }
 
+int perf_allow_kernel(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
+}
+EXPORT_SYMBOL_GPL(perf_allow_kernel);
+
 /*
  * Inherit an event from parent task to child task.
  *
-- 
2.34.1

