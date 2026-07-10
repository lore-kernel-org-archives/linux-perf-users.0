Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11D282F14
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651802; cv=none; b=N8VTdHYIUuVtLTO5HhQtHy9FcFPORGgaUjlvTtb5ttsLitjvy9Z7nLGLcSidwgV1iPlrCaquJrxql+AHY/cIpmpX/yOzQd6f/ViU85CcM9QkawOzsWqC6HrKyrizEsF+biTv6Y5gLKrhdnssSrltroPzVx3ZhQLZX4ROKAtZPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651802; c=relaxed/simple;
	bh=F9bsi5gmrABsimqKHKAnTCPLU1ZQh9edHya4BHnR46g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JOBbUz1JHiUNJESDcCLu4SlztnXirZY0KXGTtKCLI+M3nyQZXjhCyxgNi1TLLpShc/InSjISk7iNar6HOHJXm02Y8d0OkA2ODiDyKBH9we+RT3Ihf118HwhMbkOJQb5LlNVQ6zJI6ZhZDTgPPUYwcZqOJSp38kj07+RZvZTiEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BzlKiWkn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzlKiWkn"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso426596a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 19:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783651801; x=1784256601; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iThmDMaR2TxWI3wcTanse6PaOId5XouXPwzSrC3HYfM=;
        b=BzlKiWkn6FLApzIspVVLtj51VJjJhw55pIT2ya13iZylnL7+hZrrK2M0swEYeUMeiQ
         jF6rXrEswU67ZqDMjYxCrAmqWHlGYGiOUNo/Tt/xhIlOK4uK/+qudExo/WRrp+W8louO
         ZlauTOW6RAU7mVtKgZpEMKK280mpRrQgXywduIvORDPqHOWq3L4IjxFIz50XYRQdlARu
         oTZJ4OPqWvfp3dOG9MG2RhKw4fqA61a4DrGCR9tsFtiXBJ5mbIO3Iy+8DZcoaH3rEHe/
         mjisEwZIa1cutBwuaIWFHlvVDTp+rkiJXHEyGDsHjF0SXv5HJRbZ7GyjISFyNIg+JNHw
         MESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651801; x=1784256601;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iThmDMaR2TxWI3wcTanse6PaOId5XouXPwzSrC3HYfM=;
        b=WWr+PifFBAukzrf2ZiHACREw5mTjI7Jh1NzYJPBWVmk8UEgaSBAlhbtZJaNL3y3QSm
         j9OjWk+piJAIVlOksG4rBP4XP3M5eKVeHn60E5vP6LZ5q7IH9CE/vEX4u2xiA9RTA6oj
         VpxhtSXo50tBX5cx0bzuPihn7B1Gw0biax6j5+ettrWr9etabTIrOEKGkGzXvPVR/KCR
         Sj7E4zcGRBJeY9vnBYRSe8wmmp6IkC5DT573KavdgUHjnNfjSTlexdgT6ghreyjtxMvs
         nNC6rkVMfSeiceq+55IxGVFFxJFqWWEU+EdMTkaKxwA2/ps34kmTzhPJcbgJRERflZkS
         +zXA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6lR87+LNOx4XStpdQCNWMiv2PLnNItkCWda84uhVwB1Qg1e79HJi6PuUM8JXWdHaPZG1GS2n4OE9wCA52OL3V@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLWh4+hdnUZNmnhuYhXour/StDFjgJFIwG13y120kgSbEjMCl
	hVWwPGTrvUyfky0lS1Lzp0AVBkFUjQPPayQ1G4XJ5bAy4l+HIvEFA9vhExU4dhjrPHwTpra7sNs
	VsdZfjpUTFw==
X-Received: from dldyq11-n1.prod.google.com ([2002:a05:701b:454b:10b0:139:c8ec:c97d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b02:b0:39f:59c8:f302
 with SMTP id adf61e73a8af0-3c0bcb7e40dmr11617570637.37.1783651800898; Thu, 09
 Jul 2026 19:50:00 -0700 (PDT)
Date: Thu,  9 Jul 2026 19:49:44 -0700
In-Reply-To: <20260709165220.1411149-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709165220.1411149-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710024952.1668911-1-irogers@google.com>
Subject: [PATCH v4 1/9] perf hists browser: Increase MAX_OPTIONS to prevent
 stack buffer overflow
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com, sashiko-bot <sashiko-bot@kernel.org>
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

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
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
2.55.0.795.g602f6c329a-goog

