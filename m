Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CC01A9B23
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319599; cv=none; b=O1tf/pNuQmqwrZld/Bi/BVT5QIWZouenF4cjc6k7mqq4BwUhcdrav/sFqTzFAB4JjbBqtB43tF1tsAevsH7hZ+voFzTx+PCtWjvt95TYNBo0nM7Avmhqot8REiskxKCH1qVenebs8J+T11/ud112VL7563EJ/5RkRtG5sw6tpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319599; c=relaxed/simple;
	bh=IZMOov6xn3FjVYuQAaC0lPmx7AinCu9M0bXuB0NntJs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qZuiKHa1XpY+vTJfxxfYoQ9TI7f7Ys/EfjyFKz2bWzgZWqcwlNi8QG2uXiXs4qHY8v60lm5OHxjNEDLFuZRZSkM2CWcsb8rQ0Le8B1vx2Hg9v7ZKlSsm8o1kyM07idVwmRsVW2TiYY6elqMNWLaS4+s9Yw7jN6esu74XFkWYPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HE6oqqqU; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HE6oqqqU"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d0b5036394so7945336a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 22:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736319596; x=1736924396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1q62ua4ETuDv0nDfWH3IGj61xO4zPIGpATfa2OFDI2Y=;
        b=HE6oqqqUfJyStve4H1die0ZrlMjc5rDeWRSdZv6pL6i6D7F34CfeB0cFuOMYhr3oPt
         8T+5cTeq6L38n1aB55WXE/pYW+96Z6Gwg+7VwhNPRgTZHQoymGovpiuHVrJ0WbIsJ5cG
         KHpJ3NHwYF/o49KRBbG1y8H4CwdlI1rCKpmV7vo4QpJRQeNLccxTrrALCCIj97xqS04o
         TagL7EuXBfI1FhPNpm8BqzfH2iWsS2CU3SknCHmPzG54Iix2vHtGqwmFP5ImArt7iHun
         6LBzEf75eckQkj+UWDgf3/tsBAj/D6t5ycn6xnq/SGkgJnGmyDtfoD9bauJu4DsSSjHj
         LacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319596; x=1736924396;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1q62ua4ETuDv0nDfWH3IGj61xO4zPIGpATfa2OFDI2Y=;
        b=bd7uofONts6PtCRju+G8EVtv4PRov1eQckw34ohUGWIaIhvZRh9Yny/1c3mDB8N1NU
         MHpH+W/iZCsyXZggCDRtFgTDLWJ7jYL7+75wF9i4GzA2blPwWphajlQZqxRUP0pZQSBh
         05gi+5zxo3cMXuIe23V4cypxpHw61/oEN6dEYNatuEXES/iTrUuKZKJi8hFetiE33pG2
         PnJ3LoAvEWXohi11ZcOKEWeChd8JBflzwQH2PZ7J0V2QyjYJER6qg/RWSzjFq/twBHFq
         gU3AvsOFQxyAdBQAV5v4VeTlPbc3Zlk2KG3W4QHeTBdxOnFHoLsAjdMaofKwEdNCmf7+
         FROQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkqtTOlNkSLd1aOI/ZSf7GegKZtH0Phxpey5gQEOJJxDvWl/Veju9zrIzS7HoPXj+h8ZTpi6VRyjIXheYaZTJS@vger.kernel.org
X-Gm-Message-State: AOJu0YwikjOeDsoFn3eXtIyNDM+xhcLB3TZoJaob4LQSC2qVxlgjSjID
	yzAzcVabLMVDExO74ONyM/Cp0FS8pT1ARAzqLEanBuAXWF2IiXN4KxqwV+u/AqXG+6oD8XMZCNg
	UIyQbJQ==
X-Google-Smtp-Source: AGHT+IFvZjaybIQly9Y3xkx817efsDVmdjlVKo7NQCNpySmmu1PxrGxcqBDsPhYRWEyR50YkY31LezJufidJ
X-Received: from edbin6.prod.google.com ([2002:a05:6402:2086:b0:5d3:e9e4:d2f2])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:35d5:b0:5d1:2440:9ad3
 with SMTP id 4fb4d7f45d1cf-5d972e703e5mr1241968a12.30.1736319596797; Tue, 07
 Jan 2025 22:59:56 -0800 (PST)
Date: Wed,  8 Jan 2025 07:59:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108065949.235718-1-dvyukov@google.com>
Subject: [PATCH] perf hist: Fix width calculation in hpp__fmt()
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hpp__width_fn() round up width to length of the field name,
hpp__fmt() should do it too. Otherwise, the numbers may
end up unaligned if the field name is long.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/ui/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index e5491995adf08..34fda1d5eccb4 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -121,7 +121,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	     const char *fmtstr, hpp_snprint_fn print_fn,
 	     enum perf_hpp_fmt_type fmtype)
 {
-	int len = fmt->user_len ?: fmt->len;
+	int len = max(fmt->user_len ?: fmt->len, (int)strlen(fmt->name));
 
 	if (symbol_conf.field_sep) {
 		return __hpp__fmt(hpp, he, get_field, fmtstr, 1,

base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
-- 
2.47.1.613.gc27f4b7a9f-goog

