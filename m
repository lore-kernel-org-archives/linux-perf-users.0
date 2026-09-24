Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1254A8A2C
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269474; cv=none; b=LhElpzwwBuCzAcoqAjSBt3WRmV57Q7OrVQRyBCCFukucF8PcZWxoOiMan26op1Xf9TSvLphVBCTbq5vdN3v5Frbwr47ieKWfBkCP2vUnlupbjVu+f42Rlsw9tKDIF+Th54SuKSzUB3WI/MOYdn7S/v4GkKmyXsianPZNMIz8b6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269474; c=relaxed/simple;
	bh=gtUlwQvht4kO2ltpQzzq5b+cBczGRagz8mXMIE1rkdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AvHka5Hiit7+5mpAS7HIDVmjrYhCF8knVM+K7vpBKeq0m48YMrVgEAMoLWhjgkBwuP+0RVP3Mce4dBWlxA7rVBTrRh92FVylkvaftshgrH+8D7Z0k+w+8yYbw6/FIrzgiB8o1LXFZ9htK+NI3WiJVtEkPlbyhzfh/l6IwNTBfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAxsUxdN; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAxsUxdN"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30f1b904861so3213397eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269471; x=1790874271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mYOxxVFbAfN3u+LM+zVjfhOEqsElL90J9e45Teq+iJI=;
        b=HAxsUxdNICsFPjlRQxQz2nhhBWwRK9NfwyAqvchQJB0exrReEhRFjh2oJh+CNq6xmV
         x9CMVbubFTpvopM1xUZKOdQKyh5yPm2NBXg/Gg8LMPzl3WAuN1parzRzU9DizrJiAH92
         lPnzF5kncPGL3Fh4RN9tw+8GkIA+e1vHc9huD5F/c9ZSPkY97UqXsuK5mtIwwPwgO+Rs
         tdrOnCKT0c9o5ocBLxRL6MuePfHP2vXNdcCtKU3o72ZuBOoXIAJ/2H3mRXDa4eDuBElN
         DOwjv5ZTIziI+NHF3fQ5ECtTRrELduuVsdLP9nWlpS5KyuatSC0b6NBHHk/koK7TUd/L
         hVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269471; x=1790874271;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYOxxVFbAfN3u+LM+zVjfhOEqsElL90J9e45Teq+iJI=;
        b=EBCPug6MIXYEaZ5hXNKN1CZX7Fa6Q3Q0UJVzUvv+pboRJgMunufigND6DxBGWVNfG7
         Bm+tcULivZPyuX9bwLJG5ySdha2t6L4j1XkKbjIi28d9SE9Rkhq2ZIJ2HV1gMvz670TO
         1rB3apF7UV5iyTioyGozZfElz9ZVF+eKBEbXdiZRnpR/BGrNPoWnvUYAfFpRuXEvoUEc
         VSDSYpvcHhL6xkLeAqjmC9lCSk1iR4/wdo5nj4fa3Qkk3O2nfdSHWfcEAHJCzPxseIO6
         LsxuujNX5U1phGdyPw5VrUHhqkLH0stf2ayDrJuFS7WbTlHVAj8Me9Aj0VrZ95EcOfNf
         3bqA==
X-Forwarded-Encrypted: i=1; AKwUvBzxro5Xedm6qfM2HibjLwtKX7E1vaeseepCn8ovIDEYQ8gzw7BBYr+LX5dXbwkKp3bWn2/8dUzObqPvnx7bQneU@vger.kernel.org
X-Gm-Message-State: AFuF++kSm06YWXg5Nmi6ShHeA0QfqHKaqVohLWjKHvy7A2ytLjLa7Gdy
	/CM/VFenc4l1GBaW2UYFo/Ts2TiyoP1KC9bjfjhPgOA4pI/x7bw1FtwECaHL/hc/VyCZaQi5dP9
	49kS6DMSGQg==
X-Received: from dyay17.prod.google.com ([2002:a05:693c:62d1:b0:33e:55a2:f3c0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7a9d:b0:328:3944:ee53
 with SMTP id 5a478bee46e88-34003ca853fmr2602617eec.2.1790269470520; Thu, 24
 Sep 2026 10:04:30 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:34 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-15-irogers@google.com>
Subject: [PATCH v2 14/26] perf vendor events intel: Update meteorlake events
 from 1.22 to 1.23
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
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
2.56.0.rc1.315.gc6ed9934b7-goog

