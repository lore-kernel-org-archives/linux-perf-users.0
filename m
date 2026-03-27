Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86292FD1B6
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774587038; cv=none; b=ZkCkzbwE+3IH+DJErC7cpnRty/roFROGbnYDD88KP4UOi9jfGHi2GoxdcyuqGdT3oQgFwd4Tk+5dSThaFeSaNMOVqiqUKZTcghM65s7ZYcQeoT2WFi2yTpgDX+Qx4hKYQcIODTT9DCufJHdLIt2m3j2DphlGvlmpZg11bgijhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774587038; c=relaxed/simple;
	bh=DfeJ5W3UmO04OUchjljISzxHKoIIauxTlO1QcFpAhDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SjX2gDuvc4B09/I5gGsxwB26mvQr1zApkfynYWJ8/QPGIgnYKnaQMs0LPZC7tzdjgbI3rKeVHEj7FLEk+d52CojvkV4gFHzoLorT2RFkQMDcu+PtqGG5VFGDRx4ihUrdmbQ6MTCt9slxZa+yxEczBXhk6j31awOPiZBsxJkYPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0dUkPVg; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0dUkPVg"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12711ec96fbso9768082c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 21:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774587036; x=1775191836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gP9j6nyx4Uc+6s3l2FPs65bP3fpJriQsfiZsovrWcwk=;
        b=i0dUkPVgzChwsvTxxEgx4viZOU7H70O9fv0r6HU0zOCOVqMudky4MH+uioa1lRjS0F
         7c5/19NN6ZelDN4Xsnzw43mv4er+4wBM35HbKBtzgpju4aB55PzbtvMXKgSrnjenGKmY
         ZdtNsasI07kMkt8CYoVvxcXbVjcMzzbamPIOsWnomtQ/m7pfQsQx+SJswgCIfGAgqRgi
         Inaoa/UoUkeSTgoFEdCMy7+iSZJoAIwjenu2RK4IeNMjs1NL8CDRQlXPFdfme5g9hg2N
         FV+wF1Vs/LObCKB6t3vMvWK9xBiInEGK3oaH7K+ty7P5omOXIEj0TEHv74smtfUpawj7
         x8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774587036; x=1775191836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gP9j6nyx4Uc+6s3l2FPs65bP3fpJriQsfiZsovrWcwk=;
        b=J6SWeAg1gYfVZVl7xyOGU1j+yXQUh4XynvK6BWvpKFf4ju3DkMs9SP8ntanjmUXCwa
         GDs6BCL2gpQ+z9uFaGO5GzG8T5cTle/5U+z9jpA7DfYxpsNnEAFZxClUmq4NtWG/KeRT
         PCXCLHQCATvuiA4ElP9qzU+96ZFaGVs8tUByJZk9pJR+mAyp45uRhHdRNwdDwkgepDBr
         ooQYqHXWg3/CQdDNXN1+ecTMxBwpv77JS+oqq/GPgQn4iAz4QBpTrOkuJ0R/2isdBLgl
         2Dsk+lx1piuzzpqzVRNHrWP1GdQ4lA6sdZwcJ2HM1rZler80R5S6KFx2whj52oO/vw0l
         42CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGUpExFDTk1ZZmVtmzuHhRm0f4+5q0D8spdBzKe0I6YqNmK7LUk1sJjUKuiMkYeSyLAj/sxKgafxdjQOucvwLe@vger.kernel.org
X-Gm-Message-State: AOJu0YwDROCgHb3einrkr77I442XljW7Z8/MTTcRp0Lqk+LUfXalz9O7
	2hAmC+l4XXyFtE/1gIWzK2Gmrd/a1SsVYnEXitJ5QiDbMCx1vGbg6w3exMp/k/lYZL1ZJ0Uk+us
	yZNAQJkmscQ==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:121:7afb:490])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eacd:b0:128:d34a:320f
 with SMTP id a92af1059eb24-12ab286c1efmr797254c88.12.1774587035827; Thu, 26
 Mar 2026 21:50:35 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:50:23 -0700
In-Reply-To: <20260326174521.1829203-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174521.1829203-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327045025.2276517-1-irogers@google.com>
Subject: [PATCH v4 0/2] perf symbol/env: ELF machine clean up and lazy idle computation
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a helper to perf_env to compute the e_machine if it is
EM_NONE. Derive the value from the arch string if available. Similarly
derive the arch string from the ELF machine if available, for
consistency. This means perf's arch (machine type) is no longer
determined by uname but set to match that of the perf ELF executable.

Switch the idle computation to the point of use and lazily compute it,
rather than computing it for every symbol. The current only user is
`perf top`. At the point of use the perf_env is available and this can
be used to make sure the idle function computation is machine and
kernel version dependent.

v4: Fix Sashiko issues where an array element wasn't sorted properly,
    the e_flags weren't returned properly, the idle type is change to
    a u8 rather than an enum value and the s390 version check for
    psw_idle is slightly reordered and tweaked.

v3: Properly set up the e_machine coming from the perf_env as reported
    by Honglei Wang.
    https://lore.kernel.org/lkml/20260326174521.1829203-1-irogers@google.com/

v2: Some minor white space clean up:
    https://lore.kernel.org/lkml/20260325161836.1029457-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com/

Ian Rogers (2):
  perf env: Add perf_env__e_machine helper and use in perf_env__arch
  perf symbol: Lazily compute idle and use the perf_env

 tools/perf/builtin-top.c     |   6 +-
 tools/perf/util/env.c        | 185 ++++++++++++++++++++++++++++-------
 tools/perf/util/env.h        |   1 +
 tools/perf/util/session.c    |  14 +--
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/symbol.c     | 104 +++++++++++++-------
 tools/perf/util/symbol.h     |  15 ++-
 7 files changed, 240 insertions(+), 87 deletions(-)

-- 
2.53.0.1018.g2bb0e51243-goog

