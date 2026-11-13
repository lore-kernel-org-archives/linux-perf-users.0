Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606588;
	b=MZDu5CchRsP5Hc2Pe53alRlTgv9SI3wcXIlBLibqpfKKmRGxwPCyMEbhrVs73dyzwRzP
	 WNnkxurhYSRyY4mxQcVsst8AUFwJ3kx54Y0/hv4JerV4tHimnlepci2w56wVoOKB6CgbR
	 cUhfZuLseIBHYGIRCOQtUQOBerxG8WG1yx9dc+4O3T6AdZ+Hhy3NIOAaEQe+Fw0EtO7Tj
	 ga6RRY5uf0aqXVNypglrXWVSuvDVRuidMc2ADiFrGMcDJWOFe+Q6Gms+ndWWDl6HELn5K
	 5vaNWDYHewviWKwIhdHOfEYBxMssOskUX3oEX0PVR/QRA64dp32cw0vbDziKEWGUW/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/5i2ltmcVjosixSLC0kU1KPhviHORkG8iQt75o4rO0U=;
	b=Y4SWCdQYxV0nvVJzWTsGG/PVtC3+icDe+G+F7PwruNPBzeghY0+VOY8ka8Jl6txn6NH3
	 v/Ol2tc5UB3My5RvgNb5avXSkRJ/8meu59oc+H7PPX4585iXm0fk+Dik8s39R1+sXkvQ0
	 2W/RMqY2l5lWgUKf1u8R3R4otesP3Fjhg/usZzZjutCtdkumZfGpzfxhLPMMwcr15P5TC
	 57YK5F886AdUI86ZYYLpFH5BkQOA+CrVW3BOMCJIrgCvamavhwNypqwdrseIOWVj6+fE/
	 QwtHboQs6BPWMcuuUaf+z1Jxb+hopTJeDbk091esvHBp3WZaZZwaurTu5howKag3BtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MBlPc1zr;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243F60A2603
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0243F60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MBlPc1zr
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1aa0fb7f157so1777330c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606586; x=1795211386; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5i2ltmcVjosixSLC0kU1KPhviHORkG8iQt75o4rO0U=;
        b=MBlPc1zrwkRjh7Y1AmIhDatbV2d2NnTborje78Iidkgq8T7qaYKbL6Nlf8/u/EllM+
         YmEEaP5f2Z76kGj7j0NhgdFIG5HpEVSdI7jFEnB9V+MjZjRnmKCNW4Qu3sUym75tYV95
         iR0gC6ifL908gbUWxyNPMxsEr9F1zonkTtbkJX6DwNMJHOKUqgoK4XwgwdvRZzS3eS+k
         YswtdthOjtn9uU9txRBTn1JJiLzjDEBWqAclnaUVBKKq6Jq5rY8yJ1XxsilkOlE7i9Pr
         7YWqsPh80YtYdesAypcakQAnwUNwpTXwxdl65I99O8eStpT+FhRDQbMtlHmwYSkKfw4f
         Hw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606586; x=1795211386;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5i2ltmcVjosixSLC0kU1KPhviHORkG8iQt75o4rO0U=;
        b=y7KWEWfQlLqwWCle10UrlRfcul7kMw5nCxeUkxvAownAWPkbQZs189+T3ASqVwUAJK
         8aMk7siTlmT9FdzwMRcIHT+DFzNH3Z2iEeho4ZOJx2NVwVITLNTz6R5jbYYOPHB2prsr
         Fc0Cl3+yTjT9xK8WC4gKxLU/WrberDc4Z5npjylQ5+sfuUc2VTWPK+MjGFZff/dFFeCc
         rrKRlwIUa2Xdv9ptEn6imy2S+lvq+Sl521Lw40/pWuDUG+4sZIUmvOfnSkD/pqEjSAVz
         ozGY1PPZ3uRBQNrMCZNfP+zaGl0kXqwvdn733JHPLLqA+S33sOgLnZsPvkj7oPchlVvp
         gj6w==
X-Forwarded-Encrypted: i=1; AL+hErFA2NxdsSqWRGHApehX6ap8UDR6S90C3gLufAeF3kvSExi8ryxMg4uLOJhJxeedDJ5YYQLO6iiKFxnDOHzx/XQT@vger.kernel.org
X-Gm-Message-State: APuU4Z+14R89YHGWLiU9qWGAtbGw5O3WAD47d5c+4Jw2TjZvxuK+DcBU
	SLh/mZUxt9Z1zkp+OtfbHjzqr1OCBW4aVFtDmsQFmiBWC/THyOCWSi4r0lIcousOlUZeIbchj4k
	LxQKzXbj4KQ==
X-Received: from dlbqq3.prod.google.com ([2002:a05:7022:ed03:b0:1a7:450c:8b47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5f0a:b0:144:c123:4036
 with SMTP id a92af1059eb24-1b5030ecdd6mr3164387c88.35.1794606585841; Fri, 13
 Nov 2026 13:49:45 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:37 -0800
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
Message-ID: <20261113214850.3329699-14-irogers@google.com>
Subject: [PATCH v1 13/26] perf lock: Use generic hashmap for slab_hash
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert slab_hash in util/bpf_lock_contention.c to
DECLARE_HASHMAP(slab_cache_map, u32, struct slab_cache_data *) and use
hashmap__for_each() during cleanup.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_lock_contention.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index c20bd075664e..2bd8e62d3265 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -20,9 +20,11 @@
 #include "bpf_skel/lock_contention.skel.h"
 #include "bpf_skel/lock_data.h"
 
+DECLARE_HASHMAP(slab_cache_map, u32, struct slab_cache_data *);
+
 static struct lock_contention_bpf *skel;
 static bool has_slab_iter;
-static struct hashmap slab_hash;
+static struct slab_cache_map slab_hash;
 
 static size_t slab_cache_hash(long key, void *ctx __maybe_unused)
 {
@@ -99,11 +101,11 @@ static void run_slab_cache_iter(void)
 
 static void exit_slab_cache_iter(void)
 {
-	struct hashmap_entry *cur;
-	unsigned bkt;
+	u32 id;
+	struct slab_cache_data *val;
 
-	hashmap__for_each_entry(&slab_hash, cur, bkt)
-		free(cur->pvalue);
+	hashmap__for_each(&slab_hash, id, val)
+		free(val);
 
 	hashmap__clear(&slab_hash);
 }
-- 
2.56.1.703.gf848ed807c-goog

