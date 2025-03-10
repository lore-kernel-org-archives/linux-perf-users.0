Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7D221DAA;
	Mon, 10 Mar 2025 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650177; cv=fail; b=iDqnXDoKKIdV3c6sbDsKKRn9bL6M5Q8Ek2dBt3CSgosCi+U01JgqYjPzTunjPmon8mVXcU4Yov/5ZtZZsuOVnIO3UXqvdTOQWF9UHxZu4bV0r0X044S1Qhfb3FbQVbyeDI+5S2rEqiiSREbFJ7ZX1wbOT4ZGwr8tg66ZfAN0OIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650177; c=relaxed/simple;
	bh=EGWlMh5mBN5GKIa7wscDgUV8wDb6W6WCdsGfemM2cQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=rtOd5xhBUFTmgHAOKw6XLIUHQ7UYfJb0xDYbXYhQ6/neYB+NZR5oo86uhs2Y3vQsuoCcBa+QO827vCCd6exfFI6LstvOP+2O1vNabk8BJ3D2vuddkZAiRAfPIeKxRlImYUyIQU/Bh8IFvhZzOspKMfuiyV7K1M19hAWSaO28bKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N5Cf9f0V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H/+dNapC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N5Cf9f0V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H/+dNapC"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ALfkIJ025659;
	Mon, 10 Mar 2025 23:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=reBLDrgeJkQMUDTZ2CM87/Sfk0FIV2/w+1iayjwodwY=; b=
	N5Cf9f0VwF83uvtwYTB3Spsy2OvGMbL0wRHkC4tPY2pivQMz8RhQc2lolkZBYqB2
	4DcwM/UyMVn8xpqcAIKPnnsGp+rcTqsZ7qOdpqVrWBbthedi1POUcWBVq/960Ybv
	kftCPZKg+PVOUxlQzcq1UQX86u7MDK0KqdtaY9g5NlkOfYfVK8wCeGZ1qnJTl+d5
	TF1mXX2kxC93AzEHMOQhTJ+qq4kY5Y4jsIfVA1S9reCHD7CQhzIYp633PPIsuzJQ
	qeed9Vb2bjx8rd8X26/4wEnA2pHBh6afzNJ3TZBm7/W7JoxfNEQ4hezZm6FyFA3z
	m0FryIlRRm4+wAFHeTkc/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxcksqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 23:42:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AMX5Vq017442;
	Mon, 10 Mar 2025 23:42:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb8a1fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 23:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODdxH1uREfAH3e+yvpodeLFFM4yuKrPr90FtvzhdJ3/fBvXblUS3fvi6qTBdNFHtmmb+vvyqcDfNYR+jSdrawb3cIxLCNjKpZtMsiK8JQoKFLuTwg5RhYUN2lOsgDuRH2XEqOweorDgjKe+jXn9H+WGP7FezdQqMK7Sm2L4UPd6DZALN620bvBSAYIbb0rBIEK5fA831vmwiD3auyUw74fDrsCxSUemnQrjVlnE+X2raBOgMxR909wrMAupezoS1AHt01/5oIrRlciSsz6N6d+b4/0+d06Id310mUXpOh6sWHUlE87Ai98uqMM9VN0RdAzhjJBnFpOnzzA6b3ew51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reBLDrgeJkQMUDTZ2CM87/Sfk0FIV2/w+1iayjwodwY=;
 b=OtFMDAk5J+lUNcJV5uQ4fAqFIBBpCF3N2cR5LA9b/Hi05XJPmtuyQGE497TEekPva+C2vEnS9Q4LJOqsQTP9CoWOJ6rIl/CuyBSk/6p2wJYjOc6yBzRtgOTKj4Tl6lnEktJtHKaMhEQTRA47r7g3rCxBWqwTONv0hKbvvDz2uNix9GctxXLyma3vFr7aoOawjrRzKWKFSHq2YnKXST4rLNZBu0fqCmoC+mZTlivnB5wZmAji8m+bopnudoUaWsNpbaBIF+nnGk8ElAuNCYhE6xwS3kvsgnWHmctImNtncXGEjpwHBOSThj4Ob1wwFGfE5u3gN1f+GltLM8YWes3phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reBLDrgeJkQMUDTZ2CM87/Sfk0FIV2/w+1iayjwodwY=;
 b=H/+dNapCksOTATpel7w9vw1bMDfz5dGlN58gcFK/G3RHWLlw4JDl4SSwqzzffR1d74S78d9iQdLT6AZ2OfNgO0dMoo1d6p7Wi9bCXxern0nrqe6ohas8NTm+esTOSUj4m7osmeZvPAYkDe0Mmjq26OL4F4NcmGw0ckbPUTa90R4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH0PR10MB7006.namprd10.prod.outlook.com (2603:10b6:510:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 23:42:33 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 23:42:33 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Liang, Kan"
 <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org,
        James Clark
 <james.clark@linaro.org>, Ian Rogers <irogers@google.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Chaitanya S Prakash
 <chaitanyas.prakash@arm.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa
 <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/3] Support .gnu_debugdata for symbols in perf
