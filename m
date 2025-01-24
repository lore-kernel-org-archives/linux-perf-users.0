Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F828224CC;
	Fri, 24 Jan 2025 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750754; cv=fail; b=Cp1xeoBcwfGBaWJRcWNGVIBRAthTb42vmHi+n+LVWbCfCVSp0IC3wyb/Yy1c5SW6IM4VcIl1JQ5M+nfD78feRl1SG6VHoqaMR3henCYICbHgE/JijqThKziQbx0hw1coOpcB4KncqFgl6DGe/x0VahkfcfxH0OsVPG0Wewe2h+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750754; c=relaxed/simple;
	bh=jMPTKyXHOAusBAgkHOcQMdT4hbfubcM2orXd4z2BmDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RRpNlaJaeetikpiJjKHA6xMIJSVd8r8GN/u9k8G6zYGa6Jn0Lc7UrzT9ii2VfNkgQd0p6gp6pf4UAmcVdhF65czaAxzWDXqAISrSDDTQm2q/q8CtvVPmKT4PWU88F8eNYen63iBYRXISw54fJ0ctFisM3gXuBspCI0ATPWMXebc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZDrL4Idd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dIBNOYto; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDrL4Idd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dIBNOYto"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIXLI5032637;
	Fri, 24 Jan 2025 20:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9iqnUGLwN74g66rzJLZtkKN3TmrKjNmbQap9VG+ovhg=; b=
	ZDrL4IddvTH1OBmw4vjLsZ6JXYkwr6Tk+kA701DoqnUxnvvD8oP6Q+bTJnkwpw0f
	SPct3Rjqauxi3ZEW9y1cGXRSpk7Xi8gSD9gmnV4pugPP1YjHwWQ2oFHNwzqUiR/J
	tOU/XAEV8XCGD8X1+PAupJA3+do8vDPgyt1fUoR7DHv2i8ssVPMu3+UHIMNXA0wQ
	VD8oWsmLKSEGEbQ7QvlCnFlWUSbPVS4JVzkk1Zg/k9zrMuoQyEtKNsUMgsIA0Etw
	u+S8NWuHYzVominoXen1HfWnwkg8NfRboM0MY11yqhhqAtdmRToKNaUeej2229fE
	L7PZeROKrnBk04nwVSrx8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsmkx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:32:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIoPJb030592;
	Fri, 24 Jan 2025 20:32:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491fpbq7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIWMSnu7XMRz7CH04SY0YVwGKPhFx4jPycCaf7wIRLPCrTzSEZM6l/qpF2jWVAx5STUXM72RIHqe3ULSE4fD0p2I0reKfAd4mt042qiB0RzqZpLP40XCYmcXj1b+RzPf4iwVqTXAty3WGdLqhZFMkMWUAPY7JowgawPXnGF3mVT+fxbRatcnUSo92hqoEseqUXRqeNhvY9xv8a/IH1alDfKCFjENP1KkPs4IvGRYxDx08cCYyRnoo3l1VRZqja2UOjxrrd0ZlgclN8Uql6y1oi0mC41z66m6oKOBoPR+9TqUJGM32xILFefkGZLgv8kvxBA/vJ/ilVpnztb/zwHX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iqnUGLwN74g66rzJLZtkKN3TmrKjNmbQap9VG+ovhg=;
 b=NhmkrsqMevk57qnjO1d1lNWj25G5DtIsygRlQ5cRWn1Y/uaQ2puiTRM9Vb7XoPxoJVr1cj3KvC01vvzyChGbndd4/6sXs+1C8grzP4NWhu4Z+Awn/5lC3j/235LchKt33G5tGYk2G8ebvzLii5kVNI7TrPavDkA5w5faEeNC2AvFUKThDE2di+mkxsBkQvV2u4b3UzmVc7j22BtAoj1HKkm9jKG/OcX89CnXy3goy1KT4mZ6/O56pCeOfzEZI18/y6/VNIXmzGTskN/LGJizuA/kQKga1pXVQq+tDqZ/bCdLJfiSVksCuryZXjzJWyjfOtmixCOXeTKTPwyHgtIgkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iqnUGLwN74g66rzJLZtkKN3TmrKjNmbQap9VG+ovhg=;
 b=dIBNOYtoKRi2WvnuwReMZmNiHmAAx065+CE96tiNOcEQPKSNuXcYjQZdz6P66c08HHQFsUWye0CZpmV2ZT4Hn/aBKX6pNqKfmBcMMLuSnM1xojBEVh0X5KWbBTiLQLYvaq3e0Xxs7EkS+7Tl76a7I8uGq43t8/dLUNdPXI+emt0=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 20:32:02 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 20:32:02 +0000
