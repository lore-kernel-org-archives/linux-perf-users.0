Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AF185B56;
	Thu,  7 Nov 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.88
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995724; cv=fail; b=o7wEMGju7dGWV6oXcjxblwQCWfuIEtrB1bja4LvDhG1w/7HFLSTCs/AqWY5V3xoIK6LXhfGeFcywnS9K+i0HdL7bAl3mivR945vDm165KeW72N7vHkYVe+Pu/AOAbPgObyfu0QkceRBS1P8hY6txmlRBxO2tYCxbgy7rbXJLt+g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995724; c=relaxed/simple;
	bh=PAQrDcuEOwzJj6hbdwo3RA60eo4tcrBmToBexo30ZJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUmj/W/clwdrQZic6ysIzxfLnw8W07Sd+GjXyZVIIKqBg+Q2/pbHiSJw5wlP/RuV0nGIUL95msNR2BUEmz9EOkSVXfETVspuzRwEIk9qVPztwu+zJH+Z1wmwbHW3Dk4wLFeTfizsuRZK+ed4EMkuN6nBAF8DZj0E8zspGxpEAX8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nZNWolRW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nZNWolRW; arc=fail smtp.client-ip=40.107.241.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nZNWolRW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nZNWolRW"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lwRtknLWua/UgDojQnzWRJzhR6DiiP550iHzZwiiPlrykC2Qsu5U4ViuiyTxLGT8XvBaghr7WTxmTuVc+wwGOPt+FJB1iMGlUDOMamLMF8KwDlB380H7wVJ0iCGCl4eXiHSw/nCERJH7ysT+7XfY9Xe108xt05mahFkAAHAL8pLDwIp8fl0xs6215mhFK1A0MDBkQWXSBkvJYJGSpTw4OifUp3bcqbnz9wTNSg57UdT+ZM739HCamySET/o3GRpqmVttVmolCRDlcLfikAYRgAX4cm05LKQMl5aQkXWcpDSCku8B4/5gNcAVcKX3FXzxsqBjZnO5pHYfZ5WC2pF7fg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ/alzjkXRVhJbyU/UQMeY9dzEOt1z/ZPXPWZpB/Yhk=;
 b=w0pfJKVB4tcyOWziUtqqYss/EC6w3zzFc95c2jRCWGrQReeGnDncJ0INOVAYXZDvkIjP79Mer3GfVo9F0ObwEExgACen1TWT+k/iBTY5w4CK8xawDJalDYZwpA/dhQ/9CHmXfj9g5i6cYz1AvrqwUn4Ljjly7DXN5ht0+3PJWa9EJLODa8MHdh6kWImZT/qEtQ0gypVxtf1wJTwHFmu1BWAG0azf8ZLKBajwUYFLF1Lq8GsgNVW5sS8Cb3Ez92CUWVpvLaqVdCE5isqsBnDxC7Av6tY+ZmIcweVFgc13VIQ4cbPviyYQpMVdkd2h9UpjUoOrZJBWwTxnp5Tm+VqpEQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ/alzjkXRVhJbyU/UQMeY9dzEOt1z/ZPXPWZpB/Yhk=;
 b=nZNWolRWhiTa4NrCUVQvV0rkSRp+2bU+ZHUispC3ljs4Cc9dEGpWHwi4JdZVS5nJ0lIgEK80HPa6SlsmFpl4YnsVIkaI+gzxyGR5UQDtadsMFhn127v2UcACBHj6aZhf1aEWL5bsAx4xPjs34qsi4Cm1dxhXS4zMm4M+oJASzs0=
