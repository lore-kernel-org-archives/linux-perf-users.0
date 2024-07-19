Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B89208BA
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377071; cv=none; b=LFBT2hxz87zgkfnDcORXawlFLINkpLVdJATo63NwaN/VgbDgA5MSnwDe6rgYAY963emgg+iLi9LznSqOxxF2KUd/LYTr8bzBDZdRoDl6gS2LXf5ELqjeKMpUqMGLZtKLSa7TKE5ckyNm4A9todBbVr4grAKetBA11PciEytPJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377071; c=relaxed/simple;
	bh=QyvfbL1Dt9Lf/qRb/Tq/QxZnlpQmlGqWdt0glv+CBdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwhJYIv8tlSqmaFgh2QSd5E2+1fy1OkSSQn7qgFin7WwwwTkXXcxWGgKYreBPWd27qro0kxs5PWfBPNWbWaO3HdQhwMtoL9C7EZQB/t5UtqYIqiTFRi9uCNfxlA0EOomImSvylETvDMvVoVmGZSTntvx8DQbQC8bvdBqA6gQa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=d93U3cLX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d93U3cLX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc569440e1so15878435ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721377070; x=1721981870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pKe/8ymbuAK5Ax3GUIQcNZESBu/C5Eo8hDWQvxiYB0=;
        b=d93U3cLX14y0iH2BvfAI4C12yoFPYVjUpTDZpEY9aYEADlT1hwx6fmdoR8m74Wi+ai
         dLnwJ0PHem8jBa5RnjXTR6abuU3ypyDlEFPfpwSzK7hjb0owVZooE9xrWbXa1TgkWHyt
         xLbHyOKHIznMbtUbHJrz8J4C/RAFwCVsayJ87VGv0Kd4DHdlZSluwf4QUxjfh38B8QHc
         wjDdq8O8iFfSDOhcP1GwYuIz+RM448QuWY0GkugSPlGgUoa7G/wSBIQR2YI/sXRIViOh
         8eCxNKhGLmh3cKtQz8Ct5AswevT+uxcNIB6NQA9sN/Kre53AK/7amZRSEDAY4dghC/UI
         t9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721377070; x=1721981870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pKe/8ymbuAK5Ax3GUIQcNZESBu/C5Eo8hDWQvxiYB0=;
        b=PLIMbdKzQ4Is61uBHOdDFP7bDt4N7ldg6cPIuQDJRZZMDx9VYTajHplcQl8rlkY9Zo
         3oI0sDzJB2JJTJYTpSHUQv5xZlGbiHJRkoExJR6mwGo3AqHeOQT/VK++668NHSwIFT8b
         T4NbqBvgcReTDnIj99j20E8p/MrJWcoGPHCg0sZLB0Setqs+IIJQvD0MLBsJYJfC9L/S
         s8BSOl0hrYOe1ZbtfWesTWM/mJVmttBRyDmlmnQO3amloSQK8kgwxCLoxHrsX8wFv5KU
         8R45njBxdQlTE0ZHU+OLwWW7m6ezdrUUcjHtTL7adtN22V5EGMhyW9ethx2r/IBnwL0l
         c2mA==
X-Forwarded-Encrypted: i=1; AJvYcCX1wAZArDdh9UghzbBPvcRH7eptsrUftSB74BhXjDUxzPIH3Cj5TDxuu1hFLMHPjHFPkseAZyiV7cq1dngKKQvPdeHyzHuAsMK5fE710UDDYA==
X-Gm-Message-State: AOJu0YxVCw8MpFqdUnseE86o3d9TRVCUy4xbqro/LakAloiK5Ad/qbmn
	mML6Q/yhijYcAQG9qmCiQWYf/dHIQ2t179jL+IV6fQfvyTajVrz+Q2izl1j3rZo=
X-Google-Smtp-Source: AGHT+IEikfqPPIxLyXm7DyKRFHJ3A1M1Ps2TrqjIqzYPMuiDYFdEkDVoM5sL+AWzL4BN7joBqln2Eg==
X-Received: by 2002:a17:902:db07:b0:1f7:2293:1886 with SMTP id d9443c01a7336-1fc4e165dffmr72867495ad.12.1721377069552;
        Fri, 19 Jul 2024 01:17:49 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d5db43sm8442355ad.280.2024.07.19.01.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:17:49 -0700 (PDT)
From: Eric Lin <eric.lin@sifive.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	Eric Lin <eric.lin@sifive.com>
Subject: [PATCH] perf pmus: Fix duplicate events caused segfault
Date: Fri, 19 Jul 2024 16:16:51 +0800
Message-ID: <20240719081651.24853-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if vendor JSON files have two duplicate event names,
the "perf list" command will trigger a segfault.

In commit e6ff1eed3584 ("perf pmu: Lazily add JSON events"),
pmu_events_table__num_events() gets the number of JSON events
from table_pmu->num_entries, which includes duplicate events
if there are duplicate event names in the JSON files.

perf_pmu__for_each_event() adds JSON events to the pmu->alias
list and copies sevent data to the aliases array. However, the
pmu->alias list does not contain duplicate events, as
perf_pmu__new_alias() checks if the name was already created.

When sorting the alias data, if there are two duplicate events,
it causes a segfault in cmp_sevent() due to invalid aliases in
the aliases array.

To avoid such segfault caused by duplicate event names in the
JSON files, the len should be updated before sorting the aliases.

Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
Signed-off-by: Eric Lin <eric.lin@sifive.com>
---
 tools/perf/util/pmus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b9b4c5eb5002..e38c3fd4d1ff 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -443,7 +443,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 {
 	struct perf_pmu *pmu;
 	int printed = 0;
-	int len;
+	size_t len, j;
 	struct sevent *aliases;
 	struct events_callback_state state;
 	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
@@ -474,8 +474,9 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
 					 perf_pmus__print_pmu_events__callback);
 	}
+	len = state.index;
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
-	for (int j = 0; j < len; j++) {
+	for (j = 0; j < len; j++) {
 		/* Skip duplicates */
 		if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
 			continue;
-- 
2.43.2

