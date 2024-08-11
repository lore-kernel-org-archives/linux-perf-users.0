Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987517BB7
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Aug 2024 04:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723350021; cv=none; b=SOZ5PZJmJMG+bGlPfmnQboa8PcWZ9ysYbRb+aYG1dLY0BaMsPssDtZn3Wtsb7EqjXJYxuYZBa8hu2RVhBgR5fHFnsCOyu3q9i+cAmeOeI2vuN8oLI+eLGCdV/0z55qyGr0vpNlTAwNP/2dtRK3ss9hmR9Pj9Ug2jQvXtSVz/hPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723350021; c=relaxed/simple;
	bh=9wB5WbEwTw9O8SC3yq8hcASjvJOTUh+PG9zViRiT4lQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=pA4qNUVKqgIcfE4/gSSmFPsKDwgkkmSWrUo4xhEindLhGf0KVl1yz5/BYh533LesdEpZK8OlytE6assaBGTQvxAIEdUtZ7pn8eQtBYIdsAGSX29XC0yQ+/07bTGzQfFpF2ACG5VQJq9WeY4XgJO01ukcXs4Sg4T5DJ41TO2re3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZAfr2H5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZAfr2H5"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-68f95e37bbfso82798737b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Aug 2024 21:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723350018; x=1723954818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=avsZetUrmUaVFvNuI6iHf0CdeIN2+n8kp9n024Qka3E=;
        b=eZAfr2H5DTLP3U7DrKwRpEWRo71BdffJHld2u2ln+lKCvEU9Ulbj0uo0hO0yPB+ZiC
         lSOn1IvUL64dclxVWsFPUI5JgkZlypjOlp25zAyJw9Gf2AGlcaHrAtjvd1AoEz/FFdWP
         220qGSwP0DO4Ezg+/JSv0DL9Xo63Nhg7tzhu0QQXrQ5Af/ZJmecqQO/7nRc+pfjX71Yq
         BKOXcMIEDHX+TBTSmOaMfleDWMrb0fmRr8/ZgdA16jHCHiOFFNfeaBYhhmrZfOIUhKaC
         EyCC+O9F+pdLvHA1yiSYZ78gP0/OHxNC0XS8Vn2lVbiN+FH1AW8SZ+kbINmsNtIb1uIu
         vOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723350018; x=1723954818;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avsZetUrmUaVFvNuI6iHf0CdeIN2+n8kp9n024Qka3E=;
        b=CDVsPqQ5qoc6lPFinwgXZZM7Kj4GOjJar09o0q5p1qLbNXSEWl/VwK5zEkjxPKqgP0
         CP1vo1tAl+iBDQxG80I18c1kb0zNk9B2Lb48WFBHnTFCD/i7/4kOkGL0iYdAFRiYbPfX
         MMFD5uzudHir5b9aBp6C6BUG9M6WmF6xj8cXMpY/I2kSx/2eX5/VBk2vNdtqcI1SYFUY
         e4tFlQ2LCjikIdVd5ydV6ITd4GFWtwbDjXp8htwQG28zqgwbDtHtCgQ+YgQ5mTTXQuNr
         WfwvFBmUhQuFBCduZ3H/frF/TeZ51YUrgIRsl0jmTbc9+zKF17qGYQzWMa5RGYDR62sb
         j3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxbZwYtzsqXuVQAp9W+KcG9+MMCMc1X8zGMS07JgYjP+QKkP9JfQD97C76OYuwsl/CLSphFSXbxvq+LwozOZgKExFyLK4ZNdsshp7ZrcRGbQ==
X-Gm-Message-State: AOJu0YyHVNexr+q3Tyr7MYFOUa9u8tMR8OUZkce9zwjVSC9yW7zP8X4n
	5AKXOPlglGj6AEj1louAI4Zs6ylXP6369laevSUTG06/OpxBa4PXksq2GIKIJaiZTkTeiEkbjro
	ATwTAwg==
X-Google-Smtp-Source: AGHT+IHbzIh+vXHX20Y9SswZS44w5LYBqWDkVe1xw2pxjtcQpATlqOAhciKTaqtjQ5pYqwbUbK/fe6BIIjXZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2bfd:b612:c5ad:197e])
 (user=irogers job=sendgmr) by 2002:a0d:fdc5:0:b0:663:ddc1:eab8 with SMTP id
 00721157ae682-69ec84d3af4mr3448757b3.4.1723350018384; Sat, 10 Aug 2024
 21:20:18 -0700 (PDT)
Date: Sat, 10 Aug 2024 21:20:04 -0700
Message-Id: <20240811042004.421869-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v1] perf vendor events: SKX, CLX, SNR uncore cache event fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Weilin Wang <weilin.wang@intel.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cache home agent (CHA) events were setting the low rather than high
config1 bits. SNR was using CLX CHA events, however its CHA is similar
to ICX so remove the events.

