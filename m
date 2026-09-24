Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA84052A4
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228309; cv=none; b=oCre7ycQ4CF/O096RTyGnfvvT5P4a3yJVhw2P7TdwzCjAkjK0R7Jh9+kbp47ztlb9UWEpBNcaTCGqsmioufdhxmwy6IcsX2XoE354ETUVeMmRXOvFNl1fm03jtYWGkC9GIa8RkCMvYFubgzgy5vHzalderqN97xwCS8eIuvJh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228309; c=relaxed/simple;
	bh=CSpKCuVJds/+ApAGx4Nj8TetX92lxDBgxSfP5mk37e0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZMbcMRxXGI3MEy4mVSkVWpRwM/ejVh/tJnPa9qWX/jl4u1jPtHfqxmY+SkxBiVm+o+QYNLrPXSntewLIPrCROTETjkdctBBB/LW7O2MJfWca1sw2bd6oNyW5oSPKneqVDVkHleFNlAkxUoGoXMgUCoa5hIbPZzoIatWUiHvn/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRwTSVRB; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRwTSVRB"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1438fef603cso1013634c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228306; x=1790833106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TMm6PatOJi9G23C+RXEROGq5S2cKRgRHLI/Af1qFLXw=;
        b=ZRwTSVRBFt5AwELzDssfNNCx87K677wl6XJZzcMfs0MLJEUkx0hkoK7ojRFu6G4GzS
         kmO4d0DhlMJG6kTQ+LdxdCpn09tboHvFfHvfUHfnBrORgLaC55u0dLmGvT49+2xsRxrf
         qiLBZWv1R213jhsYOMyE2DnRCQqSS2NGK91cgMPO/lAoN3zPANMJcMNR0NKrI0Ie65vN
         les5Cg53TOZ71H/KgTJpZssJoyCU6zvwVV0I79yPnmopWQLW/Z6TJQMPf//R7fbzpo9F
         5WSPCQPP2PT13ovuVzmFF9tumhZt2cs2j4K0/XIVt2m2FT7qxbHRFilyS/UGub+2bacH
         TrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228306; x=1790833106;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TMm6PatOJi9G23C+RXEROGq5S2cKRgRHLI/Af1qFLXw=;
        b=bZffKV0in8rLTMuutWkPDumNanc4W0o8c183IQdEXQfn647SmZYeNCZ20A/RsFdWtn
         adrqexqlnqWGxVisK/VxdwYp4D4qGJD9xlgx8JDqBWP6qb57qVoVy2LT72xjzscIm/3d
         v/MeksoflIA4G4o1gWlREh697hZsWI6JbjMD2fwxumo+pqKM+pJrAIXPgLKaByARoap6
         RzF+GnhXCbpikdadpNMkP2nxWxUGc7uR/qItlD09TUDDZ+bMtXX+gtTuArVmXBZ/AOJr
         kXfavGPTNfORwQsmwCFcqXbuk6BhOQ+EuuaVOe1UrrtPcqPLjuikt3/FVa/WRGVOnSvB
         n1Og==
X-Forwarded-Encrypted: i=1; AKwUvBy03SnJvGJu6haX23cFwpkeYscQcehaSTGZ53nASU5dqcKfBaD5IaEcFC1sOp7b4lcA8CtBnML6JIndLFMxS/AB@vger.kernel.org
X-Gm-Message-State: AFuF++lOGhoWGObE9zCOkmiNDXBRzku608nJLvXG4IS0OdahHFeupVjK
	s2ldcMF0Vsi2f/5SDsYpRpnrObDmQbcCaMvjQFhOqVol/kX9l70VGKAGcXzOir0dD/Gp5Al4rgv
	b5TkcaR8hnQ==
X-Received: from dlbrj21.prod.google.com ([2002:a05:7022:f415:b0:143:c6c8:ff2c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6199:b0:144:c122:6cc7
 with SMTP id a92af1059eb24-1450404309cmr1545219c88.33.1790228305989; Wed, 23
 Sep 2026 22:38:25 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:38 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-15-irogers@google.com>
Subject: [PATCH v1 14/21] perf vendor events intel: Update meteorlake events
 from 1.22 to 1.23
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

  https://github.com/intel/perfmon/commit/9020a281323a0fb26ee464b3be6e29465=
73cb963

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv             |  2 +-
 tools/perf/pmu-events/arch/x86/meteorlake/other.json   | 10 ++++++++++
 .../perf/pmu-events/arch/x86/meteorlake/pipeline.json  |  6 +++---
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 694359197777..15772f0b1cb1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.26,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.22,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.23,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-(CC|D5|E5),v1.07,pantherlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/other.json
index 8320ffd83c51..5d1882064ff9 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -28,6 +28,16 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array. [This event is alias to MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcc",
+        "EventName": "LBR_INSERTS.ANY",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. [This event is alias to MISC_RET=
IRED.LBR_INSERTS]",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index 6cd1b1659ec7..59a0a794e078 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -909,7 +909,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX)",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary from run to run and not match the architect=
ural number of iterations (specified by RCX).",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1337,11 +1337,11 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array. [This event is alias to LBR_INSERTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. [This event is alias to LBR_INSE=
RTS.ANY]",
         "SampleAfterValue": "100003",
         "UMask": "0x20",
         "Unit": "cpu_core"
--=20
2.56.0.rc1.310.g51773c2048-goog

