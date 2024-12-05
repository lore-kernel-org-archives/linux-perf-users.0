Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474C2F56;
	Thu,  5 Dec 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387418; cv=fail; b=ulhEmenWUcQd3NWNsf51P1xdNgd6p68BWcun+2XjKJj8GFymgYB6bc/iJzyTmXLYN98uUpF0iVboMERhTReWUKwMJov0izcotMKV8rWb0zPPsSyD0uTJLLDSc6fGT0h2G8GK7ACYtIFaL9+bx67JOTDiO6Ww3U9DaKIRfQsadQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387418; c=relaxed/simple;
	bh=t9CuG/EfLcpjT9onamthpGfDF9+QCCJ7TdcYvlWJYBI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tNTdEldeX06FytBQPxCotuZFciCGyujOrInQt5b23mOpYl7RZtny/r/izkWDCkL99LY3Ovq1DYgtSq6Tq6tMc0F1UjJeJcargCH3UUuIEbbwhfBaJ4y7Y/oW7Q6VOMVT1lmhkC4da5T4rx1OeiPoskEmFza2IpmXuw8QgN+Fmn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OHdJNiBT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x1wierAT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OHdJNiBT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x1wierAT"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57Mnpg008507;
	Thu, 5 Dec 2024 08:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=YP1TNWtjmbUfq0Je
	6H9jtL0QmWtWMskAktzq2we6bwc=; b=OHdJNiBTBnFvbrkSVHE4Vg2caiVsgNAV
	fb4SQ9RoH0aGOzcwO5lGOyiBR+wTjTW9kJwvetWPIRdvsljED0IUAzYHUvYE8BPr
	0dW+geyrWnBqwQMBJDA0ZrV4nkLmzBrKIC42CoOzr1eSTm+yebTjncmgI0N2rVj1
	IPMzlcIUt0Kcp7oh8RMCjO1u0GlnOm8YBzzFwi6t36CBDHHmUap8/XNIjrXZU+P+
	fXpoIIQSDSCkrS6nr5/vjrKDkW0dfvvC8UV+73t8Hq01BhZR/42CeaTTpoOzX6jy
	gD/QDvOH0IQp8OiuIWGbDa+3oCRSPSlRNy9gQHwGlodPi12mqNX8sg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4ca9qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 08:29:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57tnNK040054;
	Thu, 5 Dec 2024 08:29:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836wh1fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 08:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF2MrHIIA6ElAaF+8ZswW5ks1E1YAwmRL2LLrkjPNt4zKy/PsAgtT8q5WXhZNq8UuaFuVq60smRM6ooPvQxm3eX3WG/SukAWPDMDqdBCpeU0sXOcu/7AMt8EUVo4PQiTXSUs7gpQqH5OWhlrU+ma2bgO2aHNiOB3j/V4vu90syKiA0c3S5aCPUKcEMkPM4hqZHGjzT3hl+Acz5E8djd4uckFQxTV/Kxux4sepm0nPcrLO80BRrLVTghnaLxCAMOkFaCaVDMvkzB2Hbz+73hArZEQxO5WC6VLda0W1/CrLX6UORIX9Ohyr8/F0bm66Mfvz3fIndU1dARpYn/XpDQWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YP1TNWtjmbUfq0Je6H9jtL0QmWtWMskAktzq2we6bwc=;
 b=mFlUCsGQN8IJE9dBZm9nqz5rl/emtEoBe9ibOWwqeC/QPBX8dZ+tQhPb0ihqinjkxckGX9ZoDIw3NmD+OX2zC/lRvkmLI3qrIf8PiggQ8w64NzX9pQk43RMX9kjXKBxxNcu9WqEyb7Q1bnqKl+jZSHBKnyhUBSN5n/6NxbfrH7/NHg8vZDulOU7Q2SXtBKmUh+zjX5VyKvypU9lAs8WHHKB0BfkP/eBIn4Sa6mYEdrosXJYdtABjALmzOrMV85g0CE3eFTTYqTXPXFxFBtuCFmr1mb0WzuZzbjOpiZRJrD8+3/dLddY7n4DCzE3Fxnm0DLKBiQySguwm/Jdb7qi+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YP1TNWtjmbUfq0Je6H9jtL0QmWtWMskAktzq2we6bwc=;
 b=x1wierATvcz4XBEu1HGZy4f4fq/n9idnsFdnaR6A27RMFd9pLixmbslsypUE9JWMgsq1KRMHrM43WclURZN2vSp/TO+8ozpy637+Bi/1Cjj9gJ+12D0GygI7fvU9dROMH40Cr6JoBlYMnVHoimtdjohvMfEqEwCKVcR1jviAyOk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4557.namprd10.prod.outlook.com (2603:10b6:a03:2d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 08:29:53 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 08:29:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, Yi Lai <yi1.lai@linux.intel.com>
Subject: [PATCH v3] perf: map pages in advance
Date: Thu,  5 Dec 2024 08:29:48 +0000
Message-ID: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0277.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 3352d2e8-68e1-43d7-0e78-08dd1506fe2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yEfVMibh2+9I3IkFGmrRGp/iZAJOr/VyP3HkBFto/dT3xxa35JHz+ILdu7yM?=
 =?us-ascii?Q?4BnN8WLadTvos+i5wE0ke1aHeBsaBj3bUDNkJLc6VYh96obK42p0OH35vgqK?=
 =?us-ascii?Q?/Bsmu8EDDugBvYFXQAhy48+Vb+ihM9DWXaCh5UMXIRJAYdv+UWgdkFqko66Z?=
 =?us-ascii?Q?iuRnbu/5JIwyqh5xZU5TQS6ww4ekqHCfC3fxKSUDToGuvX3o2QlshuHMbTH6?=
 =?us-ascii?Q?2UkUKG4LTrCC+UsqpDYvMKeFUG6YXX5tM9VOkxJwgyBsQ6Kg/iJfb1vM+K1U?=
 =?us-ascii?Q?YLMmgNQ2nzQG7TcLGS1UpA+jDCAQwR0pXXSJft1lvWcb3UyrZZFIPzQmraa9?=
 =?us-ascii?Q?HwyRPl/gaDvmKstsV2d77P4W1xumBU7Wmut8gOp+9t42A6xWuhlKmffl8Can?=
 =?us-ascii?Q?y4kyA35dyGIp0l/c/tecgy6nXXDSa7K9Vh8IszeNiYBw3+2K7ewSq9NZq4p0?=
 =?us-ascii?Q?KXPd8Nhd353yBjEKpZTml6Bd2WBUivtghjIXqssQJjP8ckVjDecasofukEwb?=
 =?us-ascii?Q?oEWHvwtogGEoXasjebuGtEoNvwMKlORwQM4YmYkG06Too6XIQFPiFUgU3cxI?=
 =?us-ascii?Q?VMTXsm6xRwjkx4YnZIF9lPumuC7xkpvRp102455ohVN8AEhTIrD0nICv2Yu2?=
 =?us-ascii?Q?ETkEJUPciwPIXJf4lZcPylHUYvsZUEVAtgBcYOhTVy6DZf33z6fQ1xMXzTpf?=
 =?us-ascii?Q?saI8jvjPEhsPxBimJVnsZlvqfGQDpPq81zeSM1zQXyVhy+cKh3UPA5ePno3p?=
 =?us-ascii?Q?jaZFpBBH+58LVKW/UMyJMO4WCMBy0XlPeyuwXSkhU13apmQfBBUdGxbzQuJB?=
 =?us-ascii?Q?Xb+wEBzsWN5NBKbnZYjTWF24h84rlHI8r0W7Pm5ECcgy209jBsEWHppieafW?=
 =?us-ascii?Q?1OIRf5284TBeTCIwR8o2uk561X22oH7IzaahctT48HmhULIWW7VEQpLPGMoL?=
 =?us-ascii?Q?riS9bf26fYRBRn/SIM/X7mNI+213LAVEboTCjHF970tL36EBmPuqpYkqHjsr?=
 =?us-ascii?Q?5Wir6R48/yWa0fbjSBoPiS5qgpDyjDN+o9+QdztTXem74inED4nMkcedhFRS?=
 =?us-ascii?Q?j+tufCmHVNYL8tl5GezbVzIATWn3MO5mC5IScGBMs0RF1qzb2ZXPjAQUBiyg?=
 =?us-ascii?Q?SXN77miiQTLWQ2Kh8FhECFrHoTs0Go1ab3DssdmqkXCbD30RQX4uQ1Xwut0P?=
 =?us-ascii?Q?UUgFbfN1FZD1+7z7zEJn7LaK4UNeOKnhRwxZ1fRBHdB6sNyHl6fFy25LeAwI?=
 =?us-ascii?Q?2lP5d/M080s/IzDDU+78sxSilZHkZUHIocL+IKZ2JU8Jatz4njhjEfNoMGn3?=
 =?us-ascii?Q?jDp3DfRHWvjZ/jvEUGIgu1y0BzfCRSg6IfEkaF9Y5s2mS7FpAGFhr6dfVuzr?=
 =?us-ascii?Q?Pxr00DI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YdDvWf37WA224RlM3sDiN+9bvd6eMX9L6BwLtuYoK5KKQNxGX302EUm3tK6P?=
 =?us-ascii?Q?TNPCmNwckr88PLzMqH0QvM2HRLPgEvfivciEAezWbxMdqHUya/4wdz7O0n9k?=
 =?us-ascii?Q?6wKwmS0stD5VLVShy17isc6Jn14d7YhHHRLBAg0MZ+SPKU4y7XigV0nG5e7i?=
 =?us-ascii?Q?VxA4vkDCdo4z6Qy8OcxgLbqW0HRwfmqMc3vgmEmjQx5ebiolp7vxRtkShDR1?=
 =?us-ascii?Q?Wn2uy7vi7RgLhP9oTKTKloJ2Ky6P8k80RQIs+bwsLnxkd7wzKUpNY60mU0Ds?=
 =?us-ascii?Q?Txd6tzVGPaLnFfnb/CVc0ekHknQtV5+rkrsL6/y72msql528wm4qfsm8zQ8Z?=
 =?us-ascii?Q?YficKRy35IAIoXgDHIM3EprIkuxc3/4Jw8Uc1ThjbIIYTiJiugyDmi/roLqL?=
 =?us-ascii?Q?qipS8OGPnm9PDfwdrccLReSivFXQu5Vl+ts8GA6Vvt7q67Li7Jz2aT+BMP3T?=
 =?us-ascii?Q?Hctz7NZZXr4NQnXT+I6YFwBXK0Q2MuHZliCwzws0UVLicYzLDwssJsC8sMeR?=
 =?us-ascii?Q?O2lUQ2QRxV4lAklHfFMmP3gUMPJmW79EHslZjUFiyap4gug9YloHkg6jMW2k?=
 =?us-ascii?Q?Q7pdcqmOV/E9xXpnAskW7Th0wAVKGUV7MYrF7m3x/TSoPdMsd4ry9Kq81PU8?=
 =?us-ascii?Q?pwdbouBD8Q2k4npdnScrF9ADkgQbG3qyeryciz5Cc6WVV2JW+R8nfuZdEaZw?=
 =?us-ascii?Q?KDWhrzi3EiSv+GJjupEMJVU/UutnGqvw8eoiJr8aFwGL+M19m+vQnHWE+7kZ?=
 =?us-ascii?Q?f4gJkJCieEWe8jUscjNPbtzgDKF7FJ0KugwiaOyK51pTufwNuPyw8XuEmpdk?=
 =?us-ascii?Q?ufN9ju27XxwZNXb1f673gn/Qwv89mjsR9tOALGC6VHx0gkKKNIez3WLmDktx?=
 =?us-ascii?Q?p9Sopm53wPhwA/nMe9LVRakvJbg4bmpvcCMbbNWLdARUQrklWgY0gNPl+Kbp?=
 =?us-ascii?Q?zdqwMAoRk2Fj02vRAAKGNIIp1YgxB+pPO+eyVFq1i9X+VJ4cD7y9a/qgdQIm?=
 =?us-ascii?Q?pOUSASDtI5maVINg2r8aN1cWIe0nYsZyG7P7yDxl3fG/+7OMkl8KfyaSSR+N?=
 =?us-ascii?Q?A7H8WIcg8XHS0hFB4dkM4xaT2Mq79i+cosYMqq5hGtiLIMkzJhIf+9oefn7i?=
 =?us-ascii?Q?Bc3IC4FPmHZNQaMwd/JgYoE8xYLFr/2rRDtxcexeump7q2HbdCk5rvRwaMdY?=
 =?us-ascii?Q?IFJMeSlEG4EeBU75tHfwdKpa/W02CkUnqNKDZ8MfpcLjYqiK8ZNcw73GIthD?=
 =?us-ascii?Q?XpoYOC9/lHnp5EZwjRXHlXgv4ht/TClK/FzI8mHK84cgfJPr7c8W4gxaNiN7?=
 =?us-ascii?Q?MNjh7nIuX6inHhaQDpffr6u7v3yaVP7mJDYsxuHHd0uaZqgpP0Sz9qp8znpZ?=
 =?us-ascii?Q?PIQUAG9dnkMW+pR34mRaED+QP0uoj5iaoreR9M59v97Ig53brGNwRvUUTe12?=
 =?us-ascii?Q?4K8bQOo2zqCrgx82k7no0Cy7zfiqB9ovEseCRVq/007XxzNM5NVGMyOvVJm2?=
 =?us-ascii?Q?HuiQvMAj7adUNgrG5RU90NwAhfcXRQNNSs7E+2IvwDcnmVvF2nUtwUQwaK9S?=
 =?us-ascii?Q?+RtNGFfKJHXP0n5we3SHtIxnTwq1MQHcaC2SXoAGFA8OOc6fne0rPFUSswEs?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	upDxritWIvrXEdcv/Za16RgfRv6zsxToFxj2Qa3ZG2+2vHkrzO3+xW3u89SCve1DC9aNv/nGzbRG35Cb9UsXnNSPsDDjSjg8ikyF5OAXPpUQQNRKw+RIDnQ+/nA+6M/8V6uCLT4QDo4srnMlhgAq+EZDrmIJLfw05smR+H0UDIz+4zOkRQQsijCU3UDpYFggxP6OxPwOma7OKsLw//l62BsX71VfuPzbHBvZ3loQ659T7V+Yw9sXAi3SNbue9i1TUpbJ1kaYlEsEev+lCHNG6NRQTd3mj7FrZ6jHzJ/2L9EG3XkJFuypxswUSh/jhEmPGagb1sjHRS8KBtwAJgxZ2BMPEIVxWcCFxGtnL4s6zNaUTi8K4AMy6hpsUhjc3jQUu7Pe0ea9voMaTCbtUpdoA9imq+zw9UzMeFQJzUDwn0GY8ko/g/W1OrtVpb1oJIUAiO1KREK5jfDwe44Q99ZP5pbJOyLhuso7jgvFXS/4rDnG2gC4Q8bbKXwawBlB0pykqpEHsk4zz3fc9Zxf1jW55Y+Z9QwyrD5R+A0UNUcHw5Slbj+ct/0D5yKsbf2c25/nqQG2GonGMThPy/Gl/Mg/f9psNwxyufRXcoWytH+WAUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3352d2e8-68e1-43d7-0e78-08dd1506fe2e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 08:29:53.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMaj3bc+oK1NLlS6OKqK54hYPSnTQYE2O7jHYIsXKG2VGifHuFww24pEEPxYBqYVEBRIPEp7K7Pejltxt4szN3mSw4l27Rpsk86OZMwjPos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_06,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412050062
X-Proofpoint-ORIG-GUID: c1zY07whoY3EZRxHP_gS00dlEzXTFkxw
X-Proofpoint-GUID: c1zY07whoY3EZRxHP_gS00dlEzXTFkxw

We are adjusting struct page to make it smaller, removing unneeded fields
which correctly belong to struct folio.

Two of those fields are page->index and page->mapping. Perf is currently
making use of both of these. This is unnecessary. This patch eliminates
this.

Perf establishes its own internally controlled memory-mapped pages using
vm_ops hooks. The first page in the mapping is the read/write user control
page, and the rest of the mapping consists of read-only pages.

The VMA is backed by kernel memory either from the buddy allocator or
vmalloc depending on configuration. It is intended to be mapped read/write,
but because it has a page_mkwrite() hook, vma_wants_writenotify() indicates
that it should be mapped read-only.

When a write fault occurs, the provided page_mkwrite() hook,
perf_mmap_fault() (doing double duty handing faults as well) uses the
vmf->pgoff field to determine if this is the first page, allowing for the
desired read/write first page, read-only rest mapping.

For this to work the implementation has to carefully work around faulting
logic. When a page is write-faulted, the fault() hook is called first, then
its page_mkwrite() hook is called (to allow for dirty tracking in file
systems).

On fault we set the folio's mapping in perf_mmap_fault(), this is because
when do_page_mkwrite() is subsequently invoked, it treats a missing mapping
as an indicator that the fault should be retried.

We also set the folio's index so, given the folio is being treated as faux
user memory, it correctly references its offset within the VMA.

This explains why the mapping and index fields are used - but it's not
necessary.

We preallocate pages when perf_mmap() is called for the first time via
rb_alloc(), and further allocate auxiliary pages via rb_aux_alloc() as
needed if the mapping requires it.

This allocation is done in the f_ops->mmap() hook provided in perf_mmap(),
and so we can instead simply map all the memory right away here - there's
no point in handling (read) page faults when we don't demand page nor need
to be notified about them (perf does not).

This patch therefore changes this logic to map everything when the mmap()
hook is called, establishing a PFN map. It implements vm_ops->pfn_mkwrite()
to provide the required read/write vs. read-only behaviour, which does not
require the previously implemented workarounds.

While it is not ideal to use a VM_PFNMAP here, doing anything else will
result in the page_mkwrite() hook need to be provided, which requires the
same page->mapping hack this patch seeks to undo.

It will also result in the pages being treated as folios and placed on the
rmap, which really does not make sense for these mappings.

Semantically it makes sense to establish this as some kind of special
mapping, as the pages are managed by perf and are not strictly user pages,
but currently the only means by which we can do so functionally while
maintaining the required R/W and R/O behaviour is a PFN map.

There should be no change to actual functionality as a result of this
change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
v3:
* Fix issue raised by syzbot where it's possible that ret == 0 and rb ==
  NULL, leading to a null pointer deref in perf_mmap_(). Thanks to Yi Lai
  for reporting.
* Fix typos in commit message and correct prose.

v2:
* nommu fixup.
* Add comment explaining why we are using a VM_PFNMAP as suggested by
  David H.
https://lore.kernel.org/all/20241129153134.82755-1-lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/20241128113714.492474-1-lorenzo.stoakes@oracle.com/

 kernel/events/core.c        | 118 +++++++++++++++++++++++++-----------
 kernel/events/ring_buffer.c |  19 +-----
 2 files changed, 82 insertions(+), 55 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5d4a54f50826..000d2fe0b3cf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6284,41 +6284,6 @@ void perf_event_update_userpage(struct perf_event *event)
 }
 EXPORT_SYMBOL_GPL(perf_event_update_userpage);

