Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B53D34AC
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170904; cv=none; b=g19REL/SZsmg3llhJ9+dnyIl8VsNwLYUQ2l7uMirTH19Ih/yxc4noTmciaHTN5AMsJIshYkx9Kq9xQvUEXGpl775IladPFFrkqgNI5QwSOu+HMrMypErGO7bjfdDYrFuuCLur5S9i9oytM7Yt+GuZdzlfVC1b1qVfgDu5N4YjCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170904; c=relaxed/simple;
	bh=+hAJHqlA9neGxwPbbyXGO8mgwNwORpfgUWNnvOZvG0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWo0DVy9pMx4svGx7GFeYrSniR33zOviwBZCLjdcEl9Qi8VAnMXeYWeRxUIwlj8L5Lq6IFEloi+lDVOF13mIrnq8leplp5nV83O9Ug0+7CVkttYVqyH0TJORYRdSYiDxaTpM/Nng0Y0C6AM0unljT/ogtGDGy6u5knrxlrg4opM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CXrlMvlX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXrlMvlX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso59172255e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776170902; x=1776775702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9CYFRKleV99FYE5YRfSxRGUGOIShzVFADPCbQgmgLs=;
        b=CXrlMvlXRbZ5fsKCNuI/WStZzvnV1KhD6ToggY5Djbwwf1qWg7MJK6jilFpOlkgXhk
         SDE2NpsscisXqCHnJ+NbNiojMtH0ei/huOy8GK9P2VeiHwcgn67EwakVtwo8sV9xqN+w
         5AK6naaZOFeaWThPHfqyEtFFWb8sh4pxzrb31VvpXAW2ubeails7brwpLTLGXjctO0EX
         8ZFllPS58kB8YwxHba5bHSsfn8M7SDSqUWgoRKD9uo08zIfP+bUPNiR2v6tyzMhs9Xh4
         a94Y9h3nJNX9y7+vJlcohRFvb9alGD/dwhv0JCB0UFJjnnyrH9Nq2Hnjl/hQ/qxKWgf2
         uRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170902; x=1776775702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h9CYFRKleV99FYE5YRfSxRGUGOIShzVFADPCbQgmgLs=;
        b=pb/nluEOG64ZWRjuK+YgaATgOZC8wzD+Wmj5qdvqwc3fuJpChu9/+OfAhhfXUoqMMC
         wfYpwY2qITFrf0CDKa0tq8uHMlH4n23BVodSGZ4L3yydMDIyCX8UxSBlKSYnKZ200Ndm
         7V7AoVKP0W71BqIWsYqhZHlBnMxXpY6n4hVfGimcH5knqOwg7Qn83wd9frs/EyvyaR5j
         OCpWuzA7iBgeF77wQMjvWg91rwz1DBXDPPHBFzNPGFPdIaNbspC2rUSyQFtf3v1sTosc
         x3ktnbFCsBV39POju9V6rfx3NRZ01D8qus0m1thfD+jamRWow8JsVBZDkxvQ3BU9Pv4r
         z6/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/0lX8inCp99TavIFzPwb8uTgMyDPbSbD254Nu4tvWQtyQ84pntkt7azP9hwcrSOmXpaB1uESBk2cfWXnZYFRaD@vger.kernel.org
X-Gm-Message-State: AOJu0Yybne89H8TkHsc+4y5mf0koyDf31uvq42c9s+nZtrWl6SpKDCyc
	Wq0atPNqwlomlppVvr1hJHlSoQq1Xn4LfKcKpH0FR9LnLesv6IN4K2jwQ47atA4kUo0=
X-Gm-Gg: AeBDievo0P4sBPg8incNvSVh80YJzjzH4OI/XVpf5R7h+UZZyc5UKQisWziF7W6aY0w
	vKH2OsFBAxQLc8pnzBE9wCIG/tzBiwDwtGN8ADEp9RQ8Sob5rxzj+kjDfnqPLXlfb2O30aB9nn9
	CvF+Ur/pxDHBVTz4rZj/NOdEm2gmDSu28utxDjZqYcXyMA8RAxP2pv65ixoS5wwHuQoBxCyZ/rh
	gG1r+FerYYKZae0kqh8r7iqKvxbl8zgNyCBUWqlRHeksWIUwIfzLnSIYO8pqHX2q/7BW+YR90jh
	60RlTqw9lLzkHRUZIV9pQ89RlEj7V4zC2L6UeL9ZX3MMd0D0dOe5z9AGQQWa7kl55M52doncBtd
	BSnXqsFQVLc6KN8q2qR2FO9IL/VRJmYN+tmT1G02hT8vddgdOb5cfdt8aQGVt5ZnVi/6jWGSlNa
	boXTr+nUjlNLc6MPYaPY+b8AfxDgyLIGXbEH8PefMubQ==
X-Received: by 2002:a05:600c:8585:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-488d684bcb0mr179229125e9.14.1776170901671;
        Tue, 14 Apr 2026 05:48:21 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm81185285e9.6.2026.04.14.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:48:21 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 14 Apr 2026 13:48:03 +0100
Subject: [PATCH v4 5/6] perf arm_spe: Decode Arm N1 IMPDEF events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-james-spe-impdef-decode-v4-5-1dd30783a33b@linaro.org>
References: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
In-Reply-To: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
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

