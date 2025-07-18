Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A011B4257
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752811960; cv=none; b=S5tY9RkCd7uq/Cv2sQg+s6RDWt6W/UQiQhcr0qAgL5KYJiMa2YjXULhDPSi2KYRRAzpr53kIaWhWkmdJe1UZH6aB6piU6Kf++9t1ZNCj+cguT1HXFkY9ZAzX2Nnab7Qk+MT+8wYtCiKQbNGIvMmyZYlJswdSGXkIu9eLx0z1Hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752811960; c=relaxed/simple;
	bh=JoPUyrajv8y6eG3CqFcoUp0xxvCGh8aQr6TWRHGUHDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlkFWa6rLcASDH781HN1vLmqL7QMO/t5dvtBhl2yNrB0u+4PBllQiWab45BEQqsoQgl575fKxc967F2PbLUr7hjKgweovsO+KbOWNIw3vJobxWUfe+ufSzaIEbO7lGTMX3LXBhhaeOvTLCn+/7gjOHQGO43NqO0PfgMVIm2PcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=evolware.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIntwO8x; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=evolware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIntwO8x"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-612a8e6f675so2226011a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752811955; x=1753416755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qkAbVgmr90Fx5kNcYAMvdGKY6ZHY86YsbALGCKR6LOg=;
        b=QIntwO8xBAB1sxjsFGL+Neipd3Rg9SxrW4Cf0OX9Zmf+f3bzlr+fAHpHA9e6nvfKJB
         hsIcGCud9g79vld+UtAN2jo7kfQlNaOx8/arsPAkxSQaK3ElEkg+Z41V8pgOe1MboHrQ
         QyEjVjjRW6/UpRTFbwNwIcxLOi6xAQrFL4q/10VtVHfU+0IGCs3aFIW1uWBBEOgmZGQl
         //xWPlwxaOIj2caHdokzlEgNFzpR1tYmTPoyy9+1UZCm7uFJkBfaZWcgTVA/qMyas5Kv
         467NqwMQuoNx6XocRy7eIiqA8i4+lHYpgEiinTfLAYWMA2r5OzYQzpWXJ8Q7M4KFuo6z
         FamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752811955; x=1753416755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkAbVgmr90Fx5kNcYAMvdGKY6ZHY86YsbALGCKR6LOg=;
        b=DER4H9xrl+uSsFux0y39x1zwErFLPhKkRsiNq/z+AJ7vXjUDv64hjgH7bUoPdc0BxA
         hN2J2o9HYXhFnach4Zb3pry43eUEIUebicQgZ5BeguFtoFLRqv3cecvuLPdMU7kwmMtr
         y8mDh5ikk1PN1Y1uqSQtoRLH+rV3/DFsvc8N8azzLB8W8ymb2g7WOVKefcHsxeEhFb2K
         SqmMK8nMopQ0D60q+pYzYkSjaA+82KvVFvBn9OQpcMu9beYq6QvBxNvKOw9fAKMyTwma
         8UUx/zDFnQ9GJ+cLyN5Pf9xlFBjg1PxYj/LFBOAphMbqtVlpMR7r1SisQWhdyU1gaEOw
         scxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYP+YbSulZEYCjkrEgpM9WDyB4dOPFS5lOm+/udIHWffuDpH5cJjaUCIUl8OAQ8dv3NMod3xjVVPUNMb8PUl1W@vger.kernel.org
X-Gm-Message-State: AOJu0YxoI3l4Mpyu9fu6J6PdcjhB0ffFCqcBvh8PWjUvlLD8BBtv3z3o
	ohVVnAexgK4nxAQjqlXsKrrwARILHyBRTbW4W5mSbOwJ+3NA7J/0iQ7P
X-Gm-Gg: ASbGncukiKzTc0eYeEX0kE9GYj8IeLDWjkdeoKLNjPOUKcuCAQihfly9j5kIrJhSNRE
	IvN2wsv/1FEXymKJY4qtMdUcVX1xQSTNF9IydxMSGM3IlIeSDpno3O6DBQUEuwybU2a6ZUuHorN
	z5ivNZ9jkDDzdgvKifFSJIhpo1OoMlT3m6FC2XmYlXv/wYvl7f0yie4NahTPox0VQjOCP+QTY65
	aNofS2mVXoc+j/k/1V7+ngMaMznfZYXTQ8PM2E7vEd+6lyv6XhqMT0W9hvniB/I+L2cXu20gJ9n
	/yxpi3+eEsnGPE4es6Gy2QrRF8FzTeiFL0ZFyBbLwpTLO0MlgRgwVo4W5ubDtjvt+RDIqDx7Amt
	pKV1A3Ne1RUSSAfe8i88K6EQfwRUu1mtYeBzVF2IMWzVcioyVsi3bzq4LpQElmZmUbmhZdzyR3i
	fSs5fSrtAOeKi0ftC6FOqGSPCVDAPcb5omE9/0ZX4wiA==
X-Google-Smtp-Source: AGHT+IG4NdX6dFwbTpFn/8FdVUlGgT7NATyvYS0XQM9s9Jw8V+/TtgWkHuO9QBWslfKjF+LX0JAnyA==
X-Received: by 2002:a17:907:f1d2:b0:ad8:8529:4f8f with SMTP id a640c23a62f3a-ae9ce111644mr881293066b.45.1752811954852;
        Thu, 17 Jul 2025 21:12:34 -0700 (PDT)
Received: from rawyouth.fritz.box (dynamic-2a02-3102-6875-9900-19b4-7432-1ff2-cb8d.310.pool.telefonica.de. [2a02:3102:6875:9900:19b4:7432:1ff2:cb8d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79a0basm47740566b.19.2025.07.17.21.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:12:34 -0700 (PDT)
Sender: Federico Pellegrin <fede.evol@gmail.com>
From: Federico Pellegrin <fede@evolware.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org
Cc: Federico Pellegrin <fede@evolware.org>
Subject: [PATCH 1/1] perf build: Always disable stack protection for BPF skeleton objects
Date: Fri, 18 Jul 2025 06:12:24 +0200
Message-ID: <20250718041224.12389-1-fede@evolware.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the clang toolchain has stack protection enabled, the bpf
skeletons build fails with:

error: A call to built-in function '__stack_chk_fail' is not supported.

Since stack-protector makes no sense for the BPF bits, just unconditionally
disable it.

See also similar case at 878625e1c7a10dfbb1fdaaaae2c4d2a58fbce627

Signed-off-by: Federico Pellegrin <fede@evolware.org>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4c7031b01a7..ca7dc65a3182 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1251,7 +1251,7 @@ else
 endif
 
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
-	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
-- 
2.50.1

