Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CE2857F0
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Feb 2026 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355336; cv=fail; b=E4X8N4DU4W4IAojdVUrimXCMMTxXowweS5FzIg6RlEJQsuHxDIf0LAgfO73PpVu6qI0tryFZkD1TD8lp/MgyZTOgi0wkRqD6NoRU9rkalQR9qzsqujN75VarF8OISzbF8opyjCWR83fr8Jdy+pbEExeAcbAjHu1JopRolBK7gg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355336; c=relaxed/simple;
	bh=zjqUg6XIx5Gf2oBo8jTUmGkSP2ieBXcsbPPHfumvIKg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jio14+5ghQoGEjPmd01RD/1YN1hGhoqn2C3wWTTBPYbfCvdEgLQkHnTIioCqaEN8vDZavwUc79D0WFswbRGFIJvsYsrCC/+QMxuwjHMMwi7bR5BgK/XrNjyrEDDfaWmCyMB1qOE4cJrPMiLaebZiNBJb172TGnURGRauLklyH8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rv4zCwp1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gOmln+MM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rv4zCwp1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gOmln+MM"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGNJHS389835;
	Tue, 17 Feb 2026 19:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=HkUqhLeAQAvqMy1a
	EKBh4CQFk9YH7gl1Bzu7hWOocrE=; b=rv4zCwp1bV8hzrccObZNuLB8g4+4c460
	zOxIRECQQhKDDq7MxiS6Ji3iv4f9XdQNLrPQKJ82ryiWjwTe/cQGBcAr4qvIueaD
	aLH91oSIF5K67fq3l5KAaMNjjC/Ttcrhv9w5CDxfD0x7GaV3C747eabyET4SnD/k
	q3lMrxK4+ODCKMgy/V1Vi7aXLSdWSIWExdeVnOUBqJ9iK662LPj750QWGkR2amRz
	xd9D0K4yX7nyLQ3fG0fbwiJCVPyWlkiYSgyJgy0Oo9rCmzEVq0gfkwxE5JYJTa7y
	1eTS8ZBTyKRX4uQ50eJUdfehGaYsBZsqU1tTI1WbzqaGU4p8r76e5w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj4av6fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 19:08:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61HI8dnq039056;
	Tue, 17 Feb 2026 19:08:28 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb22w3uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 19:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1uKaAQFycmfJYofl07v0/6YUN+NWGDEZQhz9e8eykbR8bBF+jbb01K9xIamxHZ80rrj68YhU5lTKXmAFHpReIJvUmzY0JHjgjT13/vJOF1JkSxqd5sNSG1o9y93NdSwAmm4nGmQbLiBs3V9K/nFrxcyWNWpQfmpF/d+XtA5xbJIZw/kjmAo+B3OuIK0ShtDONhWU4egEYQCOmOex/Zf7mBGNkZV+8ZJX7q50Seigz0DSoRvPtS5JBxJyeLFgHKpfo4R68S9xETO7q0fGO7AB9C8RUGejRMHLjWFADk2lvfxhmg1rF9qB6SYejlNYZBi4SxaNea47iT3BYxDKe/Yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkUqhLeAQAvqMy1aEKBh4CQFk9YH7gl1Bzu7hWOocrE=;
 b=qwX/7Bj/EWDsIAYmGl6APlupnrNYk9DUcxWTjTpLsmRa+AC/qdaWYxDGbWFgxINOaLLSnF5M1FhJxpRS9ABcNrIc1JZkOiObKGl7aKDfHUpYCZG0sotX/Bu5D5ii+3xXZmtNe1SExTd9jv3uDiigMEkzGHQ9GqvDylvoFAT+UixMVHogPzo6zZH4n28t3JvZzqqMguUlfTRXYlRidUSkAC1fpFPQFesn7fGRvl7ywiaQtDR8Bf6Fn3VqlXmb1rgMJbmHjrxnFLlAxRNjACzO17CNauqXc4DCR7t6/VovQcccJBHRzlQp7DrdrtVhxIGjsyTEWDbXeoKH5RifTw3ZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkUqhLeAQAvqMy1aEKBh4CQFk9YH7gl1Bzu7hWOocrE=;
 b=gOmln+MMutPWa3Cdh12lwCFUUi0F9CN5XDQPnIIr4PsLSyvQ68GAGY+5hMzZ5DMhx4xO5SoNycPd/XsOpi+MIAQSnMLk9QpfEyczGhidi8yJcr1Es9Nf6vqfXDFWXgS7P/CxeCcYQlMMu87hsQaoynSFSgNIrNjsCIyAg7J3joo=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DS0PR10MB7018.namprd10.prod.outlook.com (2603:10b6:8:147::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 19:08:24 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 19:08:24 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Question: perf report & top memory usage
Date: Tue, 17 Feb 2026 11:08:19 -0800
Message-ID: <20260217190821.3882437-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:510:f::27) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DS0PR10MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dd94e6-275c-407e-9155-08de6e57ec98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvu7u1SH3M3R7418Vjj0RnCFcFqlqpKUdIPmNSg6sb7JuIlSdoiZwI50NZmY?=
 =?us-ascii?Q?5MKZEIXUNg8M8/hLo7gmkkqkgxYZZsgJC3qzYDBga1QBoWwSznISDDZmBlH3?=
 =?us-ascii?Q?fCebR2UZTPXME+VRahE5tMD7gsL7Cr4tpsuB2LMvvVqvJtVk9O1jpoM1O0fR?=
 =?us-ascii?Q?4G6bOAinZLK5QvcHehOLhkTKyj7vIB3k5mvc5id0bF8iPPHgvEFQHhc+Zv7n?=
 =?us-ascii?Q?Yvev4LtUhogUuZAhMLucjLcg42XXbk1/3KcZJIHgMpNnG28WUMf3aILd8NkV?=
 =?us-ascii?Q?STGACJoaLXqEMjE7pGuxVIAMkWPXLJyHrtzrJqAfoHWk2RdVd8qkBiEpQLFV?=
 =?us-ascii?Q?krZSPXjBOepy3ErNOEV2ypTyC6/ebmEahK50oWU3UR5R94iV8jzAERuKAW/H?=
 =?us-ascii?Q?AzuR58yH1BqvOq+3FVpI3qNpoG5StamJjRiUswyO56TfJ1Gyu59SbSl/Aw53?=
 =?us-ascii?Q?4XFaSIjtcMLeaO4RLPN4WtxpIVujReSHqs+W7jnMXDO0kPx/cEUGspsn64PJ?=
 =?us-ascii?Q?cxF+5sZqUAOZ54t1Mam1eN5Jk6ijDiJ+hnSMS2NP0qEYkD8WS1nkZ0VSrCtu?=
 =?us-ascii?Q?Ig2rYoC9a/lQCzjQYWYc1CsPNtroz/pQE61jUoPG2juffxputM2vh2iNOeAm?=
 =?us-ascii?Q?iYVUSlVDiRg3+Ay1gvFRbkALkiYeraY17kXIsT76Znzsg6HcjSf/uzvFlIhW?=
 =?us-ascii?Q?4qtRz2pSASUNUoglYUpcSYCQa3v22sXlF8JYxho6YA5ravZxXEu2GVEh5Den?=
 =?us-ascii?Q?4d7gAsZu/3x1YOSxrct1Rjbd+ZEyppfyxNzMZVDAOHFvErcXiMXXeo3IoxBp?=
 =?us-ascii?Q?sLSPWLiB6NH1kBjLr5n7MvYxwLxBX0ScxjbC+jIq8f9uka1qwZtJNPsfjiFd?=
 =?us-ascii?Q?Q3XQdrHsmuIWvqlBLK35Eq824qZWaPrLE3WO3ge9KUCc12bvGdEUpFBWrNcQ?=
 =?us-ascii?Q?TV8/5xWVancDnecpriJnYGFtoEc5wgj/FmLYSdZswDmRJjP5q+fN8z9H7htK?=
 =?us-ascii?Q?8pxBf6HMk5FAfKEfEdH2XSJFCcCqvCZnXcMmsGInG9xLMG/IWqbQkqhrDDMb?=
 =?us-ascii?Q?jID9NMUhZJVWV1MQ2PycxnD04UjfpvfxCN0216szENsIOcgr85A7K93XTg5p?=
 =?us-ascii?Q?3mKxLQaxTt1fyZzTQxmc9s0hNRhF7M6UczRz9oRmTA3OHA+VspxWJpzFVdd2?=
 =?us-ascii?Q?3C1wlGBFCpflrLH67dqV9Z4ggGMiLpYMPrPB6BhuEIfjV6O0wSSGJ71U/Gqz?=
 =?us-ascii?Q?XhT2eiM+9Ms063jjWT3xuMGoZanhq67Rn8zqrXRCBiHu5lZ3EnUa+fOjr1C6?=
 =?us-ascii?Q?BhXO1emnjY9+Bzfcq3bkQTnVevBzMVSYJUnrEUkUuaV2OydVOll6mlpqsbsn?=
 =?us-ascii?Q?P+nuapCQhaBSWbWJ8882md7vfuEo0us9vgcZ0IJJ3d5VUqpFo0y8fjjfe6q3?=
 =?us-ascii?Q?FwrZ1jl5sm74tB8NnvAShYqc2p/npRSs0g/XS1WAzw+bl7jhRYtgyhh6BSL0?=
 =?us-ascii?Q?E33fPeB2CxbAZ2C3WjCwyJWHyve8uqJww/VvlLpLZaua/vtVy08b4KvF7krw?=
 =?us-ascii?Q?P37e9m9Nd5YmbPB/jow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aj7KTNG1lMBKIw8XVFknLc05o1pEF1S5ytfr+uPDmlrxw8rIgjtn09dnLwhU?=
 =?us-ascii?Q?NuMQZqb2bfnbw2rnIoNCyJiuoWtCkcfIfR+sBFtufP99iSZRH4dCOlYjmUqv?=
 =?us-ascii?Q?jcMHmr/nYNjo879gBQN6jL7bdkWkGSUtX8/GE7EtsRXENbCt4Mkg61hMBGsR?=
 =?us-ascii?Q?ScY00D8aPb2AXz8dWtRx/IiOpxrH5Ja3L/Iz3/5KAUfG+LVoQrVkt075KHJf?=
 =?us-ascii?Q?SEoDH3LSehwCN1pvt+mzDWvgONpt8E352s6yX9tEo2a9XIfwm/ZEPlkR5P6Q?=
 =?us-ascii?Q?dVBxm8vX50opqb1UJNCebVWiTWpRroZSXyCXh61LdwwkK8Mb9aQEgmv6lP8f?=
 =?us-ascii?Q?/p16wSAJf1hVXHOtzp+4qZm603EcD81h5tvrSjUl+WTKmuPgtvs+rnKg9kRL?=
 =?us-ascii?Q?DULKVf5GZ6IlCRGhyoeR+6YYnpqU/upo8brHtOzyfg0Jx/zbFzRdNmgkh/ZN?=
 =?us-ascii?Q?YhKFUnKrRSFE769gvcDAJhy+oaOdsch02jjBHnSrSVNsmS8UYRYBe5NjCgrJ?=
 =?us-ascii?Q?A86OlzkuX8eKc+qudt/Y8iFyS2WwJ6JnoEWAIadws5DsrT8Bqn/l48qvs4Xc?=
 =?us-ascii?Q?Xlyqq9+kBesXiXsxW2Cj43GF8nly9TUbIyIZmDpar1BGT3ZW5ozxJYmQEzDb?=
 =?us-ascii?Q?3HM6eQPF0oWVK3jxOHDT4SWmUowpk5Btt2mAjx0P27CjD1+MT1yRBjn2yG6O?=
 =?us-ascii?Q?EwTVErkGgQWgvJS8u5O/K9apNo527B4lEi9yC69L8HYhgfGLN4NEiCBdVCIp?=
 =?us-ascii?Q?F5CKgQvP3QcFoRGgsqRuKosH9QG/hxtlRCGYgQ3x31yxB/T65pnEFDF2ucQq?=
 =?us-ascii?Q?Tu2ElWgeRGC9OZ7YFiyPcmGaXfu/OAU8V9xE6javDhde1VHZfDE7Hk74Mk//?=
 =?us-ascii?Q?DDQ1uUKKLTXhKgePxVySJjxq3u8QRS+QBV93KKCQuNtMfLs3UfPT/pkls3sW?=
 =?us-ascii?Q?JcKPAh/cBA3AEM8lrpxqZbeGtGX6YqA8zzsDrjPyMmvYY6Ytlgg0TpHok95N?=
 =?us-ascii?Q?XN8jwACX8a8yE7rSF+MHerdMaVwK7KTKz/7PYa2vqcSOswA3PuWBsksBFrVN?=
 =?us-ascii?Q?07LuDR2jy5ZR2oj57E2TnDl4KLZLYONpbXHkr9o8ZcQ2IJLDpmY/RBKHuA03?=
 =?us-ascii?Q?Nr63CAQtTJOmJJd0Y4pKQPJU2vqDgMpPoizcwZgupGY7pEeu81Fvl+BOPQFJ?=
 =?us-ascii?Q?x9ctapcfiY0hZ+dbEvmnoH4jj5R+gTlDAHZdm2sSe/LkVSTlA44crUeQ0Ctw?=
 =?us-ascii?Q?MJrpQKpmprmx7KWRm6aJTvRJYRWQhnR8StpFw8YlIMYgdgWz+F1KyzCufYRi?=
 =?us-ascii?Q?wvRWtZgDDktDBwkPnqbvxj3ysh4XYHE0F0IJGoLQ2zoqgl8Ko3t9Hn3hDCNq?=
 =?us-ascii?Q?ft8C5YqvO0I3vGTJa9S6E2GPk47Pb+RI60FP+1j/MixfPWtPFJKZ+rXUd0e4?=
 =?us-ascii?Q?lDUdcXb5rxQ3pFPVFM7BQyQgwt7SVvqq+VI4PEdsoY/q9BUb2Xse2Qv9CSpn?=
 =?us-ascii?Q?7THD+ZKKGuMGepxIxykkWP2yonk/MZnNsWgALz1UxQmMeXvzZq2c44QRVcOO?=
 =?us-ascii?Q?bninZ9rNpDhcgeuA9My42j58B/TF3z9RXJJlUfK+J1WACunFxCO+vmxjxzy0?=
 =?us-ascii?Q?1CWEKSUeZmig3ilLTuXt8JpqeF4+CM6eiAI4nxFAInPOosmnI/9kecu6xApe?=
 =?us-ascii?Q?CVZDYf2DqII7t9KfmbWQegxp6wT9KQrYnpked1CK0lUcQRGRW+3+0DC0UBiI?=
 =?us-ascii?Q?Hxu/SbrTiz/SJA6/rWzREScv2mT3QxA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H3juAf1Hxa0veCKCGEK3wUbaYw1Ot0B0DJ8zEt0/jr6G2zJJwC1xkbrAkbaoR4yn/tnvGs2KI3uRIZDVZd+srlXo4NzcWW14+9IoczZkTot84WJKfE0dZKNjus60XMwnQLUwS/1dGFAb0cF3aFjjCB/FUTTJb0KR8Ey6IQO86ZVdzZTvZuxiKFynmekOwjOMGFcnhyIZna2A829KlCrtAebnnWzK6bVwZfRRWwZpD96IzvFhNy+paMoS7nDn/rfYUKgxr427SyPquBxXQHc199nlCRB0KirtQxYsmTDFj/+NRt/GwlfgfhNmW/lj3036AvUGmwJUNmf92pLfJC+Svj9xLkC/7wpty9q5onhHSV66ZX//rir+rW25S1EgbgaWki08BFyI+TK1xC7a68JMwtHdHm6sZskJ1Hog0e0X71vtqUvXBOXmAW1f7TlRgaDhyYrSlfVea4DxEt567hFTScx08m9kMKOv+3JIb2U7kERbn/S/QWM2mnjaYK3Unw8xrIaBwCsFnH5ipqwMYvD4CL4R7ZUuO8Vu6Bn6cbjGQmnyZNAaX0Nh99PxWIdSKriASV0lwv1a1JHQSmsHeidvKZXIaGunzYu8xq+y+7cecu0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dd94e6-275c-407e-9155-08de6e57ec98
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 19:08:24.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pbwn/l6bYS39yQgZXnK9lnUDj43VR8/9H3n3CXxaf0ewXw5+JrmYhnzLqMc5QaymdtHhAWwD6EBJaA6B9hhwPPUI5PEtTF8HPH2464yoXo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602170156
X-Proofpoint-ORIG-GUID: 4PPXrrxD-TbPGl3UsIkgN_vmT443a7Np
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1NiBTYWx0ZWRfXzZTrN8vkxHGH
 vGboC+9YN6VL0+uUGqzbzBHMY1bB7lmydCyWnnZckH69cDiiKdjQYu7AlLxW+zG3EmSRqUopfph
 GA/zQT30P0DQ1oOt7QjjiO6lLZtQuwkiuugxZ2Bx/O+YO9AT0w0WGZMntIHyE8h63YFZ0zAmvEd
 ydAsWDmMLaeitluShpMfNjyqaDRsOK7GhDiTKttDlP46aqO7m3ezRVQ7fZr6Dq9CC1F4cHnem0Z
 gGQsqKytk5UggXljrV1F8vXGjoQS18QKgRIYeRNj92XzAQsSYDyGV06wrW7WP4qTR1yDODl6a+j
 3y/GQGBTFTT/BhzY9fCb6U43yogJ5HvF5tTKey4pkg3SIESx1Zob8iZw80FWk73zEWrnabTRvIb
 5H3VpAOhy8I40nQT0aFheHx+TBWt/vfQd1iEYFWQ25p+Z+/hQs38e+zIi8a/M5cDO6xNC8tp85Z
 UZIEmuEWje98hUtW4Qw==