-static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
-{
-	struct perf_event *event = vmf->vma->vm_file->private_data;
-	struct perf_buffer *rb;
-	vm_fault_t ret = VM_FAULT_SIGBUS;
-
-	if (vmf->flags & FAULT_FLAG_MKWRITE) {
-		if (vmf->pgoff == 0)
-			ret = 0;
-		return ret;
-	}
-
-	rcu_read_lock();
-	rb = rcu_dereference(event->rb);
-	if (!rb)
-		goto unlock;
-
-	if (vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))
-		goto unlock;
-
-	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
-	if (!vmf->page)
-		goto unlock;
-
-	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index   = vmf->pgoff;
-
-	ret = 0;
-unlock:
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static void ring_buffer_attach(struct perf_event *event,
 			       struct perf_buffer *rb)
 {
@@ -6558,13 +6523,87 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	ring_buffer_put(rb); /* could be last */
 }

+static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
+{
+	/* The first page is the user control page, others are read-only. */
+	return vmf->pgoff == 0 ? 0 : VM_FAULT_SIGBUS;
+}
+
 static const struct vm_operations_struct perf_mmap_vmops = {
 	.open		= perf_mmap_open,
 	.close		= perf_mmap_close, /* non mergeable */
-	.fault		= perf_mmap_fault,
-	.page_mkwrite	= perf_mmap_fault,
+	.pfn_mkwrite	= perf_mmap_pfn_mkwrite,
 };

