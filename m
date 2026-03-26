Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA793B9D92;
	Thu, 26 Mar 2026 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516023; cv=none; b=nAIlCcro3kwdWOJwR3aqQXWyPclqDKSxccvFINuApR7iFfR73aKS1mZPQwzXeiZxPaORuac60TEcJRe/Kyx7HXE/siPh9l/AT0WJrJ11sS7G+/TyCXntUloh/J+HxQG6+L1KC01fHf3SlrRc48sw878LZw/SmfFpP0igbYULUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516023; c=relaxed/simple;
	bh=A6Z/ErQQ/IrcRcX81n0bHB4Em+GRg4ikUZZ0tZ7NJKQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VACUZVpt9GxL1Xtto49foAI6hkLmOyORdlHu8VZMOrLuwmIwvCg/bOuVsdlI2QlRGSab+FBFmnPsWz2En8v7MKAPDxeaG21srlCGspMAayW9ikXmfh8r/AXLoRAfwvK6NYUg7QLzFBQF39+LRfGXU2pd0L+Cm2DnFMnI5GkFBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XpLeAewU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XpLeAewU"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q7JOsL145829;
	Thu, 26 Mar 2026 02:06:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=SR/SkZn+uF4l5BsESlaKtdNrsMB0G3ypNZAO1BqWB8o=; b=XpL
	eAewUmaBcnRgAhOnVvlj0wmcT7LQ7WoF/klqqG8cHXIjsiRg0x9UI/wkK/Y2UHqH
	tqn8GyX6yC2Oh8oXeA/qpr4913EcVGiJg3D47rBdSK4kwsdV0bw/5FS9V2qdMD4v
	m99t/ipVmRuZJjEdMcRO5JLa/JgpCb70dMUvT4KB8VGQzwZScc/eAuDb12Zf+QLn
	eWcFK7T/3NknZxR6QZBah2PWObODmwMJeXc+9lQB3DyWoQKx65VLSlJ0EPejGcQ4
	tSgW1awx/vX4LVhIqZPnZQ99KbiJ9PQI/vIuRuaAHbIjh+FMZQo2URD2FdbZ4E7E
	aGNc2mL7QkFXkJzK9Pw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d420jmsnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 02:06:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 02:06:50 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 02:06:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Mar 2026 02:06:49 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B59B83F7041;
	Thu, 26 Mar 2026 02:06:46 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH 0/2] perf: marvell: Add CN20K DDR PMU support
Date: Thu, 26 Mar 2026 14:36:43 +0530
Message-ID: <20260326090645.22590-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KM9C4xyof_5VDro3pQW8DXD2lNqT1UsM
X-Authority-Analysis: v=2.4 cv=ULDQ3Sfy c=1 sm=1 tr=0 ts=69c4f72a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=wzYssofzYklCjT3gtv0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: KM9C4xyof_5VDro3pQW8DXD2lNqT1UsM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2NiBTYWx0ZWRfXyTZL5gZL96ok
 rFze5NN/Q0uJwEXkwPrHwaTdd5fNhGC1TgzGJDBbkCgMfAYJZRDMbslT+INeo10f+k0XV3/zI9+
 IQpsfumwHxenECNNRzMIutAafIVIkq81SjeDVtAuS++2tcxJpebyV4jUy1WawfB0aEw+qKBhW9H
 xUXCkQ/Jzalw8cAYWyPLSWybCL72u9Hh2KXBQrGj4i5/vwveYscfLPImY1LVEQC+tsKlEjLRKSW
 Gae+uCl7IyLroTDK2CTAJ2llFBpJ37qNu89enJY629qtICYWl5BnorMlgaDx/GZdexH7xWKNXeD
 enySR5ukK6fVAg1apB8YvKJV75WWzTlMDVpFt8X2isRz1jEhWLdStDVhdvPAdw7Z+OZxXT8iqCb
 AaJZsZJYCxWpOIjNsiFlTdLJeikAAsSVlDHP7j4rtMXzt8KABlyLIO5Ko4/dmpnoZDbXO7P8AdK
 dejZbstlI+FiTxfdOKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01

This series adds support for the Marvell CN20K DRAM Subsystem (DSS)
performance monitor in the existing marvell_cn10k_ddr_pmu driver, and
documents the device tree binding for the new compatible string.

The CN20K PMU provides eight programmable counters and two fixed
counters (DDR reads and writes).  Patch 1 adds the devicetree schema for
"marvell,cn20k-ddr-pmu".  Patch 2 wires OF and ACPI (MRVL000B) match
entries, adds CN20K register offsets and event maps, and refactors
platform data to use silicon variant flags.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Geetha sowjanya (2):
  dt-bindings: perf: marvell: Document CN20K DDR PMU
  perf: marvell: Add CN20K DDR PMU support

 .../bindings/perf/marvell-cn20k-ddr.yaml      |  37 ++++
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 186 ++++++++++++++++--
 2 files changed, 207 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml

-- 
2.25.1

