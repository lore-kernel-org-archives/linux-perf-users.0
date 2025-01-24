Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF553C00;
	Fri, 24 Jan 2025 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737682011; cv=fail; b=cyovKwz4Daqvb3skKgsuGYopO15iQtg2sPo0bkFRyxvUmocXJCLcB7TAXeEEt1lekMFLDwYS1o6atIDm6ke2L0ecIlVJzkRkxOMN2DuYeLZFkEbHU7JfkvQFX5a7MVfmX6VzxYa3JC6wwwOpZY6TbWxIikM593U2NZH0KL0c4yk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737682011; c=relaxed/simple;
	bh=SoDZo9GYUx5WxzDpY/NpK8kvC9uqw2VHFsYVg/aCF8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EVKnQQiKNWcrxI1Wjtf9tWe2X8eaQxA1u0u4MI+goaeDiO6fmq6tC6F6sdZLjlIF5b+loeniI8F15UwYIVb3iYbwK/L71fV5o/t/pb4nTI3veVIYeyhpjhZUpImGWqBYoEP+8ARBjWA7T544vdgmvyuE0tn0EG1SzgkwyinzScY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l7PCmDpQ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l7PCmDpQ; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l7PCmDpQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l7PCmDpQ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HaHrwjaUwzYZRFz3eER9/Av1MgUc9Tt53na12ICZTk/zHEO/W2eNVsoSELEZ5LG1OxUCGMTsHj5n5LbZgcJLfy9DzLvQL3k1Y9Fob4y88B44fxyaNlr4DZNQoLqtrS6vbbA7gXpbMDqDuvhgmjR+e5025ifr9GgWrxoPyceE9BpjJcV40LKbzvG+vtbc5hU03e2TuYH8WGJtkUh+AbCD+1sWSDpdWd4WDmQVqhxK7Mt0YFAkIFXd9Y98IETXN4ygyCflpMf8eLV59unXkQEIS+8CmNiRNWcpyknlQBIjqNDq7Y42jVhpVJT6A6hoXEQpHlo52JiLlKeyJ4oE4IOuLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNVmYBShqSjMNIV2McitAQFOe8DLSoDqrKrcwxftYtA=;
 b=NVxmwc/c9leGGN/mbHgeM9VkbShFaM0FKDzC9x8QHq30747jS/za0/TpeMphWLhaLaSsAGhK0lKyZc3OWcuPND6wza2+7mD5O6JJR+hFo0iepd8GSchP7dkRLENSaY34Y57uG9XIQDTM4YYhBUaLSEWnb5+9gcLycAeSxlt3zESzhc629dGAa58GabP2cZXT/xhoOhmc7B9R3O+3VbozRHHHHmQe9QfNJ4E45nZx/f9yUFob2Krk+Sdpk2xJTziGeBcv1ByM5mx79qvip6j4gsvjyIzvu3PUvLHFQRicK0sHmaJ1XNGP6sMaO9j/oSzxMS/QSZfo6TYhEOl/EAKBzQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNVmYBShqSjMNIV2McitAQFOe8DLSoDqrKrcwxftYtA=;
 b=l7PCmDpQUOfXxzQ9SmBl8R3OJTFNUQmKApr+CMJ+aQijCuSuBBvePVeZ84/6ptlT/oMepcr0Cr/mr9Flm1q/EM9hky2VKDoVvYhjxh9w3L5WcQwCFvu9yTx28h4wtAC9ebpsoL6qBf5qfBKOOT1BClhWxIx5QoR9M3rnkj1ox6M=