Received: from DUZPR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::11) by DB9PR08MB9466.eurprd08.prod.outlook.com
 (2603:10a6:10:458::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 16:08:33 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::95) by DUZPR01CA0084.outlook.office365.com
 (2603:10a6:10:46a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 16:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17
 via Frontend Transport; Thu, 7 Nov 2024 16:08:33 +0000
Received: ("Tessian outbound 8223600b7a9c:v490"); Thu, 07 Nov 2024 16:08:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 573f6fff17491099
X-TessianGatewayMetadata: 4HNeXTWXU6Akrp+qb97tsQiIN2nyXEpUHsNm/72iCnoMtr5UU+T3Ytl6EhQreN2xOHcfKIuQZ1ZoTqRtusWxWAq6OUiPZV1Zy1htG2Gmx57XPwvDjPcbYd8jPx7vl66NbQFYyg7GUoY/knpvvBP67GO2ZkZZd8ULCZt5pHY+Ajs=
X-CR-MTA-TID: 64aa7808
Received: from L2e95e45bda57.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CBF47E2A-0E0A-4469-9404-D7318797DC7F.1;
	Thu, 07 Nov 2024 16:08:25 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2e95e45bda57.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 07 Nov 2024 16:08:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9m3c+0tVFEz6e3QGwTnCMsM3CaPDsBdD5uxU4Pwhn2jJzMjauCDEErnGw6/cwlZ2/D5Og9ApJcPU7UB4rNJlZAsxZqOXrLw+LP4xNh1bqjposmyfZLZCXUusHlgouqKFWcTDwrNTnTc8WrCAIIDaSHmQlJnoRXUBmIQNo3SK82bNWOlZGz6nr8ZIwClXaLd6ftwVLTaBWGl/NYXIoIqKbS9aDrvUAK9K9+sHT77vL/UN4HpCUVWTeS82ThZHiV2Q0GbO0ZnB6kD6lNW+RwkawyRy9LVHZqueO9O6eg2BHLoNpBQnAvnAp11d43caiHdzkAnR+ePjFGsspkBznDJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ/alzjkXRVhJbyU/UQMeY9dzEOt1z/ZPXPWZpB/Yhk=;
 b=JWp8RrmHHhjf23w91TijVpZgyeOA7ZQcBVQPIW/T5o6KbkU7XdPBGI6wLk9WB1zRnXI7OJaq5QA/HUhlhOy/aTLbcrjmqkwJ+8RGjYNAqIN7JyrAEJrrjXbhxg0WtPPLtnwMaSlOryMzpHfvBqeWSWH3v/29aq2K9BVmZ5YnJuz+bX3p3SXXh99Gm2g3Ls0fh2B3uaY7fXrfuFHZPdYQahXqcHFJv+X13ztmD06rMieVsRDp1VvLFvmqr8DTDk3alGR8k+Ss6c0L7uq5GKjJCPbD+apkFg/p42/bjplOyZbF504xEseN99+WVnr++DIoi5Vr8ziyZM+FFcKdMcQ09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ/alzjkXRVhJbyU/UQMeY9dzEOt1z/ZPXPWZpB/Yhk=;
 b=nZNWolRWhiTa4NrCUVQvV0rkSRp+2bU+ZHUispC3ljs4Cc9dEGpWHwi4JdZVS5nJ0lIgEK80HPa6SlsmFpl4YnsVIkaI+gzxyGR5UQDtadsMFhn127v2UcACBHj6aZhf1aEWL5bsAx4xPjs34qsi4Cm1dxhXS4zMm4M+oJASzs0=
Received: from AS4P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::17)
 by PAWPR08MB10239.eurprd08.prod.outlook.com (2603:10a6:102:367::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 16:08:21 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::52) by AS4P190CA0028.outlook.office365.com
 (2603:10a6:20b:5d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 16:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 16:08:21 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 16:07:48 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 16:07:47 +0000
Received: from e132406.cambridge.arm.com (10.2.3.22) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 16:07:46 +0000
From: Deepak Surti <deepak.surti@arm.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>
CC: <deepak.surti@arm.com>, <mark.barnett@arm.com>, <ben.gainey@arm.com>,
	<ak@linux.intel.com>, <will@kernel.org>, <james.clark@arm.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v1 4/4] tools/perf: Modify event parser to support alt-period-jitter term
