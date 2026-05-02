Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D21307481
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705217; cv=none; b=cFMAEFmpNwcSz5/VCXIpfw1Q8z5Y7J212ysCjvfK5XNipLDZlLRXealjtNgQk4SHl9Qdgohbz59apzAsT5KRUJ3a1TmILl7OtKcLy7HDzK+JDPnzPe2VYWqu6OkGEUwBt1D1phIjJEICXAks9jFrMsiVY0+CqBf4Vird6ol9Rz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705217; c=relaxed/simple;
	bh=n9VDThrjAF8JIlTeywhHsS3R1i0arT9zN25KGhXQdsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B7Rq/SAYuwJKlbVuV9GV1bmBwEu/UvFgFt5fiMwYu3hwY7tidzXQ1nrYE/3OhubwQ7zMUkcu/t5Fd3dC0yn30kgOqOh0KEuw3KU3UnT2cs3vCfovZb4vpBSX5+mb+1zJEJbcA2ldjDY1HzOEcJtQoBVEFx5AIoGq3vvsLZcwSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpqLsl/V; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpqLsl/V"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so4142740eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705215; x=1778310015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/PPLRcE8lM1cGyL0UzecFUi3MuKZEhavOiWIiPFqzM=;
        b=lpqLsl/VjjMNK4dMEviU/+HZb/AWjZvAIZ3FMbofIiwfPBJ3kyxOclpLzu1aO6iDgC
         yTFpsq/wKTErlVI92wvVOf4hHhomj7WtjFqfmInWvlOBSPccuntpxjnS7LOMvyo7Dxtl
         +1Q75qqNpfE9d8jM3s6yfaxIVxXyVKu56YkcXwFOb150ZJmqIx80StEj5rFaoW8L/6/b
         EfzrnZ8ym6Ta1tKe28z8V0k0oO2JgBTa7b3Z/HzHr7gkerGNYcCgXyP7k5Tq6vUPy3ye
         HaW0r0Yfo7+wmVD5mwz+VdcPRRGHyG2tiXDnji8sQ6M0Pr1V6PhyLuxqhWMST3U8WHpG
         Uu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705215; x=1778310015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/PPLRcE8lM1cGyL0UzecFUi3MuKZEhavOiWIiPFqzM=;
        b=gMBKSltHx5XhSGDIz6jT+c75ypADSiaHTUi9x8qoZfG6ZK7gCrT68uOnLGIJnguynT
         Ib5BlguZqAEn8YhkQKt0Og7GfKIuToiKJG39ttq7ghJDjPRTp+L+jhMSGS/DvC81eQT6
         kCeqMXkEMXfLnQ//0dp7p/HlpVur99nCnyu2GqTpQWVzL+jhjGO/kqUpAYexhg9NZm5v
         dulodMExJOKlA7+y3ZuxrOxmA/9lHQFiZUZBCpqG2xrmaUdm5vQXzHEuuyQGFlxsHKU9
         81bnD69on3w6Gzroef8pKnbOBCvy46vZeu1jgkdO04y5TUKWExt8/983jejnA5UaQOxy
         leYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Z1932es6YU5vDg8mcGVSinYExozDVG/sYNq9YcwrQlIgiYPS/U+k+loLp0CS7dwVj2ltADVW3q7UTC08WrC7O@vger.kernel.org
X-Gm-Message-State: AOJu0YznIZCLESN43ZzN3w/HXKrafnjTLg/Hvm1x+7K4rXR1+U3st1KV
	hkeCOic4DJd7a2XzE5XJUZBkoF/OF6XCtdfPEaK6onhQirUpFgAxEYKOqAJIQxraBHC9tp0quzK
	sEUFtoEd6yg==
X-Received: from dlww3.prod.google.com ([2002:a05:7022:ea23:b0:12b:eb91:8863])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f9e:b0:12a:6fb7:87e7
 with SMTP id a92af1059eb24-12dfd70c736mr1018157c88.0.1777705214884; Sat, 02
 May 2026 00:00:14 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:29 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-12-irogers@google.com>
Subject: [PATCH v8 11/17] perf c2c: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for AARCH64.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 72a7802775ee..09c8352a922c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3202,7 +3202,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	 * default display type.
 	 */
 	if (!display) {
-		if (!strcmp(perf_env__arch(env), "arm64"))
+		if (perf_env__e_machine(env, /*e_flags=*/NULL) == EM_AARCH64)
 			display = "peer";
 		else
 			display = "tot";
-- 
2.54.0.545.g6539524ca2-goog

