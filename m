Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0644374E5B;
	Thu, 30 Apr 2026 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529513; cv=fail; b=WUCi80EXARUUh35u5nnXT0YATKn2zLeatizFTDZProJsdbvhbFiaYAcGE/tJYVDj0ns3uW5S4PKGMJhZxERfL39PbHXq+UzDD9r07L+BdIMYY6xPpnPM7LzpQC+aoZprmYJ4e31eiShaXBYLVHCqpHhgnozx/WGGCs5KSxwBvrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529513; c=relaxed/simple;
	bh=gagY/RALRT+teYqbgAfY1kWqy8Vi0KGMf5x1hR/kG94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHxLAhkPilAeNH4vAuM5gUyjKmRFJ8afRfwZaMPDFViZjQFGI/MRdZwo7C5PpTc6wfZFv2+l5nYoHnLbYVSjHBakJgWTkR70r1w2Yc3dUMEaJtiBqqaoueBZb2X/hLzjYjkfKdOyLhgeOW1qFiNWXZKz5Qh2V8j3Asw670Ihx1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vTciCVTI; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vTciCVTI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuFDXkvdAt0ZwLXm2FiutZkiapR3ZKnVC94fRW6p52UiVW4LrtaHOkcuqYXddUcZwib9LPZauwH5+eBZyFsRTzOXF9iC+atjPaA3FNJQ8uJzlrYaGuqJDr3zBNWUDOEjyP6vjUFrap81Ms3iB+tvuDbPyT8J64dKhIK/rQX08IuyfB20GsVOOM4TfseIqXufucOumiuwy+qMj2Lm5HTM9UKKG0raKFinBi81nzLivMWboStFK160us1GpMQU0Cj4Q7jgz+ui7SAmktrQeXb/kf+mdLQ9OajYSs9lIpdvRRXFIDm4RUdwZFOaZw3qzJMOZqVxc/LRxdEpZGOhBAAKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knwv+Dz6KZuy5O1RpaWKXm0dWKckLi1TSxQ4Pxp7siU=;
 b=AClNjVFqTliyAIxSmM8v5u5F2WbamTBnWtZvOErT7t6V0IWjm4bG1JhtGMlvOUWpA1LE1gSrLqmSGUjjrnRLdbYX+vdVjIbGs4I7E8A4rz1O+Y2lszPHLyV06y0JJ7CY4QPSKg1mYRgvP0X/fH0YxuigOX0b0YAvymPMDr+KK/GxdsjHc7zyYb3dd7dnVhoJUkrnoiNMlXb6S1eGfFlVDTc4g5exHXg3DmOHERD7I0ZuZaywOqht5gCvs0DkzzR8HZF2AmQsZvO2M9AMzDxmo7DBMV3BzXuI1JCxBPCkzCdzdS8INcRxraqssu2qbA0rt4YW2sg2UqTeKcUNvYCLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knwv+Dz6KZuy5O1RpaWKXm0dWKckLi1TSxQ4Pxp7siU=;
 b=vTciCVTIyYxMPkTZe5pzio7eln6rRwP6jI/EOIwf9HnVWt04I3fuPxYxKgqLGiHFss8YkYdKoNrdYjS0YMPd1F70SWkwBBtA4cr+mSRB/AOjDfLIcgQ38LRF2MuLi+GbHoAKj9nQv5TnREn3a6PX/9G1R/pagWK11dnFJ9tGPC4=
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 06:11:46 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::56) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Thu,
 30 Apr 2026 06:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:11:45 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 01:11:40 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 2/8] perf tool ibs: Sync AMD IBS header file
