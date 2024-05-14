Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CBC156E4
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715664252; cv=none; b=BX/XZnebPyfEsQ7Hl1J01ait/Sq82ACADRcURGTg+XKyaQpSaO2d5zdMB3FxmTI7nDwvlkKheooRbAsdL6VWhjDZ5GCZ/RT+PQ/Y3MJLFD0pp+PPZbyLB9ecTWKiq3aSIgQ/Qb1hq9JNyMSFscAatttMiQA1beMjTOfeMgg64JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715664252; c=relaxed/simple;
	bh=xYjH557dYWB2d8/5HQKZEVQpIIfcAGTGYy+PxA0o/vE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=JbgkNBFZHvuogHos2tsoz6TwuMnBt98YDTTvJIFdCyTCtQxkitlw/nCGU1UToh/EN/ONraeBIT79oO/Tf7id/OBdVeGmBLfWoAxcYjHxDCn6qhkGFcRRov/L+FLGEKcbrjJJuk3ouS7x7QJPoQHv+x+HNHv2kjWL8Fh5NxD5pUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4DQzo5I4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4DQzo5I4"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de8b66d59f7so7540111276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715664250; x=1716269050; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRn+JnVwl6IEnu61W6Gn+QDoOOES1k1Rqc3j0WDLThg=;
        b=4DQzo5I4bDmCzxGu1Nm+VFbLG1romp/CVgwP5cV32jMM5N1RTCUdIxtH0BBEXmgMEA
         iwKEoeVuAykXcXRBVrrTVAdl91QAVjKYv09ckXxynhmyBxJgn0oL2GS8wzMBkXh4E0CS
         RjUTqm8jwkEjmeu8baBUXdGsOb6mHQMMNQIKxKoEZZ+iRYh0xxGcLK2SBBm+uhJELZGJ
         hDfjwMyQP+taQaoJ1KdgFRFnCCoDb//MSiTtQv5Ld6O20cTP55hLeVLNS7ttFFKwDg7z
         NFD7Pw8HOoXlBskBNKPlIc2K2gKr75PBfMIhXCTFagA4ghv3MzSoe1j251BlHoq2oI73
         gmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715664250; x=1716269050;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRn+JnVwl6IEnu61W6Gn+QDoOOES1k1Rqc3j0WDLThg=;
        b=rywx79iyVZuy/2VZ4UOClLEHDoW8KOMA1rPbD/QsD5zAgBmed3oNC0Oud3SnuWOhcm
         g2fD7vAKbiwYUSUc0flISuZpN99xD2N/KZxNi85fhN8+3HKOlNrKIXOTwsybcL81o4ng
         jP19piGOQaCOh1m6TmsutTwbWlyagvQ1Lu9bhT19Yss7G7VuAksbMSiIzEVRBRDxx3CZ
         8njBG73HozSAywtluSm1lj+1ZRyrf6zRVpMWHi2qoOsaB6BpW8tRbjJOGP8q9WvI4fAv
         7RIU99TrDNrWAl1Q5W9OVW/5rxOeXO/fn/27NpocCFawRlms4EAKeLLQAxBbKH8BB2Oj
         bs9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYq2CCVtDTNOAk6ZHbBH5Qmqfs4+atvPiupfJ8xywei2ipl5VrUNb5h5ZIsjxFQ3PF2TTEGuVUTeOPXPwCTUtEoqPTIfT6wb5KROaynI10fg==
X-Gm-Message-State: AOJu0YwDY6a8bV7+xZiKkoS6FUvVz2djB2z0CGvuesaWIlXStfoSItN+
	NgJ6SdyWe27FPoKzzv2VvOkjD/Qz6jfg0LIV4c2ZitZRYekTyz59sPyl7HATX6C/0F55jB8BWI3
	ulsLKbA==
X-Google-Smtp-Source: AGHT+IG4VRGn/GKcVi3X2Zn45IYZUTpeS6Y/zFvj6MaqetVuFKTdhDz4pFXbcXfO8FwrUYoTqi6n67cjD3LS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a05:6902:c0e:b0:dda:c4ec:7db5 with SMTP id
 3f1490d57ef6-dee4e57a059mr3480030276.4.1715664250139; Mon, 13 May 2024
 22:24:10 -0700 (PDT)
Date: Mon, 13 May 2024 22:24:02 -0700
Message-Id: <20240514052402.3031871-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] perf arm-spe: Unaligned pointer work around
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use get_unaligned_leXX instead of leXX_to_cpu to handle unaligned
pointers. Such pointers occur with libFuzzer testing.

A similar change for intel-pt was done in:
https://lore.kernel.org/r/20231005190451.175568-6-adrian.hunter@intel.com

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 23 ++++---------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index a454c6737563..7bf607d0f6d8 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -10,24 +10,11 @@
 #include <byteswap.h>
 #include <linux/bitops.h>
 #include <stdarg.h>
+#include <linux/kernel.h>
+#include <asm-generic/unaligned.h>
 
 #include "arm-spe-pkt-decoder.h"
 
-#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-#define le16_to_cpu bswap_16
-#define le32_to_cpu bswap_32
-#define le64_to_cpu bswap_64
-#define memcpy_le64(d, s, n) do { \
-	memcpy((d), (s), (n));    \
-	*(d) = le64_to_cpu(*(d)); \
-} while (0)
-#else
-#define le16_to_cpu
-#define le32_to_cpu
-#define le64_to_cpu
-#define memcpy_le64 memcpy
-#endif
-
 static const char * const arm_spe_packet_name[] = {
 	[ARM_SPE_PAD]		= "PAD",
 	[ARM_SPE_END]		= "END",
@@ -70,9 +57,9 @@ static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 
 	switch (payload_len) {
 	case 1: packet->payload = *(uint8_t *)buf; break;
-	case 2: packet->payload = le16_to_cpu(*(uint16_t *)buf); break;
-	case 4: packet->payload = le32_to_cpu(*(uint32_t *)buf); break;
-	case 8: packet->payload = le64_to_cpu(*(uint64_t *)buf); break;
+	case 2: packet->payload = get_unaligned_le16(buf); break;
+	case 4: packet->payload = get_unaligned_le32(buf); break;
+	case 8: packet->payload = get_unaligned_le64(buf); break;
 	default: return ARM_SPE_BAD_PACKET;
 	}
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