+static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
+{
+	unsigned long nr_pages = vma_pages(vma);
+	int err = 0;
+	unsigned long pgoff;
+
+	/*
+	 * We map this as a VM_PFNMAP VMA.
+	 *
+	 * This is not ideal as this is designed broadly for mappings of PFNs
+	 * referencing memory-mapped I/O ranges or non-system RAM i.e. for which
+	 * !pfn_valid(pfn).
+	 *
+	 * We are mapping kernel-allocated memory (memory we manage ourselves)
+	 * which would more ideally be mapped using vm_insert_page() or a
+	 * similar mechanism, that is as a VM_MIXEDMAP mapping.
+	 *
+	 * However this won't work here, because:
+	 *
+	 * 1. It uses vma->vm_page_prot, but this field has not been completely
+	 *    setup at the point of the f_op->mmp() hook, so we are unable to
+	 *    indicate that this should be mapped CoW in order that the
+	 *    mkwrite() hook can be invoked to make the first page R/W and the
+	 *    rest R/O as desired.
+	 *
+	 * 2. Anything other than a VM_PFNMAP of valid PFNs will result in
+	 *    vm_normal_page() returning a struct page * pointer, which means
+	 *    vm_ops->page_mkwrite() will be invoked rather than
+	 *    vm_ops->pfn_mkwrite(), and this means we have to set page->mapping
+	 *    to work around retry logic in the fault handler, however this
+	 *    field is no longer allowed to be used within struct page.
+	 *
+	 * 3. Having a struct page * made available in the fault logic also
+	 *    means that the page gets put on the rmap and becomes
+	 *    inappropriately accessible and subject to map and ref counting.
+	 *
+	 * Ideally we would have a mechanism that could explicitly express our
+	 * desires, but this is not currently the case, so we instead use
+	 * VM_PFNMAP.
+	 *
+	 * We manage the lifetime of these mappings with internal refcounts (see
+	 * perf_mmap_open() and perf_mmap_close()) so we ensure the lifetime of
+	 * this mapping is maintained correctly.
+	 */
+	for (pgoff = 0; pgoff < nr_pages; pgoff++) {
+		unsigned long va = vma->vm_start + PAGE_SIZE * pgoff;
+		struct page *page = perf_mmap_to_page(rb, pgoff);
+
+		if (page == NULL) {
+			err = -EINVAL;
+			break;
+		}
+
+		/* Map readonly, perf_mmap_pfn_mkwrite() called on write fault. */
+		err = remap_pfn_range(vma, va, page_to_pfn(page), PAGE_SIZE,
+				      vm_get_page_prot(vma->vm_flags & ~VM_SHARED));
+		if (err)
+			break;
+	}
+
+#ifdef CONFIG_MMU
+	/* Clear any partial mappings on error. */
+	if (err)
+		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
+#endif
+
+	return err;
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event = file->private_data;
@@ -6689,6 +6728,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			goto again;
 		}

