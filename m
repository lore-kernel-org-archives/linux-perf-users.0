Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53731421247
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228315; cv=none; b=EzQ23YubWVYB68xhFoG5CWuiCo48T/Mib+n8A5SGb55EIo9qTU1B4c7zrFYrtDjPiGkgbvzckyjY5ac1LzjTb6mVydtZ/Kg8zm79CjUS9uNDtt0Fw1smFSS6AKGLx1oUk8y0u3M4399T+vIMsksNpfAFk3Nt4ovmmjj1qPSSVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228315; c=relaxed/simple;
	bh=qTABynfnn+y8SYQtrTJYJFFbAX2DdXUkF0yhz7ciYlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fqtGAGEGFzklM24qISyFEkG21WClWz1J7GF1STlckYqdbcQdJQzu1AGfMcH5vrIbjRfOVQxiyQDC59PcB7AtS01m9Udyg/Ex13y5IFqf0ZDzsMCMe4v6TdPe4QklmvOCrbsS1LReZTP8NJQgLHG6rf7/7F104+sDgs7N6t/jEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJ8hNEsb; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJ8hNEsb"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-32850005b6bso2164597eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228311; x=1790833111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yvog2g+31va/pLrXclGIE4EOrZp/c2D3m0b8qIMfXKY=;
        b=gJ8hNEsb88Ftk9Yvam2OKa2phpXEcBgetXKgKfDh80rTur+0HqOFMRc4cnMOInkdDP
         DsW4FHXhFXAGZb95oPWKJLSEtxDJ16sJbYDtsmaOI3QGk7PqwKYV1OZVdll+63jgHihC
         8F7/0o51QoJGmW19YNPARqeeHgSnMELvrI9mOsvM0nz5I3V0Tva4R+2u7pAPCz5Mbeny
         IQCUmvfb1TjLH9EDJqQX3zO7ObeFxRpwTfY0CsriwI6l6DtM7ua9MDn+qZB4GMEfX5le
         jZYuTrEN7VP4RUtz2QqyCXr2TQH1jOkxAiBsj24cILn5Tn4R/ZW9lGlXZRz4BHamNqkA
         U2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228311; x=1790833111;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Yvog2g+31va/pLrXclGIE4EOrZp/c2D3m0b8qIMfXKY=;
        b=mBzl6cIHlq2nSnAw+fEC2uTcI8XEPPBCUrSmzqaKGUdhMVbHE06Jv41KB1yD0SpLkX
         umHJg1tXUANq8/KiRLOwfKKcIplYJDaA80sBJp9zD8bwCo/2paBu57Ss/VHfQQiN6U6e
         WJ0Lya5k2NQcUUxv/GHKjlu28cjUo5P73U53Zd+prLYbxbYLsqXigVz768fNfGXfDY8w
         7x8HBaWmL+h1tKjHhd4urgPtceDSZmYBII/tHOwazgwmHL6IPiJCP+YGbPhzU+ryTj/K
         BFiitxG4ikL0fcQ+ZJ0X+F9ZcySiguE2W1bFzY2zUPFp93wtzIVUeG1CYKLz5j6x5+Uf
         bUMg==
X-Forwarded-Encrypted: i=1; AKwUvBwEoD7pc4ZNCaqdLDJpHsbvwWJvHmnyKAoJCMlmQbXstO4XtmjKrVtlZ930CAcPHi+Sa+cJdE2e0Y1gIfkyfTuH@vger.kernel.org
X-Gm-Message-State: AFuF++mAV4GEFlyysSIrbFgQs9AOLds9NNQX8+R6xXsF6R+xVdLX9vHo
	xQUphC28ZnaQB1FeCgXO3JbDScHtiF8Men9YkqBAjD/nJYf/BANBgOzSMiP8MjTy5X90ZVtRGox
	0IdeU4loesg==
X-Received: from dyaw3-n1.prod.google.com ([2002:a05:693c:4143:10b0:33e:643c:91ec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:561e:b0:333:b6d8:c2fe
 with SMTP id 5a478bee46e88-3400439cfbcmr994696eec.3.1790228310933; Wed, 23
 Sep 2026 22:38:30 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:40 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-17-irogers@google.com>
Subject: [PATCH v1 16/21] perf vendor events intel: Update pantherlake events
 from 1.07 to 1.08
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

  https://github.com/intel/perfmon/commit/f3bbfcf86d67948fc330d4b2cddb29408=
7663da4

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv             |  2 +-
 tools/perf/pmu-events/arch/x86/pantherlake/other.json  | 10 ++++++++++
 .../perf/pmu-events/arch/x86/pantherlake/pipeline.json |  6 +++---
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index f7c8c2aa476a..b8730fb35c31 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-(AA|AC|B5),v1.23,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-18-[13],v1.04,novalake,core
-GenuineIntel-6-(CC|D5|E5),v1.07,pantherlake,core
+GenuineIntel-6-(CC|D5|E5),v1.08,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.39,sapphirerapids,core
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/other.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/other.json
index 91dd2d25ebaf..840486ef592e 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/other.json
@@ -28,6 +28,16 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
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
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/pipeline.json
index 74209da5bc27..79747c8807bd 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
@@ -1334,7 +1334,7 @@
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
@@ -1860,11 +1860,11 @@
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
--=20
2.56.0.rc1.310.g51773c2048-goog

