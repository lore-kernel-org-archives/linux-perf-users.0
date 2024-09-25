Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898761304AB;
	Wed, 25 Sep 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260743; cv=fail; b=DtRdN7q2BGKk6fjeD1gHFbbIrNqliadvqQa6O1KjBo42W8rTeARJ+BpeCsQyu+AkyOEaLeRR2SVX2SaWILEOj31yKiWgzfH/vlZKcoC/CB/fzTxbcAc/wQExYD32wdUJvf9wa218rXkls1PASBAfiB30UfT5QfsZcCXIBPqTI6w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260743; c=relaxed/simple;
	bh=Lz6Jxl0YAKL1+eCeGnlevXiRfOC+EneQxGtsXItXt3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ogyRYxcpzgp/0Ha8qDlMGvFrEDWjPr+Pj19JajhK2n6h5yz/txNAqJbjG6xrQWrHm1+Z5tbLms6L6Epa9/RhN7XQ9fCaYRhZ7HXmWaxabdyHeSFvinOx5J651QfTkiMeVttso2H3xmJWW32XAyIC0mkh/D8SeOeszfj3D9DEUo8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NXT/wT99; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NXT/wT99; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NXT/wT99";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NXT/wT99"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EnZGdt/fhVwvU6xywyXH1N1JCsEmZV8WmKuDtyFKUxbcxDc5sLu5WO8jrJwuzjifaMf+9MKlGVHCnPhlvA+aemRlMJcQt602FXM6Nbs72Pf2G6SqFTpzk6jg80jhLLQsTwYk63vxdKr3qr+nQsHPKeZp2Odd8pe47C1EQVTiZMfEIjlAGukbV0A+moR0eETAZk4zsZKvU9KSh3LpJ0aipzASklnMkQa+MYiG9o6MixyjtPSvXQV3A2PaeyJN/9SZA/QHbhw/J3BdcQfiIthgIZEnfba7jsskfX8TRSmoyF1sCEQQLTn9UbFTeWopmR8lsBNY++sI0lvK7w0d3otB2w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmjZ4NTrGwyqJmqrCeHnLePXYwTawkheeht9qFAbwiM=;
 b=wHxk4cdrj44PcgAGDTaoEZLNpPrOgC0xxEo5pOC5derkS1+f7mc968dWoK5EPxxFyrh8qpBsm+kEocmcufQxGb+ff8FtdEHlCohCAP/KvhAYoxqFuXn3fKwNh35GfMhw+V9Tl3U3heh6R5pBxMnQ796uRngF67ttAvRTbYuhdIjmF/auQTrulRyhj2/K6iucnzDxi5F27vXfgDoQ9wXj1OXkw7QDKBZhuqEI1NtBUO+dKtikxepBtxbP5Sr4vsmeS6RRNnYQw1Vg0epxj/0WhgQJ/+UkUdQUUl16ntsmvuJgLgp/iVUtox2C2X64qyKyHib2M3TMGtad2TXcCTg1Hg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmjZ4NTrGwyqJmqrCeHnLePXYwTawkheeht9qFAbwiM=;
 b=NXT/wT99hiyTN+V6TA0CNDDJITlsk4ztQnPR3mjgZeuaSlMuSfgWQ6AcZE6SEzzuNCi5DACbBQHOafri65br5RfpBQgRiJhu1MRK3aKHc5iU4/LdenDdfm/dJmXNKVobj51kHddlQmpOd25Pm227GFRpqE0aKdtT3hAAmhAoOBc=