X-Authority-Analysis: v=2.4 cv=SI9PlevH c=1 sm=1 tr=0 ts=6994bcad b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=TgETjh5_y35KXGpTksgA:9
X-Proofpoint-GUID: 4PPXrrxD-TbPGl3UsIkgN_vmT443a7Np

Hello all,

I had an interesting case where perf record required 35 GiB of memory to create
a report for a 400 MiB data file. Unfortunately I don't believe I can share the
perf.data, but I did an analysis and wanted to share what I found and ask some
questions.

The particular data file contains 1,087,091 samples, with call chains, generated
by a pretty standard "perf record -a -g sleep 10" on a machine with 76 CPUs. I
looked at the perf report code and profiled memory allocations. Three items
seemed to dominate memory use:

1. Histogram columns. The default being "comm,dso,symbol". The more buckets that
   the data is broken into, the more memory is used, and the histogram columns
   directly control this.

2. Callchains. The default is to track them when the perf.data contains them,
   though it can be disabled with "-g none". The data structure storing call
   chains seems pretty efficient (a prefix tree) but it looks like there is one
   per histogram bucket. This makes sense, but it seems duplicative with #3.

3. Accumulating child overhead. The default is to do this, creating the
   "Children" column in the report. The implementation walks the stack for each
   sample, creating a histogram bucket for each stack frame (even if no samples
   were observed actually executing in those symbols).

