Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6512C474
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316196; cv=none; b=SKHJHFvtGAgvdLMUNnvs4Q6H8zWpniYsgMKSa4Q78pA9DEg10ROLivkr5R/5HfdTox401wTOkpDpv+uzeXy+tWte5yx7RIEyTDa5ZCU2xGo8INwtvK4By0LZ4FMX58NLfL6/riyCjR6A2MpTDPMhzEFSpq3c8PVrTzxmqvQE7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316196; c=relaxed/simple;
	bh=oQnAg/XHgmHTaoNbQThZNL+nThyW0lkh2E2uvTmBiGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urHWxzmAL5Zot61OO7vIblaeZ4+Uo7KsqCbYJhFcjcx95hDdQBhFQkAfarEBLMEmKB6a9H5zALtNWaOHgzHczNoJaw6PDf02PiWEQ3bt5692rCoEpGbqNFch/ELse9czZrF/8YZZAqVuVvwv86HFXmO6rdSlyGxGJVEWhPSCeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CEx86e5W; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CEx86e5W"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb510cd097so324672a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721316194; x=1721920994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hlSS9tFK0jyY2/f4QS94AO70MXLW8ulRLZCmaIHwXQA=;
        b=CEx86e5WibVjYiMHWXvj/5ZhcngmJvfCXfdb4Rz7Tu1MeQo+aa2zEvGmZ0S7iUox/9
         VaNrZxcX2rGCu8Y59KnZ6jhHdtSklHLqrKdquVvPag/FatSUFmvxVDTXanlkLvp9fS0O
         U4ze9qQx8IJi2usrQYnQQDpEsg78j3tDuHTokYpeB6LmftxsxWJ9z3Pu3EHKxmlPV5oK
         fRZP5qNYMQv7MiOAxXEy/nIpHSdCfwyfrdcm0Ps4+dW09bfpbr7guJwuPLDlEQummYIW
         2cXHG8hj+XV+sKU978wjB2YIJIejrKgKICQqtTqTlwEYQp+/TEmBdelsaQOJEil57x3O
         FfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721316194; x=1721920994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlSS9tFK0jyY2/f4QS94AO70MXLW8ulRLZCmaIHwXQA=;
        b=v7aTowGY/LKllhJaRfhTraF/t0VfwDeHiJfF4IniEiB5D6IGix+X0Js0eSXvDpPR6t
         1Hc5VJW4TrUgcXrRo7Xdmre8hDqA1+dLuOB41TL2RZv+xM2qR1PTe0hsZtef1UySBBor
         50qbpNroHZ7qTXAmZlkhks4oVnPtwBAUnUrrtsTVRyRMSIudVyK3JNk3DqOfxY87s5mE
         pbcLcZpCbDl7WpgBX9P7F0e6qPDORxLFO3msM2bP5l59rDRZpY7w237TzY2ytPd+tXpj
         J2DvwW2zdUnrCpaAJpPdrQuYuxvzJOmKBioiXu/cSSImw0lalNvfeIwfsUA3Jkj0ukM/
         RVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMqdiz57NTFSJ2stVdQZqmedCxUGsk6er7MyJYSvYUFNDwUE4OEYpQDFi4Lu/sTXkefLSSZFvTC7OqAgIqZJAxCkHDtAp8cEiTpGdQUP7n4A==
X-Gm-Message-State: AOJu0YxfXfs6L+HT2c4qKCjuGVofktv6uJaPJALQ1gv2oAQsp5ZC7sn+
	3G/Fdl7HiFGjSnDYJX+weFpa4FTu8A7+Nxu4LEZWR/vvo0lfpJkOojKaNd41+Yg=
X-Google-Smtp-Source: AGHT+IGYiT8Y8eVtORah7pg5+CDI8AQnZirmt9fO5DQfBE3quaBqJnjCZLTnRCt2ZV4FKuosjPfDtQ==
X-Received: by 2002:a17:90b:144:b0:2c9:66d3:4663 with SMTP id 98e67ed59e1d1-2cb7755e41emr856950a91.43.1721316194279;
        Thu, 18 Jul 2024 08:23:14 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77a01046sm810525a91.14.2024.07.18.08.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 08:23:13 -0700 (PDT)
From: Eric Lin <eric.lin@sifive.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	peterlin@andestech.com,
	dminus@andestech.com,
	locus84@andestech.com,
	jisheng.teoh@starfivetech.com,
	inochiama@outlook.com,
	n.shubin@yadro.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Eric Lin <eric.lin@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH] perf arch events: Fix duplicate RISC-V SBI firmware event name
Date: Thu, 18 Jul 2024 23:22:54 +0800
Message-ID: <20240718152254.16007-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the RISC-V firmware JSON file has duplicate event name
"FW_SFENCE_VMA_RECEIVED". According to the RISC-V SBI PMU extension[1],
the event name should be "FW_SFENCE_VMA_ASID_SENT".

Before this patch:
$ perf list

firmware:
  fw_access_load
       [Load access trap event. Unit: cpu]
  fw_access_store
       [Store access trap event. Unit: cpu]
....
 fw_set_timer
       [Set timer event. Unit: cpu]
  fw_sfence_vma_asid_received
       [Received SFENCE.VMA with ASID request from other HART event. Unit: cpu]
  fw_sfence_vma_received
       [Sent SFENCE.VMA with ASID request to other HART event. Unit: cpu]

After this patch:
$ perf list

firmware:
  fw_access_load
       [Load access trap event. Unit: cpu]
  fw_access_store
       [Store access trap event. Unit: cpu]
.....
  fw_set_timer
       [Set timer event. Unit: cpu]
  fw_sfence_vma_asid_received
       [Received SFENCE.VMA with ASID request from other HART event. Unit: cpu]
  fw_sfence_vma_asid_sent
       [Sent SFENCE.VMA with ASID request to other HART event. Unit: cpu]
  fw_sfence_vma_received
       [Received SFENCE.VMA request from other HART event. Unit: cpu]

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-pmu.adoc#event-firmware-events-type-15 [1]
Fixes: 8f0dcb4e7364 ("perf arch events: riscv sbi firmware std event files")
Signed-off-by: Eric Lin <eric.lin@sifive.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json       | 2 +-
 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json        | 2 +-
 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json       | 2 +-
 .../perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json  | 2 +-
 .../perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
index 9b4a032186a7..7149caec4f80 100644
--- a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
@@ -36,7 +36,7 @@
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
   {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
   },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
diff --git a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
index a9939823b14b..0c9b9a2d2958 100644
--- a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
@@ -74,7 +74,7 @@
   {
     "PublicDescription": "Sent SFENCE.VMA with ASID request to other HART event",
     "ConfigCode": "0x800000000000000c",
-    "EventName": "FW_SFENCE_VMA_RECEIVED",
+    "EventName": "FW_SFENCE_VMA_ASID_SENT",
     "BriefDescription": "Sent SFENCE.VMA with ASID request to other HART event"
   },
   {
diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
index 9b4a032186a7..7149caec4f80 100644
--- a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
@@ -36,7 +36,7 @@
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
   {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
   },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
diff --git a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
index 9b4a032186a7..7149caec4f80 100644
--- a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
@@ -36,7 +36,7 @@
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
   {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
   },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
index 9b4a032186a7..7149caec4f80 100644
--- a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
+++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
@@ -36,7 +36,7 @@
     "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
   },
   {
-    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
   },
   {
     "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
-- 
2.43.2

