Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160872D9EDC
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971273; cv=none; b=QzRfW2ZfxcycOhT1gIOOVNZnnLHfZUrg1glkuKFC+wq7YKJjXezROIYvsGZouyEgvlhWi3CimeSbeZa+OyFa+oZvhatZxGsTj5hUvnrHqPmPvGRSro2n7X+tuFKWm6vklinhnfp7/ruJXuMwlTAkpe6FrMJKnxvlWvso4Xl/DgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971273; c=relaxed/simple;
	bh=h8WzAtP1deJY97IsehBiHpJJmky6zH0Upj7s8EmaukQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=iDDuFJuBrSCs4zUyFHEr9u4YNfV4qfZ5kZnP4AEWAnEV3lziA6c3oCYZe4mvdJoF9KWQ5dYPR1mrmC/mQoJFr/RV6f0xHmVST0g7Nir79cLrI2BeaAP2TJuyxXlN6PP55vYbgfJlOUscClzqHICMcdgFbtB8c+gokgwdZoOxoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nQI0UJp/; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nQI0UJp/"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250708104110epoutp0153d73c3ac73cf485418e32d3e3a5a218~QQJaKAOqL2906229062epoutp01P
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:41:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250708104110epoutp0153d73c3ac73cf485418e32d3e3a5a218~QQJaKAOqL2906229062epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751971270;
	bh=wKNM/MVkW5+UIAF/DDkf6NK4GoimrDLpjI5p5ZBJ8t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQI0UJp/aEZHp3uJivzKfYJIBb1cTXi1bbF656pyNNMPJFAI01ZCufSdUCSzORIGm
	 xqLuOsMxWqtNfW5kUp6D1b4OnPNijKNgbTDNi67vS9OxTX5LFdAyFwzOgkWGkRsv6y
	 I7RAHtnOJaB9jOmYh6jdnkKw01XE+7Zbze3bWtto=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250708104109epcas5p2c53a6a032b6f49f6e749fceb3bf3b87d~QQJZeMmWX3102631026epcas5p2O;
	Tue,  8 Jul 2025 10:41:09 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.181]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bbyM82djqz2SSKs; Tue,  8 Jul
	2025 10:41:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250708103246epcas5p47b446ec342f9d49361c0a9a3929bcdd2~QQCFFnJsk0186101861epcas5p4N;
	Tue,  8 Jul 2025 10:32:46 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103243epsmtip152f34feb66a77e0fa50f13329b23b7ca~QQCCbn-4T1977519775epsmtip1_;
	Tue,  8 Jul 2025 10:32:43 +0000 (GMT)
From: Vivek Yadav <vivek.2311@samsung.com>
To: pankaj.dubey@samsung.com, ravi.patel@samsung.com, shradha.t@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, krzk@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, will@kernel.org,
	mark.rutland@arm.com, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, linux-fsd@tesla.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Vivek
	Yadav <vivek.2311@samsung.com>
Subject: [PATCH 6/6] MAINTAINERS: Add maintainers for Samsung PPMU driver
Date: Tue,  8 Jul 2025 16:02:08 +0530
Message-ID: <20250708103208.79444-7-vivek.2311@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708103208.79444-1-vivek.2311@samsung.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708103246epcas5p47b446ec342f9d49361c0a9a3929bcdd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250708103246epcas5p47b446ec342f9d49361c0a9a3929bcdd2
References: <20250708103208.79444-1-vivek.2311@samsung.com>
	<CGME20250708103246epcas5p47b446ec342f9d49361c0a9a3929bcdd2@epcas5p4.samsung.com>

Add maintainers entry for Samsung PPMU driver

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca11a553d412..5895b4e70c9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21023,6 +21023,13 @@ F:	drivers/regulator/s5m*.c
 F:	drivers/rtc/rtc-s5m.c
 F:	include/linux/mfd/samsung/
 
+SAMSUNG PPMU DRIVER
+M:	Vivek Yadav <vivek.2311@samsung.com>
+M:	Ravi Patel <ravi.patel@samsung.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/perf/samsung,ppmu-v2.yaml
+F:	drivers/perf/samsung/
+
 SAMSUNG S3C24XX/S3C64XX SOC SERIES CAMIF DRIVER
 M:	Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
 L:	linux-media@vger.kernel.org
-- 
2.49.0

