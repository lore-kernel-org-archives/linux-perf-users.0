Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4344322A2E
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Dec 2025 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183203; cv=none; b=IWYaj7WmjnVZjPRrDSdruAwavdmnk5KnJqgWwPAlCY+Sfpn++kZmTOC9EPpyt/WBxIO23BjbhRDhzHomKuJqgSpJWSye2RHgD2r7uNKSjanTLcjeNy18GCh62gm1auBMU4OtICSjD1buK8rFjfgGzMpMy4YkrvL3C5D5uJZA8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183203; c=relaxed/simple;
	bh=TbH7w6cL5HlrAiR+wUX+SJxH/xdVAckk8XejBC402FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s3HK+b9g/fPYU6J989t6zjSFbMeMuOd3L1vbXHF3M5ZURbo8Hzqv6QerzrMn5Lbe96eUoxdtnuliOc7ttEsclliA6altJkIUV9F2n1+KKYRcrxfwmu0qPP/kgakwg2u10Gu0+L+xR0HrpQjzjTtJZMnFWUxmyWbL0+XdLvgT8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V01/YWx6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V01/YWx6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so47910755e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Dec 2025 04:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767183199; x=1767787999; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NK8HAsEbzuMAmJWJWMfro3WvF+de9PMAbtRd5ci+vDw=;
        b=V01/YWx6hP89cXNNndGJOoBLuRdVvrNuGhJfL7tws6M5+TDOQdFQ718xyt7YLljJcT
         t1V5g+NhupGK/aSAzOs7YLb/tGx4SFdyes8VIxIIXJyAL1Prlg2NC+Ut8t2e+2XKh5xE
         KeUECUufq0TZqLpIT0DnJHoTVJnGF0BStvnVNWYaghaqGwdilVTq1c8Pnbz6JQMAUpAe
         TUwAzT5c6PCQOhLAaATVLmtxs7Xfm0GNUQ2I+5p68uqwp1Lm+eHlCkhK60qE4u+xIOnl
         VG7KpgxhOp94mn187x2JfbPlL84lYVsBwttRp8ZOXl1JVdMMWH1opQC6wL9SLUshlk4u
         kVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183199; x=1767787999;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK8HAsEbzuMAmJWJWMfro3WvF+de9PMAbtRd5ci+vDw=;
        b=Yof6G6ewxfwODu3nom4Nu9Eq6yrc5CejCdxf/H6Q6XWALA4nwIH4iZeN/goNr+2j+u
         9bOJrye8CT6QTLykvp9XIE9/E/SXrl0y4/fGU8/VQyOcub0gvhYlHgj0VVLE4iGNnYfq
         P0ZsWkLuuU+t26nDsChmD59ylQfxzGsS24rQ/wtRfjkh+yGlRn+sR66YcaGvAywr2jFR
         biulIOForaJcomA5CDX10g1rK3xBaZMFt06mYpmNTSVKb3XmyMczkXGHCOEyE9/7XU/R
         chWt04eVOMOpcbSI3OXfF9v7ZAL3vui9Uc8IA3zbeRolzxyzIefEZ60ozFZdlYa0PZiO
         fqJg==
X-Forwarded-Encrypted: i=1; AJvYcCXCTEN/GTd40TfDxbqlbyT9GptH73s36+BPNYqHLBwnznphXp0xRVAYwoYzFPUvSrXhis66OSfqdy4SRpYZkCcC@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyiJC2JBk51cAghdnhTUBGn2UUABLA/T5NOtFXF3PTxrKbuRx
	9+84939RDUZd9qsFHlnxP3EvyEG3YqJ5JHHtRB+9cTOVzXGpC8WE/YY5DiCv7rBI1ZU=
X-Gm-Gg: AY/fxX6FoVGqXc7XKDjLRXR4j+oajH+KpOcPKpluYwnByFOYzaatP7zk/4bEGD4JhFK
	uaARgVScEPSCBkDHhmSGTKWMtvBawJQNVY5zCxTmhpV9IjKK0rH+QiBzU5L0blaUuOt+hPCcgZf
	IUPPbOqe60MEtPUie7gif/n9MdiV/fT73Yv4roQBCUiBqCb4l+D8Wp2miyPU0Z++fEtv0kpUxOu
	BioIB+eogjakeKCHmJg1irJER1ixd2vzUoh7vrcYQ6mKOAPpassmMNknJpf6YewgNxORrrhJJgk
	Lx1/TWidYK7lIHdVK5B0zJZ41g7BAl97pKkWaVksP7jb3TVbszeAhMG4dAzWFMTgyWNk0oO75/k
	O3aUXSVt2yKeHLza5Yn8B+mq47z/AUqQawNTeWaj2G+vFoVimjDVehqbOt7jmt4yk2egTUvC9vF
	hNVDrQe+pykZlhOi+VGJID
