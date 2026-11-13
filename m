Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606578;
	b=nGCH1ir2IGqv01zDwyR+wPy1O+rcEK+g+iNnIHKzM7+v52gFqV6ny8N4TOJLxlqnZbUT
	 rs9jHVUlk70Ey9dbwZj79oZUR+Kt48WYBwNJvpXyKYwbyYDYqbdsCMxtW1fd48yGI3euc
	 3qV0i/XC/h/zsXNvXHlmJXNxRVpQMJJsEUS2ATSVJnrBiBG0rPbPAHYDpSbpTbMzb2LCI
	 a1VmJRrRzd4HOSsVYcZ/YNIeTXp1zs/Gu42NamD036roBr7kNiOPXZfB6VtQv/biAimiI
	 isVJUPrN205ltsyqxFsgS83G0n8qKiYzR95bTgEWnQZGJ9VTg4JbBAjfSvlxs0T3Uiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jq86rbtmHCfGTCXyNqVfJhMxh4HVi2BgNiFw4kBONdY=;
	b=j9efsPRKxX/UdmPiMjjRtcon0+BpWIgQr72KuR8VXCnLc8yGUBedKQIZtRnni8BNY15W
	 xTIxymIJSxPU+mOu0IhcYHa1sIHwH0Jo3WaD8/uHgselqf1IYQseuYyW9vQ9gdsFtvxU/
	 SIa+dBnh5Zm5qt/+3BOsB7oWqwqIymyiEo6RlVeIPwhdaQW0U6mGk74iXyvrSHLYMNDTe
	 VmP8fxLgIJ3eowWeGJKUrsoQh7XUDLU+ntZVFFQLAJC9efjTMrKjuAdBuy7sW7+zWPM8P
	 UbicTREx5TSaix2VKPBa/sz2O/RGl9AiDNeeU1C1e7tIP7Fl+vkrsgeKDJIMOSm4/0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MRc+sJEo;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65060A3810
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A65060A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MRc+sJEo
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2edd25534afso11715715ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606578; x=1795211378; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jq86rbtmHCfGTCXyNqVfJhMxh4HVi2BgNiFw4kBONdY=;
        b=MRc+sJEogaGVA9SE2NRCCcYksZyuJqR/PLrq6+5Nwc3H4l6q4lg9fAXTdEanuXfYp0
         5ttWZfAACGa7sKq5FqtE9hj+kTwKW5V/gyKVBlOb4NicWuuR/Te9tMGIszd5CJZDaH1H
         fb+7r4yw5v6kaGB9+ADQGpapUMw2ASvMlEnQWPOwfhY+mTsoVu94ct0vr81PcKG+CSHj
         d6f6VzTlsz2EXHdQ9dAsV3m3wTySam4g98+C5W2CAA/LZADSC8dsUrapLFU3adQ72YCx
         q63zeOZBkgBbK0/5vHnydbBXv+bTXhYPo9/tzloVaUCaFlPV5y0omqLjiky1cJaECsU6
         j+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606578; x=1795211378;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jq86rbtmHCfGTCXyNqVfJhMxh4HVi2BgNiFw4kBONdY=;
        b=Xy7SrSNJKVIRqMgETE0a1Jsat4AwIFwrN6h5jHC3geb+awLWBY10NfrCQF5vsErqsv
         eScETkxumbleravl0div+w7BOgPhtWyR5HS39mBHdn3RJ+498Pbxs5g+s6YN8ic0ncps
         uHJIPIxSKSe4bvrpz4Oc9mUkNs+8rDDjkIo298apvkFepAvRAqH+mQKSlMbapWV2WFHG
         gohit0HEFNSTxRG2JISlLH0HLrb6NDYKajCooD5v4hS14gV01hWSxykWxDLTr5vlNQs9
         8FsHZ4g/l/VrT2j+LFL/70+urUm5nGlndsoIArReeO6D1WNDFarsKa38FJkLZ+7FRkqY
         m5+Q==
X-Forwarded-Encrypted: i=1; AL+hErEU95TK7s2arKNw/0LNUGZZW0f/7SFv/MnWvGIhG6c1Qk2cr7/YrxDmdyq28ns7aNvZGNnyouzKXysHIe7HFmnS@vger.kernel.org
X-Gm-Message-State: APuU4Z+OIbV3JGENK7bY/2uaZUWZMo19L5nMxhKdvCIu4P8VUY7BiRO+
	aaoIDyvV5MP0uxaxfmY6Zk/ViSRI2YGag+0DhK5twV4Bl1yPDZ2GFXGeMGn5WwdqBtOx3wse7Fl
	K5isHnb9jpw==
