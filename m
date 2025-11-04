Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9E23B61B
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248545; cv=none; b=nk3TTiJarUVRCIeqcdAKRCPa86fFMdDKyr9h77jOcbXqfOXKtbWar8TIRrQp1PhUMt6okY2DZqdfoJO6i3GMUT8AKKmwzdf6pHTc6hSxugLKJm8WV++3x7RZpsDCe0j4h6e7Uo6+n72KT6jJDC/QwAAPNnlsoG0AohHJGyypXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248545; c=relaxed/simple;
	bh=9NZz8+0HjGiYkq9QMHNT4BbNht0YbASLljRV/7ufeE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rx6k2eNtu9EtTNUR4cx9W0u32gCdfumE9basEXdjrgdYpVbK8HrpiB9IggGSfGH/wrLrZQhmCxsmn0Axa3ik0nk107JPOIAdtxvEiyWqkfGtMQmZ/Z4hqGikEZ+H4iJolA7rTtAyomKDY/kVopMH2rT2pGd8Czp4XZ2Gpa9vtaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=b9RhNZVm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="b9RhNZVm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-295247a814bso54767885ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2025 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762248543; x=1762853343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hk3PYE38Zzgv3m8VQl8wYmuHsU1MqZfGLEy/1nq+zs=;
        b=b9RhNZVmpTFrA5vL/Nmr3PaZ2aHcswxQaeLJqxgNmGUmuJaspv/fofl9LSjBKASwlx
         DOuzg7pVy6R+VT8QfWn5s/KlaGoTD5zI0D4K1YO1oB48xT4JVP3CXIYwM03n2pPff+Ap
         781IeBnfJJ2hB8YVXrB7jKZX1snSVKLHrjbZP0RBED5gnBygBENQWCMCVas68ZNPZtxj
         Wa0sm3vPr5pb+UHlggw8k75h2f7jfqgKx5/AOXj3XUu0gk8xhqHutsSC/9ihNwhjYnE2
         mxsMxveRZX1Lvp4zUTSrbgbJJLk6JFO7b5e6/W26gsVZUuESlGt4cnmXYubdkSuGgszh
         wIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248543; x=1762853343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hk3PYE38Zzgv3m8VQl8wYmuHsU1MqZfGLEy/1nq+zs=;
        b=ND25/6di+gJpJlwIenwEKj7MJ/wz1D3BE6Km6n2QZHmzjMfX/15z+7TXfLvS+ffnT0
         yurSaasldEGyhijF/S7ojBSxjsf+1Zuo5pBbOBMgBWL0GXBAVt1mDYs9xwAmdURRYKnH
         7WrjqgOZCM/chaAqGCvKtX5OC03CvEbFMVQAbPocOPHxYJR0OoxBzLyr39SXtUcdOTVI
         d+LDhmsgBQGf22HC9ohndL+o//pC1rTXzXrw8UZMUh1dakP8TYOd26AR58UFyRnVUrvq
         CB+LTyNKYfTlQ0T4C1dhXX4Ad9a7vIjC5mDwg+qg/MWN/wUlit48Ot8UYcmFoqPMYbMo
         Kc7w==
X-Forwarded-Encrypted: i=1; AJvYcCWd6UGVwc7fg9p1aPsdJhjz7iu4Q5kCsjejGvvotK8PFbyrNX/00tveq4Kbaulvz7/VkZzL/Wb6n6VJhcioLZ4A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3lMTocF6MvslSHcZJ9+1zhKlwBcaQL4TurB1bQtqPERErLLJ/
	EpfBXue3bet8H7kvBSguHuAE8GSAqQM1UfWeXCBRpl+wQ+vj0srumBdTWo/UQsojZRLcuVdwktD
	tbGIStKT1Tw==
X-Gm-Gg: ASbGncvW+wbOPtGLhmeY9ZKXJ6c8HZvX16/5MwgNlDylV68HHcjRBlqu18VXF7JNUOk
	2Bn/p2JmupSxA1xDKD5rd0rDylnnjWJwNxCTTyWq0ducn+rUgHCVggYPeOkdUsH1hb6gj0COpWJ
	1HI8vm3Xnij7aHBeGFYUSdsXUDJVJssskPPTdEkxY9EiiNIcHvgGyRizylItFkTi0HH8NJUqUcJ
	DbZZySh//6fPHFoL24MBUiXD1y8EM27UaCorAiylYBY1pA5MO3xLNVB7XUA12YAuciMjnWXdoLO
	2rISftihgC9YjEtH2ShQeUPPmGO5mfR5saWpnmfbYLi9BVlk2FnZjrqiwwnu9vEgqoVKAohry78
	CAxpKVuDf1Aszvi2v/bKqRAszgRy3Aj1am3Jx8DWH7AgQ0OMJAzF1Qi2muJvv7mA5RKD3QJwGju
	o04QSW9y5q+qTXkSs=
X-Google-Smtp-Source: AGHT+IG7RTH3tWAxCPZkbkFtzG+dpb0z6mVERYHnwx86lq/fCclFo6zqdFexGNibOW+avSxjFq5S2Q==
X-Received: by 2002:a17:902:e749:b0:295:7f1d:b034 with SMTP id d9443c01a7336-2957f1db313mr114052945ad.4.1762248542808;
        Tue, 04 Nov 2025 01:29:02 -0800 (PST)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b78f8sm3874700a91.20.2025.11.04.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:29:02 -0800 (PST)
From: "jingxian.li" <jingxian.li@shopee.com>
To: stable@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	adrian.hunter@intel.com,
	sashal@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "jingxian.li" <jingxian.li@shopee.com>
Subject: [PATCH 6.6.y] Revert "perf dso: Add missed dso__put to dso__load_kcore"
Date: Tue,  4 Nov 2025 17:27:42 +0800
Message-ID: <20251104092740.108928-3-jingxian.li@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e5de9ea7796e79f3cd082624f788cc3442bff2a8.

The patch introduced `map__zput(new_node->map)` in the kcore load
path, causing a segmentation fault when running `perf c2c report`.

The issue arises because `maps__merge_in` directly modifies and
inserts the caller's `new_map`, causing it to be freed prematurely
while still referenced by kmaps.

Later branchs (6.12, 6.15, 6.16) are not affected because they use
a different merge approach with a lazily sorted array, which avoids
modifying the original `new_map`.

Fixes: e5de9ea7796e ("perf dso: Add missed dso__put to dso__load_kcore")

Signed-off-by: jingxian.li <jingxian.li@shopee.com>
---
 tools/perf/util/symbol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 4f0bbebcb6d6..ea24f21aafc3 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1366,7 +1366,6 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 				goto out_err;
 			}
 		}
-		map__zput(new_node->map);
 		free(new_node);
 	}
 
-- 
2.43.0

