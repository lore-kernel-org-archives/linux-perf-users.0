Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012068.outbound.protection.outlook.com [52.101.71.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095E2040B6;
	Tue,  3 Jun 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958134; cv=fail; b=GapWW5jFwmSla5v77kXKVgLrPnswLWvSuVHeZdzja7xvnNHQHQaBWU6NftQ7B6kHGxNeJMgkOyZbQfzmEBqZ81JBnIcebKhOLCG/ZwvidBiRrj8Il8+V4ajJ5CeYtoGj3s4Eb2cvSTKVcwww4fw7it662r1dZdgMkk2W7U7bdjk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958134; c=relaxed/simple;
	bh=mOQcHmmAoMsiEmmibokmV5+jOLuo9hAHkYwDa14tj2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VHrpkJEn15oxBG7aKjflsiKr+0yNkejMaHoyA4BorwasrDtPI81cOpmNlYatKS48aAUHeGH6Uwvmu2W36AhdnfIeoO3MQMJgKtPdWg9Jxc2mSs20MmXpPcGIyYjZfbh4Sl2P3yGfsw5vOBAged/0HxbvcqudZjRbyav4Cw3HQ8Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U8QqXdnX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U8QqXdnX; arc=fail smtp.client-ip=52.101.71.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U8QqXdnX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U8QqXdnX"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pclOtYfGetWDK6+gGQPeKI5tBIUv1A3ddkzI4lVSuLA8BIcbONbo+DKZ9rMU94D1Gz7Ko5hf/puzY3i9qbAb0iaZyvTy8zoRVVCyc0Q2m+azQuDO4L4DN8hxfTJnMnN7rwfiCwZ9osmaPj6v5h0rvnce5vdjV7NvgSBdywMDd0foS8F0dwUuOsbnP+2KMtiFlkzyNsm1Pux5OzetZoc6EEp9wmB4JJlK6D3WSsZ3GIZxFG1bSb9SuJIK4CS7gDqunKGiZJGERlGVcxoc16OR0LSP2SaHNO4G+3UyM5U6qJwl58kPccwkWuTMbnE9h4XIHezlUMPu27O4rkRqR+BCWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssIdokvdy62cR49I2YzeMpnU498rCzWkiWL5rmc686U=;
 b=a+j0eQOYP2JwYrtEA9gJ35G2S5SNKWZYVsQ7fUiiP01u4co1lN52+MV8P2D+uGfOV03wGrrz3T8uMr32Eru+89T57ZMqhuBrOJZvepLLOsQzNlbtZKZ+hJJq4pJW0DgFSwKL3CL/iy4f3HDFrgpKQQ3KMuSmwYxbg/tFzhJ6wROPgUVx5XSy0pZku6BaPV/7zpfHacZ+JoPI3NqWiMKryjv1B8sUVcwEtl1cypXDuP35LAaZNjQuQ5Ar6TjXeNoFh85KhCREf8VhcooH+CcYP6X8VtRJcTXPz36Qsw7gAFMK7NTQR8JDcy8S4TscOb1t8anDJVI195okGza0xq1FgA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssIdokvdy62cR49I2YzeMpnU498rCzWkiWL5rmc686U=;
 b=U8QqXdnXGk6W5U07Yhe9NFAD1FDn+A8aI5WcnxErZJUSXH6GNSGwDzr5WGyDIwIb5Mmw5wPJoX6HejXU4AMdx9E7jpnuukpW96DFnXWQyIIYihZbefrsrpVnj4rNbQ9KWfufwrFyW8BCihMvmnpsx+7Ve09tjgyYsdGsxJhb04s=
Received: from DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) by PAVPR08MB9082.eurprd08.prod.outlook.com
 (2603:10a6:102:32f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:42:07 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::67) by DUZPR01CA0023.outlook.office365.com
 (2603:10a6:10:46b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Tue,
 3 Jun 2025 13:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 13:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMPYmSjLqMERDCzFnOl/IbQ0LLwN7mbU2cnw3/1CalbRBTXTTSutYGnQ3x2DoQVGALns15kA7ifL8+1Uo1Fy+DAsKusQo6BkySKJS53tWqD9UyZNVg0pDvNOjiSBjGKmcmHIPVhs0b9yoJEozyHsmN+9s3MU4pfxLcjsRpdqNMww/jIlBY4KWq/fNBh6t/6Vh2bhdnbq2fkPNbXtHS34mRPJecZvaIoH5kHcwWAxwRqHuqZttaQ+osQK94zetu+kUY3aeCsHmZp4hc0+rpSKaWJCx58zlFwtSF5DhDaLbTHcyFVA6C49D8IHFdJczMuSWlCWBPvQ0Ew/K5cGGk397g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssIdokvdy62cR49I2YzeMpnU498rCzWkiWL5rmc686U=;
 b=Ylbb99NDYrNOJjVL5bYK9WFLXWkRFxSTMzAvPSi/tB/QZKDLx3ZJWFw2hgagOsx/TGQc83V9D/ioT7nePlxWw3o1u09G7O+cpK7CbDDdWJFv3OM8gooJ0X1uQNy25D6W5sosFMPXTmXT7L6k3bvW0ZUPC5vAYm6K7YnSIu3J6H5yBtLR5O9ty5+0QGg57ejsvVUZuU+S24ytt9Vh4LLkoaZ3Oo/VvKPDd696VhDAvhGYjOMJ7fru8aBhUh8Q60doQdhB1YcBw6dZA1uA+JeKf0CeAAaOapOdkBZpFGfOiMuUfPUFwBasXBqq6/d8tDLDCuNb8se+fClzz/UneoUDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssIdokvdy62cR49I2YzeMpnU498rCzWkiWL5rmc686U=;
 b=U8QqXdnXGk6W5U07Yhe9NFAD1FDn+A8aI5WcnxErZJUSXH6GNSGwDzr5WGyDIwIb5Mmw5wPJoX6HejXU4AMdx9E7jpnuukpW96DFnXWQyIIYihZbefrsrpVnj4rNbQ9KWfufwrFyW8BCihMvmnpsx+7Ve09tjgyYsdGsxJhb04s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GVXPR08MB10713.eurprd08.prod.outlook.com
 (2603:10a6:150:14c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:41:33 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 13:41:33 +0000
Date: Tue, 3 Jun 2025 14:41:30 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aD77ih5zOrZyXVit@e129823.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619d4d6.a9c9.1973543d6d9.Coremail.00107082@163.com>
X-ClientProxiedBy: LO4P123CA0625.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::23) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GVXPR08MB10713:EE_|DU2PEPF00028D0C:EE_|PAVPR08MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b1c157-8d98-442a-eb0f-08dda2a46ddc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?vpyEaqnN6dyqoi6napKzzjGA991RB3xm3L6v43gv/WSAVk5YblCdSvvZB1G7?=
 =?us-ascii?Q?0O7eDMRvUIcC9tFCdI5ODm/5250GMLwofJebaQNJMufig07s4EeRSAbH348o?=
 =?us-ascii?Q?gEGc+88XMB6gGsf1SSOQwdBGY/T2DFbaXiuoIwcVpn8nfmOaNc7v0Iou9yny?=
 =?us-ascii?Q?6c43L46YxokIVAG6kFfKtqTsp+TYmrfqqNzJ9x6zf9ju2fMltzFgcAjVR14T?=
 =?us-ascii?Q?1/lviNQ7eDDa66C9J4aOGFXe3UBdzNn2eSmdG3nKWYZErCpkFUy9ObnO8ydi?=
 =?us-ascii?Q?Rbf8rvaPdhl0LWboDYc2P5FKnc2r2QtPysOvSvW6hRgTs9UWUtqk2bv1uWVR?=
 =?us-ascii?Q?1bwjKvjnVowEgI2sBzoTnuJIW1nX5vCdWc17h20+BPDecuYtDUkobWmoBsVr?=
 =?us-ascii?Q?NpZE0nTeuiJ8tR865TRcSs5ZBNHVJB7aayJYTfhuIqKs5GsIzqRA08p9MPOo?=
 =?us-ascii?Q?BGRLRqHDYHBDdC2Q9ZQ68rqVJCS255ePlYmFdHAEmORV7RGQy1VmpKOZA6Ak?=
 =?us-ascii?Q?sHlVLlSNMb8aDhYb5RdJqJS4exzCH5xzsNvJbCBwxlUL6VGUpNPNMySHyR9G?=
 =?us-ascii?Q?io2dSxijxkqSkw6aDrYKWtsUuNNT1JKhHC/fo0CTqvIZcdZKA6GilGqeuvMV?=
 =?us-ascii?Q?UPxpNa/+MGhchuaZuBrdvkJ4dyaj4qXcmHdrD7pfiri8bL+QTGumA/uAQLSk?=
 =?us-ascii?Q?Ij/DPl+ZGiNWb++c3CfborwuDrIKI57QRiOTBcWqqXercU6+PIXIfSJH41JJ?=
 =?us-ascii?Q?J579dnDRA9dsjbd/jdAplChkDyM589ojusYCLWCrrZBGVr8RbOLBw+xj3DLT?=
 =?us-ascii?Q?myiJ8N/lL3nLmdBQGkT8H3489Ka+1VHnViwI90Ah52uH4eUtth+EGpi8RC8K?=
 =?us-ascii?Q?/hg+J+5eSZil97OXuIGYaWjtikPmttfNkxSIryw5wOtK+e7Kk2B0aGLPM0hM?=
 =?us-ascii?Q?X3DyczzlOjB0j55x9DXCQE6HmiDEBLed2TFaG2Njw0bGY2MAXW5BxOTrn7N1?=
 =?us-ascii?Q?rk1QrhC/Z8vT8qznXaM0+tRP+MIa3lVVV6cGMDyl0SufwXK/CSSXW8C8RNaT?=
 =?us-ascii?Q?+cm7r9hZ6wx6L0Q3ZFSmSvQwNXOBvtiXHY9ZlHkgm/pA3gY0hndmCxeVUTQb?=
 =?us-ascii?Q?hN0YxOAcsDRs2BPBMOQlQ5C8MGp0APl2ldzXz/NwQOb8BAqhTU7IbnImv745?=
 =?us-ascii?Q?2QwAOe1QjLCLWsrgAMmhgsejzD5vuNTdGVmMYTSIAOM4vqI+LHPsvmPPoKXy?=
 =?us-ascii?Q?M36X/mOH45ZAnGZCLlFKIhB4LEUYhoR8euVm7zoRm/u1rNEaKeH0x4e+ySP+?=
 =?us-ascii?Q?YfvBC+MZB8gDCQkmGCQwHH7du7DzCy1/wLENIkQsAl2gsyCLMruA8hlBi3ie?=
 =?us-ascii?Q?jR7bqUiKOj91xRKOrd3uBQwzqqn0f4vC5GRGFgqZ0CqvlyCOqxLnSP9oy0vC?=
 =?us-ascii?Q?AmzOl7DuzwE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10713
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fd984f23-63ac-47e1-48ca-08dda2a45a35
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|35042699022|14060799003|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqp7B+N2AZclbwXUmi5HK46EDecxAWu6vVFqeZbmYIqk2ppCIeUMex3Wc3h5?=
 =?us-ascii?Q?gvHH/y4HrhRTYCaytV8t2fweyRBlwRYrU8MmK77iQ1tEN6itHDy/WbCYCCdD?=
 =?us-ascii?Q?8nnneena6oZzqsgTfmPMtcdKhJqvzgAESUIghJrUB2c6MsFBdwCsuBEl+JSZ?=
 =?us-ascii?Q?gqEM1DUQVL7iF2kegirs2GUP7JnR+2AT5ph4+hebnPsnYhXEUQVpqfufG8Vg?=
 =?us-ascii?Q?5N34tSkNo3JGioRRvkFOpZZDs5j9ZQz4JPRHuPKpmW6h/JnvHCElTXPhmHm/?=
 =?us-ascii?Q?GkKEsdqmmPjUDYatCa8/vZ94DH37TfWWjO0YwUnxcEHYWr0Hm73/wuFreE9w?=
 =?us-ascii?Q?xQIwWao9MPXkWc53x79UDrbdOh3mu+wU36xx8KrvDd+U8xyBF5CkGS4ngdpA?=
 =?us-ascii?Q?AgYuktHvXvhiN0s3MNbXl7bJehCkiPwcZ7h+fxPWhWrJy5goZ/EKR4lb2te4?=
 =?us-ascii?Q?jZNesA8rOWQ6d41Cid8ZMG3/dPccBa4YHSIq5GFO/DzKKdsPUGByWYo2HivW?=
 =?us-ascii?Q?L9PurHdiMZaIYO0Brd08uMHvBd3+96+p/6oRdGOs0T17WLcUWq4amWn8W9ec?=
 =?us-ascii?Q?4AX4jgdzySManbG7xJGzv6gr1sQgcbD0g3oRjBBuqZeq6XVcCYLyNpBC8zqB?=
 =?us-ascii?Q?uqXkxQAk2SZbeJ3ONkIJ/dEDZhHvmdRLjYG0U0uF2BgqYUiwmG/u1tiQeYec?=
 =?us-ascii?Q?TAWblCqfkB6XZieHmM9DrgvMaF0V4aBC73uGw8SoB9fKjSXnrypZiBzcPHx+?=
 =?us-ascii?Q?6Arc2FFznHOd8d//dRXAcrv6VGmLCKvekzBo2Fgs4qu6uu6Yl9gBUVdzD9QQ?=
 =?us-ascii?Q?CyttL9TMV+k+7kEHG8kFAQFeqKiiL+P+mU5UgZWwbNLHtmh0XhKZfAI1wZFl?=
 =?us-ascii?Q?lgSEV9PO9c3u++NiWPL2BkaqYxEc23SK3CY7m9b3yNYkGU9GtX8Yrv+UA0qu?=
 =?us-ascii?Q?VJkx4X25NqLecudAq90PDd0VCXp4o6dKUjvfqxMN5mMlS1whcQffxfj4k1fJ?=
 =?us-ascii?Q?11AXd1UFZ6Ujzh+jK/ZCmybeAUX1GlBxXkqtUQLtVDz+FB5CfGKTmNKMb+pS?=
 =?us-ascii?Q?8S7c0yPGy00vKn5z1M1V81m242FEYMMM8mdUcXXFN09dG2QBUHQ4zDsoml+o?=
 =?us-ascii?Q?vHdsc5C5qDe4PI9hUjQSzM411qDL2bcDP/iJ34avjYiejCGyZgP3DL4zd4OB?=
 =?us-ascii?Q?AoXl3hRAw8KlLC/nTou4OR8EyFvBWiXsWtU3Dt6XRRhIg9SSjvO4L8RpVB+r?=
 =?us-ascii?Q?ekWZIxd4Jh5mexW1H0BipQQw/HNZzQNrhvAT63U+VAHWn8gf1C5igp7ssHnr?=
 =?us-ascii?Q?d+uWZhYic0LSxX8g6CSCegK52630DIypKBasm/Si4lebHHLOSWUN/gm4Nqe+?=
 =?us-ascii?Q?QkM/ouQX2b+pnggmsYa7+h2KLQgzIk9MXmOTkJYPykq6NDexYPR1O7WJ30FD?=
 =?us-ascii?Q?7cJS1kkJtE14MxEF6pNd2CcUjHt3S488fb3JtvPHK8yV9xym3oaElFXSh2ux?=
 =?us-ascii?Q?b1Fr0FqCRmWLgIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(35042699022)(14060799003)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 13:42:05.7022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b1c157-8d98-442a-eb0f-08dda2a46ddc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9082

Hi David,

> >
> > > But to fix it,  isn't following change less aggressive?
> > >         event_sched_out(event, ctx);
> > > -       perf_event_set_state(event, min(event->state, state));
> > >         if (flags & DETACH_GROUP)
> > >                 perf_group_detach(event);
> > >         if (flags & DETACH_CHILD)
> > >                perf_child_detach(event);
> > >         list_del_event(event, ctx);
> > > +       perf_event_set_state(event, min(event->state, state));
> >
> > If perf_child_detach() is called first and perf_event_set_state() call,
> > since the parent is removed in perf_child_detatced,
> > It would be failed to account the total_enable_time which caculating
> > child_event's enable_time too.
>
> Thanks for clarifying this,
> So the whole point  in commit a3c3c6667 is to make  perf_event_set_state() happens before perf_child_detach(), right?
> I feel I got lost somewhere when I rush to this suggestion. But I still don't understand why my patchv1  breaks commit
> a3c3c6667, really confused.

I explained this in:
   https://lore.kernel.org/all/5d17f1d7.666d.197348b78d1.Coremail.00107082@163.com/

>> If there is specific child cpu event specified in cpu 0.
>>   1. cpu 0 -> active
>>   2. scheulded to cpu1 -> inactive
>>   3. close the cpu event from parent -> inactive close
>>
>> Can be failed to count total_enable_time.


Consider one event which attached to taskctx with specific cpu.
In case of your original patch is for only "DETACH_EXIT" case.
Here what I mean, the event is "closed".
In this case, based on your patch, it doesn't call the perf_event_set_state()
before list_del_event(), but perf_event_set_state() is called after list_del_event().

Thanks

--
Sincerely,
Yeoreum Yun
