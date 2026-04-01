Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DA37CD4E
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053587; cv=none; b=I9sRbqxUDvbEzNNUjEoWSgX+mflQCTtYlLTDpgi6xcaqnIrTTvbzP7bCeUGeW6U3ocM4WShSXS3rO+odQ+bbXPf968DYQosshd7LvSyJ+Nls/JqZzcRBXqVfceer+U9nF5oFlLfLsgny8PS6jowvcM+f0U3ze9O5dvyln+eCL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053587; c=relaxed/simple;
	bh=Eooq+5bKb0xsDs+PjIdIUDN4p8LZJFeXS5YmCx+E18M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQqGL2otYNxnN3TZsoIazU0NJutOcclyj5Rt15BJbYIv9i8StHAQ+lN9LZFZFBP3bZJCSB+hrZfx1eQE52y/suGqqE4ImxHSlOAhedrMZSPyf2HsAhjKLyJH3isq0LfDRjpIF9UykySkkouRUXXn/nTufL0t1tPqHAzVEz7O4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gu+bk6Jr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gu+bk6Jr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso58404275e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775053584; x=1775658384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osWrxEAqmZXiuVvpI8iKF9LeT8juwh9RdnQ1+Y4xO5c=;
        b=Gu+bk6JrQsscwepLcFfJpxRJaoSPVaCz1YJwlpYeQbMxTAHxJA+jBAm9Icjeg8Y6N5
         AAH+QdP60mE1SCB+cvZ7tL16TSDBl5CrieRxz8CcwTKAqO+12hRsc9oGlH2AhfsbMJ3f
         +t9PhkKUjzxYYpntIMI7zdPXEEhL2cw3cxcD13hVvRY4dm6ZWn/b0TlxxVaTgMpqOkxD
         GSzD1g96ySPWp9/f3aI28IL4/Fos0GUQgnleI3xxISGMmN3DVavyScE/wU+MBCjh98D3
         2GqeMj29FEogZpCCqKpwAAu+9AwDGNdGnyogdWDHW9Gkw01d8AJgk77IQNFwfTiW+ylQ
         PQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053584; x=1775658384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=osWrxEAqmZXiuVvpI8iKF9LeT8juwh9RdnQ1+Y4xO5c=;
        b=pVnumWbOvIZ5j7jGE2Ae4Jv05FrbxhctHS4PHtbS7SStc7TC2ftn1DdGMvk1qG3xQ0
         P4kyPopm4LhH01+XszZeZMEONaT4tvn+q5zzVcJu3Ow0AhE+MfLe9LT8RqC6nCVOf4US
         wvX37WtuZhyc/LCKKi1+qmLbbudUV4afxuJF2DcJY/ylWWGxxnJSxh1yuGvy1YcAeJlQ
         Pge26jth/l9R+Q77ysrQpIwuWW7E9wFxcNi6t2OotbM0/brwKTqBmMrTe7xT4WAUvhGP
         2/GSZf0MCKlpa9SdxUzdZ6sFC6H7zPXQXbA0ppGc8V3/an0s6/djswyN+u2s5Z5s/VbO
         r7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYaVyuEC/XHW4YV9eY2ub0IfE13wNOL+sx8+rqMaAd1by+wnKlPw+/C5aeVOYtViEqLhnYBEN0anRf3YbufMMl@vger.kernel.org
X-Gm-Message-State: AOJu0YzJM8/V1tSn+q5pwQ9lSmD2U1Ath5lng+vi/rUZFpeTfLrMnTwW
	sYq87MVcmnXABBdtbaBDioj1IQY4OY8G9WbbkwJqcF3TubltZEkDumLlpTzk6HfSFnA=
X-Gm-Gg: ATEYQzzhEIYquT6fJvX6WPluIT7JDVj++ePPD1YOlDygkiDpQ/ZMwcD1Ae4CkNKERsd
	gQaRQRZNGg9PWFprvQj+VVvhjJKvlj2KZ/LpVD02t9UenZNQUwETjkKSffXQryuKRlpZT/SOSXf
	YH2DB8Ay3vwpMLfTQtPreYE2a8KO4B7OsM0cS9eYxrCRDpcTIMjx2emR69tapXBAHyqm23XawG8
	yRahm1/7qwb9RhkeDtz0wN5uU1HJbLpnz7U+56NINgit1JtuErnZ34SZJMXTYRC5bBR8d39YfFm
	/UoUjqHCzW1x5TJFB1Y+Wr0OyLzFlHe+6rcG7QsVXsY7axLfszSw/jpp3EEEdBwjxUHI/XnWfoA
	oD8E+CGB1ay5Dsb/r3U4/tJGvC30HmqdiNFcsc+TH0xTbYTEjaDAwJrAlsUKJK361r9JencGMJd
	WDqN+gwfQEjiKsQbzbCVIcGmppgEC1Mm5k
X-Received: by 2002:a05:600c:4508:b0:485:3949:e5c6 with SMTP id 5b1f17b1804b1-4888355ec76mr66836565e9.3.1775053584032;
        Wed, 01 Apr 2026 07:26:24 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm2305595e9.5.2026.04.01.07.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:26:23 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 01 Apr 2026 15:25:51 +0100
