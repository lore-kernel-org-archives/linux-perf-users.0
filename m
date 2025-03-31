Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D120296C;
	Mon, 31 Mar 2025 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429103; cv=none; b=mU/qoEmpMKgD2TTdQygQwcKHBGazz9rq2Gy9CCPz1K9hsf8IDkgGk8Dk80qtwO7A0fldtqCNB2YRFJ8ohCKA5opxOFYxXu6ytkpuhp3Wx2xcPLDsUNi6HaIQmvpqkPCOlAmDHyT5tehE6xu78tEDUKhINgB8a0c8G8AFNvnTatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429103; c=relaxed/simple;
	bh=/xOFCnCl1bp2H1lBSRP52BzGu4qzWa8zmSC42c8Mfu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=agpXWJ7v8/ufO4ueD03P87B3PzfTZ/TrMjiMVJVFYwfDQm5NOilIZN61ozzNedrIhsGFgsWjaZic2c9HvzDtxXX4ySv6VjCg8J8SEFyX6VzQZzJC2gQHx3WiOukjFuTP5t5AmaZyNdQdPJkM9AHzn7Vh/w18D4XV5NPVJ69EeUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAd0qmJw; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAd0qmJw"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so9785070a91.3;
        Mon, 31 Mar 2025 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743429102; x=1744033902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PInnCdBKi8aM4fbhPrQJn45/zC9pgXXJe6ZpEybvC+M=;
        b=gAd0qmJwyVsgYYBToS8t2vhg8Q0ztFc91Vvr2Wih/BXprFTR3cryBqRfGrBukAJ18i
         uueJpkkKpg4wRpzoeas+xz3CJYL7xuS07aaN7RtCzCGuGuqRw4kHcwHRKUgKw9gBQ5rV
         ZL8ehrH3jtXs//8IO/RPN63Al1F2g1OGxfsvbWWH7z6LvmdIQ9Y6af3jPKQl9rQr6U25
         qKSNeXUJ0TklmHI3Y2SJnqLlC2EdzrPZuLWHHXlfTg6liFrXDU9JN0/S/TYV3MwSC5Ps
         1uLqDzlHuPndu/p8bi7jd9KT4p0BMjrQbCYTvZFYkcdVeNTuEYJCiCxXgaC9Md3ZVEYn
         Yj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429102; x=1744033902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PInnCdBKi8aM4fbhPrQJn45/zC9pgXXJe6ZpEybvC+M=;
        b=V3HmJTBSVODSZrZHlA8O9JfUHU0F6y3A2NzU7V6m/onK0tWbme9LKi9RtNk+6lxx4G
         kF+QNBeHNHrfjvInnGs0EsikyDiH5lx+ntdD8NKuuf09tgaX+GwtDIn5QINZSFeACX3J
         c3iubdBA2vtyxEaoEInBVuhVKXgP2tWVU3e7k+vnkLley6nrMpRbe7oAVCyIzk75h+cJ
         cQRxPeca6LPpcXE2nSk34EPEWOYTiRHPxYlyaCh6vsf5/Fi+w3AUWp/emCrcNSbTQHXT
         SxgBYW27ljvoYtiExLGvZRrFipAv7ljVHZlEYgFvJjkZQwLe+cEYpo56nvs/PZ2Sl2Ya
         +14w==
X-Forwarded-Encrypted: i=1; AJvYcCW+FbzizYR4BD3/CCM1Flg6P9XXm9p5JsGLGXvWDhiPLx1eTYQblkCl51DlNx0zHiRROp9/NwaNO++esbk=@vger.kernel.org, AJvYcCWPQ4ZwT1mw/0AGsSmipAlYaV6bKk6dUBgh/8wYDPTlyIMgKSDvwDNQY2S/jV3ww3p7+Po+DMs1f9rjS6vM1ryvPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvgDFGTy9gU1yqBt0xwhoOO4QtW8c9bNWX3s7AbwrgwtQh/g8w
	7VsR+8gB1r2GTLF7pDtkdW5O71HSyMV8MH5MlazjYo8FyYrVVy/v
X-Gm-Gg: ASbGncuT70schKag1tDa8S6P0el0jKgUFox44s0lerozgN7s7ZU5emEV0lfSVq5+zKe
	UJ3kvDqNZ4MDr6wKySGIjY0ttjsTZbSZpSYTDcE0q8N0kcePTonHqYPnTConvvJBHppNSKcooCg
	MoCafR+Si+uL5wHV/H/qutjcrhi3Rd9/tINa47GRAaUaWAsanmFB/9aa/2PR5HpoWcKGfjxe+yO
	VVpZBxCoSYvCmkYVvjghXzcF6eo432eN95GvIpQXSMiAMdXDZLZaFw4wro+EVk+67GU1bM4eP6R
	Zmh44t8av1ZMq2mOSdlGhEqbnhmJK2DLzkSVUMCc8fCO7ip/Ep2UGmlf8vh6UzrI8b/qi7g=
X-Google-Smtp-Source: AGHT+IHa8yleu6Tesplwr+MK7f1aRyjHejZjDckNp6dbjCL/LDmj1X0vASxGTqF38/Sw39ZjVBBpbQ==
X-Received: by 2002:a17:90b:2dc2:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-30531f9fb9dmr14645807a91.9.1743429101645;
        Mon, 31 Mar 2025 06:51:41 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b70b4sm9513637a91.48.2025.03.31.06.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:51:41 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2] driver: tx2: Add NULL check in tx2_uncore_pmu_register
Date: Mon, 31 Mar 2025 21:51:28 +0800
Message-Id: <20250331135128.11881-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() return NULL if memory allocation fails. Currently,
tx2_uncore_pmu_register() does not check for this case, leading to a
possible NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Fix commit message to use imperative mood and wrap lines to 75
characters.

 drivers/perf/thunderx2_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 6ed4707bd6bb..24443ab5d998 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -738,7 +738,8 @@ static int tx2_uncore_pmu_register(
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
 			"%s", name);
-
+	if (!tx2_pmu->pmu.name)
+		return -ENOMEM;
 	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
 }
 
-- 
2.34.1

