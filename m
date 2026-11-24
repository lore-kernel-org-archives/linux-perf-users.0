Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490974;
	b=M9Mcx52869TcSVWCFS2dH1wuPNEEM/GM9CfzS7lbblBrwYpOlVq/t1gQMHoSt9cZab0G
	 bmt9b9T4HZQmCfyE4aSRNh15cCTFCIF7erAn3zrfceG4X3DlQovsPP62+wZ25KJjVEJjh
	 Z8JLmPZQu4wTgl5FxaftuOb0oPepnIip4RXqmJL8TZ8rttwlWdF9iWMChNdYa6k3czdwO
	 CU2kaRUrmT/uyLiTht/ODMnxiKu0sBd5G8EgZ9rvq5ef4DlwFPNLdpW3/T5REuX8FX4K+
	 eCkwAJW8fgWQ26y5JzgfP2+kGj0TPmqvGS1jsBCpT5iosMn8z8++HG9+2XCfnykFZGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=doKNLQilCAbEqzOL1HX9YWvLFzi2eOQQRDdb7QtzQNw=;
	b=UAAjy3xqzN9yRp2K+fYqBSZybEXopY07hZVbV1guXPuSmSXSwf1AeWks5xkkS1FK8nmE
	 hq7b624KK5FwzZ3B3QfOdVN9Ap5iY7UlEP+ZMaM+m+0nJiv5v1Vc1eEWG+wbcBNskHHiy
	 k617v4td76Cnhf3xIyFpFD28P4cOeCs6m3qZv2NBQu9OUafIO6Jy7HUFMVpf/CDW8sHpD
	 kTU1lsCkcyGS+PkQ/gKxwAijzxMYYW0xUJcSs51F3pcex91dL2MksqYn9yBvHmHMvv/DU
	 37yHF7+mqQyAckaQ2pOes78WIlqYaZWTx99p+poKfrDAI2eh3e49c6WRc0Y6kNGyvCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Gbgf/pX0";
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF9606A331
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CAF9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Gbgf/pX0
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-492f39f29c4so4526133fac.1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 19:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795490972; x=1796095772; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doKNLQilCAbEqzOL1HX9YWvLFzi2eOQQRDdb7QtzQNw=;
        b=Gbgf/pX0g609S1xiNsnrLIZHaxxoFXShpH/vCqySzoWK3U3rcbuuLGwF1GNid0MFyD
         eMYHumRH1oNINYvZIJneaJKImOwLwS6TBoxaWsjKlFMMA90ImMQkyJ/S/7Hed3pNfJCb
         j5f+8CcL0AEbrfa+r8PKNelQQAdksJidCkiZ6XH5HkoIranwXhK71Dcdo20zRD8ybpB+
         xUATgqYI2uSJovk7r8QqTncjl0zyXOAefHep0nIG/nxo6FaGsP5IMpazLekqaXtdXslO
         xcubkBRzpmBe7qSHCD5Vd4qKIUdEwXU7ZPUo0MjRBNECqMQ4xEq31LzgKXGhLMizjnJ9
         Zg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490972; x=1796095772;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=doKNLQilCAbEqzOL1HX9YWvLFzi2eOQQRDdb7QtzQNw=;
        b=KD0ukvlWkm4bM7AM5IOalc+VeDpN0twFsC71bwHZhPv3mpzh6Y0pPeM3xKl+mKh5LH
         qBtJdb3PWLayfLPi3X5mp3zAslDph1nYILOBPnn0dI2YQUH6k5LWcG0EKzyK8gPGvLoX
         mx1k25ei7qJpXTncKHf+hzc2X7oSwozAuLmyOg83a1T9MFAjNBES93l3KeFBbw/gxujB
         YRkGIYYmPfeQX/XtzKrjAoylhnoQPCJGDKs1cCOAXf0/NNFepGTbDBwuNxrIPnPfB++R
         lfDl+m1k2x1aHzGLCoZkrihM33zxOAKDpkFz8jeB4ZLVFcIl7glYunkNSc4xR1qnj43Y
         0SKQ==
X-Forwarded-Encrypted: i=1; AL+hErF2M4MCWc4rM/Im8vS+v3khktzI6imvkZb2KD7uSZ1bPIi/Zhazg4YorItY6tiv6bYXcyyvM3cj7UbuSuTDZ7mU@vger.kernel.org
X-Gm-Message-State: APuU4Z+MxhU4Jaq49qR6/5A8IvYF2KaaktHf8ZeCzHwUsKNDH8qdEQbC
	w+nEnz/jgTfNRkmvMXAqrr0Ssv8S+bigdfu5n3ZygXQRlHvkyeDxZudw0DIXeouCk0++qCjGBXS
	ATqCZtSaTxg==
