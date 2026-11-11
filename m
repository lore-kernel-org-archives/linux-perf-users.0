Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418951;
	b=zXTbZonRQZPwv7zb4PeX2E2MrEgaw3YqDL2RU0ELmGzpWmyljRZeGDHOl5VpyGGhy/gW
	 WfGKBJEohz0Q08tX11bF1Jh8rdoDthP3+QxPcsq80WiNBg/K090D/ECqjtwe6yDMc5gNN
	 ZrCFPvDe/r1c1P/4/vhmISMmdlGPZHck0saAHEtdunweaHIlv+3+MgmnK5ose5nwe6Wb0
	 7SWj0xgN0xaORj8G16PLk3nigAx/OuVOTAoyqvBwXp5uldor/H6AFfMz+H06hb8EUxBwW
	 rkujchdvzMg117efLQUzoHZ4YKgsDTom0JDXlRx4AvTo3rmoJkDqzQD5Cq3wvzdn+6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6lxdgKdM2r09Kc8bEmNWbsconFYa5kW2HuEnCCpVWss=;
	b=q6YWW1XlVN8cna0kHAhDdZfIArwyHTZlu7ifih8rJPEu7nujwVzkXKJfHrrCvDQXbrfj
	 JwyvZXVZ00x1XMUiOF56xnsHzFGOZWU0Xm6Ku2cF6tf3tJv7y14gnTUeUUTAjkhfaZDul
	 Zimhd5Gp71a+tORIgQxK+qxokByLgwJJgEU7ZSVvBR9wfFOAc0t1OZZpMLoeb+wL5xRJc
	 xk9sHkpy0EAYgnlEYPGUwgr1zuFaFfe2puEQhb6LBUpl5oJFcFX8Gsw85nsF3rUEfY/fW
	 UxiDBuiTqEGMbLJoxBAxQ3I/EeMUpHiNX7ZZWonvnFzal/pZB3P7eJcYDc9ymYO7yVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gayfeIsk;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859AD606A8BD
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 859AD606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gayfeIsk
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so6816744eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794418950; x=1795023750; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6lxdgKdM2r09Kc8bEmNWbsconFYa5kW2HuEnCCpVWss=;
        b=gayfeIskl2++4z3l+UbDjqpv3/dhSEuxSd1TJRaCeBtNsbdWFDZBy2c3G9slp3F+dQ
         fKFE0N3apQdPtikJUdRk3YATUMUmNEcH2U+eSj1oodB9i/ygqoouelkciJrWyN73Avfs
         mS6wTH/ll8QNdnt+Fh8oE2HZcXpnvWxNjvl9QBRThNUg4BoaNpaOpY7089DLQLueeLu7
         Hm0z7zKz2zI39v7FXver3yDDteMu71ajuUTvASWiEu34OfISba2FIAnDRM+FdZnNe03r
         tel1wK8raWQaliTX2vZeh6kLL3K65HbETDS2RKfXhVkzRnEx+mGYuOOm/HT+ie1Dwm0n
         M70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418950; x=1795023750;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lxdgKdM2r09Kc8bEmNWbsconFYa5kW2HuEnCCpVWss=;
        b=Aj3ita2GTZAmlUXHl4ps14GIPkcsAk24v2wU3sftr4DR87uJu+T7mbgwrHVBfhwikG
         P7Cud6Iqi8HKAer1akTYlwUY75kbN/ERYexuvVPDJciuNNYLFWZZeajDgMD2DhS+Curo
         0OgamTGkrpjBpbMghIS544r8z0rVpYi6q31oim3MgQHfiW2+hPTNw56hQ/ucOAumKo6+
         IhY/5PEyYF1gpTSR2A9PknTE3Zzloc8HXdiKEwR18hlOq0/hm26E8Ccr0j5HzjVH/8Np
         iJ05ghhGXOcdalqbo3S/6rkyVlrWyZOdir7QI+zPeGtAICDgQUDavKDkNLwOE3/Fhcj5
         WgLA==
X-Forwarded-Encrypted: i=1; AL+hErHgzkidsaoRY33lgA2M28bXpDfl8jYz/GMjuc6HwsvtbCuq7PMlAub5RhcVaLdmVZIS5jqFWSDtR91s0IPvBchr@vger.kernel.org
X-Gm-Message-State: APuU4Z+v18lA38tC9RnsXYucTZ/qcJGgzdSZ3eNuHrWkZH+CPI7i/+G2
	yW6qx4KWa9v32rc+h+Kkg/79itaaP0wWxvwo6UAfgVtfAIMhGqKv9FU9yxbUTUsc1x/hq6UGBLJ
	yPkamkXJDvQ==
X-Received: from dybb16.prod.google.com ([2002:a05:693c:6090:b0:368:83bc:cb15])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:88c3:10b0:370:ff2:f78d
 with SMTP id 5a478bee46e88-37685c7a800mr3499244eec.8.1794418949297; Wed, 11
 Nov 2026 09:42:29 -0800 (PST)
Date: Wed, 11 Nov 2026 09:41:57 -0800
In-Reply-To: <20261111174213.3526604-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111174213.3526604-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111174213.3526604-6-irogers@google.com>
Subject: [PATCH v12 05/20] perf build: Enable additional Clang thread-safety flags
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
2.56.0.542.g3ef89b7020-goog

