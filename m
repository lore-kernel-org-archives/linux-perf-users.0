Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794797901;
	b=5on4/b/zCTCd/Wp/U18rf35eNcPj6EwK7IRe8i1Ri3P9gnSYAs2eNQiHWRe+JDj71lOu
	 GQdVGkLdX9IuWtJRUhYFNt4f4xH9TMvyZ+YYWzWDYNo2JSlETYCWtlWFTiBiSRUzQldcL
	 8y7n2GehkoKPTY1LVVBJvw8tyAV9PD8OdCEMYUEDFBQ7JuyWWhQqFwdsK0lDmNNwKjaYv
	 yr7ID3L0iIzAxBp8+HDCVRifL7TtOfvLGLcw2ghceqhncm2mo65UU6qK14Sp/65APZ0L8
	 NOzI7XV7wGJ2TSvzBxFf4aykvGpEPnruKeVtvaDrbLw1XXH7oukkpi9JMS12QWcgE+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794797901;
	h=DMARC-Filter:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=d2em7nzPLtQPJSojdd+nKqhTn3deaCQuJEyo4+tZSms=;
	b=TWTnL5g/DGymS0k0/PEh42CcWso0wNiMvcui3eKsxIqR0ZSBhXxABZvwhBSF2t1jhPGF
	 aTjhsAimEKe3ltvmxnWuqzKaAgWmNnQYEi7P13ZGOFBhvMnwcTUiI0xvbGH1xu+l/l7i5
	 Sxoug+M+oWZ/No23p1wANVr5iNEzipcCKrUKP63+vL2GvymUwVfkFSbx0mMY1HgJXlMA5
	 PiVNAJsiefNDWeAROU5YJ9Irt0AT9K690YgFVThboPxpazOo5vPZxFDaYG/s3YLfpGZLV
	 TNWaZ1C9cvaminBB/IzzGQ6/2SQ0IkGkODk9podivd8IO40VyzmPcYFqBi9imFvR8Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=cixtech.com;
	spf=pass smtp.mailfrom=cixtech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.113
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022113.outbound.protection.outlook.com [52.101.126.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11292606A334;
	Mon, 16 Nov 2026 02:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11292606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/O7Zb4sWc8hPYjV3sSC0IkQzb3RXprJhT4VqM0fUrU4U70mgZCsORddwbFirwq4x9WcHPcQhjjBOssWMpbcb1meDX/G/yZfBJyIPrQmGpu4vcHAYHR4958H2aGLutApUP995SI+/saUdQDKDisI2iw7R8WTrCVu9MDMZErc+f2/LGFpU1Ol/YxH+T2Bed5eU0+HBIgB46+nXTojZp5zmaXg4HW/suzkkqoMbFDM+1vw9vq0CWZDpXkj6ZQZvK5/8KtYiPGg7HIMM+Wpum+nAgFLXAr5V2Jo+pA4QJ7Mw1/3Vi0p9oRwHFXZbvnigVNtbNwDIunVQbR0SKWNXtOOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2em7nzPLtQPJSojdd+nKqhTn3deaCQuJEyo4+tZSms=;
 b=fjrtNq8W99hgWWRdFMrHsxI/S0J24hhmdAY+Zvf3ZvG/0gcnb0ddSJ1o4RUGzcWx9vdE/iA5ahHx8aOLY16cU5VSxjPfWriR1WVAcloZWndHOmQ8jAAFWxYuEu/PCnJqS/LfU1NeWTFl/I3U4a+UeGuq7GCagLARKxWLIXZ6BJ9pQTVMiW/C2z/sHNdyM3wNCe8Fau5ADC22+JlVjtFBQXzIeI2d+GYykrKshNlxtztPd+6AmiOi2emLT/3weeUcbOziCAVM9dtjBhLHCYQW+JRAfVUvJ/r2QZoVnwNZF2ciZ7m7ZbcelkvW1wpdqlas7gQH+UO0XLI2yOBxnrEc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PUVP216CA0044.KORP216.PROD.OUTLOOK.COM (2603:1096:301:210::17)
 by TYNPR06MB9200.apcprd06.prod.outlook.com (2603:1096:405:3d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 02:58:16 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:301:210:cafe::a8) by PUVP216CA0044.outlook.office365.com
 (2603:1096:301:210::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 02:58:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 02:58:15 +0000
Received: from JohnnyFan (unknown [172.21.64.24])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 886CE427EFC7;
	Mon, 16 Nov 2026 10:58:14 +0800 (CST)
Date: Mon, 16 Nov 2026 10:58:13 +0800
From: Johnny Fan <johnny.fan@cixtech.com>
To: Leo Yan <leo.yan@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
	jeremy.linton@arm.com, maz@kernel.org, mike.leach@arm.com,
	james.clark@linaro.org, alexander.shishkin@linux.intel.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com, jie.fu@cixtech.com,
	bob.zhang@cixtech.com, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v3 2/2] perf: arm_pmu_acpi: Support heterogeneous ACPI
 systems
Message-ID: <avpxRZFX4Iebu0l3@JohnnyFan>
References: <20261102084153.3975282-1-johnny.fan@cixtech.com>
 <20261102084153.3975282-3-johnny.fan@cixtech.com>
 <20261113160041.GS9176@e132581.arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113160041.GS9176@e132581.arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|TYNPR06MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 1542decd-c243-423b-0dcf-08df438d75e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|10067099003|4143699003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261102124527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2AMB6foqyk23u3HR/0PBQZzhp4lZyWKjvEzBkLbPg+m64tkuvRX4SNUmxEPd8Fa07spj8YkPd6ikrkQrZTdbht6IXJMys4r0oNJCBBHjPJwrMTc07XGuwHzzWq63ZoJ57nhZ64POznIedCMj5d51TxX6d/hwo4znPdU04EgeXK8BGOY3cwd+YNskypcOaVZVQZGuUFUU7iXD/8F3Op3e8YtqIyKcNTHyS/wnmZd2GcweSjOxYa0zxcLsUCcBjMZasCkR7vjyfOv2PcU8AqW5yINChf2WIN0y199LcT6/k/bWBo0j4Rgbm1HCQnVrmSXlOsoBor8ZcaDAb/l3wmcTJOdJV14F+1s6Pon8WHoM8oJ5lAyxdt0Hu3yWC/W+L1H0mNVp+bpm9My0oZbDb6aK2YmUwy0LRTUErBNdyO86J2cNnm/twx5aFEgfbIrtSXrTipg5VddTSDdPNSc1InQ3OjEvYF+M5zMDeW00ORGnZQWK93B6niGcU5xFsCmk2dPrZtlEFxPoieUhgd1b1NwoScsuWUtViZVGrkRqYdeks05MgN1w1WNz4SqBDC5IbuhTv3fzcXixUAT8eiv8QVArPXSDEk6dDZ11YnI2UuxLamwKcB0vZsJcKNirLZvIXxEnwR6nu4kKh4e/aCou+NUfrxNk3yBL56f3SUm3AAD0+jQach7USK3fV4ytjBZwswgW6rER6KEH6nfW/Hm4eOhXdg==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(10067099003)(4143699003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261102124527099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B6Cdz4ifVZA78aIIJXaKFBwG9CNNJablUxJ/iDFw0B+pf7gF73cpKcrr6v1RWrTqEkKdGy+6uQPjB3MycZk/4L6RYi/xBi/I0j2bd1Fv1UVUd2+wd0NXQd6vTZ67nQC013vx2iFAXjjeRln4YhPbnRHw6B0k7XXULn5hg9nyPVO0HAEPNQx4uJHJKjwPu5UisnzWHKK5Gf5OwD+raLcFXQKv4kMTO9E3iygkfjwTrYr6p2svw85ysZsT4B432tZhOooIBThw7M6GVHVfU5yDUvsRR2TrXyCX/GpoM2oopC88ZkxvgsAVu8baUd8T1tFwwgDsYXiSKc3f1zcZEdXT7xT3fEU5ubBbH9zEpLHwDTvEML0NRBAnO48y6KDWHiXJFrQkYFSJMT4rZD74Rc6LS/Z2CdsCt7EmZTWhGYUmiT6p7hSv5NaseFldMNJvJQrP
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 02:58:15.5275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1542decd-c243-423b-0dcf-08df438d75e5
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9200

On Fri, Nov 13, 2026 at 04:00:41PM +0000, Leo Yan wrote:

[...]

> Based on above idea, I would fold your patch into my series (but I will
> drop the first patch for changing TRBE/SPE drivers). I will keep you as
> the author but please bear me a bit that I may refactor it to fit into
> the extensions. Hope this is fine for you.


Hi Leo,

Thanks for the detailed review, and yes — please go ahead and fold it
into your series. I'm happy for you to keep me as the author and to
refactor it as you see fit.

I'll hold off posting a v4 so we don't end up with two versions under
review. Ping me when there's something you'd like tested on the CIX
board.

Thanks,
Johnny
