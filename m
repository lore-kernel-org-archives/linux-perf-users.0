Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336AF212B3D;
	Mon,  9 Jun 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481131; cv=fail; b=vDXA0R4VMBBS2oun+HRfuP600AC2koaY+DE97a8HZySyvFwWE7IQAleRMfy+Huqe82Mqaj0py78cliu7/Bkn7CbAY5hSJtYVw9LUjoikZiaGHSTQlk0aU4+ikwhscJJyHYOspgqgO6+fvOA5f/ixyKH8nEjUK17NmbMpD/Fr8DI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481131; c=relaxed/simple;
	bh=Y4vLpf2b7dcOINzlbLqLxd3ENPe6xUYBeNwScNogRNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VhOSnQy2zeH40UXQWbKQvICTaaYiuVv4Dn0KjL7ctZzp9zgvCc/Mh1PJKpEh13RKrZsPnfHFOpmXZitlKG0ffpQe0K0/soT8nPH0HeLKaGtXDscBoUPNeeB2uusJ36J88zldxO/5klMlLPSQqhrH3DYNEC+jrkEYimI+6tY0myk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=reSUmU/u; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=reSUmU/u; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="reSUmU/u";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="reSUmU/u"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fK5Iug9T/0174/IQ1+rPFgSdRgsr7YEnjbeBs4awDkhwHgLGuN6kpEggIDzXICM0047ix4DxxBi5Iev6VW0++DU/gKVMIW1X+5ZwlEEMhtscjjbwPyEohsxtZFHMkxCtzi384Y6QzmzeCby4wW8VpN/pC82xUtgkjqOAdCz7s7ajUGyMpZzQU8OomT8mpRvCjEzV09uTFpBBDzeg29xxMUhCZ6haJvBKZCUTgpv0KHfDf5s+AxAJYCfFKK0wAP8JNls8/JRZOI3bbGq9JqVHy8VTjqo+QSkjSbgFE0uVGYqF5umQjDL8lXjFeLB9HYurPLhVkBaDCskJFWnhCCBedw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rScMR+cdKq+Fycc+VUDEog59Cdhr3ZSgbyMxz+wtBK8=;
 b=xebGmxcIgM3gy3xDSNHRuZd5428+jGChmuv4+7Ip8vT4z/FuHmNdTIs6l7H/198HoQkJ+WXrm4NM8znvzchrjXpq6I8tJVgr7WZh6H5NvAeirxbZq7vm1YhnUAx0KDQiiq5zZqEOarHDaX1JH/ZXHdHUNTK59fdcoJwQC6WKhHFE/l46NwwH/dYmFWPqR38JLu010XTzBTybADsxDLevz0s+uIZyTuPo/+ubnUc0lrx+CZV5ptb7erQY1aeAFVpKFlrWFlMTe1yUtMK7ccqwWCwXyInUNpxUzgCVQ1nN/yZhdjiVuqXvzfKJzCL9B9vUZfsi5ILieuRm8o2fp3Cilw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rScMR+cdKq+Fycc+VUDEog59Cdhr3ZSgbyMxz+wtBK8=;
 b=reSUmU/uv6fXp+eGYybRtwtdoPAllkvqrTz4w5PuYeRw29bGsLGEP2Hw9BdDx5s0XIzFVVh9gKoi0PNK0GhTHO6feomFWLkHqN+a5XE4K9EmSKHEzbvheTVbGZcey8AUh0GBzZCmKEW818Goz3IbY1y4N55gVIoTb+fiLFkQDKY=
