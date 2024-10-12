Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFC13212B;
	Sat, 12 Oct 2024 04:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728707328; cv=none; b=rjOREBRZWaIAHpxtrlQPoLvaBFqYsRLp5JOxI+gsbMkcCjI2ARLRhQ8w677X+5aAEAlz/yumT+Ep//8UGNBHS5hbP6o5xM1nGAk1HIRbE3WhRQ0NUG5jjXSehqAMCPepTj15txHQuGOGUGIsO2DZ/83mtEsdbKWPlAfF21kO3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728707328; c=relaxed/simple;
	bh=8i01FSb+IGlfRhpF8X3LU9FmbRi1pylHtQM+7dESwyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lePknGYLxxWPrNCLacASGcDZ1QcidL2YpGDPL2e+LfKeFtNiPEm/DMS58n5Tyf+Ou+w2vTVvUUoFji8t4ZZonM97v4tj3e8BW9JYip5ujXmcexnAqXiF62v1kd+XeSUJnyZMdOVAjfwcA7j69kK50GXXDswxzqLaMHR+Kl0LEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klKExNw7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klKExNw7"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c714cd9c8so21477885ad.0;
        Fri, 11 Oct 2024 21:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728707326; x=1729312126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0vPLcrUQ3dhrCe+AxqWTtAE4DFldiO30qrraC32Q7U=;
        b=klKExNw7w2pHZOjUXba3ZHFkqJYHZZQ2ikvwXbfWjeDzYmlckoFUtJ4/vxoLG3bMkK
         F8Nz9f6qrLOWdK0APKqEXaZ94hjFTZjqrYSJOXHB5muBBHL1UxJgBpFPyFtUOOTARNi5
         Wb6vhMEw72daTWkb6V1a3FLE8ukaGAtxAFG4ktQQ3s+w25fWxy93R2Vh0ZRvTntOIFe3
         jb8o06wCmvpyKchtAd/gPSoSWLX/Mc99Ds3rVmf367nGOF6iATKY00lpi8sBaalaMMEQ
         ksI1jK28LRjc26O4kD87+YSLNptADFH8D4ULpC0H2kF029t9OAvhOyymqB4pHZFVE5w3
         qS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728707326; x=1729312126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0vPLcrUQ3dhrCe+AxqWTtAE4DFldiO30qrraC32Q7U=;
        b=wS/4Vbq/siu5c2/i+RdvVojFCutBntGb3PBtmgV5alRJUScebSmY6aGfFssfKapoLQ
         21rw9qAvhVx7nFatP7uPP+jFwOD4m60pwF+4dO2dehz4etPrhBnwc8y90pbEWuhjf7oX
         pZUEb1VZRdX8MecAaoVY3byIvpOqHm5luaUeXJVTN/vDtQlSEYJot3ImanEr8hj6VjnS
         K1WL7q7XotYmvYYwcyd1bBaQ+D47Xj5xWhYNnLG6ubW2Wm8YjAQCzCI400+qnbUhxUM3
         6Zzq6AueZO5JzLf6/GSHvGIDXmCSH4Si1L/Lhn4kBG1NPqx4aKNLynvZUXo615Pjbdvw
         51iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbPXdhnexMFf5dGUIDnSIrARYs6l1AJAbPzxKwYRJ3hTrGvyRGLMjrjGeIWFleDg3cvW/wkPjkYtiQKyU=@vger.kernel.org, AJvYcCXiU5KBwBs2lpkLsQqM7/lNuS5xWfd33ZkudYaZkFEeVnbL+mM6Msj/zPOOWjP6iyYrFIiyZNvV0ZZG0oPxYcHVdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2X+Y6uTD3yIKBo+cezWt5HmfnGtm8zjP1HY10dzGqvWmJvDGT
	6VA1li0I8njtYiUWwPJClmFxWdcwp585KrYBDbDZvOl/nWRl7/gm
X-Google-Smtp-Source: AGHT+IEGhcFbgLWMN6Cde9X45F6ESflixRB4V36vMq7+JkETfm4wYCFnq3UgrS/siC02GinKHCAOAQ==
X-Received: by 2002:a17:903:338e:b0:20c:a122:e6c4 with SMTP id d9443c01a7336-20cbb195fccmr24358505ad.14.1728707326454;
        Fri, 11 Oct 2024 21:28:46 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212fc7sm31017165ad.204.2024.10.11.21.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:28:46 -0700 (PDT)
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
Subject: [PATCH 1/3] lib/list_sort: Remove unnecessary header includes
Date: Sat, 12 Oct 2024 12:28:26 +0800
Message-Id: <20241012042828.471614-2-visitorckw@gmail.com>
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

After commit 043b3f7b6388 ("lib/list_sort: simplify and remove
MAX_LIST_LENGTH_BITS"), list_sort.c no longer uses ARRAY_SIZE() (which
required kernel.h and bug.h for BUILD_BUG_ON_ZERO via __must_be_array)
or memset() (which required string.h). As these headers are no longer
needed, removes them.

There are no changes to the generated code, as confirmed by
'objdump -d'. Additionally, 'wc -l' shows that the size of
lib/.list_sort.o.cmd is reduced from 259 lines to 101 lines.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/list_sort.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 0fb59e92ca2d..8d3f623536fe 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
-#include <linux/string.h>
 #include <linux/list_sort.h>
 #include <linux/list.h>
 
-- 
2.34.1

