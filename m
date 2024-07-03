Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999B186E5F
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027293; cv=none; b=IerVK47SwZ2Yi15f9B3wcfsbOaXaJcY+dcar9Cs+ZXAD81a2cpNz592s2O7UTVdBu+uXP5XfHwzLskjF3nW/gzZb2cJ+d/BUQuuZvU5rcFo+32uCoWQP9ud+IL2uvvXHoe46E/SJIR0X1+n/bmEQLPDIwjs58jL/y8h2jSsEdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027293; c=relaxed/simple;
	bh=PyUC4JnOx8t49+z9OfoW03gptn9Bhl8DXa2Hy8+Ghhk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=L4bE48lHmiZXRL+mAncx3t16rNfN7qyltYaTBFscEyTcWQB9nAOwAh7BFclAMXgWflH+OFqjGYDwGhEYf/Sfnk7VWjBhFe7EpSXf+vnUfg0KPCjQevtxaV2H6sOUL+XpO9vrmDh1M9i3+xJfwxY/8XOjaTgj71plsSYERHWCgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tumwyInO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tumwyInO"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a40bd8afso3093766276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jul 2024 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720027289; x=1720632089; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0FWSWvUbekODbWV63YGf3s/rZsG/y2vGmr0tGGkdh4=;
        b=tumwyInOQMVTUdUQfOcAnw6ccxJ5a1K0GQPopHDL7D3Hyac94/jprk2Z3A9TIZc8eD
         +60Z5kt+pfvxLd/EFKxnLS2IIpuuwc2po/RWFf8SD7DGe0IuAQKCJCWgszxvblTl9vnI
         VX3HiOWoDj+LWQE05SFUH//AVogKTANegkaVOuOZrTuhVDWCxNiUTFECDd8kAJwLO/kY
         DF3pchQR+urmu+DCf+eS7VkQYkmQpga5KZhFSCALAmdj0Suo0+vci9VGBQ13ixvQOidw
         AvhpU0mpBO+YjQ3WG87GZylDdxsnrmu/Vr0qnqL6wOpSaXk9Fj5c0DYSP0L3PLNElNOY
         OkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027289; x=1720632089;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0FWSWvUbekODbWV63YGf3s/rZsG/y2vGmr0tGGkdh4=;
        b=T8xAEtMif9zzyqXeAA6OjQ/nh/Y2M0MlK315CqLUEWrPpef5BylsQccxNrtlUZ4EMF
         /2yPjg/nnoGwTPCK/gFmJdetnrjFAHp8RAoUVcJp8PTFg1L4xFfh0v5/RzpHxuckeGzn
         L8nHl+mN1tYOMDJHTFALNVq4NfOOihtjAzCfCG3WYHLwqeudSVCZQB4l3Mkq3bOfr//E
         z0CCZgRIVWzyUMYahd7CHCpaXAZkc0oGXMtCbpPNqCTcqmBlwOkv4sJyP/8mePXNDZHy
         jiTSDP3o3pxvvFhI2NladxvbJgjrpuRFuQkBIUnfL0QMkZ2WJWlCt8chkWg3O1ba41s4
         m1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVayUuUYa5SSjh5TkbUjjkSoNo53G1pQzHSd63KVaS7UcckfVMFP5Tigep8zgemEGeiYjHyr0Q+NZ5hbD8YYmN8JpinYPqDjmV3NkEEQKTDWw==
X-Gm-Message-State: AOJu0YxSlJJ7EwqOXO+rVswmdd4D1YZRU6jg5Woc+LfjNsCylavmyvXA
	HPtWSMuqO4ibrX1pBlp8r5KFeLJ+RKAeMLV1KOxqfwNsmzf/7j5OF0G5ZcQIpllJJWD0BGoGyWN
	YFU/qvg==
X-Google-Smtp-Source: AGHT+IGgzf2ypPsf+gg7WY15qEpj68EM85AeI9lS4mElKvh7OEaQdift7C8lBXTuoGY+dMzeU9TsXsOPncCe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bdc2:f28d:3877:f0f2])
 (user=irogers job=sendgmr) by 2002:a05:6902:c03:b0:dfe:3a4a:bef2 with SMTP id
 3f1490d57ef6-e036ec62e39mr866543276.11.1720027289687; Wed, 03 Jul 2024
 10:21:29 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:21:17 -0700
In-Reply-To: <20240703172117.810918-1-irogers@google.com>
Message-Id: <20240703172117.810918-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240703172117.810918-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v1 2/2] perf dsos: When adding a dso into sorted dsos maintain
 the sort order
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steinar Gunderson <sesse@google.com>, Matt Fleming <matt@readmodwrite.com>
Content-Type: text/plain; charset="UTF-8"

dsos__add would add at the end of the dso array possibly requiring a
later find to re-sort the array. Patterns of find then add were
becoming O(n*log n) due to the sorts. Change the add routine to be
O(n) rather than O(1) but to maintain the sorted-ness of the dsos
array so that later finds don't need the O(n*log n) sort.

Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 5e5e05f86dd3..d4acdb37f046 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -206,11 +206,27 @@ int __dsos__add(struct dsos *dsos, struct dso *dso)
 		dsos->dsos = temp;
 		dsos->allocated = to_allocate;
 	}
-	dsos->dsos[dsos->cnt++] = dso__get(dso);
-	if (dsos->cnt >= 2 && dsos->sorted) {
-		dsos->sorted = dsos__cmp_long_name_id_short_name(&dsos->dsos[dsos->cnt - 2],
-								 &dsos->dsos[dsos->cnt - 1])
-			<= 0;
+	if (!dsos->sorted) {
+		dsos->dsos[dsos->cnt++] = dso__get(dso);
+	} else {
+		int low = 0, high = dsos->cnt - 1;
+		int insert = dsos->cnt; /* Default to inserting at the end. */
+
+		while (low <= high) {
+			int mid = low + (high - low) / 2;
+			int cmp = dsos__cmp_long_name_id_short_name(&dsos->dsos[mid], &dso);
+
+			if (cmp < 0) {
+				low = mid + 1;
+			} else {
+				high = mid - 1;
+				insert = mid;
+			}
+		}
+		memmove(&dsos->dsos[insert + 1], &dsos->dsos[insert],
+			(dsos->cnt - insert) * sizeof(struct dso *));
+		dsos->cnt++;
+		dsos->dsos[insert] = dso__get(dso);
 	}
 	dso__set_dsos(dso, dsos);
 	return 0;
-- 
2.45.2.803.g4e1b14247a-goog

