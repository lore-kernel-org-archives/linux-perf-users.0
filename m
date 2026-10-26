Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997469;
	b=Hd6gNvwu/P7UUK2rdwpDsA5dHDrmCyIKkxmoMrGbvXkhgXBj2VpuvAaMWAcnr3PeC/xx
	 WR7aritw1ZOPXTeqf/Ksszjm6mDfJf99uCO7+SHDCCDWTRNY9iGe2Du627y5fG4KhYJQO
	 NQYRbsWh6JhlIxHnjPXCas2eM4UWISxTzmQYSCbP42WuNOlCUn0pE4CQtPmw9jlzIlBjA
	 cQVZ8HBMgXbH2xXwPBezu7AxL6SlytBOv+2qH1m0BNqBvQueurAXxScwk+Wo8bNnpudwM
	 odS52j75A0j+EIf2WWUQiOoq/YsUOiuGHS+SkpjpeOxZq/fkiQ4TYIHOWD5CuLI5/Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=GkgE74Kof9noBWovzKmVwuhiy64Vj0vrOAvghAtEa0c=;
	b=1QCHLQixAivmheSQo1XX1aU2dfjA7+0t8lL4zw9VKSKKonHxHuIlv80AKuxX8C7Esx5o
	 vaw/XqsY9bjDBvC1wJbHxOrwQ573/+9FkUoSdgFCfcSseBAtIv6HMZ0CeLaD9kPWFRwBn
	 zGBIm/k0dayRvse1G42by0TlXUQNId0i0rGurw9kp6Hsh/WFdB/vu+yYHdBnt2R2OSZVv
	 dheZiDCCAumkiB3pJJz8RkEvsnu8GAGbP1EyA7ybCk2+EjkZI985kbV4INohX15k9Amo1
	 QiJ8tgnzlqAknJBTHabuReBavoknAomCJkmj5cKjU+GHPTM0k+vnKvG79irxRXngnaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZWqFfKpT;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231A606A32A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 06:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E231A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZWqFfKpT
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-18b5ee75447so1177871c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792997468; x=1793602268; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GkgE74Kof9noBWovzKmVwuhiy64Vj0vrOAvghAtEa0c=;
        b=ZWqFfKpTOVAVRfllnk/3ekxMppk8CUZ0vGhwwXZp/ZT1NTOamTRCrWadiRySNWAI5J
         hHe7WIRXmD+lOQOcyJ4y2xa9gNfnPvKcMn7Rwj1auFcCEfkxsGLUbyynFoP9r4oVnFfn
         C/4MzSQsJT9rcOTSmAkYfyDUxmd4Xr5TfrhCNSB6WHFDdKU+ogjJJcW5a7oiOI1nsPPd
         f5YdYTT5ieaSTAcZ0mg3BZN+Bpb4NPxkVnE9bcb9ft6Pi4vPlL8DSTqXuysH6TsGN+yK
         McldInbBOWtqyS/BX23qhTJMwZkpf3l+vIi7juCLNF1+4/4jXpnm7Tc7OgtmWOQlTRbo
         hnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792997468; x=1793602268;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GkgE74Kof9noBWovzKmVwuhiy64Vj0vrOAvghAtEa0c=;
        b=FXisMCq9xQEAvIj1ZjhVbKOSCtzGgRdoZ0jfIcKTrVnEPOaN6P6CQs9PWJ7L7nFsMl
         jODmho0M+ryr/yYedsex1nfsxSAECRzlVj8SguRhYf+47rJT8SZTlD3Risi9NVNHDt+8
         /PRNkUX7hMZUzZX3BuGfl555tKtGT3Q9nAkQApOPaqQD4vVQPCRski0Q+PfQx5RpGJJM
         Q2m2dWeXv/jtD6VQOu7U5hVkmHVQ/vLg9pvds4Lp9oxrttoDG7xFNNJebAphgeVUMZJ1
         /dsDrPKQOkXfqZpVHdYnluy9o5TbU1ZXuTQNDs82E2jhaiI3Kby/hfib1VBo3qYTYIJH
         fgmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgRXX1oneGttWIwp1tIYzhKhnnCgd2i9BTJ9lDZJfsphHlsdSqgeojClySpkMTvxQNktRz9Cy2cKGJUATogmez@vger.kernel.org
X-Gm-Message-State: AFq9FYLz/hDCmxv8JtboMYHCI4VYuIryW7dLlGWEroAcOhJWPM8FJAjd
	+/klU5Rfi6DiRMiFWUxWxcrhDE5g9pwM+RNmRqPfpg9Nv932xj3I7i67LFjScq/xx7MEwU9Os7v
	ioEDhyjFBuA==
X-Received: from dlbsv14.prod.google.com ([2002:a05:7022:3a0e:b0:1a2:b324:b417])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1b0c:b0:144:c127:dd1b
 with SMTP id a92af1059eb24-19937bb2fb2mr11192175c88.39.1792997467592; Sun, 25
 Oct 2026 23:51:07 -0700 (PDT)
Date: Sun, 25 Oct 2026 23:50:44 -0700
In-Reply-To: <cover.1792995775.git.irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1792995775.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <3de51d76f93fdc1170e9e923589fcc0605e50c17.1792995775.git.irogers@google.com>
Subject: [PATCH 2/3] perf debug: Avoid calling eprintf() in pr_debugN() when
 verbose < n
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, Michael Liang <mliang@purestorage.com>, 
	Shimin Guo <shimin.guo@skydio.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

pr_debugN() unconditionally evaluated its arguments and called eprintf() ->
veprintf() before checking if verbose >= n. In hot paths such as
dso__load_sym_internal(), two pr_debug4() calls per symbol accounted for
~15% of total CPU time in 'perf top' even at the default verbose == 0.

Guard eprintf() in pr_debugN() with unlikely(verbose >= (n)) and define
pr_debug() in terms of pr_debugN(1, ...).

In test__parsing_callback() (tools/perf/tests/pmu-events.c), move the
test_generic_metric(mexp, 0) call out of the pr_debug() argument list so
the metric evaluation continues to run during 'perf test' when verbose == 0.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 5 ++++-
 tools/perf/util/debug.h       | 5 ++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index f507ce39439a..e6e4f4cf1fa2 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -906,9 +906,12 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 			struct metric_expr *mexp;
 
 			list_for_each_entry (mexp, &me->head, nd) {
+				double result;
+
 				if (strcmp(mexp->metric_name, pm->metric_name))
 					continue;
-				pr_debug("Result %f\n", test_generic_metric(mexp, 0));
+				result = test_generic_metric(mexp, 0);
+				pr_debug("Result %f\n", result);
 				err = 0;
 				(*failures)--;
 				goto out_err;
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index 6b737e195ce1..7552c9171d90 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -33,10 +33,9 @@ extern int debug_type_profile;
 })
 #define pr_info(fmt, ...) \
 	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_debug(fmt, ...) \
-	eprintf(1, verbose, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_debugN(n, fmt, ...) \
-	eprintf(n, verbose, pr_fmt(fmt), ##__VA_ARGS__)
+	(unlikely(verbose >= (n)) ? eprintf(n, verbose, pr_fmt(fmt), ##__VA_ARGS__) : 0)
+#define pr_debug(fmt, ...) pr_debugN(1, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_debug2(fmt, ...) pr_debugN(2, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_debug3(fmt, ...) pr_debugN(3, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_debug4(fmt, ...) pr_debugN(4, pr_fmt(fmt), ##__VA_ARGS__)
-- 
2.56.0.307.g5fe7bd680c-goog

