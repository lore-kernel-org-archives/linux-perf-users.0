Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A3728AB02
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221493; cv=none; b=ahdyUvRn8tj4VinV8oTOZz+ZShdkpuPfW5mTmRKiTfFWw9qzbeP7l9p3ulotWpQoUMo+XRfQ57B892KA4dAtUdG1U0FoMHu1GhptBxqMHG0X5TrIvzWq6A7QD4j/jt6+pUg/aO5XB/bp1YxGpPFLMus1D5iQpgZj7EfdWWxmjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221493; c=relaxed/simple;
	bh=Y9rAwk43R5Qu/XneIvtPPaxorqlg9IJwfPk0mko3rAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m3XQIhwIXMruup3NPNyEk4sdbAMi6XHiBaFXzsZHi3hIn7m0S6fsIplTWTZfRRR/fJpTwBQfzBs/jkB4RGsTH2ST01P2i9G9F0x2pFgkQi9SzM7FVSFT7LGpy0ry0ANtfmXSBO8PVsElB6V+3Nm/c6/5lOK9DBJ19S6DfT+B4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C853fdJ0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C853fdJ0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b362d101243so4560174a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753221489; x=1753826289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=06wlXYRsyscOOukfm0BoHmWOsjunsh8IZmbqRpcqtRo=;
        b=C853fdJ0xOQbgEZtQOkgX2C8yILwNijR7CiheNFg56U/T68obrJAaKZOBRtXdAJdpY
         2cEl1M1y2ST7E96LEmvGdbRRMKKAv6KPmVDG5uAchPsFPqcoiUI/PqS2h5AiLGfzzosP
         dzVkjKfe2us7v/rGB8m8ZC8WFTxeYb0xrg6y6jpZuSh1C2fiZupOLk8Y0ZkSxtWb3Nke
         KbI+h7XRtNUmhtM81RvMDSBXuJaF598mPEkfsIO4BfPKMpzL/kM8vpjDQYigeLk3myWJ
         jbr2L6L2xfZQCxj+ASc/CF+RzDE8sjGWezkmF9zorii4CRIRX09b5hNLovLdNOg9KCfu
         vJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221489; x=1753826289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06wlXYRsyscOOukfm0BoHmWOsjunsh8IZmbqRpcqtRo=;
        b=ZdOLq2cEuX8UEzX7ZrzfWVbgpIxlC3juwfNM5B7ZqHPiKV7gsHBw1d0G4e9IBMLgvI
         HUEdLGx8ays2Vd5fXYujMKBvAuhXu6UzOoTOXM+tNM4LngNHRKzH4UtYiFUjkenfJGvM
         g1q72RIfIOUX8oWjBFRLtU3cYT5mKaqYmxgFDHGKrxg2pgJmTmaL1ThMJtGYRhc0WwKf
         zaGCSSmJkkXp6YHvdC9rZyHHyg8SrT3+IG4qGae+JrH+yRerCVN+NbJ7Ti86yelXt4WN
         4B0FY4vKuL+tWXlsp1bXwE+8aH7eoijV35IKPqnsU0Wb00p1fRrJPhAEE6TVAXxMRwQ6
         ddgg==
X-Forwarded-Encrypted: i=1; AJvYcCXzX+u6QakANyi80XggRvjNAT98KW9OE82B058v3wlIpZ57lDbJKAYuqWHksyo99uwcgAUcmQ/rZEUPyCNJpgF1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ceMZQJLbVcdudgbiR7TRTiLF4a+nYrs0S7zPi7tty/uusUm3
	C/DQGuEJiyIjXn0YdSrwPIIMhI4r8I/QFzLCYvgfxwJA/TY29iBsW24k/KH1nlf8VN3ple4rfmz
	AKMoL7itv/g==
X-Google-Smtp-Source: AGHT+IEfl0qr0pR281L9dJaXexJr+ertXkeG0LYGx/wzbCfiyuMlqHnbJNq3oMgCoRDj/DcPskPxdJRnCpAd
X-Received: from pjg12.prod.google.com ([2002:a17:90b:3f4c:b0:312:df0e:5f09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d09:b0:312:e91c:e340
 with SMTP id 98e67ed59e1d1-31e50859540mr1050005a91.35.1753221489083; Tue, 22
 Jul 2025 14:58:09 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:57:54 -0700
In-Reply-To: <20250722215754.672330-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722215754.672330-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722215754.672330-4-irogers@google.com>
Subject: [PATCH v4 3/3] tools headers: Remove unneeded ignoring of warnings in unaligned.h
From: Ian Rogers <irogers@google.com>
To: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Now the get/put unaligned use memcpy the -Wpacked and -Wattributes
warnings don't need disabling.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/unaligned.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/linux/unaligned.h b/tools/include/linux/unaligned.h
index 395a4464fe73..d51ddafed138 100644
--- a/tools/include/linux/unaligned.h
+++ b/tools/include/linux/unaligned.h
@@ -6,9 +6,6 @@
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
  */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wpacked"
-#pragma GCC diagnostic ignored "-Wattributes"
 #include <vdso/unaligned.h>
 
 #define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
@@ -143,6 +140,5 @@ static inline u64 get_unaligned_be48(const void *p)
 {
 	return __get_unaligned_be48(p);
 }
-#pragma GCC diagnostic pop
 
 #endif /* __LINUX_UNALIGNED_H */
-- 
2.50.0.727.gbf7dc18ff4-goog

