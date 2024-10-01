Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3315E97;
	Tue,  1 Oct 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806872; cv=fail; b=t92izZikcLUHP+NjLhCjKCWKmSoR57KVqhbiG49AQeTQLUVdpEe9oxSzFFzzJgs/osNWXIYdtZkldS1UR0Wfd6FuiQT4ngXVl9229YxkUwcjU7JR+Qy7HAw8/P4UTDUnbyrpEvarVUxt522Y9xqLDcaEUa8kbRr1ZZ6Z/11c3yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806872; c=relaxed/simple;
	bh=0TYY1tUy7IZ5YQfhyF/kHZS8GSxfRnPhw9A0sdw9WHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GoccLE4pJ44ezIctwt+z/+KbH2dPtZgtGWC+bqY0QcqO9QsTLlqYML9IQmTcn2ODBu/xGU96VWVCSGkiNVROMsDvV0rE3Fta8pOSNE+w+vFFWm94CcYoca5LYHE3gzrNwPqyV/Heh0dHM01xQCEJAkR5pHM+bloiBZ5yQ3o+uFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ldEywVVu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tdNbiYon; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldEywVVu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tdNbiYon"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491HMaUb029391;
	Tue, 1 Oct 2024 18:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=z8ay8sHDi+XalSt+Ld1ClhSKak/eTUk+l2CCiUrkGPU=; b=
	ldEywVVuSCUKW6f8/fxtOWyyNJZUhgI4GAOm0xNhugsSN28RLho2jMuMTNS7TRiC
	LI5GPfmRR3J76LyL3DMn0QjlGm+fwKKRmjKyYoZ2M4HMioSL1NXtuHGyLAtooEVl
	cjp9rD6kK1VmH8pk21sFFsuVjuzI285EUCxW+6FM7j3+3FNBKmTkQXn+W9wBNltT
	/66qiFCv9NDu21jClO1Z82g3uLBNVuM7LFzWdDOks+55KYOduEqc1pJ433C83YUe
	Da3xglbV3UDUgil/HKkhv32XghelSzTZwzQMRkM5Jop6sM9Cx1kwT+Nk9zWKU4Tb
	UspyRq8/9GBlq+Sf+ecFXQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9pwnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 18:20:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491IHMdf040449;
	Tue, 1 Oct 2024 18:20:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x887wfpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 18:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzPZo7UYHeaZ3KZnselYcbWlTLV9rLz+XBWyL1EpTavSr/OoA6SUL06cuxH7FQX2gMzCzQilu/Fk86hFb2XtpbWvN/ncg8P5pJofqBXS8pvUBdY8clIzoxncGtft1CNulkMEeYbpQKATK4+rOyh9vnJMVG38KExY/7LxvBvg/3TqzZV+8Zlew4Fgv9ezh8tcqwM4QkvM0DfbcbfJYsqxq7uAzYolMwcCwTmnCNrwwoOGWN9fciWhD5a2RnlHGn181WARg1Vj//3S/yoOxmMNHkoPDtG49Z2lNDuagKEBkOdmU4X90Z+W1lywpF9Uq+0NHmvPakT5vqWpvN7w/KREQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8ay8sHDi+XalSt+Ld1ClhSKak/eTUk+l2CCiUrkGPU=;
 b=WFueXrN1mKBWx85mULW2d4/b97Ddq8lZSw2+zXMXQkrfbafd1Fecip4mmyyGr8/9nPbmhXhQoUjwJnvUbWcFe8Wem/bh04DKkQXKf0lNwlXiBGffZ5MoIqjTGeVwbPn8iKhnYDrlfGQ04xoK4FHtq7YX6GmKw6oQZDUndO5GaI9Qfgw2zN+WqSnD6QW1TxMzalyYEBFVe3NRb4w3zNYfY3O6nLVFvu2WuByzRVmZ+R8Pnvau7Sa0ux9DrsxHlNJaHIc2lFdmY2ROuNCO5vB9+enDyXR4cJ/TOy6ZdMXKPnBc9jmhKVNwAffLImSd5UMIvj/Z4KjWuSH7qbzyMh3Afw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8ay8sHDi+XalSt+Ld1ClhSKak/eTUk+l2CCiUrkGPU=;
 b=tdNbiYonXeqJQp9SnK5H7W4vjzPOQ4MsAeuoEBO+afW2wE/gcq+AmRMrkdp9nfciibkfoGQrvQEGcbUuSh9MKtPfTB1/yUScA6Z+/xL/gbJ6aPAIUszD/0PIUM9dQ5s4GL1+Y9r6VaYIxWb6ynHSYKVYISYjxYcc492MHj7tnrs=
