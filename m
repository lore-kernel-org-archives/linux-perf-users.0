Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976B25335F
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379399; cv=none; b=COuo+rXYoWzil3OfkeStwESyZV1BKGBf2Kls4MImXD0vNIUsjO6WaY7X+tkE5RLOZSv/epxN6TjjLPMUCnWKx9cP+kQCAx2wpGa0CLvGWHH0n4iWTRgRly0j1MKU4Njur47bO/2Cww5bFZuzUwCbcpv4Es8uyk6AHQlRF/2IPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379399; c=relaxed/simple;
	bh=73qH9kupjcKo/+QCqWZum12a/i6EIIrJ8vVYr/mhaM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OOLKDlX8Tfd2NR9VPSW3PLTmik0+oS/1GzGh1rW7qnESqOi3SZT2YYtIRlzflZR+EJ9BN89DGvjNC6vQ8fgnSI8He2FKy5ZQCWeuXKuSMvNQZHjVWGsf2lGv4pyljk0IBja1lQKW2WA28VWYhWpxrzJOHQ1W4rInFvoqHdfL0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YrkSzn/Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrkSzn/Q"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso20199285e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742379396; x=1742984196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTPIZGzjZ0/Ur1/7O/E76kCbNyjmi3E/Bqq7iXSjCV4=;
        b=YrkSzn/QWbxkyfLSwlvkPImsRpGMC5ksyEgysiDQ2vZCmppYrlZ2CMR19XPIM7hhWl
         fRcxzTOQms+f112wlZuvjkSGjgB6CpbXxyB3vgucV/+MwAmquF5sxFwYA/DsiCJl1HTq
         097ks7e3RLsRbY3kWglk5skOL0pw59NEbkQxsaZT9QFfDmYE2R6sfRwaCvs6AOIeYsiQ
         XlHF2J30eZ86ctvkgQnMbAOIdHWylOn4yuv+1FwyIRiVadj9oUGDHVxCgXGKgLPvSewT
         odqQyX2aF9FU1OL1T0kttXZomMoyCLQck8vRceH3fQyAmWn3Fb+zzoDVXmccuFUcKyGh
         SAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379396; x=1742984196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTPIZGzjZ0/Ur1/7O/E76kCbNyjmi3E/Bqq7iXSjCV4=;
        b=aW4PqOswptRIrlrbhmAKgWGY7d1OANCv6mfnNBRK3MLNdriZa7ABPv95VpoJPwiQpR
         F0B/lk+jH6Hg9jHZlkSgJBwbXdys5Zmb8m6Dzorm7mb1kVyKmfocx//iySNqmGSqzrSj
         qPJBBiiKygg3CFnU9Rb57AE1h6ChNbeS5AmHM6+58WHyxVLeNVJVzL9QHAqaH5QQPrzJ
         mNSppDpq+ItlzKioLiYW1C+FAD4+Wqf64/jYzXrW9yv+DdnOvPJ1fUOt0KGY8W262OL8
         GXozHp+R3G2n4AiLG1bDPhKKquZTwF2cIuk8vCISlbjqnOPO4usIhn91uOPzGSEPZk8V
         8sGQ==
X-Gm-Message-State: AOJu0YwvjP75XZevYjw+Xculqyb+vd2JTC2Vag/qsdKeevxEXW7jEvoG
	MW5+4C0e9ULF8VreC34MB5O/GW4uq7kleuSJJyr+MakW3QpbMr5P7qQMmwUsFHekyz9NtuOGsM9
	B
X-Gm-Gg: ASbGncsFjr4dkydJFzGdJBYQMPisa+uhJS7pJ+kwaZndongWLeRsPyL8n4Pal0EoJPT
	bJW08vgQbZgYuVLNjf1stX5ZXd1xgZ8kgkC49S12yy4ncAM70PsiLFkLsFMHRdBlg4Rd9mBbk5e
	UXBtpX15eAcwZEmxQqJoqBiH679vvbHNumQh8TWPIcJVb5DO2J/52kJKEF7cYU7h7xU1Gn7Vw8Q
	UgBxO9bUo7i5ws4VYCONjFJXVbNZrNSbpjONlA/pHYh+yQZ5WSbTqvJ82/bReZN+QlbVXbLdvhQ
	o9WAFwHixmJ8WWBMdtmyjGUF3uPLViRNCI5Q96dgotiz7kjZtnh/QcpdSQ==
X-Google-Smtp-Source: AGHT+IGidbRkyN4fpsX8yXNIbim2xYIaPUHPGDKY9qwe4rkB267sscnqlloGOWlyhqEXPwPJpvgswg==
X-Received: by 2002:a05:600c:3c87:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-43d43869a27mr11135355e9.28.1742379395971;
        Wed, 19 Mar 2025 03:16:35 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f43e35sm14302995e9.14.2025.03.19.03.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:16:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: intel-tpebs: Fix incorrect usage of zfree()
Date: Wed, 19 Mar 2025 10:16:10 +0000
Message-Id: <20250319101614.190922-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zfree() requires an address otherwise it frees what's in name, rather
than name itself. Pass the address of name to fix it.

This was the only incorrect occurrence in Perf found using a search.

Fixes: 8db5cabcf1b6 ("perf stat: Fork and launch 'perf record' when 'perf stat' needs to get retire latency value for a metric.")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/intel-tpebs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 50a3c3e07160..2c421b475b3b 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -254,7 +254,7 @@ int tpebs_start(struct evlist *evsel_list)
 		new = zalloc(sizeof(*new));
 		if (!new) {
 			ret = -1;
-			zfree(name);
+			zfree(&name);
 			goto err;
 		}
 		new->name = name;
-- 
2.34.1

