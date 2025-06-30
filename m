Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A14292B35
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301073; cv=none; b=qV8xW/PSPU9+/fojy7xuIXg+H3YOqp6twCr85e6rqJ7J9bBdBr5MQH/tdEWdeXyoxrqRacstnSjKOWC6T4a6kiwgcLkbb9QdgUx2jiH8bbgXVWhR2JiVYe3HJoJiI5Dhvl4e1OwPAOug0F1WHJQkYW0wwVcb2Ahg8wmJclDVNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301073; c=relaxed/simple;
	bh=d02+h7dwr2fRxGSVwaYyl58QhH/x4HHoW8TmRm4oLys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OIdSznOljScw6nVjOwFrg8HuQMCuWkQIo4w8od2duDk2BiQ/YPBChINRAeFq5yuEyi2PKs4c9kl1qZp1yUKg1r+P71dMKDfTinn6WEioUdFjVscWD7Ioyabuho10R+MDmVFOZSA4pKtnkDVa0dJ8b6tXGt/fCWA0dNDEVPDlSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RESHSrED; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RESHSrED"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so845102a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751301071; x=1751905871; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9THeGpXgsnPK80CZZzlbu7vC+HX+RRfJb+T3RAZV4o=;
        b=RESHSrEDPOCy+ogqDW7aZs5GazdoAVIMm3+Y+gMyMLSpo07nD72RHZLlVgRP3gQAQf
         xNqt2MadajC+7hmqsgd92fo8ZJVOqre60+YdQsjJ/UdXQwTxpnCZs0MFYosK1JOrFRiV
         DaGkVoJ2dQYgTo1Z4IaRvXheLCHFfv6AswrbL0wpOdjYdo3JmR5tcIPtgqRbZkHcjltx
         zG+7V7hjuVnkz5K2YtafKEoNDiyMzF4UmwP68/W9KriAM3GDINNjgT5iZ+Et5mSLYDO4
         CnU4B6yPRzbBrYTUwB5N8fApQ8PW+h1bWctzrXHSVqNRw8ZZrLzidPNWve6IGiXpLR3S
         aL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301071; x=1751905871;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9THeGpXgsnPK80CZZzlbu7vC+HX+RRfJb+T3RAZV4o=;
        b=ovjPigqA6Gs9URJhmXvdmKJVnb8r32KZCXMYfaAcYBQJZ9UhWCHxP8JCHeaivKskbj
         8lA+BU1U3aeh+8pWd+ubC2jpHDMB9dpnk5YACFxgPgVAbZkYzNGFlMVz+r/KOeaT3LVT
         av7qynUb/4/AI9djxIbDPdPosfLPZ7HZqhHaWBAtGLCyxS5Oh/vEcg8TqD/5cctcEUGy
         XfYcF0LFDrubrcM2kmu/qJHvYCT8UHfEvo4uC8FB9aCFQvmExNXOFAW1OKXjlaLnCqUX
         WQ8S2vVC2irqMZIzJ5vfKdnY8zybepgTVzZfsaFwjhpCnV5r1wvZROtZNE98QD78F7qY
         tuSw==
X-Forwarded-Encrypted: i=1; AJvYcCX7p/fU3uI1t33xbYsDn50NqpyQGrsDAxIQ5ddHfVtCN55QKZvPpeozSvUb8eePEE3dg+8G1eR2kJYFFTJ+z7a1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/r1iheWTSqekJRinz3Sw+9l/40ZzirZBmpig7j0IhIN+DWqB
	c2urdiHyuYEQH28xfv4DIMDY4U/FVjRWruQ3OkwbP5lJocTfSLJW7DxkaLATFCGLwiQaW934kR8
	x3zakPvgjCw==