Incorporate the updates in:
https://github.com/intel/perfmon/pull/215
https://github.com/intel/perfmon/pull/216

Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Reported-by: Song Liu <song@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/CAPhsuW4nem9XZP+b=3DsJJ7kq=
XG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com/
Fixes: 4cc49942444e ("perf vendor events: Update cascadelakex events/metric=
s")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/cascadelakex/uncore-cache.json   | 60 +++++++++----------
 .../arch/x86/skylakex/uncore-cache.json       | 60 +++++++++----------
 .../arch/x86/snowridgex/uncore-cache.json     | 57 ------------------
 3 files changed, 60 insertions(+), 117 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
index c9596e18ec09..6347eba48810 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
@@ -4577,7 +4577,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
-        "Filter": "config1=3D0x40233",
+        "Filter": "config1=3D0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4588,7 +4588,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
-        "Filter": "config1=3D0x40433",
+        "Filter": "config1=3D0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4599,7 +4599,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "Filter": "config1=3D0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4609,7 +4609,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "Filter": "config1=3D0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4619,7 +4619,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "Filter": "config1=3D0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that hit the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4630,7 +4630,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4651,7 +4651,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
-        "Filter": "config1=3D0x40233",
+        "Filter": "config1=3D0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4662,7 +4662,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
-        "Filter": "config1=3D0x40433",
+        "Filter": "config1=3D0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4673,7 +4673,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "Filter": "config1=3D0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4683,7 +4683,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "Filter": "config1=3D0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4693,7 +4693,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "Filter": "config1=3D0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that missed the LLC : Counts the number of entries successfully inserted in=
to the TOR that match qualifications specified by the subevent.   Does not =
include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4704,7 +4704,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4747,7 +4747,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=3D0x49033",
+        "Filter": "config1=3D0x4903300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that are generated from local IO ItoM requests that mis=
s the LLC. An ItoM request is used by IIO to request a data write without f=
irst reading the data for ownership.",
         "UMask": "0x24",
@@ -4759,7 +4759,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=3D0x43C33",
+        "Filter": "config1=3D0x43c3300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that are generated from local IO RdCur requests and mis=
s the LLC. A RdCur request is used by IIO to read data without changing sta=
te.",
         "UMask": "0x24",
@@ -4771,7 +4771,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that are generated from local IO RFO requests that miss=
 the LLC. A read for ownership (RFO) requests a cache line to be cached in =
E state with the intent to modify.",
         "UMask": "0x24",
@@ -4999,7 +4999,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
-        "Filter": "config1=3D0x40233",
+        "Filter": "config1=3D0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Hit the LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -5010,7 +5010,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
-        "Filter": "config1=3D0x40433",
+        "Filter": "config1=3D0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Hit the LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -5021,7 +5021,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "Filter": "config1=3D0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -5031,7 +5031,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "Filter": "config1=3D0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -5041,7 +5041,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "Filter": "config1=3D0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that hit the LLC : For each cycle, this event accumulates the number of v=
alid entries in the TOR that match qualifications specified by the subevent=
.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -5052,7 +5052,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Hit the LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -5073,7 +5073,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
-        "Filter": "config1=3D0x40233",
+        "Filter": "config1=3D0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5084,7 +5084,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
-        "Filter": "config1=3D0x40433",
+        "Filter": "config1=3D0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5095,7 +5095,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "Filter": "config1=3D0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -5105,7 +5105,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "Filter": "config1=3D0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -5115,7 +5115,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "Filter": "config1=3D0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that missed the LLC : For each cycle, this event accumulates the number o=
f valid entries in the TOR that match qualifications specified by the subev=
ent.     Does not include addressless requests such as locks and interrupts=
.",
         "UMask": "0x21",
@@ -5126,7 +5126,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5171,7 +5171,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=3D0x49033",
+        "Filter": "config1=3D0x4903300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that are generated from local IO ItoM req=
uests that miss the LLC. An ItoM is used by IIO to request a data write wit=
hout first reading the data for ownership.",
         "UMask": "0x24",
@@ -5183,7 +5183,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=3D0x43C33",
+        "Filter": "config1=3D0x43c3300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that are generated from local IO RdCur re=
quests that miss the LLC. A RdCur request is used by IIO to read data witho=
ut changing state.",
         "UMask": "0x24",
@@ -5195,7 +5195,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that are generated from local IO RFO requ=
ests that miss the LLC. A read for ownership (RFO) requests data to be cach=
ed in E state with the intent to modify.",
         "UMask": "0x24",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
index da46a3aeb58c..4fc818626491 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
@@ -4454,7 +4454,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
-        "Filter": "config1=3D0x40233",
+        "Filter": "config1=3D0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4465,7 +4465,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
-        "Filter": "config1=3D0x40433",
+        "Filter": "config1=3D0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4476,7 +4476,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "Filter": "config1=3D0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4486,7 +4486,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "Filter": "config1=3D0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4496,7 +4496,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "Filter": "config1=3D0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that hit the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4507,7 +4507,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4528,7 +4528,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
-        "Filter": "config1=3D0x40233",
+        "Filter": "config1=3D0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : CRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4539,7 +4539,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
-        "Filter": "config1=3D0x40433",
+        "Filter": "config1=3D0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4550,7 +4550,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "Filter": "config1=3D0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4560,7 +4560,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "Filter": "config1=3D0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4570,7 +4570,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "Filter": "config1=3D0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that missed the LLC : Counts the number of entries successfully inserted in=
to the TOR that match qualifications specified by the subevent.   Does not =
include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4581,7 +4581,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4624,7 +4624,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=3D0x49033",
+        "Filter": "config1=3D0x4903300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that are generated from local IO ItoM requests that mis=
s the LLC. An ItoM request is used by IIO to request a data write without f=
irst reading the data for ownership.",
         "UMask": "0x24",
@@ -4636,7 +4636,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=3D0x43C33",
+        "Filter": "config1=3D0x43c3300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that are generated from local IO RdCur requests and mis=
s the LLC. A RdCur request is used by IIO to read data without changing sta=
te.",
         "UMask": "0x24",
@@ -4648,7 +4648,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that are generated from local IO RFO requests that miss=
 the LLC. A read for ownership (RFO) requests a cache line to be cached in =
E state with the intent to modify.",
         "UMask": "0x24",
@@ -4865,7 +4865,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
-        "Filter": "config1=3D0x40233",
+        "Filter": "config1=3D0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Hit the LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4876,7 +4876,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
-        "Filter": "config1=3D0x40433",
+        "Filter": "config1=3D0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Hit the LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4887,7 +4887,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "Filter": "config1=3D0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4897,7 +4897,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "Filter": "config1=3D0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x11",
         "Unit": "CHA"
@@ -4907,7 +4907,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "Filter": "config1=3D0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that hit the LLC : For each cycle, this event accumulates the number of v=
alid entries in the TOR that match qualifications specified by the subevent=
.     Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4918,7 +4918,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Hit the LLC : For each cycle, this event accumulates the number of valid e=
ntries in the TOR that match qualifications specified by the subevent.     =
Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x11",
@@ -4939,7 +4939,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
-        "Filter": "config1=3D0x40233",
+        "Filter": "config1=3D0x4023300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4950,7 +4950,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
-        "Filter": "config1=3D0x40433",
+        "Filter": "config1=3D0x4043300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRds issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -4961,7 +4961,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "Filter": "config1=3D0x4b23300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4971,7 +4971,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "Filter": "config1=3D0x4b43300000000",
         "PerPkg": "1",
         "UMask": "0x21",
         "Unit": "CHA"
@@ -4981,7 +4981,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "Filter": "config1=3D0x4b03300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that missed the LLC : For each cycle, this event accumulates the number o=
f valid entries in the TOR that match qualifications specified by the subev=
ent.     Does not include addressless requests such as locks and interrupts=
.",
         "UMask": "0x21",
@@ -4992,7 +4992,7 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
@@ -5037,7 +5037,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
         "Experimental": "1",
-        "Filter": "config1=3D0x49033",
+        "Filter": "config1=3D0x4903300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that are generated from local IO ItoM req=
uests that miss the LLC. An ItoM is used by IIO to request a data write wit=
hout first reading the data for ownership.",
         "UMask": "0x24",
@@ -5049,7 +5049,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RDCUR",
         "Experimental": "1",
-        "Filter": "config1=3D0x43C33",
+        "Filter": "config1=3D0x43c3300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that are generated from local IO RdCur re=
quests that miss the LLC. A RdCur request is used by IIO to read data witho=
ut changing state.",
         "UMask": "0x24",
@@ -5061,7 +5061,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
         "Experimental": "1",
-        "Filter": "config1=3D0x40033",
+        "Filter": "config1=3D0x4003300000000",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that are generated from local IO RFO requ=
ests that miss the LLC. A read for ownership (RFO) requests data to be cach=
ed in E state with the intent to modify.",
         "UMask": "0x24",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
index 7551fb91a9d7..a81776deb2e6 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
@@ -1,61 +1,4 @@
 [
-    {
-        "BriefDescription": "MMIO reads. Derived from unc_cha_tor_inserts.=
ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_READ",
-        "Filter": "config1=3D0x40040e33",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Missed the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "MMIO writes. Derived from unc_cha_tor_inserts=
.ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_WRITE",
-        "Filter": "config1=3D0x40041e33",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Missed the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . D=
erived from unc_cha_tor_inserts.ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.UNCACHEABLE",
-        "Filter": "config1=3D0x40e33",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Missed the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_cha_tor_inserts.ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_FULL",
-        "Filter": "config1=3D0x41833",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Missed the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_cha_tor_inserts.ia_miss",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
-        "Filter": "config1=3D0x41a33",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Missed the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0xc001fe01",
-        "Unit": "CHA"
-    },
     {
         "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 0",
         "Counter": "0,1,2,3",
--=20
2.46.0.76.ge559c4bf1a-goog