Received: from BN6PR1001MB2180.namprd10.prod.outlook.com
 (2603:10b6:405:32::23) by SN4PR10MB5573.namprd10.prod.outlook.com
 (2603:10b6:806:204::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 18:20:40 +0000
Received: from BN6PR1001MB2180.namprd10.prod.outlook.com
 ([fe80::34e:408e:c7a1:2446]) by BN6PR1001MB2180.namprd10.prod.outlook.com
 ([fe80::34e:408e:c7a1:2446%4]) with mapi id 15.20.8005.008; Tue, 1 Oct 2024
 18:20:40 +0000
Message-ID: <d2e7a4aa-2fd3-4b6f-b6e4-66b11e89d6ae@oracle.com>
Date: Tue, 1 Oct 2024 11:20:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] unwind: Introduce SFrame user space unwinding
To: Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <ca2e603ae3dcfa3e836162ed8c301fd4d9fd4058.1726268190.git.jpoimboe@kernel.org>
 <20240914072358.4afad691@rorschach.local.home>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <20240914072358.4afad691@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::10) To BN6PR1001MB2180.namprd10.prod.outlook.com
 (2603:10b6:405:32::23)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2180:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: dce4e420-79d9-4fe3-a1ef-08dce245c10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djFpYnlWL01vcno5T2RDVFJpcDI1SURDc1h5QlhRREZoVGdOdG5sSDF0OWRG?=
 =?utf-8?B?eTdxTWxyQ2JucnU3MHl2KzFkcU5IYzExMVg1cG44b3dRbERVaElkVjVOWXFv?=
 =?utf-8?B?NXB3T0xVZUlQRlo2VkQvK2FjZnJGTEhrS2RxY1IzTGx3KysvcC8xZURMRkRn?=
 =?utf-8?B?UHFlVDFZYmFaZCsvRXN0d0djUU1HSWZMaUZIZTZWQXZWZHlVRWlGcGJDY0dN?=
 =?utf-8?B?ZkUycDh1OUovbkdYMkpObkRzWFZIMjhneGQzWlBCOWh3cDR4blFZVHFEOERG?=
 =?utf-8?B?d1RXU2d3UmJNWEppaXdhbTNRZ2ZRakwwU0YvcVlVYTJUWFdRQXFIUWdSc2Q3?=
 =?utf-8?B?SGlIc2dKSHdHOXkweVNJNmFJR0hKekJJQXd1YlFvekdTR2xMWmZSV0NTaDV6?=
 =?utf-8?B?akp0T0JvMWJWR3ozMmNIa21KbDNMcnZOY201eXFyaEdKNGpORXJsdkNmR3N3?=
 =?utf-8?B?VHBaamhUQ2xDMWJZd3Bmdkd4blpkS29rZ3pRa2lyaXhScnZFbnNjcEMrWitC?=
 =?utf-8?B?cnRwL2FsUGJOMTFOVVJRTmpwUjUyaEdSZG4zamZTVHp3aEtJdnZLUWtLNE9m?=
 =?utf-8?B?U291Q3pDdHR3bXFSK0lxcFA0ZmM1MEN6Qmg3cmxua1YzZFVvVUFuTkZSSmdr?=
 =?utf-8?B?cWtvZzZ2SXQxNHlON1plUGUzaGJ4WE94NzNJdW9jR1hXbHM1R1FaQi95aWZ1?=
 =?utf-8?B?NkF1NUpMc2RDVStQZ045djZ3QkpuRjBXY2wxR1kzbElrRkhmL1owSE8wMjZy?=
 =?utf-8?B?TGNySnM1WU42cytQOXorUXJjY2l4b2NpakZQZkVIK1ZYaW1pTWNTTUpZcmU1?=
 =?utf-8?B?b1JIenZUTkx6OWF4Z0hRN0Y2S3VDUVB3OUJKKzlzQU9HdzgwemxRcnF4bU0r?=
 =?utf-8?B?TldFZVhaU2NkdDhVZVFaYncrcGZIaE9ZQkFhUlB4NmlNYmQ1L3JtMDJGd1lu?=
 =?utf-8?B?aWhmQzZTbEo5SnM3cWVoREU1cHVZUDhzTGJrNzVSeEs2a3M4a2s4VEU1bkZl?=
 =?utf-8?B?MGpRQ2hqUUlyQWZuczllTytjQTRaM3pRd1I0bkVuNGlSeDl4eld3K2xxMjgy?=
 =?utf-8?B?dHo1K2RlN1ZXWDh1NFlhK0Myb1U1M2lWMGtNcy9HWTcwMHJHRGwzT2F4Vlo3?=
 =?utf-8?B?SVhkcy9McU85UWZZL2UvYW52dE1BR2ErVHVqNG9zUXllVUV2aEh6N09MbUt0?=
 =?utf-8?B?WEoyYzRxNy9waFJPM0lrNEdpbHQxdy9hMzVuTGN6K1dPQ01RdmNsaGt2bVV0?=
 =?utf-8?B?UEhsNGt1S3pKbmpHelQ1S0tsdFNvanYrdXNjNlpvVC9YcjZod3Q5ODIwYWFI?=
 =?utf-8?B?eVhReXdaRVpnQWN2Nm5waGViMUVtejJCTXV4SVM1SDVrdHpkb1hoK2xYaXYr?=
 =?utf-8?B?S21GR2tNVkdaUi9jcy9vVUkySDRJMFJzWDh0UG9naVpLcHp3UEJHZUl4R1pz?=
 =?utf-8?B?TW9MbWNYL1l3eFZQL3V2YTE4TnM0WmtNeWtIK3BvRGNFY2xUcXBQd1NtZnBE?=
 =?utf-8?B?a213WFdMRXRmT2JlV1QxbkZBT2NFL2d3bEl0dnMwZU1VZGE5bnFNQXJIZmR5?=
 =?utf-8?B?UDAxV2VPK0QwblBmR2w2dm54aTdOZEhJckFMZVlrbFkwam1QZXRpL09HMDcw?=
 =?utf-8?B?SXNaZTc3UkhFakJYSThuWk9odXl2aHFnYUROTXA4MVNROHArdkRTUnVFN0FG?=
 =?utf-8?B?NkIyZlIvRUVWSDhOOUdZSWg1bVkzWnRqMHFCVU04Vk05T3NGSHIrSytBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2180.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC9zYTBhOTN6QW5XYUJTZS9EZGNUaVhXVG1oWUNXeHE2QjRUbzlxT0JuMmMz?=
 =?utf-8?B?cHk3U0tCbnZuaW94SWxZcXJhaHVSbGV0dmd0SkVRVG5rM0haUUloYVNVbHNS?=
 =?utf-8?B?U2xsaVVMa1ZReStuQS9mR0p0Z3NFM01RNk9OSjlyRlpWMVJicnQ3L2xpdVFi?=
 =?utf-8?B?dW1hWllSRjRpQ1hNMi9FVDZpNXdNRE1BUGZqeHdaNXdtTDByS0w1SDI0Znkx?=
 =?utf-8?B?MUIveDF2NXhudjV1aUR0TitqZFg3ZUs4TFpZNDljZ1VKZUhuUGRMeUE0V0lm?=
 =?utf-8?B?azF3aVZVc1ZENXlPZ3poZ1dLNDJmV1VMWldoY3V5UTBBVHU0VmdVTmdPYjVD?=
 =?utf-8?B?L2NnZDk4R3BoTVZjL3MvcXZiRVRpc24vSE9iRDdONEExbndDWmZ2WEhpUFZK?=
 =?utf-8?B?Z05QQWdmVTJuV0pqZm0vaVZ0WGI1NnZDYzZKK3M2dkhaeDhJWFpXUXJDYTB4?=
 =?utf-8?B?Q05jTG00cS9LMVpqSlY2YmplK1pjLzJrQTQ1VTR4RWlYMWRaM1FzOVN3ZjFF?=
 =?utf-8?B?UDNkL2gxVEJkYWJEQmxONFE5RUQ3dittMkgwRGp5TkdWVkt2U2k2b3p0SG1j?=
 =?utf-8?B?YmJpeVhQMVlPNGVXNGRTdno3bUJJbFlBUGlwbHhtckFuQ2NJcUVzQXlyTGNr?=
 =?utf-8?B?WXVacVloUEpwTXVJYkJ2UG5zY3VsZHBIaEhNS1g5TXhGajV0OEZKVVU0aFdQ?=
 =?utf-8?B?cWhvdzgvWFpMeHZ3eFp0cFY1Vjh6MlM3OEd4eFZqdzVFSFdwSklVQm9qZm9k?=
 =?utf-8?B?RUdYbGtKN1MxNS90V3J4Y2hmcEVOdmd1T0daQ1lqVVFmd0xxUTJxajQyZXkr?=
 =?utf-8?B?akU5MHVMUXhnWWNSb2UzL200NmhsQTliQ2poNHo3bFEyQkE3ZDM3T0oyMk8r?=
 =?utf-8?B?WnF3SkN6MEl2ZkQ2UVovODhKU1ZlRnNZQjRqQzZyekQ1Y3JPbVg5VTVFaUpY?=
 =?utf-8?B?cjRWaW1KYThpeFV0WkNhNGR4ZVlRUVVxRWNPY2NqV2VlRHI3V29IWmNLdi9Q?=
 =?utf-8?B?QmhrL2JEUDR2bFVLU045SFJXaE9jMWlhTEpTRUZ6c3ZKMStUN0ZrL0RlbmNj?=
 =?utf-8?B?KzBZT29mRVFRUDVFTTJETGxXNlRnbGxCaXZ1K2Jua250N2svWTc2cmNTWms5?=
 =?utf-8?B?RHp4ZTUrK1lUU2VyYkRoNXVsa2pzbGtyRkpUK2lrdWREREhNeDJzWmtKZmdm?=
 =?utf-8?B?aTBuanpSMzl3ZXl6akVDelJEdHNDS2Vna2FBaVNoWkZSQUh5T29VRDk3Vklz?=
 =?utf-8?B?UmdBR3lKS2x3alQreUdlOVlySFlrVFlGWTc3cGx6a0NZZm5tc1phK1poMDU1?=
 =?utf-8?B?dVp3c1hBeWhPMlNXREdEL3VFTHo0WUtHZ3Q5d2o0MjI0TWxvWjB0UFdEZEdJ?=
 =?utf-8?B?VndLdENURmdlZ1ZCVVRYRVlVRVcxeUpGSzdaMDlUS0ZkWDhYZlFDbzd4dXhL?=
 =?utf-8?B?cEpjTDJnQThxL1d5RlR3RnRUa3YvUEZUR2Y4VmdkcDBvOVRPQUVMNEJucjBV?=
 =?utf-8?B?cWhKY3ZXcGIxRG9HcVhuT21VczIvblBnR3N5c0YvUVpCb095MG43YmxQbitu?=
 =?utf-8?B?UlJkZlhBZlRDL0RVS3NVWGhaVFBzR0gvUHBzYUNHWnhMTkNWTmtWSllWdzNG?=
 =?utf-8?B?cWw4MEg1RGFqZUhsOTI1VzNjclhsVmpiYmdVaWtOMVo0MWVhQjVINlVpcWFC?=
 =?utf-8?B?WjFnQzRSSFJNbUhndmgvOXA0Slk0WFRNVzluWXdtc3RKVGlzNFBZbHJ0VG14?=
 =?utf-8?B?V3g5K1dMSGp0KzQwc3ozVXhUdzlFQmpuK21ML3pqd1VwRFkrMWtGaWhNc0dU?=
 =?utf-8?B?OTE3MmoyeTZlZVdVOEE1bEVucTdNZVhOYkxoWk4rRVJpVnI4ckxyNjFxRitQ?=
 =?utf-8?B?aG5Ca0tlalNydXFYQis3S0xJaEhDRHpycXRyYjBDZmJEbm4vUHo1Y3hZRyto?=
 =?utf-8?B?T1J1TnBQNkdFSmF6ZWdmNUJpa05MUlVqTmY1MG56Uy9OZS9ZOENzc0xZRERo?=
 =?utf-8?B?RG5NWnVPclpWazc0TDVWeVo0TE82M1J2Y2RqeFlJZ1h0c0R5eVIvS1FwM3JB?=
 =?utf-8?B?Ky9wODhEdExXcTdPbGNnRmw5US94SWVIOGZxMGxnYndnZHU3QVoxUHVRdFJv?=
 =?utf-8?B?Z0hQbDdsaTFyYVNoYzNPdlhVcVJvTk9qQjVKaFNHZVhoR2UzZ0FLWis2Z0Qx?=
 =?utf-8?Q?5HTT4zveUBlUgyOBzd2MoIQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w0z7re4iXCndS0L6FiTvlwJe7SJRqk0K0d2PoZQ72QIsfMoZsefvDLAXGyYFI4zpiqBtPrklrivKSm6i0OK2rL+QVYLsoryhNXH0dJhGyW++f78/pWlE+A9kMUMCwx3/1vdtR1Y4UM7zrGkCpPR4uuUsPvsKsUhUruvgkqR5w0MT28Jay/0DaK5ntZHfvzo9rLKSRgGTyx2B+OljyboC8JNhsRaPQOmYs7nlScjBwOR563zLqXdhcy3uljVl6xmf2CuD+G43nNyEX7+4/Q19ny7fal/zMPTmuC0K+Ph3KmMpuziWcpVsZ/aQtDnJC4aev+If3VNMO82dILRPAcWK8nFvjcvhd1Is5lzt5NQHh1T29VPLEss2XRx0mCC5dxeYKRMzXjHet3VhVoWzD0uRk12byvEDfgRW8ITVJPYPQ5zg9cUVoWwFtoYF09znFPxiASZYIrnT0mkFY3EY/0R6EBJ6yFabE59HzijGJswSPNts/kSYip0xxwCHdv1Z/FrX/CuTTUTD2Tp3nkpsfQJeYeWTmEbLxLCtGZkW5ljpvi/nGfEuRDa08EhRxH8fcTLSczlRW9vv84fkfI/n94CES+gfLPXjCGnY0IlXjtiT/JM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce4e420-79d9-4fe3-a1ef-08dce245c10d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2180.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:20:40.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLBAj4Efw2ZnjI7jWvllrEeY8X34MjP4kY5V8UcBO92jNhAfvH39N3QYbypZ6mYNFUKev8uVu3WrC37frM/1mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_14,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410010119
