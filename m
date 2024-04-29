Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513BD13BC36
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416396; cv=none; b=Uh0zcmIweKErXedt+XUMdIY+rD2VRUqaSg0GgDzld3IbeQgp4QpmPDDc2Ih7G4dL5HTzNWDy7vHVDkku5W/5e+DOeEZohrMJ9V67smAmE2aLK2e37hboIsc1FxH0wQiPyCAyl0BH6Lu8gPzdDZZJEblOKvuyT19WBv/4XCa5Ymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416396; c=relaxed/simple;
	bh=lIMr2C7pqzDmaOI4kvlL+gVjJA0HX90NyHek76POXmg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KkMTlRUL0wkgeYRQn0oBivF0ZPm7x/Lt1K6o+n9PkfIvWTjCrbB+l8kZ4rMOYmO6HsEjWAZAWRImUlsGw3lnfzPDCy4IiZqxyLoCKrSrhT3iO5DwGVkqbSzD9TSEKtRVgNDhLrSwcz0AyFNZgwegs2eiORhGQs6dHuOgYwSMQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAsCQMof; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAsCQMof"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be325413eso6906317b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714416394; x=1715021194; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t830lzcH7ZkA8fGoYpxo9R5dnhJpcUV3/G0NAtLbkkI=;
        b=RAsCQMofKX/qnXwz+B98pphpFrLRT+OcKCBriURhKFpGWWrfVOT7lxZwoZaukH0Tch
         Dr5qdwSTeo5LjLmaOhJb9XsBEWZMTaSuLcLtDnOKMhibwz1JPV2KZF+1lte8lxYEqlUy
         eZTAjrvuTdzxMEqC61hTxGsXW0EisO3/0uhtUWhixxrsCp/a0G+lT3SdnHZEwIHG7FN2
         kNfG2dH9LLYJ/wlWJhr1sTEA8vTg6slmnQ+FVFTxyEzC9wOu7q72CIp86wZOpHOHj7Oo
         2Qk9yW8ylBRieadHqcwzSo83VLuTqYSpFdP2HEaIDJWsN5PQHatMXDhswa0F/mCP3LpD
         6xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416394; x=1715021194;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t830lzcH7ZkA8fGoYpxo9R5dnhJpcUV3/G0NAtLbkkI=;
        b=o4+adM7wmVuI1D96LoSvY6v8DSmR2LDG7dS1WReKyYD08dVE4hQIMF3Vys+xP2oKos
         99pdzp9Ep1ppXXAcwxWl2nykKefolouzp2hwyxaHtR7Dkad7WXoyrZWW/djY8F5JNZGp
         uy3k+hGwWuJ+h3Px391usPWJBh39/piRubfUsVkYIjEmva53ASHWyCWjqpEnCCFWkqWW
         Ijv2McmOLIQWcVYPCnuEnI9m4R3czLM558cn00+jgbWDX3JPzeHEBuOy/lkIYICL1pfu
         s/5DWUBtOwc+w2Hu5SmV0mwAk1ciDhTvdq1NKUzCPmEEm0u3iM9NJxbuSD0k1XuQeG/U
         ivAw==
X-Forwarded-Encrypted: i=1; AJvYcCUdncpwMkdTcBYHEXwM1Vf5kTyzbRIkpMajK7o5RBNCIZgv02UVUGFuqinOW+ktN4dVoxMHlvJnX4uBZJKhPwaVf2o+sUgVVpGycKGj/8t9fw==
X-Gm-Message-State: AOJu0Yw3eXv3hEZngTbcOKjN40sL5Ln4FCAM/4iEo1w8q9Sp7vM26VH4
	hcETqhG8K6l2eC27vbXBqM63vaKg/CkTgSLzOzsK3lThKbTR5DkL4tpGYnpKp6i+fGQ8jFk9E3h
	uZDz+lw==
X-Google-Smtp-Source: AGHT+IFFsmMPcHsPdDc+H2stjnuMt+QQETrq1lIc23awjP5WEsDkUfiVQzwpl0Hs74qYWMuw1BzKaJPC9FQH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a0d:e2c3:0:b0:61a:d420:3b57 with SMTP id
 l186-20020a0de2c3000000b0061ad4203b57mr112870ywe.0.1714416394201; Mon, 29 Apr
 2024 11:46:34 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:46:11 -0700
In-Reply-To: <20240429184614.1224041-1-irogers@google.com>
Message-Id: <20240429184614.1224041-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429184614.1224041-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v5 4/7] perf dsos: Switch hand code to bsearch
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
2.44.0.769.g3c40516874-goog

