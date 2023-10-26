Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E3BE58
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1CGX+In"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB91AE
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da05c625cb9so249977276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280350; x=1698885150; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4P4Ckt7g7gTNX776QqcLXSzZoxp2WVgO5XwUIxwuv+A=;
        b=e1CGX+InIxqWtJDL5/FvJy3A5HP3RtrZA52tNmZ86kZtxOkwzO276YSlmdll3pL5Dx
         +kiKGR54W/BHV0uTOpv/q27zMN9TOD0zRmscnue+GpmJE3l/3Im2h5MXvbGtEPRA3VVh
         25+TC9Rw9atFTLOLRiUG6E9E399F6vwAeACJjv2TYzTOLJPpF9Ok+KdS93p9lNW4l2ZI
         kwsSjEIhkCOfeLi3jRAgUSZT4smqmAM3iW+HergEnCEvPCEofRlV0V4pxKw+q2aFUMj+
         /PtUmF7jLSaNXACFmLV/haPBqknxyWRxOJHhqQzJlVdhQy8CQofWikHdo6tdS0qrD6nV
         +OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280350; x=1698885150;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4P4Ckt7g7gTNX776QqcLXSzZoxp2WVgO5XwUIxwuv+A=;
        b=Wowslne348fjzPue7Cgn95KDSygKNcINPkO/fxMM8JKZZtS3qpIwiku1z66+jMqh2o
         9C7bzz3InsqyjHgQf9XPzbxL2BkbMU2bNKml83DD+hop6tikdpWsE36SIPbXTj9rTO2G
         su4Ol31nnOELo2jDkACDQAtEH4/2lQw1uvPCVeFz6UiJBMUdAOHB/ocsl7EjAkfjYSIr
         XLKwsivioitszrZT5BxgQRtxDo/ajdX48tFDcYvkZs86Mjbr3wRpxN3nXQ3Uc6F7U6ZU
         ATihtDEqHbgP1vLlg0S/M9pw5eGWW/NlDBYKMolNiLIslda2/dGJsfz7fQ2c/m3EN3Az
         QQiw==
X-Gm-Message-State: AOJu0YzPifMcbX2P95TFqTnPgjaqnK+ltSXcfHX02y6libyYysxuAJs7
	95CNX1JoEUA3T2TwtJ8H/Wc1qCrkb5gf
X-Google-Smtp-Source: AGHT+IEKM2WBSyG+hlRtFEqZP5bsLUwbk8vBV8YiICaKGHobmwXo31vK4KGKqNtEuib+kL0Rv4H42EEPc1qi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a25:297:0:b0:d9a:4c45:cfd0 with SMTP id
 145-20020a250297000000b00d9a4c45cfd0mr297919ybc.2.1698280350215; Wed, 25 Oct
 2023 17:32:30 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:31:47 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 7/9] perf vendor events intel: Update westmereex events to v4
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update westmereex events from v3 to v4 fixing a spelling issue.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv              | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/pipeline.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 5b455739065b..0dee3de3187c 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -35,7 +35,7 @@ GenuineIntel-6-86,v1.21,snowridgex,core
 GenuineIntel-6-8[CD],v1.13,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
-GenuineIntel-6-2F,v3,westmereex,core
+GenuineIntel-6-2F,v4,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
index 1c61d18a4b5f..026236558d05 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
@@ -45,7 +45,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Early Branch Prediciton Unit clears",
+        "BriefDescription": "Early Branch Prediction Unit clears",
         "EventCode": "0xE8",
         "EventName": "BPU_CLEARS.EARLY",
         "SampleAfterValue": "2000000",
-- 
2.42.0.758.gaed0368e0e-goog

