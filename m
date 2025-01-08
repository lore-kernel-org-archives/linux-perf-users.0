Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087F1FECB5
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346631; cv=none; b=BGTrELdwHzRXvliyy2hmXC3VTGeNV+0y9wpeaJyxiYCeq+bqZ8qPWReNsbo+cxwM71yJEGeyCWr39ajgwThYOjRsf0qfMYJ5BOMfB1CRJ8Hno38F9wdJExq7naQzxRsJx15nk/hlYIWobkqIu0IDd+QSYTsGrEI1lTgRGoOYfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346631; c=relaxed/simple;
	bh=CzVsVOj5aHsPQBr+aXqDtSSnmkuppLx5203C1dQxOOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pH6FrJpjWvHP7mcDHydDCd+VGU9j+2+mVRMZ7vkaxvnJoynUwJ2CeI0Qerk+fkF9I5OTddsOz9PfPa+PZRD9+Ky6bn9YSY43h1RwtGHFWNf4v3n5XoDNQEj7RIf3BenxHVfJMy6sC2+nzk/spJU/0hqJuNwRLtlO/iXGHTmMOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nhcEXKQu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhcEXKQu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso8878328f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346629; x=1736951429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmWclsqjoRWfqPrE0WD8+jPpX9G+TTRqhb+EOtWuV1I=;
        b=nhcEXKQuRLML8xDCD4CRPPiPfMXV7gsgi4+dF+cuSh8DMHh+0WL4iVqPjsTSeuD0oH
         4FP1WSMkCvGPCwOGfYO3/w60OT7+5vsI5DTK7cE+uh/D4F9aRRkj4V7E2ehFhfC116e8
         DqUPtBciwNVEUIgBJF2/8KtGL5dJJ5Yh37pdTB0Hl5woDWNn7LvaDQ6VK3UFwrqbd8pq
         DUhp3FQkL73+7s6/UGCGOrM0ZD7qVN+PqFOGn9SVXy7N2+fDcFfuApwa1OAIwm4GDt6S
         VT/IQxPbnK6XMxyuP33z622HAbZnOLeSXeb2dloqDCbWng85QjGHADbfDoYzfoK8unZU
         j+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346629; x=1736951429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmWclsqjoRWfqPrE0WD8+jPpX9G+TTRqhb+EOtWuV1I=;
        b=YORppF4saQlDvrqAbrEm1BSu56IAE6XM9c4qric1xCO6MjQWDZzBK+0vopS6H/9LfK
         DGaRx4pz77U3WvIH1m3JYZn73NUeI01/u1b7OLdW1H29u0d8L878nXZs3oA+sLyAdSsp
         HNs8Qqn9Q+8+b70iWqy9C+zJDg7rHpOLR5bRP++QUMFFCwSlMCRPmP0UutrELrU2aZdU
         jRAeskZ4d7BGKA+lWqZ7sIgQw/on6vQ7lsgQH+iEC0+oUsogQz38CmkMratC1QIMAnnj
         CuAkWDHs5EBDWmwSJUU2UkuHGXNB5/aAGry0pwPESNWub/96neRLamkLlI8BfLGLi5yK
         LsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBwO8xGZoH56FnLq/gXCtDrA9nou5TtBcLEKM/8D2ZvnOpFi5eI/Q3jhuiJO681Cvk3Gx6r8TXU/wRjSMuQHmB@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqPORIeO82RI6k9/gCp0ABLebDuK6TYGNm8KY62hxMpkvdpTy
	h+lG0gyD204YUs7t1QkqSqO2PtVONGtins1sCSLb0geCbzkcS8DsT8Tq79HAyJqLvTKURc1ZY0G
	O
X-Gm-Gg: ASbGnctLQzYIGVrmXcuvrvkN3Qecq2nsqRIp3uW+izKmEU2HHDdINeZuklGWzG3zCB2
	BtB2rT54SKepEsodP3AJqfdZla+jYE1XnI82i6ycB2zayB8y/fJ2CkoaB47bDnSlFaEpzXIGqFg
	gS8NwdUlvqTdmUIAVNY1AEw+4AuHpm4mLlUdUK5ZaoZfw8NbJF767R7w252jEY664kPuVDBJibV
	+msJNF9Um4jBXY5M+U8GhHhgzwp1mETPALBIUGJPyR8t0MEyQWe2Btp
X-Google-Smtp-Source: AGHT+IFpLlgT8rIizotjQJSiOIRTNt4ClYlj0TJvrmATLoOgZqttqZSvaAwtMedep20NBlyPDrMhRg==
X-Received: by 2002:a5d:5848:0:b0:385:f7a3:fea6 with SMTP id ffacd0b85a97d-38a872da433mr2572275f8f.13.1736346628653;
        Wed, 08 Jan 2025 06:30:28 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddccf4sm22836965e9.19.2025.01.08.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:28 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 4/5] perf tool: arm-spe: Don't allocate buffer or tracking event in discard mode
Date: Wed,  8 Jan 2025 14:28:59 +0000
Message-Id: <20250108142904.401139-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108142904.401139-1-james.clark@linaro.org>
References: <20250108142904.401139-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer will never be written to so don't bother allocating it. The
tracking event is also not required.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1b543855f206..4301181b8e45 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -376,7 +376,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct evsel *evsel, *tmp;
 	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
-
+	bool discard = false;
 	int err;
 
 	sper->evlist = evlist;
@@ -396,10 +396,17 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		return 0;
 
 	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel__is_aux_event(evsel))
+		if (evsel__is_aux_event(evsel)) {
 			arm_spe_setup_evsel(evsel, cpus);
+			if (evsel->core.attr.config &
+			    perf_pmu__format_bits(evsel->pmu, "discard"))
+				discard = true;
+		}
 	}
 
+	if (discard)
+		return 0;
+
 	err = arm_spe_setup_aux_buffer(opts);
 	if (err)
 		return err;
-- 
2.34.1

