Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F007A958
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873525; cv=none; b=OBNQ8FMHvhSLxZmuqW29tR884tlFSS0OOWRfa1Ushz0LciqJ6zMWcrLNG+ocQ5sDFjvMOh6A+XwTAG6FhEhyW8rbXS93YxxPlXQd74ngacXsrimWE9Hm366N7bimhyarwcC/zRuvZ7GqWBBRmqGQmEH/X/pejlUmT+OyRR7rinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873525; c=relaxed/simple;
	bh=oqWGhmvnCzeOXwhgFbN18Vr625doCNqmmWivHF8Ff2I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=rNFlcuITsfB1DU2PIUlRSiidkZiDbbFgzExo2ZgpcqM/Fr/TZ7C2hzqxB5CF5jlYLBsTThjgIS4xc1ipjrNyxXUKTqCiafiESEiy1CG5VYm2qrUkKMkE/rx+DOQK2llcvvH3ZjOb0EUa39hJP0Lk70rVuQt7y9eomAkP/7oTAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iyc9P41t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iyc9P41t"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso1647354276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Feb 2024 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873523; x=1708478323; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pFlPVU3Ih2WfD+Bf7Kk0SmffRXojZ0a7674czSKH4o=;
        b=Iyc9P41tWqcok8bUHV0gr8iZdx2GaEji4uvXevI23dT737PB0XfOzOasP7oAXuOn1G
         pj5H43rBroextd8537ibEFwCQtVHaNh+NkUOV339BFMV0SjZS3Zb6UiQfr7n7j74NT7Z
         auG4V7Axaeq6CA8ZCrPuTAD2do45EjD2HHtjZZFkrPFeIkJH3OKMye0QhIrUCq4DvCUH
         qbPl+eCrodu5drNO2YWrnP+3G+v4o3An7NPL33z7Rc0q2/9NV20TB91cQFUVNvX+hlPH
         ix8j++bznkbnBAaNxDThNjs96u6ccaorVydff6I7QnrP4XVILgvsTD4wDcVxpmotdwKV
         DBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873523; x=1708478323;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pFlPVU3Ih2WfD+Bf7Kk0SmffRXojZ0a7674czSKH4o=;
        b=h0UHd09Bq6yCJAOj50aJAq4xxGyUoCjeIoBmCqTGCjHiV6/o08+AARNtMVQqHBsyzv
         IfalCZO/I4FpupW0EZi/FW8to49eoV6nrDeMUuwJ0WUayWrp/iQLkd/vIsEOZV6z7dKM
         cHykaPP6hBY84SPIznVuoOQIf1f13PAtFwJTpXnyPNXRc2z4iv+c2J5vcu+F3p8+SuQL
         28g4pAQI/lJWIa66EL65LZ+BhZTqRlQWBwOvWVIKY5cpupsh428DGP5iWSPIXR4l4Dex
         B05db5bGs6eb8HW3RcCjeoMMDP8LGzi/r92cBg5q2pzsOHJwN/CKQax/1Wb8oa2p8D6U
         /BxA==
X-Forwarded-Encrypted: i=1; AJvYcCW3EGB26veT6V1TDjo7VLUVsraQmk/i5GZ+djMSNV8zXdJl8x1k+CnYnTIjAJQUwDFf9SHEuPdCGqRWyblhBKi4GpZxyFx1P8x6nHJAEW0BGQ==
X-Gm-Message-State: AOJu0Yz+2hDt4/U1y7T9fCFxQLBFx2nYsNgZpFtMy2Z4WODbq0DAEDLy
	GG4NZJhhHw5wOrulAivG0WI8h283cAPy0szKzyS+TFgdcMNe6SQa6ehQtHfTEZ882dGXkxxxJ5h
	eFCr54A==
X-Google-Smtp-Source: AGHT+IFTy83QhvO6dU6qTycgT7bP4edH1GBzHdBrE2Qytend9ZPT7HGS38Ot5eXXtELMdca/gEtbFitjnVFF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1081:b0:dcc:9f24:692b with SMTP
 id v1-20020a056902108100b00dcc9f24692bmr62999ybu.13.1707873523272; Tue, 13
 Feb 2024 17:18:43 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:52 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 03/30] perf vendor events intel: Update broadwell events to v29
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Update broadwell events to v29 released in:
https://github.com/intel/perfmon/commit/47117146c6b9e38811618beca31eba4e41c3d874

Updates "must be precise" on RTM_RETIRED.ABORTED.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/broadwell/memory.json | 2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/memory.json b/tools/perf/pmu-events/arch/x86/broadwell/memory.json
index ac7cdb831960..b01ed47072bc 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/memory.json
@@ -2005,7 +2005,7 @@
         "BriefDescription": "Number of times RTM abort was triggered",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
-        "PEBS": "1",
+        "PEBS": "2",
         "PublicDescription": "Number of times RTM abort was triggered .",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 5bda5d498841..7b30c0eb036a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -2,7 +2,7 @@ Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.24,alderlake,core
 GenuineIntel-6-BE,v1.24,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
-GenuineIntel-6-(3D|47),v28,broadwell,core
+GenuineIntel-6-(3D|47),v29,broadwell,core
 GenuineIntel-6-56,v11,broadwellde,core
 GenuineIntel-6-4F,v22,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.20,cascadelakex,core
-- 
2.43.0.687.g38aa6559b0-goog

