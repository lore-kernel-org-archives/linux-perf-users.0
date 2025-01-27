Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0199B1FE44F
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971964; cv=none; b=ks+7AaAYbSGKHVIBIH5l+AKykRBVeDo3xHiUj+k6j2hpeTpojv63EqSzNdGZlB6Kcgi4EJlmViDwvzTtRKKgpYnhnY72faGmP6ofryfqLbcgKmJ3b7VoF3vRwKA/LwREjNNZfNJgmQ8tAqGHLxmqCJiG/kQsIWxG6bkwr1LqY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971964; c=relaxed/simple;
	bh=CMm71ocJ13ENhSwg83YLPq3qIcUDzcZT3Q0wIiZ2TJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GwpEFuPV/nAUa+ZG+f/UYOS5nyZqqA4dTzDZOlHFI/ji235bQQnCFUkonPXWQtewrYxkDfgS9AQUlDc6cOvejNP+Ar3qeHhy3R4q83KNvVpaIOO+yrJSI9pezHq0rbyHa7S46yJJZq6tr9RKvxPc8bHjV/Undu++5sc9toua0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9zhUMk6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9zhUMk6"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4362f893bfaso22783595e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 01:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737971961; x=1738576761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZi36qj3Dk8D5X5YEhL/AUUUkfpPn0nYoCcDBPXmPQQ=;
        b=K9zhUMk6SiTXozuOaGkTN8lcTcLaOsVy0H5wEcOYYlZcGDg/wNw3KVpgNhzSio+0ed
         AJOV5PMN3VRQWqqKxPftKiXQDyV8MFHfodx/KgRRnK5Fp68UOYkFfABTidRIIO1J/7hZ
         QVCTLP/7duJ3Ci1QClaqUVrVJejyB1JSKXpSP8bTpFI+n/AJVvlfjtUKc/CLiobNdKtQ
         inRiynfNaRBGm3w5Fom74f+bftQeIr2/klndA6+am1eNj2E2v/YGXfAFpnD9jXl1EK2U
         58Fh8hWNjFJq7GeF6t0ZiUMQKkk9QGOm+bnNGCb5dJrH2VCb+uHsi9v1RQGjE58ZSwHC
         H3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737971961; x=1738576761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZi36qj3Dk8D5X5YEhL/AUUUkfpPn0nYoCcDBPXmPQQ=;
        b=A1Og9TVW76EMZlERDeDo5a7KxPz+xq7ImqFUISzEKbtx8ZObiQZTw4ZH50sOu2MRGU
         8820hlGS8OBv1F4Pmu/AfrPX34jp8CYyNG9NRUTW0KwScnijnN8dQXHRE9AuZotxs/Qy
         NQwsgnRy2aSvFZ/aHwvExVhDQWstWJp0D/tnzUJn5Jt85EYiry+JZEwc/KDUMrMOR/Nf
         erwun48esZQ/oH1UxjSMLpjLx/vYtZzoTxMkkwapnd7/oeOu5mNZj5lOTT4Jx4pJht7f
         6cVVR1V6Rif4BM79Qns1R1eoYKECkr9OA1vaRqqLHSzCDiPjMv4jJw2hyeD4q0q97hCv
         VdiQ==
X-Gm-Message-State: AOJu0YyHoNOa5meFg3WR+I+l0445RiZkOzlOOiQASCzPKVcAXWXn/zYm
	o0YyTWUWycxPL1mV6jn/E/4MIS9wu4+RoeBq9olGrxBxUheQZ3DXSaI7AH2MnO/D4FWJWMrKxxe
	B2H1U0g==
X-Google-Smtp-Source: AGHT+IHmH3Gqb/Z2o7jzI0F2xckNIS1ZWcj3WZmmtB5FP/KGhgCpjXrsbfIsdGeJn+tXm3YFAkftIGHWW/sG
X-Received: from wmga3.prod.google.com ([2002:a05:600c:2d43:b0:434:9da4:2fa5])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5112:b0:434:a5bc:70fc
 with SMTP id 5b1f17b1804b1-438913cfa0emr355327075e9.8.1737971961472; Mon, 27
 Jan 2025 01:59:21 -0800 (PST)
Date: Mon, 27 Jan 2025 10:58:50 +0100
In-Reply-To: <cover.1737971364.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737971364.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <ebe01420df65a261bfbb59f425bc1d656f1fdc6b.1737971364.git.dvyukov@google.com>
Subject: [PATCH v3 3/7] perf report: Switch filtered from u8 to u16
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

We already have all u8 bits taken, adding one more filter leads to unpleasant
failure mode, where code compiles w/o warnings, but the last filters silently
don't work. Add a typedef and switch to u16.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/addr_location.h | 3 ++-
 tools/perf/util/hist.c          | 2 +-
 tools/perf/util/hist.h          | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index 36aaa45445f24..f83d74e370b2f 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -3,6 +3,7 @@
 #define __PERF_ADDR_LOCATION 1
 
 #include <linux/types.h>
+#include "hist.h"
 
 struct thread;
 struct maps;
@@ -17,7 +18,7 @@ struct addr_location {
 	const char    *srcline;
 	u64	      addr;
 	char	      level;
-	u8	      filtered;
+	filter_mask_t filtered;
 	u8	      cpumode;
 	s32	      cpu;
 	s32	      socket;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index cafd693568189..6b8f8da8d3b66 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -585,7 +585,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 	return he;
 }
 
-static u8 symbol__parent_filter(const struct symbol *parent)
+static filter_mask_t symbol__parent_filter(const struct symbol *parent)
 {
 	if (symbol_conf.exclude_other && parent == NULL)
 		return 1 << HIST_FILTER__PARENT;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index a6e662d77dc24..4035106a74087 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -33,6 +33,8 @@ enum hist_filter {
 	HIST_FILTER__C2C,
 };
 
+typedef u16 filter_mask_t;
+
 enum hist_column {
 	HISTC_SYMBOL,
 	HISTC_TIME,
@@ -244,7 +246,7 @@ struct hist_entry {
 	bool			leaf;
 
 	char			level;
-	u8			filtered;
+	filter_mask_t		filtered;
 
 	u16			callchain_size;
 	union {
-- 
2.48.1.262.g85cc9f2d1e-goog

