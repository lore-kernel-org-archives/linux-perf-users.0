Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7727748F;
	Wed,  4 Jun 2025 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749031657; cv=fail; b=P1oL/PB3U7ik3U2RWbdJZ0HJNm0kIDjXs4rTnERKe3bCmEiv+0HlTcd/Tev/0Ne91EYSVJ7ABRlA71YrXD5Tf0vykNCxRkFqYqSntNoLFVLcP/zbzBkrpRVRJzb2xM5MK3auDP95zbm0o3xidYvrL+ArCy3LSkROGGjTtyKDdJg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749031657; c=relaxed/simple;
	bh=Ad6FITFa0sk5VBSodMotzTMz4kiDARWlVmOM3Aat3AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vDdf5w++xBpaYVUGoZ6MI5iJGbyVC4waZtxNpfvAPoqflQfspWjqjiP99Alb+OMd2bmaYuex1FZVdOorhk0wbXQMFBnvqBdVBB/EkE657QBd1XPQFpBEm1w7mkmlgljyMQP4AksnO8mGtnrCeeWzOwfLtHE6N63Duj9iwDr7IcE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LVwsstmV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LVwsstmV; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LVwsstmV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LVwsstmV"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EQeNRSsEHg9ILBIVVLOKnZ7KUCFbWslOl9XGcfq4MtXryHvZBESeV9nl+1r4jPGBvz2Td2FCKg5ZOuyk7RjY1lv1bWtK1vELWq9AUF6cBKH3GxKxfxlJ4feH51MT61FHRRgQ9sXbhij4ltX1ILf+W1hQIs5klrKpWl5qIzmaPUFhu2NRfN/lIyVuWuimeYF/aLyTxrOoq3C85IesWGnEj73CNM1pN0Fnb87/6AiPUCPr7cdW8mW8gmgsqVxH4GX4+2RdFXU+/FDXw7Q4ZdAZ/AaPfD/devo+JTeB73V+iP7aRPWAaQHx0gObjXG1Y2IpCwMzkyfDiE0LVi7ajVnIxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hi3teqMiPlwrMPKZkGyCIx3TaKy1qnX4fUUPLa9R9HE=;
 b=ZjHwMQT3xJWOdmXCvcZ37DP+FGyl8pk0KTpGkHmnYDXDRQLcH8gb+DOGfBigFxuM8h2Ii36JRg5qtZaHknS1MJCm7a1OOIsOwQiJMwvmSs1MXmIA5YuANDDrsakBqxna9M9dM9NdjqEyp/65Wmt5ZfcZGME08Ax2R/KHTMuPS4B8PChdgTwApHUWXfOXYCcjgDXjSJF1JFPFJ7kNurq0fGIOq31hmJcGJJLCtnVHeYG1hj7BnbX9trRRQdJL3hwAyLx35podCiirMY7Ww+OVbQqQ776R68I5UhdlO10vWlMKPcBd1YCDO5jYIA8RLbk4TbMkDeeml3hiGhcXJ+sE2A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi3teqMiPlwrMPKZkGyCIx3TaKy1qnX4fUUPLa9R9HE=;
 b=LVwsstmVFfQ4sAwid+HApXldm2bqKcN6ybC8ZrcmYRQsRYbX/kG6dXXCEeGkWc6rv61hoWXqzj9fk/a1/tsCImEvcZ4xMujnkKRUBzPLnOoswR6GrGnSfqmO7X0liSFiyLwpZZvvabqryFaBkm8nliTLs3rqOj8H9gPO02rZYx8=
