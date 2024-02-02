Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7C3FE36
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854588; cv=none; b=PIFGm0tPktMihbjFlpiMhvWv1SWXZJBZ7DTKXjCG+B79+tHTqEs2dZ/c3YTYfASu+2GGAoPcHpmwBq+UymVeesCy3q+SR6zMnMWeQGyXBa6dKfoPfpl2SF7zeq5LDKo1+cuSaFsX8iJq8GwMQFD5Vy63eGleBJ1pkWWRrPj8dp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854588; c=relaxed/simple;
	bh=6VWn0G9osA8gozSelQTcU7d5xrzfIxfJu3Uomo4VPvE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rkyprOUTpwkDnzgtxW33Rwby/BlLcKQVaGZlndSueZXAl07KqwrQh4EfWUHpDqVpi+65n2MSufqOhHs4nL3Jvm9S5cWI0c/2O2jgbK2up7rm1I14fFDFAorCmWGL2wTu8PHUGcD0gwG6yVLHG1MHgIvay7teeTOU3vrmAWWbKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyNKy1MV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyNKy1MV"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6041bb56dbfso25852777b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 22:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854586; x=1707459386; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mottUhS25FsEFHcj0V/KGhVDM/ufFOH0iq7vn6sYGZo=;
        b=nyNKy1MVCa74G88wL78AybqbkKBeVGrFmHs3qnuRFw77/A4myTrpMTdXIwSi5UUtDf
         OlhOiHOJCQKMzwp2Txv1xilT35y1lLG2Y2bFV2+TSYNhcMPK8Cm6EAqynMlsSWgVMWHr
         ZC6LEXngcE47N7QhPuf0P6/j23yg3oUw+IPyMWXfCmGvwfosj6AQxupQ2ptSslRSiIhz
         C97tta0qxjQfjEfnlwvF9eNjmNZt7DrypM0gtnM0ZkmB2rzhLf0Kh91rTl2PMa6BpySq
         lB7H2S4ujCAUq6JLMUiFZhuLMP5qtfHWvZFGISsozj8xj0aHM8IODnGZKvLTy/8hPb+6
         SiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854586; x=1707459386;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mottUhS25FsEFHcj0V/KGhVDM/ufFOH0iq7vn6sYGZo=;
        b=sBbRzCln4JkxgHACZ/erVagm/+eP9Hq30/avc51CdAl3ui02PQbD+Y2Q9wSpkDTm0F
         l4f13L8dEaVGKIyep3r1dZC7Ne40LBuvEHZSYkQVYj+DhNnv2jnb6egREuzRTQTFjNep
         z87MUGv8yPuUD4CtgUCJEJoX6ZAP/GD3qSfC5bEZVWmZ9ox51DP81cMM3SqUT5oI+gMU
         cIH84bhCidMQqIPv/3XT4vtzvsarOitAgtrqNOFzwVG0ztwVfXvoLNPANpzlAjzFQ+pA
         ruh5aN//B1NsFWUnxfAUMUPWtsJGbJokxiftu62xTvjrbzKHHQLTlEkzNCvgXdyCy0Lt
         +6Xg==
X-Gm-Message-State: AOJu0YyctQbm3vdBUvIq2GzXitUgYOgTisem+vv6s7TFCv9cZ5N0LSK8
	gYogfb3oEQxUqzpPe++YlsjBgAjoeFeQsqeL/qQKbqFe9M3zkJtuyGDZwV6+Q/8fvJ7WBeK7TQo
	7qdP34A==
X-Google-Smtp-Source: AGHT+IH776idt25WUzubarXsfmMbycnvPflba+DcfORwoAcVf1CDOjT10Cm4I2sfM0MYnusyuIh3zuBwFFuO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:690c:19:b0:600:2492:f962 with SMTP id
 bc25-20020a05690c001900b006002492f962mr751446ywb.8.1706854585762; Thu, 01 Feb
 2024 22:16:25 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:24 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 17/25] perf dso: Move dso functions out of dsos
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Move dso and dso_id functions to dso.c to match the struct
declarations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c  | 61 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/dso.h  |  4 +++
 tools/perf/util/dsos.c | 61 ------------------------------------------
 3 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 22fd5fa806ed..69b9aa256776 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1269,6 +1269,67 @@ static void dso__set_long_name_id(struct dso *dso, const char *name, struct dso_
 		__dsos__findnew_link_by_longname_id(root, dso, NULL, id);
 }
 
