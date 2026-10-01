Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CAA3B7747
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790822077; cv=none; b=O3gNEfF2qBKOe3KWee32ojakMJsqVWB0My6ULpp2UxnhzPeF0JSxTDlHbroTlYi3pUj7rnkp44ObJR07FmhH8yTezm4DDlDBo/Wi92mcAevShJxW5fSgOuLEzQLB0CL950VBz41WMzvT4r4IpUj82m1NSyqiOHe/er6jUcNITIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790822077; c=relaxed/simple;
	bh=O5ODVShe1B0LC+rEY7qNyzL+7S9xq/jUBnul6lx10x4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bYOBrGaB/diQRsIqWKxfboeJQ7R2HPMEOoc1r8Gw9KLsrguNxW9MiTTpNQ9jEX1VBQp1YSFwt5S86WJLq/QmwzDKOU0oGtJv1MMUh83i2vuYyVhPH6BxcHH2FSanfsZgRpdfOOAU23orN9aLBePNa5tmTxdcZnqpPN6DLCI+Klc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlnAlGi9; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlnAlGi9"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1431ba79941so6831162c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 19:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790822075; x=1791426875; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x310nNqKeL5QTlQDhNqpbdK2+BHdclA/oEK1ZuBObLY=;
        b=tlnAlGi9OGYiN6+TYhs0ZSmNXgTxyE0wcGLhzc0miBcyuGPCDRU7OF5bp+M6ISe+3z
         QY4yaW9W4Ml3UzUS50B14c0CkxszTvadwnX1LSvLkHqF61lDmJi9CkxaD2kUJBnyr9jD
         cA9WNDimp/FcypWWnhD8ECYOVLVKnk3ukXknK9gMjDsoH1AA57iHfJa879H6K2UiVsv/
         lHnx+dapuA4/qE5yPM6g5csye2UcditjGPmdhkwHE2F+xS5Wox63pFD1dPA6h+c40xH6
         xloPLG1O7pnIduzZdEXXC4CGJFB+B/k9C8z9sb8RBYYc0YQq7IqZ1Z4c0YC7d/a0+xEi
         d37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790822075; x=1791426875;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x310nNqKeL5QTlQDhNqpbdK2+BHdclA/oEK1ZuBObLY=;
        b=QjLLVsIz6EY/GD4J8TWka1RWE85x/Knafn7/sl8WfaE/UOR/c7uMJEfjnpH/NSqe9h
         0cA/FZ5V3+WVkf+hon8+SYpCoP3D8phWPGlLVh1F5DudDUjs1OLUkN4Al+ADFCZee+Fg
         JPejJzecm2bnAlAKyAyOGPpHe44prKCS4Tt9QoWlNvwplACP1zxkgs7jCf3SwqdVCfpN
         iGuL/e3yiESclkWFKlMtZH16tfSs5vnZJW5S2+u61kT6uPOQ8dpM+x+TJ/AycBmmMF94
         PKbZWHRfKgRM/sP1HmI6zz0YJlylHu/FzOlcOhfZWmQ8eRDMxBkos6YmVVFCBRXTk/Fx
         CofQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBDW2lGkpnzdAtt2n7PdEyuaHx1rHr6Tn833BsYjQd+w1GYC0mR0dmP97yxovHg7lfokXvprwNCOgutxSEUCfD@vger.kernel.org
X-Gm-Message-State: AFuF++kco4B0i5iwCjf/TYgTuCqsj2vejcsIhkZy+jhEc6lB4oSfnG92
	Yh3oQtou+3hkqBxvLbtusFGNR04kwEBfziJ7/k60LvQGISvvdfcRkrhUg40gVu01m/XmNOesEbY
	Tw34ugy6Dhg==
X-Received: from dlbrl17.prod.google.com ([2002:a05:7022:f511:b0:143:9658:f913])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3715:b0:143:5c63:23a1
 with SMTP id a92af1059eb24-14d3204da83mr3085033c88.19.1790822074757; Wed, 30
 Sep 2026 19:34:34 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:34:22 -0700
In-Reply-To: <20261001023423.1225713-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001023423.1225713-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001023423.1225713-4-irogers@google.com>
Subject: [PATCH 3/4] perf build: Clear GTK4 instead of setting unused NO_GTK4
 when gtk4 is missing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 4751bddd3f98 ("perf tools: Make GTK2 support opt-in") switched
Makefile.config and Makefile.perf from checking 'ifndef NO_GTK2' to
'ifdef GTK2' (now 'ifdef GTK4'), leaving 'NO_GTK4 := 1' in
Makefile.config unused. As a result, when building with GTK4=1 on a
system without gtk4 development headers, Makefile.perf still attempted
to build and install libperf-gtk.so under 'ifdef GTK4'.

Replace 'NO_GTK4 := 1' with 'override GTK4 :=' so that 'ifdef GTK4' in
Makefile.perf evaluates to false when the gtk4 feature check fails.

Fixes: 4751bddd3f98 ("perf tools: Make GTK2 support opt-in")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 8f46885d6df5..cafc7be79643 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -786,7 +786,7 @@ ifdef GTK4
   $(call feature_check,gtk4)
   ifneq ($(feature-gtk4), 1)
     $(warning GTK4 not found, disables GTK4 support. Please install gtk4-devel or libgtk-4-dev)
-    NO_GTK4 := 1
+    override GTK4 :=
   else
     CFLAGS += -DHAVE_GTK4_SUPPORT
     GTK_CFLAGS += $(shell $(PKG_CONFIG) --cflags gtk4 2>/dev/null)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

