Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2058245AE8;
	Thu, 13 Feb 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473573; cv=fail; b=ANid1bVvzoutoVk8dD3n5nVyS9kasD8loeEm5t4NLBsZ0oWUG6htlqfr2Fg5L7wSBVagGwJtYrqGm8pgnwQkMHsxe/KEV2tYHVLJF/ICdNe90nEG55qEmqk508TEJKwu0OQtu0kOx7kVuaJALtnZ5CzUNH70cZ/aNj4XlqnrB6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473573; c=relaxed/simple;
	bh=+HW3iHShgy7cGvlL8fC5wbzkvys1b3onxNfF29BSVPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3jsJhSNXkxLyatWOFDj7RepWzQqEfePbVIXdAoc/U8YGUWrkW8Zi5MCepvjd9gR2TuOuUYyAKV6gFwlwH+8sBlljeQd8wI13Dtz+wGFcCPTYxUAx+uoLttO4PFMlI1r4E9E7/hFrpSPmDZiRpr2jlevA1QYg9XC23828JBi6i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XRfwu8Yl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DgzPTisI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XRfwu8Yl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DgzPTisI"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGfcQb014355;
	Thu, 13 Feb 2025 19:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GbFFoR1hQEE+kVf/QBFOGSqkRn8oXp7Q7vj+Y4C2Bak=; b=
	XRfwu8YlNa6ED6ygOzlFmGfZi0OH1NXjtiOLljRrVSpdl00e5Jsk61N7IIrsvtgX
	w6rJLijyN6N1VMbLc4KPnhjY1r0Ufq6rb1ZjqpVaWag6pQFFZLmfjeXpOuHEJ6/O
	aLVjyF6Zox51u6ZWtVQZp4SfwR7Skqu4wcDKmiyB9TNgQAEHvX1t7/jBB5SI1B29
	gjjEHJ6akM+rKK+kxLR64CgDIj8+2C0WaD5tA5tALvut/YIGfxi9Fj4D80M3vwsK
	O58u1WOMIkdphlUVOALF9qK/r2FiF83wSdTUkLAvV8x+uGX15/gDwlf3U61mu3qB
	c4n2oyMyOkQFsaguZYCAHw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2jb11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:05:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DIiqL8012300;
	Thu, 13 Feb 2025 19:05:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqc54av-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:05:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb8gy2hoq09Re8YX4NZk9vopQXwq9jR33p+1IrQ/rm0hIfKZQdsf4D7Sq5CXLPAAGxXQ+bWWupdNibaQ/fR75MzKf0TpBx9WU12noR6EC1mFbUUNcZQpN0KBtkQq3pdepa13yyg9s89GMyfFZVwhlgF3/moL0SeEz1+D95/WdojOq6yHWKIQe5nRw5shAR3plOcgyfhuiVZP2OgzT/mfOIKzUpBlJdcnTL+mKAnk6l05DtTOKoulaoxOyvN3JPLunpDGcAA3pX4ZKmxeX5lsmPsd7Gvk91GR+SAExf6B3a+ganP7O+xeMXnYevKx3n3QanfbnBmR6aVdBwpsbaXCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbFFoR1hQEE+kVf/QBFOGSqkRn8oXp7Q7vj+Y4C2Bak=;
 b=xflJa4IPyW0l9CSv0V6E7EsJXDkAqwxY56t6Zldv9YgBRpSLmoHdG+kny2Sq4MCesLOhxsILPkR87xnb96Nm8NsQyDEo09S+yVo4KYUsOJAS3X14wrmHYnBOgaYtyA02tsB7nhkGIM4ZOhxad4GjXEg8ZaSk/KvJSMZqubcIh4E5qp0bdsFh6gjTNlPZs8+92W2Q8atmVUYKvqLFZA1Gw4N/xBGr2VH8pDw5+G9RfsdDltwNi8AaG4UmjP9VIa/OhuwdlRpSuKCznp2wv9kTJs6PcXHenlvUCt+BUmP+oIR07lm2DQPd4Vc7sxVV3RDZAwuEt4jxqv4vpHMHPsnnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbFFoR1hQEE+kVf/QBFOGSqkRn8oXp7Q7vj+Y4C2Bak=;
 b=DgzPTisIkypz4GnOjZF0RTiNiUg80F5zsprjelzg10uzeKmrjDZ2iF2ITTzXZcOtgb8kkw/8/nLGMQFZFCNEFrpWuq2vynAz963gVhfu6lsfrJBLhgtSDj8JszS855fUPOKqG8O31IC1GEsJydi79DFxrz5FutYwAoCacJnrDts=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CH3PR10MB7164.namprd10.prod.outlook.com (2603:10b6:610:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 19:05:46 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 19:05:44 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/1] tools: perf: support .gnu_debugdata for symbols
