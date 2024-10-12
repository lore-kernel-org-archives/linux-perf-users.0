Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A712CDBA;
	Sat, 12 Oct 2024 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728707333; cv=none; b=hE+0fbfOXKk3+p9D1uAWGa0PQlS6xS3zgYvPbHBUzam7esVLZTJgjw7Xsfo8lW84aNS7lMtGa1ytYKZEw3sGlJWB1OruL9HX5/Yg0HGz6Wdq4KQDpV27LMvP2AoCpJ3kurZu2zw1dWSytShccNPAUi3Jmf5P89CPq/kFQJLjrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728707333; c=relaxed/simple;
	bh=937cJWb+m2WpPB8K0xnw/lEsnWbomlVJgugdRn/M0Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lR+UysCsYqWcMKctGtuqn2jV0Xr+FtYZxgZb49exlwqVLsFH7eVmCFSpRnh24Ncgs3+h+v33afJtDINB1G7ml3yaTQH6UTvWI4Sw4hA4au+i2pvCrmbLfJONppz2QylhdKJAxCuGDuwPyQUgcDjzMKlw0pezvtmFb3KMXP8n22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFvGtgzn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFvGtgzn"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cb89a4e4cso5002545ad.3;
        Fri, 11 Oct 2024 21:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728707331; x=1729312131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9fJCYKdZiwsPnTtqkeuNJILhOhmx49NiKrjpFSsKzU=;
        b=EFvGtgznupQSqNmWTjBkD+okwhC96oYs3Vyj+qZqMYYYxoGyg2tX0KYct+9CVBtVTk
         yr8dwxldFHDWN0HzxGavBH4GGONqpIns74iLlD/rDlkzUVO/sevMdGtstWFfLWPZXi2u
         ctVW0ADf+lP4jocnR6cm6/gQvBG+JUmTIAIyPuDCpnkVbaqxRf1G1HcOzZXOZS2+b0ws
         TOj4yEDMRIcJjCvP32lIFvlbA3q1d/p9CVgoeE1hQ99vAMIPgxSp9P5YmeJ21nqcwJve
         j/4KZnVJqHx8ATTsgY8VUhwvssE0ztQAJj/QseRnRgZc/9y3b3NGYsOxZmpxVhFVswlH
         9esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728707331; x=1729312131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9fJCYKdZiwsPnTtqkeuNJILhOhmx49NiKrjpFSsKzU=;
        b=QatbltSlaFp4bkinMCYeKdhGWYVvVfrWRbjDNQ5TCNOdU+jjDAHsup4Qtw9C51MBdy
         FSWGsDRiN0Y4r7hla9di1oHdjbsP2xJKh6LWYJGdp+F50W1+v2OukykjoMwVN9Gt6YCT
         RjV5ZAAVK8boiYxNbd+Er8qLwSTSQnRcbLSxPvd2IpQyxsZ0iqPIHQtIRZ0/Q4Bv3luC
         Wba6swrKz45lp4IdhQkNSRRbW72HDAQg/sy05oJkxj1fgIeC31YxDhm24Sw4IF8wio9F
         /q8JPflHHP61ZorZoJWIaw4i/Hke9k80pvzaQsFGQSn8GUL+HAqCR/maLWkjRd6O6OHg
         cxOA==
X-Forwarded-Encrypted: i=1; AJvYcCVfxY+fv+wfoil5ROO/mvidL+0vyXCbxYdJ5yGjk3rL5OqwoL0kJ9HwZSofDDV3L2hPqO2ShLJszcVgmOpZ72yI2g==@vger.kernel.org, AJvYcCWH2En5oefFbFlBkII5C8HPK6lQ7B8bDfBh4/tXqWbNBaqXYiCJbAULSj5AhS8Bt8ZxxAFeX6Q03v3+Sww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/Y6DM9e+iqGEfBgKG0KXI1yj8biv0Pcex3/wOkZyipHE7lC/
	KVX9WddzEflIST5CN7WuBr5dfyHZ9VtYLONyxogaDCHLLYazTIKj
X-Google-Smtp-Source: AGHT+IGr3nVAZV99Q+U5OpVjeGw3RTFQiHsnOVfCJnGjWm/Gf6YjY5HKnq1nfVPeP3fWqK9bXxWVfg==
X-Received: by 2002:a17:902:d2ca:b0:20c:9e9b:9614 with SMTP id d9443c01a7336-20ca1454211mr70254195ad.15.1728707331381;
        Fri, 11 Oct 2024 21:28:51 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212fc7sm31017165ad.204.2024.10.11.21.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:28:50 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/3] tools/lib/list_sort: Remove unnecessary header includes
Date: Sat, 12 Oct 2024 12:28:27 +0800
Message-Id: <20241012042828.471614-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012042828.471614-1-visitorckw@gmail.com>
References: <20241012042828.471614-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since lib/list_sort.c no longer requires ARRAY_SIZE() and memset(), the
includes for kernel.h, bug.h, and string.h have been removed.
Similarly, tools/lib/list_sort.c also does not need to include these
headers, so they have been removed as well.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/lib/list_sort.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/list_sort.c b/tools/lib/list_sort.c
index 69affa251fa7..bb99e493dcd1 100644
--- a/tools/lib/list_sort.c
+++ b/tools/lib/list_sort.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
-#include <linux/string.h>
 #include <linux/list_sort.h>
 #include <linux/list.h>
 
-- 
2.34.1