My understanding is that the 35 GiB memory usage then comes from a sort of
combinatorial explosion. In this data file, nearly every process has a unique
comm with numeric identifiers embedded within (e.g. "db1234"). This means that
the default "comm,dso,symbol" sort will result in a large number of buckets. The
call stacks are reasonably deep (though not absurdly so). There are many
non-leaf functions in the call stacks which don't have any Self samples. Child
overhead accumulation creates more buckets than there are samples: around 1.3
million buckets, compared to 1 million samples.

From this perspective, the memory usage makes sense to me. I understand that I
could tweak any combination of those knobs to ameliorate the issue. The most
straightforward option is to use "-s dso,symbol" because the "comm" column
wasn't informative for this workload. I also created a new histogram column
implementation (see below) that represents a command with any digits stripped,
so that the commands could still be grouped together, without the numeric
identifiers disrupting the bucketing. These solutions reduce memory used to 5.1
and 5.4 GiB respectively.

My concern is that most users aren't prepared to dive into this sort of detail,
especially when they're likely already in the middle of an analysis of some
other performance issue. While they may be familiar with the call graph options
and event selection choices, in my experience they generally aren't aware of the
many options that "perf report" provides. They certainly aren't aware of these
memory trade-offs, especially for what seemed like an innocuous 10-second data
collection at the default sample rate.

