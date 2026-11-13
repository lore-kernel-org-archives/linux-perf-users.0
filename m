Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606617;
	b=ajlJDL/DdsBpQA+5xAKPJNp5D7ptEeJhBrvUY5ejV/Mr9+Btc8lLiMTmxYlDm2KWxJJE
	 vCNLEXqYrYIwnRhkT4j72oxXGnbkZ7nGzpewGRKoL5JSog5jMh2xMJ5yncrFuUoKsznYy
	 S3etL2OleLwojibGaOXtBCCMhU9y4Ac1+bd1xax1eMzVcODh/Y8p76I8dB40IFsrdwVSb
	 h/eBjpI9CYBc/t8drhtkFV2iNo/nh7yL0Xd9oyWOUGOSAmYtuwroj165P8hv+NW1B7HOF
	 SqdL8xeYOu6cBp0pbaNe+/zG1MkaFfzw+lRFpIAS94at7QgSWKGW/Qt8ebMz0h8hXkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=u76hiobow2sh6220ebuI+V8/EMTbxbQPSxyin+u7NdU=;
	b=L850UEKY1i9ihg64wzLkz1+JLr9RSrwS0X1nRTqKgmFRMVt6THp+0Nwxbla4fa8LkK+y
	 n3/WEgQEuG6I5k3Ra7wmuIlji0RbIIubFNtHqk69RQTrFDoj9Cm4+zvAF2e1/NhPz6Xb0
	 7swmiUNpWyuh65cN1FYJABsWPCaqijU8Gjy4lsnybW9z0ecOEflia1lwIcr8IADnEcP9z
	 TcyAWZRzTCwLndxTeo86ax6dJ832PR519R7n3TPXqapDJZNXP7wIq/Kn9uHn3IMxkn4z1
	 ce9INrhJ9Cme9GBhOh7SJnZ4EgmpEhHWMi08ps/4ofYfDFdf3IcwD4P/4q5jHY6n9hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iZSbx3e2;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E72606AC2D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E72606AC2D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iZSbx3e2
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e942b1cc86so13265475ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606616; x=1795211416; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u76hiobow2sh6220ebuI+V8/EMTbxbQPSxyin+u7NdU=;
        b=iZSbx3e2w/WU59rErZr1cu7vsKjz5v6yk0ZFZArh116FX8qfRNY2KkNwt47+Lz5sho
         Xb34lkxyzm+Tl7QGCMAWcU9WskWXKz5tf7eMxGy4OESAWw5K5QZXGrpAJ/3EAASgmlml
         0X2E1QJm1zHwHhXrfrt9FlP5rNL1tFLeN2VjT4B/hoPO4nsfv1o2rxhiI+/SbAEG9Jly
         fEIE7m25bul7cMiikxxEVz/Iwxz2FrCjGBFi4ENCBsqZRK2pNWhEsg2rlK7wFjjj3aBl
         7rCYK3XS+0KU+hMm0GepmGzvZygM6sRQhEhm2t7A2ohsTmqGTZ0pE6bk3MaNSq/lqBpB
         SkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606616; x=1795211416;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u76hiobow2sh6220ebuI+V8/EMTbxbQPSxyin+u7NdU=;
        b=PGndK3Lopjnn/N+O5mLC+rar7eVNCK/1hVNf+CVZTvlQd9c1XQ1qB8hfsF+OAWTbP4
         WY1lXWZcssN2dmJIYmYxR70C0vkW1ZjantfNuCYdqINIHRy4DOviIHIrI7wH0oNBe4PP
         mrkY/gV3PINZB5gEAeMYJhLsORy94Y2gqajrUnaFDW+iKvaC/KZVDqmszcYsPLTGIKUU
         hhMLujYb5IUpgKmoLXt4kVlriGwzz1NLHbehyeWBs50JI3jd7oir7A3r2Z8JxbNzaQq9
         Iaxs6UWqi2Zk1EBqW7+joYrak7vRmJz121hBowlXFPONiYiFJv0wtFnQMXJn3ztY/VYw
         Lfsw==
