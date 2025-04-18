Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E951DA21;
	Fri, 18 Apr 2025 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744951775; cv=fail; b=eFUxP5o4ottPyGwZ/rJiSV0xptGADD2YC1KPPIGs2JcSg6TJ2Gq8CFn1071LuKHQQzIcuV8y4fU3NgKwL5DcmgaNx7tGm6Vn3GLsM2tfywXCX8+dxyv+WrbJxpeBQgOQ1bOMYoPSczbJkNNhgmexsRFIB/ibeJBu8WfQlTwEPU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744951775; c=relaxed/simple;
	bh=tlG1sp1LYwO6RgtX23JbHdAPoXUNibBm7hLmJ/dRrNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j5K5IfdGu40k0QJXxxhEyoD0eqo3kcXiVF45vRYAnaWG9xiDPUm8Qr0WsxHK+2j1579pg7hmgu2BFmBNQnf/kqB5RMSZlOKUdGJSXI97gO+YtEpi4S6XFGCKZpha0DhzJIIOu8j45IfaupoxaksMHto9YPajDTAU5RMl9ZM7+PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5gor6cw; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5gor6cw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwYl9N4f6lVCw8NkDXPdtluwnw5/kjJ6C5/l1kcwWw3F9wWF1K2e1i3AZ6KrllGN7dSX+3XewiMi6BJ7Dteq8Lsak4yPFuYoXNAiHiU1bcaPMg5f0INNH/YT0psE/WSLwdFTXf2EWwh0aubOCCh0VnPCWz1NWmq09I3zd4HOC08YGHQ6HBmn0n+1asx/fex2bJd2tODHENzPLAkaxqsAUxYbKvauz2DlGl+BA01iFVsydWWHz6Uaz/tPDCnGvgIIhY7LsVycmIn75hb2YzbomHFLWIVCytjRHq5KqHV4iE7tqYPxJctXr6KXaXszZOz/TX7DF9LzbPugPF0WipRkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVLkgnULzc9IKq9XmkMAEEHyXDQ1NcS8BWRsAMgD2FQ=;
 b=gAZr97sl8dkKlCEJgPZZuMLvS0YUxJPEVj+CZ4Y+ZS7Rsdsn9lznFLWgTTdi0VB2sxcIQqmKtUdmcouVqZ9r9FdF+BzMLg8asMYjEZhwzxtAaVR2BlY2oJbf8sT5Pis1v7AOW01dSTddzotMkAk8WipvKX0Jpi/mtxk1kWyZuetYTlzWp4EbX9xUOMMHAi/rAGYt599Bl3FFIfx7g+XLcTXAL2dvbREAGe2BygN2wHqyDciZFc2dbVBkfycaimguRVgJ8rGG/Qt4RU9mcmlMbwGpz8OBA8cJE/ZXbpqpL3IcYcesRw/PtEmxhnUG29Su9hWzQPdHEQ20jcteWxXz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVLkgnULzc9IKq9XmkMAEEHyXDQ1NcS8BWRsAMgD2FQ=;
 b=E5gor6cwaUh8xITx87DXOvoAhGGHRCIdf1YNlOsmSHrrUPIOI84N9P5OaW1v15PBwrTnEjNYqkXvXOXL7Eba0ivjISTFWkheMkPkKYEPXle+i/L4zg7Nf1xXsxdwdX0KGq/R4D8WYJ43qyRmEvIk+EEssEv4eyQ87VuDjuiiJcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 04:49:30 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%6]) with mapi id 15.20.8655.021; Fri, 18 Apr 2025
 04:49:30 +0000
Message-ID: <0c9f534d-a782-4e42-ae44-5d6ac9b51d25@amd.com>
Date: Fri, 18 Apr 2025 10:19:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] perf/x86/amd/uncore: Use hrtimer for handling
 overflows
