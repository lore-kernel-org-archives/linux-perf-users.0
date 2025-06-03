Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359E4A1E;
	Tue,  3 Jun 2025 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932543; cv=fail; b=RL8Ffaj/kS3xLYY1Cq6LNa5Wr9cUSqhj7MOmmMAJ1U1+5jsQiDIui8k4ewXt8kLCpKo38sJWsu6V7V0+piPC3H5tRlq7t6sPy07tU1hFzvJNy1BS0nnJeirJPyuj41JKdeat3uffAp4JTCNC3CeOqhcbAZyTpTv6x4viTt5olZ4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932543; c=relaxed/simple;
	bh=tw3EJxM94zCJnIZMgI/GxugeaQcRu9AACWSiX4/A4FA=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=os5YlNLzzyLRsLo8x31uQ6rC7/H9NEigtIE1AEyYwcP0cWSx85MPxeTTg64AXxQMfpcNQCMlbCGth50GPvCOAiqLyBDNZ27vBmxqcZ3BAnYNozPghezKIaFFsMHwWD9ljPvNrZ7xO8AE/zpPHCRL1lWawPvjrn7uVgd80IKx+RU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rY2yI3Vc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rY2yI3Vc; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rY2yI3Vc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rY2yI3Vc"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UdsM5naQAad6nbBFTFIb3cedoiRoWAVDx7CsAwPcnBWDT4cuu0IVoMJI2hPR5MDvtRnLN4xG437pJYym1yrq+H13f7AfV13ymRn2q49dDiJW2/gGwQ4UymgP1yNcljIqyw/XYuARMlSe/ueIORd78LNuOnjvBoQuGMdRRTDKbZBCLR/UBLSdIVzG5ebPMcu84xUcWc501aCVxJ6oiDrZNRF9V4G3lAO6h7CCLimwQrnWqDEKNxUkLPsgf/6OFfmaXbDA294XoT+W0FS1H39Nc25xO4IiwbWW5E/jVwPD9L3enup7TvkcVlcNAOJaYrEI1dZgqS+1jH49nHnx/T/vGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLkpYd+s6ZpD7vLmF/oYPL9G/VsjxdMontnUWq7T4Q4=;
 b=BYGseB3h4+fiZopnU0JUsx06xbEKsc+mnq6aDOp7OW1u5CDDv45Xb4v7KAtfSdodrgVHxokTwd4loi9pxnTDOUhxzk3nFumInZe5zRfaR6MPJSOQb7K0bTmCaRXtjZXgt7MFLqxSM8LfEfh5OJuERl1biBqKQooqKKxOUzi+PSnYh+vSy/keb4IH6SXJ9CPHfHn0v+pQgGj6p3n1jGXdc0UEqlDC1rAV7NWI6PY/RW5Q/rDz7bZey5+KZClE7K2JMtG6v6wBVYJ2vBNcmYzB/eElmU9VKo5iarw6ZX1kJbDYCWtM9dn6ATMHpXH0IwUZAdLD/cXj1LR0DRp+TvqH6g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLkpYd+s6ZpD7vLmF/oYPL9G/VsjxdMontnUWq7T4Q4=;
 b=rY2yI3Vc1J5CUNP2hnBtlzo4EXNl4awGMQxGvfQMKqWWqW6Rfw/BF+VcpXJnq2yhp4fW+7yfPMng+mYaO1b+okTt2b1SHjlbKU2OQIytwWlmJ9ESaXEVa4U9LQqCEaQUKnqHMU8PJjtGTji8KUDyhsK4zxLtDP6ovBT2OGwsD/c=