Subject: [PATCH 3/4] perf arm_spe: Decode Arm N1 IMPDEF events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-james-spe-impdef-decode-v1-3-ad0d372c220c@linaro.org>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
In-Reply-To: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
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
 tools/perf/util/arm-spe-decoder/Build              |  2 +
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 45 ++++++++++++++++++++--
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  5 ++-
 tools/perf/util/arm-spe.c                          | 13 ++++---
 4 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
index ab500e0efe24..97a298d1e279 100644
--- a/tools/perf/util/arm-spe-decoder/Build
+++ b/tools/perf/util/arm-spe-decoder/Build
@@ -1 +1,3 @@
 perf-util-y += arm-spe-pkt-decoder.o arm-spe-decoder.o
+
+CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/ -I$(OUTPUT)arch/arm64/include/generated/
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index c880b0dec3a1..42a7501d4dfe 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -15,6 +15,8 @@
 
 #include "arm-spe-pkt-decoder.h"
 
+#include "../../arm64/include/asm/cputype.h"
+
 static const char * const arm_spe_packet_name[] = {
 	[ARM_SPE_PAD]		= "PAD",
 	[ARM_SPE_END]		= "END",
@@ -307,6 +309,11 @@ static const struct ev_string common_ev_strings[] = {
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
@@ -318,14 +325,44 @@ static u64 print_event_list(int *err, char **buf, size_t *buf_len,
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
-				  char *buf, size_t buf_len)
+				  char *buf, size_t buf_len, u64 midr)
 {
 	u64 payload = packet->payload;
 	int err = 0;
 
 	arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
-	print_event_list(&err, &buf, &buf_len, common_ev_strings, payload);
+	payload = print_event_list(&err, &buf, &buf_len, common_ev_strings,
+				   payload);
+
+	/* Try to decode IMPDEF bits for known CPUs */
+	for (unsigned int i = 0; i < ARRAY_SIZE(event_print_handles); i++) {
+		if (is_midr_in_range_list(midr,
+					  event_print_handles[i].midr_ranges))
+			payload = print_event_list(&err, &buf, &buf_len,
+						   event_print_handles[i].ev_strings,
+						   payload);
+	}
 
 	return err;
 }
@@ -506,7 +543,7 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
 }
 
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
-		     size_t buf_len)
+		     size_t buf_len, u64 midr)
 {
 	int idx = packet->index;
 	unsigned long long payload = packet->payload;
@@ -522,7 +559,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		arm_spe_pkt_out_string(&err, &buf, &blen, "%s", name);
 		break;
 	case ARM_SPE_EVENTS:
-		err = arm_spe_pkt_desc_event(packet, buf, buf_len);
+		err = arm_spe_pkt_desc_event(packet, buf, buf_len, midr);
 		break;
 	case ARM_SPE_OP_TYPE:
 		err = arm_spe_pkt_desc_op_type(packet, buf, buf_len);
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index adf4cde320aa..17b067fe3c87 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -11,7 +11,7 @@
 #include <stddef.h>
 #include <stdint.h>
 
-#define ARM_SPE_PKT_DESC_MAX		256
+#define ARM_SPE_PKT_DESC_MAX		512
 
 #define ARM_SPE_NEED_MORE_BYTES		-1
 #define ARM_SPE_BAD_PACKET		-2
@@ -186,5 +186,6 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
 		       struct arm_spe_pkt *packet);
 
-int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t len);
+int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf, size_t len,
+		     u64 midr);
 #endif
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 7447b000f9cd..46f0309c092b 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -135,7 +135,7 @@ struct data_source_handle {
 	}
 
 static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
-			 unsigned char *buf, size_t len)
+			 unsigned char *buf, size_t len, u64 midr)
 {
 	struct arm_spe_pkt packet;
 	size_t pos = 0;
@@ -161,7 +161,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 			color_fprintf(stdout, color, "   ");
 		if (ret > 0) {
 			ret = arm_spe_pkt_desc(&packet, desc,
-					       ARM_SPE_PKT_DESC_MAX);
+					       ARM_SPE_PKT_DESC_MAX, midr);
 			if (!ret)
 				color_fprintf(stdout, color, " %s\n", desc);
 		} else {
@@ -174,10 +174,10 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 }
 
 static void arm_spe_dump_event(struct arm_spe *spe, unsigned char *buf,
-			       size_t len)
+			       size_t len, u64 midr)
 {
 	printf(".\n");
-	arm_spe_dump(spe, buf, len);
+	arm_spe_dump(spe, buf, len, midr);
 }
 
 static int arm_spe_get_trace(struct arm_spe_buffer *b, void *data)
@@ -1469,8 +1469,11 @@ static int arm_spe_process_auxtrace_event(struct perf_session *session,
 		/* Dump here now we have copied a piped trace out of the pipe */
 		if (dump_trace) {
 			if (auxtrace_buffer__get_data(buffer, fd)) {
+				u64 midr = 0;
+
+				arm_spe__get_midr(spe, buffer->cpu.cpu, &midr);
 				arm_spe_dump_event(spe, buffer->data,
-						buffer->size);
+						buffer->size, midr);
 				auxtrace_buffer__put_data(buffer);
 			}
 		}

-- 
2.34.1

