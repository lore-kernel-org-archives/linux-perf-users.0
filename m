Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AAF2686AC;
	Tue,  3 Jun 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935046; cv=fail; b=uNGriraRid1+Gc+OInaY8QYmPCEunu4VMI1ri6iYtnXDZbJ/jrGwA7J3hfUqbJNq2i9KSenVqpAwDredpim0VZio/WDD/jzP6TlgrpohcnWjD22c9F03tiTvSAd/xLxWtgCL0uSi+XdIArY3Lf5K7JWeT22WHIwTVz/onU5iuKc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935046; c=relaxed/simple;
	bh=RMZeeXSyWaTX02cPh+wGBiG6R0JncDzoqTRp9uLWTEc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QEgslDv7LnpGE/QSOO7918+TC2E203yb8pAfPZU9dVrDOUReNtgTd6JtWTuNJprBMwXBlS40MZE4pAxXunDCWgVo9gwFir/sSlEAKw4r+/nNFhdL44uO8l9ES1pDeUrwBJb0RIo2UdLfR9tLSxThKkJPpKmitIxrAYeo2rM5P1s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OxLIyA1Z; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OxLIyA1Z; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OxLIyA1Z";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OxLIyA1Z"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IOBhKH+hFQjZuJwItjCOYIPGYA9cMZGvAA9gMN4t8izN573XJMMVCuUgUxh53xHzHyhMT7DSKBtyqXDsLT3D7PXThIuHQp6wBiOu+TnBpFIogxbTJbtwNhvdptmbd2jPgl9JrLZypOny9f+R+3+exdDpVJaLISwb6TAyCjQUVTT8QNI1ubjzx5gq62DydDruo/sm5VDnkVBmigVz59QB0yvmBmXfZsgPHfXKkAG86Oj+Bles3Zkj7mfKXg3na/dk+2mSBmKg8NZoRzC31FXkmU6eeJaNdy5tJuObyTgdv5cnjuABdXHMqkP8S8+AMOvlPVZjuQKRXujakBP8FYRhwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI581lGmatDQWL/C2R2L+X0zHglhBjNWy5P/6hEVOc4=;
 b=GAau7+Zm7RSPVp0j9ZgEj+1zQdalLQAvITHeNwOG0Vzls4udL2n4AK9nVkG3dI6scv7MxLCRwRUSGs9HH85QkFjfZp15avz5P5D4v6uNr5gNsS6x2t6vqSJIivcYpRNGMk2vo2ZGQ5HdZfiqLBUiXhhylpvnsB5+vMV7IB6b7J1j3z50ou5DYC9BpMAWLOkAQTw7+wsM8bPMNyMv89Lcbd4VjpS6O5d8KpcHcA32kulDsK9V4q8GyHKXPEYAqqo3sDjjvaB96irvc0yVBcrmMeS0bZJ+mtZIVRDPZ/gWjYLvnfddwJI/thfdQJv9BnwOa5yZGXJ8wzYxCsmb7F+bkA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI581lGmatDQWL/C2R2L+X0zHglhBjNWy5P/6hEVOc4=;
 b=OxLIyA1Z61eWzGSsEPVY0qxqSQElnFLdXurJo9YRj1XnvHTCNhFMYLF6eAKnq9YUqrAlSSehbFggf4vgN8EcBlOxI3JmdRRIL9bjMW1ezq7g0Dr5DvA2VrD8Bdi/7F1Hfcb2eIzaPPJaduzwGHgEO0tIFDupr9IEx4FIikL1GvY=