In-Reply-To: <Z89acl2ZP4j3iS12@google.com>
References: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
 <Z88KyA4PCzhMa-fK@x1> <Z89acl2ZP4j3iS12@google.com>
Date: Mon, 10 Mar 2025 16:42:32 -0700
Message-ID: <874j00wizb.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH0PR10MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5f768f-1dc2-45ab-07ca-08dd602d3ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDg3bmdyeDhNYVNKTmZwQ0VLZjJvZ1RuK0N1dG5ydnU2bENteU1UTDl6cjB2?=
 =?utf-8?B?M2srSkdqa0RTMWpVaCs2WHpDNk96Q3FhWTd3WHh1dExnQTZhbWFFWU9RUTVO?=
 =?utf-8?B?SFBDY2c5a0pMcVI5L1hDb0hlMVdTZS93N2Ivcy9wSEpCMlFlbUdpNGpRb0dk?=
 =?utf-8?B?YXB6WnBsejBJTUVJRmpyWUZqNmhHL05JcXNVNngrUHFNbnVzNzUrY1MwOVNU?=
 =?utf-8?B?dVlHYkw0aW9EQkVqbjBQaCsrR1F2Y2JSMnh6aGI1dmVpSXRnakEwNEY2am9B?=
 =?utf-8?B?UjN5RG0xTFMwSG81elQwMmJDdzFzSHA0RlVzSlVYWVJqS1JtdWtJL3F1Nm00?=
 =?utf-8?B?ZEdvck5kSUtKR0p5OGxtV3RML2YrU2NMbXBpNlNtZXZqN1VjSEMvbXVBRWdR?=
 =?utf-8?B?eEN1dkRuWWcvUStORGxUQ1BZdWpTUWZBUitqU3Rmanpabm1WalFWbXMrbWM5?=
 =?utf-8?B?cHJuemtGdmFFaTEwdGJpaEJkNzJidk44cnc0dkRzOXM2Y242R2dRT1prYXhC?=
 =?utf-8?B?bk80bVVHVm1vK2Z5S3JRNkJlVGp0cFkrS0hzVVV3MzAyTjB1MTkvRm5qYkw3?=
 =?utf-8?B?OVZyb0hxZ2RSUnY0Uk1vOWFqUkFydFZRREVuM0ZJQ0s0bXkrQU9MZUlsOUtQ?=
 =?utf-8?B?bEV4UDJ6eTA3WGVqZ3hQRUd6Tlg3eStmV3B5Tmd1dloxTlNaaHJQckdJbEdX?=
 =?utf-8?B?RUVxZlgrUmRpSkdqSEFxU2JkVmtIOE5jejdmZUo3eUdtbll5WGlSQzM3MDJu?=
 =?utf-8?B?dTdyVDZLWE4rTVZDRDAyNVBlQ1c1TEtyR2VReUE2TEx6ZWtERmtTY0RLYXVw?=
 =?utf-8?B?M05DWWtkM3dMbTkybS9uZ2prWWxHdzNSTDloOElLaUNOTUZaeEdNRHhvZys1?=
 =?utf-8?B?MWZHM3ozd3ZuNXZWVExyVzMxbFlGTG4wTXF2R2lRdXdaWldzOXpLcjJZR3RD?=
 =?utf-8?B?Z1VkN3AxOXV2MnNNZEVEejFIR2h5djByQitFV2FpQU1uamxCeWMwd2JCVEJk?=
 =?utf-8?B?NFgzZDNRazFoN25qRWsxVEovNlBTU0Q1TzRyRFhCZ2U0a1pDUWVTb3ZYcy9t?=
 =?utf-8?B?MjZVSVlCTHovczF0WFAxU3RLRm5GOGFsRVVoNFUvMmZqYmxPS1Vnelh0Sy9q?=
 =?utf-8?B?S3hFOWcyaDRXakovbGVISjMxVnBHemZia2QraFRybUR1RTF5U0pOOXNYalBI?=
 =?utf-8?B?SlVBSzhNbDA0RzgxVGk5WjFsOFZrRUZnbUlLSnlXTHd5N05OaGNPdTJVV3A2?=
 =?utf-8?B?M1V1MURHaUJXa1BxNnk3SnZxUUloUXliYnJkSnVEVUxCWGdFMXUvb3dGQ0Jp?=
 =?utf-8?B?ZFZtZVEvSklsNVVEUDBEYkd1YitJNStzNFAwdDlIeEg5c3YwYzBLQTlVOURY?=
 =?utf-8?B?cjBIL1pqZkJJZUJRZG01SkMwQUxKR2lDMC8wYXE5N0JLdjc2SHVTUzQ1dCsw?=
 =?utf-8?B?alAyd0d0TVdpeE95SXNuSTZSa2s1NzhUVGdHd2FMTmltUlFvZ2d4MitZL3NF?=
 =?utf-8?B?a0xoVjdXUFQzREpWY09ZdGhQbS9GYnY3VmZGdE01SEMzclNVTUgxMmEzcE5J?=
 =?utf-8?B?Tm55cTRxdXJXa25OVVhMR29kZGM5ZExEY056OUJOdFBOMVQ2R2Z0KzVzZkRM?=
 =?utf-8?B?WkphUHVNQTByazc0SjdiOGVyZXF1TmtrVTlwSjRhSFNpeXVwV2x0RUQ0UzQw?=
 =?utf-8?B?MjRUWUl4V2oxVnBEeHc0ZnhqblEyNnord1ZEeCtnbXgvZFM2TGZ3bHVNR0ZL?=
 =?utf-8?B?MXAzQkxnSDFzTysxb1hZTXRuTHZZQThJL2dkU2ttUGIzSXArMWJGdkpjVnBH?=
 =?utf-8?B?MmhvdDcrYnNvU2NodnRhWFROY1dOVzJ3MERyeXpkL2ZtZEtQekdlNm5PbnpW?=
 =?utf-8?B?RXRpM2xyWENwQ1JDcDRXY0JrRTFNaFcyVjhBTG1YaGNyUHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3ozTmE0TE1raGpadTVXRHppK1ZGd3F5WDhHaVRnTGxvSVlacnBHWE0vSkk2?=
 =?utf-8?B?WG04dzV3a2dYOTRMeWJqVyszVnJESkRvOUlyZTYxWVJuZm1yd1BPd1ZRWnAz?=
 =?utf-8?B?ZlovUW1XVXpJUGJVZW9HV3JLbmsrWTFJODR5T2oyNVh4dzlQSEN0aHRZa3JW?=
 =?utf-8?B?SGM0WmJlNnQyV1pHOTFOL3p0dG5BbTdQRno2V2NoQnNSMHJyRWgvL2FGZDQz?=
 =?utf-8?B?R0ZuUGRvZkNaa2NBS1J6STVUWlNsRHlsd3Q1V0E4RlNBSjFwRmNvTnh5c1Rt?=
 =?utf-8?B?QWE5MDNPNGtjbnhmYW9YMWdhZ3o1a0M2bG5wQ2xzVXZzUzBndDQ5a1dKVXhD?=
 =?utf-8?B?SGlEY0ltbVdGM2w5R3FwVFh0bEdCMnRjMDAwSGhqRFNOWkRydWd5Tm9vWVNl?=
 =?utf-8?B?NXN0d2R1RmRRT01rRGRGQzRXMUtSbHp2WVh6ZVhSWmlCZUJMc09MVGtYbUh5?=
 =?utf-8?B?eVpFem00cnI3TXVNaEtrSGl0cGRYWElIUXpCZGQxSFVsNlFTQXQ5RFYyL3pR?=
 =?utf-8?B?bEozTEpyVFZBbmlLRFpJRVFJREdKc3QxZ1VITGhUenBDT2NDOVZESUw4UmNP?=
 =?utf-8?B?aGpOMXZEYlp0M0YrOUU3R0pvTGtGTlAzci9PZFl2dnRSUkZDc1dUZ3FSQVFQ?=
 =?utf-8?B?MHJ0cnlCY2dsUlNkWEJQbVBaL0F3MDd5NEs5aTA4TW1DR0psY3RGNmR5dmlz?=
 =?utf-8?B?TnJ4cU1KUWdxelIwLzJOa3VVYVFWZFFvckxhU2o3THE2R0gvV1I5dFRGS3J0?=
 =?utf-8?B?eU1NZmJkYjlHN1pOZTNDSW9xSVRNMm1PaE05cnRiQTllUURaQmlsN21OSisr?=
 =?utf-8?B?WGZ6eXI3RHQvamZYUVlMT0NFZUp2dmxKQzBOa2cvdC9Mc3hkR3JocGw3bDJh?=
 =?utf-8?B?T0QyRUZGREk5MFpxa0FWRlVpWGpJRUNFMGJ3QTAyN0NXZ3NjbXRUVDk4YS94?=
 =?utf-8?B?aUxPR3hHRlh2Rzh2dVA0V2NjbzZYbWNMcDFwaDU4QjZ2ZWE3a1VpMG5XcDhS?=
 =?utf-8?B?S21hUnlyNVRVMXRoNWhxbU5ZQW5JTEt5d2JTMTNKQlpTSUZhN3R6ak9scVFX?=
 =?utf-8?B?VmQyK1kvckRMVThuQTZKRG84VkJDVjNQb2tNNlhpWmxBR2d3amFwMzlJZ0to?=
 =?utf-8?B?cmlBdnFWM21pejh3VGp6UXhMNU1yQ3R1U3ZrakhaeFI5d21rOXpiWnJPSTZ3?=
 =?utf-8?B?VkNkWGY0aW1MTE1COHNlZXZVQ3FkU1A1VTROTXlFeTZDdW1ZdFRlOERTMEs4?=
 =?utf-8?B?THFnR0lVc0Q2dmZXVUNUaWczMlgyUi9FMWpCY3g0ZkNFSWpVSTRkQmJSaXpa?=
 =?utf-8?B?Mmw3T2E3Z1g1UVpNMTRRTURjeWhYRnpCL2wwbCtoT2VlMTRiSWo5TXU0WWRJ?=
 =?utf-8?B?Y3NmT2J3aVpMT2tPMERKN2g4Vm51a2U3d1M4aFhhekEvZEtuVDZiMERObGRu?=
 =?utf-8?B?SXh1Y001VFU0Z1lSSEVhVWFFenA4cE4yc20rNmJYYlg2bzhSRzFZRUY1alhW?=
 =?utf-8?B?c0lJYkR2RHlZYSs1ZXozQXozQ0Q2YnZlbFU1R3o4WXRnOEVXRXZlaXpxcWpD?=
 =?utf-8?B?YkFZcHlGNEMrVnc4SWNDTS9kVWJxVEVKd1MwVmw3UG9uZ29uMStLZVpLS1NM?=
 =?utf-8?B?Z24yMXEvT0hJS1c1WG0xWEh2eFA4Um1BRGVUbkJRcmsxbmdnRmNuOEUxdks1?=
 =?utf-8?B?TkxEYW41ZWMyY1dBWG1vVUsrYytIWFE5UmdtMmViQmhpU3JVeHBveFFQSVZ5?=
 =?utf-8?B?K2pwTHY4dlo5MHdGQmM1bjVuckg2bGF4L0FiODhVaFBsZTNwM09QTERGREoy?=
 =?utf-8?B?QTVLSVg5RVBPZmhOekJLTE1TemM3b2ZScU9YTGRrOExxVUpqV053bHVsejdJ?=
 =?utf-8?B?NGV4ZHZaTWY2bXc3a3FCblRnSUJJUSs2Sk9MeW9WaVB0ZXhMTk5QUVh4Y3JT?=
 =?utf-8?B?WDIyc1h6OFNZNnFwTklVbGRzYm9QYUZITTVPRUpsbXBVZkgrRWpSUjZ5M2hQ?=
 =?utf-8?B?VCtvdmp4SjIvczlFYUxaSytzeXJWajZ5NStDRERLQUU3WThMa1Z3cjZ2Y2J6?=
 =?utf-8?B?L2E2M0RKbXhWZlZ4YUdDOXpESzJZdmMvYTFUYVhaV1VYMzN6QzdxSVd5MkNU?=
 =?utf-8?B?bWwrWlp6bWs3MFZEUjB6T09SS005Y2s5RGhtTFg0Z1dOWlg2em1MNUNScWxW?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9IzcNt0xcgAR/4JEl7aq7b4SX+CxQyCeAqSO4JeDmUNlzykIh3ejBFN7bf6l6chN3H8+vQUnuv37rwLenwoMu7+AvNTTCdLEHHga8HMupvuIP9iTjku3Pv7lDdwo2hkidNHecL4u7xTZaB64P8uZe/8sIFDX+AJd3xVlS39kLGIxEzCFBVNPMEsYlO4B3yb84G7qNVgAm+iwVGxjz0ZF/ZZURbwbK3Uamxpv3jmtHnbB9hGqd0cr1pDpKHH+LpkolNbK60p+a3syco/Zs+9vIZeMzn5w826xdYgznJdz8mXo9/l4vdZjB4RITYzYIhwIFKNjTPcK5PDcZ5Tc8q14nF8jeCPr2sjI4uFW8QHRk/KIjUCUvjxWeVbcAK85ghkmbJlbWlXjhD3KIlFzNFMqySxkwWGEuvVSEzzblA4LX//WWk6af+Hpr7UxZ3/aPuMWP7NnGSo3OlOSlsyqJKRAjFqxnoBAzsNjk88ir7fVv+4B/Su6HeMts2adkCvWD/s3KgypogjS34YutesvQxraA8zKgzT5ZaM/mLzbJrWxKpHpKPQ2WiATFpfNm/W8m0q6WZp84EgxzCH6xFJl2qmo7yj6iYsMepqK1lOeCcQiHlA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5f768f-1dc2-45ab-07ca-08dd602d3ab7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 23:42:33.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmMWP7ZpV12IfG1+20sOG7r5b1tCDpIAufC1Z0/VFUbMjGrlGRLDb7bZFRT7I6io2y/u0fdTe/pG8szOK2Of8GgmPGQ9cDCWU1yg9VIUCAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503100179
