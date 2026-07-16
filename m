Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CE3ACA5F
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186645; cv=none; b=m/fYW0nBlZtEczH50oSfGIUzUbO4yNEUU4WjR7p7ukGLdmCnVdT9pPPvVG306yafTtmAuHotQekEebIWY3GC+N8WGx5VRBYcZThuBLyRZCenSN3ZDXwTR4MppwPmI8alrxJvrgX1kOq9dilBfWQm+LfPQ8ue1tAVGtCz1cX/SEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186645; c=relaxed/simple;
	bh=grjfyAzhj01LugUdX4Xx8qAky4s5ZlYXmPvi5hL2lYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J4/EyPUhuZonNSt6wimjO9q6vwWpBC+XW81Qq48CUvu5fZQ2CfWIKQoJdSs/uHAarjxpy0hIOuk923hAge4g4DxsATmV6HnvkHVQOkVNDzqKJ/dQIEwSMhVTTVbHmsfYscYTGWEZMECBJ41T/FJq+eimjOdW2EWWze+obhCbDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CsXgaU4W; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CsXgaU4W"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so9261852a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186636; x=1784791436; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7wA93UUp+mbcOvaVYThkNJ7ykXQl4HGxM7Jc6T2lcZo=;
        b=CsXgaU4WXHBUBAOzivsYMpWeAJ4EgOSdeYvlgLjU947stFhM7mYYBVqBqgj3Zqtmze
         xeb/g5IJoyd1jpk4g+Y5EQhghc95mlcrvbbaLTRuzNqT0rIio7KGJTXGy3ULrZI7JRAq
         jPzJ8V8gzd39kn23t5BIPUb5GC/Tt2FiShZgqWdlfkcVQgHNXuf578+8R+5tUojiemjs
         FQ+Eszcb2gLSCGYvDdoJt5/0hudNi3cpaJaqdw8AiY2jjUuR1hlF1gDG5JPERfUxDsIE
         tDVEKE0+6SiuM9Z+AS+if4tiPzt9sq82eItHDifta7Uq+oAKvDeESqjZUkl5SxHKqsaT
         gYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186636; x=1784791436;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wA93UUp+mbcOvaVYThkNJ7ykXQl4HGxM7Jc6T2lcZo=;
        b=WdE9yFdDeqz/bJe6Vp1V5mkPrRIWV3xnlVD+YLgTEMsi9EnFaPMdcCTzkwm75EjFLI
         HX/mEM86fTkH1vHZ6qJ9DssdYMrQAiNvFqdvBfDcKIt0DAtfOAVko5P2uCX32DM9Rkjs
         zxRGaOIwHfPPt8HN3uu8vYIERBm1yt8ScXtAZqkHr/XK88emRycdJhkhz+oCal8QXXiJ
         KJkhXxK5oPclZShjnHQWxWpDh+HfY9sgxezTAtjVmPhGYCHOaK+l4KCB0uFiHH5M+54Z
         rZNCd4evHOXI+2NEMBpieSP2JkShCFF7Hae1tcgHrjgw9XuFPDSYfVKoomfK+IWkbdiF
         yqsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqs2sSEgZ6n39XDlsmCdCtDr7Xn+kllqb0PVQV749zwudybpZO92XsU31UJK/4kMiPip4DqbpbMOr5E0GWZczOP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GBdUDKffF3b6DZwMFTN0IEMI/Z0Vk4Put5KKbn7Z2B0+GrTm
	UHzk++NSPDD9RZLMB0uQ1pDu+LkD2mITFxGWbsC8o1m90pThDczK1hiLwcdqD0Ne3Pog59J+4bb
	6iIG3qwNN5g==
X-Received: from dycai12.prod.google.com ([2002:a05:7300:fb0c:b0:311:afe7:27])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7352:b0:3b4:8880:2089
 with SMTP id adf61e73a8af0-3c356fec016mr10532237637.16.1784186636080; Thu, 16
 Jul 2026 00:23:56 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:42 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-1-irogers@google.com>
Subject: [PATCH v6 01/10] perf hists browser: Increase MAX_OPTIONS to prevent
 stack buffer overflow
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In evsel__hists_browse(), the 'options' and 'actions' arrays are
statically allocated on the stack with a size of MAX_OPTIONS (16).
Further down, the function sequentially calls several add_*_opt()
functions, which increment nr_options without bounds checking.

Depending on the context (e.g., branch mode, scripting, annotations),
the sum of added options can theoretically exceed 16 (potentially
reaching up to ~19). This could lead to a stack buffer overflow.

Increase MAX_OPTIONS to 32 to safely accommodate the maximum possible
number of options without risking an overflow.

Closes: https://lore.kernel.org/linux-perf-users/20260708235834.3FB771F00A3A@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index da7cc195b9f4..6163cc3ace27 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3003,7 +3003,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env);
 	struct branch_info *bi = NULL;
-#define MAX_OPTIONS  16
+#define MAX_OPTIONS  32
 	char *options[MAX_OPTIONS];
 	struct popup_action actions[MAX_OPTIONS];
 	int nr_options = 0;
-- 
2.55.0.141.g00534a21ce-goog