X-Received: from pllo11.prod.google.com ([2002:a17:902:778b:b0:2e9:4bf0:5f17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e80e:b0:2ed:2176:244f
 with SMTP id d9443c01a7336-2ee0df868acmr37197735ad.51.1794606577577; Fri, 13
 Nov 2026 13:49:37 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:34 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-11-irogers@google.com>
Subject: [PATCH v1 10/26] perf ftrace: Use generic hashmap for profile_hash
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert perf_ftrace::profile_hash to DECLARE_HASHMAP(ftrace_profile_map,
char *, struct ftrace_profile_data *) and use the typed hashmap__* and
hashmap__for_each() wrappers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c | 43 ++++++++++++++++++++++---------------
 tools/perf/util/ftrace.h    |  7 ++++--
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index ac0107f5b891..02b4bf12451e 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1228,7 +1228,7 @@ static int prepare_func_profile(struct perf_ftrace *ftrace)
 	ftrace->graph_tail = 1;
 	ftrace->graph_verbose = 0;
 
-	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
+	ftrace->profile_hash = ftrace_profile_map__new(profile_hash, profile_equal, NULL);
 	return ftrace->profile_hash ? 0 : -ENOMEM;
 }
 
@@ -1347,17 +1347,22 @@ enum perf_ftrace_profile_sort_key {
 
 static enum perf_ftrace_profile_sort_key profile_sort = PFP_SORT_TOTAL;
 
+struct ftrace_profile_entry {
+	char *name;
+	struct ftrace_profile_data *data;
+};
+
 static int cmp_profile_data(const void *a, const void *b)
 {
-	const struct hashmap_entry *e1 = *(const struct hashmap_entry **)a;
-	const struct hashmap_entry *e2 = *(const struct hashmap_entry **)b;
-	struct ftrace_profile_data *p1 = e1->pvalue;
-	struct ftrace_profile_data *p2 = e2->pvalue;
+	const struct ftrace_profile_entry *e1 = a;
+	const struct ftrace_profile_entry *e2 = b;
+	struct ftrace_profile_data *p1 = e1->data;
+	struct ftrace_profile_data *p2 = e2->data;
 	double v1, v2;
 
 	switch (profile_sort) {
 	case PFP_SORT_NAME:
-		return strcmp(e1->pkey, e2->pkey);
+		return strcmp(e1->name, e2->name);
 	case PFP_SORT_AVG:
 		v1 = p1->st.mean;
 		v2 = p2->st.mean;
@@ -1386,8 +1391,10 @@ static int cmp_profile_data(const void *a, const void *b)
 
 static void print_profile_result(struct perf_ftrace *ftrace)
 {
-	struct hashmap_entry *entry, **profile;
-	size_t i, nr, bkt;
+	struct ftrace_profile_entry *profile;
+	size_t i, nr;
+	char *key;
+	struct ftrace_profile_data *val;
 
 	nr = hashmap__size(ftrace->profile_hash);
 	if (nr == 0)
@@ -1400,20 +1407,22 @@ static void print_profile_result(struct perf_ftrace *ftrace)
 	}
 
 	i = 0;
-	hashmap__for_each_entry(ftrace->profile_hash, entry, bkt)
-		profile[i++] = entry;
+	hashmap__for_each(ftrace->profile_hash, key, val) {
+		profile[i].name = key;
+		profile[i].data = val;
+		i++;
+	}
 
 	assert(i == nr);
 
-	//cmp_profile_data(profile[0], profile[1]);
 	qsort(profile, nr, sizeof(*profile), cmp_profile_data);
 
 	printf("# %10s %10s %10s %10s   %s\n",
 	       "Total (us)", "Avg (us)", "Max (us)", "Count", "Function");
 
 	for (i = 0; i < nr; i++) {
-		const char *name = profile[i]->pkey;
-		struct ftrace_profile_data *p = profile[i]->pvalue;
+		const char *name = profile[i].name;
+		struct ftrace_profile_data *p = profile[i].data;
 
 		printf("%12.3f %10.3f %6"PRIu64".%03"PRIu64" %10.0f   %s\n",
 		       p->st.n * p->st.mean / 1000, p->st.mean / 1000,
@@ -1422,12 +1431,12 @@ static void print_profile_result(struct perf_ftrace *ftrace)
 
 	free(profile);
 
-	hashmap__for_each_entry(ftrace->profile_hash, entry, bkt) {
-		free((char *)entry->pkey);
-		free(entry->pvalue);
+	hashmap__for_each(ftrace->profile_hash, key, val) {
+		free(key);
+		free(val);
 	}
 
-	hashmap__free(ftrace->profile_hash);
+	ftrace_profile_map__free(ftrace->profile_hash);
 	ftrace->profile_hash = NULL;
 }
 
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 950f2efafad2..5ed52e66b8cb 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -3,12 +3,15 @@
 
 #include <linux/list.h>
 
+#include "hashmap.h"
 #include "target.h"
 
 struct evlist;
-struct hashamp;
+struct ftrace_profile_data;
 struct stats;
 
+DECLARE_HASHMAP(ftrace_profile_map, char *, struct ftrace_profile_data *);
+
 struct perf_ftrace {
 	struct evlist		*evlist;
 	struct target		target;
@@ -18,7 +21,7 @@ struct perf_ftrace {
 	struct list_head	graph_funcs;
 	struct list_head	nograph_funcs;
 	struct list_head	event_pair;
-	struct hashmap		*profile_hash;
+	struct ftrace_profile_map	*profile_hash;
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	bool			use_nsec;
-- 
2.56.1.703.gf848ed807c-goog

