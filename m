Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEE22F743
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613593; cv=none; b=B3CNwqDeNz/y46wA8hSrv3m9fExrgdBqFW+dQDTmYTShB/wg8JzERWjs9z4+KqadVaOR1AJf2oR77LkVCcAJFbzbq7kmS3BbjYQPi1ayLl9p8fFDuFzGLDB+r93B9gb8BGwnuP/B1i2Y83VfMqOodY8a77Z5Pgw9XFulVVH2vd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613593; c=relaxed/simple;
	bh=AeW/Ac3QkfBwRXLWBdChkTIwfvl/5RVURnMQ1MrqODQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=L5WHwmJimN3qE1zmrQsORNbgHMsOsAcaowTz1s09ax0ZeP9Bz+3tELbzYgP7crUr4biw8TzhuT6RuoiB1nHniY/XJHrowXo0kvK6pBmKdXuZywNh25zYhHQD4qaAsd/1GrqEKkmvoTNeNVKG6PVLAbjF6NMafwyxfCgwfzdn130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUBfLsXw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUBfLsXw"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c38df7ed2so4455498a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613591; x=1750218391; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKIwovJpQlk9CWotuuE1W1NkF/IomItix7FAi+RBbSI=;
        b=zUBfLsXwqkT3mxHbO7Kw7wdkQGgjupJ1brnXvUByTwRQ0U88Il39dXV4r5aX5ZH21f
         gjwNIJhjd3q8pW3nkX6a2pXB7dRNbDz6SIKy16ywLPxDmKxnZKYIj5RvBGXIWTF5AfBk
         aVrRAeA8aMJdXGKulVvn69eC+CtANTguo/mGDiY6TP2HBQAaYdnal8GlMpgtp+0K6sUY
         1Q+CyPpwORBoNWo6+BC3FCGupYQelAHZ220eksHxL3DfR0jVJg1ulKF8OA0O7EN88rF5
         cDRtojNCq6eYGHyYt2S/p70KBooqZITYGgdaUSTbx6JDzyI1418tvPeOc76fPmaDlu1M
         6VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613591; x=1750218391;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKIwovJpQlk9CWotuuE1W1NkF/IomItix7FAi+RBbSI=;
        b=VowL36mVaxeYNLPRm5p3LuBShlFqC0PjzDcA5TwAYvfhcpbtaDweNhJu37QiRwDxIx
         WnI4qsA9csL+BjDU67ZwngWh6H988dZUB4e03n8HpaX6P81GxDLmOvMabw8vFgka0Nau
         MFDbX1z5wFvyG4WPw1iOm75m7YdXfNv9dKWrEfAbObCHkhoM78jTV6+zXa5q2GaRy2Db
         smUTGrGK5HtM0lUynU5xyjmtU2AMuiJ+MlOTAZoSEEpUAFSrRXLCgpjq7XQOeNW9LCxf
         P3fJoonrnTGLf/eE8TbGtFFVsO28QnSJklLIHb9De6Vh7zsQuB+3EAMk9MUIMogOwVqX
         gNZA==
X-Forwarded-Encrypted: i=1; AJvYcCX3R06BSvjXQurNnCGYjAzNkOhVrFzWCkVDgEOmwTsZWNa0PuVuu4gO6CVy9ccApC1tNKYxR9itXh7wA0uWSP12@vger.kernel.org
X-Gm-Message-State: AOJu0YwisGYh+5mUj6oJ9NYVdLnCy2HJr0DhnbdWh964rogfzvpEgoCF
	LQC9vqKldAAJN7DG9JGC2pXty7GwcPYqTJqRk4RJpdnyeJyrmCQ2hi5MkoyFFHWa2R2X0lXoKgt
	Vg2bLPrzLzg==
X-Google-Smtp-Source: AGHT+IGK+vMYpdAwrp3b6Chw1tzqM16m3QZB+T7XOxBulDEWavXIAXWTFa3Hp0uZuBokPGk2SQhjhRKbXTl8
X-Received: from pgnd30.prod.google.com ([2002:a63:735e:0:b0:b29:82be:c692])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6da0:b0:1f5:7007:9eb8
 with SMTP id adf61e73a8af0-21f86651052mr2489185637.16.1749613591054; Tue, 10
 Jun 2025 20:46:31 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:24 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-11-irogers@google.com>
Subject: [PATCH v1 10/15] perf pmu: Tolerate failure to read the type for
 wellknown PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If sysfs isn't mounted then we may fail to read a PMU's type. In this
situation resort to lookup of wellknown types. Only applies to
software, tracepoint and breakpoint PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 609828513f6c..4164c2278051 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1181,6 +1181,32 @@ int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name)
 	return 0;
 }
 
+static __u32 wellknown_pmu_type(const char *pmu_name)
+{
+	struct {
+		const char *pmu_name;
+		__u32 type;
+	} wellknown_pmus[] = {
+		{
+			"software",
+			PERF_TYPE_SOFTWARE
+		},
+		{
+			"tracepoint",
+			PERF_TYPE_TRACEPOINT
+		},
+		{
+			"breakpoint",
+			PERF_TYPE_BREAKPOINT
+		},
+	};
+	for (size_t i = 0; i < ARRAY_SIZE(wellknown_pmus); i++) {
+		if (!strcmp(wellknown_pmus[i].pmu_name, pmu_name))
+			return wellknown_pmus[i].type;
+	}
+	return PERF_TYPE_MAX;
+}
+
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name,
 				  bool eager_load)
 {
@@ -1200,8 +1226,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	 * that type value is successfully assigned (return 1).
 	 */
 	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &pmu->type) != 1) {
-		perf_pmu__delete(pmu);
-		return NULL;
+		/* Double check the PMU's name isn't wellknown. */
+		pmu->type = wellknown_pmu_type(name);
+		if (pmu->type == PERF_TYPE_MAX) {
+			perf_pmu__delete(pmu);
+			return NULL;
+		}
 	}
 
 	/*
-- 
2.50.0.rc0.642.g800a2b2222-goog