Message-ID: <5cda6984-800c-45c6-867a-8fc0bb267c8a@oracle.com>
Date: Fri, 24 Jan 2025 12:31:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
        Jens Remus <jremus@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:303:83::13) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|SA1PR10MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: fddf4828-192c-497e-8ae7-08dd3cb62904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUZQb0dNb0x4OVFUaW5tenNLcDFINUU0VE4wUlBtL3VCeC81ZE5yUXVZVlhk?=
 =?utf-8?B?aStJS3hHRU9aQ3FCdmtkM1lJQ1R0S2s2SCt2SGhEcXZWQlBINXJuempyNmtt?=
 =?utf-8?B?RXZXWWpQMWdEcnhia0pIRm1XT3l5aXd6WnRPV3J1OTJnbnM4aTc2NWs2eGpl?=
 =?utf-8?B?MFpFdzl6ZGdnWUxaYkxtVnFHeldhZk0xNFFhRVd3R1QxbEJ3TGc4YzZDL2s0?=
 =?utf-8?B?R0lOa21zTkp0QUNqa3Q1dzI0bGFRK0M4T1JDczhhekNXcGZOM1hteFFMak9k?=
 =?utf-8?B?YVQ1ZU5LQmRPRTR3NDdKRHc3NUtVVDdtZzUybklXd1l2eEZLelEvT2lKOE9E?=
 =?utf-8?B?ZkQ1UTZxMFNYZXIvQTdVR0xMZHhtQnRQSC96cVIrVnNlSThzLzA1VXhCU1p2?=
 =?utf-8?B?ZDlUcVJEbGhCSDRJZi9rSm0yQ2lxWjlJSFFBTTdGUEltTzVOR3N2aEVWNUx3?=
 =?utf-8?B?UVJVcEJwSG15eU1MU2ZzM2QvRndUSExvN20xeGRqSWphOURIcHZadzlTQ2k2?=
 =?utf-8?B?R04wUytlQkFSYmE5bm1wSHoyL1BRTjlVTCtCQjBMQmZJTTJhNU5jNnFaYmtN?=
 =?utf-8?B?WDlseC9VQ0NmYUpaQ293Y0xNdVREdHZWdmdaTisvcVBUNW9WMGlMVnFMOWNa?=
 =?utf-8?B?TzhPYmtiVnpwQXJFUzNXbUtxbkZxazdYMkpnVDg3L3Z1ZURLSVd4ZTlLZlpw?=
 =?utf-8?B?bnhwT3BnUzVqSHNpYWc2VFh5SUNBeXh4UmxBNDYzdnJUWDB4eTk2d09xMzF3?=
 =?utf-8?B?K21Fd3NBaGFHV3dpVTlaSXhUTXAycmJpTVMvTjFTYk1tTy94c2UwMEhPYzM3?=
 =?utf-8?B?RXFWckdzVUc1b0FFampwdVZpOE9PcXNZSkN6aGYxc0g5MFowU1k5T0R2cmFT?=
 =?utf-8?B?emJGSmpwdXZrMXQwVVpjVUdNZEI2c1ppZDBKY3Q3bUUrOGFVc1ZrVUtaTXNM?=
 =?utf-8?B?Q2o1N0J4eHJBUXdhdWljQmJwblV2alA3MzdxSm5QVTEzOC9Oc0pBMTk3V2pG?=
 =?utf-8?B?c25Sa3ovdlpmT3UveGtFOHdaMTNMRU9pZ0lJTDJnMFNjNnRDb3dzcU5vL0ZU?=
 =?utf-8?B?eTZyL0tQYnE2cUVueUFLYmp4Q2MvbmZYQVpUQzNSalFxeWpZNS9oVlBQdWhw?=
 =?utf-8?B?ZGdKWE1wc0pzK2l2SHcyWmoxNmJ2ektxN0k5d0d2ZEpwUi94TjB6TVVDMVZD?=
 =?utf-8?B?MkJkeWZoek5uVUJ6b2QxWjJsYTg4T2o2ZW5UaWRjcUZKYmorQ2J4eklDbUFp?=
 =?utf-8?B?cGlRMkNtSzJXUFpOMmZKREpLWkI1bVU5RlBNRFRGNkszUmpiQmxBNFJINTBR?=
 =?utf-8?B?TE9kclkxWVdJcFBHaldlSTRJdWFjeHZFdFE2bkJBVzJZTmN0NCsvS3VCODVR?=
 =?utf-8?B?YVFlSUE2cmhBQUw2ZDhJaTBLNmxDcTRYdk92ZE9hbUVTek03RmRBbDNQd0Zw?=
 =?utf-8?B?bmNQMSswb1NlUTA0Zm91QmJDaWRiU2dMTlpzeTR0RlJmZmdvbkFMMU9ROWRa?=
 =?utf-8?B?cElFbkdCOHp5ODNkK0tFS3lFdlVnMi9NWEJyUHE3dklnNHpPanFHLzB2V1lu?=
 =?utf-8?B?MlJiNGU2V2NJaDBBakhXQXpSQXZEQUt1bUd1enpCZkRSTW05WUtlVG1xM0k2?=
 =?utf-8?B?QmlhU1p4dlNCRzMva0hxWkRMdVVFUzNXTWpkTkhOa3ZGZE9ta1hSV0xjY2JT?=
 =?utf-8?B?eDlFY0U4elFTOC84TGE2cVpNbzJLZlpONzVHS2RYZ1h3VUN3NXVrSmVmUU1q?=
 =?utf-8?B?d2Z5SUpnN3JLZzVIMFd5c3hRL1lKODJqWjNMZFptTnBadmZvdkVWdzFmQ1FZ?=
 =?utf-8?B?QktvMHlJMmdnNmFmMFZPdTJsbDQybUtvQTl4Z1BHRGlxYnM0UTNUd2tJNUsr?=
 =?utf-8?Q?TPKKbMyBOyeu4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1VqblEzbVMxVm8vUjNzZ3FZckFLc1I0Y2ppaUFyVHpBejIzSlNWQ3p1SGRV?=
 =?utf-8?B?MzRIRENuMTRRc2l6TUtnbzZPbEtrM2NZdkQ0ZnJzL3BkSmFaT0syN2s3eUIz?=
 =?utf-8?B?Z3lZcWl5bjBiTHp2djdiOERBWExpL3FhSE15QnBhUU0zVVVreW9DWUdtalJ0?=
 =?utf-8?B?VjJ2YktmZGtrbkxpcllxK0FPMk1QZWd6dnNnYW9CbExkZER4RmRWekRhSmpJ?=
 =?utf-8?B?S3NMNVpsS1FYbXZjSDV1UEwzbmwzSEZaWnluZThtYjRSVUVVYU9RL2ZKcUpC?=
 =?utf-8?B?VVhGUUx2bzl5eDB2dWFsK3pYRTVZY29CdjBjcXBEc3ZBdVNBRi84RzVJdDJt?=
 =?utf-8?B?d1pQallNc2ZlSlh5eXhFU01TTk0zakhMcDBsRTRMMlpNU2ZzbHF0dmtWZTFD?=
 =?utf-8?B?TGtUOGF6ckJaSHZGTXFuYmlUMElVcVlobjhlQmwzWnEyNlRyVm03eXpFYVJX?=
 =?utf-8?B?ZElrNDJjU2tsMXNhRlY1L0ZPZ214QmdSYTR3S0Y4TFJSTFBDcDlqT1R2YTlr?=
 =?utf-8?B?cW9mWjhlajVXazM4eEpaRHZ0WmhiTXBaSno2dlBaY0NhUDdKVUo2R0FkVWVa?=
 =?utf-8?B?N0NoRkJzVkZpM0c1YVVHa2s4T3lxSjdtWllGa1hjZDBDSzNVTXU5RTdZTzdI?=
 =?utf-8?B?QVMzWVY3eFpaN2lYSExsUUxjUTM5QW42bm9rVXJhSHVVZk5hMisvdmJHbXFR?=
 =?utf-8?B?dEhmclVKbDEvT3FCVjBRMGpLUTBNOGZIK2EvTzd4dzZFNWlxVDF3NENWOExQ?=
 =?utf-8?B?VHFyY3BicmdKelRINnl0NlhjWWdnNXJnS2Y0MHZCNkt3SXJMRDBLb2dLREMv?=
 =?utf-8?B?NklKdzBBUDI3RzBPOWg3Tm1mc3A3cmJVUmlqYmpiMDdhSVdqcWRsMzJ2bWRi?=
 =?utf-8?B?Q1E2cy8yVE8zZm9oQm5hZUNMWFZ4MzNScG9wdHBOVjVTaG5jN0tQODRiRW1Q?=
 =?utf-8?B?b3lnUHZmdXd5Y1BucmdsU1dpK3BWRlJ6a1Jvd0liTThLZnEva05TSThQREtI?=
 =?utf-8?B?NUZKVUxYbFp4Qk0rUW9GNlR4VENTWE1LNEhRb1lqYnZYNm5iTTFxL2RXTkw3?=
 =?utf-8?B?OWJlWHpBMGRrSEw1NWp4S0dZakZRZEdpby9FaFl2ZEcwTW9RSDZUNVlTMHMx?=
 =?utf-8?B?dnRRUVlwMENYZ1NFemFkWnpsWk0xbDZmL1ZmVGkrS3gzMlVFSEFUVG5sNWNV?=
 =?utf-8?B?a1FyRFhBT3E3UkJkcGxCSCt2UW43OGR1MFdMaWlwbXdHbU9URStjOVpzZnl4?=
 =?utf-8?B?NkRIczYvUkMwRFZLRlpMK1dKY2ljZHpTT0YyVXpNR2dLY1BYUVgyTDVoVDUy?=
 =?utf-8?B?SGN3QWFrOVBVdGhRSFhwcmY4bGZESERjQ05HNVVhT2lHbjdFRTZQZnhSelRP?=
 =?utf-8?B?Y1Zpc0tjMWJkK3JFR1BTMDB5OSs2b2tNTEhKQVN1bEpVNW5xWGlUSEtnQzU4?=
 =?utf-8?B?YTRqNVJWWEZkWHhRRmNubUc3NlR0U0tnajVjVi9XdW81STJBRFoybkFWTGor?=
 =?utf-8?B?RDhYRVQrcHErVW51OXI1K0U0SjZweEltWHR3clhuMHhJdzZML0NReEhPMGFj?=
 =?utf-8?B?VHBBdWh1SWRqL2VHSW04TUJ2SjhJNmk3UWFmNjNZc0k5UFI4bWhVeVNXQzFm?=
 =?utf-8?B?MDBIekxQTFJIUWFWak1RYmQrRXRUb3QzbFg4aXJibU1mUXRqNGR6Z2JUUmR0?=
 =?utf-8?B?U2d4YVRrQWM3K3lpd3hoSmlNWDlRSHlJZUx4OXNPRG1od0N4Zm5MZUdQbEVy?=
 =?utf-8?B?amxDczNEQW5WOVB3UUV3Q1c2ajFoUlRkVklVZ3piaUdCK1lTSGV5VXJ1cS9J?=
 =?utf-8?B?VEVKRUF4Q0NLTC81dTdtRzEraVNyVC9sa2w3OHBzWFlHclRhK0dMb0o0Y01v?=
 =?utf-8?B?dWtLRUhqMk5aQ2ZNQTF5eFFDYVZZM1ZvN3BMeFE5MVdoZmZEeTcvVE5wZ3Zs?=
 =?utf-8?B?NzliOFZkRGhDUGJBZEorNU5KSnQrbGZDaVhlVjl4S2thcHB4MldPTEp0V3NT?=
 =?utf-8?B?YWlrZnQwRjhBUlZqTkxSRFl1RC9OdGNLT1IzVksyWksweWNIL0tqTVFCTVd3?=
 =?utf-8?B?eDJhTDFkSzhJZEJ0bGw4WUViejM4MkU4R2Z1c095NUxkYnZwUHF3S0FIaFgw?=
 =?utf-8?B?NHBrcWlVVzRBR1p3MW91U0l1SHFwd1NDdW04a0laS2RvZ3gzWE02OGlsK0pL?=
 =?utf-8?Q?Be3VM3x+GeRMdELXL/uFLjg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cm9rKZSJkI7xHwXf4s4FNuhydIZFGdbRzoJmBwcErlwQstsgSH/CQVCCOh+f80l47xSlnLNRXNQ5bz5fS9opIbVApNhDo22D8wQsUGTmUdHkcHDu1/Hwu5gm5/pqT+zBL3JA0xR69wHkiCD8gMznnIXbwArTHvKuxcUk14VOSHIIn9JDyc2sECeYwAcHTZvNzDeI/6/F3Eiukr4DDlv3NKZ213W2fG43epRupTw0z9wNxITJ1TfEJMw/hrY4PD1lm9XwUJstf5byqhjmS7ConFuoRxMTxTJKp46QREjAyLAUNrcfeuOjOXYX+slKayZeYac8ATcxwiQU5LPMUuEcKsEAScvpZNT3R+W1JLlEsuOv46LPoe5+Mr5xvL4G04GXAM21KAPPXlbLMFzYKVdrQsGWqIBH4yz+1h0PRruR2Vw7J2ItqvC1HnwOINQc4eFr96N8IwYnR0/QWNDeHb1+jM57Tl6Ixd7cCUeqNqtlhf8iUzF+4cNRjhIYf5RwL9hpMeUud4uaUadoYF4adDX7MtAgZL9VhDKSMvUObrugJY+zuVkqE54nB5IBKqdE4NTWA7mMd3SibLhvFJOInWXL6C2SGQnsqbWGRHsmzewUbmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddf4828-192c-497e-8ae7-08dd3cb62904
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 20:32:02.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3lrJmcOZCQ9tZUM86rDxnAfRRHap0XYKKFuotgXsxSQdaygtCD2mPcn6vuAQEQWl9MgGknskCB4LdmwPbwNgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_09,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501240140
X-Proofpoint-GUID: yjmb58vDKz8_aKu7Qw3VhkS5WMQba4eE
X-Proofpoint-ORIG-GUID: yjmb58vDKz8_aKu7Qw3VhkS5WMQba4eE