Date: Thu, 7 Nov 2024 16:07:21 +0000
Message-ID: <20241107160721.1401614-5-deepak.surti@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107160721.1401614-1-deepak.surti@arm.com>
References: <20241107160721.1401614-1-deepak.surti@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS0EPF00000199:EE_|PAWPR08MB10239:EE_|DB5PEPF00014B9E:EE_|DB9PR08MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f53dfbd-423d-48a7-9b3d-08dcff466dd7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?xVdQLaGkhG4+9fxwBWBvjoM0NOiXnoKS3bQz5gbUNR0ixDA6lDgm/tGbae4v?=
 =?us-ascii?Q?TMIwwsPPbHTaS4phEez2htm9bdUVK3qwjTAxul1APTSeu/Om/QNZPA6lLvbr?=
 =?us-ascii?Q?M2sWXXXb8wGI3xXTioFRR0so7dqwKpUTaAPmopJg6gE5xfO0KA97VXi/MyfL?=
 =?us-ascii?Q?AwXqF8DHP+7XcCiK9GPPpMQ7Xu634Hr5x4IgfpVUm0JztynW0FpDfSkrNoMk?=
 =?us-ascii?Q?Mq94nQ0lsu7kj7ZBd+FRdKZE4ntFF/1/KXt3hlXJ3kBu3sGE4SDH15YM34lZ?=
 =?us-ascii?Q?dEid+75y20XUccdVhesuEReKD/BuiYd7esvRbo2xSolQVMDe8DQc7NW8XeII?=
 =?us-ascii?Q?lN+s1unuFV6PdidP8yC2lVNmvUqYogltXHH/g+fAV5HiF2DM7qagkzgR0MNi?=
 =?us-ascii?Q?+xce4h4b02wSgLxy2x0cFw+1T1Mng7m5XEu+wV4uYxOLvzc/HwCTcS42Ldfo?=
 =?us-ascii?Q?bwE0ulIKvY7eWleYcSDpUVqZtyIePl/unMlc9QYPLvgc/nJ7Pox65MsP8/lf?=
 =?us-ascii?Q?1Ub7yzxlshCtYM1w1c5TRJxvraOS6fgdghuMFWYbGaJFREkU+LnBtE3g3RI1?=
 =?us-ascii?Q?Q0HPprkycEyUiRpjVtKByY4OnKedBosjLOubTAKjehdlDx9tOK3cHkJg6PD1?=
 =?us-ascii?Q?fFtEpzVi1PVdXo710buvSYjLIzll1ElsXm011mNSWISZbgO5PQV0ilnHMUHP?=
 =?us-ascii?Q?gR/eM+jMKlL+8ZKOYKvSyK3T+aoBmx+373/qYFXR3GVKC05mG5nqUeJT4VKH?=
 =?us-ascii?Q?4Puto0lnonMj5b1lqvbg1d+Waf+2mw1oUj+0GJ8iULTnf0jYpeRtlH8IEln8?=
 =?us-ascii?Q?pK33VgZH7LpANFhvIQmi88xi74Vku32/FHSMm1LgQMo/P5BdopgZr9cIF0IQ?=
 =?us-ascii?Q?MfHo8R+dptoZRhXTYUl3gkKkRiZQZ0sICvwvAJYDp35d/PUEgGDKEKnkYhi2?=
 =?us-ascii?Q?YNrh/JI5xfK0wenaLXBEqQ/LgT11BW+vZSWbdGdLTf03JOpepRYIe67NN7By?=
 =?us-ascii?Q?uyDh15HTNZuPz5pSnDgdSPzkzd9mVePgFdZM/8Xr0ebjWv/qot7Txb/05YzY?=
 =?us-ascii?Q?qMwfUYH/XurOlXZrdONpvJkIt1AuCyw3SmiEYgewDCIiyHBBcg9+Sjxbb4Bs?=
 =?us-ascii?Q?1maL6pvweH454XZFZTkUGVBgyfcYFswPgS7qoBnjjaiaWzy860LHs5PeaPdg?=
 =?us-ascii?Q?w9f2nR6iHzpC1LaseiJZ46b7jLIYq99D4jE9XUoQ/oxtjsGHrtSHhsOnfguc?=
 =?us-ascii?Q?gFMDrDFwCS2EKRvw96PaHuUl7Pc/jiWofNIgYt0/5SZtR/THK2094L6FvKA2?=
 =?us-ascii?Q?ENy6zg4+e0kWCAM/2m/MR1yPQqIWQKHIZx1cvgoOFVOh3ei5q//ftgje0lG0?=
 =?us-ascii?Q?Npoqaa8ndJSq0+Gpsa4sjJdDEEz4sdW0mWkHAgK2fesY5tEUXQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10239
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:5d0::17];domain=AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b81b87fd-2e59-48b8-3a72-08dcff466688
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|14060799003|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GpSeq/LzTato3Ui/7PhcvV6h9wq6xsqcNnuG5FnUglr2bb56sBpex1aLejOY?=
 =?us-ascii?Q?lWTHp7tIhxzzGK2M3bXqn0zj/JrEA0f7YGodKoggf9ZER/40aRdk8NCMCHxE?=
 =?us-ascii?Q?4FVGsSRpQs4tWKTPKR8eo+Awzys0o2Awbl/rpqZANopwXJK0SCzdRI+lpEaO?=
 =?us-ascii?Q?dZlb4Mp1YorLD44djOMXRpBtn/cwaDH9unXf1Id939TO1FpZhR8Qx3cESawN?=
 =?us-ascii?Q?d781ozPPbcMcdhmjxzi7u1Kf4yNO29bNTqt8jCxKJhGVAzwPPEMR4AoOgLF0?=
 =?us-ascii?Q?OCpo4oV2p4B9jdKx4szasVP8/Bho8nSEvQtc+Iq8MRPxxowD21ZDij6hfded?=
 =?us-ascii?Q?FZ7+27t0Kiqav2JBeBthFGTHhv1+ShE4KShh0Ql1/hfaTt90UlnvY8F87jqV?=
 =?us-ascii?Q?ajfkXBH1UzPYjsu3o6dv8QVXa04sdMYV4Qji/p92T9hFz6WjnZgm0lVEMm6H?=
 =?us-ascii?Q?1/ei+AYGSdsjRUZyPYYKn2BBYFpehcqXVSBcHDwj5EBzjRPolGcwD7XYy4F7?=
 =?us-ascii?Q?FTx18Kgti5DVyWt5RiDJuqefjaHlaQ/bQNW2QUpGsXMn/Y3TBQYwWTkphMMC?=
 =?us-ascii?Q?GXnCbC2LIwos4+PNsKN5TnSJ6B7SPhWAUua8jApbPyIzGZBlfAIE5RYOXbHb?=
 =?us-ascii?Q?xPNEAmZEs2m+JFMl4AV8WjFIEGnJ6FQgzbxUuNFuI/L4+q/jyiAph0XEXnOK?=
 =?us-ascii?Q?mggbpr4KK3mkWy/1YqZgw4FlklBcWwcBRSvd4RnNObQE8K86wVnUlwJsRFp/?=
 =?us-ascii?Q?ahlHmO0J8945NQijtgeEInV3+qsfsjof7bmP1eiu3oAIkcs+F9uAbab3IZnu?=
 =?us-ascii?Q?cd9kcgGXiTEVgNY5OE/Kwryta90p/7UAEv6rzBIPd5Kzc9WkNxeM29ZUMyLn?=
 =?us-ascii?Q?5b2jNfRm3fMpEJYyvSG81R+G1KM+mtdFDaVjb5dPh8ERnsYGUcygrZ6NrZYd?=
 =?us-ascii?Q?NGX5VmhVHdaoiy1FvUhAbF93kKLadaTAunCiwW1lN2EyGs78OXHqmrvVhK5m?=
 =?us-ascii?Q?sRekM6R8F5/wYSrv2PRrr8vOuyS5PBGu4PpTa9z5QP7nflPfxSWtsRr1ZsNa?=
 =?us-ascii?Q?bLEJAMyQsaBoP9/6Y4CskktzdR2dEHkewGPyEGCEUpaCgUr+9bTu1fmtPko7?=
 =?us-ascii?Q?TZBontvTDRiroc5KFXpo+glexRmjsmk8whfvKkXmbXXhz3Irjvs6loXmcrNo?=
 =?us-ascii?Q?rlr/gnIOWbDYSldF7WDC77B5ufDLAv3OfkGIVkKqqL56T2v6BqMspQjJ/m6Y?=
 =?us-ascii?Q?AII4PB4XHfYsChz8LK6yqw1d8bOP2426uSWzqkcgDyzn9/alFCH/rhsHtI5G?=
 =?us-ascii?Q?pP6NO7C0KzZS461ObMJIeQDzYU1IEP4va3FhTo8kig7Nr+lZ6Vb7ej5feRcv?=
 =?us-ascii?Q?8eqnBP06vLF51eM4wMXrGvJ3q01eg5SyUDYRzVp3PgKZ0b1cwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(14060799003)(35042699022)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:08:33.5407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f53dfbd-423d-48a7-9b3d-08dcff466dd7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9466

