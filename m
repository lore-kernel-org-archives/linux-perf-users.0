Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980419308C
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434205; cv=none; b=Rnz1uKtq+LBETYNgLZiVDr33+I3HxiQoDRPTsNa07nDIfR2RFaGjzpNleIVVs+7hiERGj8L+yO+jupD6XBSIZZrlq+FhcIzBEUXHdoonNXYzUZ7TV7CQr2c6cFNwkQGzHxyhJqjbsksdWv9BCs2yzSuMLRhfzSkhuCSfkE6v7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434205; c=relaxed/simple;
	bh=qdeanQ8GYgnxi/cu3Zjdli62tKEIwEpZcs71nTkIs/A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aM08cM6FZytxy9BKXm/T+6Q13fII834JF206lXLYV0yU8WlAncPSKek5c1l7+GXbO2qph43oI7ctLkX9BO50irXcULXdzkoJxmpCat5xFVZRn3u6CHA/m2OaSgNUZp1QiMAkLR+pz4ixzSHd8zFS5T/yPGOl/xm1hMO+a/qSV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2LCt0nW1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2LCt0nW1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-643f57e2f0fso101238227b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434203; x=1720039003; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcJ2tbGh1Yfs0OJM6bkJDG9fBvcliigGM1tYWqZJmL4=;
        b=2LCt0nW1aCZUIJajkIOdSVXZx7QcXcgXlPSgn2JNhBwbPhSdy8Cul3sVKsTX+rGpgO
         NyqY0/lK2pvVbM0PIZaOJ06hi/sG0/8ttwyFPlu268LTP0DO+cCxgv3zXADuiJZOpEQn
         AGmtO3xYsebWldLVPB3lZj/oLnY2UugPke1rAr57v2dKY0f4Lq6l4yANCQ3hO17qs9WX
         ZhpJl9HDDYjdQdhNXd6NuJ5fXUj266e8KjmWv5z3+o1nXnHAxZNI7Ve8hRRvlHO45K0o
         MA9df5Dg/DqqAaRvOjBQzGvmLqG3Aqmb7uwNYJDFmJ74ucYAnbgp87pywrNh7P5vIoGC
         nYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434203; x=1720039003;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcJ2tbGh1Yfs0OJM6bkJDG9fBvcliigGM1tYWqZJmL4=;
        b=bgQIklYr9L58Ox20Bjt0UMB9D5h+ZwMp+8csumSywCx3U2E8jEw0YTyw72wac/OEGp
         9b9z8yQKnRfNzVjSy+Y1yGtNOqVqRP/jvv4NYYXSzCqIFK8aM5ZfWU6BOnq8ukrZUHnQ
         fjnAjOhOhuHyoJYZmtzsfe67OD+2Bvsd4vsz6EWMgsNYeVJhPOq2Ez3wNDPZK56C5XKe
         9t3uW1tomuU6+dRgaDmbeXF2c6zALe3QDaP8UpwxFyvZdNZmGlqAcMzfdBqe8Abs1Ytx
         VqWzp885qRzxjYpqbW63TrSFB90OlpBVIjH1YCqWTx7thQO/3DRnc6GIfJC04OH5A8Lm
         /USg==
X-Forwarded-Encrypted: i=1; AJvYcCWeQ8A5bNxjfa7U9/tNZGGobbYNogf2aXDPD/F77Vux7ASNyTHq39hbLjpkIzOr0G8Ffs3FUag6p5UqvVX1uaeelR3xD1MGrTSlhR/E0Zfzrg==
X-Gm-Message-State: AOJu0Yx1csYMBTA3CMRBEJS+nMbGRP4OWhEdQoLtOZCLCWoMuQP9FFTA
	9QCP7QuptKl5fmSADtauGJ03Bl66KffYQ9bsQ2ZUN/46x2U8cQAyZ1FQ46u2PEYOPl6CDGoiRtp
	4414cdA==
X-Google-Smtp-Source: AGHT+IF1ujd8fnaq1c9+yRQXwV8wiVuEn0TIgaMmQb8DJtqM0t0gj5rgMA3or/ZxmEcUAkhmByF2yBScwXbC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:f84:b0:e03:31ec:8a25 with SMTP id
 3f1490d57ef6-e0331ec8b21mr6829276.10.1719434203172; Wed, 26 Jun 2024 13:36:43
 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:04 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 02/27] perf cs-etm: Fix address sanitizer dso build failure
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

cs-etm.c had been missed from having accessor functions added for the
sake of reference count checking. Add the function calls and missing
dso accessor functions.

Fixes: ee756ef7491e ("perf dso: Add reference count checking and accessor functions")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cs-etm.c | 10 +++++-----
 tools/perf/util/dso.h    | 10 ++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9fd2967d4e3f..e1a7eebbb15f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1013,7 +1013,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (!dso)
 		goto out;
 
-	if (dso->data.status == DSO_DATA_STATUS_ERROR &&
+	if (dso__data(dso)->status == DSO_DATA_STATUS_ERROR &&
 	    dso__data_status_seen(dso, DSO_DATA_STATUS_SEEN_ITRACE))
 		goto out;
 
@@ -1027,11 +1027,11 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (len <= 0) {
 		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' or debuginfod to export data from the traced system.\n"
 				 "              Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols.\n");
-		if (!dso->auxtrace_warned) {
+		if (!dso__auxtrace_warned(dso)) {
 			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
-				    address,
-				    dso->long_name ? dso->long_name : "Unknown");
-			dso->auxtrace_warned = true;
+				address,
+				dso__long_name(dso) ? dso__long_name(dso) : "Unknown");
+			dso__set_auxtrace_warned(dso);
 		}
 		goto out;
 	}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index d72f3b8c37f6..878c1f441868 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -280,6 +280,16 @@ static inline void dso__set_annotate_warned(struct dso *dso)
 	RC_CHK_ACCESS(dso)->annotate_warned = 1;
 }
 
+static inline bool dso__auxtrace_warned(const struct dso *dso)
+{
+	return RC_CHK_ACCESS(dso)->auxtrace_warned;
+}
+
+static inline void dso__set_auxtrace_warned(struct dso *dso)
+{
+	RC_CHK_ACCESS(dso)->auxtrace_warned = 1;
+}
+
 static inline struct auxtrace_cache *dso__auxtrace_cache(struct dso *dso)
 {
 	return RC_CHK_ACCESS(dso)->auxtrace_cache;
-- 
2.45.2.741.gdbec12cfda-goog

