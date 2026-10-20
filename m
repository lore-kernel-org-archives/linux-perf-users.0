Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514212;
	b=hzYj23tCzi555djb22dOiKmYgSVADMpkgI1Z3T3tFGN91xW3zxN1iOwBad+tGGlrjWi8
	 ZcvrsTmuAqmJ0X/v443996+OX7myI9ue9Bsw5/9xiFsJxvCeN3EKXtcMn03+nzCLWPoX7
	 UHtl7Op6bGfVEyttSifsCVN08+C7uVMuBotbwmQJSqQ0An0AA1EUY4nFa6OgDWviKLJ6U
	 daFmSPUfRQhvVv6LZZvZpPcNpleX5LMpYYSSJI2AUeXGKGQGoVJmOMii3QXsRiYulFkNh
	 k4mOVwpVgGPEqqJ//m6DJbQxBalrbZs0R3G397ytpEd0FhP6nO5VN3aTVqeqYWBeLeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=viOIzDo9krKszOCmVOjeW9f2aQpRArqmnQIoNv00KM8=;
	b=cm+urbFX6FAdmBlSfT3Gc6cwQIU466O2HhTtT5FAc+oeKNz9rGsiOezj1mZrCfzZYY6v
	 6uIZ5GaL6EXlcA5LI+zfFmuCij1oiOBF/a56sBJsQfzLRgLvK1gcS8KwyQH7D7yGRXrmx
	 jIvMq9RyPObe0dGkGzkBsRx1vq6rjL9AKlR4QN2ntyZ3Iog75No5X+91t4vnBuaTzddCq
	 MUex2c1fbRXzBRe6C24A2b+3cQRbYaO4uZ0CqmTndRjznlRq2T2n4atXNtXc73QhO5pK7
	 g1BdBukn/UtPFlt0OdbNLRuP9xdWbHt0nisH5KmLxKKzQP8hZwZFY7mr6F/xFqHDs+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=X5BTfVBT;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3EE606A324
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 16:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3EE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=X5BTfVBT
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-366c279b454so931349eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 09:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514211; x=1793119011; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=viOIzDo9krKszOCmVOjeW9f2aQpRArqmnQIoNv00KM8=;
        b=X5BTfVBTpQLcvB2MGZfAGtuwm237zHiWb+DSuZNC7Qp9faasqFzpZbyzmD1ISDRU71
         wBRzMGS6sivj6EYNa87pc2loGs0WCybULkcVHIlcrBlhjKYjwAoahk+a6mahFE5RIYBT
         PRei3tgM5I4THuneGR9JKvAC/6kkEv/z0nVuw+qdRO6bTtEgYL+eRsSDpUULuVKOgfXq
         Y2XfhbfRGhJdTj3ks1/oLmQPLMJBnfivvyMrah9B3Hp0m1CioM5u8KRCMOYPGHKvpp7y
         /osRzkFo51ojMSqKzYWgUN+NlGr0ZUxAVsNY8SuiZm4Y/ZTiVe5bC+iZ601IwISH4B2n
         d4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514211; x=1793119011;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=viOIzDo9krKszOCmVOjeW9f2aQpRArqmnQIoNv00KM8=;
        b=jG4MDGa9VZpYJ2sTihgknR9WbDeB5EoseTMvYzOHDxZC8Xj1+qwCDuvU4hFJBmGoTx
         SGmCvaYkVHKOPzmJ28T19yAHXc4o0oEtf1mHtId2RmSc4sLWJBNB2YhPeBlEZx6jh6rA
         drxwrwQB+9BbkuP7yohajhuaFkwr1se+hy7uPczFy1Savda2zuU9xyEC3y2xFzCEWKrh
         JKv1ZbDESF2DNQSAvfENpnb/qdB49kNxvscEXQ5sMIRJn2Voast0zE+8K7LVw9YnnnGM
         XMDbLmAANBXLV6gH/qO34oy3gTPwGNFNwy8GkgrSAekHFpB0/OcE4g5wzS0abGc9QC4A
         TEbw==
X-Forwarded-Encrypted: i=1; AKwUvByTlYSNjAIWqyF0q1O/U+Erv9s8GaB7+L4/oEipPaY7LeSQJBpmNZkivooSUQh8QAyUcvaj7WzVeE2QMJl1InCu@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3lw0YY4oGgt7KWCyJbJD3JTtQRXDqcWA0nm0LIKzv57WZOkIz
	AqMiGYnizBaEVCB6fR8lqTpi9IhZW/4CPJ9vj0YNYG0SlsksGlOSoil/YhPCScfqVST599JFtwW
	DHzRj+8nYdQ==
X-Received: from dleg9.prod.google.com ([2002:a05:701b:4309:b0:144:c124:514e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4585:20b0:17d:7b45:f91f
 with SMTP id a92af1059eb24-18513b9801amr14365120c88.32.1792514210319; Tue, 20
 Oct 2026 09:36:50 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:36:24 -0700
In-Reply-To: <20261020163640.746159-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016221700.1282659-1-irogers@google.com> <20261020163640.746159-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163640.746159-2-irogers@google.com>
Subject: [PATCH v5 01/17] compiler-context-analysis: Avoid unused parameter
 warning in _context_unsafe_alias()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

_context_unsafe_alias() does not use its parameter 'p', which triggers
-Wunused-parameter when building code that enables -Wextra (such as
tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
Explicitly cast 'p' to void to silence the warning, matching
__assume_ctx_lock() and __assume_shared_ctx_lock().

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/compiler-context-analysis.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
index 8302ebc2ea8c..024e303188ad 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -243,7 +243,7 @@
  * alias as a function argument).
  */
 #define context_unsafe_alias(p) _context_unsafe_alias((void **)&(p))
-static inline void _context_unsafe_alias(void **p) { }
+static inline void _context_unsafe_alias(void **p) { (void)p; }
 
 /**
  * token_context_lock() - declare an abstract global context lock instance
-- 
2.56.0.212.g129ede20d9-goog

