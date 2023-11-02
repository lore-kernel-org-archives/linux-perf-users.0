Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAC210F3
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBuFwbCw"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF10B2697
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:59:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa071d100so25612917b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947986; x=1699552786; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crhHdwgNdVgPwaFyhVa1Sf4kXmyuYN0V7L2Kpn4xK3g=;
        b=wBuFwbCw31nqnnbwfHqB6+YQn5GCmd1sYTdTsOcicMMZBaSKVoJ1WtdOYghGbWN6GV
         sXMkJvuTP+b/Jta3Q/hno01sedd6eAX8mJHP2uuWfQn5TuYN5VT1YbF990J1gAPItmlu
         bGPwjkfMYzLrRdHD8ZODS6coOWQv1AIs4aP+0dTTUyDasy73+sPke7A+DNm46U0ZZoj8
         So4bOd/fxYGXxURtTIegN6/ly1wRqsiDFLjoqM5qJ+wIKXdH7GipppNlHA+LAvW7Ynbb
         KRv7q47eEjO9SgRkpczxVKM7KI2Lvz1wRjmnBzdqjgGtpeQEQX0q+QMsYBF/VCIn6wQx
         SE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947986; x=1699552786;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crhHdwgNdVgPwaFyhVa1Sf4kXmyuYN0V7L2Kpn4xK3g=;
        b=NXX3sWALMfkN59GpkrjMbckuG85uSBPo4bvVxsG3Cm1iFmqyCN1ZOd7UHT2WfRfEYz
         inckpm3aFgVTot2anDgveZ7KB1uktDmaNaRPBQWI9dlEAOVWDRIuxwfF0j588deoYHQY
         ACQ12DK1/hzskCJZ8WRkYkdfby0cqSlPnR9SwMIHZZxCk0aNEbxBre6tyU8SkFCoEvFC
         TRm93I38tHsijbDc5p+wwsHZ7u8YHyH62w94fD+ZOuilpnLlLQNVKT3JYLGo7Ed9jNKX
         nyVm2a6Qqu44f1x4hITmrcvgg+yAbed/te6y2DFz1dmAZymFBuDtxszpCgZXtZ4rzVFL
         cjlg==
X-Gm-Message-State: AOJu0Yyd9Q190Q1j2BLB+ao+i+4fDlYx8zdrz3p7RVatGnHGJtyvOdN3
	Ye3z/fJzXlD/QOv9iKiYaPn658suP8r1
X-Google-Smtp-Source: AGHT+IHsp8RLYX43W/19GRuBekgu0QUTset3rWELTPIzYf1mfnrP3cR4NcbWFYL9v1sruCzVYYwg6MqWapsj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a0d:e204:0:b0:59b:ccba:1249 with SMTP id
 l4-20020a0de204000000b0059bccba1249mr6574ywe.10.1698947986093; Thu, 02 Nov
 2023 10:59:46 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:30 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-49-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 48/53] perf dsos: Remove __dsos__findnew_link_by_longname_id
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

Function was only called in dsos.c with the dso parameter as
NULL. Remove the function and specialize for the dso being NULL case
removing other unused functions along the way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 51 +++++++++---------------------------------
 tools/perf/util/dsos.h |  6 -----
 2 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1495ab1cd7a0..e4110438841b 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -119,11 +119,6 @@ static int __dso__cmp_short_name(const char *short_name, struct dso_id *id, stru
 	return rc ?: dso_id__cmp(id, &b->id);
 }
 
-static int dso__cmp_short_name(struct dso *a, struct dso *b)
-{
-	return __dso__cmp_short_name(a->short_name, &a->id, b);
-}
-
 static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
 {
 	const struct dso *a = *((const struct dso **)va);
@@ -143,20 +138,21 @@ static int dsos__cmp_long_name_id_short_name(const void *va, const void *vb)
  * Either one of the dso or name parameter must be non-NULL or the
  * function will not work.
  */
-struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
-						struct dso *dso,
-						const char *name,
-						struct dso_id *id,
-						bool write_locked)
+static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
+					       const char *name,
+					       struct dso_id *id,
+					       bool write_locked)
 {
 	int low = 0, high = dsos->cnt - 1;
 
 	if (!dsos->sorted) {
 		if (!write_locked) {
+			struct dso *dso;
+
 			up_read(&dsos->lock);
 			down_write(&dsos->lock);
-			dso = __dsos__findnew_link_by_longname_id(dsos, dso, name, id,
-								  /*write_locked=*/true);
+			dso = __dsos__find_by_longname_id(dsos, name, id,
+							  /*write_locked=*/true);
 			up_write(&dsos->lock);
 			down_read(&dsos->lock);
 			return dso;
@@ -166,9 +162,6 @@ struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
 		dsos->sorted = true;
 	}
 
-	if (!name)
-		name = dso->long_name;
-
 	/*
 	 * Find node with the matching name
 	 */
@@ -178,31 +171,13 @@ struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
 		int rc = __dso__cmp_long_name(name, id, this);
 
 		if (rc == 0) {
-			/*
-			 * In case the new DSO is a duplicate of an existing
-			 * one, print a one-time warning & put the new entry
-			 * at the end of the list of duplicates.
-			 */
-			if (!dso || (dso == this))
-				return dso__get(this);	/* Find matching dso */
-			/*
-			 * The core kernel DSOs may have duplicated long name.
-			 * In this case, the short name should be different.
-			 * Comparing the short names to differentiate the DSOs.
-			 */
-			rc = dso__cmp_short_name(dso, this);
-			if (rc == 0) {
-				pr_err("Duplicated dso name: %s\n", name);
-				return NULL;
-			}
+			return dso__get(this);	/* Find matching dso */
 		}
 		if (rc < 0)
 			high = mid - 1;
 		else
 			low = mid + 1;
 	}
-	if (dso)
-		__dsos__add(dsos, dso);
 	return NULL;
 }
 
@@ -240,12 +215,6 @@ int dsos__add(struct dsos *dsos, struct dso *dso)
 	return ret;
 }
 
-static struct dso *__dsos__findnew_by_longname_id(struct dsos *dsos, const char *name,
-						struct dso_id *id, bool write_locked)
-{
-	return __dsos__findnew_link_by_longname_id(dsos, NULL, name, id, write_locked);
-}
-
 struct dsos__find_id_cb_args {
 	const char *name;
 	struct dso_id *id;
@@ -279,7 +248,7 @@ static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct d
 		__dsos__for_each_dso(dsos, dsos__find_id_cb, &args);
 		return args.res;
 	}
-	res = __dsos__findnew_by_longname_id(dsos, name, id, write_locked);
+	res = __dsos__find_by_longname_id(dsos, name, id, write_locked);
 	return res;
 }
 
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index d1497b11d64c..6c13b65648bc 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -36,12 +36,6 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
  
 bool dsos__read_build_ids(struct dsos *dsos, bool with_hits);
 
-struct dso *__dsos__findnew_link_by_longname_id(struct dsos *dsos,
-						struct dso *dso,
-						const char *name,
-						struct dso_id *id,
-						bool write_locked);
-
 size_t dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
 size_t dsos__fprintf(struct dsos *dsos, FILE *fp);
-- 
2.42.0.869.gea05f2083d-goog

