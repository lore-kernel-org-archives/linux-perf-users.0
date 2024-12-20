Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4033218AB8;
	Fri, 20 Dec 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708432; cv=fail; b=WQ6QOP0XbFs2DGVLL6CVdHZ9drEXbIx8hppT/XdDpL/1k8iPaqtnhWyrUr38vXk6owEXqwma4lIRJuGWTvGoesWvzvsge9JX2cBHpaRlsweFySvNpsbz1Q327Mjav1Mx/deycD9INxQuqA/uc8KQjfG567gr5QUQBi4N20RF6D8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708432; c=relaxed/simple;
	bh=BWh85bpyw3MSIqokM+WtSqTuPXQfLZH9FWiQ4OPWzhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qr1DoKXViRUgcMnvBSgTzlXjxTnpSujDZw7aLe0B54BDyKfnETP/Z9dhZtKKA3MabuZQ7bNYxy9fDegEhEL9s3PWtZBsqvufLHGNVe7EZEhODHgIyfJXvjTgvXfWLBqhOG1sy/+gfO3oG7xCn8UhvN7auGuZ+i71UP2/AMx1mrg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=opmEqSPk; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=opmEqSPk; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="opmEqSPk";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="opmEqSPk"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vK6T/kRbJ3yCOH9dWYSvWkjGSgXfhVpnLT7MARkbI37WhtSh7iTcwLJsxf68w416wd0K3afY62KxdwUlVmZnPii99JFcCXe85gwPnkpVqgB7ieQnp8xTmIXuVUfg/RvjVTrizRnWBtgPRAeuzImphZkdxnWLEoLA83J7Sl3OMswPPvXv5jOemw8bDGI4Qc9pkx6LVjd3t6Mu5tqM+caagisF4JJYoNy+6qfK259I2r4DUttGTcufAfTt9DOYa7Vbjwjx61IB/nEqEgicwPu8yJ4rLg/weGDEEsIHtZC/QAM14X+KrmOpzg8QMsnz/mEx2EWVKxXD21dFYIavNXSd3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK6WxBY+58CZFiKVTYE2rX5FaWDTqtM2kRMqBrLKgT8=;
 b=tGNzm7cVcgU1Oor/mPhZHFu9Kdo3nuynY+x47K0QArX9VzkKPfZ9NyIjVPXchcBXE4+9ywOn51+hGN7Yvw1QEj9WUwUboqrMcackxRyz0dKmkhfedU3TJz1T996gAeQRo7R59ne4x7z39s2PAmjDmaNzFHZUBnKY+GmKuRaaidtCEScTCmCV89M6jeM8Rjq05m+B8xt02Hx8cD1QakCMbn6LoRfNoe/HI55O8grtHdGgXGkOZ2CgJUR55+Z0+Rb635bsE+3ZSjUM04iQ0skW3KKJa/pZOXMvFG5IScWfYmqTnzlXaqSxttcc0Rj1bs4v2PQKAdG0VJQFRkDfYtfNvQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK6WxBY+58CZFiKVTYE2rX5FaWDTqtM2kRMqBrLKgT8=;
 b=opmEqSPk3Ex4de6xHFgAfKJnKXj7V6/5+Br4up+Lj+g6zn6R5WoAkD1zmq0ekCbyTlhNqphh1LEKIrvLD1vYlfAYEyrF9kQmF/ODcfS49X5+pfDtW2BMF7vXNWqBDwh72GNMfrBEvv8Hqix5dDErOz9HSDFBpp6o/hWJ9CXTiY0=