Received: from CWLP265CA0288.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::36)
 by DU0PR08MB8230.eurprd08.prod.outlook.com (2603:10a6:10:3b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 10:07:31 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::65) by CWLP265CA0288.outlook.office365.com
 (2603:10a6:401:5c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend
 Transport; Wed, 4 Jun 2025 10:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Wed, 4 Jun 2025 10:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTmtCLB77hW61Fe/JvlGCytB4tufC/4wNOu4ebDjceL13sndskescsMbPw3lDzuh3F/7TCiXyxeB8eYs6m4vNbHGKLBZU9QuzTwE22oA7A221tCz7RDCLJz9PFjW/oTHLyriUgSIRrX0I4X4rbyrpVLaGyJuy0K8apZjhu9JpvJEC4puGzuFoHuokgSYJMqeZgLwvO1Wxf+DkEvMECfYqycmyC36xzp59cf86Zl5ixs8Afc2mggYjwzuxumw8riyRlJcbczHebSAsJffG5SNXoDhUzsST5hAoAIBE6HQ3XvDdO+3h/FQXZvaMFqzCxsFyFJeJhwK7ymqUIdDs5yLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hi3teqMiPlwrMPKZkGyCIx3TaKy1qnX4fUUPLa9R9HE=;
 b=Lfr+Rg5mcmnsKARnGHvAk8X8TDsbMwpZNfTM5nXUs9T+Zw15icU30tr2m+WL13xaAx/VVUgIWrvqwzP2TQ54TSpyCrBDBKSfoEtZI1Tz5VsHcVsjvzVJvoPz0PFhktDzdiCQEO3zn0scfFmGPHqb+ZTjX4lv4YnrWZve/kaRq9OWardp0raAw/t2PiNhUw7hbaG1/3Diz6MHLcIzs4XTJ1WXIU4qro3MAICEsAa6TS5BvVavPAQrDgytPODP76pip5e9QRi8EjPHI07YL2eXYf2cWFQW1UYW/CPJMD7wVQQf5pyFiTZwCbagcLNkGp0OTfPhVom/1rahTTzEno81mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi3teqMiPlwrMPKZkGyCIx3TaKy1qnX4fUUPLa9R9HE=;
 b=LVwsstmVFfQ4sAwid+HApXldm2bqKcN6ybC8ZrcmYRQsRYbX/kG6dXXCEeGkWc6rv61hoWXqzj9fk/a1/tsCImEvcZ4xMujnkKRUBzPLnOoswR6GrGnSfqmO7X0liSFiyLwpZZvvabqryFaBkm8nliTLs3rqOj8H9gPO02rZYx8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB9951.eurprd08.prod.outlook.com
 (2603:10a6:150:b8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 4 Jun
 2025 10:06:54 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 10:06:54 +0000
Date: Wed, 4 Jun 2025 11:06:51 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Leo Yan <leo.yan@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aEAau+v4qBQSt13s@e129823.arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604080339.GB35970@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO4P123CA0505.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::15) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB9951:EE_|AM4PEPF00027A5E:EE_|DU0PR08MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6acb2a-6c1c-4a51-47ca-08dda34f9e36
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?5E+x0sjVKDDpblHs6avKbdTyIcwE49Y7BTAsPMrYjselJyUYrjWf+k7+SwnZ?=
 =?us-ascii?Q?sVoktvXWa35VOtQBnovGZaVcup2dPyZpw3nqEnOLmC9jku5lva1XlkG1YGmy?=
 =?us-ascii?Q?LLbpuJQ0aJ4iGj8ssSH1RFIS3G7xib1TS7lkQlPG3D0ddKqn6KOJVOkku+w6?=
 =?us-ascii?Q?XEfSoVZlrc7tyrbcKnFztpJUlkouqizhzAs/gnsbO3/RVui2li7uH9QfYh0C?=
 =?us-ascii?Q?A3awY3jlgQxuWfchJPsiheUl+3frbu6E+eGn2NOvpIx7opklThZ9k1UJRCVf?=
 =?us-ascii?Q?dm57PSSQobvocuTy8DlZSQYawXgytaqCnsPPKbVJ2Q8p9Xg0UU4fo64iR/v7?=
 =?us-ascii?Q?ni+SnokUEKX1ZuxKvVOK+YW1CTtslO0RqMNe072tuhpQkxKKzlwa3mpgQWic?=
 =?us-ascii?Q?1NQuMEOH/TLcPilsnIRKxmOUxiKB9XxZ9lszZc3MxAdI1D+QaPtOTsQApPwS?=
 =?us-ascii?Q?EtsWFX24d4Lgg0Pdb+7uxGtrBm9zB0OdndHZ+VGWLY4HdYwHcpFGBPQf8MJu?=
 =?us-ascii?Q?s7oqrRUJXFOavDVXExzy7bDWWA4n3T3EMpwp6gmaPKLTzWsAijePluiKnjCc?=
 =?us-ascii?Q?B9/AnGRuSpUURcBTbb4hIFX/QhaBjV8k7FMUUCPzwN53ElP2Kg8o3IUfk7/c?=
 =?us-ascii?Q?COrZtMBkCTVeBg6Ucp/gQnIsqO3mkhVu/nkofFTiPZl9RYceyoXkwUlm6BJ/?=
 =?us-ascii?Q?cfIQHqvrWt+a1YxHLf6T2EH6cvAKZsS+qCt6vazm+tLPz4KUZ8L3YKdiWjT6?=
 =?us-ascii?Q?RCcSSLDqnEnhLnjIyKMT+2x4qdcEv3Et/GSowqYhveRCooNFZ/USHCzf684Z?=
 =?us-ascii?Q?sZJ9kclh1qtwrbhTTY47LNVAFQE3elrsKWiaEEogzKdv4asGp6rBc0JYlUKM?=
 =?us-ascii?Q?fFrfn0SQpM81tefkulXOubyQEHeuGMKkaB+/cxV9Xa1GwkQ/CyjSj8IkLpZ4?=
 =?us-ascii?Q?TXs7CbksFfXzFcbCnWsEUcv+IDQr3mCg+t6X0B10SrrIlWNKMjzgIlnF70G8?=
 =?us-ascii?Q?zKYyuJpNRxz8i2Wt/A+LYkX0Cuaf03umC157jNFl7D8LVtjkF973OuvupnGI?=
 =?us-ascii?Q?gAqpBnWZhsvawcI8+UpOKDSUyn1yf/idALv82QjauT5w8xnmyMENVgctZZea?=
 =?us-ascii?Q?C1qMTwrOnKmuREgkvTkjcF2MK2QPVyMALbi1Zzghs78ZQG+DfJ8Rht3ixKWB?=
 =?us-ascii?Q?4TTFpdtzYUXwf0VUa11oKygv600R9Ba0JXkozlPV9+CW5Lw1W6sDDTKpoLwC?=
 =?us-ascii?Q?E2hZ19THFAKXgYN6urC2oboG28Lo20+XREzFEpMMkPP70Bp7/6AM4tsbtswP?=
 =?us-ascii?Q?m8jGAxWsOBtRDR2B2f9n9BgLsIb1Pncw6rkheGkm+zRWZZQTzFTtlJHyQOXe?=
 =?us-ascii?Q?kolV2ELaW0TzCjourUbKTWDcN/b1qeq0D3Jbph3NAIAi8t2Zv/qo3yNhLvNy?=
 =?us-ascii?Q?f0Svvse8rIU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9951
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	73d5af06-9ce7-4906-a25f-08dda34f8847
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|14060799003|1800799024|7416014|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yZ3sm3wAfS4hN+bsQZa3DXT5Fx05rgFjmHoPnv9ugpBufRRG58UG8scPbncn?=
 =?us-ascii?Q?s4NK3gAEwe6LZJNxH97roPBvCLuKCZM3Ifl3rhopYCy+d8KYa6Xn6h06WdZL?=
 =?us-ascii?Q?P4+ti9wi0ahWmrkNPUeKcxK9da76x0ym9t4rPAGniWRqF0Q94mmOgAcmrb85?=
 =?us-ascii?Q?vAPg5dQ751LYeEmTAyVx6XBxcjRjDrAm5rfbzXFVan3NEeWDeXXS3NHDJWye?=
 =?us-ascii?Q?CtVQm+V1DPgg4Q2l3tvbItJCV60EJdRzsK8rR/9H/LTuygcCWhnWmyssQppd?=
 =?us-ascii?Q?9Yqev+NcmN7d2InORVyRTu1anAnOoT98z0Ur9DuithFBifCJmH534WjsLo3e?=
 =?us-ascii?Q?I63i9tPg1pAq55F7acD7cwFuwOTLcmzdkJq7MhB8npFIJZCBWlAG514yuFhE?=
 =?us-ascii?Q?4ZsHIYUiPpqkuARkN/OOCnnSKgtE/C6J0QYxCl9SUSMHCiiO08LxT3g/naKh?=
 =?us-ascii?Q?DYsKHmyHHN56XfZAgWl78EKeQxPEjOxrQV7ptBah0w8ooEc8pswdHJjKV+oZ?=
 =?us-ascii?Q?SAvWu7JXiSnVgwmXy7rOPJJSd3DAuHE+S3oqatcvTLd4o18GrTALM0WyXV0T?=
 =?us-ascii?Q?SM4HN2LOCuDmiENZBXO+YbOEfdaRImB1qgYTqzqZWn8vvH3mpl1Efv9KReq3?=
 =?us-ascii?Q?OqRhSRJPKG2H6ua/RI5y9+71lSwym0Pd3IjgM2Di0+ZmchTAkUyzT5Yl2vsq?=
 =?us-ascii?Q?c259x2sY/b3wnpEX/zqYNHeQvdadmRq1dk/QVe67kE9UPrlZxE6TRhZxZltH?=
 =?us-ascii?Q?QE17F7+L9OCd7bHMui/P0GmdL5tEtND7QvRrBQFBjyW/ggU9K+TIkZ0GrpaF?=
 =?us-ascii?Q?xfqONYyz9WSGgYjy90khgiSiZO1arxtqiCIF8/fgZxuS/JtklA6aABMZhpr0?=
 =?us-ascii?Q?DCp16MbaKXoS8Y62dgBqZGMEz04ImGSJwJAl9nLu7qq9uQj1HUR/R/SoFig6?=
 =?us-ascii?Q?bS96U2DxM+LFFuln/YSPyFsL1cAD+FHYG3wJhHJgCc9Kf/tz+1oocHqLKTx4?=
 =?us-ascii?Q?UbZICtnvWcbcjkCM9Bi+jbKL5qSiTMsLhZHNNca1vylrlCD2d0rnGORIaGvB?=
 =?us-ascii?Q?yNmT22kWKKV0umjwXoyca0s49mnjnEpXEt7JnsW1KRNnfBvgoYHEg9qeTyg4?=
 =?us-ascii?Q?v+RFSM1y7iPmxY/3xIGE0CDG0YesyGU6wFIs2oZEm3kHzU9A4u9fRzwWOEuC?=
 =?us-ascii?Q?5mPhDt2NS1GFu9tN20ukG/T4Wd5KKAknmw8BY3gMX073Rj5BfkWIz0AZjFkV?=
 =?us-ascii?Q?3E4efNjE/Ud5VK9WKgiRtdxA4WLpVlRcCyp6+a8p4mByg1s1NN8MX0NkLiKx?=
 =?us-ascii?Q?jmt94JuNsU/I7a749hTVRnfgXBPrZcQ2hhdi2XmaCp4CuGsFHZSVDzrfFRtM?=
 =?us-ascii?Q?isXmpRb9o7xKJT4rBH6PUIk0w5lDsS8dBGjgBULcVrhcYWdVMLGd91jBEf7j?=
 =?us-ascii?Q?84yYN5s3eUa/ZBbb95+etoKNBh1jcmXhTQ3vhrVCVZpa3FBboD+ZdirTI1FM?=
 =?us-ascii?Q?kUnKx+abHIQBTOKdmb5DGgXIZaShTXp/6v32?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(14060799003)(1800799024)(7416014)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 10:07:30.7703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6acb2a-6c1c-4a51-47ca-08dda34f9e36
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8230

Hi Peter,

> On Tue, Jun 03, 2025 at 04:44:14PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 03, 2025 at 03:00:40PM +0100, Leo Yan wrote:
> >
> > > > +	if (event->state > PERF_EVENT_STATE_OFF)
> > > > +		perf_cgroup_event_disable(event, ctx);
> > > > +
> > >
> > > As we discussed, seems to me, the issue is caused by an ambigous state
> > > machine transition:
> > >
> > > When a PMU event state is PERF_EVENT_STATE_EXIT, the current code does
> > > not transite the state to PERF_EVENT_STATE_OFF. As a result, the
> > > list_del_event() function skips to clean up cgroup pointer for non OFF
> > > states. This is different from the code prior to the commit a3c3c6667,
> > > which transits states EXIT -> INACTIVE -> OFF.
> >
> > Right.
> >
> > > My suggestion is not reliable. Roughly read code, except for the
> > > PERF_EVENT_STATE_EXIT case, I think other error cases should also clean
> > > up the cgroup pointer.  The reason is I don't see other places to
> > > clean up the cgroup pointer for these error cases:
> > >
> > >   PERF_EVENT_STATE_REVOKED
> > >   PERF_EVENT_STATE_DEAD
> >
> > Those should be done here; on the first transition into these states.
> >
> > > Only in the PERF_EVENT_STATE_ERROR state, we don't need to cleanup
> > > cgroup as this has already been handled in merge_sched_in().
> > >
> > > So a correct condition would be:
> > >
> > >     if (event->state > PERF_EVENT_STATE_OFF ||
> > >         event->state <= PERF_EVENT_STATE_EXIT)
> > >         perf_cgroup_event_disable(event, ctx);
> >
> > I'm too tired to get my head straight. I'll look tomorrow.
>
>
> Right; had a sleep. Lets do this :-)
>
>
> So the normal states are:
>
> 	    ACTIVE    ---.
> 	       ^         |
> 	       |         |
>        sched_{in,out}()  |
> 	       |         |
> 	       v         |
>       ,---> INACTIVE  <--+
>       |                  |
>       |            {dis,en}able()
>   sched_in()             |
>       |       OFF     <--+
>       |                  |
>       `--->  ERROR    ---'
>
> That is:
>
> sched_in:	INACTIVE          -> {ACTIVE,ERROR}
> sched_out:	ACTIVE            -> INACTIVE
> disable:	{ACTIVE,INACTIVE} -> OFF
> enable:         {OFF,ERROR}       -> INACTIVE
>
> Where OFF/ERROR are 'disable' and have this perf_cgroup_event_disable()
> called.
>
> Then we have {EXIT,REVOKED,DEAD} states which are various shades of
> defunct events:
>
>  - EXIT means task that the even was assigned to died, but child events
>    still live, and further children can still be created. But the event
>    itself will never be active again. It can only transition to
>    {REVOKED,DEAD};

I have a slight quetions. after parent event set EXIT,
Does EXIT event should be inherited?

for example

   parent task(0, ...) -> parent_event(0, parent_event:NULL)
     ` child_task(1, parent:0) -> child_event(1, parent_event:0)
         ` child_task(2, parent:1) -> child_event(2, parent_event:0)

In this case when parent task(0) is exited,
parent->event will be set as EXIT state.

But suppose the child_task(2) try to fork (child_task3) and
inherit the event (create child_event(3, parent_event:0),
and at the fork, forking can observe the parent event state as "EXIT".
In thie situation why child_event(3, parent_event:0) should be created for
child_task(3)?

>  - REVOKED means the PMU the event was associated with is gone; all
>    functionality is stopped but the event is still alive. Can only
>    transition to DEAD;
>
>  - DEAD event really is DYING tearing down state and freeing bits.
>
> And now we have the sitation that __perf_remove_from_context() can do:
>
>   {ACTIVE,INACTIVE,OFF,ERROR} -> {OFF,EXIT,REVOKED,DEAD}
>
> Where the {OFF,ERROR} -> * transition already have
> perf_cgroup_event_disable(), but the {ACTIVE,INACTIVE} -> * part has
> not.
>
> The condition:
>
>   if (event->state > PERF_EVENT_STATE_OFF)
>
> captures exactly that {ACTIVE,INACTIVE} that still needs the cgroup
> disable. Every other state is already a disabled state.
>
>
> Agreed?
>
> Also, I should probably stick most of all this in a comment somewhere.

--
Sincerely,
Yeoreum Yun
