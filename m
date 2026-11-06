Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948642;
	b=ZoTGJ0X1Ujp9STEt/TlAAnVJq3PKw9gzFK7vFiRDEFMsqjS7yhoNDPxji0qe29kAud6g
	 uXw/EyalXlS/Qc/PoWQzs4BWlqQSXG4mA8KWvst9+3xEcrpmpZlruGkErpEjy/YvClafc
	 8PFdDxke6r+8LzH7h95yxfUNACl8iVHiWYxMEOaULe2E0JYL9+5ob+dqf0bsWAtR85037
	 JKxOs7uvOxMrVg1/u38rXg/WZWLJ3cTy4OzurzsuB8/VZrg1nI2AvGxBtnXaKlvV64J9V
	 U7oF/QrjefSEeLwjRV8c/4zjgmmNjeKEjH7xlWr1uaouKWGeMQlZ3VsbnlHYSgPLBNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=W68ZHdTr4uS4t3HLAWkunw91OyKFrULjE3FrBfJFUMM=;
	b=lE1NPAO4Sb8wW0BjxJUDUIdCO55ekFmOATQkQCdLjGGaUBegoBKIvFylpW2GMOXVONPw
	 zrXhRYf+TOtkU+6e+F5BRYQVedtEKHvEE0V1Btl0BMRP8QmIFnQkRYBmwaMZOcARYo22k
	 5WhvCvvw0+51ygsfKiF7cfH1NAJPkgftasqIfYk7g3VKAy2TivQMAdY88HH2HFrJbV1wC
	 KonsNcZgk1KQCGi2a58R25LBnZus3lRAI0CCvtQjt55fC+K7Wu6MbJ7Ji2zSzXvBJRnPK
	 7OX97u2SzB45oJmWIAo8Vw4gxASmEVCLWJUFw/NEPaH7qrzrOkKeu6Derm4TWSlVC/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=itqTynsJ;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6EB606D82D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E6EB606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=itqTynsJ
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso732864eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 23:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793948642; x=1794553442; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W68ZHdTr4uS4t3HLAWkunw91OyKFrULjE3FrBfJFUMM=;
        b=itqTynsJMf/7ovamYmxG/ORkNw94Xlsou3Z/Qoo+w1H3f1gNG2p2xlWeWTbprkvnaY
         c8Dit+gqVQwbpy978adjbgfmfgp0E8eYmt/Pvbw0CdPJ5hjbCVZ4nc8fHoGGD/Oj61u/
         HHnF9Mod8tAsXDBMNx6/t6Dho8KLzz1EqMvaVA3lMtV3S38JxqtotXpPjOP33DhkvZJj
         00ZtfGKARNgL7GCcbxKKl0ytbZ4Kb3iREEQ524898o2YQQLnOlad6mkcR92NaOty+e1K
         ihaCpFrlxNVyo7/q/b3vNydx1PSdXxeBAscfu9355OXi7uc8cJRqzefPfN2AtBNYTVL7
         KPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948642; x=1794553442;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W68ZHdTr4uS4t3HLAWkunw91OyKFrULjE3FrBfJFUMM=;
        b=AfUnOoa3yQG5yvcpn5Gr+tHzLpOI/NnVJJW4ypmfnwxZLixLa2xP2O1grGXceeo1z4
         VG2KGHjde+MmgItlo/QJ8dNpVA9NU36gdTM+6x+t2GWznL0Gx43fFUV645RcXYm9QIqg
         GOLelde3fdBBW5Qq0WqCrgp5b2Y8I/Ztpvtz2y2VmkEENZEaKse3wGvwPkJUr6VKdRpB
         r3kNy8DQSTsu32yWwnZdH3rTeVRS9LYTJvjOmYX5x4v2HKx5qwxeEe07MGgGcBGsayhM
         Y3vf7E5CjN5EGz+2ywED4NqBK5z+3JrJgL7+Zg+TY+VW+uPsROsCRLi6ccplgZH7l/Gq
         IlEw==
X-Forwarded-Encrypted: i=1; AKwUvBzitXghDDwCpfYQQj1qfzmDWYDq/U1WQXZxmkHycc9wRNhjjhddTEFHwpE1kVm2JBlrrOzNep8rwBgEFFtWbie2@vger.kernel.org
X-Gm-Message-State: APuU4Z/zvZ39ybYNqPRneNGBfXMUMi59EgFCo/6OLAAXaVmrx42W9BgX
	EXRnwkPXJDCvK/AaWdB7GMRU9kGYjm6E7Qe3aaNa/p1A1I/DC9dTzYzRugftwVmTJV/ReB2zQy4
	bdU/yy4kVPA==
X-Received: from dlec17-n2.prod.google.com ([2002:a05:701b:4291:20b0:1ad:6e8:8d5b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3c12:b0:1a8:9857:2102
 with SMTP id a92af1059eb24-1b25d3445demr1741316c88.30.1793948641255; Thu, 05
 Nov 2026 23:04:01 -0800 (PST)
Date: Thu,  5 Nov 2026 23:03:29 -0800
In-Reply-To: <20261106070344.329897-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106070344.329897-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106070344.329897-6-irogers@google.com>
Subject: [PATCH v10 05/20] perf build: Enable additional Clang thread-safety flags
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Align tools/perf's Clang thread-safety flags with the kernel's
scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
-Wthread-safety-beta, and (when supported by the compiler)
-fexperimental-late-parse-attributes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 3eb8d095cda0..b50702bac53c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -64,7 +64,13 @@ ifeq ($(CC_NO_CLANG), 0)
   endif
 
   # Enabled Wthread-safety analysis for clang builds.
-  CFLAGS += -Wthread-safety -DWARN_CONTEXT_ANALYSIS
+  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety
+  ifeq ($(shell $(CC) -Werror -Wthread-safety-pointer -Wthread-safety-beta -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -Wthread-safety-pointer -Wthread-safety-beta
+  endif
+  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -fexperimental-late-parse-attributes
+  endif
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch
-- 
2.56.0.455.g6c5a503b38-goog