Received: from AM0PR04CA0125.eurprd04.prod.outlook.com (2603:10a6:208:55::30)
 by AS8PR08MB7717.eurprd08.prod.outlook.com (2603:10a6:20b:525::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Tue, 3 Jun
 2025 06:35:38 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:208:55:cafe::96) by AM0PR04CA0125.outlook.office365.com
 (2603:10a6:208:55::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Tue,
 3 Jun 2025 06:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 06:35:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNE8/KQwfu7bZRvkUb3pR70yrcCgm3dfJaSpyGcVkbFs8S+vkX/O3f62xQZvM2BMBRJDMVhLuKPky24kicT7uvzaqEbvZmb2CD9fG4dvci+1ZtT8BCnCa3nmlLmtRss153AKNbsB5Kx50M891FxeWDtQXAGR2DZdCZ+hgBA3cFXXqhEap0/jhgxba9IZ2Cqi/Zp3uc15uBO/EHk/Aa3dipz4nidUrD7iTSdgGb3+4eHa18VUesiV+NeMjqpGhTR9elWyIOu0xJO/kP7X3R/TQLgoSuOQ6oTh2duGDx0PFZisTeDSUOfZn0mY7ebNhQtfBXilNqIxxvhlvWU9n9P7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLkpYd+s6ZpD7vLmF/oYPL9G/VsjxdMontnUWq7T4Q4=;
 b=DCCcAUSwul/3/TtjUbL+Gm9yIsGRr62dvr2HWL1RwM2N3SrrfTIxL6TqipHengn+/MeV9ZfXnIPjHSOvgSnr/rLbuFKnPrxlIMPAmp0kgD+suP1aclcL9AevWUeuFhMWmrgjmwcOFADjVzBNh1dscqNWF7+32h9i/rmuQPxvE1W5Fvni1c3tVxqr5EPYHviM2Xt5O4nxI1X1JI61Rdp6uK687zlAqQ0SawvQ8qyEZvaGEt3uZ1qZ/JgAEv4vDXp7zVgZaMNYdQYLHIS0AHkyHrxAJh7fY1/fDce3+nBqQ5x0nP2QDAqQaSJP5eE4yFUSXy4Itesd750QT1zFGpbwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLkpYd+s6ZpD7vLmF/oYPL9G/VsjxdMontnUWq7T4Q4=;
 b=rY2yI3Vc1J5CUNP2hnBtlzo4EXNl4awGMQxGvfQMKqWWqW6Rfw/BF+VcpXJnq2yhp4fW+7yfPMng+mYaO1b+okTt2b1SHjlbKU2OQIytwWlmJ9ESaXEVa4U9LQqCEaQUKnqHMU8PJjtGTji8KUDyhsK4zxLtDP6ovBT2OGwsD/c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM9PR08MB6179.eurprd08.prod.outlook.com
 (2603:10a6:20b:2da::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 06:35:03 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 06:35:02 +0000
Date: Tue, 3 Jun 2025 07:34:59 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, leo.yan@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aD6Xk2rdBjnVy6DA@e129823.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19514ed5.5692.19734522326.Coremail.00107082@163.com>
X-ClientProxiedBy: ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM9PR08MB6179:EE_|AM3PEPF00009B9D:EE_|AS8PR08MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 96213736-dc92-4642-17e2-08dda268d964
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?8R1OT2NP4oPqzEAfs5U6VbaNDIY5DwAWm9WLWlkbc8zlq6Yr39WJVlyLStq0?=
 =?us-ascii?Q?mA3RC3Kevjxb2cnpx5UMuydKA69cmv4bnI8s+u5gJhv3FQOcM80Ccn2l2Ei7?=
 =?us-ascii?Q?QgJmp2PW+d58b0zj3qe6MpsUcA3c1WTSMh8B6MiJg3KxeMmO4NOZ0ryeYodO?=
 =?us-ascii?Q?89jI5P6H+HgIy1+DOgQ+ffKOLDRctyAxWRWwaocf6+szUPlWfZv4zmAO9aV+?=
 =?us-ascii?Q?Efk5IT0Pk4/b8jXKyqiLQiK7BDgOnhM8cnZijpfY0lWpF+RaFSpR13rp0Ry2?=
 =?us-ascii?Q?nLCmMGG7FT1vPEYzaJmTnekKyg0LOxSSsqMgiHA5IJWNx7lzF9MqtUgsGaj1?=
 =?us-ascii?Q?MR9K+hCGYnjgMhn7r3tBXTqu6z3cqXL8G4L+1YV/sEH3t/XTkZ++zPym/Hp9?=
 =?us-ascii?Q?5LqjkQn+1d7hI78JTOvvn+zdWvCtQTO3VZpg/nNl5/eRaVX7h4rf+xAiFuzM?=
 =?us-ascii?Q?aVFMLmXsgx5kuaSz9E5K4WKaSfPSeHevFqzQ1whEzhuXSphoYSm7T70QriDp?=
 =?us-ascii?Q?q3Oxt4rmMu5xPXuZtMAwmqD3LsU5s4i05LSzxsxcchWWuqZEWthdttU4goP3?=
 =?us-ascii?Q?zZgU9sHj2Ghn5Z6t+cNgpmIpecVOJPOobAyJYdg3YygddsWjLgPV0j67wyKH?=
 =?us-ascii?Q?EMErfCtNij362wdqnGK+c/LXPUZ2v5KddfepwOYlGDhLwdJYnnp2H1iMijrC?=
 =?us-ascii?Q?hb0xMvIn3iSPCSheCFxkEBaTq26HEQIVTO9WL+EM1KRmQu1BYxQe1L+k49ut?=
 =?us-ascii?Q?tJVcsAEVGAgcbtZMEE/ldQcP9b389qCT0PZbZGGsn2n9mJ2qP5/5Suq/tq/x?=
 =?us-ascii?Q?7WAm8XZk1l+sxWbDakAxFf/OdanfeSlNy62CQBpzFh6wvUBerImCEcaMfibA?=
 =?us-ascii?Q?IVP3j7hc91+vSOx0SM9aAiZUHlD2r70wk7Czpt12r9VGIF/ILlLstTtSqYKA?=
 =?us-ascii?Q?Bd02A1CiOqTtXoqqdddqaVhxCT7PDAab7IE7nHDnEAqe6je0jc3Yl/LricGn?=
 =?us-ascii?Q?+Pb8UzsXE8HY24F7b4+/0c/r1QcOOAbNxTaEIfgO2RC3xj9azyPvM3ZJKXlk?=
 =?us-ascii?Q?WPSQK3fiAuB7aoh7UW9IXR/T3WqYbxyLPIdJ58vCcXCaJ8G8kUxUV9d9ei05?=
 =?us-ascii?Q?GTllbO23S2A39FwSD1FtQGrXNtvJDXgXhXxVzZTHXYWUNfp/ZIZvyTxXDtxy?=
 =?us-ascii?Q?nQAoT5JUJVtDNczBCLnQzJvw0I1Z1Mi6bvnIaM8cUNHh5podq7vpdqXMMFcs?=
 =?us-ascii?Q?uLjFCV/xwb5dJVkS4OJIr4FE9ThFw7ywhTw65vnBo54G9D/pnFsE0YbqcMQZ?=
 =?us-ascii?Q?VdnV1DyvHu2yBLYP2M8CmDO6kUTIVyt/8dksFC/13v5SNZaRU6f0ZhixU8rQ?=
 =?us-ascii?Q?qP9tzSUEvnKW2yG4QjyAKkPGmMIf+vK5gl7nXoIUmjs5UAd6vYItQdQMwD4l?=
 =?us-ascii?Q?nXHyd2MrzIlqcTFGVI4rx0pKW0MXtnHVTmntuLb1PSEz+hIPEsqnUw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6179
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1b1a274c-74e9-4c21-8dd7-08dda268c54e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|82310400026|36860700013|14060799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zbYktVPrXWpGyFemPZP0knhGLwAKoRD1MwuTvSH3axOT3vZ60JpY/yGIsSKl?=
 =?us-ascii?Q?BJwl3XYu42qQvrLOG+xJ5+EGb1mPEWYMcBPGnCXaflatqC7X1pFK7swsJEaq?=
 =?us-ascii?Q?WKeyFlSJQk6wcfsuW7Vmq8PQoqFH/XpR8/WzltHUWD1x/9GdFKaKzyBFwqOr?=
 =?us-ascii?Q?CNXmmMvRXHoe8QxDVyJ+loYDDbnLuIEWgziR4oL1AF4MYGbXIdGcRisrwGh6?=
 =?us-ascii?Q?/ZWvrABMMZRsGWv7+eZJe0xbAkAVYtUvu5EV2KFOQNMctgd86XOtSkh65Gp0?=
 =?us-ascii?Q?k2MFfC/wAfBpVaRNKsConYQyymzmi3pxTiizOHV0VIOW6KNrFdrm9aBrUQY9?=
 =?us-ascii?Q?x/1JOHyQHUz7Wh/RR99Yrebon4wONLP286bInzexZeLOBg3ex0QVSBznRJHL?=
 =?us-ascii?Q?KsMLQMu4aBBr5/yKF7mXtz3tr6Jl9yF6EUQCf6qLji8tP139AM3nPgTlcNdp?=
 =?us-ascii?Q?dxzn+Xtt4a5ZehrtIMrpz6OiiPTbau25FMXMY5qlrZRU+H2iRyYCpuGeXvo9?=
 =?us-ascii?Q?KNVtsVnRJPvK4ip62ckDr61Dhc7JLWRe8SbaE3MeSoIjhwUH4BqQ10WGZI3G?=
 =?us-ascii?Q?axUeD91yxKrGvb0SbxHQblOuwdhPO1vcQm9pixm4AZ8ICDorASvv5ZHUvOzN?=
 =?us-ascii?Q?C/LCrtJ3JZbUYUjjnlFoBpQsJzkiU4IzDEGHGcuxxnEcd9RTgmbAeol7WPhQ?=
 =?us-ascii?Q?GD8O+ZVcqfoLXWARrUagYwQhb3szlLvYyuNVhE8y8hmUhD3r/O4uybmfvFZA?=
 =?us-ascii?Q?3Q3Nhs71C6HGENg5EMoJPLMJUV+xfjx6Lp+++ve8XXUUEYBlhilGlPQz+o8c?=
 =?us-ascii?Q?2tb8JsAyRAUXVvmfzaHLoPj1+Da8zK5Vw6bMtb9NVk3oVBYV72B3sC+8KPxl?=
 =?us-ascii?Q?WWpwZSWbzm6kJgF8btIWGa2E9hCOtsfTKCCXCpghbf8RxUSOTx2w2HpWAT2B?=
 =?us-ascii?Q?ZjFVCFH8WhorpcoILNUGw8+FFZHVgkY8fEeD07pA3JwGJGFu/I85vJpBlp/V?=
 =?us-ascii?Q?UymP0QrqZW3rbKORAY0iD25csCb0asnp1o68ELTKCrcjJNfd5xNyXY2IMPRg?=
 =?us-ascii?Q?PQfyEtLAl+H2Ho65qMb0M/O5azNsPe0pTR96XjjCoOKeg9or3ZQnLPgpkMSo?=
 =?us-ascii?Q?7a/1V0pZ0xD+hBTMrCVRh+Hlf6g+aponPcX3bJMBMOErfz7QWm9q1ZqX9ltZ?=
 =?us-ascii?Q?lAfRxBhGkSYU2sUmBjX0KgGoA6pfNKL+6aD6jimkpFOiasyx4OKRslx6DZFG?=
 =?us-ascii?Q?Fk9hGzPsKMJWgaehMhToDgLNNGMq4++BpwoXI4KQIP4etmSIdqYrJbzZCr5K?=
 =?us-ascii?Q?tbSCg4qT5G9I38UMvMj3SSd50Rk0J6i7P/BM4t426dMzSgLe1wL0PVEq8Zzj?=
 =?us-ascii?Q?hf4A3KCrx5MCLzQXwLdS/jgvCxg3VGYIVE4hZNkWgPK1kH/0Rr2nWq4FrZUC?=
 =?us-ascii?Q?FOLUCObP1Dp6o/O8lvXiaYroVqFLFAcGNDYWAivHrZZI5IXoumiTXlAN6MZa?=
 =?us-ascii?Q?gGCucY9a998+vSkIxQGOsk1/zkDsjaP4J5OUdzmQ45c9d40NXWelNkaZbw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(36860700013)(14060799003)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 06:35:36.3102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96213736-dc92-4642-17e2-08dda268d964
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7717

Hi David,
> > attach_state doesn't related for event->state change.
> > if one event already cleared PERF_ATTACH_CONTEXT, that event is called
> > via list_del_event()
>
> Maybe this concern could be clarified, what about other subtle impacts.
> The change should be thorough reviewed, if you want to push it further.
>
> It takes me more than a month to figure out a procedure to reproduce the kernel panic bug,
> It is  just very hard to capture a bug happens in rare situation.
>
> And your patch has a global impact, it changes behavior unnecessarily.

TBH, this patch just change of time of "event->state" while doing,
As my bad miss the disable cgorup perf.
I think there seems no other side effect for chaning state while in
removing event.
But, Let's wait for other people's review.

> >
> > Also, your patch couldn't solve a problem describe in
> > commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
> > for INCATIVE event's total_enable_time.
>
> I do not think so.
> Correct me if I am making silly  mistakes,
> The patch, https://lore.kernel.org/lkml/20250603032651.3988-1-00107082@163.com/
> calls perf_event_set_state() based on DETACH_EXIT flag, which cover the INACTIVE state, right?
> If DETACH_EXIT is not used for this purpose? Then why should it exist at the first place?
> I think I does not revert the purpose of commit a3c3c6667.....But I could be wrong
> Would you show a call path where DETACH_EXIT is not set, but the changes in commit a3c3c6667 is still needed?

Sorry for my bad explaination without detail.
Think about cpu specific event and closed by task.
If there is specific child cpu event specified in cpu 0.
  1. cpu 0 -> active
  2. scheulded to cpu1 -> inactive
  3. close the cpu event from parent -> inactive close

Can be failed to count total_enable_time.

Thanks.
--
Sincerely,
Yeoreum Yun
