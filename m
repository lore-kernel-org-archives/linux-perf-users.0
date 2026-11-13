Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606585;
	b=iH/bbaFx9VObQzFrqOf188xe3panqYnEeVUooxNMhwudC47h9GjdRyTLdK5xhMmHATrF
	 kA3QEvP/xqlKXlsQfFQvzzFxY3QAUfIThBe9/myuyB/d//ECd2OQDp8CRozHyY+XP2P60
	 uLcFvcxXdrAv62vSJlY2iKgJWDZo5pUKwZpF6to2knCBqHnfXVMpghvRnYYcZSEcsPMx9
	 D2g3tXMmwWTDVnND1gpX1LNECJgE+m/YlqZqAu4X6LRl7yrhl57OlPJ16Bud8ngkU0JsB
	 8KX8Na1KLuAlYVp3qU6sfra59YPI9lb7UBWsMAz4n7dyAxXaipoKj0waBey4iqColgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=X/OOpg/RGkyhTP7uOfnk3EfDfXfXJgmBMTxuwOM2NpE=;
	b=pButqTQRDX7bYpgoJ2LHK6F/uZ/lygeNYBley0H7nxkFhnTsgzF7AblCkKafyhNa4g0v
	 DwO5yvlkX4gkYT3r8To3CLNAR/V8W5z2tA3QnmUFaKFX0gJnMC9v3riTOQpRopplSYvPd
	 SO+fWVCrIQmlLO2aaEr5X0/1zAdDlru8+92/QHL1TwVAm1f3LCHHsKi0nqvpTouPpvDz+
	 GxiIUhVxg6bOS1DZG63xMZ1tnLnKlKGPSTaj1rarHkNgRaEQRkcVcJ505DN8QG/bJCpwE
	 zEY1g83kbBhNkoCS+vNliVi/Ia636Fyt4uF2pTbS+7xgTkr/wwZ7k0SVyEPYevO8ejQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="hF+x7Kr/";
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054360A5BE6
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8054360A5BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hF+x7Kr/
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a3451ea93so1458404eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606584; x=1795211384; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/OOpg/RGkyhTP7uOfnk3EfDfXfXJgmBMTxuwOM2NpE=;
        b=hF+x7Kr/R2M7OyC0n00fyQvcFGip2bBhoJ1Z1DqJ7AH32QVt1ruiiHraKvaaCnI6+z
         0qBiu1SCS7PNmhUIg5SKBSez1rJTloizFw1q1vbDCvXlXXH+vbFw0InV2UA5ll6By7UQ
         Y35Xf0474VV7YgVohrhlA1R9d4hr8rarwyI/T5B3g7ctziVnRrI2py7xLDRNRPo+Z7C/
         R4QsrsUu8HDXdoKLolfH/QdvYjCxzupbSPAAorIUWxJBZgDzoU6SoLK2F+YHkbYzcweL
         vbgkWKT9599Kg6jbNBJa/itEGNR5cRU1VcP7lwiVHMS41TCxQM1/cZevbaYPE9iYgmQ1
         gMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606584; x=1795211384;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X/OOpg/RGkyhTP7uOfnk3EfDfXfXJgmBMTxuwOM2NpE=;
        b=tld7ZLSD4Maolo+d2pO50ENvbHnWeSaJl/G6NDWtm44OH0KZyOSrs33UwnnAxO/KAf
         C3H4YEwV5AdoFv+BSRChh2oApadDDUAvlA413imcPc+n9RSwbdVQxLOFjz9yA6bCf0s1
         cyhB+OGD+LyW+xPDB8E2mRTTCrqbeR2By8w0t3v7bj2OJ9ncp3aKil+yML2rO5E7CL54
         ov2u9qC+HH5OV4XutoP5SHCYj1CXFbg85w6o00PiBJ0yN9cQgyx4lw/cu6xZhZeO+9kG
         35nP+OeMlT6d/6P19x29972u1nQBp1wOyRMCOljQvyodBx0/kN3jLExQH6JGUiivs1oq
         1QmQ==