Date: Thu, 13 Feb 2025 11:05:38 -0800
Message-ID: <20250213190542.3249050-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250213190542.3249050-1-stephen.s.brennan@oracle.com>
References: <20250213190542.3249050-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CH3PR10MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 250af55f-4eee-4c3b-f9eb-08dd4c616af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D0BBRAKu17fIX3TdfVU2yIMboghWinTJtVNKdzPxr/FUzM0+R4XH17hf0Jfw?=
 =?us-ascii?Q?Qjzz9iPSILkhDLVDCvvzruZzDGE/Sm+f/I0Z0JHWa+sYjEBevEi93F6+FK2u?=
 =?us-ascii?Q?Wa/qF+cLGSSJaEycOgr/1T5cjOSjIpAj02+8AaLBmB+2IWtDi5acKrRZoFDk?=
 =?us-ascii?Q?xLl2shJj9zsazR7SHmBsQDyvmPYpoCG4ql+a4e4DEX8Z2ZAX4XQlMXU3tVqy?=
 =?us-ascii?Q?RWK1wFHyRTZCurrd9q9SrhFUjq+rVeGj9MT3pbjMkhIv9dzAbhWEP4h7iYvl?=
 =?us-ascii?Q?JyINxXm8JXPJkHXXBnJhFRuS9zRtMA5NlRgbssAUvwIZnkxa8fVg8Ai5ROZc?=
 =?us-ascii?Q?SElTp7Y8vkfyV+RhiSMOs6JSKKT72Y01Zf+X6Ffr/qElbws5heYl7y0lg5SE?=
 =?us-ascii?Q?g88kXENVr/G0ammKf4gvjWkje08hlVbPEwy5hUqAEgsrT6mnTW8qIdxWThZx?=
 =?us-ascii?Q?vwKHMwxtKQ4bLVdgADqPgVaSmxTF3lePbkmui2puufGoe/XJgHqTN1Tx1ZVA?=
 =?us-ascii?Q?cvHuSRYptBBFf/elmo7aYpiVzbyMKncGE0/1Zn7HC4zUFx+NPxlwkgd1vFGM?=
 =?us-ascii?Q?sT9SUcUHqr82CPcxRWgMQd8ySMGmShDPY79iQXp+alqiR0YTpC0JvYNnod+P?=
 =?us-ascii?Q?PnFEbQUKFQr77TvBVryJAt3Iyrp1zYJGYoU9T0695casCv+NhKkE/9AEpkHK?=
 =?us-ascii?Q?zvV171O2QVnVSD+RZMabE5j7Bk17Sj1G1HZwOW/8X4YQYoAfsGlrSwQa7qtK?=
 =?us-ascii?Q?tfXGrEHv7UciWWqXvNsqm0m3+d/sO+DasVbJUgysFgOIb2LDBfCY7g/4ld1Q?=
 =?us-ascii?Q?ElKIkuxaY37WFAGmxRHqbwUlnAHYCXdD8oUXxCW9sOSBxymB9LuXbtCpTQZ7?=
 =?us-ascii?Q?LApGYpZZomOD7LRzqPzyRNXkKG0Dngjc6wSVDrvhTthU3lnBfXlsdQpRfy+6?=
 =?us-ascii?Q?ePbZxBB2yWTRZFnKVTSfCHP0IdKgAs1/1xFcPxD4EFzwnzrx13SjapvshRax?=
 =?us-ascii?Q?18kwUjVNIP5vGxtjwuFoYqOV18tRqFkO90KI48KknQbi+8/TDww9YOEw77RS?=
 =?us-ascii?Q?5yaJKd2e2xacHxjuGapyHYiKmTNDi2vQyw5AWFfDqo5I2AEYItiy9CQZ2VVs?=
 =?us-ascii?Q?b+U9ZAb+F8gJMwRHbW/p00oyxh2bFEzGUnsRQwI6PfN1o3Lgb9tPNYlvNPeI?=
 =?us-ascii?Q?EqjZlhMmaRTFM6HQMb/HmQNJhYAgLb8HLzX7bFB3CW0cr2GuJOhvDryDwW9y?=
 =?us-ascii?Q?PTR5jzfpdZiOkWE1vs0yaEOn4yYSecI7Ev7ZFQ4oDDFfvWU4Tnvp74T40DXN?=
 =?us-ascii?Q?JQhmzU8aBCSDiasWr56+0N20uyhngb+2LEN0LPAlvdxiFGL2+S56NQGCZwFe?=
 =?us-ascii?Q?U6Tp1ZnKUl9z1MkvDZf2x+qTkEfd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+5obv1mtZwuDB3SWhX5ZHvJM0tUw880egIPejsjCLwsJxntDbb/QYwPMDERp?=
 =?us-ascii?Q?0Zzunpdtex7s0TeKNNAvzaaWsNSkdbUmoCINCyUqFtsKv7rR62fwvAODUz0s?=
 =?us-ascii?Q?yB4NH/0cZ5hpbDdr0GO3GcEi9Pvqf7UCm9r6QHzH/pQvzrQD2f5nQG34k2mA?=
 =?us-ascii?Q?eqzsUzuD9QYKVhZWMHo9QXcqeFuiqauUixtuU9Uz09/0xkc0gDA0mYWjYV+X?=
 =?us-ascii?Q?d+6ZqYdieM3ECvKTIwTwcwys8oQUBYsc1TYIirowUc5QF89IvS5KcPkZpsQn?=
 =?us-ascii?Q?hXJG08mXxES14NgDnGR1SpbAH9ayepOWKOAtDEEROKSO8AVLGpf/aBP1noFb?=
 =?us-ascii?Q?2gsIZXXCNDZbGQsI2MaSCgTOuf0MshGvyBdNfrFASn0C/Mirbsptq/7l7U70?=
 =?us-ascii?Q?Bp3U9Rt64/3nHLw++SG16Vd3pMztzc254BA8Tuewjrj016ds9qlf4w40Cxlz?=
 =?us-ascii?Q?YuxJHFp8i3TkQqRP43kRSiTpfbuxS8cY7ygYR0Es444G6DBvzpokIsK+gpoS?=
 =?us-ascii?Q?t6siA8WI+kEXC+3M02zgppKMKlhT3s+GBDu2J7zKNcPqdZn73nYgKS6YTYpi?=
 =?us-ascii?Q?0i2nc5Ntvs0kalP8raR0FHqc/rLJvyWiX/MqP//cY4aHcirAaDNQWQYx12cx?=
 =?us-ascii?Q?ZpCACVmyGzfDh7Arj6fWufvwlF8ESHflOhwpeq1KaFsN7tZ58Snq0+3jeGjR?=
 =?us-ascii?Q?/eYuy7kOPIVNP5WyxbZetUxjGlvgyb20wH0XIoNIU1UaqWX5qYyZO7MAQUzb?=
 =?us-ascii?Q?LVkzDpO41Kn6rJVlDMBny5dJQtE4uXTDjJi22iC/swmA5fO93ChRSwRd6PMD?=
 =?us-ascii?Q?XA1jhSZHdQVbAVw8cJsj7uok3NdDuxZnO//czJlclta4krc9mmRVYKLIlUdZ?=
 =?us-ascii?Q?R5maWwvtcPlZVvqaHFvbfvc9qB5qFF4Bkz5HQ/GW9dSEbCsRxbtFnIXNxiMS?=
 =?us-ascii?Q?1iNnvmSADZxh+Lvwkn1xjrFhhvixtdYMGSegJ2TK5/CHbQmMP5jQgo54pBpr?=
 =?us-ascii?Q?GLPd/uEjNTuZW+56sLuicoIHa5oflbF03iVMrf80jjUg8VeqZ2yEOG55JL1d?=
 =?us-ascii?Q?GochRbfSAAfrNpavfThRfScs5xAqEa67n2gjtAZZkv317fj+DSE2YYP7K9YZ?=
 =?us-ascii?Q?QyPj92XVTiLZC+7vGF2ePvjqARS6zdWZ+do4xDnGISPXvDXwMrN7/IK5Pxax?=
 =?us-ascii?Q?hZOGUaNO8rcTIbO0CviXQqV042q3Nqej4OC6bobmuqPBL+igvru2hijqhnOs?=
 =?us-ascii?Q?D9d9K7zUf17XZilF6gRmryAdPVzhGMj7kN0zklw0Fz/bfsTfP6aWOJ8nEZpO?=
 =?us-ascii?Q?BnWlUIXha94TQq0KuG44g48G0Cjas+qHGN1lddibQl33h+NrWBn40o2vrRKR?=
 =?us-ascii?Q?Mi6oPDR6aedrJ2rxERsyGbvGN03vXk/xyBh4sXgwhHFVCzvWgx2tcAcZ1oq+?=
 =?us-ascii?Q?zCJimNwD3BA06HaWwpICtiASCr0Mh9zmAEGz5nWsOVoFVJF/nFfuxI++Evpm?=
 =?us-ascii?Q?Uf/U6+KDLgdPpWDXLAVjEAKrwVHhRPfPSYY1fU+j9YZYYo/dGVo92P0zaCqq?=
 =?us-ascii?Q?tEtRRsLUAYNqy/d+rm24QTSgL0f+MmDSFSImiod5l0lJo5xq+qdDC5XWpd4S?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ouM/BF0QuOIXUH51BjdDnWf0SZj9jY79l9ooEniY73LQ4tFNgq1hj/qEmNmewBPOEbHuW9nK9/gT9rlMhHHhzrqUAPSdAg4CQt4xdcxLnjvgVPVesQP4y7qQCNY76qB+2xS6Ve/+fn0Jq/Kwram8Nnb4WVDZG8YxeTexjnKPTTv36E5bbX3vcfwJzM85VxRt4jvLs+tPYNBKVtcvTorZloSigr8UbJyX2XWlsWrnuJjXNAJonen7LZrU8gI08+LIE7hSVo+LBrg2osA9xJNN3Qj66BIh34x5E6m0Cpy7z4A63jQsJ8DvsLA5PBn2VVjnoc3wzNJ38LI7qZWc0/wdFg2louCUMRDmaert3x5WglfAvhLqdRoEVqsVBPM2/u+plMGrjtdtkiyY6VETZgG9COCecDsNimRKVkTFnrOukRpseUoz51W/fCMcgudxlYX6VhyFdHEbNawNtdXp4fSg1+Vfnu2fC9l0aBDoOCWmtQ9cQj9lXL+XvxWpceaE0E/RE6/SveXcJcRP8GWGa2T3gCDoDeCZ4tNUSJB0HTnnjFTcPelOWn8VAS/FWDJAsOnY8LL6DDRTUtu0TbMi6CyodsRdBqU89i6YvaBVDEO6VFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250af55f-4eee-4c3b-f9eb-08dd4c616af8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 19:05:44.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruSK5KqmV1uhb/4JAfU2gUavVwvsP3rNI7d8WQwRrysHiJzZU8PQY9mnos4ZYFYwH4uZsiqbMp7IURP5ZE9kgFDw5MO6fUfuJymBTF3CIJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130135
