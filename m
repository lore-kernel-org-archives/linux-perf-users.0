Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F22BD5B2
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301090; cv=none; b=L9j14RZ8uoTDoXsU26PeS83FeCxob8TMBGM/yOrRslff6X8wvc4m9AG5xkuHxl224vwEzoCkjybSapJYq3hp4crdTb1SeAZLfQGTn4pIciqcIgxG+PW09moGg0j2H6g/Ip2ceZ1P6F79/Qr2yFIlwF/IkKtkx7d3Nn2ogeEE+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301090; c=relaxed/simple;
	bh=OnXbXgwjkX4hOiWlzrqKp2yfC7i3LXoOw+vRz6PF6+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Y/9fFT2CMz4mMdDX9/JdnHBcwJPPXBRpOt/7FIDovj7u/SvE68PgbjFsSORWF7oY2HNy5ix3r36AZ5DeB86tQIBHJ/D7DGpnkuc9dIR9D5/kUPsej3GscX4e2cRsVXC9f7/iIJUihldP7yZ0jENb8TtS8eF6cWb+USUAesisoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPsKm2NU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPsKm2NU"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31e1ef8890so1620917a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751301087; x=1751905887; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1gZcEjghHOCHhsFybicQ3hDyD+e4+regBqFqmIpmWI=;
        b=sPsKm2NUZnmxyM/fzzzW1/N+xxlHxukc2qpf+CyWm7R+hEkbzBuUJOFz1xNPkr/w3F
         iFckiAnlVEvwNDjIdkL9jMRP/4sp0zXdNCiqEMz617gvsrJFIz6IF2IvLt3nFUo3+prJ
         JcGbs/pgA7hjRu4+MJO5vm0YeDwp3I7mvvskKayOVONziuymqNV3Wh2vh6gsUjgjsBRP
         mYsCFK+p+WMRzKVy74+4Ix/FZSpiqZbITFcjjbtXAjVkZ7gH/wVJLsS6FZB8h0/DlkIJ
         D0PEJFdNUbcPpbYDvVSTmUBDwrbY8iitq/Es7ik+Xh4tGWbs/yJ9xpTQ1OTqH+rdbPb+
         GuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301087; x=1751905887;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1gZcEjghHOCHhsFybicQ3hDyD+e4+regBqFqmIpmWI=;
        b=Qttfx39D/8kyWC47pqDnQoHNXvI1+tKyXHQWIq4mGv6Ggf+fNIUuPBKeIvFAavGrxs
         1wlwq5/UmpfofAzzp5dgqM6BCr3n3AyksNBeaZb0eKjgBCfBRpcPFThpuaDdcHp7kD59
         /m5t7c8fK39/Gv7DVwjUGKocKiwfoU22kMkp54TdrXNuzt5dKWSMZx8/jVQsreSH4e4z
         aPAUJAWsc/NgoZ/ta7oYP6jchmov9Ig7WTNQfw4AoUhxgjXMX/8AA67dd3Z4TU8ck2f2
         TIOGbNIFx2EGbnNXoOmvMOclU5pOps1jmcX96XacUKsLON5oqzlXEaQuotRTrPCkmX99
         81sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9EvlDDNEOJPBMiKn3O50eZEH5p4ylq2E85RhhUq9LNC1rVwcTYwuNF/KDfot9Q/d7vmT+H0wtsbtjICZc/ney@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZ85l9E7Hbsr6MvPzAln2irSTWuW+aLkMq090ebJp9JNCPc+3
	stybC/Lv4vWF4CWw+iAf8H4kSIiLKGaFBsZ4U2v34tFNxRVkym2mYQjuC3XmacyAXbNI4BSCzWI
	yPYVojLsqkg==
X-Google-Smtp-Source: AGHT+IFfHnXKiDcDqf5beuBIAYEWrYfQK4rHMlX1LZaxcuNWvp+hs4mHod1JxjmmmLPEPSnAO72NrTT808Kk
X-Received: from pfhp11.prod.google.com ([2002:a05:6a00:a0b:b0:746:2a27:3025])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9006:b0:21a:d1fe:9e82
 with SMTP id adf61e73a8af0-220a16be3b8mr21520870637.30.1751301087567; Mon, 30
 Jun 2025 09:31:27 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:30:57 -0700
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630163101.1920170-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630163101.1920170-13-irogers@google.com>
Subject: [PATCH v2 12/15] perf vendor events: Update SapphireRapids events
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.25 to v1.28.

Bring in the event updates v1.28:
https://github.com/intel/perfmon/commit/990bfdff270adf08d408534d6d66ba47ec6=
adb34
https://github.com/intel/perfmon/commit/b7b4d7f18cf9a893438777a571abc7ecc08=
7368b

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sapphirerapids/pipeline.json     |  2 +-
 .../arch/x86/sapphirerapids/uncore-io.json    | 12 +++++++++++
 .../x86/sapphirerapids/uncore-memory.json     | 20 +++++++++++++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 252382751fa5..13eaed97b4ac 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,7 @@ GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-CC,v1.00,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
-GenuineIntel-6-8F,v1.25,sapphirerapids,core
+GenuineIntel-6-8F,v1.28,sapphirerapids,core
 GenuineIntel-6-AF,v1.09,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index 00b05a77c289..48bec483b49a 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -684,7 +684,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions. Available PDIST counters: 0",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json b=
/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
index aab082ff9402..dac7e6c50f31 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
@@ -1901,6 +1901,18 @@
         "UMask": "0x4",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Posted requests sent by the integrated IO (II=
O) controller to the Ubox, useful for counting message signaled interrupts =
(MSI).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED",
+        "Experimental": "1",
+        "FCMask": "0x01",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "ITC address map 1",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
index aa06088dd26f..68be01dad7c9 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-memory.json
@@ -2145,6 +2145,16 @@
         "UMask": "0x1",
         "Unit": "MCHBM"
     },
+    {
+        "BriefDescription": "ECC Correctable Errors",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x09",
+        "EventName": "UNC_MCHBM_ECC_CORRECTABLE_ERRORS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "ECC Correctable Errors.  Counts the number o=
f ECC errors detected and corrected by the iMC on this channel.  This count=
er is only useful with ECC devices.  This count will increment one time for=
 each correction regardless of the number of bits corrected.  The iMC can c=
orrect up to 4 bit errors in independent channel mode and 8 bit errors in l=
ockstep mode.",
+        "Unit": "MCHBM"
+    },
     {
         "BriefDescription": "HBM Precharge All Commands",
         "Counter": "0,1,2,3",
@@ -2759,6 +2769,16 @@
         "UMask": "0x3",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "ECC Correctable Errors",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x09",
+        "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "ECC Correctable Errors : Counts the number o=
f ECC errors detected and corrected by the iMC on this channel.  This count=
er is only useful with ECC DRAM devices.  This count will increment one tim=
e for each correction regardless of the number of bits corrected.  The iMC =
can correct up to 4 bit errors in independent channel mode and 8 bit errors=
 in lockstep mode.",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "IMC Clockticks at HCLK frequency",
         "Counter": "0,1,2,3",
--=20
2.50.0.727.gbf7dc18ff4-goog

