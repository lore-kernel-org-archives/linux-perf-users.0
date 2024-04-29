Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8413B2BC
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416395; cv=none; b=eNQkeC3H+0zGNLP1wlgLcPAYjJlX6nz2MzzBCeVnILPp1WOZAK752QKz9EoEePspeWMomao0YkMzS5x3BjMivvU24/Sv/51j2bgVxifzrCb/jnKwtFOyMIY/5EFjCkfVIyQw46IyYgrhRK7Voiq41YaceQSHid+aG4+6Nygxe8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416395; c=relaxed/simple;
	bh=7wUIMCnoFq7ZLkHWL+493f8aFpVbZ9Nfs5gexZ7yT5c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=i/zFLq/9B3LiSwfLCHrQ75DKHkj2CtecZMpSd4escvbLnkys5c/WQlzxhdp+21XUtnFECyeMTZwz+NHNjzPv+YIcnOGpC8/l+2GHLJFnFTUIyDY53WfUUOwy/7zipGujgt0YpnMcM71j9XamjvomaIyY2QI3RirmRATrZfbzBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOiVY9Xs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOiVY9Xs"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e19bcacso6829599276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714416392; x=1715021192; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaakWA+9pmWCC2IKulyCPlxCN4FZjrOrV99o6doTC0Y=;
        b=KOiVY9XsmB1Z2qIS/z8S63njWEN17S3f1RqfV4W9WhiraE4E6JMkDPVFcEy3M+rC5M
         qyEzgZrDKzvwienI2Jk9wZxmQ8UwfdDkGLHVjeOsU0Hl27gC4VmynAPhapoprLWbxgSo
         yS8ih3Gqsl41WEWHwgmRgrg+VAuvzJ+zIr+6/KGmBmqQXZg/r29WIfN5qs1sLlqcDT1b
         QAhLXZm8IbSnxlVUBSUS10PeVgXcp6c5kxeJnG56wdEJpIdThfCbe++yMvQQevgLHzjI
         unPPR4kt4M84uModuihMNCXtMdOOYQnuE6WAdHLBK7O3ObFlqGzpo7KlYWpYOzjYAVKh
         KVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416392; x=1715021192;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaakWA+9pmWCC2IKulyCPlxCN4FZjrOrV99o6doTC0Y=;
        b=AFigJJ3kfwjA6Tl7KJDe2S/wjRI/0FoG/3uT28e436IrznoyficKjV4wVxOFby0Pud
         +Vdwp/EZdvp1qvcsBEOcZvZhAGN/XQkpqj/sQz18H1ZcdZcCbI/JqKurVtTj5+wpExfX
         YoCmW0fJ/cz7azZ86gvbB4FBEgF0l4wOlbgXgcBhtE6RH+CGkP+0N6ZFGIgrG/QT8HMq
         C700hP6t/6nIsl9klTngUhMvbimaZEgM8476FLK2pZv2/iu0NdcdKVru52fsOE0LIgDV
         m3uQA4YqnsPgS8wJZ38FWlvTQNto3chdUYyq9INIaqpLSeN9liayC7+DdW9Ff9vIp5+k
         xHOA==
X-Forwarded-Encrypted: i=1; AJvYcCWN42tq439QwJg9zGt42Z6s8S+FvGGXOdz8nwam9Un83yuYa8W0jCXcjo2ujNV6nptWEvuHjE+FcFgv3K2WnjfMfwcz8yYMnC1DpOJ3p2uGvQ==
X-Gm-Message-State: AOJu0Yw1G2kC02KzeM0mG07g77BM6hHMQOMLqbOavj4wBEWI48TpsmX4
	6wll3xWuODYIvg3/CV/gDkatjTQ5P19yFzmbmT0fV7BCLPrQZKl+uw2sFQTh+8Egjjse2iw7nl0
	jYJOnhw==
X-Google-Smtp-Source: AGHT+IGSyIVBp6RN1a1SYuRa4gu6CPyVoeRfnQrHe0n+PI7KqU5hQMjrYvF29I0oSR8gqkVBl1j8+dNcv/E5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a05:6902:70d:b0:de6:bf2:b026 with SMTP id
 k13-20020a056902070d00b00de60bf2b026mr123539ybt.13.1714416391739; Mon, 29 Apr
 2024 11:46:31 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:46:10 -0700
In-Reply-To: <20240429184614.1224041-1-irogers@google.com>
Message-Id: <20240429184614.1224041-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429184614.1224041-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v5 3/7] perf dsos: Remove __dsos__findnew_link_by_longname_id
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
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
2.44.0.769.g3c40516874-goog