From: Ben Gainey <ben.gainey@arm.com>

parse-events is modified, adding the "alt-period-jitter" term which
can be used to enable random jitter of the alternative sample
period.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/include/uapi/linux/perf_event.h             | 10 +++++++++-
 tools/perf/tests/attr.c                           |  1 +
 tools/perf/tests/attr.py                          |  1 +
 tools/perf/tests/attr/base-record                 |  3 ++-
 tools/perf/tests/attr/base-record-spe             |  3 ++-
 tools/perf/tests/attr/base-stat                   |  1 +
 tools/perf/tests/attr/system-wide-dummy           |  1 +
 .../tests/attr/test-record-alt-period-jitter-term | 13 +++++++++++++
 tools/perf/tests/attr/test-record-dummy-C0        |  1 +
 tools/perf/util/parse-events.c                    | 15 +++++++++++++++
 tools/perf/util/parse-events.h                    |  3 ++-
 tools/perf/util/parse-events.l                    |  1 +
 tools/perf/util/pmu.c                             |  1 +
 13 files changed, 50 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-alt-period-jitter-term

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bedae424ba36..16dbeea5803e 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -461,7 +461,15 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				/*
+				 * jitter_alternate_period:
+				 *
+				 * add a limited amount of jitter on each
+				 * alternate period, where the jitter is between
+				 * [0, (2<<jitter_alternate_period) - 1]
+				 */
+				jitter_alternate_period : 3,
+				__reserved_1   : 23;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 956b58c7ba8f..7fb5d1d0b0ab 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -140,6 +140,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu
 	WRITE_ASS(sample_regs_user,   "llu");
 	WRITE_ASS(sample_stack_user,  PRIu32);
 	WRITE_ASS(alternative_sample_period,  "llu");