To: Stephane Eranian <eranian@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 songliubraving@meta.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <cover.1744906694.git.sandipan.das@amd.com>
 <8ecf5fe20452da1cd19cf3ff4954d3e7c5137468.1744906694.git.sandipan.das@amd.com>
 <CABPqkBS+k4Om3-sQWGBFN-imhiU8fXYsiDR1XAyp0Ro3uknCHw@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CABPqkBS+k4Om3-sQWGBFN-imhiU8fXYsiDR1XAyp0Ro3uknCHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::11) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: 938eea49-0601-4e00-5b95-08dd7e3467d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXNTM0JVWmszNDl5OVM4REhGaFJBV0pTUjhvc01UT3VHYXNFMUVBS1lMc0VD?=
 =?utf-8?B?RzJTVWNoNjVnNGU5cVBmbUNibGZCMGNua092enAzNVFHNGFpaUp3UmhLNEk0?=
 =?utf-8?B?cVAwMUNFMjZzRk96UjZlTEkyeFFwbk10eXhnMGVwc1lrVGF4VTBJWVNidTdn?=
 =?utf-8?B?Q1FTOWV5aE9MbmtwaWRpaTEwZGU0djFhVmNpT0E3K2Y5VkRXZkgxSWhXOVd0?=
 =?utf-8?B?TkhPd1JtTDBFUXV4Ry8zNmpwR3RiSWhBRXIydkV2OUtFMzBYWHA1dGUrOXdU?=
 =?utf-8?B?RzlsRisrL0tEVDZ0dVB4c09HWTRvVnFqeXJPTjBYbTdUMzhsVVRvbk16dlBC?=
 =?utf-8?B?aFZJdEZ6b1JadHdobXAyTU54ZnIxZm53VzdxNWo4a0VMb3k2bkV1V0FETXcx?=
 =?utf-8?B?NjZDYm1VakdhNjZyd1pOYjJ0VmZVSVRQQ2tnclZVcDM0KzVJSjZjOWVEWnJM?=
 =?utf-8?B?WVRpZnpaYkFlS0xOOEc2SU5IUXBUeDYzSEVzL0doWTByeGFvNlJKVkd0dm1Y?=
 =?utf-8?B?cEUxZG1rTzFYZGplVXpHT0VwaFp4aFFBQUtDUHg5VTBYWFhwQ3hQVmQ0b3lX?=
 =?utf-8?B?ZC9peElSbVVVeXZhZ2xaaHVBTURjdjNTczdCemNRaHNBelRhNDZnT3hOZk43?=
 =?utf-8?B?K0FDY3Q4WHZWOUVma0lnVGw0K0hNTy9vUGRiRVBaY1NPakE4R2cwS3ZwMHhj?=
 =?utf-8?B?eG5peG1tbkVvaXN5RGhKZ1NlQ2tDeCtLSkJXOWI3d3B6TGhUSDQ1dmo0VktR?=
 =?utf-8?B?Q09kU3ZTNG1XSnJUa2hiOGNvMVlTeDEwVXFEYnB4d0tla0RSMXM5Zi9POU83?=
 =?utf-8?B?bDlHSXYvQTl5NHRNbVFXYUd4akZad3kxbjAwUSs5WmprTTN4QVdOOG82c3hR?=
 =?utf-8?B?T3QveDVhYTVMNGNtZnlEazdjVVFrZ282aEJEVHlvTlBUTkhjOGEyK3NKTWxQ?=
 =?utf-8?B?cUJVODhJOXB2Zm9KOXFXb21ibm0xamFQbHNtL3dtT3pBekgxQjBRYVY1TndM?=
 =?utf-8?B?YXhXRm1GSkZtYW9GOWNWUDJiZGNOMWxMQXcvZXcrSi9VWk1tS3lPY2JkdFgw?=
 =?utf-8?B?cXg5THFIc0Z1UU5CUFVxenc1VEVhUWlPVlBIemFaSXFVTEpGOWpRL01WYXNU?=
 =?utf-8?B?YkYzQkZoZmNyRnNXYWUxVHhucXhLVkRscTUvUjU3ZlM4Mm82TVhzcXpRR3Uv?=
 =?utf-8?B?T0ptQmc0S1d5YkVtVnAwZllhUHdGc3NYeGpibEJkbit5VE5ZZDVUekh2V3VV?=
 =?utf-8?B?cFpNcVRUTGZCdlhWeHBrM1JyMnpRQ2wxbHlEVG1PNURsNHNvaVRtRkJzR3dn?=
 =?utf-8?B?TEVNL1lzOVMyV2hEc3QyNGxhdjJFL3cvMC9OTUlNbHo4TW9BYlRwOHhNcTJ3?=
 =?utf-8?B?T3V1K0puYW1KWnovQXBaSlBobTFmT0w5VFprcVl6bGREc2NSOVorVU13NmRJ?=
 =?utf-8?B?dlNETlF1Nk95eS9GK0NxN2o5Mi9GOUZSWndIakJ1bjdWdUpPbFM3MVo3dzl6?=
 =?utf-8?B?UE5BdXhRbmZyOWRXcUJzcWk1Ylp1K3AzZGdUcFB2cXFyNnZrNUxBRDNhd2sr?=
 =?utf-8?B?U3JDN05uL2RDeTQrZmVOcG15TmJkUGNDcWNvYUVRQ2dITzh0UGhRbGMwT0o1?=
 =?utf-8?B?SVdlWnB4YmtSTnFaM1VGc2hXQTNRRlNEamNaT3RFeFF3S2Fad0xnZjJHejZJ?=
 =?utf-8?B?VW9NNm5jOUNnMFM5OHVMR1NlQ0hWeXZ5bkFsZkVJbDE3UkpBajhyYmZGRTlr?=
 =?utf-8?B?VitDMFFGNjJMZHFMS29MZDhiTThqZmU3cHdvc2Z0aGtldS9zZ2dBNFh5SmFt?=
 =?utf-8?B?N1NrTXZJL01FYldJUUlISjQyVmxnVFdHTGFwR0V0NXpZdDNHQnI3S1lDN2Uw?=
 =?utf-8?B?MlNCV2c3TjJsTnBjUy9LK1ZMQ0htRndmUStJN2tNOGxuZVFFbkVTaG4yaDdH?=
 =?utf-8?Q?0fSbYRzI354=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTlWR2p2ZitQYzFUZVYxTHhEMi9zZlYxVmliV3NMbmR0Ymd3Z0x2WEpudG8y?=
 =?utf-8?B?ZEpWVkFSSUhvVjA2cmMxcnQyWkJxMFZaSWFXYUxYcW1OMTdDQmYxWU96ekdE?=
 =?utf-8?B?SDFZUzBPVmkvVkdtWUZvejhRUVdMaGV1VGV3aHNMSGNscDM1aXdRR1dvbk5M?=
 =?utf-8?B?cGYyL2k4RlVyL0VqQURaU0pZYVVmUWNOTnRVVTk3MmQ5aFIyaVVnbjRDM25j?=
 =?utf-8?B?NEc4RllSV0hWWkV0VjFDNy80NW5YRlNrMm9GTXRJZ0JtdFYzakRiMDI5Wjhi?=
 =?utf-8?B?TDhhc0pkd3gvQXRpTlZkYlZjam5yWDdnMlVYaU0xWmZZckErb2ZqNGZidm4y?=
 =?utf-8?B?U2lseFcxeGNKR29SWUovU01lS3I3djltZkJmOEY3NVRFVmN3M1A2ODRTUTZh?=
 =?utf-8?B?Y24wcUhYSlFoeTk4MzhrWjRnRllJNXZjTEtTR0FHUUVoTTlTMVFSL09hZ1dI?=
 =?utf-8?B?SDN5d05lZFhpVkkxaDE5NW4xbGxQWVU4d3Y2NTEwd1BYNFNCQzV1RTJzT2Ur?=
 =?utf-8?B?Rm1JWDBwMDJSaUpJc0pScE11dVhDVHAyZkZnL09RTmZrcW5RRGR6TEU1QUhM?=
 =?utf-8?B?em1XaVdRTHVqWkNBMnpBeUdxc2tqSXVtSTBGckNXSjRkVHcwYWNmSGRLSDNh?=
 =?utf-8?B?UEhjZVBJSEEvYTJPdjVkOWFaS1RzVkFxZlRHM3ZUdmNnZkNHNDZKR2xnS0s5?=
 =?utf-8?B?VE1EOE5GNU5UMVJFUlV0S0s0WktrNjNNYTRiaThsUlJ6UFR0clBMS294NHJH?=
 =?utf-8?B?SDBJTUdrVFpmMkhUb2hNcWpoeFhzZ01XNzlocHZEdU5WUmZnaFZJWkc4NU1O?=
 =?utf-8?B?NlQyVWMrdkI3N1NnaXdaWFV2cGptaVNhRnJ3QU5aVHdvM1ZpMUU3M2JpTzI5?=
 =?utf-8?B?RjJIaEVyMlIwc09FODJjSVRoa3piQ2VOd1JyaEpJbmxNUGtBOXRvTWUvblRG?=
 =?utf-8?B?Q2p6NlRqSGlkQS8xdGRpTVFWUVIvaGNlWHRrQTB0M216ZlVLYnZGTTZoemFY?=
 =?utf-8?B?a2E4S3ZSdjkrS1ZXZ2NoNDF3NUdma05rYVQ2NGI4OUZtTzJuQ3Vzc0FOKzFQ?=
 =?utf-8?B?ZWxpQmVMZk1GbXJPWWE2MEdaRndUUnRhazRjSGJlZjVKQXpiTlQxMTVENnY0?=
 =?utf-8?B?cTR4MzJtbW1qUHh0dVpsUmN2MjVTeWp6RGFCOHBBellsMldXOWM4RXBqTkEv?=
 =?utf-8?B?dDhwaUFNdjk3NlU0VEltSXlLOTg4R21DTUFiK2tQeUdIYVZIWWJLaW1VaTg2?=
 =?utf-8?B?UE0xd3YxdTVIUWhXdkhWWXBiVGNkTjB0RDZuR2ZmZkZpQXczb2hUSkFMR1dZ?=
 =?utf-8?B?bUZsTVZCVUpzMFp3UVExQm1wcVB1YXFuY2ZTNGJRcUp2UWJZM3dUanVMQUo4?=
 =?utf-8?B?VCtzdUN0eEFvajRWSnlDYS8rcHQ5YlZGS3Zmb3RTNE1EcjBaZUFETkxxSmcr?=
 =?utf-8?B?RnczQll1czlvSXNpc2prZ0g0N01zMVUzeUlRdUtCVkRsZUQ2ZXgwTjY3TFNH?=
 =?utf-8?B?QTcwdG9wK2RlU25CbHdYNFk2bTl2ZEFjQy9uZFBUOU1JNUd0aUtjTFdaVFZv?=
 =?utf-8?B?dTB3MnBqWHVDWTNzTmJLaGFIdzNxQkdZUE02UElLbHEyZDZhcW41VitheHNs?=
 =?utf-8?B?eXA0cDd0L1M5UlFMbmI4NjNQaTdIci9weEpvek5EeDBoT3pLLzZpZ2N3SUgz?=
 =?utf-8?B?M0E2bnBkb21kT3hYUmtFazRsd3hjNEFqaE50MGtNR05EejQremdYaHZLVkx0?=
 =?utf-8?B?dFVxV3dpYjRkRzk1K3Rxc2xKdzUxKy9LRVN0MWt5NTRmdXBSN2FFSDJqMW9i?=
 =?utf-8?B?cjl2OE9Nck1HQ2hkbXY2TDYwQ2RVQTlsRStmbkRZSWplbWlrejlja1JoZmpr?=
 =?utf-8?B?elU1TzZjb3BCZExHaDNHUDFydzA5ay9LeHdTZHFqeDlhQkd3MFlGOExhUTRO?=
 =?utf-8?B?LzRaMXkvNGlYOVF2Mm9LRzdLMUdYQlY3WFdOSkNhaEFnVGJTdlROQjliVVZ4?=
 =?utf-8?B?ZTNNS0ViN21JQXJaSVFlNzdCYnBLTXB1L1owRnE1dFJJT2FBY1hENk5WVGJr?=
 =?utf-8?B?RGdhWHYxU1I2amk4a241byt0SUNISjVISzU5YlQ3aVdwVlcrVXB1ZGJpTzRv?=
 =?utf-8?Q?LlVco1GBTKE73Zdn333Lfyqpn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938eea49-0601-4e00-5b95-08dd7e3467d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 04:49:30.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbUmDakld877JNh56BCu2nrmaeDiFem/rbnYqN2CBdre1oC2Mguljs0HnwXnB8Z+WW0I0ck1lbVuA9aDgTERXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361

