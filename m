Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022112.outbound.protection.outlook.com [52.101.126.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A9831F9A4;
	Fri, 16 Oct 2026 04:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124421; cv=fail; b=So6ErC7FyyKkUI3PCBgEgSHVKJWqwaB1fxFfTYP2D1NCaLR44Qd+Ry8o6CCkWKPRPuWo0Ti2RykldDlqsLkpsatBRcnyBpuslhuUFJgE9mw3qPvaEShDLfm98ixhjjGtoYh6ZAnYu5Meqbbi/c+fW2WJuxw4ELm3oqdBxPwVosk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124421; c=relaxed/simple;
	bh=vWt2tEdqMWuOECG8UABnXw+t1J5bIE7S8p+cEvkfAE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWqXiPmez2HGYZ31wt4AxTXrczx2TLuTciK98JGKwlAcVgLDOWUBGbRV3Uo6Ws8Q/WD85+QaJ+ELDiQXGVU0ojvWqVFn5hMI+lyBCbSxlL2hh+4baDryS+4c5/bfSIbHdZhzWBGHO/xeUPjx+gNGpFBuep3T02oecHcqUFG6bVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ats6Oro/zdhKAoRqIMpd3PYZA47ok+CSnQ1wJD9fLShHW4hBZCxWSj4rTUAwzXm7CCX19cuEGsr5WYvLkAYsDtA1d4nAppIrOEP1DxQpdwFpF6MIw0AO7Acj3tmFUHm3+0AMgkCcbdV9iN5jviA++CcfCaaelxRCGhcmcjDnQnAFqENokicVGkL4Paaybq5l/6yrsduklJ1FfRSUX5JwKOFOq6aIoBRhhk6jNKT86zhE5wqWXNeT2n2V3zYdBPc/NQOK+2I2ObjJsV4wxIIxVbGChTD8yQlzN5TTpDoO4hzjlJKGnLL5UOK0u4kmJQkpZ4g4yCTbzstuCIwg4KpOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiqCA4qnLtnX4DF1IZrq2kWLRAqrZAuGv1yrVlnPGcg=;
 b=e8xA6s4jA+9qO46RnY/fz8Gao0Ex4JYAdhYAZE5NkM3ACP78sb9hraOCTgMOzp0O2V5E4osgUpwlUdTRuU/e2psY+Og8bPNGAs/tJ1AvBZhgJWXzX1t4+c7tUCB8HTD1ost3RYNOKYMDHRnuWsbgzHGrb3KRlVCesxRe9bJ8dyhMaJK9F2I5No2aaweDcNc4fzFvw6/+Fu6sF6l4CrB9p5/8ujntUcBBdWs9J/vYL10s7DIBtg89axox2Z2N/Cvic/ydPIYOa73qI1sH7gHHhKVXvjm8BhzhAqsEY7sYk4w/haJUySBnJJl9YsmseJZmOrxFv5iI6Q4xIyUroS5Q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0006.apcprd02.prod.outlook.com (2603:1096:4:1f7::11)
 by TY0PR06MB5684.apcprd06.prod.outlook.com (2603:1096:400:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 04:20:16 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:4:1f7:cafe::8c) by SI1PR02CA0006.outlook.office365.com
 (2603:1096:4:1f7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 04:20:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 04:20:15 +0000
Received: from JohnnyFan (unknown [172.21.64.24])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 7508442C6441;
	Fri, 16 Oct 2026 12:20:14 +0800 (CST)
Date: Fri, 16 Oct 2026 12:20:13 +0800
From: Johnny Fan <johnny.fan@cixtech.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	will@kernel.org, mark.rutland@arm.com, james.clark@linaro.org,
	leo.yan@arm.com, cix-kernel-upstream@cixtech.com,
	bob.zhang@cixtech.com, jie.fu@cixtech.com, fugang.duan@cixtech.com
Subject: Re: [PATCH] perf: arm_spe: Support heterogeneous ACPI systems
Message-ID: <atGl/ZTg49t/VfVj@JohnnyFan>
References: <20261015062908.3565761-1-johnny.fan@cixtech.com>
 <86mrsf1bnv.wl-maz@kernel.org>
 <atC+lsWALy6ueGAB@JohnnyFan>
 <14d16970-915b-4c86-afeb-bfc3058564df@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d16970-915b-4c86-afeb-bfc3058564df@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|TY0PR06MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 4321b928-25f0-4f8a-c337-08df2b3cc78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|261009223027099003|10067099003|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	oOklGPSFVHekC3g5CO1VYL4jaIVEmrA1QI0hluUmgPjThTIJAvJ4BH/e+KiEpUbfaU2hJS0tddnzL1/Md8xgbVFtR7l+hsf+U9GBWIvdMR/eYTkF5GSfom4LAVK1shpR11fE7V66XtXn5Pe9i1Ob+cO7DKn4G7PvsUyPs/a7q6cAufnaym41V2tYwBwPBfjN5moWVozsnw+8eDfmWJV4Naui/LfI0t+ZBvaW7NVuDmFpQzM1vg/uWrtPE9cS1mQd6Vird2uX4aT//rzUM+9a+uf+KEBC0XLG1K6u/x1g8lOGFFcPecH8LgZryquudhr2Y5mGZ3CxNgNb5aW6qUSjgtrLRoxGUHNDdyMhwJNHFDMkreT2NKC30p9An7FTGC7bS5JEg81qt6HauBSXadaWAp7fKZm1Yj9zR1xoZ2TcT4w83soiT8s1NTHfKiW1L4pvK4b5A86NJ3wWKwvANfscgyD+yWai3/vayY8tgWw+beS5vaWI5gllTX9BVO7A9wp+UsvspSwCwfeAzyazf9XPHxmp0riSAabkoHsAlJkZxFSfjDAhmj3YbzmF7OzBcxpplgX05Fo1m6z/NGhgb8gTBdjT0tcBGk4qL5MVEGDccPz1yFuXMyt9CGSfggzj635XKthe6aWmmQq3iYC1KZSGL3IRAz/ET3DRnEn2Yr8yCuQ6ANvj0oKmsX4EAl5xttup0jKDTUBkalktYMVXc8FFzw==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(261009223027099003)(10067099003)(4143699003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uU4SupIF14hTm3yspd+ovLYaKu2TfvRWjvQMvmCGIBEOaFENeaMgR9AZyAQEqGht9np1Ah+/QMvNf9YFjkdL/UPAEOiAyFqRaQtto6iW7g0fQUWerKKVybHVQrJP9j2DG4eUAXGk/MR43tqfORBysyiqtETEFQMZbHnerrp6bwVYEnw65kGg8tkUeI1wcv+0eI/aLdSeHqhI5LfvNT4kUx176/BOy/cinvL+RuTxJBTLjzViDY9CbyPqlsA1FmSilEINQY7r6GHROL9ofO6sYy7AWT3d51oS3c0bEfuycI6q1V1HRtz3KS9lL1P2S7fT650DcWrm5eRePryDo4hki6VwBDq5MCcRiD/BGOS0b1GlXx3vZjVApZEI3ko1x9wPEk35CDX+yI1I/2pDJR9YHajl8NXwqyjBUbFTQfqodPU+RZDZKvAm8LgXSxI+Zirz
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 04:20:15.3851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4321b928-25f0-4f8a-c337-08df2b3cc78d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5684

On Thu, Oct 15, 2026 at 10:58:10AM -0500, Jeremy Linton wrote:
> I don't think the GICC is sufficient, you have to consider actual
> heterogeneous machines that have differing SPE implementations with the
> same PMSVer, which mean you have to keep the PPTT hetid check, and set
> the mask based on both it and the GSIV. Then, like DT create multiple
> platform devices. Which is true with the current patch as well, the
> hetid still needs to be there even if you have differing PPI's because
> it could have more than two differing implementations.

Following that direction, the question on ACPI is how each registered
SPE device gets its supported_cpus: the platform devices are created
without an fwnode, so platform_get_irq_affinity() falls back to
cpu_possible_mask today, regardless of which CPUs actually implement
SPE. That's the plumbing question I asked Marc about -- would be good
to know if you have a preference here too.

Thanks,

Johnny
> 
