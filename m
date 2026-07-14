Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498564C77BE
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061659; cv=none; b=RU4VpL0v6OF2q00K/RTXiL9Tq6ErH3By5xFbXZ6uHdH+a3b2vHtdy54bRLX/VXXnX5+/XgUQYIuVpW5h8Voq21ZH9xX+MthkZG0Al+8reCxWUOwCvHjqD5DqNa+KkgHIwPVHvKPOkSpzhc0vYOtTwMzZsnzqHB80swtslqOrwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061659; c=relaxed/simple;
	bh=to6meEhc8IPlp1upoGAwozLO6sq7N6/JHUwyC4HVNXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RAfRn5DcEz6Sr+9/rwjPJlmi330UHG/WztfosrQ2Wv8E3RSewORixkqOkBJ76G0PWuZJl6CRjfV73jxTecdVJMvEhR0XzSW/Ev6pSA59xShClHBHuMxl9q0XZjqfpL7Ewi55EzJK0tsUMAKCNR4T29L20se6lJjssVfTzkwPXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M++bxEPq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M++bxEPq"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso7616310a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784061657; x=1784666457; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5/MPJeWkUjncly7ld3xI1JmCeSqq6+OuhJDz7/bMdw=;
        b=M++bxEPqcmPRcA36fePCdVZN2k7tkqrQWZH9ghSQbBv037pYTULDIJrfu3mjwNFV46
         j00LLvbA49X4H8qNTAD6PyMJQ16Z+aw3pjaZxIZVOZw/Jc1T7Xe9qd/GeJVUBIEQw2Xh
         lk+5fiOflUS3Th84XnYkJgw9bAvhcQzB65NMaSfhYi/Nia0J1FZCJLu9MX8C1Bm6p8F1
         AxVwTLczfKt/TRu0zjM+3v+ZwrFBK+s8gltFKzDqr2Og9Oh+zUajI19xMVuAL7OGhT0s
         HqIRyzK/o4rXyNWZ2BNTIrr6UqNxfiKhgDdP9RZo6C9aal0s2o57x00mIFDDHHOewKFV
         UMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061657; x=1784666457;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i5/MPJeWkUjncly7ld3xI1JmCeSqq6+OuhJDz7/bMdw=;
        b=jYnUi8doGKpxjjjQRSwDZCD5+b88NT3jIGLyAv3RBQtlFLZDGJumuiyGkv3qeUbJjS
         9jJBhZyfrUOnykf9U6kiTgMt9D4sMQIW5Aeimcjtpl2f4J+HIzSJlppK2elClIC2nUD1
         OercfKONqrKO8UNt6xYBlVb8qrVhyNuaj+Rif+UHA7+MHlC6Me4cc65vM0IEE0FzSnp/
         uSq6RpEwX0kY41Xgz/AflBvTCipX3MELXZMHLeoNJstRAaZELMYgh2fHH+xnBgi+WJWM
         cxyRJ+FPX7H6I8li+8+CMrc2LIUhKW7ND3mMTbBAjxQBd9MvosAUFYWqsncRZ6ZITX2P
         rnCg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1APxS8JLN7yMh52IVZej8A/EM3/8BHxLiy+VqxOa9Yn11bWKVJQs6wHO5DW2g5XmdFwvSstklznwcRC3qCo5r@vger.kernel.org
X-Gm-Message-State: AOJu0YxwAegYmSQNrHBqHXuJBqNBcItP6AcaN/zPw5peVJgHRwsLKoHL
	/fGjdoVlwLHReMZF1ZVilmjrXh+54Ud62V4MpyvKZ7VWx7ZhQOEwRinQFMPGJfH+HG6etVhi0O/
	jKjVMig==
X-Received: from pgbcs10.prod.google.com ([2002:a05:6a02:418a:b0:c99:d21a:f6b1])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:320b:b0:3c1:d78:6450
 with SMTP id adf61e73a8af0-3c34d8bc7ccmr6640582637.66.1784061656566; Tue, 14
 Jul 2026 13:40:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:42 -0700
In-Reply-To: <20260714204044.1952031-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714204044.1952031-12-ctshao@google.com>
Subject: [PATCH v2 11/12] perf vendor events intel: Update sierraforest events
 from 1.17 to 1.18
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/d1bc6c1e8b32e7a75c70cc939295c11ba9aabc96

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sierraforest/counter.json        | 77 -------------------
 .../x86/sierraforest/uncore-interconnect.json | 10 +++
 .../arch/x86/sierraforest/uncore-memory.json  |  2 +-
 4 files changed, 12 insertions(+), 79 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/counter.json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 3fffca669710..e5d90825041b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-6-(CC|D5|E5),v1.07,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.39,sapphirerapids,core
-GenuineIntel-6-AF,v1.17,sierraforest,core
+GenuineIntel-6-AF,v1.18,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.37,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/counter.json b/tools/perf/pmu-events/arch/x86/sierraforest/counter.json
deleted file mode 100644
index a92c75109e6a..000000000000
--- a/tools/perf/pmu-events/arch/x86/sierraforest/counter.json
+++ /dev/null
@@ -1,77 +0,0 @@
-[
-    {
-        "Unit": "core",
-        "CountersNumFixed": "3",
-        "CountersNumGeneric": "8"
-    },
-    {
-        "Unit": "B2CMI",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "CHA",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "IMC",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "CXLCM",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 8
-    },
-    {
-        "Unit": "CXLDP",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "B2HOT",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "IIO",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "IRP",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "UPI",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "B2UPI",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "B2CXL",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "PCU",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "CHACMS",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "MDF",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    }
-]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
index 251e5d20fefe..1f6e0970141a 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
@@ -814,6 +814,16 @@
         "PerPkg": "1",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of Write Transactions as Secondary",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
index a9fd7a34b24b..8b7222a3708b 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
@@ -499,7 +499,7 @@
         "Unit": "IMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands. : Precharge due to (?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to page table : Counts the number of DRAM Precharge commands sent on this channel.",
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.PGT",
-- 
2.55.0.141.g00534a21ce-goog

