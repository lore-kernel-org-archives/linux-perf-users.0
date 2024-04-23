Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7985E21A0B
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713846389; cv=none; b=jy4RwVBUAPGsFtutpVqYeqaCw3bSJqlMpuOL56ZbHMqFPKgXM6A9qZFXUzoOUoYqts9Pl1b9JBElZ5UYfwvCd3XzzmK91sx9o2pQ8l2XvM+F7xHL7LoK56BlNxJY3MPtK+J+eMc5AJUIJEq9uCKUmaN7TIPlmCNBggO8N/+KbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713846389; c=relaxed/simple;
	bh=7wUIMCnoFq7ZLkHWL+493f8aFpVbZ9Nfs5gexZ7yT5c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=i97Jc9XGhho7rc5NM9cpmG6u5V8HfLWMPg65ph7RZJUsc6/lSI+QmhP5Drh269rBr/1QvztrrizcxtmXC/4Bzwm/5JTuvvF/HXRGf3Seyy5jM4Gt7wTofTn3qoJSEuYxg8Mu0RdHZxvFywSDRMf77YOCQ+NyseZGnrMOugdD6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OayLsIQj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OayLsIQj"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45d0b7ffaso10081093276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Apr 2024 21:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713846386; x=1714451186; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaakWA+9pmWCC2IKulyCPlxCN4FZjrOrV99o6doTC0Y=;
        b=OayLsIQjMbrtAVqmfNyK733j2W/ZPe6AU5dMPVgJP0jcbmgoc4zr4D47aZioWdHJd1
         /NrrDzql1ZLxQetrPBY5+JYzeamUutNnqf99Gsgfmw6yIOzbP2awTP8TpBmTobxZkrRS
         gpKGxwrAMyw9Jypt4x+0pOyIzw60Lu2BNLRAAt0S+9ipDBabUUs0mC7N+F7UOUASfhMS
         amW9DEiTvEtWRl3RCCBfYRCLs8cwI12juDdtuoHsyG9CqqaMuUonwsns+x6t7b9l0/Xx
         Nn/NUkaz9l6ItXU6bCH9vrV7GxtutErKmZ0g/qq0K1Pln6U26dGZ8ZcboWrBPy2eJ4/P
         8McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713846386; x=1714451186;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaakWA+9pmWCC2IKulyCPlxCN4FZjrOrV99o6doTC0Y=;
        b=q0MclPlvR9eL2e0RPxOo8DSGF8T63hAndmf00zPKAo5M3lwYoK5RpHWMTgJ+vVA5Mk
         aL56ncbe4lvQEizsNYuMSnvzbSLxJGrgcdsLIT4GrylpunZbf748Tsaf9/TPuzyEMZAc
         xrhqCjaMBLUug9qZaDHTHzvpYAcRcylIg7j5MGovhnsWqEsGarWy/V/7HVQnrPaVVCM7
         a4Q6BFihgD8y9IvxuzyK+lbF/Kwi7BcjBagaNazIFpK5P1kMSMlVbm9IIPqhgVIoGqaC
         3N039W1fVGEkKJwvC/YL6Br/LV6lakaSBQ/LZg0/JYR5dDi8gjNFr/evCC46w2f12hwF
         yLhg==
X-Forwarded-Encrypted: i=1; AJvYcCXPk12/3oh6j9BU4xOIKEWs84BgASm9B+GznOIFrP7yjpvPocbNpVKpuscQLTHRqnm8Jv5CRprimr2AVAF5yBGzt0Ia1tpqnJTiT9d4XL6o2A==
X-Gm-Message-State: AOJu0Yzxmvtr7FrXgXzmvZAC3//Kv/elTD8E/LhSG0UTwoQnBZ3lJOa0
	8SIVLDz0OhzkSijdQWKy8IY9bnsIsWgdRUxnAGBXfjfTNY/Tx4KAwIJ1jiwrE1Ymha3V+BsxEVz
	WnA+U4Q==
X-Google-Smtp-Source: AGHT+IF1R97qVBn469onpIbuazPHHk/Dl//rgemCUBMMtu8P8PDy5xyuSGV8RV8oOLuuOLZmu4zvXMjJuyR1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a25:ce12:0:b0:de5:5693:4e8e with SMTP id
 x18-20020a25ce12000000b00de556934e8emr21316ybe.11.1713846386461; Mon, 22 Apr
 2024 21:26:26 -0700 (PDT)
Date: Mon, 22 Apr 2024 21:25:57 -0700
In-Reply-To: <20240423042601.2009469-1-irogers@google.com>
Message-Id: <20240423042601.2009469-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423042601.2009469-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v4 3/7] perf dsos: Remove __dsos__findnew_link_by_longname_id
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