X-Forwarded-Encrypted: i=1; AL+hErGXIYsMHw8fbehzsrHREDR5TGN1DVXSTyDlK2cgY8QDdViz5AiaDXbUyDs9V29l8pxx1oc1iRi8dNL/FF7Kv9nl@vger.kernel.org
X-Gm-Message-State: APuU4Z+PZv+EH4eF22jPvjbRcHocovapDhXrRA7qf0WT/J3r3ePbUZW1
	BpOxXqIndcTVi1Tk4co4Gc47y0gDda9yxcfTRwx/MoGN0Cnsf+Q+D6uIFQNRJF/e0/QijXi3r/t
	kYnT3SuBk0Q==
X-Received: from plbbj3.prod.google.com ([2002:a17:902:8503:b0:2eb:4f8a:98bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e790:b0:2ed:379:1592
 with SMTP id d9443c01a7336-2ee0dccfa1bmr40415405ad.26.1794606615571; Fri, 13
 Nov 2026 13:50:15 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:48 -0800
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
Message-ID: <20261113214850.3329699-25-irogers@google.com>
Subject: [PATCH v1 24/26] perf inject: Use generic hashmap for aslr top_addresses
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert aslr_tool::top_addresses in util/aslr.c to
DECLARE_HASHMAP(top_addresses_map, struct top_addresses_key *,
struct process_top_address *).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/aslr.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index 068e0250b151..f9c961775e1d 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -71,7 +71,10 @@ struct process_top_address {
 	u64 remapped_max;
 };
 
+struct top_addresses_key;
+
 DECLARE_HASHMAP(remap_addresses_map, struct remap_addresses_key *, u64 *);
+DECLARE_HASHMAP(top_addresses_map, struct top_addresses_key *, struct process_top_address *);
 
 struct aslr_tool {
 	/** @tool: The tool implemented here and a pointer to a delegate to process the data. */
@@ -83,7 +86,7 @@ struct aslr_tool {
 	/** @remap_addresses: mapping from remap_addresses_key to remapped address. */
 	struct remap_addresses_map remap_addresses;
 	/** @top_addresses: mapping from process to max remapped address. */
-	struct hashmap top_addresses;
+	struct top_addresses_map top_addresses;
 	/**
 	 * @evsel_orig_attrs: mapping from evsel pointer to its original
 	 *                    unstripped sample_type and registers bitmasks.
@@ -383,8 +386,7 @@ static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
 		} else {
 			*tk = top_addr_key;
 			top_val->remapped_max = remap_addr + len;
-			err = hashmap__insert(&aslr->top_addresses, tk, top_val,
-					      HASHMAP_ADD, NULL, NULL);
+			err = hashmap__add(&aslr->top_addresses, tk, top_val);
 		}
 		if (err) {
 			errno = -err;
@@ -1337,6 +1339,8 @@ void aslr_tool__delete(struct perf_tool *tool)
 	struct aslr_tool *aslr;
 	struct remap_addresses_key *rkey;
 	u64 *rval;
+	struct top_addresses_key *tkey;
+	struct process_top_address *tval;
 	struct hashmap_entry *cur;
 	size_t bkt;
 	struct rb_node *nd;
@@ -1353,9 +1357,9 @@ void aslr_tool__delete(struct perf_tool *tool)
 		free(rkey);
 		free(rval);
 	}
-	hashmap__for_each_entry(&aslr->top_addresses, cur, bkt) {
-		zfree(&cur->pkey);
-		zfree(&cur->pvalue);
+	hashmap__for_each(&aslr->top_addresses, tkey, tval) {
+		free(tkey);
+		free(tval);
 	}
 	hashmap__for_each_entry(&aslr->evsel_orig_attrs, cur, bkt) {
 		zfree(&cur->pvalue);
-- 
2.56.1.703.gf848ed807c-goog

