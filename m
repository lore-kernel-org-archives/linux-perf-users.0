Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E24AEF5;
	Tue, 24 Sep 2024 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162032; cv=fail; b=smOOrxWqlX0R5Yu7TssHLHeN+0EPaYpHvC7LlUsrVghVQP338zgM6FltFufck6hzN+kP6x3ip+bpd6NucAT8jVHkEWAXeKQ/fEuoDrGrSRVvdOOD2L15IKU0ojmwTPNyV6/Ski+2gRnE4QYvltliISiJIJyk4rOJSHS+gLW68Wk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162032; c=relaxed/simple;
	bh=oFV6vC8hopGfbGj4quZBG32O52REGC5Bjwpu+1sEhMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FdgIySyG0Yw3AhaddGmhjOKXJFZVYyz9n8A03tnNlvNkp717oMEa4/x4omVSTxl6u8i7XZ0W6f0fEfRrHFTTK/HlxLgpWtWjNtQmM4ucxGAFlkRadL7XVmaUGPfZM3mAi1QSspYaOBN3ymKWMqM+QIi/2g0tb6/JPG7xbt3AI+E=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CDLHfdEW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CDLHfdEW; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CDLHfdEW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CDLHfdEW"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=r64kErHnsj0O6THqYB3qLsUsiVC4CqqsYvsVv7IWlalgqnA4mb1juD8iExqnYyjiy1iAucYlQBp5BhyUefyxw7SYVedUqBHCEx4GeUrtkIMyfJObL+K3wrvLB/STPtEFRhAdNuJlT3Jai6U3fUEbENQpX1h9nEjDXx/hUvBLnliVtpkc4YXXo9FqO9wt2uKFftNNwcyZqhX4vuVBYVJL2Jo4NxuNnS4nD6sAdZo7Jy5Hj7mhHP6w2YyXW8L/1h28uekpflEXvjL+nm+bFmpPeoVoeSW7OXV6IF2VjIcUSURIGP5Hi3VOu0n1IUgby4g9OvfLuOuTNRAa5VQJv0EpKg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftPT4simDCSNarGItf6X7OErJVVq0GPOZZw5aSdfkQ0=;
 b=obAhpHo7LNqPFLdPxM4Yxqrqanug+g2zbXmRYyPiRyVxNgoTK4316WJzEcQR1GTl1oGi6589E0sPuqK/OzBWQqUL4gLxTs4DwwBusVFHFBAeP4niW1BAAMBvhITGEY8yskVfexzmcn50ou79l2neWDtZJ9NJegySqMb9yj9+I8u4+cJ8YxYDk25NSrtCiTG6QedyyhD2GZ5L5kJR+mvIMLKny/c1LNAFFn7bUU82WJN0st2r54P2EpfL+XsrGeTsxXQ2QeJNF9VBQqkyI1P9iVf0LSR6qIwZ00uSdjAD3oNDXlPymnhSPhUyHNyzf63B+/rQI3B9+trWDbmXz8f/lQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftPT4simDCSNarGItf6X7OErJVVq0GPOZZw5aSdfkQ0=;
 b=CDLHfdEWwz5ogW4kLXZaajnuwDwiUCeYEEjRD97gFcmdvtBniWSwFrx4eN+0CADr8eQXevwf74V+UeS688L8tzAkmHf2NOhKzz2EjlxEDLL9bGSxkgui8S9gW0IYMrcASKKY3m7kM/iNqTzSuGkdfHbnCMUjDQkMCIqiBKfFfJE=
