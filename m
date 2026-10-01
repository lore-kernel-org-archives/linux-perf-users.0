Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1743DEDD
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833294; cv=none; b=Kjxx6kUNXmQM+qOL/elz2/9ZQe/VzMA2xDRKlNzwzo25OOCC8lgdIlUxwCIocHv5zfJDL8dbDF8ODfOnJv4pE2NNVfy7AcJR0j9KuUIVwN8VDqyQY5eljQxVD4o6+TfV+RoMcAN93vUVJvABxCnedZkgSGrOnfpL3a/7+lE3PY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833294; c=relaxed/simple;
	bh=O5ODVShe1B0LC+rEY7qNyzL+7S9xq/jUBnul6lx10x4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TcveJxz3JaOV9SCMuXSlWCXhMHg+5akZa7y6u4uLp7isaFTA5e9LNZfJ1zlB1ktLJojjSOIv+q71iyktpIWazmnbm34c+6sr5k/EGvSNoh56oVGnfTT7PZuwXqTpYBygh5a9zUdr7LzdZxR0qRHekD0FJTN/OLYluInnU070gMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAuTFfUU; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAuTFfUU"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so12121767eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790833292; x=1791438092; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x310nNqKeL5QTlQDhNqpbdK2+BHdclA/oEK1ZuBObLY=;
        b=oAuTFfUUatrQrh0SmJHyc/2QeM5DUhW8hiZHopAMPN2RtGONuqOLU/+G5XIakTI+QY
         8//NkPLht0eopCGrcWjGCQksXxQRWycDqp9UJGZqSbrWeXXm3Hzx8ZWL2pc3nDvGhmks
         pJzCaQD/dsl2Il8+Zcab1jsDk1TPkqs75v15jJohf1QivO1oqAA9n49ebr2fZDP47Sqv
         acZ67NDN121cdS4ac4wbCZkJwloMgbwDJjwlmbH5JwdWhDZTymJ7diJSop//mY+nNhwG
         M/yx1aJBxNYzj2680dULPpec2rHN6d81TdHNvvDoML9403YHt5iSuWoeuU5StD5Lw1XX
         dlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790833292; x=1791438092;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x310nNqKeL5QTlQDhNqpbdK2+BHdclA/oEK1ZuBObLY=;
        b=HHUKE7UYPjjHBU1AEiYGKxybEnfo01UY2BWQeo3O4DrRg1OFFdJl3TwdJqkX5WuG7M
         Y8NNr7wW5WXsi8QRLZ+BFgXcaBU2zvgmNgCh4R8SCQ9tFb6YHfPDgKnlBJLrhtKPmKA9
         DTZJJQDOIyAgKpdZmGsrxIKjXjDNR4rEGBA5+rwxdtlc52gPUmTRnzY2813fyiwqoLW5
         3kEC97SRDtUif66PlV8VTfCraQvksJBJlRWGeXFa0QsiSRf0O0vRzBhaj8XuDmnkxMI4
         HX/k9f9jsBTRomgGY7WE5YujrkuD0Bs2gOdhiCSE1zjahw0ZIzSR+z3CBT8Wdvv5bYY+
         WKtg==
X-Forwarded-Encrypted: i=1; AKwUvBzVSQI26n1R3rwrA8WRNqUVjK7/YyPob0a2rpxTeWrQw67OzkH9xgtGtGV5V0zISVNpDOQARi73t66SDGQvHLC2@vger.kernel.org
X-Gm-Message-State: AFuF++kAZlKjRKG/0tNLi4OHtw651ID8bZMK0IkefSxsNiBE9SABd1pg
	ntBNHapZRP4aRir+PJfytrySHiFeeXpF33pXg/L3iOFccIVUwk6rDBJ5UaZ5fVB1WRtk7F4lxQJ
	rgYHlNMTt3A==
X-Received: from dlbej9.prod.google.com ([2002:a05:7022:c49:b0:14d:d7f0:5394])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:290a:b0:14d:3c0c:79e8
 with SMTP id a92af1059eb24-14d3c0c7f31mr3337305c88.10.1790833291748; Wed, 30
 Sep 2026 22:41:31 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:41:19 -0700
In-Reply-To: <20261001054120.1570943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001023423.1225713-1-irogers@google.com> <20261001054120.1570943-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001054120.1570943-4-irogers@google.com>
Subject: [PATCH v2 3/4] perf build: Clear GTK4 instead of setting unused
 NO_GTK4 when gtk4 is missing
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, leo.yan@arm.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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