+		/* We need the rb to map pages. */
+		rb = event->rb;
 		goto unlock;
 	}

@@ -6783,6 +6824,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &perf_mmap_vmops;

+	if (!ret)
+		ret = map_range(rb, vma);
+
 	if (event->pmu->event_mapped)
 		event->pmu->event_mapped(event, vma->vm_mm);

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4f46f688d0d4..180509132d4b 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -643,7 +643,6 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
 	struct page *page = virt_to_page(rb->aux_pages[idx]);

 	ClearPagePrivate(page);
-	page->mapping = NULL;
 	__free_page(page);
 }

@@ -819,7 +818,6 @@ static void perf_mmap_free_page(void *addr)
 {
 	struct page *page = virt_to_page(addr);

-	page->mapping = NULL;
 	__free_page(page);
 }

@@ -890,28 +888,13 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
 	return vmalloc_to_page((void *)rb->user_page + pgoff * PAGE_SIZE);
 }

-static void perf_mmap_unmark_page(void *addr)
-{
-	struct page *page = vmalloc_to_page(addr);
-
-	page->mapping = NULL;
-}
-
 static void rb_free_work(struct work_struct *work)
 {
 	struct perf_buffer *rb;
-	void *base;
-	int i, nr;

 	rb = container_of(work, struct perf_buffer, work);
-	nr = data_page_nr(rb);
-
-	base = rb->user_page;
-	/* The '<=' counts in the user page. */
-	for (i = 0; i <= nr; i++)
-		perf_mmap_unmark_page(base + (i * PAGE_SIZE));

-	vfree(base);
+	vfree(rb->user_page);
 	kfree(rb);
 }

--
2.47.1