+static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	if (a->maj > b->maj) return -1;
+	if (a->maj < b->maj) return 1;
+
+	if (a->min > b->min) return -1;
+	if (a->min < b->min) return 1;
+
+	if (a->ino > b->ino) return -1;
+	if (a->ino < b->ino) return 1;
+
+	/*
+	 * Synthesized MMAP events have zero ino_generation, avoid comparing
+	 * them with MMAP events with actual ino_generation.
+	 *
+	 * I found it harmful because the mismatch resulted in a new
+	 * dso that did not have a build ID whereas the original dso did have a
+	 * build ID. The build ID was essential because the object was not found
+	 * otherwise. - Adrian
+	 */
+	if (a->ino_generation && b->ino_generation) {
+		if (a->ino_generation > b->ino_generation) return -1;
+		if (a->ino_generation < b->ino_generation) return 1;
+	}
+
+	return 0;
+}
+
+bool dso_id__empty(struct dso_id *id)
+{
+	if (!id)
+		return true;
+
+	return !id->maj && !id->min && !id->ino && !id->ino_generation;
+}
+
+void dso__inject_id(struct dso *dso, struct dso_id *id)
+{
+	dso->id.maj = id->maj;
+	dso->id.min = id->min;
+	dso->id.ino = id->ino;
+	dso->id.ino_generation = id->ino_generation;
+}
+
+int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	/*
+	 * The second is always dso->id, so zeroes if not set, assume passing
+	 * NULL for a means a zeroed id
+	 */
+	if (dso_id__empty(a) || dso_id__empty(b))
+		return 0;
+
+	return __dso_id__cmp(a, b);
+}
+
+int dso__cmp_id(struct dso *a, struct dso *b)
+{
+	return __dso_id__cmp(&a->id, &b->id);
+}
+
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 {
 	dso__set_long_name_id(dso, name, NULL, name_allocated);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2b9cf9177085..7447d7a1942a 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -237,6 +237,9 @@ static inline void dso__set_loaded(struct dso *dso)
 	dso->loaded = true;
 }
 
+int dso_id__cmp(struct dso_id *a, struct dso_id *b);
+bool dso_id__empty(struct dso_id *id);
+
 struct dso *dso__new_id(const char *name, struct dso_id *id);
 struct dso *dso__new(const char *name);
 void dso__delete(struct dso *dso);
@@ -244,6 +247,7 @@ void dso__delete(struct dso *dso);
 int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
+void dso__inject_id(struct dso *dso, struct dso_id *id);
 
 int dso__name_len(const struct dso *dso);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index d43f64939b12..f816927a21ff 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -41,67 +41,6 @@ void dsos__exit(struct dsos *dsos)
 	exit_rwsem(&dsos->lock);
 }
 
-static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
-{
-	if (a->maj > b->maj) return -1;
-	if (a->maj < b->maj) return 1;
-
-	if (a->min > b->min) return -1;
-	if (a->min < b->min) return 1;
-
-	if (a->ino > b->ino) return -1;
-	if (a->ino < b->ino) return 1;
-
-	/*
-	 * Synthesized MMAP events have zero ino_generation, avoid comparing
-	 * them with MMAP events with actual ino_generation.
-	 *
-	 * I found it harmful because the mismatch resulted in a new
-	 * dso that did not have a build ID whereas the original dso did have a
-	 * build ID. The build ID was essential because the object was not found
-	 * otherwise. - Adrian
-	 */
-	if (a->ino_generation && b->ino_generation) {
-		if (a->ino_generation > b->ino_generation) return -1;
-		if (a->ino_generation < b->ino_generation) return 1;
-	}
-
-	return 0;
-}
-
-static bool dso_id__empty(struct dso_id *id)
-{
-	if (!id)
-		return true;
-
-	return !id->maj && !id->min && !id->ino && !id->ino_generation;
-}
-
-static void dso__inject_id(struct dso *dso, struct dso_id *id)
-{
-	dso->id.maj = id->maj;
-	dso->id.min = id->min;
-	dso->id.ino = id->ino;
-	dso->id.ino_generation = id->ino_generation;
-}
-
-static int dso_id__cmp(struct dso_id *a, struct dso_id *b)
-{
-	/*
-	 * The second is always dso->id, so zeroes if not set, assume passing
-	 * NULL for a means a zeroed id
-	 */
-	if (dso_id__empty(a) || dso_id__empty(b))
-		return 0;
-
-	return __dso_id__cmp(a, b);
-}
-
-int dso__cmp_id(struct dso *a, struct dso *b)
-{
-	return __dso_id__cmp(&a->id, &b->id);
-}
-
 bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 {
 	struct list_head *head = &dsos->head;
-- 
2.43.0.594.gd9cf4e227d-goog

