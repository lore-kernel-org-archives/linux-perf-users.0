Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85473D8127
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164796; cv=none; b=HTGY5JdxyyHZEmH+8hK+oTBkW3UhpGnIAS99JJEaK/En3bnYrygJgx9Z+hCbbPH13Ug2dD8B4/wPgPJyWEeywMD29PXxMPXTunkOTJKQgpz0r3v4DQ4Dbg7fJgNexWCbQDI1yZOhOHnOmVT4UtE31bis+qq9h+TCCYS3BxKpFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164796; c=relaxed/simple;
	bh=+hAJHqlA9neGxwPbbyXGO8mgwNwORpfgUWNnvOZvG0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohWk+XC6jJJpBnRIcPnV2rSU3QMIJa+IK/3ojmsWGOJ7cvWWmvGqvjDS0E21/dU8KCH07L4dBxpQNEbD0xWgO+5ZHUJeTbkKBZjWWTcE6mDzRZCM4jGqbDDxkSec2udfp9HJqf+PJ+rwqTqfrJQMGb1/i4HYWPzmNODTHyIUDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOLZZQzH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOLZZQzH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a29e6110so59226685e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 04:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776164793; x=1776769593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9CYFRKleV99FYE5YRfSxRGUGOIShzVFADPCbQgmgLs=;
        b=WOLZZQzHDWsfL8lCSa6wmFllDUTBaNUDaenSwSBEM5qWBIKiuWHm5ysOGKJBRSNDP2
         P8KY6jDmrXhBKYNWDVMO65GK8z44usI+hIx3AgWYxIrrBf56/io5kvl1e7juTfXzO3Vh
         ySnAVw6Jon/Oa4lK0K0fMpWDFIwH3K1eBBQ975xqM8dbzXsJQKMv984HhqJgOUz81kkI
         owJQdEOLd95+P4D0/6t9T8dwCYltRtJLdWMe/zXmBI8abXo/qSolcvlNmMK+4TdF540c
         H0t4Zb8cn/cJyf07VNvdYOvG1r6J6cAmmBtBNvQtMsQGtVU1TVvUUJccAKGhSgO/C4+3
         UUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164793; x=1776769593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h9CYFRKleV99FYE5YRfSxRGUGOIShzVFADPCbQgmgLs=;
        b=dTTXXHkdJcwCARUUzNHWTEZ4e1koKgyujB1iLwrKPu2or6zmP+oxCo6hnW0Cd/C8u3
         gszk/AcoqpS8ySBf42M4VGm5RR3d+/npgfTKjiv4854vrL6jHV9YMSSidBxsIHAslFyS
         +4iVGwGWhFjGkD57yk4qBhLd3zUFCvaEvhHZ7Byaw3zpd//seH0H3qSZH30glmk6u8yd
         UuVnJqm0t00lJuKohwkdGlqpExPrO6O2eOQ1EdQDzvfntnT1KYPniGRV/8tuq2V1surF
         9LUU30OMfhFLWIyPnUCq0pr4pCTp1QaeVFwdp7jgZcc8up2hevjI0MxYOnEegUlc10Ou
         lpQw==
X-Forwarded-Encrypted: i=1; AFNElJ+N3MUA44T9HJOC+z9catOUXbMbz1A+3dHRyVy+QVLK2v7Ca1JFzBBcChmae9BIqBWjekQBCwZkIUBYYq/Lh3gz@vger.kernel.org
X-Gm-Message-State: AOJu0YyuP80OLqZ3oFqDXGWoO2WPBar7hemsl7NUFYd7+87oi5l+mv0e
	AAyqpkuc/ci1s43YMCLLGBoGRJlXk8Mxg8gcBwywUCwHEC48qfgLaFnB5ah+ffQdK+LOsEOjpvd
	np70PtAU=
X-Gm-Gg: AeBDieuuhm8fB6nOjhCLjmKBWmu+0aWmDeS85p9D4S56MR2Y4JTk3umorgwk15ILRs3
	p5Pwt8xK8cCoWlf9wt9pvf+RDCik1UX1UQVV2P30fatgP5Ywqfn6kOY9w739X6dO4E1ZJj8iBJj
	CWYQj+yeCjdDBZAu6Ldd2yFYrGhvPjxlUI93zgKiFXhlgiYRWQ2t5CUi7G/5h18m87LCNDmOFV5
	L52Spe2d1ddkMmzbJF7mRSzAkvsLD/EkkvWjx7a7ikJIatkNBGk7Yn+4mz4NKOIBj8CH620XBBg
	/p40JrK+RRzZSqYCWskPXhcgH0KNK/2P+T5bHqLfhiAdUzhW9yv5CKm7a++8wR0OQTGr5Z9InRf
	lRzEZPDRiP2X97VZ7mqzzFj59hBgtCvwgF2pOSMJQ67e7DNBuP/2uDepMbzBqn4MR+qxNFfq/5J
	iHErNdEhWQba4JUXnfwxUxn2V64MaSEi/WB64F7cVb8A==
