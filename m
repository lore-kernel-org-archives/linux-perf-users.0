Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538DA7BAE6
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Mar 2024 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577363; cv=none; b=loKh1WmNbRP6THz/UiD4Hx/174sGKlpj5xBOXyZdQsAWmO3poLRnklbvqCWwHou1RaJ0gUyfjPtnsHsS2eS2jaW9CD9cddPQWLv1UYnQj7x7t0thLZP/018vl9GyDwG1bKt0klrP/Mg/iugSbiXmKFdr7tSlutPNMNfkqebWx9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577363; c=relaxed/simple;
	bh=UxBICEnGoxJN1FLWr1JpuU/MzleQ8XlBL+nMW6Wy8ho=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sOaRdsC/hT/XJbSYnSrvLuaZZxwuugeJA5rXyXivWJ4iK4GG5l2bWV1M5MIGilckkOqkkbfQHCq/0ZLnWrXsZs4NCiyGHt/ZWNeNQ72Uo5JJQYAkQ/1lIdW8ffYZ+1oh/V3UO/KTfm6FRH8VKjgk2EyrmNnvcYANyBRa9fcO6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wu+d5spo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wu+d5spo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60966f363c1so70255437b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Mar 2024 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577361; x=1710182161; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjtFtniifoQlqJRub627DOEGH25VNIzcRPx8GUuqtSw=;
        b=Wu+d5spoQaZo0zgV3uerVsox+G3/Ix+4RXUUDus01I4fpNX5Rh3foluz9zJpwmXXDJ
         wI44DKOaGz2SrcYg9eILyhYbyZRxrY7qDianm6cye33Zt879VpHRcw4sF3afr2/cKSwP
         +VAqVEZPgbVi8T/ismYw55jzNepjD6N69Enx6Sj08H48EagLbjS8ObcYbpxAoyLm0mVD
         Eg1SPvKLBraWnXyWPAdPuDbKbFtbCEURqJ18V1vgkAUe8W1Pe+24om4feP9nW0uGeFOj
         3GQvBnUkmQseiuIDm4Fr4ulFmA/AUSGpBiF3C31DAjl6rcFjbos9JO3t83DrR3kfLiQf
         AlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577361; x=1710182161;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjtFtniifoQlqJRub627DOEGH25VNIzcRPx8GUuqtSw=;
        b=fWlMpcmRVClK8ojjS6zU9iQqle3OAMEReVCIUaKlkKh22eiVBjAS7r7YYgYUv7VY5T
         BV76m3ydqazl9U2plFpAOaQbdKpGZvKYUmpIqYAxCLfd0w5sLkVUSYukECkVrOoGwZqR
         WfLDS6hnOulf1Lfqm/CeD9OBAOa6/MFF0D5y/8t0XiAtBnAxoaQdUw5BTDIhsz32RDq2
         xdev2tcVRiIpV5AQfTe4wnViKoQzIITplSQIsJgZn6oRDEynlw7eXFGK7Hh4Jibucs10
         Vm14XaTncR64ySdc3a23C3F2+BQgByK2PFQfXRFaETO0udM4dLLDRWWKDLqDyCEOmzVy
         kcjg==
X-Forwarded-Encrypted: i=1; AJvYcCVv8I/snIjbzLbPFExK9bFGiLOpvTUfMcZZ3D4A42RHmV5wkAb9KoZc97/c/oeHeYp+x0ieMfgoHsr/0bd06M8AgftRKzWRJRWJTM+0MitdZw==
X-Gm-Message-State: AOJu0Yzx8xaarKYRmMWFd93WReNnAUPIlgJuTqFHvXKoPYWwkJ3fMfWW
	XAfatYBYuCNDq9MVGPlab6fV4HgvefSXufqOyc0VtY6lveT9ydd9R3CKJrb5wHtoMetcZ9enIyf
	1xSxwtg==
X-Google-Smtp-Source: AGHT+IHYOjFVH6Dr/OVAJoImhoh7qAf1dpmY1zuEGfYpsOK5zEd5Lo7cjpUXgoE1elXkFnURIrd50lVYOvz6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:38b7:9cbf:f246:dafb])
 (user=irogers job=sendgmr) by 2002:a05:690c:3386:b0:609:2570:f06f with SMTP
 id fl6-20020a05690c338600b006092570f06fmr2734889ywb.0.1709577361605; Mon, 04
 Mar 2024 10:36:01 -0800 (PST)
Date: Mon,  4 Mar 2024 10:35:20 -0800
In-Reply-To: <20240304183525.3222581-1-irogers@google.com>
Message-Id: <20240304183525.3222581-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304183525.3222581-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 09/13] perf dsos: Remove __dsos__findnew_link_by_longname_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linaro.org>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, German Gomez <german.gomez@arm.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org, 
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
2.44.0.278.ge034bb2e1d-goog

