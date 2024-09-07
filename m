Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E915ADA7;
	Sat,  7 Sep 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725714622; cv=none; b=F3NcsJkXZBYog6sK545gKPDJ0rET06Ozb6F3xyfg5Ch/7ppy4WoNpUyR+qFQFk9dyP7SRDkC8Fm6HTqS5y5xWjOtGz47vJky+AzDQqmDWsGGJhLsdQ1X2dCKZOpigc+mDyR831JUzghOtiw+zq6QrpwB0qsU5yCp5il79PgOKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725714622; c=relaxed/simple;
	bh=CxPCxWvN8cI6T67bY/RNZ7fNp8GmAqt/ncYb97a2G1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uObm3oaEPElFx9MzUl6vK9YRo+vC0ELj32iaFqeN7wN7/wA+Xojvnp1T6ghu7MtrCsgWhEHAmJ7bFFA5oo9DAe+HAl54/B9cL+QbWIQ9qxrLHbTzScOI9Ynl2JCzhDdC1+x4lnhqhii2p6mJFwAdGGtAv6V2CATQ65WEsX1wYh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYiwctEG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYiwctEG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso24160865e9.0;
        Sat, 07 Sep 2024 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725714619; x=1726319419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SnZ926g9psemexTKOW5FYwYvLAMVycIhWdzHzhBre4A=;
        b=OYiwctEGeqWcDvyeb7inx8u3+UNbkOAuElMDS/rYzvXIz01dt5csYQ2KyPshK29g4k
         iL3sjDFpU/xq4fE3OakPOerpqAVZVnimoNIRY7pw4vEGuB1bo7mwiPwNM2YSj8h7t+LB
         V9/Q0h3uq/f5u9Unkm1V7O0FAVOBou8t33hgdWGyhLyO3++ZrYUG4CldaNZol2oJAeA/
         j3TWxDL2GrHl2b9DfQcVVqzGtF9Bq7mLuwl1M8B9jwRlEajqrihqH3im/aMpuVjc4pDl
         IegcyvhWhY6pdxBic3vU/AxgP2OwqkBG/CK0mH04tT6Kvjlg3gAFbL1V9B9VTdpI2nLa
         +9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725714619; x=1726319419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnZ926g9psemexTKOW5FYwYvLAMVycIhWdzHzhBre4A=;
        b=SzLprqBSizCtb9sqBakCHa9r0HXvqwuI6lwN7S5AYkI/ofOXmWrfSi4Qdodz9JJXov
         OYRk+HOla4aCh97gUHBJtQQHouRnIG4pelTmaJyUgtgsJJyIAVKCko3d0WaQnzo4kvsJ
         iKlGt60kTLWzYV7IyYmj/axoG/sNmgp9NcXsqM/rW9qXy5JbhGmpESgKGo/j00JCVQnf
         oMwFA7j5+UlcAENCKU1SSOsZCyFjyIe3M76m8TiLBar4O4QFCW/hH0h94bnDDH6ZrFMs
         GyIMnGv1Dy/Q9DN4+mVP5AB6n72nLBMjl8jXnvV33wG1pF6IOJcZc/5hTJTMg1ceE3on
         u2lg==
X-Forwarded-Encrypted: i=1; AJvYcCVcF7tZPeGWPjuH6uWlE7RU/Wz9pvCQopApPpYyvUHofyckRqyWUwoj+4D1vcMVkIsGg4wO47lvFFZEu/wL@vger.kernel.org, AJvYcCVkJwBLsldKl8/Ek0JtbD6jgGqww4AnerXGeRv0Di+aZN0jzM86L7ptMK6mmcdqwCXjke8NxRIgdoCoGacCYLbpDg==@vger.kernel.org, AJvYcCXHPLnvMAT2bxGrGKVxNVU4ManHyQSWylEtsP5/2xi0C/jiYoS8kfMVdPq+t6rCL0AzEioa4rVoAjlB6xMoz2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXpsvteFVDpjKLgpWlmwxN5TvtOhuDTEVmNVyXkMBcvZOYXpj
	CJMO62zU20dkeXlQOQf8imAWsyPvpbk8MOvc3MrS7czyM9X1liZG
X-Google-Smtp-Source: AGHT+IH8sPoSI1MlkKkQgd88D2zs4MDzS00EQ3O94oBq2M4RIL+h/FbKuQgMGDgd6hTzGMt/mgH3sg==
X-Received: by 2002:a05:600c:3483:b0:426:5440:854a with SMTP id 5b1f17b1804b1-42c9f97b8abmr41014505e9.1.1725714619042;
        Sat, 07 Sep 2024 06:10:19 -0700 (PDT)
Received: from void.void ([141.226.8.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d35c4sm1391535f8f.87.2024.09.07.06.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 06:10:18 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] perf tools: Fix a typo
Date: Sat,  7 Sep 2024 16:10:01 +0300
Message-ID: <20240907131006.18510-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 tools/perf/builtin-help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index b2a368ae295a..0854d3cd9f6a 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -417,7 +417,7 @@ static void open_html(const char *path)
 static int show_html_page(const char *perf_cmd)
 {
 	const char *page = cmd_to_page(perf_cmd);
-	char *page_path; /* it leaks but we exec bellow */
+	char *page_path; /* it leaks but we exec below */
 
 	if (get_html_page_path(&page_path, page) < 0)
 		return -1;
-- 
2.46.0