Received: from DB3PR06CA0001.eurprd06.prod.outlook.com (2603:10a6:8:1::14) by
 PAXPR08MB7490.eurprd08.prod.outlook.com (2603:10a6:102:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 01:26:42 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::da) by DB3PR06CA0001.outlook.office365.com
 (2603:10a6:8:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Fri,
 24 Jan 2025 01:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Fri, 24 Jan 2025 01:26:42 +0000
Received: ("Tessian outbound 2d1ee33e113a:v554"); Fri, 24 Jan 2025 01:26:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5ebbd5c4707a6c3b
X-TessianGatewayMetadata: XosOLEcvRLKczOF3SgKYj4l6BjQ3zlGXtok/Az/yqIO2iwUnlaHoaBiwP18tp+7LB5uvauD+TSLOZ62nM+voa706gNfDsbssyUJsgeMtZvrgCt5WQlMy/eH+4UVcoVNqYj78SwknzQTedpBwLNdkpuD1TakHXdLAF3ZXzZHOWzN77CvVwg/LQ9M+mCWyACeJdXFvdv+JsmG7k1sfIH96BA==
X-CR-MTA-TID: 64aa7808
Received: from Lc9e7d21c67fe.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C3F8BFB9-0F0E-4393-A3A1-D081C5F6099D.1;
	Fri, 24 Jan 2025 01:26:36 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lc9e7d21c67fe.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 24 Jan 2025 01:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdSq+a/uWMJ4Xz+wRgooHWSMXw9TrOOPMf8vJO9uiqQ44LbHBjMb/yxoZk122s2XPMHecHJeiqMJKxidI9titqEHjaaDm044QdzA2mRCZX2VA3LQuQsD+vAVDveGwZfcvINZvoD5dAG8m95daM/0exdoeaMdUUkbD9IdEik64DbHFvMAwOmXnTdLtDDM35lRxWEL7eFeR8eeiLHdQdmCsLSUUftsjAJF1Lsvfj3Bx40kScG3Mt3Zp6VlSzvvA2Lbsu1fo3o+0+7+jjQ1jyK4YzZKaiYg3Rlb0XsY8xhgqX+7hg7R0kXPcgxH5CO3VJL2/COn42QgnNmfdsuDLQ9KYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNVmYBShqSjMNIV2McitAQFOe8DLSoDqrKrcwxftYtA=;
 b=doMdxaLKESUb/4aRM21YKRbNur0NIAUG/LTbltp3/pGn2Bc9E5gCRPmqH/5/JlarlJU6WgejHvJ9H9vc0RNF1qxmQqGyU8MElNT7DiKH0mslnFJPfx7N+VgmDZvFm7ndK21p01u5fCc8Jcg/xVOd2HqWvjCrgj8+MRjNtKdZsMdRpgu35OvTT7p8ssYac4GGL9fzLGCnnVKfVoppeuSxjNJAdYdpYMHpPgkw8AYG3G+bGaYaI6YJYdSCLNK+fDwxGCZPiimGT9Bfl7FH/ryh898VfstJ1bMulSRXcLUm6wvgFM8FcLMOD7g4lBbTfWJ8IUUMmdlQLJw0+JzNeehaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNVmYBShqSjMNIV2McitAQFOe8DLSoDqrKrcwxftYtA=;
 b=l7PCmDpQUOfXxzQ9SmBl8R3OJTFNUQmKApr+CMJ+aQijCuSuBBvePVeZ84/6ptlT/oMepcr0Cr/mr9Flm1q/EM9hky2VKDoVvYhjxh9w3L5WcQwCFvu9yTx28h4wtAC9ebpsoL6qBf5qfBKOOT1BClhWxIx5QoR9M3rnkj1ox6M=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB9PR08MB8436.eurprd08.prod.outlook.com
 (2603:10a6:10:3d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 01:26:34 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 01:26:33 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 RESEND] events/core: fix acoount failure for event's
 child_total_enable_time at task exit
Thread-Topic: [PATCH v3 RESEND] events/core: fix acoount failure for event's
 child_total_enable_time at task exit
Thread-Index: AQHbYsIctsQWWyuw4EmiaA5TVwHL0bMlOFIz
Date: Fri, 24 Jan 2025 01:26:33 +0000
Message-ID:
 <GV1PR08MB10521CF5217BB5F36DE91D769FBE32@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20250109181231.3539863-1-yeoreum.yun@arm.com>
In-Reply-To: <20250109181231.3539863-1-yeoreum.yun@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|DB9PR08MB8436:EE_|DB5PEPF00014B91:EE_|PAXPR08MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b1361b-c607-4364-1055-08dd3c16288f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|7053199007|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?3MJ7TvJEa7JRhrQGgspojnBQb9aavqi4nH3WvpgKhoDnLCu+iqHBFzxx6onn?=
 =?us-ascii?Q?8aqN2NW0RDtSOrrIFhNjuAPG+Ez6vMWjemo796w3wCVxZKZ27B6NYUNY0k9A?=
 =?us-ascii?Q?k0UOnWsILipXqKRzY2EhQlGh7H1t8/5drPjr75fpTbosx8ZAat8T8Dk7P6p5?=
 =?us-ascii?Q?n7GtRZp1DihqpGh1IGZgelqGZeuGVVNw85zBnvnXX8Pe4mZ4HO45t1ACjlcx?=
 =?us-ascii?Q?yunJ4QgNXMW9N47L2dTmoNkxflVyIdiT5XSbao2uK8Ajwi/hM5+o4VChKBr+?=
 =?us-ascii?Q?0pf/cukJKOhs0g7yav8h+v9VmT09bqVLqSMDJNXxha/PqX5MPAPoax5LPtfG?=
 =?us-ascii?Q?Oid95Xs32iZfsDID6g9vjVdb1fITeLKB1bsosjqvbPjUAlJj13HzQ8XRKGSq?=
 =?us-ascii?Q?q8X1Lcnq0ISSWfcRk21n/ABBRfJdXbXZxWN5FKBU7tOCnvZ8AA7UyMPLBLpe?=
 =?us-ascii?Q?Ze9HFbKzOL9GVpIyCucaDWAsQK0f9cRAdYonZNeKML9KGF3l/ixNeMtCrAhR?=
 =?us-ascii?Q?bvrvILAB9R2fVoKHc7FG2Ggvmn09gly26J9cz9doEko8yQWHf3Wl9lk/tMXZ?=
 =?us-ascii?Q?Dkn9rFazZS6Hn9dITHbNjDgYrRu/oN7mVE0s4jC+wbeqV+2qV8a40KNZntSG?=
 =?us-ascii?Q?p4PDeHJwEv74oLtP9v93Ys2lGYvW+sEUv2MwhGKC5IVjLkk8mEsKgHVkIxnC?=
 =?us-ascii?Q?BShGDqZVUIoHLeExnBBe6hdtv2bN8Af6CTFNpyYxdcfWVP584/RCjMo534tJ?=
 =?us-ascii?Q?fO6TCrkecKzIEnVrkJgS8YQR/0WwlL5imDSDuDIgE1bEudBV4ZfsiAV/1sro?=
 =?us-ascii?Q?QJ7/LhqktQmBQzL0/Osp/mWc4oCRBnHCHg2hVMVsniRyz6EkBxhdRFcv1+U+?=
 =?us-ascii?Q?q4x9unBtLvqAGhyUAbQfHztkBUAXEsFMTv2O2Gzq/KCYuR3ENd1l80YMma0H?=
 =?us-ascii?Q?zgh2Q8GqazOY/TuLkMjNexagS/Z8F08FjgKcYX6Pa3b7JL3lm8CDaFeNCY3o?=
 =?us-ascii?Q?Php5lkziSmQwcGPQ3m1nOegKS+gLVmpO6K6Wa11bouAdviI1mzl1i4Jx5DGs?=
 =?us-ascii?Q?Rhpz0AiHpcSQIbgWQWwC7NB1GnvMQFO8o+T1pVwrkvxZQm7xKjWAhppTSOzO?=
 =?us-ascii?Q?4gFSQzJNJW53gLxy5LOQeRM0b8FjN4JkUnBh4CeKmB0MYCQok5AzsoHzGmjt?=
 =?us-ascii?Q?3Co5ExDBLg0/dpHYv64d0+YqdUcMvOQbrWEMdsZMlWC8cuImUeegiPzX0WTN?=
 =?us-ascii?Q?uQprYnK9jE+Oa1mWQ0DB3VsHeY/1yMKC9+8NxdNOBVS7mM+ZA2lMh/S9izJx?=
 =?us-ascii?Q?Y9mttT3yAik5xhfH7pm5CVeMHP6smCQ/lXJW5UxsVLSQeCLuyiI9svQ+mHuA?=
 =?us-ascii?Q?lsE8Swg8qY5UJcaR+rFOidbkAl1GJ9GsEtnZLNCAQrTMIKHFIrqBMH1xiS42?=
 =?us-ascii?Q?nBpZnboO0RuVGDk3FB/M+sh8sIIplLpG0FcAZzoBK/PSoZYgxNb1vQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(7053199007)(921020);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8436
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9d6773ed-8e03-42de-f51f-08dd3c162319
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|36860700013|82310400026|35042699022|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?drIBntJqYiaA1W5YNRYviqLMLgXnhWC81sa6OSGxMQEfS4UjdWNx5oXHISCX?=
 =?us-ascii?Q?OcW5KCScVSXDdCFsJvK3pBhsNH4HGe+29y+lDuI4fT3eV+iSTokhLEhkHGzl?=
 =?us-ascii?Q?oseHyvpEL54aMwQzJoIvwf1hygHoqdsIrZ4cnVlsrRQAW6xBuDc+/EFrPpD1?=
 =?us-ascii?Q?STLH9DsFjjhe6GM2XnbScI0EwOwb1HozxJFOm/nbSbNHWwvODUap5iVdxZJN?=
 =?us-ascii?Q?RgbkzW1SD+fQJRR9KTnU8rTA+r20YKltpAx3tqvGHCpwNQQ5JxBpAEU30pT9?=
 =?us-ascii?Q?CC5Mj2hXK7sMR3rOLwo38FYdH3iv50/bjk6UuFAoq3aS3uLPnQ1fw1tNurPn?=
 =?us-ascii?Q?iT1fS14gUTvU/RilIfJMKRmUpPgZaKIU1mhk7If7IGAEWeXA+yDz/d5acpMU?=
 =?us-ascii?Q?xei/CQbcmBJeJqYzUpk/+vY5k1b7O5enKCx2fUaRqZvcn2C2gKE6RKm4yTuH?=
 =?us-ascii?Q?z/0MnbPsfQYe6ogW9qMIE8o51TAzzsMMCq/+gR/h0wYJMhTwgrigYjPVyMP2?=
 =?us-ascii?Q?GeylDnyqQJ2j6huuOjXfxGMicNJ37INCmf1dRt8npxIEm6zm2D/udBRI7/QK?=
 =?us-ascii?Q?5oGLsHNg58vmCpGVLcJwRek6l4y8ZISzkvbySJLOGhKx9dtN1EvSfV6QWwuy?=
 =?us-ascii?Q?BeXKKfKR876ZrNKbB00vJs3XuEXUS67+oOha3WczvCgpiJFEb9pZos+k0UTr?=
 =?us-ascii?Q?Tj3ST8jRnu4e4P5XNYyBd8XKRulmdBdygezJhBZb/Qy3nAtcWNla0ndSXRBi?=
 =?us-ascii?Q?d4lgI8UklLTw7iFBzZF9h9oOdC2jYUBr0MRmHswLkjHVapxbOL9RLBCO+zC5?=
 =?us-ascii?Q?kPVUwXoWmrNrF6TvWqOrOr+6Ln2nCcAytD7Xy4TF5f+qr9NfTTY0yZcCQijd?=
 =?us-ascii?Q?OFa1yr+E+Ic9qCcFpjYDMhNIYA2x2sNdfKkfl8lq4u/OVVCkmnw1s9F2D6J5?=
 =?us-ascii?Q?CJW//kM2PF+oEOoW6wx5bXmlYrTwOj54YfjYw+pbB/lpREHs+EjZqjdxGa3i?=
 =?us-ascii?Q?kfXFYR0NNywu5DOik6PuGEBWxqh6Y0/8M1HAmbPfjMPaIRKiFYEpwcdfdUrW?=
 =?us-ascii?Q?yWxR21yV5JGwm6kE/lM4yXP2eVuAM/YsqqnGA0WyE+2CQ4XQ8BdI149f2xbW?=
 =?us-ascii?Q?QfiHMu5k5fnNQ6qk9woVy0hqZjS3CK9tSf5KimDT+OCO9GhNO4lcl1lw+YTF?=
 =?us-ascii?Q?8Qr8En1wBqdoVqyAor1f34jnD6WYGMVn1+Angr5y6KUsgZ0nxqx/Owm+xWR8?=
 =?us-ascii?Q?SFFA9SSBopo7tcIFXyxdleHlPsZxRb0D3JxZVNA68fDdduEsJkIvkQpDnrrg?=
 =?us-ascii?Q?r71ZQKAA0o98eIMpvmtiKJgZT9Jw14MuJoGsrZOL0ismnG6cq9zxBBid8pUn?=
 =?us-ascii?Q?4fx1sxbYqjq+HbMsLo42yh2VywecImdUlyunbgDAe8ItNFs/1la6KyrYbyyO?=
 =?us-ascii?Q?o2Yl/EB6VUvReyIUJ0d/UY5PHvwCiDOXXvn5yF4rj37L6YayNe2h1/TOBMDl?=
 =?us-ascii?Q?/SO/2xpBbO5Ncjvkbjd6kd/O8QsosD8APvS/?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(36860700013)(82310400026)(35042699022)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 01:26:42.3890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b1361b-c607-4364-1055-08dd3c16288f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7490

Hi @Peter and @Mark,

If you don't mind, could you review this patch please?

Thanks.

________________________________________
From: Yeoreum Yun <yeoreum.yun@arm.com>
Sent: 09 January 2025 18:12
To: peterz@infradead.org; mingo@redhat.com; acme@kernel.org; namhyung@kerne=
l.org; Mark Rutland; alexander.shishkin@linux.intel.com; jolsa@kernel.org; =
irogers@google.com; adrian.hunter@intel.com; kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Yeo Reu=
m Yun
Subject: [PATCH v3 RESEND] events/core: fix acoount failure for event's chi=
ld_total_enable_time at task exit

The perf core code fails to account for total_enable_time of event
when its state is inactive.

Here is the error case for failure to account for total_enable_time for
core event:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=3D0x08/ -e armv8_pmuv3_1/event=
=3D0x08/ -- stress-ng --pthread=3D2 -t 2s
...

/*
 * three number represetns each
 *   scaled count / total_enable_time / total_total_running_time
 */
armv8_pmuv3_0/event=3D0x08/: 1138698008 2289429840 2174835740
                                      ^^^^^^^^^^
armv8_pmuv3_1/event=3D0x08/: 1826791390 1950025700 847648440
                                      ^^^^^^^^^^

 Performance counter stats for 'stress-ng --pthread=3D2 -t 2s':

     1,138,698,008      armv8_pmuv3_0/event=3D0x08/                        =
                       (94.99%)
     1,826,791,390      armv8_pmuv3_1/event=3D0x08/                        =
                       (43.47%)

Since above two events are belong to the same task context and
mutually-exclusive per cpu (they couldn't be active at the same time on the=
 same cpu),
the total_enable_time should be the same (marked with ^^^^^^^^^^^)
and the summation of ratio should be 100%.

This account failure of total_enable_time because of
account failure of child_total_enable_time of child event when
child task exit.

Below table explains how the child_total_enable_time is failed to account a=
t
exiting child task which switch cpus as time passes by (CPU0 -> CPU1 -> CPU=
0)

 - in means sched_in.
 - out means sched_out.
 - exit means at the exit of child task.
   NOTE: the value is before calling list_del_event(). which mean
         the value at exit column will be added at parent event's
          child_total_enable_time when child task exit.
 - ctx is the child_task_ctx,
 - e0 is the child_event which set with cpu =3D=3D -1 and opened with pmu0 =
only
   added in CPU0,
 - e1 is the child_event which set with cpu =3D=3D -1 and opened with pmu1 =
only
   added in CPU1,
 - e0 and e1 belongs to same child_task_ctx.

          CPU0 (run t1)        CPU1 (run t2)          CPU0 (run t3)
          |  in | out |       | in  | out     |       | in      | exit     =
   |
---------------------------------------------------------------------------=
---
ctx->time |  0  | t1  |       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2 +=
 t3|
---------------------------------------------------------------------------=
---
e0->ena   |  0  | t1  |       | t1  | t1     *|       | t1 + t2 | t1 + t2 +=
 t3|
---------------------------------------------------------------------------=
---
e0->run   |  0  | t1  |       | t1  | t1     *|       | t1      | t1 + t3  =
   |
---------------------------------------------------------------------------=
---
e1->ena   |  0  | 0  *|       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2  =
  X|
---------------------------------------------------------------------------=
---
e1->run   |  0  | 0  *|       | 0   | t2      |       | t2      | t2       =
  X|
---------------------------------------------------------------------------=
---

The value marked with * means it doesn't updates since event->state was
INACTIVE.

Please see the last CPU0's column with exit (marked with X).
Since e1's state is INACTIVE its total_enable_time doesn't update
and it remains with former value without accounting t3 time.

In this situation, at __perf_remove_from_context() while exit child_task,
sync_child_event() where adds child_event's total_enable_time to
parent event's child_total_enable_time is called before
list_del_event() in which event time is updated by setting the event state
as OFF. that means child_total_enable_time is added with missing
amount of last enable time -- t3.

In case of parent event's total_enable_time is updated properly in
list_del_event() when the task exit.
However, the child_total_enable_time is missed when child_task exited,
the perf prints error amount of enable_time (which is summation of
total_enable_time + child_total_enable_time).

To address this, before updating child_total_enable_time of parent's
event, update child event time.

After this patch, this problem is gone like:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=3D0x08/ -e armv8_pmuv3_1/event=
=3D0x08/ -- stress-ng --pthread=3D2 -t 10s
...
armv8_pmuv3_0/event=3D0x08/: 15396770398 32157963940 21898169000
armv8_pmuv3_1/event=3D0x08/: 22428964974 32157963940 10259794940

 Performance counter stats for 'stress-ng --pthread=3D2 -t 10s':

    15,396,770,398      armv8_pmuv3_0/event=3D0x08/                        =
                       (68.10%)
    22,428,964,974      armv8_pmuv3_1/event=3D0x08/                        =
                       (31.90%)

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..d27717c44924 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13337,6 +13337,7 @@ static void sync_child_event(struct perf_event *chi=
ld_event)
        }

        child_val =3D perf_event_count(child_event, false);
+       perf_event_update_time(child_event);

        /*
         * Add back the child's count to the parent's count:
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

