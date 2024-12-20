Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF40C219A9B;
	Fri, 20 Dec 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711842; cv=fail; b=riT8jlkZGcoAmUuCVCsyeYWDMdK3l6TXdmEzsCwuS79QOQfm/EC9ToRJPeWJj+xjJqbPcyJuf6ELsQOwif5oSCwwTh/N2UyszN7VAMlKa/XpZLvUoZyPK7+BvQC+GvyNoeq16bJiurqT6mP4BLXFcu5lKeLSMmqNhPD4AY8lpRY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711842; c=relaxed/simple;
	bh=Be19I09N2mDERTeDgyw9ydtc8+nF+Sqx+O9LKwCSaMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=butidnxyBjVd9FbUtKQiVI2R+hYefZXvLDAUZAJ201WGn7IONs51q0z27xU+M5Eojg1kL73Aj11YapWsH/aUxtdJlZAUqQn2b0DeEjjU2rm8TgLqip59KybxMaxmxKT0kTvY/GWZ+tH/NaV6uPuDEOOra/6QY3EwRVbnscumDVw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hN0YlKXb; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hN0YlKXb; arc=fail smtp.client-ip=40.107.247.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hN0YlKXb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hN0YlKXb"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uGwRIoVOOGw1p0YcvQiSXntNM+WyCvbA2z0y1QrRmCJOEp31NatNSivbTgEkvEWXT4wnDA6hjpmwMQI/2ElpnX4rSXwVKr923DSFqyaKvtRlAPiKo++vgKfWo5Y8E5Q/OO2UxokMfn/fijrXt3lkbaJI0p0Uh+OilUUb8Hrm9GBdf65Id3s7vQS8zcZpHvHApjR4wVao7sTuNRjT+Gs/Ky+aSTZahNXBNpL7GcY7sxqKtoeB9JuwrAxLJ7P7P8aByImbdKAYVwc5V2RGqUz0za1fIID4/3ChuGPel0pvaFZQVyJ3jk4Tit0fYJ2jdC4oyhKn7jSW5zEap4s4CELo3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA6tHIp+gjiRXxWP4IHbEXq/Z93ZegdNTjWIGR8uis8=;
 b=JwQraqHUjj4nIepVzSH5uglQSUPXXsXSY+zeQ7HJutn5h+9BTHla7PFVv8PHu8GTP2xdwMvBALunkPLkKLB15qiYKVhrJgQq29ySFU140NMnSx10utx2TdJ9am5KoyhZrjjBYTEp0+CD2IFztjjTaA+2rd1/J2FNFXfOxEq+6Rh4oMP2OY9JwBcuGO0BtjlpE1f61QnTZxbZyzcoIvc9I7AocU4pOvnkr13MAP23JfgsitlzMQzfAhEAM+ZzAat18EssffxSwQIGFDh4WY/Dt5qOBaOwarZByGTCgp6rsAqcczu0xetmJN6Y9nP4HxySSCWz5LqFrUlbNmrEpa7Tvw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA6tHIp+gjiRXxWP4IHbEXq/Z93ZegdNTjWIGR8uis8=;
 b=hN0YlKXbfuLM/vE2ka4kKlNK0PmSZwyNMLDEvNSIkt4DlYzVOOS8xmBmOiC6obLXQen2hahRxQuLrskc2qmYoKl7rFfEyujB6IrX5gNbbzcAv6cIsk0rGKtKQ/QMD3GTpZ4xIYyDBz5dDRu6MrcSz/KWh3ruYHRmZ6EcbFTOj/Q=
