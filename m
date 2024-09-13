Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C81D7999;
	Fri, 13 Sep 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218944; cv=fail; b=YvfAM5Nb7sXkmXLb2SQoVYSVHqcNjYHiUhC216ejA+4bUcTPCkRWLu6kaW1p1jVM0OJ90B8f9vFUP80opY6sTwEC4kmbCLKWT0WqBXQ+vQacXh+xVt76b0PDbKIggD1Zgw0xGQzKnM0v+CF+YhvBKDbKPhFRg7vmg6dY5F9CkdQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218944; c=relaxed/simple;
	bh=9jgZl4mJJ9zw3yROJqImwZIircAqHUZcgsi/+qSonXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXfFFeUjMgWXsnGQTQsd9Zl7SdIjxiUHSv1g/YTq/pPuWFoYTqliwgFIWJgSL3IW7KRcABntQIAwEXOmTYCwl0N2GbSE+n1wFLu+9fuWCsEYVZbuWjOrYkupfsZiyMehyOGxjFb0jGi47T+jho/FseBI6Uk+CMNmON+fZRJ1TT4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i5IKBQjl; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i5IKBQjl; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i5IKBQjl";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i5IKBQjl"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YqkNUrqyv8IZGeuqEuA7543KrTyL3sVtZ7u7B6Tb6Sj2obpIJJ8CaxWVEVbPVgVlG1JDI2HEx/VpgY5noIntJqAyQ/McJ6ePE0Of6mwn9AVFVUDQapGl8KWSD3Ym/eFD73ghxseIwSUdiOZ5Gi1AOCVgnerf31LC6jJbT18KhTrqBWF1Qqy8Ny1ACH/58ZEifQr0itA2Fa8DzDSi49LVfosbpPXY40Swd3G9c3szMqgW2TUh/KIEB4BMM5CbrBjt6ftpqt1ZgujbjcBFfqnhOo3bgOjchPtMtwFgQtXs3fOuCJrLGs+qUgD80plradqAWEAppiQc5bEjmAu+GRXKkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfAzC6KaEdEvdDNjAfmdFq6ExzlWS+As4UEScHzLwl8=;
 b=KBQeRBNaKhdFBR2rqNRiAcyobxSkqDqdF5FE2VIAL3LwqLR+NKrfRqsQAB9k3CEkiqFnAx5sVzakn6dwZCLYDbNFp4ZVpuJuvVOTh4tZdJOv2JPRjtzeNznVj6jL3YxDOzHFCWKG0nQ9K5zb/oOnu8IoDC6LWugIZgcbiwjM03HPVVpJIgNX3anwr/PHk1X7alMhbdYMif9u0JJ712oku0e2Q8iRuZ7B7Xbfylf/fKj1lHorOUZQMChb26Z/KjYRt8V0iap5SnQwvGMfPX2vpD/j/AaAqbaIBQDiWXHhFHb/iei4ZRt3aTfZdGqefi2RHyPtCYQtpMqV3Z98V6brcw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfAzC6KaEdEvdDNjAfmdFq6ExzlWS+As4UEScHzLwl8=;
 b=i5IKBQjlaLip21Ih70il328EGFd2yW8Igs1Y4kFMLEY9xe9gI1qEVWEoj2qgsTUdhpsOP0hKj4kn4alXJFjcRgsM7ajDJcfTjAHSeq5EQk7sgLVLuIuBFxUI2htMZa1CjhIAtaL8ytBWNHFa+Rfu6w3rJc4QtJOoNzpvvOcOooo=
