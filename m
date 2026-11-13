Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606619;
	b=o8q5lmW9DDnoalim9/6cSjxnvWcsEiXGeTGRGFtYIoTtslgqH1DNm2uZnk+DwJOWsABm
	 qVB5L2oejUSwzAGv28dzwUaEtKDUF9mUS7EqG1Yj5Cb3so/k1ZcZJoRW6M9YpBuAso5Dn
	 b0Zh9AwnGb/HShpEP/sMqrwWg0qTutX9dj45f4Pb90CH+NghCMUg+cBqeaJ2BHFqDirWQ
	 h7nCLt56C+5L2oPr25TchsEcyaGN8SBsV4eRobPVSpXrzwDSBVtRlnk1sANGQPP3ZTBej
	 LGM+g6motwaqQD8Z4KCfGvf4fyIdmiszVVeSFDUX3AiP3cLnQ83JwG4yIzWKrQZXm8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=20FBjiYEHLIAyBJpKjtstE2CmYArIOoKSg7HdyQLaKs=;
	b=gZURVCjoLS1D34jiS8BaDD1dOrrGZhO7/GC7werFRoLd7os2pY2AEFhvpFF9thOC8/4V
	 3QfDy39Qgb0GChzM55+YonJAhlqE58Jc37uA+5fzQSB+8U9Uc9Zl0YF/WcJOpT/L9aJQ9
	 BBZgFPKJtv8hDUAv4MjKy+qGWma/Ab7at+5ZR9Add8iVcyOQ7y8PaToxQ2hnTgludhho8
	 A+UrNVSzae1EihVkyyvBLOzar1GSy0LNodTi5y1i13VpSpmtD6I6ps3hm90S7Fnae2NFH
	 61fJj3dMMoXYUtmDr6z4wIN88uc29enKLGs/nzPOYPy5cgpXFejrCqyn2+4kxMp4Ghw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j+bqwudw;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48047606AC1A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48047606AC1A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j+bqwudw
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a71dd190b0so1185865c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606618; x=1795211418; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20FBjiYEHLIAyBJpKjtstE2CmYArIOoKSg7HdyQLaKs=;
        b=j+bqwudw2T0Gxx9hCdjy6tvFIVLoUBtCMwoM+XNsugfT8wHK/ma8ffWb4dNMDgF/yT
         iNc6lm+4hbUe/giUjD55BQN348RykGjmlqRm6AJNVSItIJ8qiUY5Lv1sUnM2l3hdAbqr
         wghjZLwhQmB2BeENIr32PywtWkOTl/O/gd/+XX/w/V3KjyGd2ySAGEhUO5Ex6iAbfK9e
         1XuhmBXrMHydHEIKWyKcjERPWeGS5etYfs9cu/jIuVqa0HeGymZNdNQgw5IV4rRDdW2w
         MviIslxbtGaP5bbc5+zRHUwKcjpcLmkyF6SCuMD0b08OofjEG2ZkSZwJK9U3KnyCHHDc
         dSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606618; x=1795211418;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=20FBjiYEHLIAyBJpKjtstE2CmYArIOoKSg7HdyQLaKs=;
        b=GRzvr4ncwxDuber49RrWuLyQBuwwuYBDdAJQA473nNnTzmkWjFkUH2fbVFvIHqdgvs
         /KhGxMkMJ3sTRmx7c9zDYfr8sMeGn4Qeee/Z52iN9NA7sZ6vqu3TEOWfQy3RSyOaaTd5
         v9PaN+FwbMaBE7eoBT1aClEaxiujZuAhl6SDrtYfm7NMMYrX1a/MhwufdLo3or+vDKOI
         24hALhuqY68GxumMaGKJI4tahaSCTqkqG4ewIdvYOaoLKkiTbII111gxp4HdnW5Q8Hhm
         WwcO6KfQ6D5plO/Wjyiq+dkfTc1rdm5sO+YxZxB/fQ7V/QSA/6JBoEYF2xYeJJBEQ7Rj
         +OEg==
X-Forwarded-Encrypted: i=1; AL+hErETn/sVDVy/BVOKm6FyU5AIPbONpnTI31MdAhC1JKogvtZ2WOMYuL4hI1HcdNj+/UJgxryYDqNZPQpkZ9lAFnes@vger.kernel.org
X-Gm-Message-State: APuU4Z96kYPcJjc9E98ogucoAIXHPOK8cjfg4FBDjAFPnTNsqQezPRUP
	MpV8HPwVRpgPrpj02S35ga1YIEh3K21n0lK62k/yH+RSmde0XI12HNOx6xaDKpUvsMUrna/aDBU
	0LGbz/dyp1g==
X-Received: from dleg1.prod.google.com ([2002:a05:701b:4301:b0:1b2:43f5:b296])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a4b:20b0:1b2:4e2c:6838
 with SMTP id a92af1059eb24-1b50314bed1mr3398593c88.15.1794606618032; Fri, 13
 Nov 2026 13:50:18 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:49 -0800
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
Message-ID: <20261113214850.3329699-26-irogers@google.com>
Subject: [PATCH v1 25/26] perf inject: Use generic hashmap for aslr evsel_orig_attrs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert aslr_tool::evsel_orig_attrs in util/aslr.c to
DECLARE_HASHMAP(evsel_orig_attrs_map, struct evsel *,
struct aslr_evsel_priv *).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/aslr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index f9c961775e1d..8aaa685f4203 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -75,6 +75,7 @@ struct top_addresses_key;
 
 DECLARE_HASHMAP(remap_addresses_map, struct remap_addresses_key *, u64 *);
 DECLARE_HASHMAP(top_addresses_map, struct top_addresses_key *, struct process_top_address *);
+DECLARE_HASHMAP(evsel_orig_attrs_map, struct evsel *, struct aslr_evsel_priv *);
 
 struct aslr_tool {
 	/** @tool: The tool implemented here and a pointer to a delegate to process the data. */
@@ -91,7 +92,7 @@ struct aslr_tool {
 	 * @evsel_orig_attrs: mapping from evsel pointer to its original
 	 *                    unstripped sample_type and registers bitmasks.
 	 */
-	struct hashmap evsel_orig_attrs;
+	struct evsel_orig_attrs_map evsel_orig_attrs;
 };
 
 static const pid_t kernel_pid = -1;
@@ -1341,8 +1342,8 @@ void aslr_tool__delete(struct perf_tool *tool)
 	u64 *rval;
 	struct top_addresses_key *tkey;
 	struct process_top_address *tval;
-	struct hashmap_entry *cur;
-	size_t bkt;
+	struct evsel *ekey;
+	struct aslr_evsel_priv *eval;
 	struct rb_node *nd;
 
 	if (!tool)
@@ -1361,9 +1362,8 @@ void aslr_tool__delete(struct perf_tool *tool)
 		free(tkey);
 		free(tval);
 	}
-	hashmap__for_each_entry(&aslr->evsel_orig_attrs, cur, bkt) {
-		zfree(&cur->pvalue);
-	}
+	hashmap__for_each(&aslr->evsel_orig_attrs, ekey, eval)
+		free(eval);
 
 	hashmap__clear(&aslr->remap_addresses);
 	hashmap__clear(&aslr->top_addresses);
-- 
2.56.1.703.gf848ed807c-goog