X-Proofpoint-ORIG-GUID: w-qwDO3Zqexrx3afBNpHk7K6MAMFgFHr
X-Proofpoint-GUID: w-qwDO3Zqexrx3afBNpHk7K6MAMFgFHr

Namhyung Kim <namhyung@kernel.org> writes:
> On Mon, Mar 10, 2025 at 12:52:40PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Fri, Mar 07, 2025 at 03:22:00PM -0800, Stephen Brennan wrote:
>> > Hello all,
>> >
>> > This series adds the ability to read symbols from the ".gnu_debugdata"=
 section
>> > of DSOs. More details are the cover letter of v1. This only has one sm=
all change
>> > from v2: it adds the missing entry in dso__symtab_origin(). Its lack r=
esulted in
>> > truncating the output of symbols in "perf report -v" -- thanks to Arna=
ldo for
>> > testing and catching that.
>> >
>> > v2: https://lore.kernel.org/linux-perf-users/20250220185512.3357820-1-=
stephen.s.brennan@oracle.com/
>> > v1: https://lore.kernel.org/linux-perf-users/20250213190542.3249050-1-=
stephen.s.brennan@oracle.com/
>> >
>> > Stephen Brennan (3):
>> >   tools: perf: add dummy functions for !HAVE_LZMA_SUPPORT
>> >   tools: perf: add LZMA decompression from FILE
>> >   tools: perf: support .gnu_debugdata for symbols
>>=20
>> Next time please follow the convention on subject lines in tools/perf:
>>=20
>> 36e7748d33bf6a82 (perf-tools-next/perf-tools-next) perf tests: Fix data =
symbol test with LTO builds
>> e1f5bb18a7b25cac perf report: Fix memory leaks in the hierarchy mode
>> e242df05ee5f2ab0 perf report: Use map_symbol__copy() when copying callch=
ains
>> 4c3f09e35ca999f6 perf annotate: Return errors from disasm_line__parse_po=
werpc()
>> dab8c32ece27c7d8 perf annotate: Add annotation_options.disassembler_used
>> b0920abe0d529101 perf report: Do not process non-JIT BPF ksymbol events
>> 2c744f38da7aeae7 perf test: Fix leak in "Synthesize attr update" test
>> 41453107bfc30083 perf machine: Fix insertion of PERF_RECORD_KSYMBOL rela=
ted kernel maps
>> e0e4e0b8b7fabd8c perf maps: Add missing map__set_kmap_maps() when replac=
ing a kernel map
>> 0d11fab32714a2da perf maps: Fixup maps_by_name when modifying maps_by_ad=
dress
>> f7a46e028c394cd4 perf machine: Fixup kernel maps ends after adding extra=
 maps
