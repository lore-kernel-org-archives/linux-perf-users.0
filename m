Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A982F60A1
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553568; cv=none; b=SckDxlgPUxcrenQyA5TlTAgnlFTgUWCW/ziQZ+t+7BikiPEKCAIdZcOH/vaRZz8VUqkeqWWbivF0F7vOABwJBxpwKxTEPiMoYuQ4FW+6mlKy/3G6/K/gDhxZz820MJP+DZpD1EVv8WraQflpRlsytZSQIIurcIBBdWmdp6sdp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553568; c=relaxed/simple;
	bh=wS+WoY5+pabDz6YhKsGblNEU9rEa6XiOUL5c9eS9Ybg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6LTPM8HxXMWR2hqOKnz6zUtkBPdAQZXBivjKQrdQRtzN+rt2iNXWWkgabPAbq7OT+0ONEGWM0uwtwElyb9dMTFH2EyGBk1pSNQaVtrRpwla4bolQIilANib4zo8zeyngaL+xtQ0XvQ6EvkX/5bYe6hmKhNA4s/cwIEfXCqR2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TUpMXsbR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUpMXsbR"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so2347585a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553565; x=1766158365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfU6zNPFNxu9+V9/OLIYdA0tUQo18HdLl5yljJL+Q8o=;
        b=TUpMXsbR7CTH05ysiTFH/Hgh+tBf4Y3PfNWjwHOVXaRA6bbcACQOLZ8C2ALaXCSTbA
         s8SmbfBHeSmn2B+T0aTosQ816gMgcmLF8Y6wYf0DW+6Qa/n7qWvsHk/2ju2PtSlxSkDx
         WrljMVcwRh8lCEkPmTnyPBVo5DVzv9R7aguTZmJUMGAXr1K0OwjWpfFDljyY5k71v3Y3
         zkA2PDOFzrDiC4CH6vKHbViMlh6DnDO9p+xcjeERt0ikT/J59sEjhDcGaGK8NSdrM4VR
         D2dj2LPjQYZh51o5sZjG23/BXgkcXqLopJlcby/EzmEIZKpbC0YRvj3qSIn5wfdr4KPg
         m80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553565; x=1766158365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UfU6zNPFNxu9+V9/OLIYdA0tUQo18HdLl5yljJL+Q8o=;
        b=G/8534TwmxE/dy7ZQRtF6siUMld/qMWvItegzVn04akGQH5eIzG+mzgN1rHkU7ptrj
         XzMf/14Ha9yqNh8haZ8EZyvITPD7JPluBTN7uUdu5TmN+RReFmtjXYji+S4OWgoyZGTg
         QGBef6LCDddhqSmLGQiHB9GvVbGD0OC0RKWPpPPY7gQ2zYRLEG3BmCp3otCaCJWgmPYH
         UgURw4wIIhqCzmp0B6GhY8yE7fPuKUP3dKAIgLtLoFv7E7ETeZ4dfOVb0ekmWEgWG7Cy
         rZ2VJqX/rclTF9A13u1/feFmIhZld4pE1pmb0jF6oEyIgk95aIRwD2sDwSsaiRLscaBJ
         gGHw==
X-Gm-Message-State: AOJu0YyZ7qMW2wXohWiZLs3iwvL7ch/UX5E2oPVpg+8xEn+aldOkGav5
	wNkQD/GI95C9rEeTfTtHecRSHsETHTwpQvD9FikT8ZTCWSVT6AUpCexC9pIbxGiN6lM=
X-Gm-Gg: AY/fxX5Nxiosgu5NFJ9IEn/6hr/VmN/utGY+XoXuJBhcl5bJ5QM2NTYrHxX+EMGC7G4
	PHv+cy3EIXXjfp9LH2bks6JC97NxQF+SZDPKIME/4vtaCGgES7m0Jm2V6nAlV9Bzyridac8o4k8
	Nc9Sgm3gYT2JySsWh5PUVKiZkEr8zSNQY8RHzbDfG9R3BsyGRe8kYc/Ui1mHOPDh2VDGJrbEEIH
	wVyTGH2SodgQ19GHxt4i/LDTwZG26y+QOwBI4kYcC4SZ3tjp/nvwqbvwQnDbY1Sw11XW96Gwium
	BVgtaMZmlXykIgCAkuLmulUz1d5CZX8AsxrfMpxFk3dc1RscTq0zxR6c9AEmf7TiqVabEGNZbMm
	65B8+CDsM9bxFysZlw+goIm67QymWbi7gzaGbg0yoFhKyYZoTxZepzYvrnO0qs14HaLWt7yUs+r
	wpmWvoXcMPtTxEzvCv2xo8sixP+Xos6mU=
X-Google-Smtp-Source: AGHT+IGZdm37HxAqsjhy1/5xDaqN7lUTV358c1EAXqBH9pM4lK4FxazOWjwBlNTx1asu/TcDWqtePA==
X-Received: by 2002:a05:6402:2553:b0:645:d764:3fcb with SMTP id 4fb4d7f45d1cf-6499b1e3610mr2444108a12.28.1765553564857;
        Fri, 12 Dec 2025 07:32:44 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:32:44 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:19 +0200
Subject: [PATCH v3 02/12] perf evsel: Support sparse fields in
 evsel__set_config_if_unset()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-2-aa36a4846776@linaro.org>
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
In-Reply-To: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.2

Sparse config fields are technically supported although currently
unused. field_prep() only works for contiguous bitfields so replace it
with pmu_format_value().

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 956ea273c2c7805c0cb504fb7dcf996f79f5588d..2c26c8d76bed920c7b5b43beb867e4d1bcaa2970 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -144,6 +144,8 @@ struct perf_pmu_format {
 };
 
 static int pmu_aliases_parse(struct perf_pmu *pmu);
+static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
+			     bool zero);
 
 static struct perf_pmu_format *perf_pmu__new_format(struct list_head *list, char *name)
 {
@@ -1381,7 +1383,6 @@ bool evsel__is_aux_event(const struct evsel *evsel)
  * the bit pattern. It is shifted into position by this function, so to set
  * something to true, pass 1 for val rather than a pre shifted value.
  */
-#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val)
 {
@@ -1398,8 +1399,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 		return;
 
 	/* Otherwise replace it */
-	evsel->core.attr.config &= ~bits;
-	evsel->core.attr.config |= field_prep(bits, val);
+	pmu_format_value(&bits, val, &evsel->core.attr.config, /*zero=*/true);
 }
 
 static struct perf_pmu_format *

-- 
2.34.1

