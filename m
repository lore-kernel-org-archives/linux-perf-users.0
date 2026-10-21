Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602660;
	b=3ZvmaA79lAbI4AA+0kZ8LBthB5NP/9v7FWvCoaSC7nnedjPLI7F75ON5xDQ5Uc5L5cw7
	 61jYCFCroA4qb0tU2KJMahVwTIuwAwMIHXgifYG08Y1kRm0G+UGiPY7S5piqMvNxCO78R
	 +7PYJa+RWbIlFp3sOMfFttKMDRsOvVb0muL6o1FywwBqjEK98cfWxLqMtwNHrHv2tuCy1
	 ZJwiK9U1NJUDDMIRhMCs+yjOtZrGLIqlpdlIxlg61+2KU8MgDTOPGN51GVwAZVEojXdI6
	 UPnV+HSuwvkpiG87S2FisOeTnMC5P7eL1IE3KAQXlch0QZNUZ4DQnEgqfR4uGVEjmcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EfwNfupZ0TIPuuv+IGtyp0tzfxdoSxsiIGDg+mfEKAU=;
	b=yf7GiBeIDyUi2D4f9LAujm5u2mT9Vmzl7WEvKA2TlqPqsjGe8BTLabhe9JbSFoYFelWT
	 3pfsRjVKWjHQFRES1cwmUogv9kSKU/2iz5X2ft59pfQFwh3Nn4AIMjC9zUYHFs08YI7sW
	 NbTL+9eheGLgzo7klAVZhvEc3u37Llaek2iumFW6K08rSVChEZhvEQnuJKbPtFuRO6rs1
	 BUrertzEYVkiHyCb223x20ywmRzwoeBtYS9sHhQ5hrUQ9UNS/ge5mTD3Hy8qA2vXJcy1x
	 lbifTRw2UVhlRJncFuPnpFxlAAX+86qHov8pbFHp/ojX763A3aPgB4HgknWTHdRQUdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cenRYtIz;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2E606A322
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C2E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cenRYtIz
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cca35cf9f77so488788a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792602659; x=1793207459; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EfwNfupZ0TIPuuv+IGtyp0tzfxdoSxsiIGDg+mfEKAU=;
        b=cenRYtIzL5g/KFvXHlF4y9NTGcDmVgvtXMRDcpFLLR6zvc50pahn5XGh6GZfL8FQqB
         gQqr7q+c3wJQGDGM9iichYXsqcl+bYjtky6GnPIce0H4zPxJ1woAVYSlPCAsPCBHxcxl
         xpIvAtThd7y1X9RI87Z6j9U+g1+zT62dN+U9tiKgLvB+wiJr5uFY2iG4yLpPBrKtassE
         xgiNUw3XKDa8iAornXTBZyFM1ovx03XSF9BBWCMAiiR2i1UXKEY/E4RF1rolg1HrP7hT
         v3lhaqIZx6bKoYmCS0nSGp/a1+ptPRgpA185mG6rGpt04XSOyq9+lBgdu8AaQEFxn9DN
         yUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602659; x=1793207459;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfwNfupZ0TIPuuv+IGtyp0tzfxdoSxsiIGDg+mfEKAU=;
        b=trPxDSc0FtV17kHPsXkNTdKK2PMTxw7RHC/OyoFpUpX4p+ims3/GAVq/0xbsTt2nCW
         e10HUgH5/NrKWjpdmdy+e46x0wJKXTmK7BYF4cCH8aoaJArcy6tCGSH2HdzdvszrHzJp
         8aSX9x+8K9/ooI+aUbsj92RSbcf9Z5cKooMcbBaJr7mXguvCMR/Zl1PxWnohKqZ7VUF2
         NBuKghhImKeXo0ABoCmg4/X4mKNyFbPizYnL4PYSRII6q1tFkgy/jIV5hC+m/VUuGhYR
         Qyk2Dzi26PLbOuFTv9yqN11DC8Cp7R9S5cr0HmOK2kIg+io7lWe2ZRfFTHUPVVNp2hES
         h1Jg==
X-Forwarded-Encrypted: i=1; AKwUvBy8i8qcyrEIZxo+TvFzN2aMmDMnO8FBlBhf1uGnO0IHqRsEc6kotA38UnrlCiPxZ9hqCNSh62VTsrJir9N5J6vU@vger.kernel.org
X-Gm-Message-State: AFq9FYLkPYkR1YUbw5HtejbDY2MbtYtaBpBdWtGIAky/tN90D9Zbw5dC
	kScvTwQsvwuDiaZ3C8S9AHstTBSQhxxZt9jsWWuMpEEhwbvx+X79ZhsgtyFVARTNuL77D/CalNK
	sQ4SHY+CC6Q==
X-Received: from pjboj12.prod.google.com ([2002:a17:90b:4d8c:b0:3a8:645b:da8e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b90:b0:3ac:c03a:38ad
 with SMTP id 98e67ed59e1d1-3ad86c00fa4mr2544214a91.5.1792602658534; Wed, 21
 Oct 2026 10:10:58 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:10:27 -0700
In-Reply-To: <20261021171044.155240-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020163640.746159-1-irogers@google.com> <20261021171044.155240-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021171044.155240-2-irogers@google.com>
Subject: [PATCH v6 01/17] compiler-context-analysis: Avoid unused parameter
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
2.56.0.218.g1ec904b173-goog