X-Proofpoint-GUID: 1hOxFr02aStTjDBqQ-2ZX5kPihJJvXVX
X-Proofpoint-ORIG-GUID: 1hOxFr02aStTjDBqQ-2ZX5kPihJJvXVX

Fedora introduced a "MiniDebuginfo" feature, in which an LZMA-compressed
ELF file is placed inside a section named ".gnu_debugdata". This file
contains nothing but a symbol table, which can be used to supplement the
.dynsym section which only contains required symbols for runtime.

It is supported by GDB for stack traces, but it should be useful for
tracing as well. Implement support for loading symbols from
.gnu_debugdata.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/dso.c        |   2 +
 tools/perf/util/dso.h        |   1 +
 tools/perf/util/symbol-elf.c | 141 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/symbol.c     |   2 +
 tools/perf/util/symsrc.h     |   1 +
 5 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5c6e85fdae0de..67c21999628d4 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -93,6 +93,7 @@ bool dso__is_object_file(const struct dso *dso)
 	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
 	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
 	case DSO_BINARY_TYPE__GUEST_KMODULE:
 	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
@@ -224,6 +225,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__VMLINUX:
 	case DSO_BINARY_TYPE__GUEST_VMLINUX:
 	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
 		__symbol__join_symfs(filename, size, dso__long_name(dso));
 		break;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bb8e8f444054d..84d5aac666aa1 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -33,6 +33,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+	DSO_BINARY_TYPE__GNU_DEBUGDATA,
 	DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
 	DSO_BINARY_TYPE__GUEST_KMODULE,
 	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66fd1249660a3..e578b7d406a69 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <inttypes.h>
