Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A62063FB;
	Tue, 10 Dec 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850142; cv=fail; b=cAa2ZmIy4pYh2H95vMdDZhtkwONm5z2SwAHsSDpPvy1dIWGkr0DVsFSrHHkP5PF+hzWiFWDvX6S02/n64ULbrqJCN2ouEJ++3QdcCSSto5RNsPhMP/tIUr6wb/2MVwQjdUTFZ+g7HOquhDik2c60CMFz9aN85LrIjEE5YCZC38o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850142; c=relaxed/simple;
	bh=gSffr0IPcR1b2WT2sV2LLW/8p/6isdsgsXtWPdvI5Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XRUNEl7hJfMYYM2V5FwAEVhui3B42vKeUbzD/JiJsiWWyWD7/uw+iaQX6wFCDVWsq1yoEaVz3rmqLB+ieK3Gnr14AOjXAjqbOzvPAg7MjvoATSihuUZjIqQY4d7rYKPOyDBUahhAkSjBNDIY42yW4u1/JRHA4g7PRjigBHudu18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LHKEIiKu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c2fbWTLu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LHKEIiKu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c2fbWTLu"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAGQwua004424;
	Tue, 10 Dec 2024 17:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Li122mKtPjEnPHvqFu
	k96dHNQlzCL5O682Q+kbsHRKY=; b=LHKEIiKuI3x54V7TQT9Qm78SN4dJVAUN5n
	5x7uyeVGf/SK54VkL2yij4ZQ5R54NP0yU9OCmbkBF5xfg3waKMEGRJJUZKz151yN
	LM17i5tL2rMfCyEHSyl5rOkvJSHoL4MZLw4OuXYiGVvVk2tvGjpyG1ur65w/8RXV
	fuk5/5b/gPLBdHOebVYyeiDIUil14e4C8dYNqY/GUzjwLuuPhNn4FftZO5fO4V8k
	Z6QZwYEot9HmJxMoSw8CsyJJa7cvsG+i1IbcqIXjUV4FgxrmtjUMMOWWoe0jNYvv
	TQJRFncseO2Uy/qSJ5/WDvCjJCOCa45F6Np/mHRuhGZdvx6J7oaA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9apbnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 17:01:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAFl1Yv008679;
	Tue, 10 Dec 2024 17:01:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8mwkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 17:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBnv0zzTGXtUaVjvr3KbQxsCfC2gfyEhkhTMhNrrGs8axMcTWIoBK0B58RdSSul4/TjZEIQBUIGs4pox0wDmV+XZurCyR9yD5aL6UHSHYOYakNWquGsHCrMhhL4FzUEhPee3wDDJWPIu+x3hWL5brJTXvBpeElezZiCrrEYh6x3TEJNMFurj+oJepgew5JQRfG+rmf6Tw9oSCIAV5WACggn/25bmHGgy7qwog7e/lYBGTGWy4NSgu0Et+LLsuyMGTLIM9uzOYhTW8RnvanXfPIpS2iAO2/YK4UA66hQ571DccRBQMfvvVQJAhhPW0XFINrwmo3ZVcqmXt9da7/AeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li122mKtPjEnPHvqFuk96dHNQlzCL5O682Q+kbsHRKY=;
 b=TWs3WL9OixyM/8WwdqPkof3+vr08x8FggBO8zfbDxFB2ZgZS8SbEWbl8gh29AeKLNzCGaGaKYUFDnnzbq+/Uy6DWwBdRLgWmpEImL0zLcmzXXMntsTwD8fcOXvZWpIgUV89s+w+pFHr9TMnpro8BJlo+aO6GIAKwvGhxzFZXmif7WdY45jXD7sTKzZcnYO7LffqvcxvIGpmimNnQQodUcCaeLCTMVSvonXb4XVrjtnpj3G9odqgZma20x7pVZP8EANSGBWZILodavs1NHK8mdmpC3JriSpam27Jt5Pl9punWvBNTZ2uVtQPnMoNVPTQGSuYA8KfHz4NVZYgoywKCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li122mKtPjEnPHvqFuk96dHNQlzCL5O682Q+kbsHRKY=;
 b=c2fbWTLu60z6zHiG1IxzmFeuUOftQX8iKOTzytuUyPfseNRzbLS78VceyOPczSnnoEs2BLo4Bbi8V86uJ7ITw+trj+s8k9Yx/KQNhaB6CAPTQFWv6jAlBFXjg8rAwjWvAO32vT8uF9p5ZwTRnfC3VzDaHDgcsoRv2MFZUwSx1L4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB6817.namprd10.prod.outlook.com (2603:10b6:208:43a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Tue, 10 Dec
 2024 17:01:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 17:01:44 +0000
Date: Tue, 10 Dec 2024 17:01:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH] fork: avoid inappropriate uprobe access to invalid mm
Message-ID: <38d54e6f-54cf-49b0-b879-4fc4a2afc749@lucifer.local>
References: <20241210163104.55181-1-lorenzo.stoakes@oracle.com>
 <20241210165334.GB31266@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210165334.GB31266@redhat.com>
