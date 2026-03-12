Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59F2FBDFD
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773294508; cv=none; b=mKVn2LL21PfTzfbRCSYqZnt8L8IW7HznYqP/87qLhRaRBpFX6s8tzRYULzeqeV+L5vTdFv3I9z9BjIzSz/mEuB6bePGZcZYS3KP0wQe/WzFqhdHpNYOnKe6p56XCc1XXqb9i0/L76E6AA2+b3MVFaCNlPL5c1dDBO84F4Y7OdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773294508; c=relaxed/simple;
	bh=RuVytkDFOGxLZv5hZQSKqWBhPyyYvv451s5B3uiFF/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TIs1Z+H9M2f5JIxtFkueJ+YbuQk+icwnLFY4DAIVM8df29Ioau09LI36imwy5R6isRQyLsvO9foaploN/zPG6mqSCQZmkkNg18NJ0k3fxi7wwptdDaOpwQxQB9/LxEjiNPly5Ht6vI7x4VQRvyN81O7JhH60KxstPLAyX2OcdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNofy8ND; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNofy8ND"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso774406eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773294506; x=1773899306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIZKFE8GFE3BbHex+q85LNyPvOPEOZBzXZizsyJDBtk=;
        b=NNofy8ND/pp7fIj5mDTrIVI24XqJwhDve9fcEIs1NT4JYI6GYt+sfuGb1wzh+uQMj4
         d3SIr7e9lJg8kNy6byK2SrI9O+lEVRTydpqxy7d0NxsRedeEIP7D6Hak02HkAWCLIufP
         cQvt6PtLXHfMVPT+CbFM7+nuljqPNh0JE47G14ElYj/rDgBaGFPgXA2UejsWl69gMxCa
         aHmnp4CCgFHmGvUukSaFVa/Hc2LTAwsqjAAcDc5G2L6CwDyXwEGMTzIWW3+xL8eMjZD+
         2qVVD/aBr4mayi+3+BootkimllozdJ6xMCGEpGRf+2aA5bXvRhvZu4jNLf1MuyTua5cW
         c2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773294506; x=1773899306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIZKFE8GFE3BbHex+q85LNyPvOPEOZBzXZizsyJDBtk=;
        b=joPgI7vhT3euZrpxW1cY8nY5cUpspXl2vPmB1AXg4jsgtd+o04gJ6KScVOpPJFw/dg
         vWkEfHU2ohp5GTmfXT49FK8oXr0Dx1gZQL8FAgtaAbb3wl/znrpW+GFz9q0i30NulRmx
         AlLgFpc09JSke1EiNAfAg7bs7rBJXSqM9P4BCyj6hn5FCpEVXI4OXhZ2Epo9po5RLK6E
         YBKZ2P9rXOSbc7RYnxaV7CWiw8ZoNzvNLVcvyGfGHlDX9cfWPFN13rquw+hxkbokWAyB
         3Tl33A00lxr3U5nEcTHLPCFWg3cJbcG9NgCYNEQm3fhxkCPtoHXBQQ0P/KtVYw44+8/b
         E8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCU1FsMx9dyPnpo1PX0NcuArIpCiZpMa2pEbFy2G4KniYn4Qrgu72yxM0SxigfNtudCdyX3dmlSBej2kLj6p7VIo@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvBrlRndH5tL8VaUkVMSXtPEaacKWFUPGm4SL4gx1KRZfIXoa
	x/ztTtO9t3gF6RjyPenVO6EesLiCcXRqZfIULNDrLzecs07RJiU9dcrzkXALxbHUma3fwekpb0v
	S7HXGxqn4rQ==
X-Received: from dlbvg13.prod.google.com ([2002:a05:7022:7f0d:b0:128:db8e:c776])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4184:b0:119:e56c:18be
 with SMTP id a92af1059eb24-128e787d086mr2490867c88.38.1773294505947; Wed, 11
 Mar 2026 22:48:25 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:48:10 -0700
In-Reply-To: <20260312054810.1571020-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
 <20260312054810.1571020-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312054810.1571020-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf/x86: Reduce is_hybrid calls and aid ellision of
 BUG_ON in hybrid_pmu
From: Ian Rogers <irogers@google.com>
To: dapeng1.mi@intel.com, dapeng1.mi@linux.intel.com
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ak@linux.intel.com, alexander.shishkin@linux.intel.com, eranian@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	thomas.falcon@intel.com, xudong.hao@intel.com, zide.chen@intel.com
Content-Type: text/plain; charset="UTF-8"

Use the capabilities of the PMU rather than the global variable
perf_is_hybrid to determine if a hybrid pmu has been passed to the
main accessors. As the pmu capabilities check mirrors that in
is_x86_pmu, the BUG_ON(!is_x86_pmu...) in hybrid_pmu can be elided as
it is provably always false (with sufficient function inlining, common
sub-expression elimination, etc.) in its most common uses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
Only build tested.
---
 arch/x86/events/perf_event.h | 52 +++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f1123c95d174..7990d86ef233 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -802,34 +802,38 @@ static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
 extern struct static_key_false perf_is_hybrid;
 #define is_hybrid()		static_branch_unlikely(&perf_is_hybrid)
 
-#define hybrid(_pmu, _field)				\
-(*({							\
-	typeof(&x86_pmu._field) __Fp = &x86_pmu._field;	\
-							\
-	if (is_hybrid() && (_pmu))			\
-		__Fp = &hybrid_pmu(_pmu)->_field;	\
-							\
-	__Fp;						\
+
+#define hybrid(_pmu, _field)						\
+(*({									\
+	typeof(&x86_pmu._field) __Fp = &x86_pmu._field;			\
+	struct pmu *__pmu = _pmu;					\
+									\
+	if (__pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)	\
+		__Fp = &hybrid_pmu(__pmu)->_field;			\
+									\
+	__Fp;								\
 }))
 
-#define hybrid_var(_pmu, _var)				\
-(*({							\
-	typeof(&_var) __Fp = &_var;			\
-							\
-	if (is_hybrid() && (_pmu))			\
-		__Fp = &hybrid_pmu(_pmu)->_var;		\
-							\
-	__Fp;						\
+#define hybrid_var(_pmu, _var)						\
+(*({									\
+	typeof(&_var) __Fp = &_var;					\
+	struct pmu *__pmu = _pmu;					\
+									\
+	if (__pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)	\
+		__Fp = &hybrid_pmu(__pmu)->_var;			\
+									\
+	__Fp;								\
 }))
 
-#define hybrid_bit(_pmu, _field)			\
-({							\
-	bool __Fp = x86_pmu._field;			\
-							\
-	if (is_hybrid() && (_pmu))			\
-		__Fp = hybrid_pmu(_pmu)->_field;	\
-							\
-	__Fp;						\
+#define hybrid_bit(_pmu, _field)					\
+({									\
+	bool __Fp = x86_pmu._field;					\
+	struct pmu *__pmu = _pmu;					\
+									\
+	if (__pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)	\
+		__Fp = hybrid_pmu(__pmu)->_field;			\
+									\
+	__Fp;								\
 })
 
 /*
-- 
2.53.0.851.ga537e3e6e9-goog

