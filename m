Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606615;
	b=s6BBaxEtgag16bx7Hn1uIHKyAlv8M0b+hvEPeanBX/jyWp4Rkca2eNjgkumOWkxfkgCB
	 8eTJhMKBXMfGGogjEWBnD2033zulTEbyroa6AFSz+2DE4EEydskH1sueZ99c98ild3/GU
	 q/wa6Vl1mZKiuZdd+1i46Me8KL+wY1BuKHrCssVL247YsZwpNUu2MvI54yisr64df2cYh
	 6iH8Ps6Ko/lHaP+WHG7HXWUW7YNC3xu6LlRoVHeq+t+4QqkI4RPgKc1xw+m/7/Oc1Wn5U
	 yzd52r0CnKZMO5vwd3g+diLCMLfJEw1IcWEdMteCxNyQEBw0Gp/rvOwiZ6kBWvsfMuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=yx/V2gPrdDaexlpKpFWuCGkCF4A7cUFJ2vXkWtFB820=;
	b=tCXNYgvficwjDBOnWVwNhl7GEycDv0lZvc4DHoFfKFm+Rh8P+6L74wTnJndBrDeCMEhO
	 VmZvHUh5jHTBJbXNEjYQVEE+8sgBPyFvd1aawU9C7nrqZwClhjh/AoERZnd0yRnaaG5Az
	 +nP2hponnv2EA4Yxrjjn65ipLFdVe/Hq9hcePTa9Uc0YzfXQcySkciL2d131T6EmgN+eS
	 XaADnJP3PqTn2a3ctyu+WkR5Ms7qxGtPyX5gXJ42gbNmjDekR3xRuYcjvZINtjalCJnDP
	 a+5pWt7ep1GzI0ZfR6jB1671HWWVMF832KvpvkxyBdBLrrNNpiJybY0h5asXPlwWoKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g2pLdmWc;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E4606AC0F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD2E4606AC0F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g2pLdmWc
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1842629eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606613; x=1795211413; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yx/V2gPrdDaexlpKpFWuCGkCF4A7cUFJ2vXkWtFB820=;
        b=g2pLdmWcmbryDqxCG90MG9+9+HBDgereGU3IVi0P+LDmILiML4PPxoWe231G7ubmm1
         sMejR/HvYvhfGrpmIKNnIkyIM3V6ynlU1iSbU/FeHz7ru+o6TChkNSIKpKHA1S6yVTH9
         /aEx/mNQsuzv5uBxOZw7EdfBMVgUIddvinkAohVTRWif7lxYYGEOpB4iMzE7+gz2959P
         p2SxS+g/HBBayiEsCstdjNXSD5rgM7TEJjwCaoWaJbYkCt2CUyGmz+p6bqqlxkDujnCZ
         LlEJkLpr82TvGEGdsuOSV8BFdRQH6js3ZLWR+3FCXoPMFKg69muvqm38VpYyMiDpeBws
         3DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606613; x=1795211413;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx/V2gPrdDaexlpKpFWuCGkCF4A7cUFJ2vXkWtFB820=;
        b=tubXXo9zSxEN5P/JjesZiDqU9sCCv7oH8njS8JofIYbhWgsZKsPfi+oIEPdHBFWSrG
         AZktXauGYih3UCkTU4+7Ylm90MIGi++RoTWSjw4uAzAOL56gUfCUHqx42F91T5x8P4FR
         SxKd6C/XxW5lkpauo6mblUeIg3NG9VCF8TfXDRyoymJnRJzD+rw0fVMoMfINKpx31XON
         d1qYA5hAHGVs1U9+lfwyrCpaMxP1UVLLHXcuG2TJJ1DDPdnWN5Dr1pZNyTbox/dmcNKf
         z6LKblSQTMZLs2WzGF3vragMDvHJQiWQE1wZDRyoi69TlVYDDH+KpeUTRTz1EVSVGYt7
         zFmg==