X-ClientProxiedBy: LO4P123CA0323.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae3695a-8c20-462e-2aac-08dd193c5366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvMyJ5jtqBMe867/t671CkJzYmNnajL6KE8N7vGnKXi1fscgCTskYhN++Gde?=
 =?us-ascii?Q?mFN50K8NDyAQutCwUdlvU7DLaqlelit7PbtsoUJbTbTD132m1fgPtaU7r8td?=
 =?us-ascii?Q?Sg5e6buv1Y+jn79CcYiZKO5UX4/6yWkvPJocAx86iwHVGAF1VedPMlyOdxuw?=
 =?us-ascii?Q?d6osQzNV7PvOFKxqTZ9MbCjWs5UHfuRy87SclYgYkqZ93WucqveQW7DrK0bm?=
 =?us-ascii?Q?igelHRjn1EXShyS1W2mfsWkOCU2Rx2QkVoe6LAnqjcNC/CU4pYsGCyD/e2LY?=
 =?us-ascii?Q?sa8F62s0NCxnz9FyVhG7TOZivDbGW3qaKn2sDtoMcBL+SqjkTqmxcw961k6h?=
 =?us-ascii?Q?0z8d/ZbO28pP8915ogtwXsczrNreSZCsCPC3YWDJRTe29MOhCLWPLq7qjopm?=
 =?us-ascii?Q?m08LVHD83APYzUhJn86GsU+qof1kYHiH7WZmulfM7KVWmh+N5d8no4oEm9Jk?=
 =?us-ascii?Q?gVQf6ZbHIeS7VSJsWJvBUIvj06WNjDGMJaViCDVaYqe5/zCCS3cplKJx6yyi?=
 =?us-ascii?Q?0l67kWw4ZBt3HwwJU/9vpVgOZkqTKhAS4ql7M38aj4GcieT0YTTBkVOotnBC?=
 =?us-ascii?Q?7L32jtNljuJIC9Qrm2PKvXePZ615zLlbb2HVvZdWShuRzgi0dlqel1sHqA1E?=
 =?us-ascii?Q?0aj+a7SqcO3l91xhxCZ6m3dNKF5kYKr4QLB6Ikb6G5ztL1PLNzvwKUXTW9LX?=
 =?us-ascii?Q?J4JT8vEmx8De4UngKDFk4Nr2hOT7hJ9EA16oHTys8plLbz6iZt67qYL9Wyf/?=
 =?us-ascii?Q?2UUn8nLgH+xTBFvvja7SWr7m1XllPqkiu3XK7MbIpb2uQQuJVeN3sP5OgyNq?=
 =?us-ascii?Q?91Zm9S3bmoSd0KHDq+i3GhM0fTgRjh0VB39/8ZEesJL63A18LYcg0VnLctHq?=
 =?us-ascii?Q?mwMAlXdqPzWFB0Y53OGGkXK72rsEdu9tSpUktSWSxUZhaKOAL3l+EZU4g7qG?=
 =?us-ascii?Q?dbbFISEfjibO4Pe4WtSCptSEUntzX/xZUZuYecy+d6lWOk10FHljl5fCgg6U?=
 =?us-ascii?Q?eLUyKCLv9BevWtXJXD0l1qZ9+NuDWuWlBlBVRrEe0StvZSCgsy4kwFZ/YgS7?=
 =?us-ascii?Q?VG0izA+kXgUpZdlqbQ7g6XpGUh5LTqOs2OZjv/Ki9WdVqAn2Ohe+ly+iHf+w?=
 =?us-ascii?Q?fcx4UGDr352XDbgz7hEZQblaq9+CnS4cRooWP6uLNetKAsMAFsB8poUPAMHd?=
 =?us-ascii?Q?2oyLliDJXPzOcqzR79eqK8HgEIzWR5GaL0Kc1x12SWh+vjsyxpAGQ/nY4hHd?=
 =?us-ascii?Q?kqJ493HZm8zPMWRuyN4hAD5iLALoWAz0CLjml6QbCSAfV1qw9ZYXT6X3DbxU?=
 =?us-ascii?Q?vBD0oCBuSIKoBYeHsCabpHjNq6eGuvLjyu3VtAggGATZ/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aY6RcnyWurfw0nY6n1epAelHNy6Om9ZBcbbMZH6z5whfohGj56qhwmepiXk3?=
 =?us-ascii?Q?6O1mLkDEnqe2PdFsI5MelViERExOIqYNJ95ob9BPgQoAcUxfvwrXxloKDHyf?=
 =?us-ascii?Q?ErwlDQL3PZkr0sSwBb3Vc9zSqk4E2RCgclbdjxTY+Kqw59wZVVp+/RFrR7Gi?=
 =?us-ascii?Q?qNgam+1D1SME6TWHIZIz7h6RFYrC4K9t47r0QFOFLW3fyKBdMKDUQOOWYBMP?=
 =?us-ascii?Q?pnr0zPhBgQ3Dq1n6sz9z20ff85UGSRBDBCtArmFrkqsEteix9CnQAb0izhuD?=
 =?us-ascii?Q?bsizpc4wtGz062OIZkRhVzQdKL7BShxL0BYBciQnhN66z9m97nn5y413jVcf?=
 =?us-ascii?Q?/uoEMUu4DXE3XcZsRrclQelQYuu8s9uOSVr/s4w/RwsHPv0/KWczfS5dUj5V?=
 =?us-ascii?Q?HaqttvYXpoMleVE2j2kG6ofbfAM8sMAFsFtErICMQcYLIDweVOewXErUCfYC?=
 =?us-ascii?Q?YKSEclAJF6HtjrxhoaXVSQPNoFK5AiAxN/xUvP4krNoguK9LvVq5c8YYlbJ+?=
 =?us-ascii?Q?Vxp9loG9MtwVGGHm2sAwXZiCO8LPTm5URtAhC0jgmnTrFi2+Pnjj6LesELhW?=
 =?us-ascii?Q?MP73HEnUxhuPrnbcUoRDM4DAeI4Qgj0P7Djfrz/f26cc8Twxd+HyCv5oPVhg?=
 =?us-ascii?Q?ZZsXScY/L5leRRhc3Upy2OwuDz/ei3yPNIecHg447vnbuCnPG27oiyDtFBz6?=
 =?us-ascii?Q?9i+iBBMVarGpbscV5pdThAosG70iQ0kQh4qVT2Nbwu4zziIC2PQmxYvue8Ed?=
 =?us-ascii?Q?em4/RbTBFjca0axZLovdpVnZJkF+4PWcAZ0iMx4rlbRygN6VaXZ4PjuHZM2P?=
 =?us-ascii?Q?9l3lZA5u/E+vSG2cbcSJ354nCFG+0fzrggx3B/QVINnuOPFfIyI69N7Vi4/J?=
 =?us-ascii?Q?BVgNSjPBVfmUS57eV1nYilRDFpfuVCMoKrTerPwlzthPgkN9qv2M0E6pSAJc?=
 =?us-ascii?Q?H1Lz1bMR5n4oylWmki7CGk+CpDhwEsJ0Sd0/8WcoVkU5WNa6wVUmg4EXeO0g?=
 =?us-ascii?Q?Lx0aoDwDhTeYx/CoF4ZCt1YABuDGA0hTqQzYjZjzlJqW1YH4eUY3Uz0iMKwi?=
 =?us-ascii?Q?yp79f2ZSvxQo3acj8A6SbfXm2Ai0DDnwqj92E1rCZUy7MczhpMOckG7C2cRp?=
 =?us-ascii?Q?LqNyHAoDC/YOKztoss9bdsNoMVLJog1pHD2qzhui0G+qHrOhP3Fv1b+Bmmge?=
 =?us-ascii?Q?4UmdifsQjl+J+sM7FXvYQ+0VmBOVJfcMElIJ1RqHcq0ABMiYknzbeSO1GLaS?=
 =?us-ascii?Q?O0CPhkUNgjBn3OVTQzsbexRUyZqehRre77vqjrJ8fRYt4/UP2jAYSrhsU764?=
 =?us-ascii?Q?EAdZDSqIwdloQeirylkrUKHLhRDPob4o8g9kfH9MRj4ixqhnmr03IyHtm+sG?=
 =?us-ascii?Q?qFXiSO0+Vp5voMD3UD3tsltUvqejCpTj7F5tI353/qUBzjdDMiPxKuXJIMCX?=
 =?us-ascii?Q?CbOunj1k3Tb7fC9RfFlox+OfrXdesrhLmi2vOIW+YhtmUPX2Y71A2U32TgZs?=
 =?us-ascii?Q?v1FCuJ4SjZ0U0I/LiS3MKMnSrEtbKVNnUt7A+weTET/5ZS+eelntVGhtjjE5?=
 =?us-ascii?Q?Nf8nDPyGQ4N5awIGrzVUE1awQHE5/6sXwm6749/cAYwYdkvUmqWRD89VsS0C?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v7Ur5f9UuLp5DLuSr+WVvmxwvUmvIS4X9vpNSSax0rhdQdZIWcf7lrWv6glfFA6cpENHPUxj1TNSM3dC26LAQ0GBrjFUjAz7mnZfAKd5YqzK5UQg2liHCRW8PPcsXqjdAmvwjqPQEWGP5JoBgRZd8NHCIsUX8yG1KIqymMcyjnOyaL8dttewotl45Do0nY0O+y/KrdsnyYcaNw+Z2fs7rH+j63g+8ShQPkRkJ0yE0Rv8ZHraBFOKvt9os8eJ3PmcpR/Q9NRzUSvGjpN98wMcLDBnGTFfrZ13Pn3Wo0txW3WFpultzBMpo+VD7qKcAVEbKob8OUSw90iBFHkoDZr/geoEUqDOOLonheBAAUeSIIn4Eo5gawRq+nwTOFmm8YGDuERa57WPPuZR48gp+GlpAcG5bsOsxc3Rmx/VL5+k7Ab/j3xK1OhvQXeBodTCNxrn03jebKK+F+3k9pcBsCs8eZbp40J9sEqn2k6t9rgWCM1IoDBsrSC9EbdWGoUkvzNkojZKe/k8jWsT24DuvEgA0MXSL5KSynRgHP6mv5k49d+3w9qOD2nZDizySxX9N9m17wME+yJTN0lY7OGKuIaxynmdS3tVoMEqz8w0rUMSJ4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae3695a-8c20-462e-2aac-08dd193c5366
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 17:01:44.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo4UP+tUkt5FitOub16zYOhKKAyDEvpLBSTGy8MLbtcNd7n4XZ80GFDEoBOOd7wKXdtTLExDoAASAhPqjDn7ow4T9UyfQkN2MnCat4w14z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_09,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=997 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100126
X-Proofpoint-GUID: KoR4z1VP_jh-6VnWO7Q952dhZ2pzdHIw
X-Proofpoint-ORIG-GUID: KoR4z1VP_jh-6VnWO7Q952dhZ2pzdHIw

On Tue, Dec 10, 2024 at 05:53:34PM +0100, Oleg Nesterov wrote:
> I must have missed something, but...
>
> On 12/10, Lorenzo Stoakes wrote:
> >
> > @@ -1746,9 +1741,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> >  	if (!mm_init(mm, tsk, mm->user_ns))
> >  		goto fail_nomem;
> >
> > +	uprobe_start_dup_mmap();
> >  	err = dup_mmap(mm, oldmm);
> >  	if (err)
> > -		goto free_pt;
> > +		goto free_pt_end_uprobe;
> > +	uprobe_end_dup_mmap();
> >
> >  	mm->hiwater_rss = get_mm_rss(mm);
> >  	mm->hiwater_vm = mm->total_vm;
> > @@ -1758,6 +1755,8 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> >
> >  	return mm;
> >
> > +free_pt_end_uprobe:
> > +	uprobe_end_dup_mmap();
>
> if dup_mmap() fails and "mm" is incomplete, then with this version dup_mmap_sem
> is dropped before __mmput/exit_mmap/etc. How can this help?

Doh! Sorry, this is me rather rushing through this aspect of it here, my
mistake... I may risk an immmediate v2 with apologies to all for the noise... :P

>
> Oleg.
>
