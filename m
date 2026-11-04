Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825969;
	b=SUXR2g8obyuu/AvPnv4VH1SE1PXl2LhSNXb86KqGb/1e9c69I6YusDChPBxOB8dOcvOd
	 VI1bXRtXX2L7gjFHXPb9dfmBq1T5VZC9S/Tw1h0tnQ6HlEEHmAk7h79Ia+YGh4J4QAvj1
	 Ot4BhhLpwpQ9WZm52ek9C2WKsTVF1Xia9zw4gG2A0StfIy0kP0/pRwU7jA4I61lMzGPhT
	 Q8zg21SBHqeBWh8alVh/DNyxtJ9abe5Wr/YstmUvSyPu/uJ8+FO9qdOlPEmk+U+n/C7R0
	 1hnM8kDQlecxR+mFn9RS+krpITgfP5b6kgvRrc5101aga86inT9IMKEjT4flKykxgBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=W68ZHdTr4uS4t3HLAWkunw91OyKFrULjE3FrBfJFUMM=;
	b=hRb3E5QzJqJ07ptRscusdBYcYazkRGGdhYlYDx+GlSX/3/np06b49ktb8DPV+RyW4gpP
	 l3sRv1Dz9hqAjx1XXk0Azn1oti1wMZadzF1y8Gicf3LNGiKfEKa190gMMD5Zgl/n7gfEQ
	 Pr8/qjXBmWRIuuC2tfzr6gvpW+jBxyIPmjlvDcerKl2f6SZVPWpkbMGs2CZE2uPVLhXur
	 IBC+/P5HNqVFzxfgcjPh5E+3iihkCSUUteAlUorzVQysZtcjsq5KY0prlYzVTPTRt3JX5
	 KDpzTvO96ik7UBOwbJa1TTRoCUaQ02Lr4oDcFEme/SewtRNxej/Q1zh+0XhP5BuqKmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dmlG66kc;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F0609DC9D
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 20:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 022F0609DC9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dmlG66kc
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3662e7a9299so3893650eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 12:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793825967; x=1794430767; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W68ZHdTr4uS4t3HLAWkunw91OyKFrULjE3FrBfJFUMM=;
        b=dmlG66kcRRj0kd/fNUqpkHKLvSrILls9jC5PGoL8OR+Q5fgStJwycq94K/yX2Jxkme
         /+4Dra58WPFZHurtMdz9PoH31FskZ/iANvD0j5Wjx2a1cbWbaOlbj5QwtvGqr2Wzemyd
         tQ0U0V1EWsSZGzmsb6WCor7J/pk70zIixz8lEL9Xy9vXrVfU8hnGzarRjbaAHdauUvEm
         4stMG9HM4MDZKduB783fa8nm7oG63uenQfSrH2gcypnsWMk0vIfvvdp19fik3kyErA6s
         Vc35/XwsYzpRRCMDM9rkD3ggJWU7mDZ2te9BwdDOO86gsjc+SwZx9nK1uY16qRcj0FkY
         egHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825967; x=1794430767;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W68ZHdTr4uS4t3HLAWkunw91OyKFrULjE3FrBfJFUMM=;
        b=WDYbtB6o/yvrWn+8HSasTAvtlK+syUTzVOEQ8FjT76HlhfRYHmTHC5mbK9ITE6RwDJ
         CfcmRfaNcPkQuIFRrQV0NV5Ckcn642eEsMqYzZCxlm3isnyNAXzhNoqRfioRzHNXTVLb
         PA+dbj9VQJcrFZI68MqiaAHYT7EA4TCy7EUU5/i4aUhJAgtMTRO0kKZEI+23RsO1yeRa
         Ty0N14WZ2EMTUczjuvhnuROR2AjJSXumKj3PGRLtQ17OehoLg/LACYmozO0gFMZVTokf
         6K9OyTrhk9uIh3Me/lM97UDTHY+zj2L2oR8SGsnSe7nqZlqXY8gvZMuouzH7tM0S/wMo
         ClqA==
X-Forwarded-Encrypted: i=1; AKwUvBxE6BNSVguDE3xsPOIr8mWcwVeAw/QFZruvefQrV9NwPL669WY9XoNIECcy5jY09ZtmMViAtbhX/SBUix28lfz9@vger.kernel.org
X-Gm-Message-State: APuU4Z88Ptf8Rm0d8t80lnGY4Z4Geoy+13UUiLWm+14Xwi9hm2lYTDwu
	6zbbXC3MeQeqaH4+0JpGPyOP61qmislV5+7MHJMEP6Ow3DZQ0jrcsvucr3+buXo+OGTLyFu893B
	pBxmj/S93Ow==
X-Received: from dyad10.prod.google.com ([2002:a05:693c:834a:b0:369:a832:e377])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:6312:b0:36a:1709:458
 with SMTP id 5a478bee46e88-36a423cce1fmr29129144eec.27.1793825966833; Wed, 04
 Nov 2026 12:59:26 -0800 (PST)
Date: Wed,  4 Nov 2026 12:58:55 -0800
In-Reply-To: <20261104205909.2078411-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104205909.2078411-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261104205909.2078411-6-irogers@google.com>
Subject: [PATCH v9 05/19] perf build: Enable additional Clang thread-safety flags
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

