Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0893E172E
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228285; cv=none; b=WwewWk4glzIE5qsx4JZ2KJuDzOzaiLm+3+RLDrJ3/O3MIfXdO/1n6l7A+/RrMMV4PdbYu7bImG7TZg+oP4m70ZVjEFDjOSycX0vdQgMaLRqTe0e0riCHXr5D19I/ybQ1etwByeijDGuaMHM65eZCESeNDec5eKBBv9LJr4dQcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228285; c=relaxed/simple;
	bh=yXeWpriq36hxA6BJpuexMD9zy+c5ffiMkSnlizwIr0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=krYt4DRrNJqz+LcdQT8khXYqQLEUeWFMHKeLLs41w6S9G8fMQhWuoBdYDoGYm+22v6kbYKBMrEeUHepbaXhIIcBzL3HzmrylKwO9Gposz/n7CskzL+i9T8CQP28QCzqgVwzJgx/wPuJ4QBRtsXCiLA/+PgaZoeKk+RD+DAy77zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVsCi0UJ; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVsCi0UJ"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-32b8c2b30c4so2685249eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228280; x=1790833080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/hfQYqaN1qKTGFNWK2B/kjIY84Mav5iOvuLQjajRo3I=;
        b=eVsCi0UJDMpxVbN67wnL3lTBx91eoln9McGmGAZj9bk9l/7GEdVUHYTAwbADMwreTn
         FtjfAZluEsgsm4auiUdIkLw/uq63ZiwQ/9+X2dnihmO0MmTUxv+Z5W0cd/Avkh8GsBJW
         gBAaxyikx254XFQbm6e+OZ//orbIMP6Y5pbGWccKtoFPzlacd0h8gda3Tspq2RjA06vl
         0SITfiLQs2M7VTBjvTVv62spgtQZioaTRbqtQZhiBjQoVi6nYwxz16LyDq1/Y2vjXm1D
         1aOjBrTC6tdyqzyG9y1G/zU0Q8GidOUmwN1KxrfMawWNtgOn4wp6dJESCY5hGYE26wzk
         D7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228280; x=1790833080;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/hfQYqaN1qKTGFNWK2B/kjIY84Mav5iOvuLQjajRo3I=;
        b=gALRZh8CgRirvZ3pgAh5uiYUn51OR2g7CSVjQ/VHNHnkBhi9DOl85gKXAYpvxBHY2v
         1/g92wEd5xSAPgSgXGxqHBBceS967myZnY382TBLwbgw7ZuYZIuktECifjb83B+TM1h0
         aPbqkM9WJ5t9eiwnQv/FvMXcgrrm4WOrhfOL+pTAp5lF9AOU/+0Rfw4t2gRckczOZ7Ek
         PFD/enm5kvtflTV6pT0X0fSBEFOg0wgYgUJ4b9z2cVkAh0zHPlHgHEwnJMBKXtGquHYf
         +eBu3J+yKo6DDoyGE8WbFySbNqTw+QSplj2HWbYNMoKUwRW9k6cErVH3ddMvSdYF6S4V
         nUIg==
X-Forwarded-Encrypted: i=1; AKwUvBwLFvA2T+lpcQscZnmMLnCSEIlR9QlNFU/2RA3626TgaDuYMXCbdtEWsh32HciB5RsfdR5xA6rjWNY2g8SYzlHI@vger.kernel.org
X-Gm-Message-State: AFuF++n832I7RP7jYe/FWqrehtoJpzZ4y0wJwR3ew2Ll/ID//y7TjEkl
	zBBVg2dAJtmMcqioZVXOrnIz/6wbD0isFVs+Lbk4FAr1AUBMS8Vz55WPuV3uN22ekWpsn+Oasbh
	JW3YVXAJFtw==
X-Received: from dyvs26.prod.google.com ([2002:a05:693c:42da:b0:33c:28de:54ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:69d9:b0:33e:d4ae:e10e
 with SMTP id 5a478bee46e88-34007382407mr1012666eec.40.1790228279493; Wed, 23
 Sep 2026 22:37:59 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:27 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-4-irogers@google.com>
Subject: [PATCH v1 03/21] perf vendor events intel: Update arrowlake events
 from 1.20 to 1.21
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:

  https://github.com/intel/perfmon/commit/335239ef9a63a3a6e198233678f898761=
cba38aa

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/arrowlake/other.json  | 19 +++++++++++++++++++
 .../arch/x86/arrowlake/pipeline.json          |  8 ++++----
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/arrowlake/other.json
index c8feed3a99a6..96086e257a6a 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/other.json
@@ -101,6 +101,25 @@
         "UMask": "0x10",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL. [This event is alias to MISC_RET=
IRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "LBR record is inserted [This event is alias t=
o MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "PublicDescription": "LBR record is inserted [This event is alias =
to MISC_RETIRED.LBR_INSERTS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to MISC_RETIRED.LBR_INSERTS]",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/arrowlake/pipeline.json
index 1f1b5a88216a..4afc90dfe96b 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
@@ -1238,7 +1238,7 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX) Available PDIST counters: 0,1",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary from run to run and not match the architect=
ural number of iterations (specified by RCX). Available PDIST counters: 0,1=
",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1931,7 +1931,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL.",
+        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL.  [This event is alias to LBR_INS=
ERTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
@@ -1940,11 +1940,11 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "LBR record is inserted",
+        "BriefDescription": "LBR record is inserted [This event is alias t=
o LBR_INSERTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "LBR record is inserted Available PDIST count=
ers: 0,1",
+        "PublicDescription": "LBR record is inserted [This event is alias =
to LBR_INSERTS.ANY] Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 748d1ee1605c..27eaf934b925 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.41,alderlake,core
 GenuineIntel-6-BE,v1.41,alderlaken,core
-GenuineIntel-6-C[56],v1.20,arrowlake,core
+GenuineIntel-6-C[56],v1.21,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
--=20
2.56.0.rc1.310.g51773c2048-goog