X-Forwarded-Encrypted: i=1; AL+hErFqzDgCEE76LxjzD7/30h3gtiAIpqEvZtO6IEm2dQBcU7Q0bISCaDEQJ5EG0m40ATdX2xFQb0MpD6lQ+zF+HeXq@vger.kernel.org
X-Gm-Message-State: APuU4Z//p3ykbxERBfgkzRRiq5Zl3ATdJOovIyTiZZ8mm9AVB8QbAuC4
	tdbHx+g02D+DiNXJd8D2PxikRKegfxe7AjY9dCLwzPmnS+1nrL5V9R3uVZM29uYzLN6HcFPc01e
	OkMXlty4SuA==
X-Received: from dyad22.prod.google.com ([2002:a05:693c:8356:b0:376:b21d:4a0d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fc09:b0:36e:b3e6:ebe7
 with SMTP id 5a478bee46e88-37966a58499mr2990761eec.26.1794606612605; Fri, 13
 Nov 2026 13:50:12 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:47 -0800
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
Message-ID: <20261113214850.3329699-24-irogers@google.com>
Subject: [PATCH v1 23/26] perf inject: Use generic hashmap for aslr remap_addresses
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert aslr_tool::remap_addresses in util/aslr.c to
DECLARE_HASHMAP(remap_addresses_map, struct remap_addresses_key *, u64 *).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/aslr.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
index e365f807b021..068e0250b151 100644
--- a/tools/perf/util/aslr.c
+++ b/tools/perf/util/aslr.c
@@ -6,6 +6,7 @@
 #include "event.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "hashmap.h"
 #include "machine.h"
 #include "map.h"
 #include "thread.h"
@@ -69,6 +70,9 @@ static bool evsel_equal(long key1, long key2, void *ctx __maybe_unused)
 struct process_top_address {
 	u64 remapped_max;
 };
+
+DECLARE_HASHMAP(remap_addresses_map, struct remap_addresses_key *, u64 *);
+
 struct aslr_tool {
 	/** @tool: The tool implemented here and a pointer to a delegate to process the data. */
 	struct delegate_tool tool;
@@ -77,7 +81,7 @@ struct aslr_tool {
 	/** @event_copy: Buffer used to create an event to pass to the delegate. */
 	char event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 	/** @remap_addresses: mapping from remap_addresses_key to remapped address. */
-	struct hashmap remap_addresses;
+	struct remap_addresses_map remap_addresses;
 	/** @top_addresses: mapping from process to max remapped address. */
 	struct hashmap top_addresses;
 	/**
@@ -1331,6 +1335,8 @@ void aslr_tool__delete(struct perf_tool *tool)
 {
 	struct delegate_tool *del_tool;
 	struct aslr_tool *aslr;
+	struct remap_addresses_key *rkey;
+	u64 *rval;
 	struct hashmap_entry *cur;
 	size_t bkt;
 	struct rb_node *nd;
@@ -1341,13 +1347,11 @@ void aslr_tool__delete(struct perf_tool *tool)
 	del_tool = container_of(tool, struct delegate_tool, tool);
 	aslr = container_of(del_tool, struct aslr_tool, tool);
 
-	hashmap__for_each_entry(&aslr->remap_addresses, cur, bkt) {
-		struct remap_addresses_key *key = (struct remap_addresses_key *)cur->pkey;
-
-		if (key)
-			dso__put(key->dso);
-		zfree(&cur->pkey);
-		zfree(&cur->pvalue);
+	hashmap__for_each(&aslr->remap_addresses, rkey, rval) {
+		if (rkey)
+			dso__put(rkey->dso);
+		free(rkey);
+		free(rval);
 	}
 	hashmap__for_each_entry(&aslr->top_addresses, cur, bkt) {
 		zfree(&cur->pkey);
-- 
2.56.1.703.gf848ed807c-goog