To sum up, I have the following questions:

1. Does my analysis make sense and seem consistent with your understanding?
2. Does anybody else deal with this sort of memory usage issue, and have
strategies they can share?
3. Does the patch below for the custom column make sense to submit? I know it's
rather workload specific, but it could be useful for others in this situation.

Thanks,
Stephen

Patch for the "commIgnoreDigit" column. For this workload, it reduced perf
report's peak RSS from 35 GiB to around 5.4 GiB, when used in place of "comm":

From df1452ae742d933b45c18d9dde090c11fb3cf846 Mon Sep 17 00:00:00 2001
From: Stephen Brennan <stephen.s.brennan@oracle.com>
Date: Wed, 3 Dec 2025 16:01:49 -0800
Subject: [PATCH 1/1] tools: perf: add commIgnoreDigit

The "comm" column allows grouping events by the process command. It is
intended to group like programs, despite having different PIDs. But some
workloads may adjust their own command, so that a unique identifier
(e.g. a PID or some other numeric value) is part of the command name.
This destroys the utility of "comm", forcing perf to place each unique
process name into its own bucket, which can contribute to a
combinatorial explosion of memory use in perf report.

Create a less strict version of this column, which ignores digits when
comparing command names. This allows "similar looking" processes to
again be placed in the same bucket.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/hist.c |  2 +
 tools/perf/util/hist.h |  1 +
 tools/perf/util/sort.c | 88 +++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/sort.h |  1 +
 4 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index ef4b569f7df46..5f691d9b0272d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -110,6 +110,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	len = thread__comm_len(h->thread);
 	if (hists__new_col_len(hists, HISTC_COMM, len))
 		hists__set_col_len(hists, HISTC_THREAD, len + 8);
