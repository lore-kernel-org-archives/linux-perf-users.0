Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FE3AAF4D
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259731; cv=none; b=QvN5n6rmK1sF/47SMrGRNh9qQiswn7KzrKcUVDLraEaKDt5LFQRN1cku9tpGThim3BPFD0Zo+CTFy8f/yVsmaqDEZAEhWkCknVjWs6xM+V/hrIfIuaWBfpCi41gm8fmaLPRkWMeUfcGAq6HUiz++oxuaniBTRNLZk6VYALmM3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259731; c=relaxed/simple;
	bh=DtSsifjwWVyJ1/n4M/V9Rng/YX6VJnOi365fPzujeYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bC4zVNOHylwtgN3WW0qZzv9VH1Iay3P2bLSx6RRwXjfxVGraaa03qR8MGmFSaimFImYPFUknWLnFEtxMShWgi86dfVjadidN9fbZ2yyHY7NNe3lFfMzPMJRN8qsrD6gh5ogIrMEn4ZMarB13ePr6td9GMhnzWQbo193KtuHEleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyW1mD1s; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyW1mD1s"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso814522a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259729; x=1786864529; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmNU6KqTmzL/zIuJqf0Vz5N9nW2alEymL/EvtGqx9YY=;
        b=lyW1mD1suaxp+ghVWhL4nW0hAW+kX3Av5WKEhxbQILKgNXEjdpKJkggoTlgWy0Eilf
         oJMbV5lGJHNYJaYdY/bqimqFmKUdIgqCbvpdyxer3IzyNYZ2SonsA9Fitw3tbR+1b5aI
         aXW/5d+aA2mA+IeScxWZhD270ZEsmDkclGgBXEWNsgXK8o3B6ASsG0s70IpL3jc7VySB
         J81o0kc5BXDZ0tk8p9AdOT9i1itv7+Gb48Z3I9PWN3BhxoKd3WtDocezkRW39sxdJwlz
         ZehaOrZrMMdlHgFlIac1vy/hC3zKBJqBXVe96Wbt5GwUt7taKZEq6oK3R4geVvzLwYBU
         OrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259729; x=1786864529;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OmNU6KqTmzL/zIuJqf0Vz5N9nW2alEymL/EvtGqx9YY=;
        b=sKYIUV2WHpry95C8F8BERYbL8tM4Bjm72cXtR8PcTDxrm7BU9Kjy8G/9qmH5JnFkIA
         evCqxC3efEXy8NbmRArpsXTbcrkTjl2pHPCuUx/hMLeBxwjumPVBXDDYV9NRoCmoowjo
         lImAXKrcrBRu8qO8hrF4tuys5OZ4WBaINwb3i6jhmoew9IIDuWmuuBsNKF4E4PhElgyU
         tyUdsu811HGZ/C58c3ZsHmfmc6ATQF3dt9EM+TiP1L9jLMga8FqQZstSc68xWVZEobNv
         TFNHFjEp0mVS5GBO4awoXACuaiSvWBgrzKFLEiof21dvPQet6yXfX7+Ppy3J34LztRn9
         K1fQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwgCkG4pKRleUoTczYR8Z1/favkTOUQK2uSdQLPRvrXNustPi+AzQbSEmkL8+Jm96tuyoyMSkCx2qOfoJLofOM@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxKz/fiTu+oO1WmMtDkXi6nsvVRJ+MJ8CfQddAIqdIPjiN4/K
	m+lQLUXgfLVVWy6sF686Y59I25efVKZZEvr6GG/ql/S73B2I5XCC0eLQvzh0PmqShBVRs1ETTyV
	IrsRTHHdPMQ==
X-Received: from dloo4.prod.google.com ([2002:a05:7023:a44:b0:13d:1fe2:b775])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c89:b0:38c:a59b:5189
 with SMTP id 98e67ed59e1d1-3903c5aefe9mr33482071a91.15.1786259729335; Sun, 09
 Aug 2026 00:15:29 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:53 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-15-irogers@google.com>
Subject: [PATCH v3 14/15] perf python: Fix memory leak in pyrf__metrics_cb
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In pyrf__metrics_cb, PyDict_SetItem does not steal the reference of the
key and value, so they need to be decref'ed after successful insertion
to avoid memory leaks.

Fixes: 47b3e95728eb ("perf python: Add metrics function")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 71431c9c2e76..077e0f5d9fcd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3574,6 +3574,8 @@ static int pyrf__metrics_cb(const struct pmu_metric *pm,
 		Py_XDECREF(dict);
 		return -ENOMEM;
 	}
+	Py_DECREF(key);
+	Py_DECREF(value);
 
 	if (!add_to_dict(dict, "MetricName", pm->metric_name) ||
 	    !add_to_dict(dict, "PMU", pm->pmu) ||
-- 
2.55.0.679.g6767b8d81c-goog