X-Received: by 2002:a05:600c:8585:b0:488:ba19:da25 with SMTP id 5b1f17b1804b1-488d6822a0bmr168820335e9.12.1776164792947;
        Tue, 14 Apr 2026 04:06:32 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d9dd86sm183254655e9.4.2026.04.14.04.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:06:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 12:04:51 +0100
Subject: [PATCH v3 5/6] perf arm_spe: Decode Arm N1 IMPDEF events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v3-5-63baf9c893b1@linaro.org>
References: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Al Grant <al.grant@arm.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2

>From the TRM [1], N1 has one IMPDEF event which isn't covered by the
common list. Add a framework so that more cores can be added in the
future and that the N1 IMPDEF event can be decoded. Also increase the
size of the buffer because we're adding more strings and if it gets
truncated it falls back to a hex dump only.

[1]: https://developer.arm.com/documentation/100616/0401/Statistical-Profiling-Extension/implementation-defined-features-of-SPE

Suggested-by: Al Grant <al.grant@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe-decoder/Build              |  2 ++
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 39 +++++++++++++++++++++-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  2 +-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
index ab500e0efe2449fa2535d6efae2a30bc2690cb9e..97a298d1e2791bb9556cf893bd170ef938bfe631 100644
--- a/tools/perf/util/arm-spe-decoder/Build
+++ b/tools/perf/util/arm-spe-decoder/Build
@@ -1 +1,3 @@
 perf-util-y += arm-spe-pkt-decoder.o arm-spe-decoder.o
+
+CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/ -I$(OUTPUT)arch/arm64/include/generated/
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 67ca356100e53aaf6d47489717537ba27aa2b98e..b74f887a48f2a13b1be165947b4e3293f9987bd4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -15,6 +15,8 @@
 
 #include "arm-spe-pkt-decoder.h"
 
+#include "../../arm64/include/asm/cputype.h"
+
 static const char * const arm_spe_packet_name[] = {
 	[ARM_SPE_PAD]		= "PAD",
 	[ARM_SPE_END]		= "END",
@@ -308,6 +310,11 @@ static const struct ev_string common_ev_strings[] = {
 	{ .event = 0, .desc = NULL },
 };
 
+static const struct ev_string n1_event_strings[] = {
+	{ .event = 12, .desc = "LATE-PREFETCH" },
+	{ .event = 0, .desc = NULL },
+};
+
 static u64 print_event_list(int *err, char **buf, size_t *buf_len,
 			    const struct ev_string *ev_strings, u64 payload)
 {
@@ -319,6 +326,26 @@ static u64 print_event_list(int *err, char **buf, size_t *buf_len,
 	return payload;
 }
 
+struct event_print_handle {
+	const struct midr_range *midr_ranges;
+	const struct ev_string *ev_strings;
+};
+
+#define EV_PRINT(range, strings)			\
+	{					\
+		.midr_ranges = range,		\
+		.ev_strings = strings,	\
+	}
+
+static const struct midr_range n1_event_encoding_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+	{},
+};
+
+static const struct event_print_handle event_print_handles[] = {
+	EV_PRINT(n1_event_encoding_cpus, n1_event_strings),
+};
+
 static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 				  char *buf, size_t buf_len)
 {
@@ -326,7 +353,17 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	int err = 0;
 
 	arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
-	print_event_list(&err, &buf, &buf_len, common_ev_strings, payload);
+	payload = print_event_list(&err, &buf, &buf_len, common_ev_strings,
+				   payload);
+
+	/* Try to decode IMPDEF bits for known CPUs */
+	for (unsigned int i = 0; i < ARRAY_SIZE(event_print_handles); i++) {
+		if (is_midr_in_range_list(packet->midr,
+					  event_print_handles[i].midr_ranges))
+			payload = print_event_list(&err, &buf, &buf_len,
+						   event_print_handles[i].ev_strings,
+						   payload);
+	}
 
 	return err;
 }
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index a457821f3bccb67691cfd530de2f1c5bf9d8d50c..a3300bec4990a76608d23e34368d6146c9f4a5b5 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -11,7 +11,7 @@
 #include <stddef.h>
 #include <stdint.h>
 
-#define ARM_SPE_PKT_DESC_MAX		256
+#define ARM_SPE_PKT_DESC_MAX		512
 
 #define ARM_SPE_NEED_MORE_BYTES		-1
 #define ARM_SPE_BAD_PACKET		-2

-- 
2.34.1

