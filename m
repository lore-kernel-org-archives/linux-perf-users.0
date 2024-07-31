Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2516CD27
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466810; cv=none; b=jlPYiy6SXNXhvkXyUj3QDCTbq3453BDUQYQSfMA9EcMbWzrLTkps9G4vm1HT7vxBSd6synMRWrjO8z/QQdqjf9XZDNbkrAvBxpYlNa/+1aB0TZsKZJSpVoKUVzDAGw885u4vGDiNtJL9pbaWKCIHj1AkZ5OHFE4qWMLP4cGeIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466810; c=relaxed/simple;
	bh=OJgk9cJ+TdeGwOTgs0ZEde/0xIJ389zukYYTF7pgxO8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=lcNr5rnw8CNHE18ybzEKBQrtJXNboxCCWmWdL4vnMI7YC09/GaOTXpvTg5JqBI7AWEJDkcT2eYAnr8fCddYD8gnT1iir0J4WYLSv//3+E/VxQ9fbrWrkXq9YrpEW8hkhflamV91hMRKYB6vTvBrXC7mRuGRCgmC+YeWpQMicxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2TVlNlD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2TVlNlD"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so9272324276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722466808; x=1723071608; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IvDlKqQSP4EQTz9NFmsrxvp0IpCcDOcWrteWc7+vTTo=;
        b=r2TVlNlDi9muKMX0v1tXfZnpImzvplWv3Q7irYc/IcWVls8G2eUXkcPsdUsnAml+FC
         JEEm0KZpiWI6LKCGsgVDhMvRW2R6zWdVf+67Zh4Y2Xojq9Uudu0REtjidCgzLTm9XLIi
         CbpbGN/BuvgKV9o1iRHCqi76IkfTHq6ffvkTKZXvs0x2qUK/gs+83Tx7Xr6miSaT2wLV
         st1JY+o1qb0+JhKvz6ezfcCCJMObE0tdSesULbLncfbQLJdxYgKPw3ZOJx1ToUGPCho6
         F5/rbdx5YTY2dOReKP6R8oCS3CauNIxA6ECCLdjK1GxjZiODxiP75Iw2a/gSDpBKVnvW
         Ci9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722466808; x=1723071608;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvDlKqQSP4EQTz9NFmsrxvp0IpCcDOcWrteWc7+vTTo=;
        b=iEUKaLdJsZ5gRuo/rEkayLB4iwthvTiwtP6wZcghy6neIHeKnmiK8s6BlBsMEmE/fU
         JgRTYfvemTTzyZEbyzjbCHyPV+KPTM6bKo7MyT1UGqc3lVf8CMzYY6Y6SdsflZDy243d
         e7bQwUroUvYEQ8/e0R4jv4vjfSJWwoKroQuJ2f4cd5pPRTZHJh44aOZaxMaM66xAegFq
         RH5oIFzBo07GcDN2CWkgAb2+w60MR3zo9CVGNYfUfrnMk4MPS05zlFV+Md3gi0V/hO03
         qBfll0wiQGdC6Z2q2BSrT5DYC02Cs2Ut0LOtUYW92nnVzVZFpDthnyldGKL+7VW3FkrQ
         Uj8A==
X-Forwarded-Encrypted: i=1; AJvYcCX1Q9aWiy6FQoJOCa8Ot7BF3JcCDbk/ST7oOwHcUF1qItcVhI9469uRgnQh8+8wARLa650iVrMrrV/0nOEgMrsSZNZrR+NKsaTv0BcO0Y4XUQ==
X-Gm-Message-State: AOJu0YwpdOXP1vxY/EJrWEvfZRKraSwsZJ++HriLxZvYSxaXTVHVqJpX
	y8/5he50bbvWOdUOPsug0ZkjT6h45EpvT4+M3NZ8DVP0iuJzq9xMPe++yZYN34SmhHkEr3jiboY
	xdhW+6Q==
X-Google-Smtp-Source: AGHT+IFR7w2wRPd8Gbc8O26Wa4D6n9qH15B2Ufe2fKiQvk6YNr6BOOAn2gagsJjY5+BdwpcK7lp2dOONGop+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91b9:a9ed:5ab1:7e4c])
 (user=irogers job=sendgmr) by 2002:a05:6902:154a:b0:e07:2e88:89fe with SMTP
 id 3f1490d57ef6-e0bcd20e3aemr808276.3.1722466808184; Wed, 31 Jul 2024
 16:00:08 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:00:05 -0700
Message-Id: <20240731230005.12295-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1] perf python: Remove PYTHON_PERF ifdefs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When perf code was compiled one way for the binary and another for the
python module, the PYTHON_PERF ifdef was used to remove some code from
the python module. Since switching to building the perf code as a
series of libraries, with the same libraries being used for the python
module, the ifdefs became unused as PYTHON_PERF is never defined. As
such remove the ifdefs.

Fixes: 9dabf4003423 ("perf python: Switch module to linking libraries from building source")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel_fprintf.c | 2 --
 tools/perf/util/mmap.c          | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 8719b3cb5646..c2c0500d5da9 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -107,7 +107,6 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
 	return ++printed;
 }
 
-#ifndef PYTHON_PERF
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			      unsigned int print_opts, struct callchain_cursor *cursor,
 			      struct strlist *bt_stop_list, FILE *fp)
@@ -248,4 +247,3 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 
 	return printed;
 }
-#endif /* PYTHON_PERF */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 122ee198a86e..43b02293f1d2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -230,9 +230,7 @@ void mmap__munmap(struct mmap *map)
 {
 	bitmap_free(map->affinity_mask.bits);
 
-#ifndef PYTHON_PERF
 	zstd_fini(&map->zstd_data);
-#endif
 
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
@@ -295,12 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
 
 	map->core.flush = mp->flush;
 
-#ifndef PYTHON_PERF
 	if (zstd_init(&map->zstd_data, mp->comp_level)) {
 		pr_debug2("failed to init mmap compressor, error %d\n", errno);
 		return -1;
 	}
-#endif
 
 	if (mp->comp_level && !perf_mmap__aio_enabled(map)) {
 		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
-- 
2.46.0.rc2.264.g509ed76dc8-goog

