Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAD481B2
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854600; cv=none; b=NWAUAauCUheWHqBoKE7UqhuWzFK8hcQ/akYxUfxBztWef54HxZIRq1CHaWTRu+Wno1kHK80R/rvkFdm3clwBeBqT+Qq4n2QdIeusfgf9GLe2c1WAfEgtO0uZglAohQConG7y6VriFbfk9uz9CG1q2i6AE5myjIEDNz2kt6iZZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854600; c=relaxed/simple;
	bh=xDTTHE1+3Q/N7SIwR8+1310MYI2J+UCB79HiHPCwufc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OtdaEVuK80KK9i/CpHiR/5Eu6phuqLtLHaJF04Bix/CiXsLLnj/Hk4ToOx60HGbWA+y97p1aIhRv1l0AMGuLvkwZ7h7j09CvvEDK9Kx5lYdebO6HaCxABotlFN5shAIp9u59ON5fjFeNtdwgugavgNgHQnbVtEB7FJApvDqnlqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aliQj6aw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aliQj6aw"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso3123687276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 22:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854597; x=1707459397; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/Pk6SJ35jEAj4GFAF5mDm6iqfrtol9Y+OYWK8WFxKo=;
        b=aliQj6awUeLxTBXLmiOAd7NSRgnNGgx8OxnFFbCVTNXsrXSVml3mWixNzSXbVqj1RP
         l/jnFfDGl6qTADw6swZnjmbYa1VxvdOGzPncw7+aI7+4RKZo5gMenFzMDPXcj06kPNvD
         V266u5BC3NrrYQfxVkLjULhgqijgxrcGJLOqW+paNYd0p7MUAeHL99dgQ/NZ5TgCs3b0
         pEx67VJYlIFvDz43dOdPUzQfxLqW0a4WTTOiwqe2QziFDCmdIZVhNLkAN/WQUuxD0m7P
         +1eRN5KQhbsoDOpX9CjA1bmqjk3aH1AUfgv+4fOm8m3KElaZCcsqX+xApQ1gnkT2S7vc
         XwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854597; x=1707459397;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/Pk6SJ35jEAj4GFAF5mDm6iqfrtol9Y+OYWK8WFxKo=;
        b=MgLq2fQ5IjHqa2UKRfGuqszbPZQ/rhb0qDGOe8hyCs839kDyX2dWzpgFIKREJZG2Cu
         o4M0how5SIzNgpOoj9meQVg2eamEqa+mPbDSgAh7qc3ed47wipQV+7l4or/VsFU9xjfJ
         n45WkrxkRFE2ciyvqYbqdbxHPfrHl5/x6tJzDQEdnWSZznudE/BK/iMDY6RJtH/iHaDg
         UcPoFJfyw60xLesYeQsHxyf1XUS06q77kvYcZuRpJKm2ZI258Pj/fK1rdahh6FuIhxH1
         ZNmx17dxRLSSCC9JIzZKY4/fQ5s9ku01AxHN1gMYsU85utSQ/6/vhkp5F8W+my6SmxSe
         HxIQ==
X-Gm-Message-State: AOJu0Yw7Y9QoGcmkc+2BYS1H4J19afNoc19pDsPQWodYuXDriStx+aVO
	ruPg7o8mJVGwzqi8Ta8z76ay2jLvBE+NtJYq/fXeIl0IhuRrjvwbazLgfRAdqjwCRn3lu7Yvgt3
	0ItZCgg==
X-Google-Smtp-Source: AGHT+IFBp/tYBJQcYucHVMYGDXByehoOSCjCVT7PCuga1KSf2I/TdysoicofOxaqt8PAtalbiaAzX5LYJOl5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:6902:2212:b0:dc6:c7ed:e72d with SMTP
 id dm18-20020a056902221200b00dc6c7ede72dmr356062ybb.4.1706854597627; Thu, 01
 Feb 2024 22:16:37 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:29 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 22/25] perf dsos: Switch hand code to bsearch
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
2.43.0.594.gd9cf4e227d-goog

