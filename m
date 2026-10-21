Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602684;
	b=0Id/nxQwr5j4FUgm+LSxNx+5TJsUIJ1aPL/rKBipDc/hWd3ElPjysxwu1miFM1C+KpzB
	 HEACMP9zC28Kx61N8OpOrJ1ZjG3ieFCd13wCqMAm8eDNgyRVhJ+NWzPBigr8AaUyZabYS
	 0LyKTWordTArPvHveu9i73Dd5+NVrrQkc1cIiV0OxWhh4runwKBUmUWIqacGGnOF48S2h
	 /BModHlk2feYL8kAqZcq2Iext8JGdej4RRrv27RSPYpUKs5mWvYDjsoNA1P7i6M4nCo60
	 wRk9e7owei8LbezmdEK4S88hjX0xYxhuL3L8G7GiehD5nAJFeDITLDc3a+s8D0sLiqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qxTFTtf8V6FF42iRmNOHdvJNuQcB3RcU8GW6u8RfjpA=;
	b=kT/X3oB929WZMfh2qyBZhV/SBGIIm+CEyUb2XFKBnb4uUtIxS8rkeSUlf2qr/H96TG5/
	 cV83TrfAKyp5gFyAszoNWED9576Iq6EZ8bkN4XjY8T4qM2hYNfSbKNLKpiVvQoJKIVhRS
	 k/wI7JBjaLFDiRGkPXLqtQVPgSYYtqGYxPxSj2IwkLnclV4kBee2m7Zip6HTIoOap3dWp
	 er0SsS6SuA4BvjGF/dwfPZXoojqYP6jc8HIeKmNtwQkt5TjO3GTEsE4epiB6Q6B8dT9tK
	 NV00tQRzL1f307KjHR+IkUhCkeIJreSghf9YrYcRSphjaZTDB2WsQmCf1CTmtFI6RlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="cRD/JdmM";
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6442606A332
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6442606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cRD/JdmM
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so826185c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792602683; x=1793207483; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qxTFTtf8V6FF42iRmNOHdvJNuQcB3RcU8GW6u8RfjpA=;
        b=cRD/JdmMX3CkUtEnuTfeUvxDCO3zy30tqwynMZdClCobMLCdQdU5d6PwDa8KoQYJoC
         xrsw1T3RKxI7NOhDrdIXjx9V4Mh/6HCwDqmFOET80Sdo4rqdbr2hjtGMm8GI9LNbfiQz
         4Efm9lioKBTO2g84k0/X+XuiU8LtWjaBN2AMJoYrKM0MxFbzotsPKw4KjbHNKQq+52nH
         gFYlKVVCEjtzHQUg28tvqZA7duiUZ/l9j0OjK69fGBJC3+CORkEZx3ke2i3O5MNVnQhO
         w+Sr/yFoExsU+Dm2UaeeKGYNt/66ceMNA9P/5YbI7fLOrL6iK9FRAc8SFmmiMJz9Ev/j
         6y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602683; x=1793207483;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qxTFTtf8V6FF42iRmNOHdvJNuQcB3RcU8GW6u8RfjpA=;
        b=aHRSyQeHoKk5IPCzEfxCdDXuOqMJtWaZ7Ff+GUUEr/OKYm+5WsqLYBnwq8RPADyPCz
         kh5wdmx45pJ9mJ0qtW7UYL/AEHF5NEzw0MloBbxI8x6/tXJXnfpkFK7u2awgeoYVHmU0
         RzJeB6pLepIqrdZLqZbbAyvKYCu4eirt+a1dxrouJJkWJGjK5/MFf8I6Pa5uVo5lJe/H
         GsExOmhK1JOpvnMEX3EYzjvLZHsHAHxJ2DpUv41q5xv3hzG8nLLxHsvBBIzRjH3Kctqp
         vdCjrmqPWaAitoQXolDzdwJG2JXoWuF9Ql0CYw9c9d7NoKLXKUx04SxTh4nnIjuKD6Hu
         GV9A==
X-Forwarded-Encrypted: i=1; AKwUvBxu5ponC7QU/88sdLcW9O6tcNa+3644F3F9mcVPlUGiE+A7fLdbEg1cC6MbRWDutccXXgwi+iBFrzsWQbrXd4bz@vger.kernel.org
X-Gm-Message-State: AFq9FYLPfoXDLOx/i2puhEvJEApnp1VtenwYluJ//FHlt0sBI3icJmKA
	mtu6+S/c8OFsizKCn4E4nfNtrR5g+lFdyZiIcgcScJ6GNrp1JEPORMMC35j4cvegfyPJSuWyt+4
	PR3Xwgsg86A==
X-Received: from dldz1-n2.prod.google.com ([2002:a05:701b:4181:20b0:191:2838:ebe4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:906:b0:14a:8cff:fbb8
 with SMTP id a92af1059eb24-190a6adabb9mr3548333c88.28.1792602681890; Wed, 21
 Oct 2026 10:11:21 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:10:31 -0700
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
Message-ID: <20261021171044.155240-6-irogers@google.com>
Subject: [PATCH v6 05/17] perf build: Enable additional Clang thread-safety flags
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
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
2.56.0.218.g1ec904b173-goog

