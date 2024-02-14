Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6447C14F
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886476; cv=none; b=bhZlyX2abcRroBoFpIkHb3iYz7+UD+INEumiUP0aIsaNviK/Qr8VS/9Jj8xNQPFakl9Pnj2Yzp1qU3bsjTZmoMxXvlLuoNrrli0/iy6ZjuDetvZaGMFuvjB4JRKqMtqGdQFqk5jR6YJYmi9uRI56ZCrHXAJkW21+GiRx4rIJ644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886476; c=relaxed/simple;
	bh=9GvaQ8U/ciyGf0POxeefEusSW20t+DHMSsugj/N6ETY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KXd0EB6GbFEiBbX/ZcW3RVpfO8sBARiA/4vB7pD0PqmW32R2ecgqqn2XK5HXQz5sUkZ/1Ct2pK4ypd6YtSMuqsuFGn2SQ5Xpvgwzo4qT6vypE6uLEhaOEpvSKp2PvP6vAL3pY0M9bccWlsLlvaZ7grMjodTa3EH/cG5C5e7tYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xUNo3MuT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xUNo3MuT"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso2820868276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Feb 2024 20:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707886474; x=1708491274; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6UUwQ6uU0gh1AgBT5LAdlyWuLVQW/eRWP9wNVATd0w=;
        b=xUNo3MuTCHNPNBQSi0iOeCYRhkZNpLcWuhCz+RXhzVfhzxK+TFj5UCTqB1yjMiEgf4
         Y2IG/TsNqIuLvuXhVgwCfrFqkulqkxzpGVoKkvlnkvgmtXb2fvm49DMi+Cx4GsUWHQrZ
         sWYmkj0jSbpPEK9d36KD+H81PqEqLB+Dy2jKJeYw3fZYvAS1ASJvzI4cLcAKXNtG/yUE
         TWjImoL4OLfJtmjCA1uNDwXgoX/RJOZzGnIhuSWn0e/QVWX2zxnobM7lxur5JaxWHXVI
         Q5X5Zf41wd99vLJfhXQ4rztXfxNuf+epH4qJaFXBRbgLreCLKQGyL2o/vWpZP1VeA/E9
         3aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707886474; x=1708491274;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6UUwQ6uU0gh1AgBT5LAdlyWuLVQW/eRWP9wNVATd0w=;
        b=HCVIO5eJFrWYSw63U99B/hVZjvEh1ImfFd2yqYJwvzDHmtgusuwnobNEwleGqEXIkq
         U1TKjo4B5mRO7tyckc3QrxuFV5h0O1giDAbcrkJMOM/gFluHGGidogfLcTW2lm453udo
         29oqqVirV0TiWcx7SbcbEaVtPGcbmEZwMG6WLi41VT/cQs4rSl+9vUzPI2dOaaGKuHTf
         D0Z+cUzkKLrtYpxzKfHaZ60/WswjdTsJnycmcGMWx2bp9KbcQuKwwsRrjhMw4VqTNvvH
         Q2PrMhtBsDF3KQhw0UQuoxyIklM1aEfb6L7wZeJQCmNULtgN/o4tdGyiDkGlrVFuEQ4r
         1Lew==
X-Forwarded-Encrypted: i=1; AJvYcCWtsp4rRPE3N+5uehvrzSNEEDTYvPDphe+Q97+3WC/XiQbhzoLyLwYYZbDkj5ojWTABfaXgV7RbgFD6NMr6+KwQGvou2Xx8I3MucGhTEtmcUg==
X-Gm-Message-State: AOJu0Yyt6AYTGw44TkYPARR2c8TXxBh+O6wrlZE1EJikoIdiS/67vDKn
	tgvdjD4JHJXqPl0A7dPFLTq4zpn7RpOlcWUgMoygNtAm0fZDHNZ6a2ITLYZ0WhGNmrEVKGMR3fY
	a5GOJQw==
X-Google-Smtp-Source: AGHT+IEYhgWjbXFx0sxYnQQnVr7GNh7ZLD+INkja+l1mji2uo3Azkx4WVasjvNd44POf3VLkrK39N5w37xYF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a25:d3c6:0:b0:dc7:6cfa:dc59 with SMTP id
 e189-20020a25d3c6000000b00dc76cfadc59mr50124ybf.4.1707886473857; Tue, 13 Feb
 2024 20:54:33 -0800 (PST)
Date: Tue, 13 Feb 2024 20:53:49 -0800
In-Reply-To: <20240214045356.748330-1-irogers@google.com>
Message-Id: <20240214045356.748330-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214045356.748330-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v4 1/8] perf thread_map: Skip exited threads when scanning /proc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Scanning /proc is inherently racy. Scanning /proc/pid/task within that
is also racy as the pid can terminate. Rather than failing in
__thread_map__new_all_cpus, skip pids for such failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread_map.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index ea3b431b9783..b5f12390c355 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -109,9 +109,10 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
-		if (items <= 0)
-			goto out_free_closedir;
-
+		if (items <= 0) {
+			pr_debug("scandir for %d returned empty, skipping\n", pid);
+			continue;
+		}
 		while (threads->nr + items >= max_threads) {
 			max_threads *= 2;
 			grow = true;
@@ -152,8 +153,6 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	for (i = 0; i < items; i++)
 		zfree(&namelist[i]);
 	free(namelist);
-
-out_free_closedir:
 	zfree(&threads);
 	goto out_closedir;
 }
-- 
2.43.0.687.g38aa6559b0-goog

