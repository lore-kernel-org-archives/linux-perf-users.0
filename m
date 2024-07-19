Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F478286A
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389854; cv=none; b=OIYgS6VU+PX/RWu8lTf1erAzS13sN/2s6MPsDMBWRHW47GW2107lr+keutKNwh4xelqiw1lnQNRS85PTXeU8lKK5z1IwgALfr08ceEaM4HL53N3+L+g86q4tPG4JSXt8ddefizmBYqsCbcd26GJKJwo1JP7GYgiufHzUm2xkeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389854; c=relaxed/simple;
	bh=2nXJRqyZ94MzNB6+UT3+UIBVzKXxjI53h+rtn8Ad9gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdxyn3CoAZLhoml6ETB+EDlreq51ZNN6HxGlgEyGyhk1EtcLARGHqcnN6XNOi3ETD1pQjC1LWQr/YZQAj9WDEsI1fIszOvfYDUdaITzs695pQ36T5pnONcP2y+Wac+lKYTFwTNMSfGH7YTyBsUeS3+KYzRzlyQXTA+zETzJmKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=P2r+g3xN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P2r+g3xN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd65aaac27so3220965ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721389851; x=1721994651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVtxIMKdmscS/o7u8DiflVJHHXOzMHg1+tf2aCpyfEQ=;
        b=P2r+g3xNXQxwaan24QeHHSg0S7+e9r/iVpXXQA73lnG+vVXdkJ2Pokqj3wfcmxNTKD
         Ht2JM31BLDJRukniF4EYCUCAB/0Wq9Q4qiZiJSowfpClBTrlqlMGcvRhlEf0KTNUNwsb
         JKZ9CwX5TMhHI1VITZDVklSez0bWFzFgRgXXYQRk/LQMBPPxeV3pUisrUbGgKIezKCU3
         iqyKgUs5P+IWhFXWSAzqHa5belppXDZJg6S63SqKAzjjnPD7mQerNwRp02MCodyBSJg1
         jYDjv46tLAc5afagOyjm4IwI2bAQxeWr5Iu96m4N9fPc0tMEeHItp6Ba6XQNMZArfYT7
         F81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721389851; x=1721994651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVtxIMKdmscS/o7u8DiflVJHHXOzMHg1+tf2aCpyfEQ=;
        b=P5dzZ8IE4NFGW2jbT6xCRcQYwtiVxL+S2ZQ/aaK4RTarSZwkSj3azmbyuzeOLSl5hw
         bb/j9YZwjgB0ngtQb40/Q9Y6F/O3FNl3KIClepwzGMrqvfp3J1sEVI+Fufam/6kEME5i
         h7RY21AzsGt9EhVOw3THzKYEUU+R08XaUu9f19RRVNfL/toNhO6H5DDS6VtmL0gMI/LP
         hRNhAb/AtafG8VbPHrXu/Z+gO82j3sApFUPEgjrzalZQ3rnH7/7D5RVF1Xm5XlR8Csej
         EUsC945Q5ocNDCWbfG1LqUfM/sNO7Y1dNYv3ZaJyxlC5VXUct8QUdaydnS2nIGS6pOpL
         fvvA==
X-Forwarded-Encrypted: i=1; AJvYcCWF8NEGnYqQhuv3FEPJJFT7J2/sstyzWCeVpLvTk0OFff0OhG4snpab889UiUz6QH8diZkY1yndj5OQJKbb95SH+HfzlZb84Qm+Iv5+x8Jrhw==
X-Gm-Message-State: AOJu0YxzqXnEu0TekdVVZIXDvB7eN9dCyDvLF9nKX1CrTlPDyV3+x0Ef
	K3WiVspfXy07c7dX8vJ1CasnKM9QZrSqbcoMF0gL/ItInbuYY5JGZE6OplizT9A=
X-Google-Smtp-Source: AGHT+IHiq2nRMIb+cCUNS9RgmKaSW0ZowUVhXRGuZHjMWBQJkKfjSbT351Hq+x1XMf0TtCGjGJZ0ug==
X-Received: by 2002:a17:902:e54e:b0:1fb:6e83:7cc5 with SMTP id d9443c01a7336-1fc5b58436dmr84582635ad.2.1721389851242;
        Fri, 19 Jul 2024 04:50:51 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0a3deaeasm236589a12.1.2024.07.19.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:50:50 -0700 (PDT)
From: Eric Lin <eric.lin@sifive.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
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
Subject: [PATCH v2] perf arch events: Fix duplicate RISC-V SBI firmware event name
Date: Fri, 19 Jul 2024 19:50:18 +0800
Message-ID: <20240719115018.27356-1-eric.lin@sifive.com>
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
Fixes: c4f769d4093d ("perf vendor events riscv: add Sifive U74 JSON file")
Fixes: acbf6de674ef ("perf vendor events riscv: Add StarFive Dubhe-80 JSON file")
Fixes: 7340c6df49df ("perf vendor events riscv: add T-HEAD C9xx JSON file")
Fixes: f5102e31c209 ("riscv: andes: Support specifying symbolic firmware and hardware raw event")
Signed-off-by: Eric Lin <eric.lin@sifive.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Nikita Shubin <n.shubin@yadro.com>
---
Changes since V1:
 - Add "Fixes:" tag for every patch that copied firmware.json
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

