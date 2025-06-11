Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60241E9B0D
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613574; cv=none; b=lTRdCfMjoxDX91cf28NJnmyS4sERhJAhtVZh4+7xT5UZF/wJMuIy5IGAxjLmpyfHooXtIye5diFvuXERD8bMbqJ6Hu3ZCnGs6nb1cL49FLW+y7e2pVdAqI3hfBj6GxvulgTJkJmAZHNkJvtTuM8yRVrRijG4ICEphYc5aSssXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613574; c=relaxed/simple;
	bh=BjW6AZGk7CZomAEyWECRkQDZi3WC4X5fktZTMbvlAbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SjLL9NHGFuTW9tbdbnLYoZQdi81XH40Mn15p/S9g2ZkuXrl79XJgzsZfbfBU9/JQaWHa61ADR5KQoNgSLq42F16zSbtDcGb+MbWhouFD7NPI+xpjhm6gEzcLjVZFMIZy/Gk3DdcS7+kb2R3VRaaLvGA0j5nmOTL0owcH7YEsbfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aaGOkT7w; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aaGOkT7w"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234906c5e29so72971835ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613572; x=1750218372; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EK8se2wo8pULW/UeVmGZwrfi1Azdb8cvXZbahmZy3Ao=;
        b=aaGOkT7wCbpJ9NGxM+6Lt9/XYogMycuGjAdw3rn8/kK38Bgr0SWgWZ05FUD5O9+2hi
         FAq7dggzteeWqzpbTGPf04atTZSYiVxc0Hxa6r3IxWk7xcWxQLjo3Gc8pxu3+mvchEN3
         kdspRL1WHDwJGxDoFHZeqqnZJhmoX4Jm29CVMZTbc8Y3hyFE9ZX4rhnpGxo8nxh9kslb
         iUKZutTQOzWf0J+28rgDClT/iYWamrd8bwE/py5yVjNbBqopO+JVHkeQW0nkYVr/UKUW
         sCUdRRdPeOZZDENIYO2/JXiEWuLbgPfa+xyEdlWddBNpQOa3DszH7ojLO0JcCibBZOZ/
         FZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613572; x=1750218372;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EK8se2wo8pULW/UeVmGZwrfi1Azdb8cvXZbahmZy3Ao=;
        b=qLPTmFBhjzu0PM+AArJoWjDvn3jj4zNJR97svzW9vwG4/uAXUPIDyocAjYjw/+p8R2
         tbN/qY5E4H8k/McqXDNdi1L9ZILPI2LpIic25PIPrc7mGsheVxrPOQntKtHNXvLYQUvF
         2qmdA9XszZscPk6MD+vGO4EgH7ilbK/ki6TUJcDjkbp3pjZo0WXvsZBHHwjO6DfmeM7R
         IzadyN4rC/TSLNgLu311kSiGomC12JvRlA+ftMA4HXfONN296XNGuyAK7ynskKp6Q1EL
         4xi6Do5sjPkLWCCLSeQ3nLJhOvZ2dk6baMAfYP1/kkhXzAf1DDxesJWBmJxX2nsJH8xq
         +Mjw==
X-Forwarded-Encrypted: i=1; AJvYcCXg2GahRvpc9CWi5vJ2gO4MKNEAtoVFM9lzt3iH8ghmayJ3Xow46mLJe6Ir3gdqsRhspuO/9AxGjvAdv0b5H60E@vger.kernel.org
X-Gm-Message-State: AOJu0YyCl7fGisXHKUcITDJLE7URrYfIJbyhnw65tEjNdm3K2+5hR0EB
	iKxH3ddi96RS6lXVxmQYzqvNF87CDGnby6a1Edt7LgtrrJCx0Ar4jAmOKKm5LKWBNFb04rUUbBc
	DTpbb0WLt4A==
X-Google-Smtp-Source: AGHT+IGHPjGfNv8/2SbmRZRAAxy8oNiAGjL6dFb88W6cXiB9ruYnJCVqIRK6rOyuGvjWvE/iZ73skL+ii1vw
X-Received: from pgd25.prod.google.com ([2002:a05:6a02:2c19:b0:b2c:462c:520])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b6b:b0:235:ec11:f0ee
 with SMTP id d9443c01a7336-23642621bcdmr16215185ad.14.1749613572251; Tue, 10
 Jun 2025 20:46:12 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:15 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-2-irogers@google.com>
Subject: [PATCH v1 01/15] perf hwmon_pmu: Avoid shortening hwmon PMU name
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

Long names like ucsi_source_psy_USBC000:001 when prefixed with hwmon_
exceed the buffer size and the last digit is lost. This causes
confusion with similar names like ucsi_source_psy_USBC000:002. Extend
the buffer size to avoid this.

Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index c25e7296f1c1..75683c543994 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -344,7 +344,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 
 struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir, const char *sysfs_name, const char *name)
 {
-	char buf[32];
+	char buf[64];
 	struct hwmon_pmu *hwm;
 	__u32 type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
 
-- 
2.50.0.rc0.642.g800a2b2222-goog