Received: from DU7P194CA0015.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::10)
 by GV1PR08MB10979.eurprd08.prod.outlook.com (2603:10a6:150:1f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 07:17:16 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::6b) by DU7P194CA0015.outlook.office365.com
 (2603:10a6:10:553::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.31 via Frontend Transport; Tue,
 3 Jun 2025 07:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 07:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfCdNX3w6UZg5+rOC/pymHtghOQM82n62D+bXeZWUhZ97sYs07hEBU13goKa37NyKVSfLEU6jXYSGlhBrAk6cSh/89tPRhDTJp/EWatteF+SoSyWQlC49CC9l8656K/ad1rgL4VCmODB9Gc15Hv+Pqmj+xOjea+LwQwEdrnzaILFmeui3DTDhRuXAIix5ttDO/WRRka7TZTau09pGSpdwRo8pH1qQl0f1Zp2lblCRe6bpKb+6F/vR6A3L/9gzIWOoPEAJ6DL/q537KkK934NGzjmPxgOGnT2t/8vp+cP+0L/MBBc4KssFcMmVu9rtx2pMw8WMf3rPPpMlwDvpOXxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI581lGmatDQWL/C2R2L+X0zHglhBjNWy5P/6hEVOc4=;
 b=mt3g9j+kU7gG3tQCL+DZyfAjpbSFc3jeDrsp1BPInnf0GeffLbA/3CkExrlhhoJlP7m8W+aXqd+w/yZD8uf6EsvECHlOI7T31Q8p9YJQWfZNjGpFtLrFDd52AjFDjkSZvyxkvWA6Hz4F7Ot9EVh1JUvQ8fwMTPBuqpgs+67F9BRdmwe/aPQvFfFx5xU64jgn1Ql+NPKKXA8DLFjVzfYjXyO3SLuci866GkRaRtREbptVvJC5THE66lInXraW2p3uqeo4g0HiZtd9o0Fr7C+GcrkKOhSTh0k039qCAfD7Inw2IKw8+MLq9YIM/0jzkj9p6w7HGLd3TNXMdXW1e55uew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI581lGmatDQWL/C2R2L+X0zHglhBjNWy5P/6hEVOc4=;
 b=OxLIyA1Z61eWzGSsEPVY0qxqSQElnFLdXurJo9YRj1XnvHTCNhFMYLF6eAKnq9YUqrAlSSehbFggf4vgN8EcBlOxI3JmdRRIL9bjMW1ezq7g0Dr5DvA2VrD8Bdi/7F1Hfcb2eIzaPPJaduzwGHgEO0tIFDupr9IEx4FIikL1GvY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB9232.eurprd08.prod.outlook.com
 (2603:10a6:150:d9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 3 Jun
 2025 07:16:39 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 07:16:39 +0000
Date: Tue, 3 Jun 2025 08:16:36 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aD6hVAuHGNZjrKpr@e129823.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4939eff.64be.19734874658.Coremail.00107082@163.com>
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB9232:EE_|DB1PEPF000509F9:EE_|GV1PR08MB10979:EE_
X-MS-Office365-Filtering-Correlation-Id: 5345a0cf-69b8-49ad-7e1c-08dda26eab45
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?MQjszNi9XB6RryRfBGBTpIVtWUewaUXiBi0mdgHh2udD9Q8STIjjFQZ+AB3I?=
 =?us-ascii?Q?yexrHS4RL68rGRuz+iSUBANo3hKw65+y3/2z5YPOcvjAKjuZC1IiQx26kl6e?=
 =?us-ascii?Q?KnuBShKj/Iqp28vfwv3AY8Xf/icSuuy6XYT0SdWqjNikruo63ikkQyQePY4J?=
 =?us-ascii?Q?nT8vmIpK1Bws9GlDCUD8WT8t4/BeawTYav4IT1LCfVzEgYkC1gjbMQfOt/q2?=
 =?us-ascii?Q?I4MZjo7bWe4Tt/Bzx23BtHMoX4Cisj+Jo0bOLoFej8Th63ae+d0d6756DuAx?=
 =?us-ascii?Q?PUdd3jB3xBoz1w6RSpuglN/Ou7wO7Mqg6U2IBHwjp8yIN/TYQ44HGLil8awa?=
 =?us-ascii?Q?6doXEoDShN7zYO3LSgZoGpt1KjOrXPVGIgqtVmmFYovozR78eYYBWLIqE/6K?=
 =?us-ascii?Q?PAna3DocQC2wPptD19Z48vAE+uoH9pW/KCh2BhNWE++/HDGsmXOCK5t6XAt2?=
 =?us-ascii?Q?nc7AvDGm2rZTYa6FUPZQAT+tZ2UuNPrXZetLnCjdVFtlrdMJl29SfPrJb34M?=
 =?us-ascii?Q?cwAi7ukoCBRO/f0nFrEeB3JCHvRJCAI/YFh48o4x02FMEX0R/inH6/wIiyV4?=
 =?us-ascii?Q?iPYduV2563kThEpd89ez3MLED67mZHHDCngg/IzFd1SbMBWtJlwinpMhuWBP?=
 =?us-ascii?Q?xGJevUQWyrLhhjk4WTs7U5b+KnAYBg4CyI0m3ibxIJfExkm/cBqkgKkhJ16s?=
 =?us-ascii?Q?QgCsbbQXibxq9hYBo8Np8meOWHu11KeAGUptJRw98UIxYdRu7UBLx/W2Zz+A?=
 =?us-ascii?Q?JoPw0KYNfaAs424uHhLRd3LQpYTC/s5sOLy84uRjY3brsAOWmtsEQE8hyQbp?=
 =?us-ascii?Q?gpw3GeBy3ZknN7n6LmFWMG91okTcoD5kEYON90Kqvw2sPnlh01NBZ9a05htt?=
 =?us-ascii?Q?lzanjSCKQUjdYnwpCh0VS9uvHyWsUszDtpqeLV3Mc4lFiS0GYlycMSuZPsUP?=
 =?us-ascii?Q?ifXc1nH4HogS6DGCPJYObwHx2TVW5tEftHivRKglzCoRmVx//3Lk6JGUGBoD?=
 =?us-ascii?Q?W3OpfRvA1e/AA4WBCMe68dTfRyNabbsqWFVREJvb2KnuAiYSwXMtQY4X/jo5?=
 =?us-ascii?Q?KpIWI7Udykk6LPQ+FlprARK63H+pyyvfDSOYEFMlYTzbSnRNSI7r7ZLQVGJ3?=
 =?us-ascii?Q?Cw9TQnuL7M9HQ1n5fZ+Goh1FLPJHR9JR+go4lylvL54Bm6yL7MMQ8vhcftzu?=
 =?us-ascii?Q?fjt1eV6aiQtJ8qJMG2F69KbTYo/RqcnVVl2dxyCkG5XlD0+S9HCy+tGIPXih?=
 =?us-ascii?Q?DecRM5E5/H3z/AgUGXepJy/RHIKBAreIrro7DgpMhuTaaF2H4mwNYyOdctcF?=
 =?us-ascii?Q?uZkzquxWlyoIYcUwa+xAhEqtmQGU3Og+0JlCDViD8WeqRvmlSMJtLl9+jCH2?=
 =?us-ascii?Q?k1UHjtF9jQ5q5NYdsmos4GyUIXAAjOJ3072UeME4JNZtOtmVZBmZUGXB1TTE?=
 =?us-ascii?Q?c4612st66qDls6FnVC2qVLbnOOrndF8vIzUfJfOrL1y0+u7DagC5gg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9232
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6c0cb7f3-9453-43f7-2cea-08dda26e9509
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|14060799003|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vfr6hQd7caBr/mXbPcYLOfJhv2xALfNCXgZqBS2gShxnSHIJ7jlyHv+QPLn1?=
 =?us-ascii?Q?njGdf8qbdnRNrhUaUdVBpqGepHnZZFnpjjnTUoFcgB1zSJav620cx4ZLrcp/?=
 =?us-ascii?Q?AFU+l0dRg2+kjLHKXe8bSq56L2Rvb4o3v6+Ns2pPY3JTawMWyLiB5Ezm3O63?=
 =?us-ascii?Q?vx0PbozZvEehtIQ7qzUPHScNYMK0cNEdNa8WH+LEXkm17hZTZelIkYEfLDSM?=
 =?us-ascii?Q?vjFCdsMF2L3Hajq911QwPUY2+pBboonAI8Y3DDa0YTzJ40MsM/6a+CJYJ5t0?=
 =?us-ascii?Q?H0LQY6E6zkPL2OS2j3i4gTU0nmSfc2pm8faSx4h6EP5ClxK3tJCExXBS4wNv?=
 =?us-ascii?Q?yUHNvC7/hin2CRTDAUcroPrML/mdshqblM4TT1234VOCOjft3aZEg4iXE4pK?=
 =?us-ascii?Q?4u7vgEdk09VSbSmx/84UwgcPt9NET8BhUqWWBpgdboW3s3LgoKMl0dXkbAeq?=
 =?us-ascii?Q?I7rcHQyi3M3qP8SvV50ch93dhiukWeytxiqPwthYn9h+UVktVS+jpPlmxLbo?=
 =?us-ascii?Q?qZ99xvZymsN1xEjiO/5zGUzvQMvFu2KwcCuUZlR7O2Vtwudd6LciLAs5r/1H?=
 =?us-ascii?Q?w361HSY2Esb3Qyz/mr3ypQewZu7C1iiRhLiS+bOFeM2LdeuhSHnz/n0U9VN1?=
 =?us-ascii?Q?DX5fQAIbB1+hEk7+qjbaRNFTg/fPlTZ163rLvPmz34alNOp7Oj/VZU2fzpWW?=
 =?us-ascii?Q?mSIrIlMc14fICaiA4D98wZiXkDYalSrWYWlD9oMDUzcElFvBSOa3hIDO6HXo?=
 =?us-ascii?Q?ztGKJPb7hGpqkU9RrIrbwMrhqpRbzDfSosdYIshgvZxqqaAmn3uPRsEMFsFA?=
 =?us-ascii?Q?0ShX6hqIuCrw6f4ShXSn628dlDPmm8nAnTEXWG179MLqLQHJXZv3jU8fM6tt?=
 =?us-ascii?Q?U5cQMZ02GMXZ6bZNi5dy357ZXSNbWW732b5aDSZj1xdaoWjAXbXzjN9b1xh2?=
 =?us-ascii?Q?+0tlMTnhBJZM5AdWISkfh5jbHDTAYLPXmn4qMOCLTl+8UkzoOb+6I531n2ds?=
 =?us-ascii?Q?D8Sajo7pKgwrg31G01UMoUeqjNMqyToJF7WZpX+Hsmg5HfBBHOKodBIGj8Tx?=
 =?us-ascii?Q?Koq8Xx8KhcmpsxgkcCeT5U1FpznCn+A8XOKHUs+sDu0Pcsveap2asJ6mYCjp?=
 =?us-ascii?Q?6XW76G06FjIJNFwk69ZY1Cl8a3IczKCL2KgA0CpIL2WbE7bZ41LdBZsKBKuE?=
 =?us-ascii?Q?bTxIIdYroqN0j/kzKxgqW4/OHlRTsyZ3HJJF0WLTVBRoicZ8eynAZ2pFZPTe?=
 =?us-ascii?Q?FvIwRxnLFmS8/6yuvcMAs4zbi/2ji08sEuBrxpUK6NB9cBlhYEUS/8klet5P?=
 =?us-ascii?Q?lO55mFTPVn772+jD1iW2UphDURHBI8NYp8CKJG8gn6zKXRGLLuP4kIt/fGK/?=
 =?us-ascii?Q?AhltTb4PxuWzyPIUEk7e/fpysdTeEkyk5xFYYC0cCkTWhpJ1TpFpmh9r6qWt?=
 =?us-ascii?Q?5rwdA9o6WibuOSsOKFYfEEilj1KHs2z72lj2jeNlWwlCsRHaKDRfvnUAVXSf?=
 =?us-ascii?Q?BPYxGsJY+01uhROheiw1bIhTW+m0a0EGMEBfI1RaowpZizjCurrPs2uDpA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(14060799003)(35042699022)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 07:17:15.9055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5345a0cf-69b8-49ad-7e1c-08dda26eab45
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10979

Hi David,

> >
> > >
> > > Also, your patch couldn't solve a problem describe in
> > > commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> > > for INCATIVE event's total_enable_time.
> >
> > I do not think so.
> > Correct me if I am making silly  mistakes,
> > The patch, https://lore.kernel.org/lkml/20250603032651.3988-1-00107082@163.com/
> > calls perf_event_set_state() based on DETACH_EXIT flag, which cover the INACTIVE state, right?
> > If DETACH_EXIT is not used for this purpose? Then why should it exist at the first place?
> > I think I does not revert the purpose of commit a3c3c6667.....But I could be wrong
> > Would you show a call path where DETACH_EXIT is not set, but the changes in commit a3c3c6667 is still needed?
> >
> > Sorry for my bad explaination without detail.
> > Think about cpu specific event and closed by task.
> > If there is specific child cpu event specified in cpu 0.
> > 1. cpu 0 -> active
> > 2. scheulded to cpu1 -> inactive
> > 3. close the cpu event from parent -> inactive close
> >
> > Can be failed to count total_enable_time.
>
> Is this explaining the purpose of commit a3c3c6667 ?
> I am not arguing with it. And I also not suggest reverting it. (it is just that reverting it can fix the kernel panic.)

In commit a3c3c6667, I explain the specific case but not with above
case. But the commit's purpose is "account total_enable_time" properly.

> > And also, considering the your patch, for DETACH_EXIT case,
> > If it changes the state before list_del_event() that wouldn't disable
> > related to the cgroup. So it would make cpuctx->cgrp pointer could be dangled
> > as patch describe...
> No, I don't think so.
> change state before list_del_event(), this is the same behavior before commit a3c3c6667, right?
> And no such kernel panic happened  before commit a3c3c6667.

That's why list_del_event() handle the perf_cgroup_disable() before the
commit a3c3c6667. However because of *my mistake*, I've forget to
perf_cgroup_disable() properly before change the event state.
Yes, your patch can make avoid the panic since as soon as exit,
the event->cgrp switched.

However, as I said, the INACTIVE event could be failed to count
total_enable_time.

So, set event should be occured before list_del_event().
And since it's event->state change on remove.
It shouldn't have any side effect the state change isn't cause of your
panic. But missed perf_cgroup_disable().

Thanks.
--
Sincerely,
Yeoreum Yun