Received: from AS4P189CA0053.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::17)
 by AS2PR08MB8998.eurprd08.prod.outlook.com (2603:10a6:20b:5fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 15:27:01 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::aa) by AS4P189CA0053.outlook.office365.com
 (2603:10a6:20b:659::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Fri,
 20 Dec 2024 15:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 15:27:01 +0000
Received: ("Tessian outbound 867970499bdc:v528"); Fri, 20 Dec 2024 15:27:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6a32b1aebb4a9569
X-TessianGatewayMetadata: hZaNc3/CM0eYoumaFx6Mv5v028FsoB6NAEVMG2Wf9OdmfQjhcW7s6m8X/MjMR4gRrujQhzDzGjKlbofau0SbQOfF5cjBjKvZ954i0qXmBhcjwPEe4KKa0Ze5M2HFwQ8qUDBYzlLLw52nUJDNrF0FMQ==
X-CR-MTA-TID: 64aa7808
Received: from L0b9ede1c8882.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6C242304-31B6-491E-83EC-180B9584D6CB.1;
	Fri, 20 Dec 2024 15:26:54 +0000
Received: from AM0PR83CU005.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L0b9ede1c8882.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 15:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BV26wW7kO9QQHa6h1hy1jMQ9X/Mwtt7mTR2467ZUpDGwk/ejExZDfoDevL/7XB+P/fn2Y4YCNOyYdH/lVjsjwYGstJu3osCV6/iMD6PfGyGTX6ubL4OUIQcePRxxCAC3c6l+NrSHJ8lc6zmfFBxrIqXXR5QBvJPg39JgeeOPMUKR+anXDxEf3LO7U4d0fDGj6LzN5e+EvkXxj8dQExWqpy2RhWn8g9M8Ngs5MOI3zSEm5z+sej/9jHYfaOdSSoEwvJ4dWtbCeMA2wKviwwlijvBE49QrzIQZLd9p0B5hNjquRjzWQNrQIhux25a9tlqPud4fO6nfKFA5Hbt2nK8hwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK6WxBY+58CZFiKVTYE2rX5FaWDTqtM2kRMqBrLKgT8=;
 b=ByQVH/lvtyPIXWNPhr7nnmPenyyAmcZNQ/6kfkXj2jFm1LbEVibZUA0OMfhVRBRlXzoZ+R0Z6s7AgeuDYkJbVT7MiaMGgHT8hW5nNUHCumKcSqVOgkwsW9c+u4IcmCA96WmVds/0563C5cICKmlWLgPM9WLbbE9rzx+efv5QjKKz6caaD+b+/WB0gY6avIGf+QM+6TzVZvoR/3jX3xM9zuW0Z9ds0V8ZahfzxA28QGsVb6AUZJKc/dbZ6Fy0vDGyP3Aw4PAwJ+qpfYicyYtjpKYhkN6mMOSk3Qh4H1wXpksL8/zLFwwlgWDrhD/2wgF0U1wYiYC1JmU5HbxdPPR0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK6WxBY+58CZFiKVTYE2rX5FaWDTqtM2kRMqBrLKgT8=;
 b=opmEqSPk3Ex4de6xHFgAfKJnKXj7V6/5+Br4up+Lj+g6zn6R5WoAkD1zmq0ekCbyTlhNqphh1LEKIrvLD1vYlfAYEyrF9kQmF/ODcfS49X5+pfDtW2BMF7vXNWqBDwh72GNMfrBEvv8Hqix5dDErOz9HSDFBpp6o/hWJ9CXTiY0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GVXPR08MB7703.eurprd08.prod.outlook.com
 (2603:10a6:150:6b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 15:26:45 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 15:26:45 +0000
Date: Fri, 20 Dec 2024 15:26:42 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <Z2WMsnbFmqpEV5Pu@e129823.arm.com>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
 <20241220151414.GO11133@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220151414.GO11133@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO4P123CA0595.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::12) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GVXPR08MB7703:EE_|AMS0EPF0000019F:EE_|AS2PR08MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 7602a362-1989-4bdd-0ee8-08dd210ac041
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?SbvH8DqPuYLilTTyRVtBneJXeMimnyd1sQHARCiiGJF0mnIYdZnWZ7HjEK6A?=
 =?us-ascii?Q?wPcwSnF/u0PVA2mLy5xuGcKON6EGNyoE8QOfnUsMeAmPZSA6ZGbxPLUC+Mfz?=
 =?us-ascii?Q?8H9atMj74dW+fhG2ZogrX5iujCpFv7wgQiWBCFA/XT3h7pCP6I51jN56Ekmz?=
 =?us-ascii?Q?QBdLuk/DU1fe1T+anUAc8gTCPgVueeMj+Gn9oYSn9B1SgH884U25ELTihCJ+?=
 =?us-ascii?Q?tWucgh3K8GRzzMLxr4hiqLJzCLdDiGzxiB855lFMgm4qRzkgm3BOx4ublPLy?=
 =?us-ascii?Q?lQSrZNy9Ke82xE56/prcUG5O6k6Zu+aTQK/U9vxR0bFvOFwiGh8FmsMxxEu6?=
 =?us-ascii?Q?BaxirRQ21isK9elHnlXPNoMREUZDPt45czS9hlOq7U8/lGirtujF6gSP7JCu?=
 =?us-ascii?Q?6uzH+trOvOY059JLE5T6DnBReETmvF4dAk+/u0bk17x0dVSY9/ergEfQ5CD9?=
 =?us-ascii?Q?TB52jakPPW3gwA1ylUaApD6YlHl1srNGvI+2t1VvezULMhAqSXuE9AYdvugY?=
 =?us-ascii?Q?fFuB2kuh6SEN9a98reVb5MaggETdTuD4zyVXF3aT1QXLY4h2C/IBMdn1h3dT?=
 =?us-ascii?Q?2j6GlRNZBplHXnYHiAHdOfTqmQFjTXh5jPbqnDPLmgfVgF8ZrGOdn6nBDXSO?=
 =?us-ascii?Q?wMV6Cn37ZRjZ1MXKYJIf1gkVTx5rmbCP9WlAusc21RpUUqRxJz81p3H7hAwl?=
 =?us-ascii?Q?a6MXhyLy9ngg64xtWojrjt30Wnkd5PQZwGK5ZDCahyhZ7PsHznknTPQORrpu?=
 =?us-ascii?Q?8dv18JAZNuRTZ7iImFPcj9Q5C1totEsos1EX4rIjmeocRbv3GMWTzmxwY1cM?=
 =?us-ascii?Q?wRrdG79LQz1DEAX0capfbe8iJXgWU2Y+eYG4q518yKtLlY/u5QZotyl4PdSo?=
 =?us-ascii?Q?jDQRKfm2Y/yXx/WJ0eylYmdwf2Poph15IaN+INYzBqqko84Na/paj5Tev+f9?=
 =?us-ascii?Q?Bf67rSOwmgb9iFpibEoNHRDceBaFi/17a7Ql+MByRossZa6EOcsfRMG6/IV9?=
 =?us-ascii?Q?4wPeJxetIQ5In4vYwmhLL5cjNb31gmuD0pR/EDxNYH64tLXkRDe/qXh75G0j?=
 =?us-ascii?Q?R50BrC6b5PJl1c+8O4uBVh+eEus1YXl9Wu2FC9olkqL6fBw1WfG3d5y9dYXE?=
 =?us-ascii?Q?mgmX996Sbb48esstHPP0wL/VmgpCTA4dHLUUC/e7IGOFKMxPCrWscXqVm60q?=
 =?us-ascii?Q?EkB54UhBnY64Md2fthbAalMwwDUaizjI6WmfXg9T6aMk56uGgoKhLpS0ICY3?=
 =?us-ascii?Q?QyeTPYB0C5lA9Foa3sVWxxP/d0S0T7Z5TkLyDBLEYeuiGAS+73hoHFTMCvXU?=
 =?us-ascii?Q?4+DqLot7CEDklTJor6VEn/Lvnhx4rNf0Tof5ti77PP6huTIT+4ggbs2cPE+u?=
 =?us-ascii?Q?SIN2yFQapzPefn4DiEI39l7AqAo1?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7703
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8d887269-e5af-459e-09c3-08dd210ab662
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|36860700013|376014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/0T93QSotuzRMd5esZGyyukg6Sf8ancVxNfm/a4IiMUwsDmiVBIw99cKMH/0?=
 =?us-ascii?Q?J0F1zZuno5gC9CjDdHLyHSO60HJEHmcTfLLLt3jdIKo6TTr2HKVpo/skWXuY?=
 =?us-ascii?Q?WQhyeHBi/BETVJXoo7kd5tY3HYqU2XuqalOn6OpsY6LVaHobCTUE53hzQIjz?=
 =?us-ascii?Q?2ipi2SzQHAJIbRiVvxFNX61ILGdx155AyRPjmxeACgl5vDRYHtd7OGqf/bIs?=
 =?us-ascii?Q?YxphlqLo9u1Wpo89zvapzw7NRz02+dSesexXilav8wVYANwxTmBNN38y1lAX?=
 =?us-ascii?Q?+bCIgY4wI69kO4c1GbfCUppPbfctqfvD3p2TAOEbUGtmfzhI9oU63hP0JxoV?=
 =?us-ascii?Q?BWhUPbRQI0xBYbGyMn7UQ/5hsE9dIMAMCV3lHB63x5eq37aIlnrVFL+rTaDf?=
 =?us-ascii?Q?7b3sRlw1BjT2RGih2piygj5Ph3kjuu7vmzm2PhWr0bhVNMynx/0e2zn2ZwsW?=
 =?us-ascii?Q?2PGM+eiWWtmvHHBUPcJc3UDydRVhvLl+jfRHDhgcDeGKaV+evInGUlZ7Z/rD?=
 =?us-ascii?Q?Fh7N5+XvAKGE+p3EdwfbZWk+K7TxY0Mn8LNugdDJA4Cnbsi8whj6GkjWu7fv?=
 =?us-ascii?Q?GKdxbheX4UvdR9bMFhnifavXNUMJNazWgl15kE5A32VrvzfHWkG8IKfD2Bgi?=
 =?us-ascii?Q?VR/cTsAOL87fGbHqXy9bP7VjPuHhb72VoEXLbyFQAzSFMmgyGIzzeGzodIPd?=
 =?us-ascii?Q?NlyBs+/JLXnQMLBe9Ta+nXYoeE3ylRnHzCul0kkgoQuHNLYUF6+cCVbxXR9t?=
 =?us-ascii?Q?GGge47fnDCsRoQ3X3Fxjc4RXbbx0Iucn2d+fD6+PYOLZzsTU783wInFq8lHW?=
 =?us-ascii?Q?F+ztbbsfGMMkwkKLenNdZtN8Uv5HJVzdBomnGuQdUBEly8sDCDZVuVpuLTkH?=
 =?us-ascii?Q?lup7TLCmzQJ+/mmp3FS/45GgjbcLl08aqneQzxgX7ABweKvFIDPbRb+CouFN?=
 =?us-ascii?Q?SMr96FeJAI/L15cSBYAYGpyGGzDo6DML25kUMEwcAgXxBxSRimObTMaw7COU?=
 =?us-ascii?Q?iGjPmRl6GQauq2VZX7WrpPI793RSHPkiz95cLTsKT7Y4FvsYBNIYg7CJ59ur?=
 =?us-ascii?Q?0ChOpMtx0JY3S1ONK091JJsd3rPYE6+p6mrxSWFCjP26P2QkOHZ7Tqu7Y/BU?=
 =?us-ascii?Q?DlbRADJDyg1zMWymCPT7thkpNxOTCagkDqo2GNFJzE4pskjTNpDxgo/5FPOq?=
 =?us-ascii?Q?PTkwAeub1djPlRKqFAmRorVkVFJuvTFkmgLsiJJcHLmaR25UtJamNcisw+xe?=
 =?us-ascii?Q?d3pxib56uIjAaG9E1lgzRYAeGeI+iw8juZMO8oRVnumcU7LnhproplC1kdCy?=
 =?us-ascii?Q?CMzQLS0ezjJeki3AZpcirUZBRFP4YvNhjCnycN7e5jxzbXYfmkha5EQstb79?=
 =?us-ascii?Q?M6wNvArXX8ti9dxxj1N1zyGe0DPog2EOQ4iaKfwg0bX92ksif/gZH31BSBvd?=
 =?us-ascii?Q?d7fwBvYrS2l+tj7sJHUBNTYdAhlRArmUmt9p8VGZGzGJp2cq/yjt84U374eq?=
 =?us-ascii?Q?Zj/XcRMrvWVjt+8=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(36860700013)(376014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:27:01.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7602a362-1989-4bdd-0ee8-08dd210ac041
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8998

Hi Peter,

> > > This doesn't make sense; e1 should never reach event_sched_in() and it
> > > should already be INACTIVE.
> > >
> > > Notable events are created INACTIVE when !attr->disabled.
> >
> > But in perf stat code, it via enable_counter(), so it's set with
> > INACTIVE.
>
> your text above references ctx_sched_in(), what you're now saying is
> __perf_event_enable(); *that* will indeed set INACTIVE, but it will then
> also fail event_filter_match() and never even reschedule.
>
> > > Also, scheduling should not get beyond merge_sched_in()'s
> > > event_filter_match(), which will find the CPU is a mismatch and stop
> > > right there.
> > >
> > > This also means the event (e1) does not get to go on flexible_active
> > > (see below).
> >
> > No, when perf stat command with above, the cpu sets as == -1,
> > So, It doesn't filter out in event_filter_match(). so it enter into
> > merge_sched_in() and get into event_sched_in().
>
> Hurmph, I thought the hybrid stuff used to set CPU.
>
> Let me try and remember how the hybrid stuff works again. Ah
> pmu::filter(), that's called in visit_groups_merge() and should stop
> right there if the PMU doesn't work on that CPU.
>
> Is your hybrid PMu not set up right?

Oh, I miss it for filter. Thanks correct this.
But this is not related to this error.
The error occurs at "task exit" -- failured to account last enable time
for inactive event at exit.

> > > > To address this, update total_enable_time in event_sched_out() when event state
> > > > is PERF_EVENT_STATE_INACTIVE.
> > >
> > > This is a giant jump that I'm not following. Notably ctx_sched_out()
> > > will only iterate pmu_ctx->{pinned,flexible}_active and that list should
> > > only include ACTIVE events.
> > > So how does handling INACTIVE in event_sched_out() even begin to help?
> >
> > the answer is in the perf_event_exit_event()'s
> > perf_remove_from_context(). in here
> > event_sched_out() is called via __perf_remove_from_context()
> > So above case, the enable time is fixed in here.
>
> OK, how's this then?
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 065f9188b44a..d12b402f9751 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2422,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
>  {
>  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
>  	unsigned long flags = (unsigned long)info;
> +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
>
>  	ctx_time_update(cpuctx, ctx);
>
> @@ -2438,7 +2439,9 @@ __perf_remove_from_context(struct perf_event *event,
>  		perf_child_detach(event);
>  	list_del_event(event, ctx);
>  	if (flags & DETACH_DEAD)
> -		event->state = PERF_EVENT_STATE_DEAD;
> +		state = PERF_EVENT_STATE_DEAD;
> +
> +	perf_event_set_state(event, state);
>

It works. but what about this?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..71ed8f847b04 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2432,6 +2432,7 @@ __perf_remove_from_context(struct perf_event *event,
        if (flags & DETACH_DEAD)
                event->pending_disable = 1;
        event_sched_out(event, ctx);
+       perf_event_update_time(event);
        if (flags & DETACH_GROUP)
                perf_group_detach(event);
        if (flags & DETACH_CHILD)

Thanks