X-Received: from oaos11-n2.prod.google.com ([2002:a05:6871:854b:20b0:4a4:2256:e2bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:e0c9:b0:4a7:1d66:1463
 with SMTP id 586e51a60fabf-4bc83d532bbmr13034002fac.35.1795490972331; Mon, 23
 Nov 2026 19:29:32 -0800 (PST)
Date: Mon, 23 Nov 2026 19:28:57 -0800
In-Reply-To: <20261124032902.3859564-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124032902.3859564-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124032902.3859564-7-irogers@google.com>
Subject: [PATCH v9 06/11] perf symbol: Add symbols__shrink() and symbols__try_delete_unannotated()
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add symbol-container memory shrinking helpers to struct symbols:
- symbols__shrink(): Reclaims the secondary name-sorted index
  (symbols_by_name, rebuilt on demand by dso__sort_by_name()) and trims
  unused over-allocated tail capacity in symbols->symbols while keeping
  all live struct symbol entries intact.
- symbols__try_delete_unannotated(): Deletes all symbols under
  symbols->lock when none have entries in the annotations hashmap, running
  an optional pre_delete callback before freeing the symbols.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 61 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/symbol.h |  3 ++
 2 files changed, 64 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f1abe3333ac0..1bcc36e011fc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -253,6 +253,67 @@ void symbols__exit(struct symbols *symbols)
 	exit_rwsem(&symbols->lock);
 }
 
+bool symbols__try_delete_unannotated(struct symbols *symbols,
+				     void (*pre_delete)(void *ctx), void *ctx)
+{
+	down_write(&symbols->lock);
+	for (unsigned int i = 0; i < symbols->cnt; i++) {
+		if (symbol__annotated(symbols->symbols[i])) {
+			up_write(&symbols->lock);
+			return false;
+		}
+	}
+
+	if (pre_delete)
+		pre_delete(ctx);
+
+	symbols__delete_locked(symbols);
+	up_write(&symbols->lock);
+	return true;
+}
+
+/*
+ * Reclaim auxiliary memory from @symbols without freeing live symbol
+ * entries (whose lifetimes are owned by the containing struct dso):
+ * - Free the secondary name-sorted index (@symbols_by_name), which is
+ *   rebuilt on demand by dso__sort_by_name().
+ * - Trim unused over-allocated tail capacity in @symbols->symbols.
+ *
+ * Returns the number of buffers reclaimed/shrunk.
+ */
+size_t symbols__shrink(struct symbols *symbols)
+{
+	size_t freed = 0;
+
+	down_write(&symbols->lock);
+
+	if (symbols->symbols_by_name) {
+		zfree(&symbols->symbols_by_name);
+		freed++;
+	}
+
+	if (symbols->cnt == 0) {
+		if (symbols->allocated > 0) {
+			zfree(&symbols->symbols);
+			symbols->sorted_cnt = 0;
+			symbols->sorted_tail_cnt = 0;
+			symbols->allocated = 0;
+			freed++;
+		}
+	} else if (symbols->cnt < symbols->allocated) {
+		struct symbol **shrunk = realloc(symbols->symbols,
+						 symbols->cnt * sizeof(struct symbol *));
+		if (shrunk) {
+			symbols->symbols = shrunk;
+			symbols->allocated = symbols->cnt;
+			freed++;
+		}
+	}
+
+	up_write(&symbols->lock);
+	return freed;
+}
+
 /*
  * Order symbols by start address only, preserving insertion order among
  * symbols sharing the same start address (matching the previous rbtree
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 1aa54c1f1680..dd9be561618d 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -153,6 +153,9 @@ void symbol__delete(struct symbol *sym);
 void symbols__init(struct symbols *symbols);
 void symbols__exit(struct symbols *symbols);
 void symbols__delete(struct symbols *symbols);
+bool symbols__try_delete_unannotated(struct symbols *symbols,
+				     void (*pre_delete)(void *ctx), void *ctx);
+size_t symbols__shrink(struct symbols *symbols);
 void symbols__sort_read_lock(struct symbols *symbols) __acquires_shared(&symbols->lock);
 
 static inline u8 symbol__type(const struct symbol *sym)
-- 
2.56.1.809.ga0b61035b5-goog