On 1/24/25 10:00 AM, Andrii Nakryiko wrote:
> On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf<jpoimboe@kernel.org> wrote:
>> In preparation for unwinding user space stacks with sframe, add basic
>> sframe compile infrastructure and support for reading the .sframe
>> section header.
>>
>> sframe_add_section() reads the header and unconditionally returns an
>> error, so it's not very useful yet.  A subsequent patch will improve
>> that.
>>
>> Signed-off-by: Josh Poimboeuf<jpoimboe@kernel.org>
>> ---
>>   arch/Kconfig           |   3 +
>>   include/linux/sframe.h |  36 +++++++++++
>>   kernel/unwind/Makefile |   3 +-
>>   kernel/unwind/sframe.c | 136 +++++++++++++++++++++++++++++++++++++++++
>>   kernel/unwind/sframe.h |  71 +++++++++++++++++++++
>>   5 files changed, 248 insertions(+), 1 deletion(-)
>>   create mode 100644 include/linux/sframe.h
>>   create mode 100644 kernel/unwind/sframe.c
>>   create mode 100644 kernel/unwind/sframe.h
>>
> [...]
> 
>> +
>> +extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>> +                             unsigned long text_start, unsigned long text_end);
>> +extern int sframe_remove_section(unsigned long sframe_addr);
>> +
>> +#else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
>> +
>> +static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end, unsigned long text_start, unsigned long text_end) { return -ENOSYS; }
> nit: very-very long, wrap it?
> 
>> +static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
>> +
>> +#endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
>> +
>> +#endif /* _LINUX_SFRAME_H */
> [...]
> 
>> +static int sframe_read_header(struct sframe_section *sec)
>> +{
>> +       unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
>> +       struct sframe_header shdr;
>> +       unsigned int num_fdes;
>> +
>> +       if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
>> +               dbg("header usercopy failed\n");
>> +               return -EFAULT;
>> +       }
>> +
>> +       if (shdr.preamble.magic != SFRAME_MAGIC ||
>> +           shdr.preamble.version != SFRAME_VERSION_2 ||
>> +           !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> probably more a question to Indu, but why is this sorting not
> mandatory and part of SFrame "standard"? How realistically non-sorted
> FDEs would work in practice? Ain't nobody got time to sort them just
> to unwind the stack...

It is not worthwhile for the assembler (even wasteful as it adds to 
build time for nothing) to generate an .sframe section with FDEs in 
sorted order of start PC of function.  This is because the final order 
is decided by the linker as it merges all input sections.

Thats one reason why it is already necessary that the specification 
allows SFRAME_F_FDE_SORTED not set in the section. I can also see how 
not making the sorting mandatory may also be necessary for JIT use-case..

FWIW, for non-JIT environments, non-sorted FDEs are not expected in 
linked binaries; such a thing does not seem to be useful in practice.

Hope that helps
Indu