Received: from AM6P194CA0057.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::34)
 by DBBPR08MB6281.eurprd08.prod.outlook.com (2603:10a6:10:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 07:13:37 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:209:84:cafe::56) by AM6P194CA0057.outlook.office365.com
 (2603:10a6:209:84::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Tue, 24 Sep 2024 07:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 24 Sep 2024 07:13:35 +0000
Received: ("Tessian outbound 690adfc84afa:v465"); Tue, 24 Sep 2024 07:13:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bfc83d0576e86027
X-TessianGatewayMetadata: HR+sKimEsLv1o/Mk03woC24ZnVpOjfQs90wKJReuIwY0GETOK80IZRICgk1TzQfsh9dKG33ftdY7iJ0jaY25b9tH6laapOIyQh+bE+o9DYJwK+irySuYlTYMbEt4lR9lU7hNj8SlkdzlD4aZVoZV9jxKjC4dTqIYWRcARU4RnSF8BzXW7JtkVXjoHj+t+ROEC4JNUk8pR9IWzQ8hBmo3ow==
X-CR-MTA-TID: 64aa7808
Received: from L49a71f081dd5.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6F430B1F-62D0-45E0-B70B-04CABFEC7511.1;
	Tue, 24 Sep 2024 07:13:28 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L49a71f081dd5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Sep 2024 07:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNNZRCGCHZB2+pkhZFbnTOeg64Q7RxOHERG9yat4jDJdtSenjA6/xfdOncnrK11RW3MGWojprVi+bc6sIicFqonb7Odble3K17x4sDCdCHZ1Ja83NseCQgYC6KkFUvsXfMMnEmlI8ILNNYshmpyRVvTHAw5Q2rDHGX1+9p1rwphSKNfyo7CIqT1jOB81Fj+xz1NI+VBlcO1+3V6kH/gBNn1FKZPRMSXFW+ZEuK6XLminKka6Kcg/SwBcDWwoSB1A4H7l1iEZ8vWiWrD2bTLqHn5S01t2+NG/9BBuEmCgIM7lVVSwwtCac5d6mdKamPiRUsgl2SEmGVe3DmDiDX09OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftPT4simDCSNarGItf6X7OErJVVq0GPOZZw5aSdfkQ0=;
 b=SuPpTCM7McERedILQMDkFpf9OsGj+m2utL1tQxM+hG0ZbyIQ9/E+/qaAfsLCy02HPKJ6Kg69Dhs5weZ3WOoLx5tnkYtGfIFq/eDM5qqc5sD4Cwjzalh9bhaJW6yKMGXm55P0xFcg3l0BKD/CfkDb6qqMncuP53DGQRE4MLpNi15xZeXNGASvKpw60gMTUNE+2dnVtQlFw4i4U9kmWS9fSBIU3BOAtZcB4CeIFnQGEakKlTR30Ff+ML4kiijg/yPCUBIrDE6ShjEG7qnNWkNifBX8c1U5igejkit/tbCG9Z73nmCGZ2PeKhmYwXPVbcBaf9I5MhBxyo72rSoA3QHCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftPT4simDCSNarGItf6X7OErJVVq0GPOZZw5aSdfkQ0=;
 b=CDLHfdEWwz5ogW4kLXZaajnuwDwiUCeYEEjRD97gFcmdvtBniWSwFrx4eN+0CADr8eQXevwf74V+UeS688L8tzAkmHf2NOhKzz2EjlxEDLL9bGSxkgui8S9gW0IYMrcASKKY3m7kM/iNqTzSuGkdfHbnCMUjDQkMCIqiBKfFfJE=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM9PR08MB6017.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 07:13:24 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 07:13:21 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "james.clark@linaro.org"
	<james.clark@linaro.org>, "asmadeus@codewreck.org" <asmadeus@codewreck.org>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd
	<nd@arm.com>
Subject: Re: [PATCH v4 0/2] Minor fixes error handling of perf stat
Thread-Topic: [PATCH v4 0/2] Minor fixes error handling of perf stat
Thread-Index: AQHbBeUfytSJ9uZC60eYZMsyvOFdjLJmlkca
Date: Tue, 24 Sep 2024 07:13:21 +0000
Message-ID:
 <GV1PR08MB10521B7D2A65ACA5CBD252655FB682@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20240913135907.648734-1-yeoreum.yun@arm.com>
In-Reply-To: <20240913135907.648734-1-yeoreum.yun@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AM9PR08MB6017:EE_|AMS0EPF0000019E:EE_|DBBPR08MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: c64591a0-4184-4c9a-c124-08dcdc686789
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?UVZSNrmmemzOizn/Q7oEFDXE/1RvAvZ+tq9klxxcajnjxGenieupmy/Pfj4E?=
 =?us-ascii?Q?drYWcd0sq0QjUq3YYgAcp9qrZQ7G74lY8OfuikAUdaw3VC2AjL35QnUi/S0V?=
 =?us-ascii?Q?/AoQU0bglQp0Hzje4jUjSq8e0VuUzGq6msk+sh6b+/nlH+GRcUJCtZZb0700?=
 =?us-ascii?Q?AxXOWbQ4x074Rrg1pCBhWW44SVcNPj3h2rAjjhH5l2PoV27O87jq/+d3tOK7?=
 =?us-ascii?Q?SIRmzqcDZNnFhX0OkTR/GaGmqElZ9OZYS3cQnVWb9KwLMtQr4zxwMzHCddkQ?=
 =?us-ascii?Q?UxfBg9aD7JFuxKV8u2QVKAD8OWvgAa+MJShIlCQdukO3eKzSLZU7i6ICbC0h?=
 =?us-ascii?Q?zF7ELICKh1aZn9IiP62NH8ua/DHSglTZ/UM0DzE2202PPciUbh5XGmbNQCXa?=
 =?us-ascii?Q?nNLO07tXXOwS+zL5PK4Q1naTkvuhtSeh8d+wWgHfuzg3QodJpqtNPVLjIFkH?=
 =?us-ascii?Q?pNOuZpFq3dwaWeyO6nkjnRP27EM+SeW3yQEREwvE1F39TCNOqx8DF0IC3TSw?=
 =?us-ascii?Q?OkofhMOSOJO7yUHB13aAm2q+Yp/T19bqqd/H3p52RqfxqLwEbsTm9MM1wKst?=
 =?us-ascii?Q?mVlzlvaV1JDRgosbt9JOQnAA3D0YaAQJ8KtWIp3tpi5xP1lgnlpkG2X4ihIa?=
 =?us-ascii?Q?UxaMGpEFCt1s0TxV3mwV1lcyC/dsEYdRCj7MW0qToypwKsbWX0u0ZkH+uD9P?=
 =?us-ascii?Q?LHDSCv4KCFCgFQ5Z7/Tq0jT5+HsxVWmb9Nz2JaqiKrbLWlyfnYfJzY34Kq2d?=
 =?us-ascii?Q?28sXvXDBSbvQuxPj00Is+endDUJJnmqIBvz9coOMvm+4le4LjHtbItnqqe4r?=
 =?us-ascii?Q?/Zfmw/w6bUbxpVIg3YQa5QuBiu+7UqDOB9Oi2wt6Bo5Xtg+3pwRuKpU0EGYB?=
 =?us-ascii?Q?c5aRVUldDFzBeIL3IBKDLjriQkTcedMseEQn7l16r/hXNJjlywHWbCNZ9nO9?=
 =?us-ascii?Q?KfG85hx4aEnzx8ohIC0teQKDbD2wAZ8SlKap0wdh4+cKML40Z1DuzgGNm2Xz?=
 =?us-ascii?Q?wsp30wDJO2TW2lCplwweltGcpgui5Bk6M++HBD/JUEMQzIjRw1oMsnPHUtW3?=
 =?us-ascii?Q?sYJ0tANcxzz5HCxxVxG45fVyaVSWUJ2FdvClRfCp9dHQP3058zo5BEx62DvF?=
 =?us-ascii?Q?PjZvYkddMTMhi7K/cVYlejbtbk8l0HXsz+R/GYvO2j/rma3tsQg8EHrlIsHW?=
 =?us-ascii?Q?bViQpMy61qPE86qp9hQdwsqVG5hM8j514kDo5QeuphpqDgcAmwf8MIuCVnyg?=
 =?us-ascii?Q?YEYVe9TQDuPuk6b29cg5Z2UhHYNvx1CgMvNPKSirNwF6+6aDumg9JU9XUFEy?=
 =?us-ascii?Q?CQQLGIBaX6iIlYCoJQypMECu2rahEa07pSvxIxIa3Cn2swvHj0jzSDafQRX5?=
 =?us-ascii?Q?Hq+ZiEhmWQAkjSQ1SVJmKglYG6BgvJzcymtKHycBeKjmNzsXPuMwXdeuB8bW?=
 =?us-ascii?Q?fkQh+frnNIs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6017
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d02c29b6-377f-442f-3ec1-08dcdc685f8e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?USMSjeoKO4gSSSTM2L9K+AdAMFLdOppI6Xz+LfHeVMP9v2RwVZRsGvAbgS9o?=
 =?us-ascii?Q?oOl8PzjE6hiLAukhn2w9XS/TN2jrJkdFMkxyQmrcD5opfrqvw99XfOvXvJvV?=
 =?us-ascii?Q?+rKFthFdOD7BtlxB/WnYhefM9QJKY0QsHxouTow/SayzyT/fEhxQ8FW95EjP?=
 =?us-ascii?Q?lfzLgOsVW9/QgDkIe1+xBE0pvtr3aR4DFmuazIkdDv/Z3kMESUWd1nqUwqsF?=
 =?us-ascii?Q?Ch2bvDAIn5J82Hp1k8m7ZDcGrkVV/phhFrNRuWYb2rR/cQ9UJNtUXOkwARDv?=
 =?us-ascii?Q?8jz344lIYuWZ7wWC6eJA/a1jZgnYF+ozTU07r0KGaK3o8tx3Q3l1IMA42Oiw?=
 =?us-ascii?Q?lMQVmSeVmdR1B1hDJs1fnyr6v3hgzO4GSQklDPYjgunZ8aKRUQsdkwG5duXZ?=
 =?us-ascii?Q?XA9xknuWToJ6F51yESPFQE7ZOkIbiCkP6G+4ZSba3W+rfX1v/ymkqVkP+0Ch?=
 =?us-ascii?Q?Mxu+WrH56HPrpVcUx+YuehQYyZv5XJjMQQ1B9Wqg81AyDBhHE+yOx9Bn/0gI?=
 =?us-ascii?Q?5qPuxI2VS80gEkT2X9tdO73YcLMpEbwISf6HAmFOCT3kXbtaMZwd7asuwaSL?=
 =?us-ascii?Q?r8XXeP15r46M5csJ0nNrKl/WLA5gx2LVQBLDux6Vp3i+o2NGayELIlRwuIoI?=
 =?us-ascii?Q?sGs1wZmA+M1YMc6oqlpetAmE0iP8TTGTfl5BXChIehGXIfLq5FuMoyYY53w0?=
 =?us-ascii?Q?gt/UMPMlW10491ueaAlWCxgdiDjZdEOpFcxtFxF4KaH4DpvKyiGfkiwWO5q/?=
 =?us-ascii?Q?Tv3vcuJIO6lin+rdHDT2eaBQFOOkFhIV1/rpZPK0jJnLCCoVu3pFq7EayUlv?=
 =?us-ascii?Q?ZI/J/sxlsObfrh/6IO2pHBerJzB7f1rqMWcUE8X8JpnNNZ1IlTFi4ashWWII?=
 =?us-ascii?Q?US4J617uVc5Tdv7JaR+zQ1h8g0srukNnmFJkkYdMyRfrr5jBOpHxhVkoHLWz?=
 =?us-ascii?Q?aSVg5v4rvFJRj3bFJc6d9Ah57OoMZ5GMIHQSQiUDFBwWZAjGH+1kWJxA5lj3?=
 =?us-ascii?Q?QsW518LMc2CCNij1tis9t42odPOvCEyioucLefoO9+MEO9DdZP80wCHwGSAY?=
 =?us-ascii?Q?g+cjaj5TlFMfYV6voYsBiwZ17JtkKaIdg9gFrcf/xZ7RkZaksVjsr4CAEYQP?=
 =?us-ascii?Q?8tB2YbLuI29VqfKBPpZ5QeXGNauCLP8+49PFLAYHv1IhUkjuRNa04Zl7cpkw?=
 =?us-ascii?Q?E4TT3JyK20tlA2GtR5PF2NmMUwSATPUOuoYo/bofUKUkV2gqOwBhsca6nhLj?=
 =?us-ascii?Q?rHkO29yr2XsLrLa2uBkILdrC4uR7ufSoKNAuEiu0PgH7hpqluWXrUN4tbF7Q?=
 =?us-ascii?Q?SN8hTRvESF3mN70Pic7M/XLjPYr8Oie2M7JT4jy6N1sT5l+p+Z0Zl9sPlXs5?=
 =?us-ascii?Q?BUlK4Hk/Hc6FVZppfZp5GCNTxX4e?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(35042699022)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 07:13:35.0777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64591a0-4184-4c9a-c124-08dcdc686789
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6281

Gentle ping.

________________________________________
From: Levi Yun <yeoreum.yun@arm.com>
Sent: 13 September 2024 14:59
To: peterz@infradead.org; mingo@redhat.com; acme@kernel.org; namhyung@kerne=
l.org; Mark Rutland; alexander.shishkin@linux.intel.com; jolsa@kernel.org; =
irogers@google.com; james.clark@linaro.org; asmadeus@codewreck.org
Cc: linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; nd; Yeo=
 Reum Yun
Subject: [PATCH v4 0/2] Minor fixes error handling of perf stat

This patchset fixes two issues that were seen when running
  "perf stat -r" with perf_event_paranoid=3D3

   1. failed with Too many open files.
     $ perf stat -r 1044 -- false
     ...
     failed to create 'go' pipe: Too many open files
     failed to prepare workload: Too many open files
     ...

   2. repating error message
     $ perf stat -r 1044 -- false
     Error:
     Access to performance monitoring and observability operations is limit=
ed.
     ...
     (repating with same error message 1044 times).

v4:
  - Move comments to run_perf_stat().

v3:
  - Fix comments.

v2:
  - Add some comments.

Levi Yun (2):
  perf stat: Close cork_fd when create_perf_stat_counter() failed
  perf stat: Stop repeating when ref_perf_stat() returns -1

 tools/perf/builtin-stat.c | 11 ++++++++++-
 tools/perf/util/evlist.c  | 14 +++++++++++++-
 tools/perf/util/evlist.h  |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

