Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCAC20B3D
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzGiV9oH"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5A626A5
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:59:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da39d244087so1504759276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947988; x=1699552788; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7T69bsAUNRjcM3qmyt9J8wOUEZXUtACXk4aBD8XhGs=;
        b=gzGiV9oHebdm3n2Yr9GnfEx3osID6i9Kt3ONaGv6Pc/RCO9mktruKT9X9wzTwFWwCo
         kqIEZ7/EsHsgVuHM0iVacE8MIAzB5ssOuDGqr7JN1ALOPnRWKZct+dNBTVy+81xUElM5
         Oi7K0EfeoiAzSZnLOO60qeZVvGr1kQQ029+ErDgXfZKQ1qHZ0VpZG7aGmidYHHF+93KS
         cJZrUwd51CE7AN0NYSEx+rjt5eMQPGXA+p3AnbGVLy36CDBSQtu/YOafp7t9sLO74cB4
         4is/qP4otDRjkVA7wbgUYJFOtQ5Fy6lvmkX+mnnYyHEXxegCQIuxFtNgvFLD9q73Gsc4
         EdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947988; x=1699552788;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7T69bsAUNRjcM3qmyt9J8wOUEZXUtACXk4aBD8XhGs=;
        b=vCSkGZxEEYYxr1rSLYlNpprN/c1PWqq2QTRj40zdl9EDn4FKeHZK+EG1GCbPUlZmn5
         Pe6kGnuY8Y8XCYvwgnC2JZ5qNEAIpEgXjTVdiLevznuMSObcCIV1q4Rtcd8OWJB4v72r
         Eghwb7ul+e/E/CsuwVVnyMHy1Wm4u37ccSfj7jXiiDJaKOasvteMgyBsMbxxGc2HcbtA
         IfTK1mA7CJIl8YWpXExDwnQ+SAy5jPPjAuqaZUaWGYamRpgzcMR/9k1oPJOOAknXbsAE
         ASNjzQoY8d7WndRJM+F72aj0uGGJx+AB1Ej+naVicHO28vaIpLgzGj/ghpeJ5VUQ580l
         i0ww==
X-Gm-Message-State: AOJu0YwbdsI6yNb4cqW7y9HKmxhLAlURch5CbIUDCSvOtGzwGodFbmZI
	OiRPnWAMie4KiVwVEM+CwY9Pd/xEbFtn
X-Google-Smtp-Source: AGHT+IEyoDJPW1kqDnah2e0Y3xfDQZ5keGT2SWBKBH0TFnLXQMxLoRqOXhWOV08bsD+3jOuDMHyDxGnhFx4R
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:84d1:0:b0:da0:cbe9:6bb5 with SMTP id
 x17-20020a2584d1000000b00da0cbe96bb5mr382618ybm.11.1698947988239; Thu, 02 Nov
 2023 10:59:48 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:31 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-50-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 49/53] perf dsos: Switch hand code to bsearch
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch to using the bsearch library function rather than having a hand
written binary search. Const-ify some static functions to avoid
compiler warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 46 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index e4110438841b..23c3fe4f2abb 100644
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
2.42.0.869.gea05f2083d-goog

