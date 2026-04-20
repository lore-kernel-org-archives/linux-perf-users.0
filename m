Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D665E375AD0
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685959; cv=none; b=jkFLpJDJo/QrYlhpBs3MFe///BwqhPuLB1V7BMZXnoGEALtYr8JwdSAgwRMrXzUOhFTNCfbO3BcsJcM7Qtbwz6ELIXxca/XMxcMyTkJwT2i6VYlVpTwSBCW39IhtT96BKYEfSHItl2lgeC9bWkMXqTBWUPvIhGOHfLtBqb6cvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685959; c=relaxed/simple;
	bh=vHwBqswcdQZaeVsEc2gwd6vRqAC/RTvzirs9erExNeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oYwx2nW8sPdvsmBz+FktlQrWbQyFvp+D29c6JOJ3pa2gr3qV3azd6GLwAefsY51gpUi4/juAbh6T6NpoKhDBDgezynl+nQP6Snt2A3T3rb9H5hdlK4/lAvanIBGGUWURdUB5bfuifWtvlsBa4tnS4ECtZM7/4ZH5tR9fQuwsepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P6c/0Rde; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6c/0Rde"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so45513125e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776685956; x=1777290756; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft3GZswCSIEeKUFgI0RRTCd8g+ojVNAgLUGVNSAH9vY=;
        b=P6c/0RdeatH06jw2Cphnqj/qEDNXlVW+yRyAm1WhLnYJVMdKyZoILjUo0urohSwTpN
         KUMPvttkgYN0M/1B50Qn148+BwFMSTXt/1NZh51AUENnK8qwe7rFnVya1WAppXf+lpje
         HhqdcwRYp7J0zmu6ZesAcIBAq+rS4ExjC23Z4/AWCKdRaYPPpIFdp28WNA6rx/By6uWk
         hwdMvVeI5XwWFdASjnFFZavDYcQ+C04Af9Xbw1T3KU8tqJ/A1Ly2E1DoaWDusWzDoUMc
         vYc7kGWNLCwWGMbdG8wi99I7lKPxz7cxptEdcIsdcYO7sYXOMllUtyM0VvXz+QlWh0VR
         SYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685956; x=1777290756;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft3GZswCSIEeKUFgI0RRTCd8g+ojVNAgLUGVNSAH9vY=;
        b=j8voI9Pmbqew020crb/XbOmcCxChoaLr4WmVYpYi4JsoEgL052jpLtMmm1dUgHTwCb
         AqD/ZBCtifwVs0EG17DkcA8nnLSg8LXz9wrQF8uMwjLA3KtTfeZ5M9nXCFKiN/Qrw+xt
         vigxqPwN8/K/8RxKicKVXjAoktOau/rHbinyYdJ0GTogqvPtCTxc3u6jz+SmDUf5YCxs
         F4Igj1rS6WDhMyA4vSOL8wkAyxwbPRkoVo+ZGFLefzSPrKK/rIwEScung5IGet2bjHw4
         P2Cd7VfPIHq9cB55GrvDBQImkNlsG+/cDnb8/m/GrNBGfHFumG6sfDE1QMnA5k55/tXv
         ke7A==
X-Gm-Message-State: AOJu0Yx+sZIb2oPC93o6g5015U2vlWMP/RuWan2u2pnoAmvjWX3KHdOx
	/sFnU9hnxaWDwQZKmlGzc4IJsdvVv/+j4Cgu8KdyZVQzTYjFNXz3RE7MhOoz9f/qaVI=
