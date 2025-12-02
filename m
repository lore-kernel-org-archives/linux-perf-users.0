Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753D2BDC3F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694452; cv=none; b=Vt7Kw3ALKjaieaqKzCuvb6lVbtNEZZZplbExluLw+65Hk34Jwb1gbBlDAfMlfylq9BP9iArZAVolOjR/sSlPsBd6TgKkyAwLYob8Vj/+RNSUdujRFbS1O/J59Dy2OE27rLSU+CZ1QrtAeS2KLVCutpNmlrgXKW6ARikhYN+mC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694452; c=relaxed/simple;
	bh=WYYNP14S8YjMZOL777FihjsM/G0AU65yXBiFj2wQZZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mkzThCQZIkWfM1mvglciZ0se9ZUwcFPr0tiK/7YMMFiuNhtC7ws6NYG4fC8K8uMN91mqZjqc8eXqBDu9L+Gy0wWGQSoG/tczv5smnj+BYYOWwZdq4hc7yMW7qIZ1IfJAsuIq4/QVT7Li334OZNESiVlBf3U5lwP3wTadLN3On7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aewR8KEV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aewR8KEV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7bf5cdef41dso8951284b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764694450; x=1765299250; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgiJJ8VnErYYR0SPPpbdwe5Z/cwJRzNSOEm4lX+yWX8=;
        b=aewR8KEVTdNu4BejMeKlPaPTcfVgqOsWsqy8CcB00qCham1iaXC2Rwm1fSu17bi4AC
         ldDGaISubAQ6AjDAw4ZSr/Ho4gswMiR50Z4QFWimufxt/5RXsbjIlUpUtLmjggy+frrF
         +6VFgZl9CId0Pp5srkRe9bUxCkltprx8/S04z1VtHhnOrIQOC1aoVNlbzvAhhfN2eMK4
         nWSZpBhA0qTDrj7K6PrelIHQJ1IuRsjt0wb4fS+X5saeITKMcmXdshMLw6l3EANlNpcu
         t7tGdEVdl7j+lHMvBWvRoUOj8gMBjinu6GOk5ukCy4GK1Gg0PSlsAgvbzqbUYkHFzPZ5
         3/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694450; x=1765299250;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgiJJ8VnErYYR0SPPpbdwe5Z/cwJRzNSOEm4lX+yWX8=;
        b=Yq7YeY0GlT54X289O1cSnAhhPm2dgZpvWIwUJ4BcVe7zZoi7dlHao/fygoPJ4jEn+a
         JLuAAEpMOI5HpHUOoOOR2PpzdjeIlFuY0NBnUSP7hUBpk/yEFz5Jo8XNpxVoEe6ulz+R
         hKmp9ff3qHfOdcPDYWiAOLdtnum6pxJQp+xwK1iUkmzLovWAwFvmALK6WrHhL9QMrMAx
         7/vH4Q++rfqWdwSvoS37AsPqUTZJSm4BxIqIWXg589q2V2DYEP9+WfhIBxRrU6Xi/CKz
         mfDhPq53InjCqCk4OIeSa9lgRl5Ds58v3rXUu09WRySmXkMRdFFScn4nxFTBLyFwHWZZ
         h8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKjkd0l7lpV5AwppCH5X4//A7wOCitsqMR9i+k4RgBln/5qCo9EIKfmGPiHfsL/Y3hrq4Xkrp3E8F2tw162sOB@vger.kernel.org
X-Gm-Message-State: AOJu0YyITAKbQ+ZZz+Tu3HxP9B+BcydRIIbD0x1iSStS/VtdzHa0V9/m
	PQZg4BqjKOtOMwojtPHyLhNGQHzGjCmltt6hH3vOulF3nWrNQzdKGex1GQxvrzvJk7H7q5Ccw/w
	MXrsvzhCXyA==
X-Google-Smtp-Source: AGHT+IGTDkD5+B5cmP+kGaVMGsU1aio4QWieXGAN5ITra2kaebibJ4aS7KhG91jRnPt2OGEWWBuuV+WKP0ob
X-Received: from pfey11.prod.google.com ([2002:a62:b50b:0:b0:7b9:d501:2b1f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f84:b0:361:3bdb:26df
 with SMTP id adf61e73a8af0-363f391df10mr326160637.5.1764694450361; Tue, 02
 Dec 2025 08:54:10 -0800 (PST)
Date: Tue,  2 Dec 2025 08:53:35 -0800
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202165340.555375-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202165340.555375-5-irogers@google.com>
Subject: [PATCH v1 4/9] perf vendor events intel: Update graniterapids events
 from 1.15 to 1.16
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/b4acc3fd520eb098db41083010b65b75ae906c96

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/graniterapids/cache.json  | 4 ++--
 .../pmu-events/arch/x86/graniterapids/uncore-cache.json  | 9 +++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv               | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
index 7edb73583b07..db28866444b6 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
@@ -488,12 +488,12 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Retired load instructions which data sources missed L3 but serviced from local dram",
+        "BriefDescription": "Retired load instructions which data sources missed L3 but serviced from dram homed in the local socket",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PublicDescription": "Retired load instructions which data sources missed L3 but serviced from local DRAM. Available PDIST counters: 0",
+        "PublicDescription": "Retired load instructions which data sources missed L3 but serviced from DRAM homed in the local socket. Available PDIST counters: 0",
         "RetirementLatencyMax": 4146,
         "RetirementLatencyMean": 115.83,
         "RetirementLatencyMin": 0,
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
index b782f6d54fc2..721fc42797b1 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
@@ -9,6 +9,15 @@
         "PublicDescription": "UNC_CHACMS_CLOCKTICKS",
         "Unit": "CHACMS"
     },
+    {
+        "BriefDescription": "UNC_CHACMS_DISTRESS_ASSERTED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHACMS_DISTRESS_ASSERTED",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "CHACMS"
+    },
     {
         "BriefDescription": "Counts the number of cycles FAST trigger is received from the global FAST distress wire.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index c25f718cfd54..521718b0d4e0 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.20,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.10,grandridge,core
-GenuineIntel-6-A[DE],v1.15,graniterapids,core
+GenuineIntel-6-A[DE],v1.16,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
-- 
2.52.0.158.g65b55ccf14-goog

