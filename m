Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE985266
	for <linux-perf-users@vger.kernel.org>; Sat,  4 May 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714858701; cv=none; b=JhvEfBIYEwRsHagSjLTNGz9NACTch890v75jWX4gdy5sAksKPoSSsz3ykin3RQ/foA3yNfwnDjCOhq+N/C+OtYIvLGjZCfkRdOs4gNsz+QMATDoAovwJdgrnjdI0snVbSGJwbxV+i3GGLbOqr/cIUq0CxjgbFEYSoF4UlkrwBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714858701; c=relaxed/simple;
	bh=xnDpwNHBHh7YAyxzTfoCDFzRMkDZg46aBApaw6QafJg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gHHu0xGpylrh7wiDeejwHy4ugTn0Pap34DN+TjHmea0Br/zCuynmRZIqANapdbWHineTcWYYgOnG+iKbD3ok6WxWm87rIOREJzgnJmO9YTVQTZrXMlpJQY7gUU5DJRkRqw4pTgUygZt1monET0yvcS5XMjd4+nP7XhqczECtBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZliWXUHl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZliWXUHl"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0ca5e2so16353327b3.2
        for <linux-perf-users@vger.kernel.org>; Sat, 04 May 2024 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714858698; x=1715463498; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0rJvt8VLF4+JLdHgJvQ3YGpYyrzz7RIia1LPuHZNGA=;
        b=ZliWXUHlT+XcrNr//Askf+VWdDAmW/cavq9mcGAQkNdNCwXYabBC5tTbyOlwsn3QLw
         VrPQCAelfnrKq1AfLcL4LTIP07LB+5Uc8xLiCIrX2ucoIju4Q+0TAolHN1K48VNLZbfE
         j377+kAu3x3WRT8qyC4jVKGwxKz/QTwVd92c30rAT9hclm+Vn9nnrlEOnimt8rGoi8sj
         SHHrh8zisWHIBntafGQDqMuJuM689p7eo/BY5f6hA4cZGZiK66lvwo1rycl1MxDuma9I
         MsngLkohVUpDi0z7Pw3z/WXpT1d3NyZREw1zBb2FKavLHIxHmapnyNeSO/e3T4oBS3Fa
         H0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714858698; x=1715463498;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0rJvt8VLF4+JLdHgJvQ3YGpYyrzz7RIia1LPuHZNGA=;
        b=S53zFv49LQ63e/jAyoM7vJaHO0Mz8pZlgR0y2bfYwGOqd+CnWaX2ULW7N1LyWeyOEt
         9uQACGDsN3fZrnUHiepEFofDPWzdx1yV+GDPlnLAmwBfMzlsKVBAUtx2TsHzZrnhhNq5
         qmN/hc9klDu+3ModkQ9uXLJPdcHLKacUQncNz4hjgQkxQMV/K11IHMVYic052sTi+Vbj
         kIhUDwjgCMA7qR4EwCXQbP2sVwWA2qm6UEBUCfW1YF3CVEiacf9YbwyKMOz4zdryhjh/
         RBV1A+VQMGwyZbdZqxm3kAMwyd1Txt8OjqeykerBuEy6Vh9al89uHqIQKBJG/sOuv0uB
         oBwA==
X-Forwarded-Encrypted: i=1; AJvYcCXkawKH1kFoIiAuNfQG3xpHbAoOpv5qlX8CdLmnxga1UZ8IeLckIZkncM8aRjTZ3a1t2vwlglQqJmlrBfRMyT9UBgvhzKZo6vCWhY2HsDXfPQ==
X-Gm-Message-State: AOJu0YzNaQ2ndydgRsU3nBbeRQHfL9t7yUEsgm997cmoQKU4+rLXl3vG
	vbu3jawLg4g/KkvjOBy2A8mIexmnXph5s7MzHIbjTQuiZFMvzP0Stqu3PPK9UphxmyZPGJYHJL7
	ySmilfg==
X-Google-Smtp-Source: AGHT+IHd0TEvGWGmfO9kLtShz9itFB+4RhbAIDe7ZlDsv/kemSpH51iv72teKd5TlRAT4OGpo64iPbS9XFd3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a25:b311:0:b0:dc6:44d4:bee0 with SMTP id
 l17-20020a25b311000000b00dc644d4bee0mr849799ybj.7.1714858698588; Sat, 04 May
 2024 14:38:18 -0700 (PDT)
Date: Sat,  4 May 2024 14:38:00 -0700
In-Reply-To: <20240504213803.218974-1-irogers@google.com>
Message-Id: <20240504213803.218974-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240504213803.218974-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 4/7] perf dsos: Switch hand code to bsearch
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch to using the bsearch library function rather than having a hand
written binary search. Const-ify some static functions to avoid
compiler warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 46 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e2ccceac7619..2e4e86dc6c17 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -107,13 +107,15 @@ bool dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 	return args.have_build_id;
 }
 
-static int __dso__cmp_long_name(const char *long_name, struct dso_id *id, struct dso *b)
+static int __dso__cmp_long_name(const char *long_name, const struct dso_id *id,
+				const struct dso *b)
 {
 	int rc = strcmp(long_name, b->long_name);
 	return rc ?: dso_id__cmp(id, &b->id);
 }
 
-static int __dso__cmp_short_name(const char *short_name, struct dso_id *id, struct dso *b)
+static int __dso__cmp_short_name(const char *short_name, const struct dso_id *id,
+				 const struct dso *b)
 {
 	int rc = strcmp(short_name, b->short_name);
 	return rc ?: dso_id__cmp(id, &b->id);
@@ -133,6 +135,19 @@ static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
 	return rc;
 }
 
+struct dsos__key {
+	const char *long_name;
+	const struct dso_id *id;
+};
+
+static int dsos__cmp_key_long_name_id(const void *vkey, const void *vdso)
+{
+	const struct dsos__key *key = vkey;
+	const struct dso *dso = *((const struct dso **)vdso);
+
+	return __dso__cmp_long_name(key->long_name, key->id, dso);
+}
+
 /*
  * Find a matching entry and/or link current entry to RB tree.
  * Either one of the dso or name parameter must be non-NULL or the
@@ -143,7 +158,11 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 					       struct dso_id *id,
 					       bool write_locked)
 {
-	int low = 0, high = dsos->cnt - 1;
+	struct dsos__key key = {
+		.long_name = name,
+		.id = id,
+	};
+	struct dso **res;
 
 	if (!dsos->sorted) {
 		if (!write_locked) {
@@ -162,23 +181,12 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 		dsos->sorted = true;
 	}
 
-	/*
-	 * Find node with the matching name
-	 */
-	while (low <= high) {
-		int mid = (low + high) / 2;
-		struct dso *this = dsos->dsos[mid];
-		int rc = __dso__cmp_long_name(name, id, this);
+	res = bsearch(&key, dsos->dsos, dsos->cnt, sizeof(struct dso *),
+		      dsos__cmp_key_long_name_id);
+	if (!res)
+		return NULL;
 
-		if (rc == 0) {
-			return dso__get(this);	/* Find matching dso */
-		}
-		if (rc < 0)
-			high = mid - 1;
-		else
-			low = mid + 1;
-	}
-	return NULL;
+	return dso__get(*res);
 }
 
 int __dsos__add(struct dsos *dsos, struct dso *dso)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