On 4/18/2025 10:08 AM, Stephane Eranian wrote:
> On Thu, Apr 17, 2025 at 8:44 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Uncore counters do not provide mechanisms like interrupts to report
>> overflows and the accumulated user-visible count is incorrect if there
>> is more than one overflow between two successive read requests for the
>> same event because the value of prev_count goes out-of-date for
>> calculating the correct delta.
>>
>> To avoid this, start a hrtimer to periodically initiate a pmu->read() of
>> the active counters for keeping prev_count up-to-date. It should be
>> noted that the hrtimer duration should be lesser than the shortest time
>> it takes for a counter to overflow for this approach to be effective.
>>
> The problem I see is that the number of uncore PMU varies a lot based
> on the CPU model, in particular due to the L3 PMU.
> Is there a timer armed per CCX or only a global one that will generate
> IPI to all other CPUs?
> 

For L3 PMU, its on a per-CCX basis.

>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  arch/x86/events/amd/uncore.c | 63 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
>> index 010024f09f2c..e09bfbb4a4cd 100644
>> --- a/arch/x86/events/amd/uncore.c
>> +++ b/arch/x86/events/amd/uncore.c
>> @@ -21,6 +21,7 @@
>>  #define NUM_COUNTERS_NB                4
>>  #define NUM_COUNTERS_L2                4
>>  #define NUM_COUNTERS_L3                6
>> +#define NUM_COUNTERS_MAX       64
>>
>>  #define RDPMC_BASE_NB          6
>>  #define RDPMC_BASE_LLC         10
>> @@ -38,6 +39,10 @@ struct amd_uncore_ctx {
>>         int refcnt;
>>         int cpu;
>>         struct perf_event **events;
>> +       unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
>> +       int nr_active;
>> +       struct hrtimer hrtimer;
>> +       u64 hrtimer_duration;
>>  };
>>
>>  struct amd_uncore_pmu {
>> @@ -87,6 +92,42 @@ static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
>>         return container_of(event->pmu, struct amd_uncore_pmu, pmu);
>>  }
>>
>> +static enum hrtimer_restart amd_uncore_hrtimer(struct hrtimer *hrtimer)
>> +{
>> +       struct amd_uncore_ctx *ctx;
>> +       struct perf_event *event;
>> +       int bit;
>> +
>> +       ctx = container_of(hrtimer, struct amd_uncore_ctx, hrtimer);
>> +
>> +       if (!ctx->nr_active || ctx->cpu != smp_processor_id())
>> +               return HRTIMER_NORESTART;
>> +
>> +       for_each_set_bit(bit, ctx->active_mask, NUM_COUNTERS_MAX) {
>> +               event = ctx->events[bit];
>> +               event->pmu->read(event);
>> +       }
>> +
>> +       hrtimer_forward_now(hrtimer, ns_to_ktime(ctx->hrtimer_duration));
>> +       return HRTIMER_RESTART;
>> +}
>> +
>> +static void amd_uncore_start_hrtimer(struct amd_uncore_ctx *ctx)
>> +{
>> +       hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
>> +                     HRTIMER_MODE_REL_PINNED_HARD);
>> +}
>> +
>> +static void amd_uncore_cancel_hrtimer(struct amd_uncore_ctx *ctx)
>> +{
>> +       hrtimer_cancel(&ctx->hrtimer);
>> +}
>> +
>> +static void amd_uncore_init_hrtimer(struct amd_uncore_ctx *ctx)
>> +{
>> +       hrtimer_setup(&ctx->hrtimer, amd_uncore_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>> +}
>> +
>>  static void amd_uncore_read(struct perf_event *event)
>>  {
>>         struct hw_perf_event *hwc = &event->hw;
>> @@ -117,18 +158,26 @@ static void amd_uncore_read(struct perf_event *event)
>>
>>  static void amd_uncore_start(struct perf_event *event, int flags)
>>  {
>> +       struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
>> +       struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
>>         struct hw_perf_event *hwc = &event->hw;
>>
>> +       if (!ctx->nr_active++)
>> +               amd_uncore_start_hrtimer(ctx);
>> +
>>         if (flags & PERF_EF_RELOAD)
>>                 wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
>>
>>         hwc->state = 0;
>> +       __set_bit(hwc->idx, ctx->active_mask);
>>         wrmsrl(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
>>         perf_event_update_userpage(event);
>>  }
>>
>>  static void amd_uncore_stop(struct perf_event *event, int flags)
>>  {
>> +       struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
>> +       struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
>>         struct hw_perf_event *hwc = &event->hw;
>>
>>         wrmsrl(hwc->config_base, hwc->config);
>> @@ -138,6 +187,11 @@ static void amd_uncore_stop(struct perf_event *event, int flags)
>>                 event->pmu->read(event);
>>                 hwc->state |= PERF_HES_UPTODATE;
>>         }
>> +
>> +       if (!--ctx->nr_active)
>> +               amd_uncore_cancel_hrtimer(ctx);
>> +
>> +       __clear_bit(hwc->idx, ctx->active_mask);
>>  }
>>
>>  static int amd_uncore_add(struct perf_event *event, int flags)
>> @@ -490,6 +544,9 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>>                                 goto fail;
>>                         }
>>
>> +                       amd_uncore_init_hrtimer(curr);
>> +                       curr->hrtimer_duration = 60LL * NSEC_PER_SEC;
>> +
>>                         cpumask_set_cpu(cpu, &pmu->active_mask);
>>                 }
>>
>> @@ -879,12 +936,18 @@ static int amd_uncore_umc_event_init(struct perf_event *event)
>>
>>  static void amd_uncore_umc_start(struct perf_event *event, int flags)
>>  {
>> +       struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
>> +       struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
>>         struct hw_perf_event *hwc = &event->hw;
>>
>> +       if (!ctx->nr_active++)
>> +               amd_uncore_start_hrtimer(ctx);
>> +
>>         if (flags & PERF_EF_RELOAD)
>>                 wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
>>
>>         hwc->state = 0;
>> +       __set_bit(hwc->idx, ctx->active_mask);
>>         wrmsrl(hwc->config_base, (hwc->config | AMD64_PERFMON_V2_ENABLE_UMC));
>>         perf_event_update_userpage(event);
>>  }
>> --
>> 2.43.0
>>

