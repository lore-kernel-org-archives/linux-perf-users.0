Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A917B506;
	Thu, 14 May 2026 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720853; cv=none; b=KivW92HxDAo+Q2Gm9s0sSSuxPoA99mwAMLt/1QP9DPpiKSCrpgD1wH1AuayE1v9/DOw+3VJ3xhprbu9UnfFG6duFuLhPe6sIOo9TzHhCCszwQeJfLgsrbMCVhzvx1kizgoI0KSg54amHy2lqdtVYNQbU7pKFK01i2+vx9EUGiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720853; c=relaxed/simple;
	bh=rtVsvFalX6/NG83hTkcYsXRI0iEC+uLXcHvNmqDe29Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHbiC6Y8l9gbs8cWthiX0+aLa4sK4LREddOGWtD4heyrBooRBqaO8rOl2wjRYx8wXbcMh9EmxySDx7eqKy9y6mdsUZto9qWNdzOYeWuSBke0ZR9EWq1DxT9G4w55JZtwePKUTowisSHFWJJ7SzExvprmsyNYjOw8JGEvc8oDtVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GJ+IYhfX; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="GJ+IYhfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778720852; x=1810256852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2jXs4EkT9DeyOXXdzgslt3x0NXkaMOG8V9VCmcm4hms=;
  b=GJ+IYhfXfxpb5DJ77O7twyBx6xkZn/+TYPBlLWJG0yPWeJVvLxE+dB8Y
   7DjpA47eeSR2hhK0qPngGvxXww0hqjNwIV1lgs957y5LDLWO+gwfm7wh5
   aoUAAii6dzqOkf0XSc/VdFgpk8v179OnICFv3Rfvzv55XVqhiC4CMd+Ve
   NFpQ0DYR4K2K/kaxUQDBxUvH0DfVeezHiuXjrY1ZRgasqeq0rOE9iFFfL
   9ODBQY37rQ5zU+rSW4HFAHCiXADtwG0DN0BI/RTJXNWKSfNMGOXTKlpM4
   fr6cjV0Y3Fl1piWGUbWM3LBX5F44jSiQ3YOsZfJxgBLJSKyffyrXf8iUN
   Q==;
X-CSE-ConnectionGUID: KdUAb0WjR1SvVxBa01IgOg==
X-CSE-MsgGUID: wQR12aYuQg6MxCxpTCdJog==
X-IronPort-AV: E=Sophos;i="6.23,233,1770595200"; 
   d="scan'208";a="19394225"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:07:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:8265]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.132:2525] with esmtp (Farcaster)
 id efe55baa-545f-48f3-bc17-0317dc041ac3; Thu, 14 May 2026 01:07:29 +0000 (UTC)
X-Farcaster-Flow-ID: efe55baa-545f-48f3-bc17-0317dc041ac3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 14 May 2026 01:07:29 +0000
Received: from dev-dsk-sauravsc-1a-8777b848.eu-west-1.amazon.com
 (172.19.118.34) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 14 May 2026
 01:07:27 +0000
From: Saurav Sachidanand <sauravsc@amazon.com>
To: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, "Andi
 Shyti" <andi.shyti@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aghayev@amazon.com>, <juew@amazon.com>, Saurav Sachidanand
	<sauravsc@amazon.com>
Subject: [PATCH 3/4] perf: nvidia_t410_c2c: fix cpuhp state leak on init failure
Date: Thu, 14 May 2026 01:06:28 +0000
Message-ID: <20260514010629.76558-3-sauravsc@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514010629.76558-1-sauravsc@amazon.com>
References: <20260514010629.76558-1-sauravsc@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

If platform_driver_register() fails, the cpuhp multi-state registered
by cpuhp_setup_state_multi() is never cleaned up. Add
cpuhp_remove_multi_state() on the error path, mirroring the cleanup
in nv_c2c_pmu_exit().

Fixes: 2f89b7f78c50 ("perf: add NVIDIA Tegra410 C2C PMU")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
---
 drivers/perf/nvidia_t410_c2c_pmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c b/drivers/perf/nvidia_t410_c2c_pmu.c
index 411987153ff3f..662fa1bc833a5 100644
--- a/drivers/perf/nvidia_t410_c2c_pmu.c
+++ b/drivers/perf/nvidia_t410_c2c_pmu.c
@@ -1034,7 +1034,12 @@ static int __init nv_c2c_pmu_init(void)
 		return ret;
 
 	nv_c2c_pmu_cpuhp_state = ret;
-	return platform_driver_register(&nv_c2c_pmu_driver);
+
+	ret = platform_driver_register(&nv_c2c_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(nv_c2c_pmu_cpuhp_state);
+
+	return ret;
 }
 
 static void __exit nv_c2c_pmu_exit(void)
-- 
2.47.3

