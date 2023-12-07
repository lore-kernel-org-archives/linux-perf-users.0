Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCi8naAa"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF61130D3
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:19:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf86963ecso1813427b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911949; x=1702516749; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfZhXz3aJqIR3B942uDWzE+/1mlKepIUmUSXOJMumf4=;
        b=JCi8naAa/FIYwAjXY4IwCJVGLyiAohN1z3QpUtrfdX+ujw/8ya3r94BJuEsn5a6MwZ
         LFyrvLM5BPPundoEly2CSqTgjwTSDVLtCQH24uEKq2YqPmeW7XuwSbwtpOIJhFA+mMji
         qA2Hvoz4ZGrd8QEMqdDOMwhNz2L1bKG8F+zw+9p+poeyZr/E7oGpN+v1SQdwJMw6g5XI
         QR3hFwqsbydVeHRRsh3u0qyj/+rPLSty2/1gLBC485SwxZrve8iNda4xie2M8zxKp7EM
         wDT1A3hfcmHOh1vsU6lBbi/JPnnUO9qKuK7AZOJJ3O/akpNtdgra0IKE6XQqiniwORUm
         Vrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911949; x=1702516749;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfZhXz3aJqIR3B942uDWzE+/1mlKepIUmUSXOJMumf4=;
        b=Dnq8xexJQzmoOOZmio3hvCQiCK4lUBb6qaNRdfCzlE5z+qeknbtHfeZRpwlJHDCzOv
         N52d3oEWo/9AMkX05vPSpvU26Mcjwh/VwJXE6pVbek7hSEBfMzJXgXHf3pGZLGg5MOQB
         +kMwlTWHVlBkxvyQgHlLAevCLpoPe4gjvgJYDIRRfaX19DntFLb79XzAp9/5J870WJOw
         k2ZJDT6TLsD8YqGUFcHFUzomcH57daNOEFq68tegOPvXI3Wl4ny8Y5Ey5mwHT5w2CcSy
         Ni8mUVm2JEVoAm6AeWrpAB8K//W4NhbwRTlgXQhH+xaiVxQtRm38z3dabFy8BooO33Wy
         hVsw==
X-Gm-Message-State: AOJu0YyvCs0+dB6b1XrzFaenswSiz4KysRitQBVnoaoP0V4+rjH9ARWV
	hvn57KHH5gDYjjiITd4vl95bj3lTiqQG
X-Google-Smtp-Source: AGHT+IEFGIHjxtwtssSHBNP1N9AtvROXQnmmbb4cujCd65lj2pKmwKkxBtnatTH/s/39At1DrwlShvskYDh9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:be16:0:b0:5c9:c698:cd34 with SMTP id
 i22-20020a81be16000000b005c9c698cd34mr31433ywn.2.1701911949131; Wed, 06 Dec
 2023 17:19:09 -0800 (PST)
Date: Wed,  6 Dec 2023 17:17:18 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-45-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 44/47] perf dsos: Switch hand code to bsearch
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
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
2.43.0.rc2.451.g8631bc7472-goog

