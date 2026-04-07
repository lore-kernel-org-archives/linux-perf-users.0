Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF13BA243
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570763; cv=none; b=djP7BZTeOyiDs6GMuWP816+jJYLzf4upsfFZ8vffji6qeWn53J2QoOj9JmIZ+1nP72oNoYvCv0rzHf2noCkjW/LE3Toe0l+uJPF1L/6sIc6L+D/kCb2ZS2fFtXuyem8gmOekzPMiej6DRYKHlzzsoLJuVo2wEKE5IgVUbtZYCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570763; c=relaxed/simple;
	bh=SfHRtjxTdWpox2uy5+oIJcperwjPdyLz6dz50gZO0vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1YI/W5H8Wgi6e1rpWt7IqYARhomPtPTlOf+5EqQ422FzMeFyXJ0dPcCDN9ZTtiwPe/4cjUVJIPPJO0+f8T/DwT02xBS6eFNsD4uiJreTTMKQRibanSWoI9jG/ZpKKpo9svqnUSz8a/3XNDvf1rfb+8AQnlrdihTf1uxZIx4Evs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hwMI3V3y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwMI3V3y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so14306145e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775570760; x=1776175560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLZ04h5XV7RbRTSYEuzKScz0bb5tSDren7EYv5i83Is=;
        b=hwMI3V3ygmsntkx/I7pE+ga9V5Xjt8lp5A0b4JQ4pQtxjF+/wdgk5yhcLoR6oZGkOR
         iZ81cJHHa4qIav7wbbhtnlrSAvBXr5HqxIkLko3CCgfbn9Erz8SdrNv8mmoj4/goYNSR
         2CqsfJaeaT7bBCDRrUykbQ2c5N+TGD0QnFs0fczU2AtBuDB2S7As9u7oNGk8v+l+LQSI
         2SJHscHgvDSMceNXUe4BD+as7GskFAucqQu/G3PHl9z/MKuQrpDTymav6lYH1c/3EsuT
         ZzOnZ4qLXD16uZOGVvKYtr+5jXLwSbrjR2MCy8SFtx5ROxQ5xDxYbolC/oCTmZP4Caeh
         5oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570760; x=1776175560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eLZ04h5XV7RbRTSYEuzKScz0bb5tSDren7EYv5i83Is=;
        b=QlrWiOWOHkkf4WofZhkCndPQlrcIKqVJOuw/wyT+WmZQsdW5aB9I4L7nAw/uCYC2V9
         HlGRFqasERx4UK0jsvSBHlXeq7+E/2hshKouyEZP5/4+ST7kkn15XqME47HyADtULiYv
         N1YupLI/a8M4Hz31SPvtuKmudqOXdEeOX3SI+HLsG+ycPmb6+V9CzD2ZTY/vLqur0P7Y
         9wCNmh5cqxkqPHRx7Riec2KsLYHks6T83xcuDxWfzuG8ggnjiWB7UZ3J8tI+35sJlDeY
         5IAvqIZbomiyGQ7Kudt+72fEtLgynnKH0zjTgq71I2m9pVlVlfphMRwVFqmAGE2MqM0V
         UWNA==
X-Forwarded-Encrypted: i=1; AJvYcCVx+24ln0zhbnmygmhDJJJ0WgmeVmt6NrsnhWnEHokGBA+hS2KH9ASAOhBO+4cTL9V3odfv8CQ6XAYAqBi4/zSF@vger.kernel.org
X-Gm-Message-State: AOJu0YyEy7ex7zIKx2cKZMpV0YIaKPuQSMt85I0uXiOTcU3zgMgQnXVm
	aG0KMgsSuXrE0fYVqiYmNXRt5DY7NR9M2RS9y27+WC4moROErlP0Pv68Cod7GcCGMuI=
X-Gm-Gg: AeBDieuwe3v+uG6XoARNJilUEVX1oLHy44hu3SOkh0XxiCvHs/GWWwwoX1BH79FeibI
	68kKjwDZakPDfCEzRBqjJ3o5SY1IByOAbeWntiF5rTrqO/7OqIsu3yiYVhL6RwyS/vsCZTEWmXd
	aCpPXSntUtiCA3h9X1HW7oNENWL3wL0UjYajZMcWxm95zaDtWLRhjJccwBW0HNc3nMOYAnEwsyk
	i/00ZKotXndqLynEOzVEmlvh25ji/u40SPQiC+bA0iRVU9GACf2juPLbSXhqgDd8Cblf/xNn7o/
	5XHr+aPsQ3FFr5o9jUPxzyg4hMz/yP5ziHsuemih1/CrlBO2H1knLb6pfUnoQUVetCGNFxjaak0
	q1+20GAM0x/if2+4RejuKAGLoX/3wZqqeWEtXzLCHAawY9HLNxgzvHYqhDfiiRTRic/5li+yVPR
	FKJSwj2D9bLN6uGRG6PkM9pnNm+083H4QmnXSiw0NWW9c=
X-Received: by 2002:a05:600c:181b:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-488a8820213mr94479095e9.25.1775570759631;
        Tue, 07 Apr 2026 07:05:59 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm626876145e9.4.2026.04.07.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:05:59 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 07 Apr 2026 15:05:19 +0100
Subject: [PATCH v2 5/6] perf arm_spe: Decode Arm N1 IMPDEF events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-james-spe-impdef-decode-v2-5-55d3ef997c48@linaro.org>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
In-Reply-To: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From the TRM [1], N1 has one IMPDEF event which isn't covered by the
common list. Add a framework so that more cores can be added in the
future and that the N1 IMPDEF event can be decoded. Also increase the
size of the buffer because we're adding more strings and if it gets
truncated it falls back to a hex dump only.

[1]: https://developer.arm.com/documentation/100616/0401/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe-decoder/Build              |  2 ++
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 39 +++++++++++++++++++++-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  2 +-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
index ab500e0efe24..97a298d1e279 100644
--- a/tools/perf/util/arm-spe-decoder/Build
+++ b/tools/perf/util/arm-spe-decoder/Build
@@ -1 +1,3 @@
 perf-util-y += arm-spe-pkt-decoder.o arm-spe-decoder.o
+
+CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/ -I$(OUTPUT)arch/arm64/include/generated/
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 67ca356100e5..b74f887a48f2 100644
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
index a457821f3bcc..a3300bec4990 100644
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

