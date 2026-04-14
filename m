Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B435E95A
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150807; cv=none; b=WEWfazuucaFCZq3n6UVZ0d4pF920etIkhblyu6lGgyK2p+QPlCvI+IIH7t5TiAev9XuW9+pk6C6C56Z5xznh4W/mpED599ubY2ohps0/etuV95D+xtRh0+jMkLKYmRJ460/gjsOcVrI0Hher+BH2YXL6avL1mkQKkHR1BMjNyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150807; c=relaxed/simple;
	bh=RrspV2M3q1YMPaUF6NAuszBGY+gIKbsLaOiFuToNw3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyEaBTE9bRaOAzSUHDoDVkB9Ti4u2D6Nel+kx3COvKK0S0BN0Avrz7ZBW0HW7IIYbGcuErIDX5v0uvOJNqBNwPW5GHiU+ORLKVFrPLa1xXlZpqPTFFyrSvlQZ8lC0+dLYb46C4W30p180nxGoZZ66IE/uHmzNZoXkwJSvOLyFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltlS0kZT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltlS0kZT"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so769247b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776150805; x=1776755605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZR5ZSEZp74pl3SVnEkbEOwwj/yRKz7BitznZw1sh5s=;
        b=ltlS0kZTR9RXOmax5ag2pon1pcI6NpXbpv58fJCWq26yTqXvNkagRRqZ7VGt7iRnSd
         dGdUzMG/hihbx71ZdHfU65oTnKjRwM5GNOQwHQQXltvpHcbkZEhFkTq+KnH8WCVDf0le
         w9dFLF7QTbvt1js9BSVvsyGQA/LoOliuBwRMzHFmpH3Vv9Ia1HjwOTHEl21ZCUE5ejdw
         RZoZAHAZ4Y/JCg2ZVeNtJ4MAgYocoo/CGijc0AlcMeI7JQegIwI1M/LCGBHYjXVHHPJ5
         BDDpES9RP/1AcBOjv1rkRLvJSP7efo3RNJFnRAlPvtUZhd8qpXSszjZ1vRLMyk6XdGjp
         M6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776150805; x=1776755605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZR5ZSEZp74pl3SVnEkbEOwwj/yRKz7BitznZw1sh5s=;
        b=W8v6U7XFaRR+twQTJGjcb83NgkWHk2Gq+JGrUArcU+cUcmaFpvBL6AU/ky/m6bebAk
         O7xFRDYMahOyq/4ZqXEhI6BgGxijdp9Eco/L/bo/JrlK97Q6YC4wyFgZ7Whjq7HMSAXf
         UPfv/U9NL5sSyGUgTr8LieR4lXRo5I75uPfBiSZ8cCKtAE4KFd3DgS8KLjqZpI9S7ZRr
         4eLRrewrT9YfqzQ46Pmuf+rI/IYY0JEhklPk4frj1aHJwS5BZQ5cgbKS/akDNyNyRniR
         RbD1Pk2TEDv1adYKt+y089cSdi2oVN9yss6d/1fErlU+TRuXbUHUiJSLl3dPFfFTtyjB
         rlPQ==
X-Gm-Message-State: AOJu0Yw9GultMUNwCJ4Zmmlf2dlm9eCogi9FMC/F4myib47NfC78TgSW
	UyI++cRBtJLJAzJrkcrydKJZdCFD16P1wZNlT2nbroxzSkT4GiA2IlemrNb00L6D
X-Gm-Gg: AeBDiesPJ9IwKHWtCfNbtlqqJGEA0Z8uuZeD0nxBb+7Kw2yoKnXRh6qg9FlN/7+6cHC
	DgrcjyB2sJnYFmw+rnreLEt9T3Ai6Pk7l+0a9RuX5FXneKh8SNbCeC4ofq5fWOu2lMfSRz36ZKD
	gvsB/YhzVpVtfH94Vkal0chUax+Al/z06Tv86o/kpJGgMIKZsN5QPYPGNbzfNbcpdcVSmhu7bUR
	A0xKCn+ScWD2NU6Vvo4e9nD0H2AdaI170YsS0ZhLsxxkVCG6c0V7i5wNluDhArMIeIKkRPTVWg9
	Cpqrba5qvPPn2HkAUndpCtY2Jmcq5XltSlbBjmxWBQqeIs4g+EKAcqSKqv6dHZ6fzHED5RxgqyG
	PH3xqZFsvk1fPVISOC7H9LjePRiWwxhleNFnDzUCJqsxOEIMrG5dMIumB0vTQ4vOoMAcokQLgji
	11WVPNPQCaf3hdabrMaFsGPKuXnJWVip/JxIHnb4Gs3Mp35fj3zW7vevELJC0TXQMsbYVQTWe7W
	TpdyldnkEJxcpcUKfxapv9oo9hmZQ==
X-Received: by 2002:a05:6a00:140f:b0:82c:dd31:b844 with SMTP id d2e1a72fcca58-82f0c316a23mr16607277b3a.40.1776150805492;
        Tue, 14 Apr 2026 00:13:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8d02:27d0:15f3:5e9a:ad7d:22d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c506150sm13172519b3a.52.2026.04.14.00.13.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 00:13:25 -0700 (PDT)
From: Gaurav Sharma <sgaurav00719@gmail.com>
X-Google-Original-From: Gaurav Sharma <mgsharm@amazon.com>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gaurav Sharma <mgsharm@amazon.com>
Subject: [PATCH] libperf: fix parallel build race with header install
Date: Tue, 14 Apr 2026 00:12:42 -0700
Message-ID: <20260414071242.95637-1-mgsharm@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When perf is built with high parallelism (-j128), there is a race
condition between the install_headers and libperf.a targets in the
libperf sub-build. Both are invoked as targets of a single make
invocation from Makefile.perf:

  $(MAKE) -C $(LIBPERF_DIR) ... $@ install_headers

The perf tool's exported CFLAGS includes -I$(LIBPERF_OUTPUT)/include
which points to the header install destination. The coreutils install
command creates the destination file (truncated) before writing content.
If the compiler runs between file creation and content write, it
includes an empty header, causing incomplete type and missing prototype
errors in the libperf source files.

Fix this by making the libperf compilation target depend on
install_headers, ensuring all headers are fully installed before any
source files are compiled.

Fixes: 91009a3a9913 ("perf build: Install libperf locally when building")
Cc: stable@vger.kernel.org
Signed-off-by: Gaurav Sharma <mgsharm@amazon.com>
---
 tools/lib/perf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 32301a1d8f0c..8372cd9919b7 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -99,7 +99,7 @@ $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
 
-$(LIBPERF_IN): FORCE
+$(LIBPERF_IN): install_headers FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
 $(LIBPERF_A): $(LIBPERF_IN)
-- 
2.50.1 (Apple Git-155)

