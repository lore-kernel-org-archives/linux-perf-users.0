Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FB02063C1
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459477; cv=none; b=uDylujQSzVgNoj8h4BIlc/R/J0SCDNrV3Vg3rqNM1UbNm6ZneZja6H2IXdAwq+PxGwxp2fVB3Q2ZCBO0soPaNaKTOpf763swoZcr45rxM/cGbQ/sEsyl/4OMwxXTRI+KAzfXIHWkbmi+IIJ798GoQpG6T3FUXVBnY9IIV/FXALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459477; c=relaxed/simple;
	bh=rb3nJ50Qx6Av0jjPKM4BDhZRCZf5SaYdGkra8TgFlyQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KcHp2+uKE+cXInY4ANgCvtVpsEm1lF7h+fWc2CMYjkFiy56suM9rLn5+dugGbEbGXnGBJwdp4GKQeJjZVLlGOHVlcl3honplOETMMeXGkFik2XFMGsKCM1u9mAPWnmfVSdQLKobtpvJbQam+EAyMMVswoq17n80SDHqndcdjpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWGMevKH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWGMevKH"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e549c458692so3497513276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 13:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736459474; x=1737064274; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XY2zs0NTwgAFtZHHxTu56AgcGBqwz9PeDUjhHd39VYk=;
        b=mWGMevKH6ra1j6yZuIfMmMTdudhmhnUbn7AYy/8L23tXS7ET4Ba54hd+fuKBOs4irH
         xZq+8HTr8M1LGQOBXIV6o/ShZGaq+DJyh11MkO94nLdRz6gCYqanqr6W1sVDaSwIythL
         R/vbdli/S2alihy5LI7fB2yv32JRGDS7gFGu1XzLRlqSHbP/sKNg2nKCdORiRSjRszO5
         rFr2W7KX5ez+QodArSPWZBbWqHJxG09girQYnVjociOVFOaeruYsgVNTjz5jiPn2i3A8
         qvxmThy4KmLLBIVL5Xp9Dy16VwgkIQMVcBQWKg9sfnnfiYQ98X6/HLf0xSqN2skmr1OY
         9iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736459474; x=1737064274;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XY2zs0NTwgAFtZHHxTu56AgcGBqwz9PeDUjhHd39VYk=;
        b=OCzFEB5sSB+LzlIj615LCfrUzzuXCSFkMB/Ehgblgl0z1sKwnEo9uqiDSXitun8076
         oI7czQqWyAeW15RcdYIAq0UaHzc6E0MYAm8rXV3jE84BVAoFGBthOc3gawFFjuYH+z+Z
         sTtAaKkomq6kZjM/0LDrcP5x6ERgQpltsWnttgOJPGQFs0ThDjNypTSX+YWyj/seOoiT
         CHoBi/t2gF7XcoHp+mItP8IxPiVm34Rl6Q2hP/+xovek3lw4R8XfJjaAjbLW0C8RzSYr
         Kqr487+JIPUG2O1j9N1W+Yf/AhwJKOBHoXTiERS8fRypi13HjKDiKPNnAJZmbMCtFMAm
         JJIg==
X-Forwarded-Encrypted: i=1; AJvYcCXEL0cl29R0jWu33pO3ZcD5jI5AWH+UuC4XpMBDjeYen9f9QSjd47pGuADw8FWJSOlsvyP+5GD2Bby/mSgjgIbT@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsGxsnnsEebgqH1MLgxrR5Dkigl0OXyXXBWCEUNVGtw6UQqzz
	MPzxF7rtg3rspG/fHQuJSs1RrFhvJxLwvu2EDqixB659/2mJPJ+ynKkzLtpmI4nr/yQVKYRqdLp
	GYTBDMA==
X-Google-Smtp-Source: AGHT+IH2qwOcfHH2bK3OckucCWIEdi7YApF7/mRchMh0i7t2VufuaD66SsX539TxewHKkwJtAR5ode736gWi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:ce08:0:b0:e46:91aa:992a with SMTP id
 3f1490d57ef6-e54edf44475mr17922276.4.1736459474673; Thu, 09 Jan 2025 13:51:14
 -0800 (PST)
Date: Thu,  9 Jan 2025 13:50:55 -0800
In-Reply-To: <20250109215055.454888-1-irogers@google.com>
Message-Id: <20250109215055.454888-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109215055.454888-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 5/5] perf test: Improve verbose documentation
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a little more detail on the output expectations for each verbose
level.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-test.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 85f868c324ff..32da0d1fa86a 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -28,8 +28,11 @@ OPTIONS
 	Tests to skip (comma separated numeric list).
 
 -v::
+-vv::
+-vvv::
 --verbose::
-	Be more verbose.
+	With a single '-v', verbose level 1, only failing test output
+	is displayed. With '-vv' and higher all test output is shown.
 
 -S::
 --sequential::
-- 
2.47.1.613.gc27f4b7a9f-goog