+#include <lzma.h>
 
 #include "dso.h"
 #include "map.h"
@@ -1214,7 +1215,9 @@ void symsrc__destroy(struct symsrc *ss)
 {
 	zfree(&ss->name);
 	elf_end(ss->elf);
-	close(ss->fd);
+	free(ss->image);
+	if (ss->fd != -1)
+		close(ss->fd);
 }
 
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
@@ -1228,12 +1231,115 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 	       ehdr.e_type == ET_DYN;
 }
 
+static Elf *read_gnu_debugdata(struct dso *dso, Elf *elf, const char *name, void **image_ret)
+{
+	Elf *elf_embedded;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	Elf_Scn *scn;
+	Elf_Data *scn_data;
+	void *data = NULL;
+	size_t shndx, datasize, bytes_decoded;
+	lzma_stream stream = LZMA_STREAM_INIT;
+	lzma_ret ret;
+
+	if (gelf_getehdr(elf, &ehdr) == NULL) {
+		pr_debug("%s: cannot read %s ELF file.\n", __func__, name);
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+		return NULL;
+	}
+
+	scn = elf_section_by_name(elf, &ehdr, &shdr, ".gnu_debugdata", &shndx);
+	if (!scn) {
+		pr_debug("%s: ELF file %s has no .gnu_debugdata\n", __func__, name);
+		*dso__load_errno(dso) = -ENOENT;
+		return NULL;
+	}
+
+	if (shdr.sh_type == SHT_NOBITS) {
+		pr_debug("%s: .gnu_debugdata of ELF file %s has no data.\n", __func__, name);
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+		return NULL;
+	}
+
+	scn_data = elf_rawdata(scn, NULL);
+	if (!scn_data) {
+		pr_debug("%s: error reading .gnu_debugdata of %s: %s\n", __func__,
+			 name, elf_errmsg(-1));
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+		return NULL;
+	}
+
+	ret = lzma_stream_decoder(&stream, UINT64_MAX, 0);
+	if (ret != LZMA_OK) {
+		pr_debug("%s: error decompressing .gnu_debugdata of %s: %d\n", __func__,
+			 name, ret);
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+		lzma_end(&stream);
+		return NULL;
+	}
+
+	stream.next_in = scn_data->d_buf;
+	stream.avail_in = scn_data->d_size;
+
+	datasize = 2 * scn_data->d_size;
+	data = malloc(datasize);
+
+	stream.next_out = data;
+	stream.avail_out = scn_data->d_size;
+	while (1) {
+		void *data_resized;
+
+		ret = lzma_code(&stream, LZMA_RUN);
+		if (ret != LZMA_OK && ret != LZMA_STREAM_END) {
+			pr_debug("%s: error decompressing .gnu_debugdata of %s: %d\n", __func__,
+				name, ret);
+			*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+			free(data);
+			lzma_end(&stream);
+			return NULL;
+		}
+		bytes_decoded = (void *)stream.next_out - data;
+		if (ret == LZMA_STREAM_END)
+			datasize = bytes_decoded;
+		else
+			datasize *= 2;
+		data_resized = realloc(data, datasize);
+		if (!data_resized) {
+			pr_debug("%s: allocation error accessing .gnu_debugdata of %s\n",
+				 __func__, name);
+			*dso__load_errno(dso) = -ENOMEM;
+			free(data);
+			lzma_end(&stream);
+			return NULL;
+		}
+		data = data_resized;
+		stream.next_out = data + bytes_decoded;
+		stream.avail_out = datasize - bytes_decoded;
+		if (ret == LZMA_STREAM_END)
+			break;
+	}
+	lzma_end(&stream);
+
+	elf_embedded = elf_memory(data, bytes_decoded);
+	if (!elf_embedded) {
+		pr_debug("%s: error reading .gnu_debugdata of %s: %s\n", __func__,
+			 name, elf_errmsg(-1));
+		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
+		free(data);
+		return NULL;
+	}
+	*image_ret = data;
+	return elf_embedded;
+}
+
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		 enum dso_binary_type type)
 {
 	GElf_Ehdr ehdr;
 	Elf *elf;
 	int fd;
+	ss->image = NULL;
 
 	if (dso__needs_decompress(dso)) {
 		fd = dso__decompress_kmodule_fd(dso, name);
@@ -1256,6 +1362,18 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		goto out_close;
 	}
 
+	if (type == DSO_BINARY_TYPE__GNU_DEBUGDATA) {
+		Elf *embedded = read_gnu_debugdata(dso, elf, name, &ss->image);
+
+		if (!embedded)
+			goto out_close;
+
+		elf_end(elf);
+		close(fd);
+		fd = -1;
+		elf = embedded;
+	}
+
 	if (gelf_getehdr(elf, &ehdr) == NULL) {
 		*dso__load_errno(dso) = DSO_LOAD_ERRNO__INVALID_ELF;
 		pr_debug("%s: cannot get elf header.\n", __func__);
@@ -1328,7 +1446,9 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 out_elf_end:
 	elf_end(elf);
 out_close:
-	close(fd);
+	if (fd != -1)
+		close(fd);
+	free(ss->image);
 	return -1;
 }
 
@@ -1854,10 +1974,23 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 					     kmodule, 1);
 		if (err < 0)
 			return err;