X-Proofpoint-ORIG-GUID: 1HROWELPzVZkwqZQiI9KSYsigDT9Cgbe
X-Proofpoint-GUID: 1HROWELPzVZkwqZQiI9KSYsigDT9Cgbe

On 9/14/24 4:23 AM, Steven Rostedt wrote:
> On Sat, 14 Sep 2024 01:02:05 +0200
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
>> diff --git a/include/linux/sframe.h b/include/linux/sframe.h
>> new file mode 100644
>> index 000000000000..3a44f76929e2
>> --- /dev/null
>> +++ b/include/linux/sframe.h
>> @@ -0,0 +1,46 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_SFRAME_H
>> +#define _LINUX_SFRAME_H
>> +
>> +#include <linux/mm_types.h>
>> +
>> +struct sframe_file {
>> +	unsigned long sframe_addr, text_start, text_end;
> 
> Please make each entry a separate line:
> 
> 	unsigned long		sframe_addr;
> 	unsigned long		text_start;
> 	unsigned long		text_end;
> 
> It may be fine for declaring variables like this in a function, but it
> should not be done in a structure.
> 
>> +};
>> +
>> +struct user_unwind_frame;
>> +
>> +#ifdef CONFIG_HAVE_USER_UNWIND_SFRAME
>> +
>> +#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0)
>> +
>> +extern void sframe_free_mm(struct mm_struct *mm);
>> +
>> +extern int __sframe_add_section(struct sframe_file *file);
>> +extern int sframe_add_section(unsigned long sframe_addr, unsigned long text_start, unsigned long text_end);
>> +extern int sframe_remove_section(unsigned long sframe_addr);
>> +extern int sframe_find(unsigned long ip, struct user_unwind_frame *frame);
>> +
>> +static inline bool current_has_sframe(void)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +
>> +	return mm && !mtree_empty(&mm->sframe_mt);
>> +}
>> +
>> +#else /* !CONFIG_HAVE_USER_UNWIND_SFRAME */
>> +
>> +#define INIT_MM_SFRAME
>> +
>> +static inline void sframe_free_mm(struct mm_struct *mm) {}
>> +
>> +static inline int __sframe_add_section(struct sframe_file *file) { return -EINVAL; }
>> +static inline int sframe_add_section(unsigned long sframe_addr, unsigned long text_start, unsigned long text_end) { return -EINVAL; }
>> +static inline int sframe_remove_section(unsigned long sframe_addr) { return -EINVAL; }
>> +static inline int sframe_find(unsigned long ip, struct user_unwind_frame *frame) { return -EINVAL; }
>> +
>> +static inline bool current_has_sframe(void) { return false; }
>> +
>> +#endif /* CONFIG_HAVE_USER_UNWIND_SFRAME */
>> +
>> +#endif /* _LINUX_SFRAME_H */
>> diff --git a/include/linux/user_unwind.h b/include/linux/user_unwind.h
>> index 0a19ac6c92b2..8003f9d35405 100644
>> --- a/include/linux/user_unwind.h
>> +++ b/include/linux/user_unwind.h
>> @@ -7,6 +7,7 @@
>>   enum user_unwind_type {
>>   	USER_UNWIND_TYPE_AUTO,
>>   	USER_UNWIND_TYPE_FP,
>> +	USER_UNWIND_TYPE_SFRAME,
>>   };
>>   
>>   struct user_unwind_frame {
>> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
>> index b54b313bcf07..b2aca31e1a49 100644
>> --- a/include/uapi/linux/elf.h
>> +++ b/include/uapi/linux/elf.h
>> @@ -39,6 +39,7 @@ typedef __s64	Elf64_Sxword;
>>   #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
>>   #define PT_GNU_RELRO	(PT_LOOS + 0x474e552)
>>   #define PT_GNU_PROPERTY	(PT_LOOS + 0x474e553)
>> +#define PT_GNU_SFRAME	(PT_LOOS + 0x474e554)
>>   
>>   
>>   /* ARM MTE memory tag segment type */
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 35791791a879..69511077c910 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -328,4 +328,7 @@ struct prctl_mm_map {
>>   # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
>>   # define PR_PPC_DEXCR_CTRL_MASK		0x1f
>>   
>> +#define PR_ADD_SFRAME			74
>> +#define PR_REMOVE_SFRAME		75
>> +
>>   #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index cc760491f201..a216f091edfb 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -104,6 +104,7 @@
>>   #include <linux/rseq.h>
>>   #include <uapi/linux/pidfd.h>
>>   #include <linux/pidfs.h>
>> +#include <linux/sframe.h>
>>   
>>   #include <asm/pgalloc.h>
>>   #include <linux/uaccess.h>
>> @@ -923,6 +924,7 @@ void __mmdrop(struct mm_struct *mm)
>>   	mm_pasid_drop(mm);
>>   	mm_destroy_cid(mm);
>>   	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
>> +	sframe_free_mm(mm);
>>   
>>   	free_mm(mm);
>>   }
>> @@ -1249,6 +1251,13 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
>>   #endif
>>   }
>>   
>> +static void mm_init_sframe(struct mm_struct *mm)
>> +{
>> +#ifdef CONFIG_HAVE_USER_UNWIND_SFRAME
>> +	mt_init(&mm->sframe_mt);
>> +#endif
>> +}
>> +
>>   static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>>   	struct user_namespace *user_ns)
>>   {
>> @@ -1280,6 +1289,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>>   	mm->pmd_huge_pte = NULL;
>>   #endif
>>   	mm_init_uprobes_state(mm);
>> +	mm_init_sframe(mm);
>>   	hugetlb_count_init(mm);
>>   
>>   	if (current->mm) {
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 3a2df1bd9f64..e4d2b64f4ae4 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -64,6 +64,7 @@
>>   #include <linux/rcupdate.h>
>>   #include <linux/uidgid.h>
>>   #include <linux/cred.h>
>> +#include <linux/sframe.h>
>>   
>>   #include <linux/nospec.h>
>>   
>> @@ -2782,6 +2783,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>   	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
>>   		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
>>   		break;
>> +	case PR_ADD_SFRAME:
>> +		if (arg5)
>> +			return -EINVAL;
>> +		error = sframe_add_section(arg2, arg3, arg4);
>> +		break;
>> +	case PR_REMOVE_SFRAME:
>> +		if (arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +		error = sframe_remove_section(arg2);
>> +		break;
>>   	default:
>>   		error = -EINVAL;
>>   		break;
>> diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
>> index eb466d6a3295..6f202c5840cf 100644
>> --- a/kernel/unwind/Makefile
>> +++ b/kernel/unwind/Makefile
>> @@ -1 +1,2 @@
>>   obj-$(CONFIG_HAVE_USER_UNWIND) += user.o
>> +obj-$(CONFIG_HAVE_USER_UNWIND_SFRAME) += sframe.o
>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> new file mode 100644
>> index 000000000000..3e4d29e737a1
>> --- /dev/null
>> +++ b/kernel/unwind/sframe.c
>> @@ -0,0 +1,420 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/srcu.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/mm.h>
>> +#include <linux/sframe.h>
>> +#include <linux/user_unwind.h>
>> +
>> +#include "sframe.h"
>> +
>> +#define SFRAME_FILENAME_LEN 32
>> +
>> +struct sframe_section {
>> +	struct rcu_head rcu;
>> +
>> +	unsigned long sframe_addr;
>> +	unsigned long text_addr;
>> +
>> +	unsigned long fdes_addr;
>> +	unsigned long fres_addr;
>> +	unsigned int  fdes_nr;
>> +	signed char ra_off, fp_off;
>> +};
>> +
>> +DEFINE_STATIC_SRCU(sframe_srcu);
>> +
>> +#define __SFRAME_GET_USER(out, user_ptr, type)				\
>> +({									\
>> +	type __tmp;							\
>> +	if (get_user(__tmp, (type *)user_ptr))				\
>> +		return -EFAULT;						\
>> +	user_ptr += sizeof(__tmp);					\
>> +	out = __tmp;							\
>> +})
>> +
>> +#define SFRAME_GET_USER_SIGNED(out, user_ptr, size)			\
>> +({									\
>> +	switch (size) {							\
>> +	case 1:								\
>> +		__SFRAME_GET_USER(out, user_ptr, s8);			\
>> +		break;							\
>> +	case 2:								\
>> +		__SFRAME_GET_USER(out, user_ptr, s16);			\
>> +		break;							\
>> +	case 4:								\
>> +		__SFRAME_GET_USER(out, user_ptr, s32);			\
>> +		break;							\
>> +	default:							\
>> +		return -EINVAL;						\
>> +	}								\
>> +})
>> +
>> +#define SFRAME_GET_USER_UNSIGNED(out, user_ptr, size)			\
>> +({									\
>> +	switch (size) {							\
>> +	case 1:								\
>> +		__SFRAME_GET_USER(out, user_ptr, u8);			\
>> +		break;							\
>> +	case 2:								\
>> +		__SFRAME_GET_USER(out, user_ptr, u16);			\
>> +		break;							\
>> +	case 4:								\
>> +		__SFRAME_GET_USER(out, user_ptr, u32);			\
>> +		break;							\
>> +	default:							\
>> +		return -EINVAL;						\
>> +	}								\
>> +})
>> +
>> +static unsigned char fre_type_to_size(unsigned char fre_type)
>> +{
>> +	if (fre_type > 2)
>> +		return 0;
>> +	return 1 << fre_type;
>> +}
>> +
>> +static unsigned char offset_size_enum_to_size(unsigned char off_size)
>> +{
>> +	if (off_size > 2)
>> +		return 0;
>> +	return 1 << off_size;
>> +}
>> +
>> +static int find_fde(struct sframe_section *sec, unsigned long ip,
>> +		    struct sframe_fde *fde)
>> +{
>> +	s32 func_off, ip_off;
>> +	struct sframe_fde __user *first, *last, *mid, *found;
> 
> Need to initialize found = NULL;
> 
>> +
>> +	ip_off = ip - sec->sframe_addr;
>> +
>> +	first = (void *)sec->fdes_addr;
>> +	last = first + sec->fdes_nr;
>> +	while (first <= last) {
> 
> So we trust user space to have this table sorted?
> 

GNU ld will create this table sorted when linking .sframe sections and 
will set SFRAME_F_FDE_SORTED in flags in the output .sframe section.  In 
the current patch, I see the __sframe_add_section () includes a check 
for SFRAME_F_FDE_SORTED for admitting SFrame sections.

So proceeding here with the assumption that the SFrame FDE list is 
sorted should work fine.

>> +		mid = first + ((last - first) / 2);
>> +		if (get_user(func_off, (s32 *)mid))
>> +			return -EFAULT;
>> +		if (ip_off >= func_off) {
>> +			found = mid;
> 
> If it's not sorted, this can return the wrong value.
> 
> We should have some check that has something like:
> 
> 	s32 low_func_off = 0, high_func_off = 0;
> 
> 			if (low_func_off && low_func_off > func_off)
> 				return -EINVAL;	
> 			low_func_off = func_off;
> 
>> +			first = mid + 1;
>> +		} else
> 			{ /* Note, this needs a bracket anyway, because
> 			     rules are, if one if block has a bracket,
> 			     the other needs one too */
> 
> 			if (high_func_off && high_func_off < func_off)
> 				return -EINVAL;
> 
> 			high_func_off = func_off;
> 
>> +			last = mid - 1;
> 		}
> 
>> +	}
>> +
>> +	if (!found)
>> +		return -EINVAL;
>> +
>> +	if (copy_from_user(fde, found, sizeof(*fde)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
> 
> -- Steve