Received: from DB8PR09CA0032.eurprd09.prod.outlook.com (2603:10a6:10:a0::45)
 by GVXPR08MB10914.eurprd08.prod.outlook.com (2603:10a6:150:1fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 09:15:30 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:a0:cafe::84) by DB8PR09CA0032.outlook.office365.com
 (2603:10a6:10:a0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 09:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Fri, 13 Sep 2024 09:15:30 +0000
Received: ("Tessian outbound 80464012c5bc:v441"); Fri, 13 Sep 2024 09:15:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d7f793b2667f8d81
X-CR-MTA-TID: 64aa7808
Received: from Lf96b34bd7dd1.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id B9F234CB-5533-4C4A-9671-EAA2BE1317E7.1;
	Fri, 13 Sep 2024 09:15:18 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf96b34bd7dd1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 13 Sep 2024 09:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWpWI7gFYgzKh/qXLQ5/l8++zHDOQkT5/6wBFmIpLRNyUBHnC9H0bPH2C4Y8zz/T1sZQwMzjMfMGESYsOGQNAkdpdtjLdcKei2w2m10KHoYqqLeQ7f+y+PnmPBBynhEWEhgAdltlGlymJ4cqz9K69uQ8rZLI/Ps0PkRjuE2IU1v0Shi9UW7W6W6MBBtZMWADzPz8pgIMb/q9GxfWq1rZLx/zwNLKs3Cj/I/3urGnp420ueR28BC6y6DXQfRqZ525pqTk8Ltz/+ZVhvDumrTFFsKx/7LaZ2g4zbIinfmTQV7TX1UwXuDZrmbyBEF5XMJkPaPP9QWloqif7aZzDm9iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfAzC6KaEdEvdDNjAfmdFq6ExzlWS+As4UEScHzLwl8=;
 b=UbktKlQHf48uy/Z+RoUkB+kkoggluewyh73gbhO2swjAFWcvUGep34ONV+EysTDRmj+QBPabJk9ZeFmUtKYstRgoZAcCMVceainohZQDPtoqyfpmkVFcXKNotWCpsZW28l6f7wEQBLPCN9DFkWGfaCAjla5uRJOJzPB+afCxK9q+YVnenhs33cQsjc77zF2fQnOQw3TDnw2PiYZ/eDpt104A3ck0Xsi17erV1kTW0a6AyNGR+8NLy2vx54BwsaKvfQapAscXa7zFhr3YYdA2T8u7UIrWEZN0SO7tyLF7EcOAxCfTEPr0cd1t8U0BcyF0Pwb2vZEyiAtoV61VWWXBug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfAzC6KaEdEvdDNjAfmdFq6ExzlWS+As4UEScHzLwl8=;
 b=i5IKBQjlaLip21Ih70il328EGFd2yW8Igs1Y4kFMLEY9xe9gI1qEVWEoj2qgsTUdhpsOP0hKj4kn4alXJFjcRgsM7ajDJcfTjAHSeq5EQk7sgLVLuIuBFxUI2htMZa1CjhIAtaL8ytBWNHFa+Rfu6w3rJc4QtJOoNzpvvOcOooo=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB6610.eurprd08.prod.outlook.com
 (2603:10a6:20b:36a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.8; Fri, 13 Sep
 2024 09:15:14 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 09:15:13 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: James Clark <james.clark@linaro.org>
CC: nd <nd@arm.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "irogers@google.com"
	<irogers@google.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"asmadeus@codewreck.org" <asmadeus@codewreck.org>
Subject: Re: [PATCH v2 2/2] perf stat: Stop repeating when ref_perf_stat()
 returns -1
Thread-Topic: [PATCH v2 2/2] perf stat: Stop repeating when ref_perf_stat()
 returns -1
Thread-Index: AQHbBYD5dFLOLQI6eE6HD4Zkve4TWbJVZSoAgAAATPc=
Date: Fri, 13 Sep 2024 09:15:13 +0000
Message-ID:
 <GV1PR08MB105210E217DA914A0CA8989B4FB652@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20240913020209.520104-1-yeoreum.yun@arm.com>
 <20240913020209.520104-3-yeoreum.yun@arm.com>
 <39eafc82-dfa8-4e22-9d8a-071ed09460d3@linaro.org>
In-Reply-To: <39eafc82-dfa8-4e22-9d8a-071ed09460d3@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB6610:EE_|DB5PEPF00014B99:EE_|GVXPR08MB10914:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7142e7-3720-4fb6-802c-08dcd3d49d14
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?CLhNj57zCKGi468pVK/5WDjBptmnDN0+irHD+ASyVtr9UgER9XTxGEN506?=
 =?iso-8859-1?Q?xKa4GpaTcavGJVQIimepeh2ivk2dNiI34IG6E48DmVZuV8ouSlDz6a2NCH?=
 =?iso-8859-1?Q?l4pb4U0w7YS1Lr3rOl3C26oCBu5ie9FFbq1/aA6SX0fwwB6xtGBR9DSpnF?=
 =?iso-8859-1?Q?S6IpTwJbDyPvfNLZwL/zlvgIH94viNNv5VQcgvYIB6l2SORREEnR5pNvfd?=
 =?iso-8859-1?Q?h4vDd6dc4t19tn69/oGA21sIur5xNXwxrhkzAYjFkxh9A83aIwlKCD4xoc?=
 =?iso-8859-1?Q?qT6Iu6kIQx5YRm0LLjGwbLYZsm07nY9chzk6gMxclCbi/S2QIwPYYr6+AI?=
 =?iso-8859-1?Q?ekZj2wAIa9QP6796xKd9LLaQNRoA+ykRJd2Qcja4LQ/+GGzAs5UyVQxU/P?=
 =?iso-8859-1?Q?DVoKg0eGkYdbvIm+zb7+PbltGdUaUl/C3jvFs8F0lYdR14dHOAv7E9q9vQ?=
 =?iso-8859-1?Q?TRkTysJ9hlFsTyzadFBReNhsBr+lGQhpjURFQtZSjU4YW8qMCkd7CSP6Ql?=
 =?iso-8859-1?Q?8g8Rikx/Y2Nd/Z1/Rhzpg5Ow+8UiTGnbxRu8rAz1vndRC/loKJVMnGc/O+?=
 =?iso-8859-1?Q?YuXMNFo65iA8gQPDCAEZuLcjpLDYJrSOltcpXDTunNhf5tMGpoxhd/AdSX?=
 =?iso-8859-1?Q?GjhN1jTPX0bprSNJLD/Se/uAHHvP4NsAxmg6BaxJGX/QnaLDqvI5DN0oQR?=
 =?iso-8859-1?Q?uuQbrxMEmKpLaYeomxxIHX4uTwgRmbwwZdQLizHr7CW4pDeD/Q+gL+lLBy?=
 =?iso-8859-1?Q?fzJe4172gsw7IwNQu32SU1x08Zi1zT5Y24u7DHGAqbeJgoCgfQaByD5PqB?=
 =?iso-8859-1?Q?9+gfcFGDrXWnrgqzzNIGlfaz0ip+U2NYBs8wzQJ6M0ZquhNLIg804e6BHc?=
 =?iso-8859-1?Q?qGglKE8exB6qq2dmajV8cP7ix5t3D7r25c5d9zOFl6sn01KWA8NAzUwsGX?=
 =?iso-8859-1?Q?Ql7rgE8e6HIbpjjCfTPcOQHOZcxjNk3a7nAZEo+EDGKO7mlAHbtlOWT2QR?=
 =?iso-8859-1?Q?wvxvzTzKZJNeorOYyGaupYGlW3LfZlKU5ZSJBj50Argyk9WcX0x/sTvSP9?=
 =?iso-8859-1?Q?iYQjOFWgW67PJBz4OGiuJdeWeoG63MVIDNGVYsZC31DoRYt2VAYlkwVM7E?=
 =?iso-8859-1?Q?3dZxtK3J4zvIVKHKP/o5m4+OMr0m6fSWVbiGgVmyq/GrknI9MdhGu4BMll?=
 =?iso-8859-1?Q?53XcOl6Cui/Aklwp97qFtZnTvIMyr+Y3PpvZEsV09v3DfibMqvYDj3K5Ye?=
 =?iso-8859-1?Q?EF+gV4olV45J7CkmlS6N/RBSfJGmow0C9N9C3OKSiGCO6AOHpmCv66A4za?=
 =?iso-8859-1?Q?gn0EV50tTy/HulhAVqpB4Fa+fUIbz76zS77DQu247D2q09fH6yAcfrkb51?=
 =?iso-8859-1?Q?4LHy70jZlC9O0Nkh/rG2AzSAXuiXxcR7GuNfkDPB8YkYoVryr25HYgBaEC?=
 =?iso-8859-1?Q?bQU1bu2tpvoU/t2p6LeI0C4G3i+43pcTNCaOVQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6610
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dd311fdb-ff9a-4725-7206-08dcd3d49366
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?B4kK4yl8uxAgRg3/abrZJHnqbHt+mtL0qFMoMO2os0RsuqCU9CjLGj8Yk7?=
 =?iso-8859-1?Q?iugVh/UM5DwVFZhJC+WV+c2ZVL0/wCDmx6EPUY2vMgmZwsStfxma93lUbE?=
 =?iso-8859-1?Q?OQ4iEzyfOSYYvImALf+HVPUTfOtmJtyhbkXpaQmjXtwJO9a4p40WKkj2Vf?=
 =?iso-8859-1?Q?rjePl+fFO7KJdldwc8aOwG9oywmJItp/jO2s2gih8ErDTaqwqbB1W9TmAr?=
 =?iso-8859-1?Q?MZHVUPboJP4Y13HMiQ1XJYMBMy0ARsi9JafUGJcuI7/x/ZCPGpl6lcVT80?=
 =?iso-8859-1?Q?6w/JVEIb/QG4HRaRV/Ewbjn6q3LKQyqsHnDTaOjufN6PUebtS/Eff6VW5g?=
 =?iso-8859-1?Q?XimYc5p5jM9Zuz7uqRAvQApj9zGv65fGXx1qOhLIh9azAz3QJDOC8+gN49?=
 =?iso-8859-1?Q?afN9Af8ibnCAHqhQEkxvH32mab/FtTKKaOPFwS00FwvlZV9wKzLuDUENhP?=
 =?iso-8859-1?Q?1C2439Y9l4d+6CkGPkd0D+X+hbVc2MgWg+jbmWSTjqHVfTH4QKeaq6iW50?=
 =?iso-8859-1?Q?KKQgl1Te1fM/d6PusskSbDzHtI8wcoKqw8FKp8nJVnS6E8fXwg9k1/AMCO?=
 =?iso-8859-1?Q?uKHYYbwEa8m8tfGh81lrc0dnEDblm3ay3vHdnJkkQHdBXihXHD5+EVOdQF?=
 =?iso-8859-1?Q?WmOVL5Nmd2VaWUczQVIZZzOqEOlomuJbJGUYMeR53Vk7pqNes0NUUDnzAd?=
 =?iso-8859-1?Q?9zw3YG97srCgel6rktZl+N0YFDyqu+tcilJrIGUXaoFQLvqoNLSi/0O04J?=
 =?iso-8859-1?Q?gOKEVuL5tBNSYLAivnklhyonL+wRzIrFq6H9UKpH323WXgQh/TGoHFFCEU?=
 =?iso-8859-1?Q?683NR92dE4xlNedJPyyDkGbzb+tToYi1vvP2lmsMy4xpSlSO8uuVtg7V4s?=
 =?iso-8859-1?Q?0giADHnqYYYud7vJlbgR3olMOUiq1CruWAzQElLg/aJ0AX6cVawvrPOOu8?=
 =?iso-8859-1?Q?nsUSBfJ24WODIzlggDJOQ4X5k4+2xap1QnQt3hGcHNvo9uKLwIj00wpQBN?=
 =?iso-8859-1?Q?bnOq851UWViZjuI7kkyLih18ljUiSWWXgR8sNuE2rekJYWg9UjZ7iMGk/e?=
 =?iso-8859-1?Q?PW1Dd+aHy6PXxa8F6Bbb6AUQR/CXFtW34c493QlvEFjL6C0y5bsEYHcRKk?=
 =?iso-8859-1?Q?tPEPEwh9CgOcy58YziIsxEm81rksTFwwZyyn3HtMtEkdfP28vuJgWYBDWi?=
 =?iso-8859-1?Q?BzNIVFKUDcSJExkn5Fsz0d9RB0yY//TZbja44aD5rAqn0DJJd44gEqFhA/?=
 =?iso-8859-1?Q?0y7hEGndmSEtPQerUbpx2Rr/aWYLp4S4i8CtwMK2q85JGJe+YJ7IOJkSL0?=
 =?iso-8859-1?Q?qqdAwQ4s5cL2bn+8udpE1DKcYHU6qPr+/esw+SKVCalipemoS4YKJ0QrSy?=
 =?iso-8859-1?Q?SQ65rDTBNZp94jMtAJj/Ug2qrq5Wa8TrM5qf4EwtuPhxn2l9GIVH48bcOf?=
 =?iso-8859-1?Q?E9XGw4wV1tz2duFvT8UxsVnHimHnj/EH0tiC3sK+sJggccGcsWvVfXsgvM?=
 =?iso-8859-1?Q?vATJ5YXAZY3sxnqDw0ozhT?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:15:30.0880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7142e7-3720-4fb6-802c-08dcd3d49d14
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10914

Hi James.=0A=
=0A=
> There's something wrong with the formatting here.=0A=
=0A=
Oh. Sorry :(.. I'll fix it.=0A=
=0A=
> But I don't think the comment answers my question about the other return=
=0A=
> codes. It just states what the code does.=0A=
=0A=
> There are many more return -1's than just for COUNTER_FATAL, so it's not=
=0A=
> just that situation anyway. And in addition to that, there is -ENOMEM=0A=
> and others that aren't -1 which aren't explained that they are=0A=
> deliberately explicit retry or ignores.=0A=
=0A=
Ah. not only STAT_RECORD error, it could be generated by pre/post command..=
.=0A=
Okay. then I 'll changed with < 0. That would be better=0A=
and remove the comments.=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From: James Clark <james.clark@linaro.org>=0A=
Sent: 13 September 2024 09:36=0A=
To: Yeo Reum Yun=0A=
Cc: nd; linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; pet=
erz@infradead.org; mingo@redhat.com; acme@kernel.org; namhyung@kernel.org; =
Mark Rutland; alexander.shishkin@linux.intel.com; jolsa@kernel.org; irogers=
@google.com; adrian.hunter@intel.com; asmadeus@codewreck.org=0A=
Subject: Re: [PATCH v2 2/2] perf stat: Stop repeating when ref_perf_stat() =
returns -1=0A=
=0A=
=0A=
=0A=
On 13/09/2024 03:02, Levi Yun wrote:=0A=
> Exit when run_perf_stat() returns an error to avoid continuously=0A=
> repeating the same error message. It's not expected that COUNTER_FATAL=0A=
> or internal errors are recoverable so there's no point in retrying.=0A=
>=0A=
> This fixes the following flood of error messages for permission issues,=
=0A=
> for example when perf_event_paranoid=3D=3D3:=0A=
>    perf stat -r 1044 -- false=0A=
>=0A=
>    Error:=0A=
>    Access to performance monitoring and observability operations is limit=
ed.=0A=
>    ...=0A=
>    Error:=0A=
>    Access to performance monitoring and observability operations is limit=
ed.=0A=
>    ...=0A=
>    (repeating for 1044 times).=0A=
>=0A=
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>=0A=
> ---=0A=
> Changes in v2:=0A=
>    - Add some comments.=0A=
> ---=0A=
>   tools/perf/builtin-stat.c | 10 +++++++++-=0A=
>   1 file changed, 9 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c=0A=
> index 954eb37ce7b8..0153925f2382 100644=0A=
> --- a/tools/perf/builtin-stat.c=0A=
> +++ b/tools/perf/builtin-stat.c=0A=
> @@ -2875,7 +2875,15 @@ int cmd_stat(int argc, const char **argv)=0A=
>                       evlist__reset_prev_raw_counts(evsel_list);=0A=
>=0A=
>               status =3D run_perf_stat(argc, argv, run_idx);=0A=
> -             if (forever && status !=3D -1 && !interval) {=0A=
> +             /*=0A=
> +              * * Meet COUNTER_FATAL situation (i.e) can't open event co=
unter.=0A=
> +              * * In this case, there is a high chance of failure in the=
 next attempt=0A=
> +              * * as well with the same reason. so, stop it.=0A=
> +              * */=0A=
=0A=
There's something wrong with the formatting here.=0A=
=0A=
But I don't think the comment answers my question about the other return=0A=
codes. It just states what the code does.=0A=
=0A=
There are many more return -1's than just for COUNTER_FATAL, so it's not=0A=
just that situation anyway. And in addition to that, there is -ENOMEM=0A=
and others that aren't -1 which aren't explained that they are=0A=
deliberately explicit retry or ignores.=0A=
=0A=
> +             if (status =3D=3D -1)=0A=
> +                     break;=0A=
> +=0A=
> +             if (forever && !interval) {=0A=
>                       print_counters(NULL, argc, argv);=0A=
>                       perf_stat__reset_stats();=0A=
>               }=0A=
> --=0A=
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}=0A=
>=0A=
