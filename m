Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17C39099A
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Apr 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274932; cv=none; b=K1QyOWZ0i9fcuREDTaAewrqepzIMAEq4G0GaLfQOYaghynpuIcx58KXSGDyRGXpXlDldOki0tJNy3qSbFJ/G0k+diLJadTJyIEUpjqX0DjjVfUnE6I4wnC6WD5pKozorNeGAn1jrh6NaZmkqaXxgpkrT+qpVsNsOp/aPzXEoJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274932; c=relaxed/simple;
	bh=OfEpoQQCvbruyEEiVw52qe009gbsqV/tWcOBBRa19tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8OR2EPVdf5ztvFRgD7lZbuvF+LgDz+bXP/U/jGFUgQ03JcSNLq75lzaWJYoChr4jbJQ3Ef91AIWOf1h95U04Xe5X7/d88SSKAqsAuQvxGvoTC+upN26R+h5ntFvOf4K/+FiJZHYwWSHSDV4G5bFysUzmlBLYGfjX+m6OCs3XSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBHfCfzn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBHfCfzn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b2503753efso61882475ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Apr 2026 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776274931; x=1776879731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ/g0M6nIzsGKbX6brZJSUwMyF1dOX6znsTMtk5A1OI=;
        b=XBHfCfznBWOBlNUya6LVCeZPr/6rGOAwcS75+nsMKFYDSdAYZDnjUx1U4ynNpNCSyZ
         RuZQfPgey20aBRklXxX8gZCb8gQ/6DdhqRfSl22ey92r3CSm9zoXPVZ2e+z3aphfyOAg
         o+kVCRkS6YjUwc3O1o2RE4c/D+VOhK6+mOsG8jFftQSuIyg03fcgc2Q8J3OZA4P7F2Nn
         Nhi66mrEYeqy9wI06141OJ5sibnhs89hw20cvawm7wE9d3/AN/ln/ggMpimewVZL20g1
         vVzNFHwcwvp2EmBwekNFetxPoQgL9hkOH9yeMPXA04eZKQnqFL1UlY1hDr10/L8FLDO2
         dNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274931; x=1776879731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ/g0M6nIzsGKbX6brZJSUwMyF1dOX6znsTMtk5A1OI=;
        b=de9tQkDkYorbdol6Z8aAxNPuYRVvkzBXSky+Xomcyud1oaemASypk2A0A9xkm55JgS
         vWOc8DQ8xZjsNGJkYsWiDU8ShgeiU32tBirxsy+Bzbsh1gajw7PkrN9BPu9wQo4IhAqB
         fRd8Yb7/9/tHFoKFqEvQFlqQeWo/F/koA3qvp5rTIl7139buAFYbuIbXSTp1SUh+pkE4
         XiGTwIyD1k3SFDHLfqF82hB/n4G1Q6doIgQnOW7W4qo3mhepmZ0Knf/AK0ATxx3+NL+2
         xtfJ3xsbU2Tvd0S+BDmyPatgdVpYsrs656l8XhN12lnawKbdDTeEbDmOqtxyJQ0/+wi8
         Qk8A==
X-Forwarded-Encrypted: i=1; AFNElJ8vyI4JMbQL0oGe9698CMfuFIpIPatPl2rEBWSHhWEGEP/T/04ga7+ICOkgEf3zHGhK+APbFbRsekZg1kDQSSGA@vger.kernel.org
X-Gm-Message-State: AOJu0Yza0P3GvT1j6oX6sK6+ttR3JJwpzt0AeTdAQuDgo1FjszcnoTgv
	JRF/+ah/G8OcIVRnTWf8tfqOh1sb6TiMYW8Ga8QMZggJXF6dwFFeuXXD
X-Gm-Gg: AeBDietMFFwf3LjsmStmelkjfd9wVCro18t25JjnsXaVFDBONyBoiQrYCYZQeYpSApT
	kKpJGeO90WPx9D7mifVlV8nGZ5xeaEP7+cN0Y4JjEtU6fO9DALUgZB3uPLRTozzwW4wGJFN0FFw
	Pgo5BsRmSvbbChyNTIypyuV+eYWxrZLJ/wVX4EaErMYoq2drIrhtUcszVdJhB4mXtjliQH/rzr5
	xH8z+AltLpZWFtcGdVhu7wBnVobp9umqZceveebPgc3h6+6DN+bOReKfJ4y6uegYxNVIlwBoVLj
	f7Qlr+H2P7JtN7OW+Nd7cloWfisirHDYvJRFuM85KFv82nN0WOOpaC7Kihs5icEksfHHh4gWHF2
	rmEbwTeri9LBt9diFzTD3rUNHofJLJc7iZaDKYZacRdod/8pDp8qE5onVnU1dJQVcbnCZrRMO6O
	DFa5rrpd5zPY1dDQatDzLm8dRe07c4lnpYMEI0
X-Received: by 2002:a17:903:b0e:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2b45ceaf83emr139663995ad.4.1776274930985;
        Wed, 15 Apr 2026 10:42:10 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:48dd:8f21:beaa:cec8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47829a4eesm33777805ad.60.2026.04.15.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:42:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm_pmu: acpi: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 01:41:59 +0800
Message-ID: <20260415174159.3625777-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When platform_device_register() fails in arm_acpi_register_pmu_device(),
the embedded struct device in pdev has already been initialized by
device_initialize(), but the failure path only unregisters the GSI and
does not drop the device reference for the current platform device:

  arm_acpi_register_pmu_device()
    -> platform_device_register(pdev)
       -> device_initialize(&pdev->dev)
       -> setup_pdev_dma_masks(pdev)
       -> platform_device_add(pdev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() after unregistering the GSI.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 81e5ee4716098 ("arm_pmu: acpi: Refactor arm_spe_acpi_register_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/perf/arm_pmu_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index e80f76d95e68..5ce382661e34 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -119,8 +119,10 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
 
 	pdev->resource[0].start = irq;
 	ret = platform_device_register(pdev);
-	if (ret)
+	if (ret) {
 		acpi_unregister_gsi(gsi);
+		platform_device_put(pdev);
+	}
 
 	return ret;
 }
-- 
2.43.0

