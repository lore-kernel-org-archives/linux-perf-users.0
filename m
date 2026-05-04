Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EDC2E040D
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889341; cv=none; b=NojunYd3/PiLneRjocY3QEx0tPLhmsXWaf4RXn8fIimsuGZbZOdveXbvpkp9qNrYkYXoJLIj755Wb7ouzcWXuWuACs6BbDVRGJcctcnO6I6s7VLl5nFSRww76iVejqrCm/pmSJK15a/hCGAnLjZLqM4p1jw5GRz/AYCeygGMz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889341; c=relaxed/simple;
	bh=pcbrlB3qHsPLc/y90rnx1LrG5b7iFx58tWFuf97lMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsNSPdaw30ZwmzCVH11f2Lzl51VHMQoSQbnkGJxlHt4s9jQSKcH3DL5h5qUd3GFAS5DGwNq84pjvPMQB5dH5qHqMPHRfHFxB6Ar5Oe38iWZQM6bq4KKTRC6SybEmBB+bsdxjgWboZnPxyARqo+WGKcQ8ZOExCUurujuOalNPka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKW7JyjX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKW7JyjX"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3fcb2c718so3489901e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889335; x=1778494135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUsuLRSeuIGkFfh6WNuAvk/R1MMvm5m1C1zWcRocwNE=;
        b=cKW7JyjXHGgh6mBa2l2a8jd40EAX5sw0SGAXxqQFYZFMqJLhudJJTojaBfnSJUqbOj
         w5BjRfybVM9L6dC7Jn/+Fkr4jsvL2/n2vqEB2P7MnRuuvnPtdWQzhptnWBVXuNYPbuap
         QOJY22o9bjxeYQ/k7Ftl21S5SQ1yv2kvkR9XDaWmQ+OhGLe/1p1jd9Cvc76vGcZa4TVq
         ZXdrTu0iXq7rlQK6IXjslucJviAi+WgrTlB31XjBOeAUXeJmsfXDuilGkZhliM4+ZHmW
         a/LNpYwKlfvwxDEX4MWlQRzxFzDLQPJ6R5LzP0Vjdc6prrrAnhzAaLdwOo1bmt5U1+0P
         STxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889335; x=1778494135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fUsuLRSeuIGkFfh6WNuAvk/R1MMvm5m1C1zWcRocwNE=;
        b=nXwD+sUXFeh/xwCL4EOVHjfPSJzbyaUl4HFw0bn6xlt3+6m0Y9iX92m/vF/k8l7S5c
         qIdfBvYuuE45j0eWhGy/YdYbhruTJdkGbjFETY8PgXnr9aN0vZQfVOqwVEC+ZALP1UwA
         BvrICs/ILDrO49XKddCCqmvzvIQuMzQT+D3ZaUEQvYVMQDmmuNdE9th0Q1Fn+ko7eOEr
         EyJbXtYczQ3srUbCB4chYeqMePLIg7bL+h4BVbqndq4+92ryErHIsWCrzdT5sAvIEjaD
         QclvCV7G/9c2L/jfQDdQSsv73DsY/6HecXGjpzj+KHNwuIcegl6ruF4+pWUKUyeuB+j2
         qrJA==
X-Forwarded-Encrypted: i=1; AFNElJ9QvS9Bx6uRrzovHiIt0ghWJJhjlc66ojl6lnbGO20GSDs8f+mZ8PwGXb51D7xR1tlinkI0iw+0wgZ+lIXD3lvd@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbWsmnDbGYE6pODr2a0UO4uzllsAFjNaSkNd/1T/lbAxsN+rs
	LtqJyO8tRPrya+Fahp9sOnboGtFaRKAQawiAp0CCuYBglNJmrcJj/oFs
X-Gm-Gg: AeBDievvVfNWlN6cUd2MLTFPkGEEKmqP8Etzp7VN1q+Pu8pVMdWGpn7/aavRVzxYnMO
	Oq2flHhBmzZuEZHClAYyvCfyAeXvTZ/nYeTMyYDHPMfukcH3cnrFr+ufIzDdQnTaoLguR/SiZvj
	QDR3JcijA1CiLPJaBN4gUTye5k4NUxGtsUfg2f2UUDTekTVb/ZkP7M2gFh/bBxsCD7HTwJzrgNg
	S1SYK0wgBTHAH5jUY1MIPgOF7tOY5/t7d/aADjMEx7qJLfdy5ftKzWkrOpXzRcwmpFNsYaIgaE/
	2zH+QT/p954wEJB9Bi/z8T8bmzCng6Cxe8p0Li2z/EIqpW1nLn+cGpxBHx0SiSbJy9q/0HMCXV6
	ERqY/JBxfmWEcdJvMRvlpSmw/I1k9XZxWym8YQq9X/ynNSJcEWlptggNgdFHBt+klYIjtVedAt8
	MDDcg8OoVN3+7tAdVGe8jX83OCorGfAVxChmVDgbppQxdQJC91Us7dVsjIYtDQ/NfileWTuzg=
X-Received: by 2002:a05:6512:3c8a:b0:5a8:6ba2:225a with SMTP id 2adb3069b0e04-5a86ba22265mr1869874e87.39.1777889335210;
        Mon, 04 May 2026 03:08:55 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86645ae7csm1979099e87.79.2026.05.04.03.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:54 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vastargazing <vebohr@gmail.com>,
	stable@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/5] perf: arm: pmu: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:46 +0300
Message-ID: <243cb3737b41fae32a09117c17809a210395e69f.1777889235.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in arm_acpi_register_pmu_device(),
the embedded struct device has already been initialized by
device_initialize() inside platform_device_register(). The error path
unregisters the GSI interrupt but returns without dropping the device
reference:

  arm_acpi_register_pmu_device()
    -> platform_device_register(pdev)
       -> device_initialize(&pdev->dev)   /* kref = 1 */
       -> platform_device_add(pdev)       /* fails */
    <- acpi_unregister_gsi() called, but kref still 1

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() in the error branch before
unregistering the GSI.

Fixes: d24a0c7099b3 ("arm_pmu: acpi: spe: Add initial MADT/SPE probing")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 drivers/perf/arm_pmu_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index e80f76d95e68..c2defbc32ad9 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -119,8 +119,10 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
 
 	pdev->resource[0].start = irq;
 	ret = platform_device_register(pdev);
-	if (ret)
+	if (ret) {
+		platform_device_put(pdev);
 		acpi_unregister_gsi(gsi);
+	}
 
 	return ret;
 }
-- 
2.51.0

