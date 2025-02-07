Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790F1DF25E
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928482; cv=none; b=FLHVQKRWZYHogw/0B4J/cfFkSB+fiWHoibDMYuvUCNJGF235yfYleyi3PrFYl2V426bJSPzPtB/qtQyCxE4Kl/RosThRQVHeMx46CD+0McWfpBXLOR1aBIGELCQut/bqzxuB0VfN3+aNUvCfOwYhZOoEVBl8a+rKrV50piVhVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928482; c=relaxed/simple;
	bh=JrTATGJXLXPnfT36NRdWEwRMkJqStLNhLoyrpg87QNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GfzDa83vfRfixsOe7HJMS+rv4G9aiCDSGDOydxVQzZUCm5Xk6+PnDF0MGIrEYR/HBsxAGZP12MHa7TX6GYvc22Gy5H0CjZfwFhaGkiFe316z/9TvP5kd58O5pKqx1IU81DS50TcBGhEjTmJYSu8HhW/MdVIGHt8gm/DFzGdzaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=na2zzlSX; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="na2zzlSX"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5de4d9cc915so389046a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 03:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738928479; x=1739533279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mjAFE95s2BudHj4Rh3WJBU6cX4YpZYt+tVJ8vz3xHhE=;
        b=na2zzlSXYcHHR4lHoiGdO/j4aWe9LmrbRs6/Ys/1VRZJB7B/xVfTzivc2p7gBHTtre
         FvLpP4SD3NsKMf+r2jne2AeZVnDGidfIfNCLuOeFzk+SMbvQrv/fMbhSQRshvhMwENbF
         CwC2Mw7+MIymbMPMJ2YCiEe8vXkI+RCePs+CLgH0LJxeL7g51vnAlfQ6OJRSFeJnlIiu
         OTMIM9UfUxBC3GACwZ9KiOCYMeS9bGARAn85jF4ZAQh0DXPtc9soasCXoyDDruHGepL+
         BeWGZyNITWbctDfq5fHC5fEoLj7sX4xrOt2QOrw865xZkpDPkRpGYaPyP2sJNBl5vdAZ
         ep2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928479; x=1739533279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjAFE95s2BudHj4Rh3WJBU6cX4YpZYt+tVJ8vz3xHhE=;
        b=Zl/F6mNrZQcXNlk/b1tn9N7t01SYU5U7Qi9q7wwajVEF0bxFP0oBkCfO7/knEv0fao
         bicrlRq2H1VK/1u7vnm7pRUBj6XGOSd+tTinyA01XkmTNLhZxI81pB728/70xTEccSGh
         OWq+P//CKwraOXdXTGNlj0fhZRqCOkMte6dhgdDpq9lzwu3PNgwZNJZdFEID7FJn9765
         htBrWGcQeDqH1yOVHRza9CTLvOl+Qv3lugt+dzk8lYKYv4MyAZ5UooxtUILXMqkJwPVW
         GN5fsCU2U8neiqyaTOMSYhutFTqjTCOR+ir8aleccPKspUrHwfSTwXhfitvSBhe62XxM
         mPMw==
X-Gm-Message-State: AOJu0YyaShfYiwpigjPesx6GXPv640wzFGSvRl0DakDi6/Re1V4w7ix0
	DV0LPAtiQZH0O8/rDCIkzKO31ShB2nMDEL86TuXTgyekKOcalYc5HH1XcaHPVY3K+j5ACF0ZFsm
	lDDKriQ==
X-Google-Smtp-Source: AGHT+IHMCaxJwhN3b35vofvhjLQWUnuYR19i1hbqbz2zViRW2xF8n0bIBTGUvJ0aty3IvlWxGQQSnNt3z9Cv
X-Received: from edat9.prod.google.com ([2002:a05:6402:2409:b0:5dc:de15:859c])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:210e:b0:5dc:ebf3:b967
 with SMTP id 4fb4d7f45d1cf-5de451074f3mr3228263a12.23.1738928479229; Fri, 07
 Feb 2025 03:41:19 -0800 (PST)
Date: Fri,  7 Feb 2025 12:40:30 +0100
In-Reply-To: <cover.1738928210.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738928210.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <b6ec169be9e2827ac417935886b466683775ee03.1738928210.git.dvyukov@google.com>
Subject: [PATCH v6 3/9] perf report: Switch filtered from u8 to u16
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

We already have all u8 bits taken, adding one more filter leads to unpleasant
failure mode, where code compiles w/o warnings, but the last filters silently
don't work. Add a typedef and switch to u16.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/addr_location.h | 3 ++-
 tools/perf/util/hist.c          | 2 +-
 tools/perf/util/hist.h          | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index 36aaa45445f24..f83d74e370b2f 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -3,6 +3,7 @@
 #define __PERF_ADDR_LOCATION 1
 
 #include <linux/types.h>
+#include "hist.h"
 
 struct thread;
 struct maps;
@@ -17,7 +18,7 @@ struct addr_location {
 	const char    *srcline;
 	u64	      addr;
 	char	      level;
-	u8	      filtered;
+	filter_mask_t filtered;
 	u8	      cpumode;
 	s32	      cpu;
 	s32	      socket;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index cafd693568189..6b8f8da8d3b66 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -585,7 +585,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 	return he;
 }
 
-static u8 symbol__parent_filter(const struct symbol *parent)
+static filter_mask_t symbol__parent_filter(const struct symbol *parent)
 {
 	if (symbol_conf.exclude_other && parent == NULL)
 		return 1 << HIST_FILTER__PARENT;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index a6e662d77dc24..4035106a74087 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -33,6 +33,8 @@ enum hist_filter {
 	HIST_FILTER__C2C,
 };
 
+typedef u16 filter_mask_t;
+
 enum hist_column {
 	HISTC_SYMBOL,
 	HISTC_TIME,
@@ -244,7 +246,7 @@ struct hist_entry {
 	bool			leaf;
 
 	char			level;
-	u8			filtered;
+	filter_mask_t		filtered;
 
 	u16			callchain_size;
 	union {
-- 
2.48.1.502.g6dc24dfdaf-goog