+	if (hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len))
+		hists__set_col_len(hists, HISTC_THREAD, len + 8);
 
 	if (h->ms.map) {
 		len = dso__name_len(map__dso(h->ms.map));
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 1d5ea632ca4e1..ae7e98bd9e46d 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -44,6 +44,7 @@ enum hist_column {
 	HISTC_THREAD,
 	HISTC_TGID,
 	HISTC_COMM,
+	HISTC_COMM_IGNORE_DIGIT,
 	HISTC_CGROUP_ID,
 	HISTC_CGROUP,
 	HISTC_PARENT,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f3a565b0e2307..656b5cc62a730 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
@@ -265,6 +266,89 @@ struct sort_entry sort_comm = {
 	.se_width_idx	= HISTC_COMM,
 };
 
+/* --sort commIgnoreDigit */
+
+static int64_t strcmp_nodigit(const char *left, const char *right)
+{
+	for (;;) {
+		while (*left && isdigit(*left)) left++;
+		while (*right && isdigit(*right)) right++;
+		if (*left == *right && !*left) {
+			return 0;
+		} else if (*left == *right) {
+			left++;
+			right++;
+		} else {
+			return (int64_t)*left - (int64_t)*right;
+		}
+	}
+}
+
+static int64_t
+sort__commIgnoreDigit_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int64_t
+sort__commIgnoreDigit_collapse(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int64_t
+sort__commIgnoreDigit_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int hist_entry__commIgnoreDigit_snprintf(struct hist_entry *he, char *bf,
+						size_t size, unsigned int width)
+{
+	int ret = 0;
+	unsigned int print_len, printed = 0, start = 0, end = 0;
+	bool in_digit;
+	const char *comm = comm__str(he->comm), *print;
+	while (printed < width && printed < size && comm[start]) {
+		in_digit = !!isdigit(comm[start]);
+		end = start + 1;
+		while (comm[end] && !!isdigit(comm[end]) == in_digit) end++;
+		if (in_digit) {
+			print_len = 3; /* <N> */
+			print = "<N>";
+		} else {
+			print_len = end - start;
+			print = &comm[start];
+		}
+		print_len = min(print_len, width - printed);
+		ret = repsep_snprintf(bf + printed, size - printed, "%-.*s",
+					print_len, print);
+		if (ret < 0)
+			return ret;
+		start = end;
+		printed += ret;
+	}
+	/* Pad to width if necessary */
+	if (printed < width && printed < size) {
+		ret = repsep_snprintf(bf + printed, size - printed, "%-*.*s",
+				       width - printed, width - printed, "");
+		if (ret < 0)
+			return ret;
+		printed += ret;
+	}
+	return printed;
+}
+
+struct sort_entry sort_commIgnoreDigit = {
+	.se_header	= "CommandIgnoreDigit",
+	.se_cmp		= sort__commIgnoreDigit_cmp,
+	.se_collapse	= sort__commIgnoreDigit_collapse,
+	.se_sort	= sort__commIgnoreDigit_sort,
+	.se_snprintf	= hist_entry__commIgnoreDigit_snprintf,
+	.se_filter	= hist_entry__thread_filter,
+	.se_width_idx	= HISTC_COMM_IGNORE_DIGIT,
+};
+
 /* --sort dso */
 
 static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
@@ -2576,6 +2660,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_PID, "pid", sort_thread),
 	DIM(SORT_TGID, "tgid", sort_tgid),
 	DIM(SORT_COMM, "comm", sort_comm),
+	DIM(SORT_COMM_IGNORE_DIGIT, "commIgnoreDigit", sort_commIgnoreDigit),
 	DIM(SORT_DSO, "dso", sort_dso),
 	DIM(SORT_SYM, "symbol", sort_sym),
 	DIM(SORT_PARENT, "parent", sort_parent),
@@ -3675,7 +3760,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
 			list->socket = 1;
 		} else if (sd->entry == &sort_thread) {
 			list->thread = 1;
-		} else if (sd->entry == &sort_comm) {
+		} else if (sd->entry == &sort_comm || sd->entry == &sort_commIgnoreDigit) {
 			list->comm = 1;
 		} else if (sd->entry == &sort_type_offset) {
 			symbol_conf.annotate_data_member = true;
@@ -4022,6 +4107,7 @@ static bool get_elide(int idx, FILE *output)
 	case HISTC_DSO:
 		return __get_elide(symbol_conf.dso_list, "dso", output);
 	case HISTC_COMM:
+	case HISTC_COMM_IGNORE_DIGIT:
 		return __get_elide(symbol_conf.comm_list, "comm", output);
 	default:
 		break;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index d7787958e06b9..6819934b4d48a 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -43,6 +43,7 @@ enum sort_type {
 	/* common sort keys */
 	SORT_PID,
 	SORT_COMM,
+	SORT_COMM_IGNORE_DIGIT,
 	SORT_DSO,
 	SORT_SYM,
 	SORT_PARENT,
-- 
2.47.3