X-Google-Smtp-Source: AGHT+IHQ5LypR5RbbfZHdQpjGV/2jqk9WKiulJxid6YB9fhPZ5/JJSTI7yLpcY5Bsm49ZrxR/UlJ1hgZUVpL
X-Received: from pgac18.prod.google.com ([2002:a05:6a02:2952:b0:b2e:b370:6975])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d92:b0:1ee:dcd3:80d7
 with SMTP id adf61e73a8af0-220a0936f22mr21384395637.0.1751301070726; Mon, 30
 Jun 2025 09:31:10 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:30:48 -0700
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630163101.1920170-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630163101.1920170-4-irogers@google.com>
Subject: [PATCH v2 03/15] perf vendor events: Update Arrowlake events
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

Update events from v1.08 to v1.09.

Bring in the event updates v1.09:
https://github.com/intel/perfmon/commit/cf3be6daf0a751ad270b67890dfdb2261dfc75da

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/arrowlake/cache.json  |  13 +-
 .../arch/x86/arrowlake/frontend.json          | 135 ++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 3 files changed, 148 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json b/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
index 70175404540d..91929d8bcf47 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
@@ -237,7 +237,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of L2 Cache Accesses that miss the L2 and get BBL reject  short and long rejects (includes those counted in L2_reject_XQ.any), per core event",
+        "BriefDescription": "Counts the number of L2 Cache Accesses that miss the L2 and get BBL reject  short and long rejects, per core event",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.REJECTS",
@@ -728,6 +728,17 @@
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
         "PublicDescription": "Counts retired load instructions with at least one uop that hit in the L1 data cache. This event includes all SW prefetches and lock instructions regardless of the data source. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
+        "UMask": "0x101",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts retired load instructions with at least one uop that hit in the Level 0 of the L1 data cache. This event includes all SW prefetches and lock instructions regardless of the data source.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT_L0",
+        "PublicDescription": "Counts retired load instructions with at least one uop that hit in the Level 0 of the L1 data cache. This event includes all SW prefetches and lock instructions regardless of the data source. Available PDIST counters: 0",
+        "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json b/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
index 67cc83de18d3..56cf1ec63200 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
@@ -58,6 +58,22 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired that were tagged with having preceded with frontend bound behavior",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired that were tagged with having preceded with frontend bound behavior",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Retired ANT branches",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -82,6 +98,80 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instruction retired that are tagged after a branch instruction causes bubbles/empty issue slots due to a baclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that are tagged after a branch instruction causes bubbles/empty issue slots due to a baclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_lowpower"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that are tagged after a branch instruction causes bubbles /empty issue slots due to a btclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that are tagged after a branch instruction causes bubbles /empty issue slots due to a btclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_lowpower"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired that were tagged following an ms flow due to the bubble/wasted issue slot from exiting long ms flow",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.CISC",
+        "PublicDescription": "Counts the number of  instructions retired that were tagged following an ms flow due to the bubble/wasted issue slot from exiting long ms flow",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired that were tagged following an ms flow due to the bubble/wasted issue slot from exiting long ms flow",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.CISC",
+        "PublicDescription": "Counts the number of  instructions retired that were tagged following an ms flow due to the bubble/wasted issue slot from exiting long ms flow",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_lowpower"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired that were tagged every cycle the decoder is unable to send 4 uops",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired that were tagged every cycle the decoder is unable to send 3 uops per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Retired Instructions who experienced a critical DSB miss.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -103,6 +193,15 @@
         "UMask": "0x20",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired that were tagged because empty issue slots were seen before the uop due to icache miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Counts the number of instructions retired that were tagged because empty issue slots were seen before the uop due to ITLB miss",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -301,6 +400,42 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of instruction retired tagged after a wasted issue slot if none of the previous events occurred",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired tagged after a wasted issue slot if none of the previous events occurred",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_lowpower"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that are tagged after a branch instruction causes bubbles/empty issue slots due to a predecode wrong",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that are tagged after a branch instruction causes bubbles/empty issue slots due to a predecode wrong.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2nd level TLB) true miss.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 8a2ee64cad7e..b2db2bb658ce 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.31,alderlake,core
 GenuineIntel-6-BE,v1.31,alderlaken,core
-GenuineIntel-6-C[56],v1.08,arrowlake,core
+GenuineIntel-6-C[56],v1.09,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
-- 
2.50.0.727.gbf7dc18ff4-goog

