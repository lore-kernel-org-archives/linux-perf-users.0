Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606600;
	b=SKjIYmrAwUs5znlMOBRk5twSwfciVRn4hUTBEuFjLUUKP1EHnRULLz23oeQThLI0k6zr
	 utshiybSVsFylhBqjfpgYZugpiwQp0qdhXkFvK1vgoDt9EaSM1m8f7XCfSpALymTD/K30
	 jnYqiJyogI84+53BRQUJvxHrjlzZAn8KCH3rq6wGe1sQ8R+PPEy4Ip3ZfoZt67r3jim+F
	 +6tol01B1mNkfZHe+bXVUB+xrNHiXycksyArrl06fIqu5tmWlgUdG3JXazXVq2FtHYbqH
	 fExZi6Tvi+9oqWoMDc3Atxbc41bon226Ppe8MsKj5tTCAkDnVyIPqStb0/jgKlxJBlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uYC21Pnl3GWWGtwZwoI5E/x8WHXcMx7NEy2Jgq4qSlo=;
	b=5SCv9wrdeQVYggAAETb7H1JAMFZKlGMXo9c7BSdtZHrGSvnN/HFK9yu5bpeuNGX2IcvU
	 TLf9RU0I3ux80WNJoDPzQR5kI7qp6OczIh2iI9jwphmSkKaStTrcQNC5kgXt0Bp4aOMb4
	 2Z6KGJBLIxVnUajq7I3ETi5JbXGgTIiWlDdp5Tz0b2bU6nzdvlWryCbOS7tZc1ZdG5too
	 NZUxHHotqIvpBW6rvbC99j6Xj0ZaomT4cG7tAVxqJ2RbC3g+JghUfe1yk9YJi62i2hZYe
	 WXLgZkT2xd34yUWI6bAlMuiNCpxAghBb1cPk7VRLWXeN5o/5qFDFSVzA9Un5YVB6PAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aggjouJr;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C9606C99A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320C9606C99A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aggjouJr
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2117375eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606599; x=1795211399; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYC21Pnl3GWWGtwZwoI5E/x8WHXcMx7NEy2Jgq4qSlo=;
        b=aggjouJrKDj7l2y++2dyqu3B/h8iSqAFq9hF2HPwH8gIPdzeIdVnik4+gYttGyZPnt
         e1P1a3qk8lS/jxM6WvAoIhOt5H5g0f2XDUj8qVzFJh71A8NC5xwA7rNusAn3qB6N7Uib
         wBO9L5K51XrjuIL2raZJtNWo2Tv6LcWfZIu8AGyt9fkscu9X8HVWkSfkSiWfly/Q5d96
         dZk2doc9ICnlXxFhVu6G4w2Wo6pfY4rNJ3h02nmHeMg53AyW+odEVGl6HqvN44/uu5NB
         LS/WTCXvr5mrg3bzQaMOh2jORq2FYeoSm63Yo+H/ETfivwA7PegsVqf1BLi1W+2h9BOm
         wf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606599; x=1795211399;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uYC21Pnl3GWWGtwZwoI5E/x8WHXcMx7NEy2Jgq4qSlo=;
        b=Uq8VmAtblkh7NUByic8XfPTxLHuN5ugkFlzaOMQ9x5x1JNHZ9vzWnzpnhaLhz/aaM/
         ZQOHV1KCOw0xnpgmlNBtJ7L6ZcTQPz92sylLwAWFgOeiHfkz7hPz0ZsAgnMSbLhIs5PA
         5ZRBHZI15N591l0f2hmqb1n4gfIXur4RZeQdqcERG+pMv3MjZHGxTmq2P+WBmIgx9HuT
         8wIXPPuBdgTru10ahUqko6Y5QMwiUMXt1FAALXRoYN2RMPgFL100Mv+rUFj2xanpg3WC
         ljp+XCe9t5mY1oJtaiSvG3flhVuZcGFzoIA4Xl43TVy+vG1R9kHDh6B/iAbab8Nu41ww
         zniQ==
X-Forwarded-Encrypted: i=1; AL+hErHAD5MAO9VfLsrAv2TzisNev/1VwO4ZM+o0fR5YFGCG19x2AzWAfF2uLbjmJ4SbyHQktPXn7k4qGFT8WTu6sAki@vger.kernel.org
X-Gm-Message-State: APuU4Z+mCI4bhAkAUaTu3LSECBlz5PvMnBtL6czFAXalPcP0qkZXbWG/
	COBaBysCIVBsNyS2LMjgTz0J6mUEzewle1pxDFdC1oh9jEq/TFpHMTIyac/cnFaXb6FhTgmIH1X
	6KVzZqZCqmg==
X-Received: from dycnn11.prod.google.com ([2002:a05:7301:140b:b0:36a:1c45:2f79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:b06:b0:36a:1089:9836
 with SMTP id 5a478bee46e88-3796628ce32mr2703477eec.15.1794606598899; Fri, 13
 Nov 2026 13:49:58 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:42 -0800
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
Message-ID: <20261113214850.3329699-19-irogers@google.com>
Subject: [PATCH v1 18/26] perf s390: Use generic hashmap for counter name cache
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert the counter name cache in util/s390-sample-raw.c to
DECLARE_HASHMAP(s390_counter_name_map, long, char *).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-sample-raw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index e0fac2aa15ed..c9afc4bc4a39 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -170,6 +170,8 @@ static bool get_counter_name_hashmap_equal_fn(long key1, long key2, void *ctx __
 	return key1 == key2;
 }
 
+DECLARE_HASHMAP(s390_counter_name_map, long, char *);
+
 /* Scan the PMU and extract the logical name of a counter from the event. Input
  * is the counter set and counter number with in the set. Construct the event
  * number and use this as key. If they match return the name of this counter.
@@ -177,7 +179,7 @@ static bool get_counter_name_hashmap_equal_fn(long key1, long key2, void *ctx __
  */
 static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 {
-	static struct hashmap *cache;
+	static struct s390_counter_name_map *cache;
 	static struct perf_pmu *cache_pmu;
 	long cache_key = get_counterset_start(set) + nr;
 	struct get_counter_name_data data = {
@@ -198,7 +200,8 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 	result = strdup(data.result ?: "<unknown>");
 
 	if (cache_pmu == NULL) {
-		struct hashmap *tmp = hashmap__new(get_counter_name_hash_fn,
+		struct s390_counter_name_map *tmp =
+			s390_counter_name_map__new(get_counter_name_hash_fn,
 						   get_counter_name_hashmap_equal_fn,
 						   /*ctx=*/NULL);
 
-- 
2.56.1.703.gf848ed807c-goog

