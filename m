Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E5388369
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661807; cv=none; b=HqTf6OkV3p83IsWqQ5H1EPBw1PfQt68KPufLpH0wHXjcXi3XtI2cRA8gCxfayYQVxFU6evO238q2qAK6J2yOF2Yw1iwTR8V/wgPZQfdFAMOVvA4iJAHlPPiJU0v+b0OPQodXztP8CgR8jpyMVnUk7UmpkIhLEuqz8oEDfI4w9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661807; c=relaxed/simple;
	bh=S6sIYjE/pDY3/PigUzvo7fO1UxZJC43MESyjtHoyGs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LGPvqQtrhDruCpzz1siUfDjc90T9MKIg8Sf0xKASMw5u8Lr3lkUInn7oxJAi2VF07YoOC+pP99DvgE8vXMq241TtjciF+1NxfZtT26Yj1PaNeLhEgnDw5e47Z2LN53W0X1iEt4A85YV1LcBKRKyd9VVbx/cxOqg+t3FziB9+enI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTz+2fmy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTz+2fmy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3881937456bso1108512a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661800; x=1784266600; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BArQ92G2DUTyeOnLffLjz+dJxeKrEe+mx3QwI0NTlvI=;
        b=dTz+2fmyumOTOzFHjI/DU5w7WfpvaunkQApNUDYM1VbbCsn3tpY9XdZ5BByvE/n1lB
         HfoZZHe2xZWj/buvivGiQp+JcdGkFdV+oW2gDS3JVJS7jQzeWsAlMscuQ66EqKG2WIqw
         iqD7neFGqA1glJullrDsF1pcHgeX6RDQ8kibqkpWBy4ErgUtkWfF0fb1bD7AZcC+99n9
         172adbSZy1vLFodQ7XJC17XlbICjPXmYVn72/AXvelwaEqe85j00X+eMl0MhWIWDPoqQ
         j86hKiBVDufIDd6e7m4XBP5ssX/RKtWrLjVgZe3wwKIT8QGKc6+WpdGOyJ/XaQja+kgf
         5n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661800; x=1784266600;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BArQ92G2DUTyeOnLffLjz+dJxeKrEe+mx3QwI0NTlvI=;
        b=a9phSO1HQdlgXff4V3nPu6z7IZIcAPSf7x1sW16nZ1z+8MdAvnTTxJvoybSeXh1yJV
         jLnmwDWzItV+p1LVv/YAIwU50OEHLzH99/FVoLF1FPads19x8vYw5OUxHC6qjTi8KUSb
         mTgqzW79wV5iaV5N/vaV7jUk6Uu42ls9EHNhmgUPJQUTjq+zX8ckez43mnBRBOHxm1J3
         IMYcNGjSiSBTGNQV03YkJhM0b3HRW0WQoHkMQDBg+rW3pUjm++iwwDhtMREQUAL3WUG8
         Du1DQoyNUgdHCLZqJ4FR8dr0aeTincGV99WMyQZQkB/aTIuY2N4JH27Jf3n26xfnCLnz
         aLZg==
X-Forwarded-Encrypted: i=1; AHgh+RoB0DTh66s+cyZdyI7zcoSVgGqPn9XmkWu6cQLlS6N1au+FUoVVtHzdn13M9bMBIJies1tObsQQFkLijT2O/e6j@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpxwkChkb+ShevJB01oqSjE8+0Lpjdme9xf+XzlzVo9j1BU8d
	C5yISKE3E+isRsYrlwNE1gc52YSg3LEpUgzkZt1M1WEOiavUzN5me5cAhLT4A1BfK0MW+JI8gBC
	ZRxEi/rtpaQ==
X-Received: from dybb17.prod.google.com ([2002:a05:693c:6091:b0:30c:1aab:2586])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:562b:b0:37f:a913:1554
 with SMTP id 98e67ed59e1d1-38d1596cd89mr2274052a91.16.1783661800233; Thu, 09
 Jul 2026 22:36:40 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:22 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com> <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-4-irogers@google.com>
Subject: [PATCH v5 04/10] perf ui hists: Fix stack use-after-return in symbol_filter_str
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In evsel__hists_browse(), the local stack array 'buf' is assigned
directly to the persistent 'hists->symbol_filter_str' pointer. When the
browser returns or is exited, this dangling pointer remains active in
the 'hists' struct and is read asynchronously by the perf top background
timer, triggering a stack use-after-return.

Fix it by properly duplicating the input string using strdup(), safely
invoking zfree() to prevent memory leaks when overwriting, and cleanly
resetting and freeing the symbol filter string upon exiting the browser.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 9a3844dc3246..675910893644 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3213,7 +3213,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					"To remove the filter later, press / + ENTER.",
 					buf, "ENTER: OK, ESC: Cancel",
 					delay_secs * 2) == K_ENTER) {
-				hists->symbol_filter_str = *buf ? buf : NULL;
+				char *new_filter = *buf ? strdup(buf) : NULL;
+
+				zfree(&hists->symbol_filter_str);
+				hists->symbol_filter_str = new_filter;
 				hists__filter_by_symbol(hists);
 				hist_browser__reset(browser);
 			}
@@ -3447,6 +3450,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	}
 out_free_stack:
 	pstack__delete(browser->pstack);
+	zfree(&hists->symbol_filter_str);
+	hists__filter_by_symbol(hists);
 out:
 	hist_browser__delete(browser);
 	free_popup_options(options, MAX_OPTIONS);
-- 
2.55.0.795.g602f6c329a-goog

