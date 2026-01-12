Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8131A55F;
	Mon, 12 Jan 2026 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200560; cv=fail; b=XCaQ/+RPXbixrVbYv33ou4rY6ynpGaExvFYlpvR72Ko14roRx6uI9P2N6uAwld5TiK0/Dc9BO8bLcBOL7N2Y46du1mN2wYXnpq1sIl0CxrRbnoHpPlk6NqwGwNzhT55V/jgOtq9BEwvg3LS/JS/DuRbiC0+qFDg1tqycH8qnZOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200560; c=relaxed/simple;
	bh=ocqC+XoAlxLTBe9DdVw9EIH5rdtMdf+PuXT+oPvoK4Q=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=CrR90KBJDZbajngrqOcrj/J1vdLLaN2A4E9Ec7DFvB6SbAQEAcCeeHpuTTVzohpp7yGmYYSMPq39O/fSHXXmKAStuqEHtK9iHxgKltr5xPB6wCZWTQrVhTjsLqYevovlsqWY9XljXR2wcJel2owaFi4fX4p8VA36uESQo2CzEDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DKoyCseg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=odHwB3Zu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DKoyCseg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="odHwB3Zu"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C0o22W234566;
	Mon, 12 Jan 2026 06:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=X1m+XpkdSdFPCRIaVH
	9SHGqizEXJ049M6lPaqqPqyqo=; b=DKoyCsegtFOCt6Mt9xkhMtue0em09D2+oi
	xvnipcTDZ9taiggE032p/e6P/icjHJCy08VSqYa474x9Is/yR0opihFqyUu51Eau
	RQlq/saFTKySMiqBQOByZYtplrrMYjw8L4untRrnS4yYTD6L7axVJft4MGMpDCEH
	oAAu7vMRyhFXxnRfSFHWHraQsCXMkEJG5TMMngXR8QZHLJDk3OtRF29OV0JcKNur
	7LDfHxc6s7bIvTPDKkD3aJvoJhJcnbMf2NXvDPcq1ToNzjLLi+lOnfL1DnIdIEwN
	nkLePnTAMjnH/KpEXaSnif88PA9E7CGa77uWauHoE9kNpTPCaBrg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb15e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 06:48:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60C6i0dG004244;
	Mon, 12 Jan 2026 06:48:45 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7gtme5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 06:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRATvQJokwMp32GEruZsNXHAl3AiYlkAGlSyh1tg2G9v14yDgjD2nvpYI6eMhxjtBqyJ56be7ufbKcXcqEkVmOkXMtDJCKGQVf/+5oOFvIXeNxnxAOl1+PCpS0DiMLPgT+WH7Xrc/AnFH03IVgOWau2htVBipg+yJn51cQE4p6FoV4F9LHn5FvsrQjCGQA+A+/G6nVX0HyDnBcUFPXWpBsRY6JhkhjFWSc/mASob6rjFiTINEK4IZzwKc/PHgRnEXwKWBp/awwciRyhDbhOB3WgrBll55Jg+x6a7TGjhsbYMdje/6gQQdgpYlRnnebBz6+tLTxa/VoxT61fNuLsgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1m+XpkdSdFPCRIaVH9SHGqizEXJ049M6lPaqqPqyqo=;
 b=Ch81p/ri36yMyWA9AFEKVnLS38wtYKL7ntFE7T9xropUEkMUKTsS+aYZSj6wd58CAvpGWHx1DG9LreytyPRg3/zEBgw/RGmqBjz46XB5rA1vqMp+VqjAxvIIo0h3CeV33lc8Mqurb8wiXMqClALlPln6P/x4EWZGqXQC3ei8XaAA6ei/OZHrB8YPAZiL1wfsxYyJulP8MBRmFJ7iFLzYjz7wAtRNSO5wWmO6u2H3ltpSRGx+QQhSFkDzJlvU6voQpMjImAVNO3eJYc2H1eokRUyhlMcP7VRYCl/EvxhCEDdHoBg4BsiDQ0nP0KU3nTYxpiyBrd2RSmPjkqKO5ncWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1m+XpkdSdFPCRIaVH9SHGqizEXJ049M6lPaqqPqyqo=;
 b=odHwB3ZumBlWyNGO1biqVOi5zi3chOm3JsIUgbjR219shyC61RTgJbzBoXRdqYboreJdN6gu3INBjoLxbURQNGL5lsMxffmMHvP0RUbej2izTBDsDsCSImbGJqohr7aHcjj0VrP7BYyHHV0SCeBa0JLHJNaVzaNA4qfxgbRCWS0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7185.namprd10.prod.outlook.com (2603:10b6:610:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 06:48:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 06:48:40 +0000
References: <20251204214235.589865-1-irogers@google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
 <namhyung@kernel.org>,
        Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Paul
 Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Ankur Arora
 <ankur.a.arora@oracle.com>,
        Howard Chu <howardchu95@gmail.com>,
        Athira
 Rajeev <atrajeev@linux.vnet.ibm.com>,
        "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>,
        James Clark <james.clark@linaro.org>, Leo Yan
 <leo.yan@arm.com>,
        Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf: Make more global variables static
In-reply-to: <20251204214235.589865-1-irogers@google.com>
Date: Sun, 11 Jan 2026 22:48:37 -0800
Message-ID: <878qe3l41m.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0369.namprd04.prod.outlook.com
 (2603:10b6:303:81::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 5781f0da-293b-497c-86d0-08de51a69e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?todTa7GOQfJMCHV0Qvbtf7XBdIbhlYGF875x8F74d3y5V5KAv27sIzJmjSGz?=
 =?us-ascii?Q?U7tKzQOtvhijPoOdwjRZNo/maiVdG+akfqDMEa9xSEvrEfq/jjVfo/gwQ35P?=
 =?us-ascii?Q?5DmST/LViJ9Urm6wwP2eThX8H527jwt0BamPdoG379MMgFPo4Te/J/mDywcf?=
 =?us-ascii?Q?Bj5WAoUTClmYGgilUGJtwa65+DcrXYpERgSkm4gIxxAjXeoSiXmBv3pviXnX?=
 =?us-ascii?Q?R5RhRla0JagQGBC2ppV2r7LINACRsz1ENIAcVyYpyluCiofq0jQF/T9CL3Hs?=
 =?us-ascii?Q?Yie1rRbFs35z8tDEF3+2prXzarHUQeiI+WNxdIUAnnZrrTQr7BU7MnnT6UEq?=
 =?us-ascii?Q?zroka0qbXP61MQLUF1UKCWmVS7sS3/PWXLU54RoX0qQk4srTGZcd18MhHrgh?=
 =?us-ascii?Q?bG2KYjItQk0sWEBQr6UUoL5IE9AwiAiuADlLkxpJ/b6d0hzx4XkyEcXrXamL?=
 =?us-ascii?Q?v4X1WIAcdyU3CP6j8ggYbZM0HKWyPH/uBViwTVyJZRmezDwtODCTbf+2NMpL?=
 =?us-ascii?Q?6vneRRFnr9q/4t8lB5x0rAOLhF9zTS6hLXb2DFmFEUDzpSAdzjTM4IWb/YSp?=
 =?us-ascii?Q?5188eHxmIiYwmLvgKP6+zcN2XkfbN6ivXSSa1/n1YotD9J1Ad/zMj4tTBsP2?=
 =?us-ascii?Q?evTPCdtCEK2PL441fteFaOAkiJoCQCV0k2oGKcGP7DdodoMqOgOXMkwlNgDh?=
 =?us-ascii?Q?Zv2ym316yV+HOZa8GQZ7bZHYvZ3/pViVy1pkh3CJZOxsxX6wvp+EEBi+nZDU?=
 =?us-ascii?Q?MTeZI1STpag+tx35ebKUXCFJYleQfzlzG6DF+TL/jSzlYtHqXAnQXsqjX8ez?=
 =?us-ascii?Q?g4eUyfoHuxCKtd72wKGZcfX4Wg67IYqGyFnIzCYcBCTOJeooywx5Wkp7S0qG?=
 =?us-ascii?Q?Tzb2pGY8S8/DgZBC2iPhd1ukI5JNvGjXdaf8cs3EbdFucSoS/LpHJ4hEvba9?=
 =?us-ascii?Q?V4sVvb+j0KTZP9uCc2E3NJ3KEtlOzPEfZHz8IiUFGib/rqjOKuLNb24/FM8E?=
 =?us-ascii?Q?+Vqc0ZmUiQYtLUYiVJrGT5Nf4UtfXemEqXhkRHEdtroKxpwfr9RqgUIpLknI?=
 =?us-ascii?Q?yomuWFJ6ydUu5z4dJfLdd3MgZld/mBZmLj66H8KYKCnlD1+D+6/j6nUrvXzX?=
 =?us-ascii?Q?Mt3bpfKOpcbXA5RJok8fCyh6xbUx4hHJlwuJ7M7hu+WznriR30junaPrXJoy?=
 =?us-ascii?Q?pbpGc2uunkZXBkSpYlPX7mXDC0Ko/ALANgGV3TaFpvoZdtFc6V07cY3dQ1ps?=
 =?us-ascii?Q?1XZwhzuhMv69uPXhqtjQUc9pb2S+6S4BM0VQ/ZAJyz8Eog9LpWOR0EwDVbMa?=
 =?us-ascii?Q?TxBM8Jys66nBNGc+ycRKoHsTXX2mpWeD5J+mu/JdT7aJ4qLqNwSLnMEQxE++?=
 =?us-ascii?Q?CRH8Hu5BY1WongRoeCO/Zxv4PBKHCciqAPQXaGkOCVgX7zOBc9R6/jsTyKaG?=
 =?us-ascii?Q?jw5DjnMasqwCoioKXXVSeNFyvwKEQBu5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZEHy+AhS5wKXGDJ0AGOQ6/+tAR+NIdpGCQfQ7AgpITTQniqzS8eutnBXWczd?=
 =?us-ascii?Q?Pjnzh97+KN/q+7POa5F1kgfXCuYqFWCtp+Im+W22yrisyvo509xJ6Cfteqyx?=
 =?us-ascii?Q?KmRiHFiN5t+wx4oLp39rWWuuw8TM1VBXArHgmRgyrND4byObOH0cU7baUIaH?=
 =?us-ascii?Q?WfqZENLn9yDFrsirNOxBLgMXPdxPW8oumWHnCV9peaSdp3vc3Iu+ffnsdf2d?=
 =?us-ascii?Q?+SR4qpUvw/3cqC1VLbkLf1vLtxmLdVk70wrEINgr2WjIOOZ4TvSf5AAbA3dA?=
 =?us-ascii?Q?r8WHGAXgH9+qDcT3L4ujqIToMvrQVsRQbbZWjK5EbKFg//+487ZWKEmVtSw9?=
 =?us-ascii?Q?7NCls1jNbreSDCqkcrvZqUQ9pDWBZtVzmr43oj7G1/9HBmTXk9aQ7U5I7EHj?=
 =?us-ascii?Q?a2EUMUMhCRZsvEPNPPWWO4kJm6/tjtO9LEPftQUvlVHCRroERvs1BJBMfpd0?=
 =?us-ascii?Q?IQMA1Yo/vzamaGeld5FfZ1WLnEJ0y8Io6pF+4dgHsUUx9wjGEa6DolrZlnsW?=
 =?us-ascii?Q?pP/f8GkdNa77nNP3T3C4VQ7/a6WPFR1BG9DvPJf748nsMfQyRWkjOyG833vD?=
 =?us-ascii?Q?Wl/eZbhNMPpLExCUh36SGH0EpRyIrZUzIhYpcvQgHU33KENxaet4C4EUymzW?=
 =?us-ascii?Q?29zztxt5itJcRIJXv+L25LbmEOuxFRZ5tQIKv/Xk6Tz1XHRnxeuJlnDUAcuW?=
 =?us-ascii?Q?Go0DLlobFmCtFg93Pm/7yVj6IrgHxfPm6Gip4hck/5Vhk/+zoJmCO0oultod?=
 =?us-ascii?Q?AetcXUxA3HC40gsg2FCeKzzXutie8KUfw1Ov/n3ffW/L4Gks9mQl+YUD6kWB?=
 =?us-ascii?Q?T3vtxn2PfgiJomywIhAvQhzKYVsY4KjeLsh0w/6Mnr9IaJiWYg9vVkrjr5E0?=
 =?us-ascii?Q?0xT65GTCWZvdpLY+L1NjaBwHfz8bRurq12Uhi8ePc7H8gsIkNlZk8QcRR9iG?=
 =?us-ascii?Q?JQfvHyM+uaETCnTPBAKdXt0VqMaW03NAUcyEtAupyBvd596Uz211DmhO/rmi?=
 =?us-ascii?Q?MONl8UKhS+rJHekRDkkBz35zr5XIIsOBvJzkEh0/2aVxCeZi9civKmsv/uTU?=
 =?us-ascii?Q?6A9J9qUZ1ewEdDsScj7BVpNp5AM+wDu5rWDaI3dgt2wxx2Svr2rToH7+7jMj?=
 =?us-ascii?Q?W+0KHaKs3Yt/fkijcMLKRfXGuJ1qQATZjdjcX/AG0ygeC9+OFYhP4wenl8XY?=
 =?us-ascii?Q?kjvR2jN5bxYt9++xyAy7KBKSW599GCVmJVFx8FFBR7HXVsvsOsMx7iaN+D/g?=
 =?us-ascii?Q?86B0j1Nkolu7HJp7FtSc47NGpwxS3hlH5QWCboJm1aYAz7b9kPDwYmo2LbeX?=
 =?us-ascii?Q?Y8mJzyQLGq/krc+LDkpUwfh5ipDo3DBpd6d5wFl6uU1FzLftRMln5f8fJicL?=
 =?us-ascii?Q?pcIt10flTJ/b9tQyGPINS0OThzzIutCm+/JENdCBhq60tVejD5pOAl+Cxxoo?=
 =?us-ascii?Q?RHZ1VvalikarUp3OUBOH4MH3is2mX9U6+uutZxPpZ5rb+OvWlzaS0etcHnBI?=
 =?us-ascii?Q?n2c3RuZBl+oSM59aI4uoFV8ObIi4s7JqmMTeAP8rMzL0DqlMKA075dmBLaI/?=
 =?us-ascii?Q?aMsA5k7G2UPIqanI4Zi6kZlK6qi7+RL/2rSbHZrXCDQAI79R1slyy3EBfe4u?=
 =?us-ascii?Q?SckL9o0S3ZhL9n+2UJxunfMpJtReDGtZRxPQwaRUAGcvjVij/G/k51wPKabU?=
 =?us-ascii?Q?OFvGhiQBkTPSgu0x9jsOk6s6vnkNpoSOllwexcg/8R4QR5If1lwCN3LaZwS8?=
 =?us-ascii?Q?98e6WiVhP78Qx0FDZNje+IeYBACsrBo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W7YLjEU4FFthOeXVYrF2JlWhU4WuQtLQNAKNYvJNC+8BMBE9Hz9iGCq4Kw1YMfAf05eR3oulgI7YMkn04Voroio2KWB4S50K29OpnpoXHbRJipaqEy6eLUZvkNwtlrTSxgG2dYQU/jjpspSNgKDKZCyIUpkhIojD5I0aPiP7MgJqH0irA5ZOEKwQYlqC1l6cnyXGru36wlJz+pPaqpu50LbQ2DMrFo7NSkCcKaS4MZdKHxQmZKSWABPVrJG9//pHPt+rwCVm8+sh7sIWb43jSXAXC8HDWJw2QdUcdO6w/IDwAIxQUCj4gbtI8gk8VdvQstZ1lg/fitn5trC/uSNd42UQndjuLKsbp67d0XmbV8N8vzSyHLG3e+ixPewC+uuJ//tQ95YvzyBDsivJVkhNs6tvT6K4LXOacjT5vcAp5rfc12rnDS+fvkH+nnGFkWwFyg0Z5W2ApPjq3NrVPJbhcPBdidI0Z1veP9IL827U3pl+E++urU+k7Qti4VmKzExfFqW1gUMPJrGvSz35LP1V+4Xpqdpb270uF1JRMs91CWScettqAIJyM6x0RVaDwrsNPyf9W3Znc+GFoGkPhsmZjZtw+WNRHFJYJ82mowXeEBk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5781f0da-293b-497c-86d0-08de51a69e6c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 06:48:40.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lf6UT+UOnHLN+wnTdxxqCP7kRZ07wRHym55VHwPZw0t7AknIfBtbLbWqUimjEqmclT1BV6gPYPBBHtR98XRY7scP0ligEwe6apcExdtcU7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601120051
X-Proofpoint-GUID: p3jrc2LR_kiEq5-7mPZEZww7d4GJygLF
X-Proofpoint-ORIG-GUID: p3jrc2LR_kiEq5-7mPZEZww7d4GJygLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1MSBTYWx0ZWRfX6xaWAC0T/oQb
 lYQ0c3/X1MkyGbNU9hlXvKObhQZzk9LhA4Sa1i2E2TQaD9dx0l0rgHmFJy+IOsVAYuc0JcHRUFy
 TR6KP6spq+MFUBFkn1G5NtXzwE+NPEKTlIjYOwU2azosj6CGjEFYZXl/RggoYMA6Y1PXMGAeknh
 uT48IBeM4tA7X7Rs8xAA+YioIboZ7vxPyj18e4pfsnnD8/fNxfb3nDpx66l5aXZvrlWWy5lNJPz
 ojsBMGO/N1Gm6jF27RBe5bfIM4Ws4F9KJdvMSD+FSkaXIoHsbePxvb9uqgY4imsY00ZsUkeOpPK
 cHEBk+B5/9zuLmA7+VmSPOm6Dh9Za21mzE8SJJcd2LVUjEgpEPh9sHeTYiXDrMd4sncoX/AkWzH
 SePMZgYOIpGrGpuUe+rWSaBcspBRCjPfrJpiCivnU3nRyOwx6cc+f01OHD/JXqGF42kmW/7nunB
 jbjQ1qx/Kw6W5COS/5X8kMjcT/68jI9g6j1eAGqM=
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=6964994d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=QVmZUokEEKJmHpALEwwA:9 a=gAHPzpR5NItfR-hf:21 cc=ntf awl=host:12110


Ian Rogers <irogers@google.com> writes:

> `make check` will run sparse on the perf code base. A frequent warning
> is "warning: symbol '...' was not declared. Should it be static?" Go
> through and make global definitions without declarations static. In
> some cases it is deliberate due to dlsym accessing the symbol, this
> change doesn't clean up the missing declarations for perf test
> suites. Sometimes things can opportunistically be made const. Making
> somethings static exposed unused functions warnings, so restructuring
> of ifdefs was necessary for that. These changes reduce the size of the
> perf binary by 3,264 bytes.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

For perf/bench/mem-functions.c:
Acked-by: Ankur Arora <ankur.a.arora@oracle.com>

> ---
>  tools/perf/arch/common.c                      |  22 ++--
>  tools/perf/arch/sh/include/dwarf-regs-table.h |   2 +-
>  tools/perf/bench/breakpoint.c                 |   4 +-
>  tools/perf/bench/mem-functions.c              |   2 +-
>  tools/perf/bench/numa.c                       |   2 +-
>  tools/perf/bench/uprobe.c                     |   2 +-
>  tools/perf/builtin-c2c.c                      |   7 +-
>  tools/perf/builtin-config.c                   |   2 +-
>  tools/perf/builtin-data.c                     |   8 +-
>  tools/perf/builtin-diff.c                     |   4 +-
>  tools/perf/builtin-kmem.c                     |   2 +-
>  tools/perf/builtin-kwork.c                    |  12 +-
>  tools/perf/builtin-script.c                   |   2 +-
>  tools/perf/builtin-top.c                      |   5 +-
>  tools/perf/perf.c                             |   4 +-
>  tools/perf/tests/bp_signal.c                  |   2 +-
>  tools/perf/tests/dso-data.c                   |   2 +-
>  tools/perf/tests/wp.c                         |   6 +-
>  tools/perf/util/block-range.c                 |   2 +-
>  tools/perf/util/bpf_counter.c                 |   4 +-
>  tools/perf/util/bpf_off_cpu.c                 |   2 +-
>  tools/perf/util/debug.c                       |   2 +-
>  tools/perf/util/debuginfo.c                   |  19 ++--
>  tools/perf/util/dwarf-regs-csky.c             |   4 +-
>  tools/perf/util/sort.c                        | 104 +++++++++---------
>  tools/perf/util/trace-event-scripting.c       |  98 +++++++++--------
>  tools/perf/util/util.c                        |   2 -
>  27 files changed, 163 insertions(+), 164 deletions(-)
>
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 4908d54dd33b..21836f70f231 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -9,14 +9,14 @@
>  #include "../util/debug.h"
>  #include <linux/zalloc.h>
>
> -const char *const arc_triplets[] = {
> +static const char *const arc_triplets[] = {
>  	"arc-linux-",
>  	"arc-snps-linux-uclibc-",
>  	"arc-snps-linux-gnu-",
>  	NULL
>  };
>
> -const char *const arm_triplets[] = {
> +static const char *const arm_triplets[] = {
>  	"arm-eabi-",
>  	"arm-linux-androideabi-",
>  	"arm-unknown-linux-",
> @@ -28,13 +28,13 @@ const char *const arm_triplets[] = {
>  	NULL
>  };
>
> -const char *const arm64_triplets[] = {
> +static const char *const arm64_triplets[] = {
>  	"aarch64-linux-android-",
>  	"aarch64-linux-gnu-",
>  	NULL
>  };
>
> -const char *const powerpc_triplets[] = {
> +static const char *const powerpc_triplets[] = {
>  	"powerpc-unknown-linux-gnu-",
>  	"powerpc-linux-gnu-",
>  	"powerpc64-unknown-linux-gnu-",
> @@ -43,40 +43,40 @@ const char *const powerpc_triplets[] = {
>  	NULL
>  };
>
> -const char *const riscv32_triplets[] = {
> +static const char *const riscv32_triplets[] = {
>  	"riscv32-unknown-linux-gnu-",
>  	"riscv32-linux-android-",
>  	"riscv32-linux-gnu-",
>  	NULL
>  };
>
> -const char *const riscv64_triplets[] = {
> +static const char *const riscv64_triplets[] = {
>  	"riscv64-unknown-linux-gnu-",
>  	"riscv64-linux-android-",
>  	"riscv64-linux-gnu-",
>  	NULL
>  };
>
> -const char *const s390_triplets[] = {
> +static const char *const s390_triplets[] = {
>  	"s390-ibm-linux-",
>  	"s390x-linux-gnu-",
>  	NULL
>  };
>
> -const char *const sh_triplets[] = {
> +static const char *const sh_triplets[] = {
>  	"sh-unknown-linux-gnu-",
>  	"sh-linux-gnu-",
>  	NULL
>  };
>
> -const char *const sparc_triplets[] = {
> +static const char *const sparc_triplets[] = {
>  	"sparc-unknown-linux-gnu-",
>  	"sparc64-unknown-linux-gnu-",
>  	"sparc64-linux-gnu-",
>  	NULL
>  };
>
> -const char *const x86_triplets[] = {
> +static const char *const x86_triplets[] = {
>  	"x86_64-pc-linux-gnu-",
>  	"x86_64-unknown-linux-gnu-",
>  	"i686-pc-linux-gnu-",
> @@ -90,7 +90,7 @@ const char *const x86_triplets[] = {
>  	NULL
>  };
>
> -const char *const mips_triplets[] = {
> +static const char *const mips_triplets[] = {
>  	"mips-unknown-linux-gnu-",
>  	"mipsel-linux-android-",
>  	"mips-linux-gnu-",
> diff --git a/tools/perf/arch/sh/include/dwarf-regs-table.h b/tools/perf/arch/sh/include/dwarf-regs-table.h
> index 900e69619970..b5974a090fb4 100644
> --- a/tools/perf/arch/sh/include/dwarf-regs-table.h
> +++ b/tools/perf/arch/sh/include/dwarf-regs-table.h
> @@ -2,7 +2,7 @@
>  #ifdef DEFINE_DWARF_REGSTR_TABLE
>  /* This is included in perf/util/dwarf-regs.c */
>
> -const char * const sh_regstr_tbl[] = {
> +static const char * const sh_regstr_tbl[] = {
>  	"r0",
>  	"r1",
>  	"r2",
> diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.c
> index dfd18f5db97d..1b7cd4481bd2 100644
> --- a/tools/perf/bench/breakpoint.c
> +++ b/tools/perf/bench/breakpoint.c
> @@ -16,7 +16,7 @@
>  #include "bench.h"
>  #include "futex.h"
>
> -struct {
> +static struct {
>  	unsigned int nbreakpoints;
>  	unsigned int nparallel;
>  	unsigned int nthreads;
> @@ -173,7 +173,7 @@ int bench_breakpoint_thread(int argc, const char **argv)
>  	return 0;
>  }
>
> -struct {
> +static struct {
>  	unsigned int npassive;
>  	unsigned int nactive;
>  } enable_params = {
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 2908a3a796c9..c1a84be1c50b 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -388,7 +388,7 @@ static void mem_free(struct bench_mem_info *info __maybe_unused,
>  	*dst = *src = NULL;
>  }
>
> -struct function memcpy_functions[] = {
> +static struct function memcpy_functions[] = {
>  	{ .name		= "default",
>  	  .desc		= "Default memcpy() provided by glibc",
>  	  .fn.init	= mem_alloc,
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 19be2aaf4dc0..6588a9b0b15a 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -166,7 +166,7 @@ static struct global_info	*g = NULL;
>  static int parse_cpus_opt(const struct option *opt, const char *arg, int unset);
>  static int parse_nodes_opt(const struct option *opt, const char *arg, int unset);
>
> -struct params p0;
> +static struct params p0;
>
>  static const struct option options[] = {
>  	OPT_INTEGER('p', "nr_proc"	, &p0.nr_proc,		"number of processes"),
> diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
> index 0b90275862e1..99c3f9d2f28d 100644
> --- a/tools/perf/bench/uprobe.c
> +++ b/tools/perf/bench/uprobe.c
> @@ -58,7 +58,7 @@ static const char * const bench_uprobe_usage[] = {
>  		goto cleanup; \
>  	}
>
> -struct bench_uprobe_bpf *skel;
> +static struct bench_uprobe_bpf *skel;
>
>  static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
>  {
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 14c3823f8fed..348c69224a91 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2900,9 +2900,10 @@ static int ui_quirks(void)
>
>  #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
>
> -const char callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
> -				CALLCHAIN_REPORT_HELP
> -				"\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
> +static const char callchain_help[] =
> +	"Display call graph (stack chain/backtrace):\n\n"
> +	CALLCHAIN_REPORT_HELP
> +	"\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
>
>  static int
>  parse_callchain_opt(const struct option *opt, const char *arg, int unset)
> diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
> index 45b5312fbe83..237600643bbd 100644
> --- a/tools/perf/builtin-config.c
> +++ b/tools/perf/builtin-config.c
> @@ -23,7 +23,7 @@ static const char * const config_usage[] = {
>  	NULL
>  };
>
> -enum actions {
> +static enum actions {
>  	ACTION_LIST = 1
>  } actions;
>
> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index ce51cbf6dc97..638b67f7c1d8 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
> @@ -28,14 +28,14 @@ static const char *data_usage[] = {
>  	NULL
>  };
>
> -const char *to_json;
> -const char *to_ctf;
> -struct perf_data_convert_opts opts = {
> +static const char *to_json;
> +static const char *to_ctf;
> +static struct perf_data_convert_opts opts = {
>  	.force = false,
>  	.all = false,
>  };
>
> -const struct option data_options[] = {
> +static const struct option data_options[] = {
>  		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>  		OPT_STRING('i', "input", &input_name, "file", "input file name"),
>  		OPT_STRING(0, "to-json", &to_json, NULL, "Convert to JSON format"),
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 53d5ea4a6a4f..41a40d94b053 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -113,7 +113,7 @@ enum {
>  	COMPUTE_STREAM,	/* After COMPUTE_MAX to avoid use current compute arrays */
>  };
>
> -const char *compute_names[COMPUTE_MAX] = {
> +static const char *compute_names[COMPUTE_MAX] = {
>  	[COMPUTE_DELTA] = "delta",
>  	[COMPUTE_DELTA_ABS] = "delta-abs",
>  	[COMPUTE_RATIO] = "ratio",
> @@ -384,7 +384,7 @@ static void block_hist_free(void *he)
>  	free(bh);
>  }
>
> -struct hist_entry_ops block_hist_ops = {
> +static struct hist_entry_ops block_hist_ops = {
>  	.new    = block_hist_zalloc,
>  	.free   = block_hist_free,
>  };
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 7929a5fa5f46..9c64a0d74823 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -82,7 +82,7 @@ static unsigned long nr_allocs, nr_cross_allocs;
>
>  /* filters for controlling start and stop of time of analysis */
>  static struct perf_time_interval ptime;
> -const char *time_str;
> +static const char *time_str;
>
>  static int insert_alloc_stat(unsigned long call_site, unsigned long ptr,
>  			     int bytes_req, int bytes_alloc, int cpu)
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 7f3068264568..97be06ba3ad9 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -985,7 +985,7 @@ static int process_irq_handler_exit_event(const struct perf_tool *tool,
>  	return 0;
>  }
>
> -const struct evsel_str_handler irq_tp_handlers[] = {
> +static const struct evsel_str_handler irq_tp_handlers[] = {
>  	{ "irq:irq_handler_entry", process_irq_handler_entry_event, },
>  	{ "irq:irq_handler_exit",  process_irq_handler_exit_event,  },
>  };
> @@ -1080,7 +1080,7 @@ static int process_softirq_exit_event(const struct perf_tool *tool,
>  	return 0;
>  }
>
> -const struct evsel_str_handler softirq_tp_handlers[] = {
> +static const struct evsel_str_handler softirq_tp_handlers[] = {
>  	{ "irq:softirq_raise", process_softirq_raise_event, },
>  	{ "irq:softirq_entry", process_softirq_entry_event, },
>  	{ "irq:softirq_exit",  process_softirq_exit_event,  },
> @@ -1211,7 +1211,7 @@ static int process_workqueue_execute_end_event(const struct perf_tool *tool,
>  	return 0;
>  }
>
> -const struct evsel_str_handler workqueue_tp_handlers[] = {
> +static const struct evsel_str_handler workqueue_tp_handlers[] = {
>  	{ "workqueue:workqueue_activate_work", process_workqueue_activate_work_event, },
>  	{ "workqueue:workqueue_execute_start", process_workqueue_execute_start_event, },
>  	{ "workqueue:workqueue_execute_end",   process_workqueue_execute_end_event,   },
> @@ -1281,7 +1281,7 @@ static int process_sched_switch_event(const struct perf_tool *tool,
>  	return 0;
>  }
>
> -const struct evsel_str_handler sched_tp_handlers[] = {
> +static const struct evsel_str_handler sched_tp_handlers[] = {
>  	{ "sched:sched_switch",  process_sched_switch_event, },
>  };
>
> @@ -1561,13 +1561,13 @@ static void print_bad_events(struct perf_kwork *kwork)
>  	}
>  }
>
> -const char *graph_load = "||||||||||||||||||||||||||||||||||||||||||||||||";
> -const char *graph_idle = "                                                ";
>  static void top_print_per_cpu_load(struct perf_kwork *kwork)
>  {
>  	int i, load_width;
>  	u64 total, load, load_ratio;
>  	struct kwork_top_stat *stat = &kwork->top_stat;
> +	const char *graph_load = "||||||||||||||||||||||||||||||||||||||||||||||||";
> +	const char *graph_idle = "                                                ";
>
>  	for (i = 0; i < MAX_NR_CPUS; i++) {
>  		total = stat->cpus_runtime[i].total;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 62e43d3c5ad7..6b7985121ec9 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -168,7 +168,7 @@ struct perf_script {
>  	int			range_num;
>  };
>
> -struct output_option {
> +static struct output_option {
>  	const char *str;
>  	enum perf_output_field field;
>  } all_output_options[] = {
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 710604c4f6f6..0628e5f2023c 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1437,11 +1437,10 @@ parse_percent_limit(const struct option *opt, const char *arg,
>  	return 0;
>  }
>
> -const char top_callchain_help[] = CALLCHAIN_RECORD_HELP CALLCHAIN_REPORT_HELP
> -	"\n\t\t\t\tDefault: fp,graph,0.5,caller,function";
> -
>  int cmd_top(int argc, const char **argv)
>  {
> +	const char top_callchain_help[] = CALLCHAIN_RECORD_HELP CALLCHAIN_REPORT_HELP
> +		"\n\t\t\t\tDefault: fp,graph,0.5,caller,function";
>  	char errbuf[BUFSIZ];
>  	struct perf_top top = {
>  		.count_filter	     = 5,
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 88c60ecf3395..318455d7b4d4 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -178,7 +178,7 @@ static int set_debug_file(const char *path)
>  	return 0;
>  }
>
> -struct option options[] = {
> +static const struct option options[] = {
>  	OPT_ARGUMENT("help", "help"),
>  	OPT_ARGUMENT("version", "version"),
>  	OPT_ARGUMENT("exec-path", "exec-path"),
> @@ -289,7 +289,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			unsigned int i;
>
>  			for (i = 0; i < ARRAY_SIZE(options)-1; i++) {
> -				struct option *p = options+i;
> +				const struct option *p = options+i;
>  				printf("--%s ", p->long_name);
>  			}
>  			putchar('\n');
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index 3faeb5b6fe0b..f580ba7486b1 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -36,7 +36,7 @@ static int fd3;
>  static int overflows;
>  static int overflows_2;
>
> -volatile long the_var;
> +static volatile long the_var;
>
>
>  /*
> diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> index a1fff4203b75..46bc3f597260 100644
> --- a/tools/perf/tests/dso-data.c
> +++ b/tools/perf/tests/dso-data.c
> @@ -58,7 +58,7 @@ struct test_data_offset {
>  	int size;
>  };
>
> -struct test_data_offset offsets[] = {
> +static struct test_data_offset offsets[] = {
>  	/* Fill first cache page. */
>  	{
>  		.offset = 10,
> diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> index 6c178985e37f..69b31f00eed0 100644
> --- a/tools/perf/tests/wp.c
> +++ b/tools/perf/tests/wp.c
> @@ -22,11 +22,11 @@ do {                                            \
>
>  #ifdef __i386__
>  /* Only breakpoint length less-than 8 has hardware support on i386. */
> -volatile u32 data1;
> +static volatile u32 data1;
>  #else
> -volatile u64 data1;
> +static volatile u64 data1;
>  #endif
> -volatile u8 data2[3];
> +static volatile u8 data2[3];
>
>  #ifndef __s390x__
>  static int wp_read(int fd, long long *count, int size)
> diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
> index 15c42196c24c..7c559fcfd7e0 100644
> --- a/tools/perf/util/block-range.c
> +++ b/tools/perf/util/block-range.c
> @@ -4,7 +4,7 @@
>  #include <assert.h>
>  #include <stdlib.h>
>
> -struct {
> +static struct {
>  	struct rb_root root;
>  	u64 blocks;
>  } block_ranges;
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index a5882b582205..32455dc42498 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -351,7 +351,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx
>  	return 0;
>  }
>
> -struct bpf_counter_ops bpf_program_profiler_ops = {
> +static struct bpf_counter_ops bpf_program_profiler_ops = {
>  	.load       = bpf_program_profiler__load,
>  	.enable	    = bpf_program_profiler__enable,
>  	.disable    = bpf_program_profiler__disable,
> @@ -831,7 +831,7 @@ static int bperf__destroy(struct evsel *evsel)
>   * the leader prog.
>   */
>
> -struct bpf_counter_ops bperf_ops = {
> +static struct bpf_counter_ops bperf_ops = {
>  	.load       = bperf__load,
>  	.enable     = bperf__enable,
>  	.disable    = bperf__disable,
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index 88e0660c4bff..eaff3c0bd9dd 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -39,7 +39,7 @@ union off_cpu_data {
>  	u64 array[1024 / sizeof(u64)];
>  };
>
> -u64 off_cpu_raw[MAX_STACKS + 5];
> +static u64 off_cpu_raw[MAX_STACKS + 5];
>
>  static int off_cpu_config(struct evlist *evlist)
>  {
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index 1dfa4d0eec4d..6b5ffe81f141 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -48,7 +48,7 @@ int debug_ordered_events;
>  static int redirect_to_stderr;
>  int debug_data_convert;
>  static FILE *_debug_file;
> -bool debug_display_time;
> +static bool debug_display_time;
>  int debug_type_profile;
>
>  FILE *debug_file(void)
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 4a559b3e8cdc..8b819dea36ac 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -88,18 +88,17 @@ static struct debuginfo *__debuginfo__new(const char *path)
>  	return dbg;
>  }
>
> -enum dso_binary_type distro_dwarf_types[] = {
> -	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
> -	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
> -	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> -	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
> -	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
> -	DSO_BINARY_TYPE__NOT_FOUND,
> -};
> -
>  struct debuginfo *debuginfo__new(const char *path)
>  {
> -	enum dso_binary_type *type;
> +	const enum dso_binary_type distro_dwarf_types[] = {
> +		DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
> +		DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
> +		DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> +		DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
> +		DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
> +		DSO_BINARY_TYPE__NOT_FOUND,
> +	};
> +	const enum dso_binary_type *type;
>  	char buf[PATH_MAX], nil = '\0';
>  	struct dso *dso;
>  	struct debuginfo *dinfo = NULL;
> diff --git a/tools/perf/util/dwarf-regs-csky.c b/tools/perf/util/dwarf-regs-csky.c
> index d38ef1f07f3e..f6645cf770db 100644
> --- a/tools/perf/util/dwarf-regs-csky.c
> +++ b/tools/perf/util/dwarf-regs-csky.c
> @@ -6,7 +6,7 @@
>  #include <dwarf-regs.h>
>
>  #define CSKY_ABIV2_MAX_REGS 73
> -const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
> +static const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
>  	/* r0 ~ r8 */
>  	"%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1", "%regs2", "%regs3",
>  	/* r9 ~ r15 */
> @@ -27,7 +27,7 @@ const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
>  };
>
>  #define CSKY_ABIV1_MAX_REGS 57
> -const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] = {
> +static const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] = {
>  	/* r0 ~ r8 */
>  	"%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
>  	/* r9 ~ r15 */
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f3a565b0e230..2fa2b11c655c 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -42,11 +42,11 @@ regex_t		parent_regex;
>  const char	default_parent_pattern[] = "^sys_|^do_page_fault";
>  const char	*parent_pattern = default_parent_pattern;
>  const char	*default_sort_order = "comm,dso,symbol";
> -const char	default_branch_sort_order[] = "comm,dso_from,symbol_from,symbol_to,cycles";
> +static const char	default_branch_sort_order[] = "comm,dso_from,symbol_from,symbol_to,cycles";
>  const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat,local_p_stage_cyc";
> -const char	default_top_sort_order[] = "dso,symbol";
> -const char	default_diff_sort_order[] = "dso,symbol";
> -const char	default_tracepoint_sort_order[] = "trace";
> +static const char	default_top_sort_order[] = "dso,symbol";
> +static const char	default_diff_sort_order[] = "dso,symbol";
> +static const char	default_tracepoint_sort_order[] = "trace";
>  const char	*sort_order;
>  const char	*field_order;
>  regex_t		ignore_callees_regex;
> @@ -171,7 +171,7 @@ static int hist_entry__tgid_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%7d:%-*.*s", tgid, width, width, comm ?: "");
>  }
>
> -struct sort_entry sort_tgid = {
> +static struct sort_entry sort_tgid = {
>  	.se_header	= "   Tgid:Command",
>  	.se_cmp		= sort__tgid_cmp,
>  	.se_snprintf	= hist_entry__tgid_snprintf,
> @@ -217,7 +217,7 @@ static int hist_entry__simd_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "[.] %s", name);
>  }
>
> -struct sort_entry sort_simd = {
> +static struct sort_entry sort_simd = {
>  	.se_header	= "Simd   ",
>  	.se_cmp		= sort__simd_cmp,
>  	.se_snprintf	= hist_entry__simd_snprintf,
> @@ -494,7 +494,7 @@ hist_entry__symoff_snprintf(struct hist_entry *he, char *bf, size_t size, unsign
>  	return repsep_snprintf(bf, size, "[%c] %s+0x%llx", he->level, sym->name, he->ip - sym->start);
>  }
>
> -struct sort_entry sort_sym_offset = {
> +static struct sort_entry sort_sym_offset = {
>  	.se_header	= "Symbol Offset",
>  	.se_cmp		= sort__symoff_cmp,
>  	.se_sort	= sort__symoff_sort,
> @@ -605,7 +605,7 @@ static int hist_entry__srcline_from_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-*.*s", width, width, he->branch_info->srcline_from);
>  }
>
> -struct sort_entry sort_srcline_from = {
> +static struct sort_entry sort_srcline_from = {
>  	.se_header	= "From Source:Line",
>  	.se_cmp		= sort__srcline_from_cmp,
>  	.se_collapse	= sort__srcline_from_collapse,
> @@ -653,7 +653,7 @@ static int hist_entry__srcline_to_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-*.*s", width, width, he->branch_info->srcline_to);
>  }
>
> -struct sort_entry sort_srcline_to = {
> +static struct sort_entry sort_srcline_to = {
>  	.se_header	= "To Source:Line",
>  	.se_cmp		= sort__srcline_to_cmp,
>  	.se_collapse	= sort__srcline_to_collapse,
> @@ -689,7 +689,7 @@ static int hist_entry__sym_ipc_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-*s", width, tmp);
>  }
>
> -struct sort_entry sort_sym_ipc = {
> +static struct sort_entry sort_sym_ipc = {
>  	.se_header	= "IPC   [IPC Coverage]",
>  	.se_cmp		= sort__sym_cmp,
>  	.se_snprintf	= hist_entry__sym_ipc_snprintf,
> @@ -707,7 +707,7 @@ static int hist_entry__sym_ipc_null_snprintf(struct hist_entry *he
>  	return repsep_snprintf(bf, size, "%-*s", width, tmp);
>  }
>
> -struct sort_entry sort_sym_ipc_null = {
> +static struct sort_entry sort_sym_ipc_null = {
>  	.se_header	= "IPC   [IPC Coverage]",
>  	.se_cmp		= sort__sym_cmp,
>  	.se_snprintf	= hist_entry__sym_ipc_null_snprintf,
> @@ -740,7 +740,7 @@ static int hist_entry__callchain_branch_predicted_snprintf(
>  	return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
>  }
>
> -struct sort_entry sort_callchain_branch_predicted = {
> +static struct sort_entry sort_callchain_branch_predicted = {
>  	.se_header	= "Predicted",
>  	.se_cmp		= sort__callchain_branch_predicted_cmp,
>  	.se_snprintf	= hist_entry__callchain_branch_predicted_snprintf,
> @@ -770,7 +770,7 @@ static int hist_entry__callchain_branch_abort_snprintf(struct hist_entry *he,
>  	return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
>  }
>
> -struct sort_entry sort_callchain_branch_abort = {
> +static struct sort_entry sort_callchain_branch_abort = {
>  	.se_header	= "Abort",
>  	.se_cmp		= sort__callchain_branch_abort_cmp,
>  	.se_snprintf	= hist_entry__callchain_branch_abort_snprintf,
> @@ -803,7 +803,7 @@ static int hist_entry__callchain_branch_cycles_snprintf(struct hist_entry *he,
>  	return repsep_snprintf(bf, size, "%-*.*s", width, width, str);
>  }
>
> -struct sort_entry sort_callchain_branch_cycles = {
> +static struct sort_entry sort_callchain_branch_cycles = {
>  	.se_header	= "Cycles",
>  	.se_cmp		= sort__callchain_branch_cycles_cmp,
>  	.se_snprintf	= hist_entry__callchain_branch_cycles_snprintf,
> @@ -870,7 +870,7 @@ static int hist_entry__srcfile_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-.*s", width, he->srcfile);
>  }
>
> -struct sort_entry sort_srcfile = {
> +static struct sort_entry sort_srcfile = {
>  	.se_header	= "Source File",
>  	.se_cmp		= sort__srcfile_cmp,
>  	.se_collapse	= sort__srcfile_collapse,
> @@ -922,7 +922,7 @@ static int hist_entry__cpu_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%*.*d", width, width, he->cpu);
>  }
>
> -struct sort_entry sort_cpu = {
> +static struct sort_entry sort_cpu = {
>  	.se_header      = "CPU",
>  	.se_cmp	        = sort__cpu_cmp,
>  	.se_snprintf    = hist_entry__cpu_snprintf,
> @@ -953,7 +953,7 @@ static int hist_entry__parallelism_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%*d", width, he->parallelism);
>  }
>
> -struct sort_entry sort_parallelism = {
> +static struct sort_entry sort_parallelism = {
>  	.se_header      = "Parallelism",
>  	.se_cmp	        = sort__parallelism_cmp,
>  	.se_filter	= hist_entry__parallelism_filter,
> @@ -994,7 +994,7 @@ static int hist_entry__cgroup_id_snprintf(struct hist_entry *he,
>  			       he->cgroup_id.ino);
>  }
>
> -struct sort_entry sort_cgroup_id = {
> +static struct sort_entry sort_cgroup_id = {
>  	.se_header      = "cgroup id (dev/inode)",
>  	.se_cmp	        = sort__cgroup_id_cmp,
>  	.se_snprintf    = hist_entry__cgroup_id_snprintf,
> @@ -1027,7 +1027,7 @@ static int hist_entry__cgroup_snprintf(struct hist_entry *he,
>  	return repsep_snprintf(bf, size, "%s", cgrp_name);
>  }
>
> -struct sort_entry sort_cgroup = {
> +static struct sort_entry sort_cgroup = {
>  	.se_header      = "Cgroup",
>  	.se_cmp	        = sort__cgroup_cmp,
>  	.se_snprintf    = hist_entry__cgroup_snprintf,
> @@ -1058,7 +1058,7 @@ static int hist_entry__socket_filter(struct hist_entry *he, int type, const void
>  	return sk >= 0 && he->socket != sk;
>  }
>
> -struct sort_entry sort_socket = {
> +static struct sort_entry sort_socket = {
>  	.se_header      = "Socket",
>  	.se_cmp	        = sort__socket_cmp,
>  	.se_snprintf    = hist_entry__socket_snprintf,
> @@ -1089,7 +1089,7 @@ static int hist_entry__time_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-.*s", width, he_time);
>  }
>
> -struct sort_entry sort_time = {
> +static struct sort_entry sort_time = {
>  	.se_header      = "Time",
>  	.se_cmp	        = sort__time_cmp,
>  	.se_snprintf    = hist_entry__time_snprintf,
> @@ -1158,7 +1158,7 @@ static int hist_entry__trace_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-.*s", width, he->trace_output);
>  }
>
> -struct sort_entry sort_trace = {
> +static struct sort_entry sort_trace = {
>  	.se_header      = "Trace output",
>  	.se_cmp	        = sort__trace_cmp,
>  	.se_snprintf    = hist_entry__trace_snprintf,
> @@ -1453,7 +1453,7 @@ sort__addr_to_cmp(struct hist_entry *left, struct hist_entry *right)
>  	return _sort__addr_cmp(to_l->addr, to_r->addr);
>  }
>
> -struct sort_entry sort_addr_from = {
> +static struct sort_entry sort_addr_from = {
>  	.se_header	= "Source Address",
>  	.se_cmp		= sort__addr_from_cmp,
>  	.se_snprintf	= hist_entry__addr_from_snprintf,
> @@ -1461,7 +1461,7 @@ struct sort_entry sort_addr_from = {
>  	.se_width_idx	= HISTC_ADDR_FROM,
>  };
>
> -struct sort_entry sort_addr_to = {
> +static struct sort_entry sort_addr_to = {
>  	.se_header	= "Target Address",
>  	.se_cmp		= sort__addr_to_cmp,
>  	.se_snprintf	= hist_entry__addr_to_snprintf,
> @@ -1518,7 +1518,7 @@ static int hist_entry__cycles_snprintf(struct hist_entry *he, char *bf,
>  			       he->branch_info->flags.cycles);
>  }
>
> -struct sort_entry sort_cycles = {
> +static struct sort_entry sort_cycles = {
>  	.se_header	= "Basic Block Cycles",
>  	.se_cmp		= sort__cycles_cmp,
>  	.se_snprintf	= hist_entry__cycles_snprintf,
> @@ -1808,7 +1808,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
>  	return _hist_entry__sym_snprintf(ms, addr, level, bf, size, width);
>  }
>
> -struct sort_entry sort_mispredict = {
> +static struct sort_entry sort_mispredict = {
>  	.se_header	= "Branch Mispredicted",
>  	.se_cmp		= sort__mispredict_cmp,
>  	.se_snprintf	= hist_entry__mispredict_snprintf,
> @@ -1827,7 +1827,7 @@ static int hist_entry__local_weight_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-*llu", width, he->weight);
>  }
>
> -struct sort_entry sort_local_weight = {
> +static struct sort_entry sort_local_weight = {
>  	.se_header	= "Local Weight",
>  	.se_cmp		= sort__weight_cmp,
>  	.se_snprintf	= hist_entry__local_weight_snprintf,
> @@ -1841,7 +1841,7 @@ static int hist_entry__global_weight_snprintf(struct hist_entry *he, char *bf,
>  			       he->weight * he->stat.nr_events);
>  }
>
> -struct sort_entry sort_global_weight = {
> +static struct sort_entry sort_global_weight = {
>  	.se_header	= "Weight",
>  	.se_cmp		= sort__weight_cmp,
>  	.se_snprintf	= hist_entry__global_weight_snprintf,
> @@ -1860,7 +1860,7 @@ static int hist_entry__local_ins_lat_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-*u", width, he->ins_lat);
>  }
>
> -struct sort_entry sort_local_ins_lat = {
> +static struct sort_entry sort_local_ins_lat = {
>  	.se_header	= "Local INSTR Latency",
>  	.se_cmp		= sort__ins_lat_cmp,
>  	.se_snprintf	= hist_entry__local_ins_lat_snprintf,
> @@ -1874,7 +1874,7 @@ static int hist_entry__global_ins_lat_snprintf(struct hist_entry *he, char *bf,
>  			       he->ins_lat * he->stat.nr_events);
>  }
>
> -struct sort_entry sort_global_ins_lat = {
> +static struct sort_entry sort_global_ins_lat = {
>  	.se_header	= "INSTR Latency",
>  	.se_cmp		= sort__ins_lat_cmp,
>  	.se_snprintf	= hist_entry__global_ins_lat_snprintf,
> @@ -1900,70 +1900,70 @@ static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-*u", width, he->weight3);
>  }
>
> -struct sort_entry sort_local_p_stage_cyc = {
> +static struct sort_entry sort_local_p_stage_cyc = {
>  	.se_header      = "Local Pipeline Stage Cycle",
>  	.se_cmp         = sort__p_stage_cyc_cmp,
>  	.se_snprintf	= hist_entry__p_stage_cyc_snprintf,
>  	.se_width_idx	= HISTC_LOCAL_P_STAGE_CYC,
>  };
>
> -struct sort_entry sort_global_p_stage_cyc = {
> +static struct sort_entry sort_global_p_stage_cyc = {
>  	.se_header      = "Pipeline Stage Cycle",
>  	.se_cmp         = sort__p_stage_cyc_cmp,
>  	.se_snprintf    = hist_entry__global_p_stage_cyc_snprintf,
>  	.se_width_idx   = HISTC_GLOBAL_P_STAGE_CYC,
>  };
>
> -struct sort_entry sort_mem_daddr_sym = {
> +static struct sort_entry sort_mem_daddr_sym = {
>  	.se_header	= "Data Symbol",
>  	.se_cmp		= sort__daddr_cmp,
>  	.se_snprintf	= hist_entry__daddr_snprintf,
>  	.se_width_idx	= HISTC_MEM_DADDR_SYMBOL,
>  };
>
> -struct sort_entry sort_mem_iaddr_sym = {
> +static struct sort_entry sort_mem_iaddr_sym = {
>  	.se_header	= "Code Symbol",
>  	.se_cmp		= sort__iaddr_cmp,
>  	.se_snprintf	= hist_entry__iaddr_snprintf,
>  	.se_width_idx	= HISTC_MEM_IADDR_SYMBOL,
>  };
>
> -struct sort_entry sort_mem_daddr_dso = {
> +static struct sort_entry sort_mem_daddr_dso = {
>  	.se_header	= "Data Object",
>  	.se_cmp		= sort__dso_daddr_cmp,
>  	.se_snprintf	= hist_entry__dso_daddr_snprintf,
>  	.se_width_idx	= HISTC_MEM_DADDR_DSO,
>  };
>
> -struct sort_entry sort_mem_locked = {
> +static struct sort_entry sort_mem_locked = {
>  	.se_header	= "Locked",
>  	.se_cmp		= sort__locked_cmp,
>  	.se_snprintf	= hist_entry__locked_snprintf,
>  	.se_width_idx	= HISTC_MEM_LOCKED,
>  };
>
> -struct sort_entry sort_mem_tlb = {
> +static struct sort_entry sort_mem_tlb = {
>  	.se_header	= "TLB access",
>  	.se_cmp		= sort__tlb_cmp,
>  	.se_snprintf	= hist_entry__tlb_snprintf,
>  	.se_width_idx	= HISTC_MEM_TLB,
>  };
>
> -struct sort_entry sort_mem_lvl = {
> +static struct sort_entry sort_mem_lvl = {
>  	.se_header	= "Memory access",
>  	.se_cmp		= sort__lvl_cmp,
>  	.se_snprintf	= hist_entry__lvl_snprintf,
>  	.se_width_idx	= HISTC_MEM_LVL,
>  };
>
> -struct sort_entry sort_mem_snoop = {
> +static struct sort_entry sort_mem_snoop = {
>  	.se_header	= "Snoop",
>  	.se_cmp		= sort__snoop_cmp,
>  	.se_snprintf	= hist_entry__snoop_snprintf,
>  	.se_width_idx	= HISTC_MEM_SNOOP,
>  };
>
> -struct sort_entry sort_mem_dcacheline = {
> +static struct sort_entry sort_mem_dcacheline = {
>  	.se_header	= "Data Cacheline",
>  	.se_cmp		= sort__dcacheline_cmp,
>  	.se_snprintf	= hist_entry__dcacheline_snprintf,
> @@ -1998,7 +1998,7 @@ static int hist_entry__blocked_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%.*s", width, out);
>  }
>
> -struct sort_entry sort_mem_blocked = {
> +static struct sort_entry sort_mem_blocked = {
>  	.se_header	= "Blocked",
>  	.se_cmp		= sort__blocked_cmp,
>  	.se_snprintf	= hist_entry__blocked_snprintf,
> @@ -2039,7 +2039,7 @@ static int hist_entry__phys_daddr_snprintf(struct hist_entry *he, char *bf,
>  	return width;
>  }
>
> -struct sort_entry sort_mem_phys_daddr = {
> +static struct sort_entry sort_mem_phys_daddr = {
>  	.se_header	= "Data Physical Address",
>  	.se_cmp		= sort__phys_daddr_cmp,
>  	.se_snprintf	= hist_entry__phys_daddr_snprintf,
> @@ -2068,7 +2068,7 @@ static int hist_entry__data_page_size_snprintf(struct hist_entry *he, char *bf,
>  			get_page_size_name(mem_info__daddr(he->mem_info)->data_page_size, str));
>  }
>
> -struct sort_entry sort_mem_data_page_size = {
> +static struct sort_entry sort_mem_data_page_size = {
>  	.se_header	= "Data Page Size",
>  	.se_cmp		= sort__data_page_size_cmp,
>  	.se_snprintf	= hist_entry__data_page_size_snprintf,
> @@ -2093,7 +2093,7 @@ static int hist_entry__code_page_size_snprintf(struct hist_entry *he, char *bf,
>  			       get_page_size_name(he->code_page_size, str));
>  }
>
> -struct sort_entry sort_code_page_size = {
> +static struct sort_entry sort_code_page_size = {
>  	.se_header	= "Code Page Size",
>  	.se_cmp		= sort__code_page_size_cmp,
>  	.se_snprintf	= hist_entry__code_page_size_snprintf,
> @@ -2125,7 +2125,7 @@ static int hist_entry__abort_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-*s", width, out);
>  }
>
> -struct sort_entry sort_abort = {
> +static struct sort_entry sort_abort = {
>  	.se_header	= "Transaction abort",
>  	.se_cmp		= sort__abort_cmp,
>  	.se_snprintf	= hist_entry__abort_snprintf,
> @@ -2157,7 +2157,7 @@ static int hist_entry__in_tx_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-*s", width, out);
>  }
>
> -struct sort_entry sort_in_tx = {
> +static struct sort_entry sort_in_tx = {
>  	.se_header	= "Branch in transaction",
>  	.se_cmp		= sort__in_tx_cmp,
>  	.se_snprintf	= hist_entry__in_tx_snprintf,
> @@ -2229,7 +2229,7 @@ static int hist_entry__transaction_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-*s", width, buf);
>  }
>
> -struct sort_entry sort_transaction = {
> +static struct sort_entry sort_transaction = {
>  	.se_header	= "Transaction                ",
>  	.se_cmp		= sort__transaction_cmp,
>  	.se_snprintf	= hist_entry__transaction_snprintf,
> @@ -2268,7 +2268,7 @@ static int hist_entry__sym_size_snprintf(struct hist_entry *he, char *bf,
>  	return _hist_entry__sym_size_snprintf(he->ms.sym, bf, size, width);
>  }
>
> -struct sort_entry sort_sym_size = {
> +static struct sort_entry sort_sym_size = {
>  	.se_header	= "Symbol size",
>  	.se_cmp		= sort__sym_size_cmp,
>  	.se_snprintf	= hist_entry__sym_size_snprintf,
> @@ -2307,7 +2307,7 @@ static int hist_entry__dso_size_snprintf(struct hist_entry *he, char *bf,
>  	return _hist_entry__dso_size_snprintf(he->ms.map, bf, size, width);
>  }
>
> -struct sort_entry sort_dso_size = {
> +static struct sort_entry sort_dso_size = {
>  	.se_header	= "DSO size",
>  	.se_cmp		= sort__dso_size_cmp,
>  	.se_snprintf	= hist_entry__dso_size_snprintf,
> @@ -2344,7 +2344,7 @@ static int hist_entry__addr_snprintf(struct hist_entry *he, char *bf,
>  	return repsep_snprintf(bf, size, "%-#*llx", width, ip);
>  }
>
> -struct sort_entry sort_addr = {
> +static struct sort_entry sort_addr = {
>  	.se_header	= "Address",
>  	.se_cmp		= sort__addr_cmp,
>  	.se_snprintf	= hist_entry__addr_snprintf,
> @@ -2462,7 +2462,7 @@ static int hist_entry__typeoff_snprintf(struct hist_entry *he, char *bf,
>  			       he->mem_type_off, buf);
>  }
>
> -struct sort_entry sort_type_offset = {
> +static struct sort_entry sort_type_offset = {
>  	.se_header	= "Data Type Offset",
>  	.se_cmp		= sort__type_cmp,
>  	.se_collapse	= sort__typeoff_sort,
> @@ -2513,7 +2513,7 @@ static int hist_entry__typecln_snprintf(struct hist_entry *he, char *bf,
>  			       he->mem_type_off / TYPE_CACHELINE_SIZE);
>  }
>
> -struct sort_entry sort_type_cacheline = {
> +static struct sort_entry sort_type_cacheline = {
>  	.se_header	= "Data Type Cacheline",
>  	.se_cmp		= sort__type_cmp,
>  	.se_collapse	= sort__typecln_sort,
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index 72abb28b7b5a..7353af6148ea 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -123,6 +123,7 @@ void scripting_context__update(struct scripting_context *c,
>  	c->addr_al = addr_al;
>  }
>
> +#if !defined(HAVE_LIBPERL_SUPPORT) || !defined(HAVE_LIBPYTHON_SUPPORT)
>  static int flush_script_unsupported(void)
>  {
>  	return 0;
> @@ -140,7 +141,22 @@ static void process_event_unsupported(union perf_event *event __maybe_unused,
>  				      struct addr_location *addr_al __maybe_unused)
>  {
>  }
> +#endif
> +
> +static void register_python_scripting(struct scripting_ops *scripting_ops)
> +{
> +	if (scripting_context == NULL)
> +		scripting_context = malloc(sizeof(*scripting_context));
>
> +	if (scripting_context == NULL ||
> +	   script_spec_register("Python", scripting_ops) ||
> +	   script_spec_register("py", scripting_ops)) {
> +		pr_err("Error registering Python script extension: disabling it\n");
> +		zfree(&scripting_context);
> +	}
> +}
> +
> +#ifndef HAVE_LIBPYTHON_SUPPORT
>  static void print_python_unsupported_msg(void)
>  {
>  	fprintf(stderr, "Python scripting not supported."
> @@ -170,32 +186,18 @@ static int python_generate_script_unsupported(struct tep_handle *pevent
>  	return -1;
>  }
>
> -struct scripting_ops python_scripting_unsupported_ops = {
> -	.name = "Python",
> -	.dirname = "python",
> -	.start_script = python_start_script_unsupported,
> -	.flush_script = flush_script_unsupported,
> -	.stop_script = stop_script_unsupported,
> -	.process_event = process_event_unsupported,
> -	.generate_script = python_generate_script_unsupported,
> -};
> -
> -static void register_python_scripting(struct scripting_ops *scripting_ops)
> -{
> -	if (scripting_context == NULL)
> -		scripting_context = malloc(sizeof(*scripting_context));
> -
> -       if (scripting_context == NULL ||
> -	   script_spec_register("Python", scripting_ops) ||
> -	   script_spec_register("py", scripting_ops)) {
> -		pr_err("Error registering Python script extension: disabling it\n");
> -		zfree(&scripting_context);
> -	}
> -}
> -
> -#ifndef HAVE_LIBPYTHON_SUPPORT
>  void setup_python_scripting(void)
>  {
> +	static struct scripting_ops python_scripting_unsupported_ops = {
> +		.name = "Python",
> +		.dirname = "python",
> +		.start_script = python_start_script_unsupported,
> +		.flush_script = flush_script_unsupported,
> +		.stop_script = stop_script_unsupported,
> +		.process_event = process_event_unsupported,
> +		.generate_script = python_generate_script_unsupported,
> +	};
> +
>  	register_python_scripting(&python_scripting_unsupported_ops);
>  }
>  #else
> @@ -208,6 +210,20 @@ void setup_python_scripting(void)
>  #endif
>
>  #ifdef HAVE_LIBTRACEEVENT
> +static void register_perl_scripting(struct scripting_ops *scripting_ops)
> +{
> +	if (scripting_context == NULL)
> +		scripting_context = malloc(sizeof(*scripting_context));
> +
> +	if (scripting_context == NULL ||
> +	   script_spec_register("Perl", scripting_ops) ||
> +	   script_spec_register("pl", scripting_ops)) {
> +		pr_err("Error registering Perl script extension: disabling it\n");
> +		zfree(&scripting_context);
> +	}
> +}
> +
> +#ifndef HAVE_LIBPERL_SUPPORT
>  static void print_perl_unsupported_msg(void)
>  {
>  	fprintf(stderr, "Perl scripting not supported."
> @@ -236,32 +252,18 @@ static int perl_generate_script_unsupported(struct tep_handle *pevent
>  	return -1;
>  }
>
> -struct scripting_ops perl_scripting_unsupported_ops = {
> -	.name = "Perl",
> -	.dirname = "perl",
> -	.start_script = perl_start_script_unsupported,
> -	.flush_script = flush_script_unsupported,
> -	.stop_script = stop_script_unsupported,
> -	.process_event = process_event_unsupported,
> -	.generate_script = perl_generate_script_unsupported,
> -};
> -
> -static void register_perl_scripting(struct scripting_ops *scripting_ops)
> -{
> -	if (scripting_context == NULL)
> -		scripting_context = malloc(sizeof(*scripting_context));
> -
> -       if (scripting_context == NULL ||
> -	   script_spec_register("Perl", scripting_ops) ||
> -	   script_spec_register("pl", scripting_ops)) {
> -		pr_err("Error registering Perl script extension: disabling it\n");
> -		zfree(&scripting_context);
> -	}
> -}
> -
> -#ifndef HAVE_LIBPERL_SUPPORT
>  void setup_perl_scripting(void)
>  {
> +	static struct scripting_ops perl_scripting_unsupported_ops = {
> +		.name = "Perl",
> +		.dirname = "perl",
> +		.start_script = perl_start_script_unsupported,
> +		.flush_script = flush_script_unsupported,
> +		.stop_script = stop_script_unsupported,
> +		.process_event = process_event_unsupported,
> +		.generate_script = perl_generate_script_unsupported,
> +	};
> +
>  	register_perl_scripting(&perl_scripting_unsupported_ops);
>  }
>  #else
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 0f031eb80b4c..ce2c020247fd 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -76,8 +76,6 @@ bool sysctl__nmi_watchdog_enabled(void)
>  	return nmi_watchdog;
>  }
>
> -bool test_attr__enabled;
> -
>  bool exclude_GH_default;
>
>  bool perf_host  = true;


--
ankur