+	WRITE_ASS(jitter_alternate_period,  "d");
 
 	fclose(file);
 	return 0;
diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 75c4527393f9..ecab8e69418f 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -92,6 +92,7 @@ class Event(dict):
         'sample_regs_user',
         'sample_stack_user',
         'alternative_sample_period',
+        'jitter_alternate_period',
     ]
 
     def add(self, data):
diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 403de2e2c891..39a7228612c2 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -39,4 +39,5 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
-alternative_sample_period=0
\ No newline at end of file
+alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/tests/attr/base-record-spe b/tools/perf/tests/attr/base-record-spe
index db528d7d8b73..b228cd98cfa1 100644
--- a/tools/perf/tests/attr/base-record-spe
+++ b/tools/perf/tests/attr/base-record-spe
@@ -38,4 +38,5 @@ config2=*
 branch_sample_type=*
 sample_regs_user=*
 sample_stack_user=*
-alternative_sample_period=0
\ No newline at end of file
+alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index 27ef0fa1386f..d9057d780262 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -40,3 +40,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
index 5c4d2a60931d..4d80542c3a68 100644
--- a/tools/perf/tests/attr/system-wide-dummy
+++ b/tools/perf/tests/attr/system-wide-dummy
@@ -51,3 +51,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/tests/attr/test-record-alt-period-jitter-term b/tools/perf/tests/attr/test-record-alt-period-jitter-term
new file mode 100644
index 000000000000..cda28c1ec8dd
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-alt-period-jitter-term
@@ -0,0 +1,13 @@
+[config]
+command = record
+args    = --no-bpf-event -e cycles/period=3,alt-period=2,alt-period-jitter=7/ -- kill >/dev/null 2>&1
+ret     = 1
+kernel_since = 6.11
+
+[event-10:base-record]
+sample_period=3
+alternative_sample_period=2
+jitter_alternate_period=7
+
+freq=0
+sample_type=7
diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
index d4f0546e02b6..0f3360c35a5e 100644
--- a/tools/perf/tests/attr/test-record-dummy-C0
+++ b/tools/perf/tests/attr/test-record-dummy-C0
@@ -54,3 +54,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 48723cea3a51..d3a4f52a7644 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -827,6 +827,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
 		[PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD]	= "alt-period",
+		[PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER]	= "alt-period-jitter",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -856,6 +857,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -1010,6 +1012,16 @@ do {									   \
 		}
 		attr->alternative_sample_period = term->val.num;
 		break;
+	case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
+		CHECK_TYPE_VAL(NUM);
+		if ((unsigned int)term->val.num > 7) {
+			parse_events_error__handle(err, term->err_val,
+						strdup("expected a value between 0-7"),
+						NULL);
+			return -EINVAL;
+		}
+		attr->jitter_alternate_period = (unsigned int)term->val.num;
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1137,6 +1149,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1269,6 +1282,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 		default:
 			break;
 		}
@@ -1323,6 +1337,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index f1482361321a..9b9649da1932 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -80,7 +80,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD + 1)
+	PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 1972a5a696ef..c22e64407d64 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -332,6 +332,7 @@ aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 alt-period		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD); }
+alt-period-jitter	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7615d05e389f..c7a5ee61c436 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1739,6 +1739,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"aux-output",
 		"aux-sample-size=number",
 		"alt-period=number",
+		"alt-period-jitter=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.43.0

