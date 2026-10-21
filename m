Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622369;
	b=M/Rfp/cVuyc0L2uxFkfP1A5vkYWw6QndD7VxWRx3+m2h1N9FK23AwQ0hcnVsjW+Syzhg
	 6GccO7UGXW4rpHAVMzb13RSUSLVwBZdDPX1rw6ctTbcsAdAchJuM0wZjFJXfU3NC+999u
	 UE1uYuQ3g4sXqZvSesp01TbG0F8q9U5KOIW2IV3JBqpF6UrrL6/RKyLGX4R5L9bzXDYzT
	 MqEM5oOGQBmMiXfelYomKrJdK1GCGoNjG0GkH7LyLIEJ3ai6e6iSBZfn/MzYCokFmwJpz
	 gVXMgrvtJpOWU4l0nUBYLElE7afJEsbBv9ObPDqBGOsSQlz+0YD+lDIBD42bXDECkqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qxTFTtf8V6FF42iRmNOHdvJNuQcB3RcU8GW6u8RfjpA=;
	b=Lp0ElsAp2IBq3nJQmk7mVw/VqEROiWUkB+YdXMUmACgGKqWm6bXOMjUrvls56mjU8VOA
	 Yg385YAqmpj3vYecd/C5mrBycA4CfrSzP33hnGJe0UwWoBKW8q0HuPFEJXK8HGxd2lHFB
	 pN9go+Ddqb7zYtGxcKW84+lMEWFxDt5QFAhTrFXND7BL43Ll4rLmxODGpaw6+UY3P6mzM
	 8A3ot0HrSAOCqaZhsFk8THY2PwXLCPdqLyIMSbqm29UPnB1mnwGqAMrF1CNP2/ve6kHPA
	 34qgki4ts/wdby6CTRjq8/GzCWc1+JLMifT5tcs6dB8Qpl5aCgsN/JXrobLtnCHyUgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZmlFAVSd;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E0606A324
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 196E0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ZmlFAVSd
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3552883bd19so4344866eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792622367; x=1793227167; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qxTFTtf8V6FF42iRmNOHdvJNuQcB3RcU8GW6u8RfjpA=;
        b=ZmlFAVSdzrOMJ88OeZ7hGewJu+rpH1Dqxv/iV2esiVu/uLoAyZy6IGIuyfYX3xtjOB
         dR4aUYU34z9de3Csii55McJSYKzGiFC0JtZ/70f26tSMUX/JtmDOQu4AFM2JSzpB6Aph
         e/QS8ABg8P5KyTKc/02sW4hMg8P+KC3J6WCdTQaBzFy5NbWFfOvBsHpyOOuc9Ep54h2G
         nqTK992c3qbyEmz4WwhIxbdeMYWKp0KF4z/Hji/t7ncQ5PGorfL6AfNuIyHFbsVYkcWo
         fEEOJUDmxJsC1LfnWOYOYWUB+ZdWAJuZmAH19hZE4PeshPXMdBwksd+6c7Ui0KNABnoL
         Qjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622367; x=1793227167;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qxTFTtf8V6FF42iRmNOHdvJNuQcB3RcU8GW6u8RfjpA=;
        b=OCWipXZDcmMMd7VG/RxyA598uv9i7YAG7yWQ9qmFp22T0GM2cF01N1mi2QZiWSEAfV
         Z8BxynI2HCI8AVjL16vi/yeFUhk6iMcVp1KCtEPUmet53Iz0WnDEaljT5d0SuMsCmwg8
         bynSDo2nsY4BUSZQyQ6JyoGSwe+GlvR5qEshOBMmqWjUe6W+2SUzRN+AxwnziV2U6mAK
         P2UClq++JaG4hRsFtFl81y5lP6/du246758frQiF454rKm2K/CFPF6/2hQZpIY8CE0L0
         WVwygKXcHFHkkB80HdKDIHKkwEDOi9ynuCYiai3R+7eleyAIHAW0aeL/MeCoscjWLiXZ
         B4zA==
X-Forwarded-Encrypted: i=1; AKwUvBxyZJjzYeTaG3Jay8ILGW5swd6SnGZw2qApP6r1ZFjGF1QaQ68SdzKYbrOu8CPp5nCfxpYv6aVk5AiqUCxuoe0X@vger.kernel.org
X-Gm-Message-State: AFq9FYJu9+KxlUGbmGw+gYnWPMxn3uRSRISBZwVVUN/YCmY2Il3D4e/P
	WXZafNU7nO867vDoghCH0lf/RKNINsueJuLqi7mx9GyVgP1zgrTaJAud7F1+54AhABEEJLxwfkK
	mpxjOzQLyqQ==
X-Received: from dlbpu6.prod.google.com ([2002:a05:7022:e886:b0:161:df69:3983])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4546:20b0:144:c112:5f24
 with SMTP id a92af1059eb24-190a5d6eea5mr4048804c88.25.1792622366950; Wed, 21
 Oct 2026 15:39:26 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:38:53 -0700
In-Reply-To: <20261021223905.715051-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021171044.155240-1-irogers@google.com> <20261021223905.715051-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021223905.715051-6-irogers@google.com>
Subject: [PATCH v7 05/17] perf build: Enable additional Clang thread-safety flags
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