Received: from AM6P192CA0048.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::25)
 by AS2PR08MB9389.eurprd08.prod.outlook.com (2603:10a6:20b:597::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.11; Wed, 25 Sep
 2024 10:38:51 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:209:82:cafe::8) by AM6P192CA0048.outlook.office365.com
 (2603:10a6:209:82::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 10:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 25 Sep 2024 10:38:51 +0000
Received: ("Tessian outbound 2e8248bf46c3:v465"); Wed, 25 Sep 2024 10:38:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ba2eec32ab61e4bc
X-TessianGatewayMetadata: rd3MUqM30mkHRq1KbpVJLkp16O8XEYb7bPdrBh3d9TaZN7U9C7WT+hOWpGFyOV4IDN3aDQh7pffa1aDCg9/OHIBA57Ya+fRhcorE4xjbLcBtqu9SIUVqCjiuXk9twu46UkpFciblMuXldL29z+mPyAGq2Vr0Twm97FsCk7I6Ew5W/MT8ru9ChViClJfxoi7DbVpRHvdUnyl1X02X7Wuj6Q==
X-CR-MTA-TID: 64aa7808
Received: from L97370d751352.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id ACD825DA-11E4-4488-8412-C95C267CE661.1;
	Wed, 25 Sep 2024 10:38:40 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L97370d751352.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Sep 2024 10:38:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGa2oucWBrT3bfCIEZ+Zu2qTxDr2Bg1fGNW5xYDw/sjuqM5BuYFI4yY23zKrAsO5JttVhhj0Oc/x1oRRzUmsBoETXRC1x+QtwWoadREtS1CK1VU+DK3TZmiQA/pwrXkSvO0bPbYSVflljlyrm8e8VVkgUyK+t7uFomw75OASe5/2Knc6tv1YWbKaKgsHnxerfzkakd0LniNFYDMAsiSs0+8ACGsoZ+k+S0Caxc0ho2VGdtm+v/3IVpx/n9SUTEU/LHndGLQvq38SPh6zf/+RSPfwAy677in4ISd2Ex1+rHxB5InpZEpHFSSaEMnM3Xg2bP+9XzobFGu/1NmGE05V2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmjZ4NTrGwyqJmqrCeHnLePXYwTawkheeht9qFAbwiM=;
 b=lUHYbrDkudUsKlASpi66e5d15fJLXaMSUeHTcK7BaYjFhTv8jvvNpd7qnWeqMGYGFb6sytLdNF+BrIsYMyM5PZYex6YKfJcHav0rD5Iqz12mN4cEp0jdxxzol+zvNgsjd6OmNrlXF4j3nlc1TcRJrwofWkQ8Q1sldr99lmSXuA6ZNYrljRzmkZ5so6FEIYKBu5Lh76uXuQRQwClWiKzwlnGrLvcND85crZTLiwofsM5SuQQddEN9RbCa8wOKGyvij1/o5yIqJ6CIBjqRuQa5KTo3gaDUIUt25EeYrjvLWG1PxYKvJP4w2SV+YkDky+GkHteG2XzdHzNVLXZKWLVR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmjZ4NTrGwyqJmqrCeHnLePXYwTawkheeht9qFAbwiM=;
 b=NXT/wT99hiyTN+V6TA0CNDDJITlsk4ztQnPR3mjgZeuaSlMuSfgWQ6AcZE6SEzzuNCi5DACbBQHOafri65br5RfpBQgRiJhu1MRK3aKHc5iU4/LdenDdfm/dJmXNKVobj51kHddlQmpOd25Pm227GFRpqE0aKdtT3hAAmhAoOBc=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB5PR08MB10048.eurprd08.prod.outlook.com
 (2603:10a6:10:48e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 10:38:35 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 10:38:35 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "asmadeus@codewreck.org" <asmadeus@codewreck.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd
	<nd@arm.com>
Subject: Re: [PATCH v4 1/2] perf stat: Close cork_fd when
 create_perf_stat_counter() failed
Thread-Topic: [PATCH v4 1/2] perf stat: Close cork_fd when
 create_perf_stat_counter() failed
Thread-Index: AQHbBeUg+/U1MGUVB0u+C+5naAKH/rJnZEQAgAD98iU=
Date: Wed, 25 Sep 2024 10:38:35 +0000
Message-ID:
 <GV1PR08MB105214E9BE2F298AA2F656BB6FB692@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20240913135907.648734-1-yeoreum.yun@arm.com>
 <20240913135907.648734-2-yeoreum.yun@arm.com> <ZvMTBryjl5xTYr8W@google.com>
In-Reply-To: <ZvMTBryjl5xTYr8W@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|DB5PR08MB10048:EE_|AM2PEPF0001C711:EE_|AS2PR08MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e92d63a-e726-469e-5ff5-08dcdd4e3f26
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?fNOfT6ioakKcGe5kYGsuAiv0D5RHdeRj+fx6iSVzwqvMpTEtM7qe+jKQ3Ohp?=
 =?us-ascii?Q?GcQXocWxuNOEv6zMXJdWI+1hmUNCxxYuaP+CgorxFPygFfWW329IAMA3EFMv?=
 =?us-ascii?Q?WP6bvPBA5jiK1AtBeVlD2Yk2wEbCqvrcfBLogBMr3ECwAsr5D6hBHudOIj3C?=
 =?us-ascii?Q?JGxecjKLq5GIkpdgMf2OeNZyMlmCEyCjX0CH5HbQx7mylHY4Mhg6ewk7WLEJ?=
 =?us-ascii?Q?teme0c3ujpyZtA14T0R45322cCboPuboFtYnZK+EZLCiqa5mWAvIMcufs+7R?=
 =?us-ascii?Q?ftzOdhkIrmxlkmZZj0ehuR8MF6d11v1jzAtvuOkDtFSzxCeaoE3gAj4fl2nA?=
 =?us-ascii?Q?MBBz2BfHZTBjyATDXG54dNX3volUALgi9SabYbhwqP/7/dOBTfH445sw8MSy?=
 =?us-ascii?Q?qCNH8rLffUzcE3z3i2Fai0XP4WnQ0Sx2ZKNcTlpjwpbbm6j5BfoGAsD773ec?=
 =?us-ascii?Q?EGERCvVdk89E95E3GuYgydNdSwubXGxpMAJaySYBi095Ywn68Z/64hL+FEKC?=
 =?us-ascii?Q?wbvotE7XEKwRtIV4woUZJjrfvDqUzkb6vDJgZeJ9HK6eJHIJSF2/AvyMd93N?=
 =?us-ascii?Q?4/acIYvaBflezdbzZ9uQhEdSDorIidKnC+i75HlfTz2VyXColNkC3tWI0qy7?=
 =?us-ascii?Q?0/p5eEnxJAGm1kI93u0zKyaB+bWQ4hAQQI9ZaXik4axSZaAXll+AxkhKuJZs?=
 =?us-ascii?Q?ekuDqbaCu/b/4iNmSkxJ/AVLnFF6Oa3sbTb2kctwxAN2SYziH/5Aijqrn3YV?=
 =?us-ascii?Q?VWOwdk0UOxzbRL8AFN2eZ3SHtOrhd6Q1lbwzKL5iEGv2F4LFvdSSp1sIxhhO?=
 =?us-ascii?Q?2YzcKaKGLgXniFcaLhJjg/pSmJOQKlDc5deJp1BZNTkhz9FFLslb4BWCQDM3?=
 =?us-ascii?Q?/HOFT2YzxP2X9CZdX3EnzwHCo7HwoAHHfuWM+97zK5bNZ5IJyWYSn2g9/k+B?=
 =?us-ascii?Q?EkNplhjHwvsepEBBSeLhj7B2z6HpzKFh6r9FAupporBTuuCA1o5C996pxTU7?=
 =?us-ascii?Q?NjEe9CUGyWHx+lODUkbWGy5PPsRdGRb/aRkkx+opLdrNy31urZeycOl5z4ak?=
 =?us-ascii?Q?iSVN7pYWLIhif7wp0JIZbOZO3tDFAlkeVC+GHq9lbZzDv2HVsEudxJ/N4NtH?=
 =?us-ascii?Q?FRQusCsjhelSTzwEal7P+UuUnDmd3lN9CvksKE0XX1x+iHWGxiOcriOAeyFT?=
 =?us-ascii?Q?AVQ3dVzZXUGVWdi7iC6TCBSS80OM/Kmy+zE4YSkXDQjPNDYkf9cv0SIy/g65?=
 =?us-ascii?Q?TibYBe4+XdHRElhNlt6eNbY3taakFRzu4eSZFDNXn1iwtHrGSwmKUvASC0QS?=
 =?us-ascii?Q?MR8nu+M/WwLa8MF7L17CTsBFN0R6a6+KtnxiqW29siViSlhdpQjMCK5HFFx1?=
 =?us-ascii?Q?EZzTsqX3xxjlFqe+UgToJPg99iRivB3RuUpg4yaA1VklkjhzXw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10048
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	452f8991-7ca1-49a5-db76-08dcdd4e3543
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|35042699022|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7XdZhfP6AJbIguxioUixyE/g+0SnnssNSgYiFT3ZTWTjG1iUXIyowD+Xg/xu?=
 =?us-ascii?Q?MibXNHU7skLFw0/aJpDar/MyBXy9NT1EfsDPiSEVNJrdxZDISGGdk3gVAWGu?=
 =?us-ascii?Q?DTs1qfQ/i12FxB6/kbJ69v/3A3gE+U4BIjw5sCIh9aoZGrHXFBwthO2ib24r?=
 =?us-ascii?Q?DzUfWyaUP/id8pTBanPJEM9HD/erpWAA3izJo/qL3Krv9m2VUQOKOJucKF95?=
 =?us-ascii?Q?Kdsp6y3wYele+tfX/0SdFnqO/IgU9DlWclCLjQkkaovS4NmVHMCrA5ZXuncL?=
 =?us-ascii?Q?yWgcnHu30mwBFhEJxyQ7cbNu5lGzbR9iRS1FNzV8YHrnTdQKZo95HMhhZmdp?=
 =?us-ascii?Q?bjYsAfGZbC0fhJ7oCN3qIGM2kW8Iw6eVy/xljuyxntekawN9O8aoE0p7WOhR?=
 =?us-ascii?Q?hknFQ1MvRfWPhwtNJTwWWeepGfoqVv+kEUbAqslcUHjMS16kN4Qse4jsw8j4?=
 =?us-ascii?Q?PSB9wUaWuz2pSgznCJYUll30uabJNyKO0Q3LjnYRYB+gNy7T4WNwUoG4BrmQ?=
 =?us-ascii?Q?C8vXVPG8U/S3crwtGP5Yn+2wTM3reHQyXz7QWVnkdL51nJTizBZ1Eunaib3d?=
 =?us-ascii?Q?XJm2Lh2zotyl86up7weLVvZSmkZiMSMYQDF5kRCAl15QmKDB+wgKBd/d+ipc?=
 =?us-ascii?Q?RwmhoQMsq3l/3E5LCjHD+0xz2HsdcBJRihJ55jotQa5bFU83ZkPYYpEmiFTJ?=
 =?us-ascii?Q?fey4PQG0Hd6Z7UV1Wxm+/P2bhXlLlNDE1RAoSAx0h2UMFWdrXT4BcRnTD6kb?=
 =?us-ascii?Q?PDD+kp5CBacbvvwGNofez7AUp2HJBheoWhMa2aupdsTsKQGuFd9VMIF6wJXx?=
 =?us-ascii?Q?pV6ht55kQOrWo4z1iW9LC3FpUEcYWJYPZ8pZEZuY8ZGUeWwHnqriXdYtzrDb?=
 =?us-ascii?Q?46YrJjhHFyEaMXT65FwBAFovKK1qp4SX+XE6RO9I/tt2eSkRTXbhBfGmyk/u?=
 =?us-ascii?Q?6QkYa5rHmoHuuFCwuFU/E1aPsq0585t0N7Dp9ERbDrHTI8/fnm1NoaYqvghh?=
 =?us-ascii?Q?yDa8LeYqoPAYpp8rY5K19OYbqsKj4rBOdl3BaLtH/zGKymMiORcRtJeIppVB?=
 =?us-ascii?Q?6JtuF3HgfG7Gnf1uYWHaR79Rt4PbPy/DSpAz/nw1cIpNlEG9YhpIv0M2Qmf3?=
 =?us-ascii?Q?l6g9bXnDSCaeGf0U9qxhz/jsHDKf+V/taR+8zy7SYi+hmYkJNQhojAXXmQ/H?=
 =?us-ascii?Q?zxN/M70jNSSelmHcxy7//qHKqWDELmOcnwLGk8Ow6/QLcYwOngdy5uykNieN?=
 =?us-ascii?Q?u7QmUIZM83Fvk7/lgORqrgw9ZCPSJeiGubC3GDRMcSljELZdqOHGTflWdzzn?=
 =?us-ascii?Q?j/vrFXSdpBMQebHVNDCzCeTtNNHnZSb873MNkPBCk72u+NhRU6M3WVVQ/ofU?=
 =?us-ascii?Q?iIWTB47Vz4hyo2lz4F58Qpu2SAlf?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(35042699022)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 10:38:51.5653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e92d63a-e726-469e-5ff5-08dcdd4e3f26
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9389

Hello,

> I don't think you covered all the places it can return before starting
> the workload.  You'd better have an error handling code at the end with
> a label and then goto there.

Right. I'll change it.

Thanks

________________________________________
From: Namhyung Kim <namhyung@kernel.org>
Sent: 24 September 2024 20:29
To: Yeo Reum Yun
Cc: peterz@infradead.org; mingo@redhat.com; acme@kernel.org; Mark Rutland; =
alexander.shishkin@linux.intel.com; jolsa@kernel.org; irogers@google.com; j=
ames.clark@linaro.org; asmadeus@codewreck.org; linux-perf-users@vger.kernel=
.org; linux-kernel@vger.kernel.org; nd
Subject: Re: [PATCH v4 1/2] perf stat: Close cork_fd when create_perf_stat_=
counter() failed

Hello,

On Fri, Sep 13, 2024 at 02:59:06PM +0100, Levi Yun wrote:
> When create_perf_stat_counter() failed, it doesn't close workload.cork_fd
> open in evlist__prepare_workload(). This could make too many open file
> error while __run_perf_stat() repeats.
>
> Introduce evlist__cancel_workload to close workload.cork_fd and
> wait workload.child_pid until exit to clear child process
> when create_perf_stat_counter() is failed with COUNTER_FATAL.
>
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/builtin-stat.c |  4 ++++
>  tools/perf/util/evlist.c  | 14 +++++++++++++-
>  tools/perf/util/evlist.h  |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 661832756a24..954eb37ce7b8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -763,6 +763,8 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
>
>                       switch (stat_handle_error(counter)) {
>                       case COUNTER_FATAL:
> +                             if (forks)
> +                                     evlist__cancel_workload(evsel_list)=
;
>                               return -1;
>                       case COUNTER_RETRY:
>                               goto try_again;
> @@ -804,6 +806,8 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
>
>                               switch (stat_handle_error(counter)) {
>                               case COUNTER_FATAL:
> +                                     if (forks)
> +                                             evlist__cancel_workload(evs=
el_list);
>                                       return -1;

I don't think you covered all the places it can return before starting
the workload.  You'd better have an error handling code at the end with
a label and then goto there.

Thanks,
Namhyung


>                               case COUNTER_RETRY:
>                                       goto try_again_reset;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 3a719edafc7a..51a221679c92 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -46,6 +46,7 @@
>  #include <sys/mman.h>
>  #include <sys/prctl.h>
>  #include <sys/timerfd.h>
> +#include <sys/wait.h>
>
>  #include <linux/bitops.h>
>  #include <linux/hash.h>
> @@ -1465,7 +1466,7 @@ int evlist__prepare_workload(struct evlist *evlist,=
 struct target *target, const
>                * For cancelling the workload without actually running it,
>                * the parent will just close workload.cork_fd, without wri=
ting
>                * anything, i.e. read will return zero and we just exit()
> -              * here.
> +              * here (See evlist__cancel_workload()).
>                */
>               if (ret !=3D 1) {
>                       if (ret =3D=3D -1)
> @@ -1546,6 +1547,17 @@ int evlist__start_workload(struct evlist *evlist)
>       return 0;
>  }
>
> +void evlist__cancel_workload(struct evlist *evlist)
> +{
> +     int status;
> +
> +     if (evlist->workload.cork_fd > 0) {
> +             close(evlist->workload.cork_fd);
> +             evlist->workload.cork_fd =3D -1;
> +             waitpid(evlist->workload.pid, &status, WNOHANG);
> +     }
> +}
> +
>  int evlist__parse_sample(struct evlist *evlist, union perf_event *event,=
 struct perf_sample *sample)
>  {
>       struct evsel *evsel =3D evlist__event2evsel(evlist, event);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index cb91dc9117a2..12f929ffdf92 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -184,6 +184,7 @@ int evlist__prepare_workload(struct evlist *evlist, s=
truct target *target,
>                            const char *argv[], bool pipe_output,
>                            void (*exec_error)(int signo, siginfo_t *info,=
 void *ucontext));
>  int evlist__start_workload(struct evlist *evlist);
> +void evlist__cancel_workload(struct evlist *evlist);
>
>  struct option;
>
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>