-		err += nr;
+		nr += err;
 	}
 
-	return err;
+	/*
+	 * The .gnu_debugdata is a special situation: it contains a symbol
+	 * table, but the runtime file may also contain dynsym entries which are
+	 * not present there. We need to load both.
+	 */
+	if (syms_ss->type == DSO_BINARY_TYPE__GNU_DEBUGDATA && runtime_ss->dynsym) {
+		err = dso__load_sym_internal(dso, map, runtime_ss, runtime_ss,
+					     kmodule, 1);
+		if (err < 0)
+			return err;
+		nr += err;
+	}
+
+	return nr;
 }
 
 static int elf_read_maps(Elf *elf, bool exe, mapfn_t mapfn, void *data)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 49b08adc6ee34..a0767762d4d73 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -84,6 +84,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+	DSO_BINARY_TYPE__GNU_DEBUGDATA,
 	DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
 	DSO_BINARY_TYPE__GUEST_KMODULE,
 	DSO_BINARY_TYPE__GUEST_KMODULE_COMP,
@@ -1716,6 +1717,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
 	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
 		return !kmod && dso__kernel(dso) == DSO_SPACE__USER;
 
 	case DSO_BINARY_TYPE__KALLSYMS:
diff --git a/tools/perf/util/symsrc.h b/tools/perf/util/symsrc.h
index edf82028c9e62..38b628f12aaa5 100644
--- a/tools/perf/util/symsrc.h
+++ b/tools/perf/util/symsrc.h
@@ -15,6 +15,7 @@
 struct symsrc {
 	char		     *name;
 	int		     fd;
+	void		     *image;
 	enum dso_binary_type type;
 
 #ifdef HAVE_LIBELF_SUPPORT
-- 
2.43.5

