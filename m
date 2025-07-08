Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770A2D8386
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971257; cv=none; b=iJR0BF2XM1GJbZTW7sB3TZbmqFigvROaUp6lpBvQ9Yp43ox/D3WSvXINVQzP9H8lpvvhAVFmeRWHpZizj+MGEFmI5Sa+SNc1FkoJgt+WlbS0+xp7h1fGoT2frjKUcf10toBQCm4058Oh7wLLmO/Lum+h0kPsM9+MQjUql16xXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971257; c=relaxed/simple;
	bh=MDIEaPr8HDVKtLmDaM9Mbp62hb9gBqko7nOef0uAuIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Ixa0iE68S7EJC3O20Di7bLXa8AC/m87ZCfkMaXwwiXZN8T7ALQ5swCCf/D48Dx2kIFRzvsp8kq82cbKI4FmuRprvoICeZKl+HP6b0K2y5LrJ+qa63iKdAk+MZ1WkTlhqW8N2gGihMofLU9XrgA738Gz0ktYIBe/OXaDXbUboqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AFZE5An8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AFZE5An8"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250708104049epoutp038fefbf4a9de870e5bf1e4f1a1caf4341~QQJGxIVb22789027890epoutp03Q
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 10:40:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250708104049epoutp038fefbf4a9de870e5bf1e4f1a1caf4341~QQJGxIVb22789027890epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751971249;
	bh=jH87uithjfzP9Ykpoxmhz9d98lNSkdIORLDu4bcOrWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFZE5An8I4UPKDhyNrWZ1uIaoLRQWo68NYtgqYhHHThIXR2SZeyqwIsyrT8stp3x4
	 qMFLlUMv/KA1I8CeO2caI76ypjuswT4VrNDXGK2nZzwmia71I4VHIh7hefVBeGk7cw
	 FK2q2XSKZWntlFs8qjTO0zkbmTi3qWAlLI5BX7IQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250708104048epcas5p45aedc6a241e37ee683d7b1880dc8903e~QQJGIyyTk1622616226epcas5p4l;
	Tue,  8 Jul 2025 10:40:48 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.175]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bbyLl00Mhz2SSKZ; Tue,  8 Jul
	2025 10:40:47 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103231epcas5p1b9fe52dd6ea3cdd65a5df163ba05e139~QQB2zDMtv0987209872epcas5p11;
	Tue,  8 Jul 2025 10:32:31 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250708103228epsmtip11c2127deecf9c06a4da8aa251fc8feba~QQB0CXqJN2120421204epsmtip1W;
	Tue,  8 Jul 2025 10:32:28 +0000 (GMT)
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
Subject: [PATCH 1/6] dt-bindings: clock: Add PPMU clock definitions for FSD
 platform
Date: Tue,  8 Jul 2025 16:02:03 +0530
Message-ID: <20250708103208.79444-2-vivek.2311@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708103208.79444-1-vivek.2311@samsung.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708103231epcas5p1b9fe52dd6ea3cdd65a5df163ba05e139
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250708103231epcas5p1b9fe52dd6ea3cdd65a5df163ba05e139
References: <20250708103208.79444-1-vivek.2311@samsung.com>
	<CGME20250708103231epcas5p1b9fe52dd6ea3cdd65a5df163ba05e139@epcas5p1.samsung.com>

Add clock IDs for PPMU (Platform Performance Monitoring Unit)
associated with the MFC block.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
---
 include/dt-bindings/clock/fsd-clk.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/fsd-clk.h b/include/dt-bindings/clock/fsd-clk.h
index 3f7b64d93558..552e8bad98e0 100644
--- a/include/dt-bindings/clock/fsd-clk.h
+++ b/include/dt-bindings/clock/fsd-clk.h
@@ -125,6 +125,10 @@
 
 /* MFC */
 #define MFC_MFC_IPCLKPORT_ACLK			1
+#define MFC_PPMU_MFCD0_IPCLKPORT_ACLK		2
+#define MFC_PPMU_MFCD0_IPCLKPORT_PCLK		3
+#define MFC_PPMU_MFCD1_IPCLKPORT_ACLK		4
+#define MFC_PPMU_MFCD1_IPCLKPORT_PCLK		5
 
 /* CAM_CSI */
 #define CAM_CSI0_0_IPCLKPORT_I_ACLK		1
-- 
2.49.0

