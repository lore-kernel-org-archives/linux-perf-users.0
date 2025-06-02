Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012037.outbound.protection.outlook.com [52.101.71.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA922A4FC;
	Mon,  2 Jun 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.37
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877230; cv=fail; b=JHMeMsrdEI/kALn9j+aBD+8fE9IdiWoJx3N/5RLlVbjzsIkDgAsGQU+8d7C9aXj9dDLbJhSIMXcwtAPNn0166V9V1/tagqvLFW+U89ElC1pjPSHMV6nGwfqPA1oCftNIZfimzu/2XTO/4pHGuX3xPniFdwi5oa/kJZzFuRXCmWA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877230; c=relaxed/simple;
	bh=K3KVm60p5dRnEC72HVE2LLE8MwS8l1EFpFjfhiqkWzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FrmBA5FeBk2/5UY0mdoD6cFiGtizyzie/g4OUWYveKEtCexKAcppqo3XQEt7L+G9z6jPK3JTaB2gUEyjO17ZvQW5SGTSqCx1bViKPf2QFjsNti/bJxrxwsjsrxOF1k5OOoVLlHwywgrmMOPROdDB+0cNM4aMcuJPmhuZAqP5k4o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VWQzTCT1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VWQzTCT1; arc=fail smtp.client-ip=52.101.71.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VWQzTCT1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VWQzTCT1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wE+d8oWHs0SbrkETSz9ZSP1k82HagxZM+EBMQfPUH4fl163b6L8YQO8X71h6Tng7PchPhS286aIF+aKObRAfIXBgXJ7dsj80TEAGvLY6zaYB/eCxFcXJ8eN/W6mQofVtY9cDBt1SPjO0e/AWsM144sx2lMD2QY9UqmjqK8t4Yc0tLOiySJoc7/vlUQ55rSZh4hOnTXH7YDJRMeMPmbQQjJ/GfU2IGS7qNJYyKiyVhYe6u/MZH/NgBh7hPubCVQ4K4fcIUrHZicCX5KFMiFs1phXfZe+jqiVyZaxHw2t2SNd/QaED4AnlxsfuZflgVCig+9qQNNYqYFHmLUa6NTdXkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voAheTLa9UucCCTWNZilA3jaEZ1e8BfpaVA2fxtXS9E=;
 b=MJxonMZdhLKj40AuX5kK8/f9Symaz8dt6TnTC/I7WTCaQWpk379ccwHmlTzBDJdUkWnKVEPgIwpN0c8GHK1a4BURv9Y2ss9w9WzuTx/GLg64e57zvgS4RjCDC8Ez9AV24rwdnEQFdfV+XOGtVdp6Vy9xTxHaoyt+RzxAkMmc6na754uaSywr+Oj99Yn+5cd1IgtpJ3Yxax+nvVq5G+A4KMlSbOxMzLoxVD52fZGclO3rDwFltcLckGcKbdGjnQ6rEETC5mIyM+RM2rc7roCmjAGNBP2bU4rOnDc5NGABlzYy2OjLMTA7VcdUKKd2QHh30cmXZI8Kb+CfSru442WBiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=163.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voAheTLa9UucCCTWNZilA3jaEZ1e8BfpaVA2fxtXS9E=;
 b=VWQzTCT1X4f6HrR8Xqg3xDLD6RqHMk4vxMdAcUKJK5+ZA77bB/ZLu5zW51uWGDs22jh/qfvFClknAszE3xCn9TLUagsu21KAHtm60R3sV/IxB4mL2zP7wcEvHCI9U0ZawSW4nARobgqB0KRL2gl+n/arHs0gnnUN8cdLy3Y4dBw=
Received: from AS4P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::10)
 by PAVPR08MB8896.eurprd08.prod.outlook.com (2603:10a6:102:324::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 15:13:45 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::a2) by AS4P191CA0027.outlook.office365.com
 (2603:10a6:20b:5d9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.31 via Frontend Transport; Mon,
 2 Jun 2025 15:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Mon, 2 Jun 2025 15:13:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTQLK94+Qt8Oxz6D9XRfTnYqeoAl/nssV+xkJ6lKbwmAqKPoR5KgYSgTwrM6s4aHLohllYN/17QTiq+2dK7Y7BZ1Vt1JvYloUEbE3cdxfuUe+NFaIGSupLS10CL5uTeuSGPZOy7L4FR7GAUDSX7wC8c7URMz8Z6ZIEE3BNdXz4qp7Nt6KoMqePoUWzfscRtqvZ6yIwwOiof1Dx8hdDB4qvgy+VEE+ryMxhc/Mq6s30j0BNlQF1BFS9JfL11D+EkGLR41tnhrrWenXM9p1Z8xqELZ//u/U0+N3eDeU6tornnJWeuplvNRzxQJnRqRxcsehuz0oLg9rhiktR3av1z9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voAheTLa9UucCCTWNZilA3jaEZ1e8BfpaVA2fxtXS9E=;
 b=O1+lrkPjXVcVAdnG4+g1ftFUbICuWEBv2GAoQcrzY7eiqQaWUZWa39HTAEsCKgcd+FW9/h6Cpgy6CyNgJVjuG6XoDXnCLwVofyZr/0Ds4yDSKiyhcqLTJ+kqf6xUjITIdPQpHI0/S5WXbhC9DWoSNhP7n24CQlGV64R9jdEB1p/nhhfKw03Vg1PWakxTWIEFdJ+ZJ41eWO8YF3me0pXhhIDt2rhIICJ+bYVqBBiY2piwwyrRCMZ8gb+xX9jNvNmBOe/yzggLpa++fmkC6jdsZa9p5Pflnj3jA4zEPYHBIpMGvQkrz4JmUTpIGinQtFJCzjuacZqhmtelm4c91aaMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voAheTLa9UucCCTWNZilA3jaEZ1e8BfpaVA2fxtXS9E=;
 b=VWQzTCT1X4f6HrR8Xqg3xDLD6RqHMk4vxMdAcUKJK5+ZA77bB/ZLu5zW51uWGDs22jh/qfvFClknAszE3xCn9TLUagsu21KAHtm60R3sV/IxB4mL2zP7wcEvHCI9U0ZawSW4nARobgqB0KRL2gl+n/arHs0gnnUN8cdLy3Y4dBw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PAXPR08MB6334.eurprd08.prod.outlook.com
 (2603:10a6:102:dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 15:13:13 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Mon, 2 Jun 2025
 15:13:13 +0000
Date: Mon, 2 Jun 2025 16:13:10 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: 1f4a84e5.32ca.19730d781aa.Coremail.00107082@163.com
Cc: 00107082@163.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mingo@kernel.org,
	leo.yan@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG][6.15][perf] Kernel panic not syncing: Fatal exception in
 interrupt
Message-ID: <aD2/hoB+KhLITSu3@e129823.arm.com>
References: <aD2TspKH/7yvfYoO@e129823.arm.com>
 <aD2kz52p5NHpuXk3@e129823.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD2kz52p5NHpuXk3@e129823.arm.com>
X-ClientProxiedBy: LO4P123CA0325.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PAXPR08MB6334:EE_|AMS1EPF0000004D:EE_|PAVPR08MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8c78e2-5acd-4620-0827-08dda1e8117e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?4trCpSaCZ7aClw2Lrhe5WQ7Ajbf+0WxADmAp4EDxzv5nh0D1zbGFVMUdtVsK?=
 =?us-ascii?Q?seHC8ElmU9oDbGQI/NedCStMmPg2f+KfRQcT6vBeGXymZI/fqJ2WMBaW3anv?=
 =?us-ascii?Q?faiJgrhxkI42c/KPnHdnBGpDfQkUzfYBMb8yNGhSOftxoyoDo9cYI5rDd+mI?=
 =?us-ascii?Q?u3J9v4FyPM84feQTqde5zbm2ygDdqGqO8lrYIwyJCRp8A4YwepEVPDlJUQ1P?=
 =?us-ascii?Q?jyMyHAyPQ6Ec1WBS3FcnXpbbXSqc7Ez6z3LyXT6E4YKqCDEbN/y8ABG3PDGI?=
 =?us-ascii?Q?h636s+4W+KmXDOFTrJPhKGjrQziwqZDUnLAGr41yN7zgxqm52jEn1XriqjFj?=
 =?us-ascii?Q?UVAwgvDwHI5t9Vo9Z/9WfwJ1YkLsC4Sm7V8MekGio+b6wD2lxSPqH0uZKYad?=
 =?us-ascii?Q?AqsoZ7NIdRV8IduBpKMRxPrabV6XIbXdfLrDZ11Vz4sFkAAxGrBE9ntNk9ke?=
 =?us-ascii?Q?oNkiLwS+1rpL1hJVvJ1WOD1EZaaVNFtbRtQp45M7b1eh4SJ3SoJhJ0cUpZJB?=
 =?us-ascii?Q?cgcZKidBTlNXFw4D0xcja/S+TFS4tpzhXaMzvjOKBzuM6bGFPEBARahofJan?=
 =?us-ascii?Q?AxPMPJqwnQhh/3PXiddrDYSD0XiyPCJ5OtOzUYprLS3cyCS2E22xAfk6bA9x?=
 =?us-ascii?Q?lX5O0AanGbhzvQDxYS6MB7U01OhOzJ3BuxH5RAsC5V8Uuyy4R7Lr6ncxlxDy?=
 =?us-ascii?Q?UppQ7CLSqNYl7wUkd1tyiIIW2YyIOU4YXU9MtNSzJmr+wIwGFYTaU19wRzlc?=
 =?us-ascii?Q?jCugB8UHQbgVNlw7wqzyvgsqPcL5Xr/ze6gaOyA9BLizWovIAWSwlPfJRWIE?=
 =?us-ascii?Q?z6mX/ldPIdMVkZJsM9/JztX209EJjzcKTLRNkOXZFDUsO3vGjDKsroPoZil1?=
 =?us-ascii?Q?VVRxk1W2qnRmIH/AV4S20Kk8sqZ40BjUcC9TXg1eozVFNY0k/3sEmoX8eUPo?=
 =?us-ascii?Q?5kat3nCRfysq2iUmY1hFX+p95S8QPTVkC1ZfbmeeeTXExpFK8BTS3tb0e0SC?=
 =?us-ascii?Q?1pwrapGEnDGpgl7yA0bpcCSaTDGAlQsTuUbS1aUAH7wuRIvuec/iHFz6lS4Z?=
 =?us-ascii?Q?e2qKZtg/1rxsvqYh36QsqWb6IKe2uI67AkaNOixRgQqwYAQLmyklvfJJl8EW?=
 =?us-ascii?Q?dNX6/mMgA7bwCAqflNWFKmfJfzhy+zjub5WNnoVcg0lsY8lpnjN89/rvYbKK?=
 =?us-ascii?Q?LDPqUX/PRbePV42tVdMi/CTVWL8/WtQ28+dtHoaH67VBDGIIPyjp4o/uZCfU?=
 =?us-ascii?Q?qgJAa9/2p12/AjOVarM0CFgfnnNiB+++EGsttDKdInfiAN16/CSwYaQBE+U5?=
 =?us-ascii?Q?zH3qFNW3oVNsabt/FN+1JlD9NS3joLrhn3klMmpLYX722CJLqAckOaIBg/79?=
 =?us-ascii?Q?KZXvI1q/rtjbI4RAoCma8/7e60/8yUFmveZtlNjQZXIR5Lc+7WxfU5MOmjlf?=
 =?us-ascii?Q?zIgwXjqZPiU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6334
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	068def58-aef9-4a22-21cd-08dda1e7fe48
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|14060799003|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70sWmEf74ZSpOZWLp7oW70h1e1PPpEz8/gtBScUCYkkEPQFKjNKY0iwvhy+D?=
 =?us-ascii?Q?So+yUeneFwrZWaSnJQcLHQ1unKd7vnGuGAr2BpVnyUr+qzHLmlmeTvQkta5U?=
 =?us-ascii?Q?vNbX85e1zlNfft8X4vd/4STxRF1SLBi1kf2DrYEyY+nfDln0BseAW5qwAFGU?=
 =?us-ascii?Q?7wt6mSQEeKgwnhBS14zT8KYD3XEB+jGY3QGtBCRxVtsd3bm7quxNlQNNXqxk?=
 =?us-ascii?Q?ijIW3eUmdoQpPFMoaw8Zq+sT8UiSXyQZmJPs7eo+WMxtE0Wh/w82RgtDgPLH?=
 =?us-ascii?Q?ZHZx7t2wyMb+BDnEwF/h9fslooF/HPcjKIsz/Z8WSJE+I4T0xOU2mUkJxbqL?=
 =?us-ascii?Q?8r0PN286yUf9HzSP5bziN91wGX6YpyXNhxBAjovnCAfasYWp6PGs7e4phH+u?=
 =?us-ascii?Q?0i0TzVDjGIENdpsQ2kEjKVfWGI5nFjsA8ZOwHsdsMBUitC+poUMN68uhVZtS?=
 =?us-ascii?Q?NaoSBEcBKdRGDZgMq5t1x4sfWaOxG9SAgfqBy1qbpCIwS4ywoUslHA5Oa+Xj?=
 =?us-ascii?Q?QQUiYTQRUz3P+d2QQO1V0HfXbmY36erKjzF9WFLF44/bA8ts5a9l1ecYKLbz?=
 =?us-ascii?Q?jPEKs/Q/M9Pv22ixZ7E++DwKKBFKphOMu/Lw7JZdO7TcGz+3ROGJY5SxO4jQ?=
 =?us-ascii?Q?cglWL5Ua5l9H9hK62Tfuhs1EVe9j3X8NtWJdrnXDBCP92SyALlV2vclpMSzX?=
 =?us-ascii?Q?O8UMyhpFHCE3KSifJbtB2c7aS0ORq8v1IGiXEDCe2E+rOiCTQdCvn1pmsCa6?=
 =?us-ascii?Q?xWBWvqg/0VqgCxzso04sJeWb2lHatazEB/1K+r5fi08ZJ0UbtXyh/WJ7dcZ9?=
 =?us-ascii?Q?baUsSU6DPTVdrTfUWUgXP0XP/x93WdFBcL2GrT1X1JYQ8FS5zc4r+zUh2hvf?=
 =?us-ascii?Q?bfY80TKEl9/Z4y5G4ztsOWecyugrwKLd4coRw3hxVYzjTMr1flYnTqAEaU0F?=
 =?us-ascii?Q?jdXXLtMn7+rCi8I/qNhVUpiXt6oWn2CpJSWEAg058epsrLygO6DCIYdxc5qD?=
 =?us-ascii?Q?eb7ODCgnWofT5W9jAx2YQU+0yvmMZrTs3CVQEixixmZm+lWjFyDiRASTnT80?=
 =?us-ascii?Q?m/d0jSOp/31Bgw5Jl8K6ioZ8p+ncZNQqvmmo1xx+OPRwQFRjc1fUtqfuUSs7?=
 =?us-ascii?Q?HI66ep01+oZBJuPdT/30qt9+iis/TAyR0gf6R2nHO27l2JuPs38W+vaz8Up2?=
 =?us-ascii?Q?cC8XmMlfsaCSBkddYMlO5xDAhKKyEiNYz4X0SzQnVgHDtnCmLOp/tmR8ebW8?=
 =?us-ascii?Q?gcH55Wg1ieBMGI3EchCrWhLNfBOIwuMbOcHXviAFt6wNbJYl9x/mklvrYaR3?=
 =?us-ascii?Q?iw3E+Vi5ev0sNkEj+NjTK4lVZdNeuq1aTrPyoEKcqm/Hnjovr+xfbecNyHud?=
 =?us-ascii?Q?hei4FD7kiiIf7+QqqTXLMCdHJF3CRTYOHzKE0rAU5zjawAZ88gFaEqJkhRo3?=
 =?us-ascii?Q?RwUFwaFh22HsuPO1cA1Fv7pqZervA7alZ9nArCGgKgaFgJ7AGWgjQYXNn5/2?=
 =?us-ascii?Q?gOcrMzAIBywfw2zQMFHip6F9DTAbrF/LoNZj?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(14060799003)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 15:13:45.3572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8c78e2-5acd-4620-0827-08dda1e8117e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8896

Hi David,

> > > Before I start testing, I feel concerned about following chain:
> > >
> > > ./kernel/fork.c:
> > > bad_fork_cleanup_perf:
> > >     perf_event_free_task()
> > >         perf_free_event()
> > >             list_del_event()
> > >
> > > This patch seems changes the behavior in this callchain.
> > > Would this have other side-effect?
> >
> > What behavior is changed you're worry about?
> > both error patch is handled by __perf_remove_from_context(),
> > There wouldn't be no problem since this patch just move the
> > time of disabling cgroup before changing event state.
> >
> > also, the cgroup event is for only cpuctx not added in taskctx.
> > So, there's no effect for event attached in taskctx.
> >
> > Thanks.
>
> Am I reading it wrong?
> The call chain I mentioned above dose not walk through __perf_remove_from_context,
> It is a fail path in fork, which happens rarely, but still possible. I guess...

Since commit 90661365021a
("perf Unify perf_event_free_task() / perf_evenet_exit_task_context()")

perf_event_free_task() is integrated with perf_event_exit_task_context()
So, it calls __perf_remove_from_context().

In v6.15, I think you can test with below change only:
@@ -2471,6 +2459,16 @@ __perf_remove_from_context(struct perf_event *event,

        ctx_time_update(cpuctx, ctx);

+       /*
+        * If event was in error state, then keep it
+        * that way, otherwise bogus counts will be
+        * returned on read(). The only way to get out
+        * of error state is by explicit re-enabling
+        * of the event
+        */
+       if (event->state > PERF_EVENT_STATE_OFF)
+               perf_cgroup_event_disable(event, ctx);
+
        /*
         * Ensure event_sched_out() switches to OFF, at the very least
         * this avoids raising perf_pending_task() at this time.

not with modification with "list_del_event()".

Thanks
--
Sincerely,
Yeoreum Yun