X-Gm-Gg: AeBDieulOfieXzg+jPJmFuX7l76pNlIalRnfpyxyJdxIz9FSjkKqp6ZCvcUNULREWku
	DDMDG1S9kr/OIvdsBjsufxIEShUyP8CwYOz+Lou8DyHRRqsx/SB1aAe4al5D26cEYTa/VU3VPgB
	iqxuKWN+AZO43W3LrdM8tp6ADOKTnsdIdf7NOu/vbgoHnwVyAHZjitUw6LJMYgqmG0wMzI7qELF
	LEjcRTnbfBgRh+Ce/7YLBtKthszhA4NkC+d2uZIJmRV1LfM1zBYQeJkCetH90kqbJK+SWI+0mIc
	LgOZiPF67ABYVf/CVbKBfvApXWVkpyrF8vFaMIuF23pbg4zycLmUMjR8bDJZAophauJzhBU/g9B
	MyFdJaFD6Iw2wVrT7elUlyN962uw+Ahq14Ov0mOCa0smQQahHwAPnn7HxLmcfk87TTtC8s5wvH+
	N5Yvkh//tho+KYrDQtGr0ITn1w0+6QPgRYR32cVkY=
X-Received: by 2002:a05:600c:5252:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-488fb768483mr204267335e9.18.1776685956193;
        Mon, 20 Apr 2026 04:52:36 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c320084sm120790985e9.2.2026.04.20.04.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:52:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 20 Apr 2026 12:52:17 +0100
Subject: [PATCH] perf annotate: Fix crashes on empty annotate windows
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-james-perf-annotate-assert-v1-1-ddf04d640569@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHAT5mkC/x3MQQqDMBAF0KvIrDsQU7XQq5QuxvqjUzBKJogg3
 t3g8m3eQYakMHpXByVsarrEgvpR0W+SOIJ1KCbvfOea+sV/mWG8IgWWGJcsGSxWlszehdY7oH+
 2PZVgTQi63/nne54Xc1nxHGwAAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Annotate can open with an empty window if the disassembly tool fails.
After the linked change, the TUI started assuming there was a current
annotation line and could assert or segfault in the seek, refresh, and
source-toggle paths.

Handle empty annotate windows explicitly: set the asm entry count before
resetting the browser, return early when refreshing an empty list, and
ignore source line toggle when there is no current annotation line.

Fixes the following when opening an annotation:

  perf: ui/browser.c:125: ui_browser__list_head_seek: Assertion `pos != NULL' failed.
  Aborted

Fixes: e201757f7a0a ("perf annotate: Fix source code annotate with objdump")
Assisted-by: GitHub Copilot:GPT-5.4
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/ui/browser.c           | 3 +++
 tools/perf/ui/browsers/annotate.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index dc88427b4ae5..321187b204d3 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -513,6 +513,9 @@ unsigned int ui_browser__list_head_refresh(struct ui_browser *browser)
 	struct list_head *head = browser->entries;
 	int row = 0;
 
+	if (browser->nr_entries == 0)
+		return 0;
+
 	if (browser->top == NULL || browser->top == browser->entries)
                 browser->top = ui_browser__list_head_filter_entries(browser, head->next);
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ea17e6d29a7e..0261cd922183 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -449,6 +449,9 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser,
 	struct annotation_line *al;
 	off_t offset = browser->b.index - browser->b.top_idx;
 
+	if (browser->b.nr_entries == 0)
+		return false;
+
 	browser->b.seek(&browser->b, offset, SEEK_CUR);
 	al = list_entry(browser->b.top, struct annotation_line, node);
 
@@ -542,8 +545,8 @@ static void annotate_browser__show_full_location(struct ui_browser *browser)
 static void ui_browser__init_asm_mode(struct ui_browser *browser)
 {
 	struct annotation *notes = browser__annotation(browser);
-	ui_browser__reset_index(browser);
 	browser->nr_entries = notes->src->nr_asm_entries;
+	ui_browser__reset_index(browser);
 }
 
 static int sym_title(struct symbol *sym, struct map *map, char *title,

---
base-commit: 841dbf4871c57ce2da18c4ea7ffac5487d0eda16
change-id: 20260417-james-perf-annotate-assert-20f520eeb35b

Best regards,
-- 
James Clark <james.clark@linaro.org>