Date: Thu, 30 Apr 2026 06:11:09 +0000
Message-ID: <20260430061115.10266-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430061115.10266-1-ravi.bangoria@amd.com>
References: <20260430061115.10266-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d9200b-7e4e-45e6-8b08-08dea67f5b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GVy6FNZ4Cct5LOWOiRGc9gutCLPZpFPAAlYNqa20ih7UzIffVTJRiDlSa7Lb0D63h46zqApRPOipKgV6lU5Wc+oSQXXzKR7HrrItWJWn43CdN7wQ6GXXOTe4sqP4mvCQGFIvLcYBG6fELcohfp/xZAqm7fkK6KjrNit9CCifDnfn9ZWXSg9o+9wzh2MmEyVbwocIOc6RpnyXJsO0fFoyVYGnSi6NJxxaPKFmh+e9v5ykJU8VSZZglhNQG1Nw/qtzlQXWeXQdWvFXROU5lFnx4okJ6BScK5go0SzTHSvnmOGL3vELNIyvY3cRC+dmJ/xDm0vBtdU8uo0FVSw3p+dp6owtK9bW26iplek9xXRjXUNyCG8Ywt9YPNciCqZrJ86mN4u7exUkdDJkE1jL85R+yp9kCfZ4MLhkHRckgcuJfijRsr/7UiwPFXt3DSxg/bsPHXjcZ7UUn0tNEzrXilmWhProcTW0hvxGRR+raLji8mdfzkQx6j6K4++zzg5cDotV91jUD685+bi02CDNbpg/wlmqRDolj2pGsI0/K+Ftk3fntggM4SPtMbbZjX1laBv25mq6en89S8D5ITtql9X/goTUcavUPZ29l9KIGcBv7AlB6ssxrtTIlzR3J4UpswDJa0rMx8uMCy6xwN6RrbH93jpCmozK0x1nMRAzJHKaH3hdDLQtVOuienq2frVvJGkTCb05IIaVC6/k5a3kGAZfj6bRYbWy11lb99YgjafRfqTuvIKncLiAdbVhb0bbaU/2fz1bXkKxQL4+KUBjKsu2fw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SuAsDF23yCwsqRFg5ePXSjYez9U+ihW0O1ICfSOczIG0dqxSp1Ypn3vryzJV2l5i+2S7GGbqx3xHKCaq4+McjThFD3L3pMTuYH/lVVFFJ2ZtmrzofAL6Ya/Gm49qyNq7BSUNa0Zw2dbdIbDAFoNZX5OFi6T/508ZVGmjZCbd7bFHai3OnT/+SdcT3F8xTri1Z8g+NMMyrCSpJUEoBokYxMciWSsrBNaLbfIZSMgKSVic2CYg5WFUWERsFHeh0iAT11/hwxZRQtzGRItHvUMRyhjqh72NbcmaIVF19u6D3qERwIqTYS4Aq4g8BGNiBebE8jxIInQPOKfDx+lZv2Sq7IAgMQ9nXfIDjfsnxtrkSgtNMq/kVelJ+vU/OpNqWQdjQ8nsIHrhqRS9UhG8Qt0edCxbN6C3BcbIFxWKrsT6bxcmJ/0pMQrgWAk79cuV3nF3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:11:45.5322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d9200b-7e4e-45e6-8b08-08dea67f5b4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0

IBS_OP_DATA2 register will have two more fields: strm_st and rmt_socket
in Zen6 and future AMD platforms. Kernel header file is already updated.
Add those fields in tools copy as well.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/arch/x86/include/asm/amd/ibs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/amd/ibs.h b/tools/arch/x86/include/asm/amd/ibs.h
index 41e8abd72c8b..c505c80d656d 100644
--- a/tools/arch/x86/include/asm/amd/ibs.h
+++ b/tools/arch/x86/include/asm/amd/ibs.h
@@ -99,7 +99,9 @@ union ibs_op_data2 {
 			rmt_node:1,	/* 4: destination node */
 			cache_hit_st:1,	/* 5: cache hit state */
 			data_src_hi:2,	/* 6-7: data source high */
-			reserved1:56;	/* 8-63: reserved */
+			strm_st:1,	/* 8: streaming store */
+			rmt_socket:1,   /* 9: remote socket */
+			reserved1:54;   /* 10-63: reserved */
 	};
 };
 
-- 
2.43.0

