Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F2165F01
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990736; cv=none; b=KMlLsH/WnLYqrFcw7bX7LU0gU2xTIKWyVJcvraptbhrcYOR///oDQuoaxw8Kds59GOE3u7b7xf4c1I+Ob6OqrzACyvdn5CVEKCEtFp2Zok5BdMaHOBzm3NwUZhmBKw6RaoAmBBcexlEKM7NaJkTm0XRqutDMj0Nk/5dp3G8eT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990736; c=relaxed/simple;
	bh=yqB0/GPRcQDx/x2Af/mlqf6+hKzIMv4AZqz43FGoaOQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Q8bsIOln2OQhR+XE5qzw37Lw3XHlyOn3GMMhekEvwT9Md+vaUX/CVlJVqmEu2zhbGd4m12YoGEwqtueInxypa4BSI+GgS5Pg8f9MxwppTEUFGTEpR88dtfHzeVI52vGHp8d9N73zDYIvEpWCSe/9rpDVg3QcxgWvSA9/g9Mv+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ztxe7jyg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ztxe7jyg"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef35527569so3718697b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 00:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733990734; x=1734595534; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xx8jjmLWLaNrzTLWOTiBT3mcX72ApM29yyW3EYU8tWc=;
        b=Ztxe7jyg23+YM0A4Sb3iX8lUH1LtJ3dAu1Qxqrq8xhHd3PWeR6tWLBLmil4+W+vcWS
         PO9DeLkQK8mEMH92gtACl/kiLvmAzf5w7rLGQ0F7sCD+JBrw/ixumZI4oNr24xsKtRZW
         9EDFxgREneH07bUGi5ztEuGWUNgg4zXkrnitLugjdCO6g0asKlhmjHqBr6SIQgRjn7vB
         smpBUWlk8+nY1eWB3Tv557egJeetBi5PSRVBG7YuhBHpPR2nnhL7w8QjHDiAi++pHyqu
         5H7SGNCbxKZGhZU8jsS34Hb9kH5BKSdx93zA7xNIurlVnXwSRH59afGR3kgDncNt1W7z
         mpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990734; x=1734595534;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xx8jjmLWLaNrzTLWOTiBT3mcX72ApM29yyW3EYU8tWc=;
        b=nUXJRXOOcwYkEgXwhj1lgUIQNrxLSFDXVBrCMUz0RosTbA3d7QDCt+BeIUE1caC4qY
         A9Z6v5JtuobyB6RoTA2WwILsyHMYqRV7tpaakBw/VM4xjdVKRh0ZHfpyoRuXvYZk/WPI
         hNEy6InXqQ0dPm/lPqwR8s00ptGio1brtGzU0cVZzCUMnfhGW636jkd0+9QewZGk6mGj
         wqNVEAl9goiz5YCzUWjoGJf7FFh0vgcyIcr5sR5I+rNUCQgBAJwoSJ58a+UXDivd8g1c
         FsQgp6PqM5yn49gxAuQSZ7cshhUYYtNMNUiho4RzSQ6EFCteqrg0qFjaic6Aj3t0g/Zz
         OehQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1rho2jzrw972sAgMPyD/kXekCN98Cici0A1p088fiRSzKlvqtLHUAEJd0lTsWNx0/E6mE8yQJNr1y25bCM9XP@vger.kernel.org
X-Gm-Message-State: AOJu0YwAcoxM+2Xdz+6dlGqdA9sxVJTWbRdHja+xKmWqDpeRuqEM441q
	uk2tTR+WnYVlanze3v+EmnGrtYjEOJAi4DULL84olTH/KffAxtr8RHzJNARK8MaV5GyW+VNo9/Z
	vY/Rrbw==
X-Google-Smtp-Source: AGHT+IESbMp1bRdGyzcWTColyA4uyZXvAYYXGzuS3Kl3isywfeiyDfYWMaodiV5KNSAdllszta0WfMhw37SQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c22f:1975:e7cf:849c])
 (user=irogers job=sendgmr) by 2002:a25:3611:0:b0:e39:95b8:a83b with SMTP id
 3f1490d57ef6-e3da21d5616mr1623276.7.1733990733836; Thu, 12 Dec 2024 00:05:33
 -0800 (PST)
Date: Thu, 12 Dec 2024 00:05:28 -0800
Message-Id: <20241212080530.1329601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 1/3] perf synthetic-events: Ensure features are aligned
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Features like hostname have arbitrary size and break the assumed
8-byte alignment of perf events. Pad all feature events until 8-byte
alignment is restored.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index f8ac2ac2da45..5b14244253b5 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2401,6 +2401,11 @@ int perf_event__synthesize_features(const struct perf_tool *tool, struct perf_se
 			pr_debug("Error writing feature\n");
 			continue;
 		}
+		while (PERF_ALIGN(ff.offset, sizeof(u64)) != ff.offset) {
+			char c = 0;
+
+			do_write(&ff, &c, 1);
+		}
 		/* ff.buf may have changed due to realloc in do_write() */
 		fe = ff.buf;
 		memset(fe, 0, sizeof(*fe));
-- 
2.47.1.613.gc27f4b7a9f-goog