Received: from PR3P193CA0035.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::10)
 by DU0PR08MB7613.eurprd08.prod.outlook.com (2603:10a6:10:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 14:58:42 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:102:51:cafe::b6) by PR3P193CA0035.outlook.office365.com
 (2603:10a6:102:51::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 14:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Mon, 9 Jun 2025 14:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nq0jSWAZHWRl97JPhEnDJkE+2PfKizxyAlBl4yyz3y433PMoZ3gPTP6eCfSQUEpy6U6d36yf31/CYx7ympLPd8qVqNFMK0MxmWVC5J8eMjJYI0lMya7UonunbAAW7cGrbEwexdNaUMm+QkcawoFYPUedTvLZ0IAn5D1PJMS1M/c/jzua9EAUPO7V8L7KrdVBnzHGrdFLhi2PwBKZOV9gjUcojkmgqAPJj0I79a8ID+tseBmSY0w79ZNLSQc6s7Cu4VbPahYuSWh+ZNqcBwBg0Q125iHAtEDLYaVh/TBaIMLYtGAqbOky5kNARBxszASv5hZ4tglEx/0jxMyUwUV58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rScMR+cdKq+Fycc+VUDEog59Cdhr3ZSgbyMxz+wtBK8=;
 b=Zu1wKllsk+Wze5kliUDUGL1VwC0i2nQeU4RkeKwbwz2qqz95bVxAsSEQderETrUqcAHadYP9DBA1QzQgxIsNiju6L2Jbf/M2DBtXki59ewtWENdctoGuGO1ap9mMc67BRonq7DcsjxZDvgWuCAfafAiooj+Y3Zb5Ola/EjoftVhYeTAW4VIpPUkzjH4w3jb+mfK5EmFWN9kBhXO0npTJv6JV7SWfVY97KowDMpP3JjT45Vo8qQF/fKnLiq28z1wTQMm5+bg/2KbbPVjq8+X3nkI7YocV/C9bz7jwARwyvNiYOy8Y6LNI8V8U98iriApG0ej9/sT9myyHizPan84C3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rScMR+cdKq+Fycc+VUDEog59Cdhr3ZSgbyMxz+wtBK8=;
 b=reSUmU/uv6fXp+eGYybRtwtdoPAllkvqrTz4w5PuYeRw29bGsLGEP2Hw9BdDx5s0XIzFVVh9gKoi0PNK0GhTHO6feomFWLkHqN+a5XE4K9EmSKHEzbvheTVbGZcey8AUh0GBzZCmKEW818Goz3IbY1y4N55gVIoTb+fiLFkQDKY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS4PR08MB7829.eurprd08.prod.outlook.com
 (2603:10a6:20b:519::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Mon, 9 Jun
 2025 14:57:05 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8813.020; Mon, 9 Jun 2025
 14:57:04 +0000
Date: Mon, 9 Jun 2025 15:57:01 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/aux: Properly launch pending disable flow
Message-ID: <aEb2PZHb6c175uPy@e129823.arm.com>
References: <20250522150510.2942814-1-leo.yan@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522150510.2942814-1-leo.yan@arm.com>
X-ClientProxiedBy: LO4P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::7) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS4PR08MB7829:EE_|AMS0EPF00000193:EE_|DU0PR08MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7719a853-40aa-433c-c015-08dda7661fc3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?DgaVZ6UdSp13rsJeILS5WRSrxxEbC70j7T9RSfNrbHKys/GIDPtMq7Z294xg?=
 =?us-ascii?Q?vV+rqK3S6fKyv5mvQqsR/FROf9iNWyitSYbOD32znVBQtsszmBIJr5t7UF/A?=
 =?us-ascii?Q?DI/7kGrXRmwK3uZ2K5PAgZkIDWAhbpvCODo4c/PPn3nSVAOif2Khz1qEPLpk?=
 =?us-ascii?Q?kbi1PuhJN0bHQd/mDJ2wcLhvzSdQPt5qUueT0LR1PAndHvnR950PIy3+6MJE?=
 =?us-ascii?Q?lwYVKFhVPUFGcH5O93Q+CgfcdPPJUt2T5i08S5c+sLlSw3Pvt2MxEe5BYIeM?=
 =?us-ascii?Q?ACnPaXZxjNwg1Fvs9Ilc0vb04PfrXwDz88KhYzeKck/jmk3Yct2UveQ48dcL?=
 =?us-ascii?Q?HPvv42xPyjGzjccS2t6hIIQMk2Lo0Ayca6GSqCh/k7uKdlLyUN6hd0fn8QMj?=
 =?us-ascii?Q?jmTcc1ANus3BdVP14jDvY2LorcSnpyTtx+hHGlj4E7Z59p4XKcGpviuChTT7?=
 =?us-ascii?Q?eidOkez3cScf7pJyrLPH6OapWbHDKkM6NTuegq2jKHJIL7SbxpNPoRVoSe9w?=
 =?us-ascii?Q?jorSp9vW7HpqSLgc9In+oa7GZZuxLxn5RuwmptixpBmmguWEE3/Bd6xefHyZ?=
 =?us-ascii?Q?TNXmxudKo9Z5pckDx7v8q7ulBW6OheH2Q7RLBjToLgTKmNtw72uWAWm/qzXT?=
 =?us-ascii?Q?I5P6sdc81zy74LSHlTQIydDIGOPLr6obUZz38xiNJnOYyBaHPH3mq0fbSnbT?=
 =?us-ascii?Q?sHk+s/PUhei/FMnTM5cmcj5MdYgzfizci7tMCmGUr1Sdvk2m1B9GjwzYjdHe?=
 =?us-ascii?Q?vUDth4LqdNWG4GhevGKZMufyyx3xApfAuMf1Z7chVIcthm65cfhOxqWkzpyl?=
 =?us-ascii?Q?7hPRmoxfn/5qMiyk/wxW3U9hcboqI2laqk1iaoU3djdY2OaufofpK8TVWL4U?=
 =?us-ascii?Q?dPf84/pRdEW3kblc1A6UbOJ23nFas1qxvQJPU3NT4r/CIITV6gjE67oMS88p?=
 =?us-ascii?Q?hokhq2c4iXtHt6sbngLRSpKPJLZM79lzrtEYYSoM2tYg603/jXmy/kv0kGFe?=
 =?us-ascii?Q?16RlPTJ0LrRGYsYGQwD26rrXuLUA8zkJjCZketkXE7UGex8nIo/K/aTeXme+?=
 =?us-ascii?Q?cwoRmhUNBE+xaUa0S5NLKUS4LacVzOq/u61AjvI0BmxNj3cNDkcMD/GXORIB?=
 =?us-ascii?Q?WjmFVwUX+wivkncHnYeRcuxio3DpehyzzT9dksIe4hAeh8JL4FcPcjGG4Uly?=
 =?us-ascii?Q?rxjMHOIOr04NeBRuFHLx8wIReS7cRKRoJOBPLB7ePza/XOEUEhg21s6hYcZd?=
 =?us-ascii?Q?rgd3y+yjT2C2rYglj6LqvMisJr5C9DRz4VXv9+BYv09yqoGzS80v8J0zAyqN?=
 =?us-ascii?Q?jdMuXHQhsBrJXkjFe21LvgsVUQlMR5lRmYFPpzCQp0SBU/aVbc8CdiCE4iM/?=
 =?us-ascii?Q?qa/1bad+xCGClxilVOp5/Qhpy0J2dPWKyfo5XzCg/Epsu+uDPgJrzmQ2yZX8?=
 =?us-ascii?Q?nG9ikeaUM+c=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7829
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eed35034-7a1c-4acf-b1bd-08dda765e5e6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|82310400026|7416014|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iUytAjNnh1FWuABkgQ2GufBuc1vrqtb038wfZX2wYtX4mXaLmU+sTxm2Gd/R?=
 =?us-ascii?Q?gCKmlpTnZQO2fOoRHY2hgnZQWJINTBylxRjyxE4vqL/bmNo+Sr0qXBCGMfsn?=
 =?us-ascii?Q?e+9s5D46FdfVU5o+8jFRfs+cEJWQfNoraYxit0bSBCOKpRBlvszu1rg0pTMP?=
 =?us-ascii?Q?UyA7H3BKYyyql2qkFtNKOnQUiltRPWx3Og7bbZHPYq1iYZ/hfURm8LE7EqEY?=
 =?us-ascii?Q?1H4EjgAqgxk4acgpMn0pDcVcRsgqGV+QMmI2UyeHXNoKoq+rbwXoJWNpq1yC?=
 =?us-ascii?Q?TYT7MDzI894CZQdzJ4CBPMp0ALVd0tFXJMm8K2xIG4Zc3moNmyXMpG2/R5Xl?=
 =?us-ascii?Q?PZya0g0v8Az5oN9pENkoaImI18HAF7Ea5O38p4GMrmrQwjU7wrp+qDWV8pPy?=
 =?us-ascii?Q?aG/8/CnuquBpHf8K4BFfnAzMiBn+rBY50Xi3ByIxIQNXkQgVAUi8BppDdK2W?=
 =?us-ascii?Q?JaoXGorO4LdjmWmDvZehfVGEr4SRC9Q8IWGmij3De5Nla06mlkolLvzNdBtg?=
 =?us-ascii?Q?syYAHXY6kdqOspeFAardza+0CTf2noTlaqoM0ZjowCK9NniJWwemxprsUzNJ?=
 =?us-ascii?Q?RyvD1fbOO0iXZqZbd7BTIpJbOHyGVmyKDoNEFOZI4ktFi/Yc+iBEki6w486o?=
 =?us-ascii?Q?b/HMXVb0yvrcJTVcKdT+eeRft2wVG4QMEkpH67TFkkTSxPlK9vwe/inIPWWC?=
 =?us-ascii?Q?u2d0MmOLmab12Q8ecZveOjhXnYDuWMsN2AjE/UMXxj/ySCZC+nCcnB9HTDud?=
 =?us-ascii?Q?yTZGcArbzDlIiLe0yWa3qEvqRANvlZIT0NCWFXu/yFnxEGcYH/+QGiBhIyJN?=
 =?us-ascii?Q?5Mr9OGTm/wFzQTY4bmCvcBIBcjBj+mGs+uOiAp1bLloeLSyFkWeHInwAXGiX?=
 =?us-ascii?Q?jtJ2oFJqifTkOelVdjFx0OyAaD4Yva3ODNf0Xa70eQY8s+cJ/EuBLLzASY4q?=
 =?us-ascii?Q?Ybl83ourcTifJX5zFOanlcanlWhSNjIgcKxNFvR/sRDC9x6XDsyBbJzQ+6nx?=
 =?us-ascii?Q?mjrOod8iVCCVY2zx1hYXsnwpUsD0lVHjI8IYs/sHnWCPuavQ2YVCplPzWRcD?=
 =?us-ascii?Q?rLWEDxtzVay4Jxg0kpKjiQ1TtA4HAPIhe+mauxNfwYrFoQjmyMM9wkJOounU?=
 =?us-ascii?Q?C2q8iycfuyKCB7OvivWsAbKsPnzvkFFYbUJ5KE2LcwwoMqEg7D8OTMDAmNwm?=
 =?us-ascii?Q?Ht8fYt+CicvQR6q7HTzq0DOO9it/P7rjh+cufNataCVh6neKMT9TApSoKp+V?=
 =?us-ascii?Q?r7bAxfzLcEQF0Tbp6l/M3ZjyQDgZbXhHUzj7BGgMzt9XGpR5S7gUGm0Hdvui?=
 =?us-ascii?Q?qgBuKgaNi27bD2p5PlXERQu7WmkZ3wG1BBs7fPimhGmxjOZkE6ldnTCAmV0D?=
 =?us-ascii?Q?DpPCaQJqIVGNo4c/mC6BP054edOG0ExS4stHDVqO7kgAIbZlnyw2EQESYLvI?=
 =?us-ascii?Q?XK29orHQthzYDUXTb7iTV9ytu9jlbd38lkSpG0C6xUeBNzoU5eI9HZJFWHgK?=
 =?us-ascii?Q?pZI11qWBGLkWiWBAENl9raG9yo37BzvqkqbA?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(82310400026)(7416014)(376014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:58:41.7053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7719a853-40aa-433c-c015-08dda7661fc3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7613

Hi Leo,

[...]
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -441,7 +441,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
>  		 * store that will be enabled on successful return
>  		 */
>  		if (!handle->size) { /* A, matches D */
> -			event->pending_disable = smp_processor_id();
> +			perf_event_disable_inatomic(handle->event);
>  			perf_output_wakeup(handle);
>  			WRITE_ONCE(rb->aux_nest, 0);
>  			goto err_put;
> @@ -526,7 +526,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>
>  	if (wakeup) {
>  		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
> -			handle->event->pending_disable = smp_processor_id();
> +			perf_event_disable_inatomic(handle->event);
>  		perf_output_wakeup(handle);
>  	}

LGTM.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

--
Sincerely,
Yeoreum Yun