X-Google-Smtp-Source: AGHT+IGLQlOVOkiDjec3oBGg4+Ay31+MFr1T1oasXTpgdA5gcl1YGVgHyCirJ2aVhoFz1PXleO1q3g==
X-Received: by 2002:a5d:5f87:0:b0:431:327:5dd4 with SMTP id ffacd0b85a97d-4324e50db43mr41813742f8f.46.1767183198565;
        Wed, 31 Dec 2025 04:13:18 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43277b0efefsm40904221f8f.25.2025.12.31.04.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 04:13:18 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 31 Dec 2025 12:12:28 +0000
Subject: [PATCH] perf vendor events arm64: Remove uncountable events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-james-perf-uncountable-events-v1-1-f2d9932999fd@linaro.org>
X-B4-Tracking: v=1; b=H4sIACsTVWkC/x3MQQqDMBAF0KvIrB3QhNLWq4iLRH/aKe0oGZWCe
 PeGLt/mHWTIAqOuOihjF5NZC9q6ovEZ9AGWqZhc4y6t8w2/wgfGC3LiTcd50zXENxg7dDV2tzC
 lePfx6hOVY8lI8v3//XCeP4R9qiNvAAAA
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>, 
 Yoshihiro Furudera <fj5100bi@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

These events are never countable by the PMU and are only intended to
be used as external inputs to trace. Therefore showing them in 'perf
list' is misleading so remove them.

The generator script doesn't emit these events when used with the new
telemetry-solution input files [1].

'perf list' should only show countable events because there are events
that are sometimes implemented, sometimes countable and sometimes not,
for example TRB_TRIG. If we always include any implemented events
whether they are countable or not then it's not possible to tell whether
they are usable in perf without going to the docs, defeating the point
of 'perf list'.

It's also not useful yet to display implemented events that are not
countable (for help in using trace rather than perf stat), because
PMU_OVFS and PMU_HOVFS are practically always implemented and TRB_TRIG
is always implemented when there is TRBE.

[1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/main/data/pmu/cpu

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json  |  8 --------
 tools/perf/pmu-events/arch/arm64/common-and-microarch.json | 12 ------------
 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json   | 10 ----------
 3 files changed, 30 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
deleted file mode 100644
index d8b7b9f9e5fa..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
+++ /dev/null
@@ -1,8 +0,0 @@
-[
-    {
-        "ArchStdEvent": "PMU_OVFS"
-    },
-    {
-        "ArchStdEvent": "PMU_HOVFS"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
index 2416d9f8a83d..468cb085d879 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -432,24 +432,12 @@
         "EventName": "TRB_WRAP",
         "BriefDescription": "Trace buffer current write pointer wrapped"
     },
-    {
-        "PublicDescription": "PMU overflow, counters accessible to EL1 and EL0",
-        "EventCode": "0x400D",
-        "EventName": "PMU_OVFS",
-        "BriefDescription": "PMU overflow, counters accessible to EL1 and EL0"
-    },
     {
         "PublicDescription": "Trace buffer Trigger Event",
         "EventCode": "0x400E",
         "EventName": "TRB_TRIG",
         "BriefDescription": "Trace buffer Trigger Event"
     },
-    {
-        "PublicDescription": "PMU overflow, counters reserved for use by EL2",
-        "EventCode": "0x400F",
-        "EventName": "PMU_HOVFS",
-        "BriefDescription": "PMU overflow, counters reserved for use by EL2"
-    },
     {
         "PublicDescription": "PE Trace Unit external output 0",
         "EventCode": "0x4010",
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
deleted file mode 100644
index 65bd6cdd0dd5..000000000000
--- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
+++ /dev/null
@@ -1,10 +0,0 @@
-[
-    {
-        "ArchStdEvent": "PMU_OVFS",
-        "BriefDescription": "This event counts the event generated each time one of the condition occurs described in Arm Architecture Reference Manual for A-profile architecture. This event is only for output to the trace unit."
-    },
-    {
-        "ArchStdEvent": "PMU_HOVFS",
-        "BriefDescription": "This event counts the event generated each time an event is counted by an event counter <n> and all of the condition occur described in Arm Architecture Reference Manual for A-profile architecture. This event is only for output to the trace unit."
-    }
-]

---
base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
change-id: 20251230-james-perf-uncountable-events-28adfb93b73f

Best regards,
-- 
James Clark <james.clark@linaro.org>