X-Forwarded-Encrypted: i=1; AL+hErGikGpYuXlWOWHko9nuc/z0pbURmR0WsCcXJPOVIFXUIV02FB3DZ4PrS98jM0SFx0W8hNxNmJkApLjVxAnP+XWu@vger.kernel.org
X-Gm-Message-State: APuU4Z9Yg7vGDNv7fAIIfKgMiWB0KGAH1/h/O/RKbugOMoPYPt2Aw/BJ
	2tP16FU3hEFy/JT+dLsZ9kIWbMKN6eXP/B+EAWl65r1ve5J3b4+xWACESNbflwmH4tqpPBJtK2W
	aUq1ECbeU+A==
X-Received: from dyab25.prod.google.com ([2002:a05:693c:8319:b0:372:7af9:c0a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:864b:10b0:35e:f4ac:5f8e
 with SMTP id 5a478bee46e88-37960384530mr3381604eec.0.1794606583452; Fri, 13
 Nov 2026 13:49:43 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:36 -0800
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
Message-ID: <20261113214850.3329699-13-irogers@google.com>
Subject: [PATCH v1 12/26] perf trace: Use generic hashmap for bpf-trace-summary
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert the syscall summary hashmaps in util/bpf-trace-summary.c to
DECLARE_HASHMAP(syscall_data_map, long, struct syscall_data *) and use
hashmap__for_each() instead of struct hashmap_entry iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-trace-summary.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
index 9a31dbf06cbb..2cc42f19d223 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -113,6 +113,8 @@ struct syscall_data {
 	struct syscall_node *nodes;
 };
 
+DECLARE_HASHMAP(syscall_data_map, long, struct syscall_data *);
+
 static int datacmp(const void *a, const void *b)
 {
 	const struct syscall_data * const *sa = a;
@@ -169,7 +171,7 @@ static int print_common_stats(struct syscall_data *data, int max_summary, FILE *
 	return printed;
 }
 
-static int update_thread_stats(struct hashmap *hash, struct syscall_key *map_key,
+static int update_thread_stats(struct syscall_data_map *hash, struct syscall_key *map_key,
 			       struct syscall_stats *map_data)
 {
 	struct syscall_data *data;
@@ -233,7 +235,7 @@ static int print_thread_stats(struct syscall_data **data, int nr_data, int max_s
 	return printed;
 }
 
-static int update_total_stats(struct hashmap *hash, struct syscall_key *map_key,
+static int update_total_stats(struct syscall_data_map *hash, struct syscall_key *map_key,
 			      struct syscall_stats *map_data)
 {
 	struct syscall_data *data;
@@ -305,7 +307,7 @@ static int print_total_stats(struct syscall_data **data, int nr_data, int max_su
 	return printed;
 }
 
-static int update_cgroup_stats(struct hashmap *hash, struct syscall_key *map_key,
+static int update_cgroup_stats(struct syscall_data_map *hash, struct syscall_key *map_key,
 			       struct syscall_stats *map_data)
 {
 	struct syscall_data *data;
@@ -379,12 +381,12 @@ int trace_print_bpf_summary(FILE *fp, int max_summary)
 	struct bpf_map *map = skel->maps.syscall_stats_map;
 	struct syscall_key *prev_key, key;
 	struct syscall_data **data = NULL;
-	struct hashmap schash;
-	struct hashmap_entry *entry;
+	struct syscall_data_map schash;
+	long entry_key;
+	struct syscall_data *entry_val;
 	int nr_data = 0;
 	int printed = 0;
 	int i;
-	size_t bkt;
 
 	hashmap__init(&schash, sc_node_hash, sc_node_equal, /*ctx=*/NULL);
 
@@ -420,8 +422,8 @@ int trace_print_bpf_summary(FILE *fp, int max_summary)
 		goto out;
 
 	i = 0;
-	hashmap__for_each_entry(&schash, entry, bkt)
-		data[i++] = entry->pvalue;
+	hashmap__for_each(&schash, entry_key, entry_val)
+		data[i++] = entry_val;
 
 	qsort(data, nr_data, sizeof(*data), datacmp);
 
-- 
2.56.1.703.gf848ed807c-goog