Received: from DU2PR04CA0270.eurprd04.prod.outlook.com (2603:10a6:10:28e::35)
 by GVXPR08MB10586.eurprd08.prod.outlook.com (2603:10a6:150:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 16:23:52 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::5) by DU2PR04CA0270.outlook.office365.com
 (2603:10a6:10:28e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 16:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 16:23:52 +0000
Received: ("Tessian outbound 42d62cca2da1:v528"); Fri, 20 Dec 2024 16:23:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a3675878124de2f0
X-TessianGatewayMetadata: wj3CQ0cKro05qGCUyccaUZrRfpIHI7kS6fY4gINot1gw3Oq9X+wmRAD2WPwr3+1uAX2WnfKwgcK76qd9YBONtfxbv5zVUTGVa3uKeJDkz7T2pK5M92QtW0PLzDnf5gJvnLYygLZo1PmLj1uRoDpncA==
X-CR-MTA-TID: 64aa7808
Received: from Lcb091fab7faa.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 03B907E3-769F-439A-AC59-6DC26403ED13.1;
	Fri, 20 Dec 2024 16:23:44 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lcb091fab7faa.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 16:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecx0RouvuZ/Icbil95h9aGYlVZ9MQ9Frx8Wq0l0rMdTzgOwvHxXv+LHm5hjYavbF+F0LPQ2JWfX1mzvjYVU3CuWbqLnVkJ2GPthx7HdFa0REpYEcBfQi3yoNilgZH93Lvi+QcvCRnYD+6nWcn7CLYGqsWVLsEySvqa2UlYkRWja6DX03p2Esu6wMr0H+xyjB3j05QXi8rjOPZy7gb9LK8L1JBILkoGmwz//H0/jI7oQwOhuEiDTeTFFkReC1mFsXC39imGGWNJygCya+RZyC2cQf+uvlNP+UZeUDJWGOKSEcRxD+vxbrGHTth4z85roxJovROU5QMT21gwBjEV+vXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA6tHIp+gjiRXxWP4IHbEXq/Z93ZegdNTjWIGR8uis8=;
 b=go3y4a3I1PMjE5/fpdAroqybRQCZzBvA9DdmLfnE7k9+LaQ7rW7l14jfyHuejy9+aMSR3yi7rysgmfYT+DKdTBA4cKhLSE0GhXSvDZb57LjG3KBtNFJakC/74OUJo1Jwp7J7of9ptA67Z+1G9FVXGAax1bhkuHNNyzLvW5hCU8jcvHhKh/bIm+EU4Nq9xnFdw7XSFrxJB7zjmCxO1C8kvKpbiQMaBDdatkNupC3BGxlaFmiemarNuElp2M3t3bjCYrarzFZT9r3crvcbNsP1WaE+/pGPD0wcHyv095fZOs/dRajLXYIg8NA07MNQLqZaEF62r/3nzaUW9zmuUk8MKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA6tHIp+gjiRXxWP4IHbEXq/Z93ZegdNTjWIGR8uis8=;
 b=hN0YlKXbfuLM/vE2ka4kKlNK0PmSZwyNMLDEvNSIkt4DlYzVOOS8xmBmOiC6obLXQen2hahRxQuLrskc2qmYoKl7rFfEyujB6IrX5gNbbzcAv6cIsk0rGKtKQ/QMD3GTpZ4xIYyDBz5dDRu6MrcSz/KWh3ruYHRmZ6EcbFTOj/Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAXPR08MB7441.eurprd08.prod.outlook.com
 (2603:10a6:102:2b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 16:23:42 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 16:23:41 +0000
Date: Fri, 20 Dec 2024 16:23:39 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <Z2WaC0CqSwU5Ux1B@e129823.arm.com>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
 <20241220151414.GO11133@noisy.programming.kicks-ass.net>
 <Z2WMsnbFmqpEV5Pu@e129823.arm.com>
 <20241220153040.GP11133@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220153040.GP11133@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAXPR08MB7441:EE_|DU2PEPF00028D06:EE_|GVXPR08MB10586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f84ab81-1254-4f21-01e4-08dd2112b11a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?sosF24zE1iLZGBKQ6jJ8XbIN53pbm/oOWJoDHl1AlUKHLzSY46P8s69+aB6+?=
 =?us-ascii?Q?QOF65xyEtjVS2GsMwRSz3Ni75b2KlnNpGlL+feySNQziL/VV4EtGfe+lo+3E?=
 =?us-ascii?Q?ONUgXtlhhCiU6fcZLWvLOfu0awV/6xXhgSTZ/pdSGhfV/NlHSU/HXEslDzBo?=
 =?us-ascii?Q?edjPX9SsARcghdofhoCKbfNOM0q0GSiv05+Yr3MCTxWTMT7AAz/YGLtGSSqo?=
 =?us-ascii?Q?I0eIWLJRqLV1IuMowV37zhwAhpsrGF/b8yi9RhJMFlW7mVlndFgm7DfN8AbU?=
 =?us-ascii?Q?gDwQVlYdR9DhjGSrZywYk6jEKj5thaCyHov2h3VeQwug5Wfq3t0L3lIuroHs?=
 =?us-ascii?Q?FE0hFJLXhcjrSH24oWvBJoMLs6Q+QDIpmZL+BLSGHjitAvWTiD6DPdbFxJu6?=
 =?us-ascii?Q?WxB9euHts12e7nUNM9E097x5spS7ZKi8dfzmcRrLnBhuvPjxrezL+2d1zWzB?=
 =?us-ascii?Q?QOFJLNDMmxWCIeAZU82BoKJTl9+KdaMB/YUqiisWgwczENmC/qfXh/KB5Gnz?=
 =?us-ascii?Q?IoY+BXyDSSrTJArwgARdESFo3SvJRH2lxH+TfUP2eJWfoR9jYdnd9PGtesCb?=
 =?us-ascii?Q?D5uy2hA4pXCGBrcmycvSnJiUTNci+EmIklaMzhGcKX5en+IRPirqi1XgHlnd?=
 =?us-ascii?Q?K8rzHBDMILziX1NdDtuB9MpuuQisTYBw05/+SsYOCHIBSMajnMJ2x/Qf2pTu?=
 =?us-ascii?Q?EdVW7r2qcUNESBsWwO7leUgl2KVTFdKW++5zSktdF6cOqZtqBY4CzwZY7348?=
 =?us-ascii?Q?0RFzREoNP214zkqNt05hGyZmyQKVzXKyj72dmOOadl3BEYl74PjVHAt1s2E7?=
 =?us-ascii?Q?/nmQcKZTAG1bk3pykxmBtRk9GxWzFDzwHOjtLVWvjigZTGq3pnmfy4xIoYKW?=
 =?us-ascii?Q?F1C3aRNQ38eFSiXOw9hvstBEZJVG5fDTSN/BsdlniOSiIQOMP45z3HHPOkZC?=
 =?us-ascii?Q?6PXIZ+Vnk+O41RK0bApro6VxZk4nN3QKgUr0P5BL58xzgHP4gPK4F41MC4Ig?=
 =?us-ascii?Q?3aSEvT9MCL/opzPX2SHobeHuU7O3uILTIw+jEGNC6YsJLysO7dSospHhWflS?=
 =?us-ascii?Q?gmOMhYeDc2M/5QXWFDToB+Ld7AinERzWK48OCDxla+pCFO+TGygwyZhACgdI?=
 =?us-ascii?Q?R1Dir20cwH+UYy1XboM0XJxn/SLcBeMrXWJxlnUYOrnsNPirKYClkzDgS7hB?=
 =?us-ascii?Q?3A+kS/4Eum6mTPaYp8iaQpx37o8PCFZtkFRnqSpwmOD6MWlHMs6fUiOf475r?=
 =?us-ascii?Q?19PYU7YZ3UDxWgxauB2sMMbyb0ylwLLygC/Jkauq2L+JLiaMbBzeAVnfQ2fm?=
 =?us-ascii?Q?ov2Kt9MhFM+pLIbyUjluUbhzaFMCQaXOHems2qQGk3RVUZkYtMXb3OnFnDRh?=
 =?us-ascii?Q?EKKM6tRxyA7g/efgpJQFjEtwiH3O?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7441
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0fa4c455-6a61-429f-73cd-08dd2112aaec
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/X+kTeQOPhpAfxa3mOnWjDLWt1tWKOpfz1vuXv4cHSar0Yi7/ibcIHYNBpJ?=
 =?us-ascii?Q?6jfPPszRIZT3o0FaxTtk9khowk4hj1Cu9j1sPI63Ub3rMjHOgfCrXJuIVtV6?=
 =?us-ascii?Q?9L6waod1vLRG07Vi40qh7jmg6F8CLTTk5APLNWhtasetji2IAV/yZu4jJr2L?=
 =?us-ascii?Q?jqCNiAcf3QjI4XFeLukI8ypY0TXixrBC0sLHFNYYsc2wl6K8T6qhGCFU1x7k?=
 =?us-ascii?Q?ZNiZAqBjD2cTE18SnMWp0WxpvCSvdNjbct+5bFMdeP+AmNAU0FXvoHxwxZFl?=
 =?us-ascii?Q?4iVpxwzi1etQrzE6LHitPbpRWvF/YL5AU6AQCWlU9j91xnVSToHBgrZxYhOs?=
 =?us-ascii?Q?ivCLAkvfYRJUpcBDOft9AW9QcWC+/G/T04G6K0y3qW3EVxXy/3nz6tvaiig6?=
 =?us-ascii?Q?wYxxAJZM6AT2R6BbYPdM+atT25kbwI6nwte1/Ow6p9q0ux16OLXiTOP62oY9?=
 =?us-ascii?Q?laBazCX+l470eUVtddthNJjnBnlVpJK3Xw+EQUvOh9XnY2HaJHk9OlirwWWH?=
 =?us-ascii?Q?Bk7NKQIxI3bAxujR8eXmAZgiibB0xStwz8NbXlR0Gxi62NLclktfQ//fFlGr?=
 =?us-ascii?Q?dzKALqI+TgUedLD4indPJ/Pw4Yrua81vCH8CClt7iELDftuSTYSE34lBdYUN?=
 =?us-ascii?Q?Dpv+dyrLDuOxi6ImKB4+iOHzIvCN9ufv4Ck8PLMeQ40FF+xgsVOhOTPK2bJJ?=
 =?us-ascii?Q?WGvrdbHtLfwqi3cjPHFSbVIVawBgrw9Zrc5s4v426PK3b0goPSqnz54LDnHJ?=
 =?us-ascii?Q?iQMPq7uUd0mVzjVfNQ8f55/iTueLQuzH/zhH1Wy5iw/jkg5FgkV8u8F5B4+X?=
 =?us-ascii?Q?8hZ3zk0gPv8dfpTNmncO8rKjsHbbE2D3Kj+AgFI8SXLMzw/K0/LfY+MuqPnP?=
 =?us-ascii?Q?Z7Py7W8Cwz/znFR9FzcR46tA8CNrmLR5NqwtxmMC6UntZ9btweP9GzRrbEgV?=
 =?us-ascii?Q?xRuUpU6Xg82eecinaqQ9I185eGoJzxCbtfcwR2kpj3S1haPzOYXhGYMvBFk9?=
 =?us-ascii?Q?u8pL7Jcsqz0xw5Gyx6aiqPzHu8/65+eCPpXAS0//9ezANi2dmzJftMmRkhw+?=
 =?us-ascii?Q?bqlg84gCcH9XQ9t8WegO9TMHGPcZDLj/H4VeS8t9QsQ4kfRZ7LyZmiY3E8hF?=
 =?us-ascii?Q?sgLiOpFkjtNZrbSFrDwTuTb8CdtIfRf3JCvpcYUhBBeajqH7HhuPBDw81c6g?=
 =?us-ascii?Q?Qo6LOXWARlnrdOlXoAniqykda60cXEm7OwdWgV1T58nA5cpePtdHx7SoY6It?=
 =?us-ascii?Q?LvWK7Mvb8VsIpWtfa6J6vQ+tse9Eb8zSNAeJ7w2i/930l2HjeBggdmyeDDch?=
 =?us-ascii?Q?/i/FCPfaM1CPboL6xq1uIijzB4mohyoVTBqBlBL78aNGjFExl1uCLC06B7LW?=
 =?us-ascii?Q?ZY1gy88MLyHjQLyKZGgzEk17IQVQm1K2JsdYYXCfhYhJAdTT4eB+a7xyjVoI?=
 =?us-ascii?Q?ANQdqq+bGeB1iTxpG7z4VI8iDmVT0SjOCMlZ0YxMmHlWKSl1eOTW00/yQNdi?=
 =?us-ascii?Q?iKN/TEZzK8/o2OU=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 16:23:52.0565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f84ab81-1254-4f21-01e4-08dd2112b11a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10586

Hi Peter.

> On Fri, Dec 20, 2024 at 03:26:42PM +0000, Yeoreum Yun wrote:
>
> > > OK, how's this then?
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 065f9188b44a..d12b402f9751 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -2422,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
> > >  {
> > >  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
> > >  	unsigned long flags = (unsigned long)info;
> > > +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
> > >
> > >  	ctx_time_update(cpuctx, ctx);
> > >
> > > @@ -2438,7 +2439,9 @@ __perf_remove_from_context(struct perf_event *event,
> > >  		perf_child_detach(event);
> > >  	list_del_event(event, ctx);
> > >  	if (flags & DETACH_DEAD)
> > > -		event->state = PERF_EVENT_STATE_DEAD;
> > > +		state = PERF_EVENT_STATE_DEAD;
> > > +
> > > +	perf_event_set_state(event, state);
> > >
> >
> > It works. but what about this?
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 065f9188b44a..71ed8f847b04 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2432,6 +2432,7 @@ __perf_remove_from_context(struct perf_event *event,
> >         if (flags & DETACH_DEAD)
> >                 event->pending_disable = 1;
> >         event_sched_out(event, ctx);
> > +       perf_event_update_time(event);
> >         if (flags & DETACH_GROUP)
> >                 perf_group_detach(event);
> >         if (flags & DETACH_CHILD)
>

This patch doesn't work when the event is child event.
In case of parent's event, when you see the list_del_event(),
the total_enable_time is updated properly by changing state with
PERF_EVENT_STATE_OFF.

However, child event's total_enable_time is added before list_del_event.
So, the missing total_enable_time isn't added to parents event and the
error print happens.

So, I think it wouldn't be possible to update time with set_state.
instead I think it should update total_enable_time before
child's total_enable_time is added to parents' child_total_enable_time

like

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..d27717c44924 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13337,6 +13337,7 @@ static void sync_child_event(struct perf_event *child_event)
        }

        child_val = perf_event_count(child_event, false);
+       perf_event_update_time(child_event);

        /*
         * Add back the child's count to the parent's count:

Thanks.