>> 25d9c0301d36f4d8 perf maps: Set the kmaps for newly created/added kernel=
 maps
>> 99deaf5578cd768f perf maps: Introduce map__set_kmap_maps() for kernel ma=
ps
>> 74fb903b212925ca perf script: Fix output type for dynamically allocated =
core PMU's
>> 957d194163bf983d perf bench: Fix perf bench syscall loop count
>> b627b443ccfbdd2c perf test: Simplify data symbol test
>> f04c7ef35256beea perf test: Add timeout to datasym workload
>> 15bcfb96d0ddbc1b perf test: Add trace record and replay test
>> 38672c5033c3aebc perf test: Skip perf trace tests when running as non-ro=
ot
>> 3fb29a7514e727ca perf test: Skip perf probe tests when running as non-ro=
ot
>> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>>=20
>> I.e. perf, followed by the tool or class (machine, maps, etc), followed
>> by : and then the summary, starting with a capital letter.
>
> Yep, I can fix them this time but please follow the convention next
> time.

Thank you for the fix-up! I will use that style going forward.

>>=20
>> I retested and everything looks great, so please add my:
>>=20
>> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

And thanks Arnaldo for the test & review!

Stephen

> Thanks for the review!
> Namhyung
>
>>=20
>> >  tools/perf/util/compress.h   |  20 +++++++
>> >  tools/perf/util/dso.c        |   3 +
>> >  tools/perf/util/dso.h        |   1 +
>> >  tools/perf/util/lzma.c       |  29 ++++++----
>> >  tools/perf/util/symbol-elf.c | 106 ++++++++++++++++++++++++++++++++++=
-
>> >  tools/perf/util/symbol.c     |   2 +
>> >  6 files changed, 148 insertions(+), 13 deletions(-)
>> >=20
>> > --=20
>> > 2.43.5
