Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14A15B12A;
	Tue,  2 Jul 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920359; cv=fail; b=Cd7kDwUdMlt6nqn9GatXDBB3QNASHlxBGrnryoKQ3zByMOTI+dwKb9slJngteX9YZneykbhxpIu2qitm9fPlzKEcBoRk2KKPgOeyhvHxK8BBc+TeIcbdTrMmS32dGMUzQkW8+4fCYnKVhgwrgiVaTPS1MXuZe97wzHtqZ+MKqSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920359; c=relaxed/simple;
	bh=2xbcmZ3AEJBMql6N4IDsQCstMi/S/b3FLbeRiiMYz24=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GX/MzKR0LThkTL3iXR8kCHkO6Cq/QHsUeJ10zNPcUyeOHxtBOBlBET9ejKamZGsiLjuoHHPdqtA18XQvlxLamr5iy1ntgcIemgVlflFY6JnFG0KCsIIfMBKYW0gynuNwfCPxWIqYSX8QGQlAvo6K6x5d0rP8LIJth9RDWYlqDSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cjyfvo5J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DPoEBoJ3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cjyfvo5J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DPoEBoJ3"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4625MbFn030697;
	Tue, 2 Jul 2024 11:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=UKc0udnZu0QPy93NTpF6A7qSPGsbNtsJIj+GUAvHgFo=; b=
	cjyfvo5JWrOxGEqCoJ2Dvgl1yTmZ295F39rmJaRLtVNBsgMJkmicmRltC9Jz5GKF
	RK1hTE9+em8CrTdOzWEkr4u668SxKN6svjgYEIHwCqwC3ft5yttWtEFDi0wYdxNE
	05fWH6jtig37Ixq50+zbU8jnzpFZ3o+pnMZHram0dRETn6/sKwWtpRkNb7ULwy3B
	lrzkJCWXUQ/OZsalk9v8HBVtFnjBjXvt5JOhgxOPYiLMbTPkNjlgr/XI+tljlpYW
	Ny0L1cXETvvGbEP/Qwgke3NDI/LjN2d8OfpPwpS58ATWGMxONoMjsAPaTRyBtxg6
	bDw58JZeaFen+Kn75yYowQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attdn2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 11:38:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462BPpkI010685;
	Tue, 2 Jul 2024 11:38:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q7r6q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 11:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBJRwBlsuxHcjViwahmcS9qxX5gF159AwgABvGt21Vt4pwct7Yu/wcBAE3sNFbEZ12tNHsvfQrub+7Yex4VVQ1r4GH0gpPYixfpiroZ4YSmU30EWsrSjUQTxtZNumIZ0MLvpmwSrtcwkporIcddiBQqHShuWmhwUagZwhczmKqhkToFoq01CykACY93gu3JfZ0c2lVADh9i+Os2T+vJhcLPSgf0Muj+3jwPvZUKbGLzfT06rPitC7smuMeJBp/bqQ0/5RX8zNCsNLg6VnxnHWAmsAwMK0EU2V0jR7I+tKmWE89levYp4Pv+NjFud31cl0vlFMMAeScvAWEVwAEoj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKc0udnZu0QPy93NTpF6A7qSPGsbNtsJIj+GUAvHgFo=;
 b=iNuo2cEnWIV07p1jbkg5ynNGr/BCHbKqtXlQ/Y49gin1UeXotiti1alXDa5LiiVnHpedxxF2HRb2us9cBYrjO5cPO40bnc3A/A+WlC9KAGWXZDPiHSJRyRmAjb9uOMl7Z9sutJDPjDOFNJimAmJ02KQIZVRrC0TxavOmU34zMnBDbYhKbJBTTSgKWqBW2/DX2oPEy41V0HJO6HiXNMODGDg3+bO9A4ELgT6taE4TVHUljco9TBp/9lKCDZf9ovQWMuXNiP2f/B1t9eeY/1hDMnfBA6m63K6xstHQ6XJmoGI+r+vKap/gRVJKPNhZXe607wRai4QcZqRGyiy7Mxqdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKc0udnZu0QPy93NTpF6A7qSPGsbNtsJIj+GUAvHgFo=;
 b=DPoEBoJ3pj7eZ1sbye41GaQ0w+UC68dlnZ5TjUGHVYGzScLX7LFzkm7ei2FdQ6FQ97eduq/zIjK007uq3AHTJExYiA9IlusAK3RAmCA6lstZdCiISyuPJNfQzfIrAIvMhFKRW0DNbVyqRB6br62ERKZm6gBzUDYf4mX7xB6ecVQ=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 11:38:39 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83%5]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 11:38:39 +0000
Message-ID: <18c85162-20cd-42d3-8955-85ae612db0c5@oracle.com>
Date: Tue, 2 Jul 2024 07:38:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
 <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
 <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
 <36e86320-1a43-45d4-b25e-a5d60857f4b2@oracle.com>
 <78db946d-db24-408e-92fc-b7ff79c80728@amd.com>
 <e193949b-d969-42e7-a0f3-fbea6e4dfe12@oracle.com>
 <7a34a58b-9366-46a4-92ca-e36e378311f5@amd.com>
Content-Language: en-US
From: George Kennedy <george.kennedy@oracle.com>
In-Reply-To: <7a34a58b-9366-46a4-92ca-e36e378311f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:208:32e::28) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|BL3PR10MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b67306-6271-4c60-7728-08dc9a8b844c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEpnaURlcXA3ZkZKMGFTK2RDUHRyeFRWTG1UWUk2cmdsb3ZxOTFRamozbnNC?=
 =?utf-8?B?Vzg0QTU0d1JzYmlEdk0rc3F0MHoyLzYyaVU2OHhrOTFhcENRYWNoWVRMN0xn?=
 =?utf-8?B?aWp5MUJyeEt0dmpzMzZJdHdSSFZ1WVRmTWFNZkdOSnlveXNJU3V5SXhHZU1F?=
 =?utf-8?B?enhVWWFrQ2tFZnNuc0JQYUNkYmpqWElDencvTFc5WjRtSEwxZFZUMDdiaHlm?=
 =?utf-8?B?eXlRaGJETlhscmJHenJHYks2eitkVldVTmJFaWE1MHRUMU04VzRXUFRrR1Vv?=
 =?utf-8?B?azJYZkppM0lPdWVUUXJZSGM4Tlhxc0NmemNBMzl1MHVxT0tLYmowWmg2K1k4?=
 =?utf-8?B?ejFJSERIa0V0aEp4bkpBL0NsVDJnRGZEMDc4TmtQK2k3L1FjVmJTYjdTVElz?=
 =?utf-8?B?dHAwb2prdlpVQlIzSW1BUTYxZVVtT0N2a2diUjVmcUE1dmJVZFVwbTVXQnow?=
 =?utf-8?B?blBIdGdOUCs0TTRKQW9IVUUxeE5UNlR2UVR1cjkzbE5KSDEvMzNHa3dzZGFM?=
 =?utf-8?B?Nk14VGRxQ2V4aFNNZjdTdENUT3BubzlYNmE5bW1mY3A1VFdxN2VuVmxrNXFq?=
 =?utf-8?B?cklWMXhXdHNEZkxtU1FkbVdzL0FYRk12WmpSemU0OXpxZ0JaamR4QkN5bGdm?=
 =?utf-8?B?UENQTUVuK2JNd1hITDI4R3Q5RDRUNC9mczNRMzBCNGo5RmNmYVB1di9tS3lP?=
 =?utf-8?B?ZW5vNnY2SnNVaGhDMngrZG04eTYyRzNMMkMwalArVG5yN1RIYy8wc2RmS1hO?=
 =?utf-8?B?NE5xaVN4bUpuRncyU3p6ZXVsSmY2YWtaaGZPY0JBSURrQ2xPKzBmTHVxWVNV?=
 =?utf-8?B?K1k5Tnl0M3FiNnhWLzBhYkk2ZUplS3pydnZGN1paaFFESitYQXpjSDcrMkZT?=
 =?utf-8?B?RElIVlh2K1E3YnU3VHkwcGFTZURYd2ZyQ0RhaExJcE5iUWZQU3lPRkdnalRI?=
 =?utf-8?B?WGgwMDR6V24zeCthNlZnSm5nUDV6QmhMTmVVODlLYVZJekZpanlsL3FPRE85?=
 =?utf-8?B?RHYwY3NDVnd0REdteGphZkpyckk5QmcyZkN3bFQ0NGkxOURQY2gyWFVyZ0F2?=
 =?utf-8?B?YmtUWlRLSWZRL3U4L25IOWZhMkV1c3JNK1hiRXdFb2hXUSsyQm8zbVBkUEYw?=
 =?utf-8?B?U0ZIbmFsTG01U01jbW4zb1lNcVpDR1B4U1FxVzluY0haRlBheWptZGt6blo2?=
 =?utf-8?B?KzN6YVhMeHRIQStwNW4rYVZRdzlNelBPbE9xN09PcTZXakw0L1VmN3RHZ1Az?=
 =?utf-8?B?UmNlRGYzYldod3U3c2hpZlczYytNb29VelYwMnRXRTVvaE1OTVRSci9FeHd4?=
 =?utf-8?B?T0RJbUpMRW5sZjc4N0ljTGFqdE1kVXF0NnlPZG5EbWJJVmNlbHJoNzNiS205?=
 =?utf-8?B?NXpsVUVBKzFpbEpmZWFvNVlrS2hQRWo2UFpEbmdDUEhTRm9XYTZadC9sQTlv?=
 =?utf-8?B?NmlRU2NYK0tScUFTWXhOcEUrSUdUYmU4Y3RqUDZ4blZVOHNrWFg5UEErWDQy?=
 =?utf-8?B?WTNSTUcxWW9XZ1gwMEd3K21VUDVqaitjcDRRWlNUKzQ2THJaWHFtUDV5RkdE?=
 =?utf-8?B?c2lZOTY4VzV1Q2xlVm9vaVBNZ0gzaXNJTkYyOGxWWHJpSXhvYUU3QWRZV29M?=
 =?utf-8?B?b3Z5ckxhTkRmOElOYnh2SHlpOFNCaXF1RkdKaXBnSUNybHZ6SXNrZVZqS0VO?=
 =?utf-8?B?aW1sVkZDS2pJSUlaemR0Q1VGWElVREwvcGcrQi9TbkpSbDRKUUtHbjVORGhZ?=
 =?utf-8?Q?yqXr1DZcceXjQdYkSo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGR0U1JKU2ZQajhzUEQ4dGxTUHhlWThMcFdQSHY2TjFWTms2dWlYTk1tRk1V?=
 =?utf-8?B?SEJzdHI4L0cyMEgwWCtoMk1oVkpvajJtN3V5NUxZV0Q5VmJlSS9CNy9nb0du?=
 =?utf-8?B?L21KNGFEQW1lZDlrSG9CaDFhb3Y3YlJiWHByMGZUZkNPaE1Ib2w4OHBxZEVD?=
 =?utf-8?B?eHB0c3d0NW1WTFlNdkdieTZmNnZqcHJUQ2d2Zk5UK3VkQXkrRnpRN3hRM0c2?=
 =?utf-8?B?UUNtdHJSVFdibkFlVzAvWHZibnNGTjUyTGVUcWNKbTEvcHBmeEVlc2xBNE9z?=
 =?utf-8?B?NmRMKzQ3ekEyU3pEK1FNbVVvcGsxbGl4eEhoVXdSMkpYZGVsK1FLK3dLeXZ2?=
 =?utf-8?B?TjdTT3RKeWVzNEYyYUU1ZEEvNFkvRTNZeXV5NGdhelN4djlBOFFtWDFabTl5?=
 =?utf-8?B?NVRnb0UxbkZmbmRKbHNMQlU5R1BQUlJUL285VHJVSEpXV3RmQUEzZ0tUeTFi?=
 =?utf-8?B?WEQvdUFCalZ4SDh2czRoc0ttOW9zd2oyUXg0c0hnaTBteThic3RTcC80ODFU?=
 =?utf-8?B?Vm9IZWRIeTV4UnJYamtMVUpsYmMvb2VEdnlNWVVUZFJIVGVIcWNxcWZqcWUw?=
 =?utf-8?B?Sk5xRGtIc2F3bjk3alFHcmloZTVybWFNVEVvZTI1R3dzOTlvOU9FN3Y4a21R?=
 =?utf-8?B?K0ZtcC9veXkwQWJOL2ZNbmp2SCt0ZlVXWjZYcGlTem0zWEN4TDM2T0xPWHNG?=
 =?utf-8?B?R0NaeDJsR1hRTm4yUXdWeHpKdlpuNUNmWmdQZ1djOTExc2tnVGZjczJWMldH?=
 =?utf-8?B?SFJmWnlSM2Jnd0c4eE9qR1NTWEo2ekVydWF5RFN6b2xxMHl2Z2tkRzRyM0g0?=
 =?utf-8?B?TUgzdzZ0cGtTVlM0a1B3YytsN3ZHVTFhUE04aWJZclZ2eVFlWUhHcXZzVFZ6?=
 =?utf-8?B?c3lzNTd4Wnp2ejVhMGRieHJMQndRZTFCYTNhSGpHc042UHV1RlFwV1l1WTJT?=
 =?utf-8?B?czBVL2Y5Z1RFMHdQVmExVGgyS3dYVm1nb3ptSTdsd08ycUVpTlVzWnhkUkt1?=
 =?utf-8?B?RVBqUW5IdmUvbkgxaVBTbDdFOTc0blVFbjI1TjFUMDhFMlovZXFiVTBCZ3dw?=
 =?utf-8?B?U21HS25BTjFYZWs5SnZNSjJtZS9xVUlFNXlGZGNybjNsd05pRUg0TnhGejRz?=
 =?utf-8?B?ZWNIU0J6NnVDVmp2T0hHMEhaKzh1Nm00OFBjVWRnWXhBcHVYeWRROVFYQ1VR?=
 =?utf-8?B?UW9vRGFRM2VIT2RLbk5sb1dDRzRJU2FFRzAwZTVESi85S0ZrNHBhVSs3dkVy?=
 =?utf-8?B?VjlSSHcxZ2M1alluVGpRTGJ6ZnVxWHB4dklnS2RCT2oyK2VLejRvU3B6WW9r?=
 =?utf-8?B?bitCZHFDeFk5ajE0VFZyTkYwNHJGdjd1eVpwU1NndkNucmIrdHFZRmJyNy9H?=
 =?utf-8?B?TmU1WnY5SllYTWt2d2M3eW0xUmtSMzN4aWxkNzVtVWJucUtGR1QrSjdLVzh0?=
 =?utf-8?B?VmlmRndXTks3ZWhpWGtUMTNic1czdzFiSjByTG1GTmkvNDdERmRjNjBsUjc3?=
 =?utf-8?B?SVpoQ0owZ3VFNmVMMzR0N2NxUHhKT2ZGcEVlMm1UOVVSaGlaajYwZmkxd2hY?=
 =?utf-8?B?VXlYWHFNak1tc1M5dXUrYWM4Nk5UQWZ5bSs5aXdwRWxkT3lzNDBkbGdNcUo1?=
 =?utf-8?B?RWliNnhvRERYazJyV0hpTHZaSGhBMnFzUk5pNzBQeW5kOU1qU2cxQ1pvSkVm?=
 =?utf-8?B?bk9YZlphZ1BGRVNGNEdNMEZpamVGUXBNTC9ndUdobEI1V09ENVBmNTFvWnNp?=
 =?utf-8?B?VWRLOGliZlVOR0hEc1JRVk5ORk9Da0NONloreG9pTVo5UFkwSjFvWUZUeWtI?=
 =?utf-8?B?SUY5dExMOFJZY1pjWE1DQktoaGpYeFNsT24wajhGMVh4RVNLWGprbXV1QllF?=
 =?utf-8?B?ODFubnZGVmdxZG92NU9JbnZ6YjZYU0JFZnAyaFFGWTIxalEvVWpQR0krYXYx?=
 =?utf-8?B?eDNyODNBSi8wZGx4MWFPVzRpb1czcVVLQlRzLzVtUnNrS2lwQ29KTjNMeWtN?=
 =?utf-8?B?OXZQSHRNTzRBQkNZMUZtWm1FQXpyam5pTDd2aEtleXE4NVNLbVhubnVSdVlL?=
 =?utf-8?B?UlB6S1FLT1hvVDVQK2xONHo2NjNsSS81czRMUk8xWU5VbVpDNVFjTjZ1SERW?=
 =?utf-8?B?SThZbDdUSEEyWkFNSEJycVV0Q29XbzlhalVWUXRMc2xibFRwU0VVNXBXS1ln?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pz1Ncl0lztnK/ayroY2uzL0f2WNJpAopU/R8frWGSVzBSazSsckrBkwVYgyC/c54zMmNm6hV2fZ9BGt9459x6lgVKnfZ1g/Jbgtoq/2uYKT58QeGbHwkN1NTeeOwJTYZaE8UoBPhMa30ii+XG+tBXHzwWteLzVfnBomIK1G9HAIvlhwEAsTobKU+yB6KoBS8rHoXqTE/FjnfJlGsSMasx2aiepe3hRA3r5Lbr+HeHvGmohZttkgaxVr6to5GvQispQxhhvh7VpOyzj32SeVl882e0x9lnIflK4rEC4DwMQejYNJAiz21Dh6Ru/85qkXVwlGRUcNvTWwFvDG5KWRUgvlKA1QDSl73z4n6SGkLIyTFiwxoxws/89FO17pWjMGahrvfQFf493hXZSkVCTY6KPPK9YMepCmR0P53WBa0d9nta50KWrLJlN6rBw+zkuJohW8JJyF6vfuPJbQqwe8CDlfMUScaok8Ym+budAaPjJaxpCrk+3DjNzEYLx24D2GvlO/JJJu5jlVab+LvhsZO+Zr6Qga7jlsuzCavT0XPGXwujtmlVtBhVS8K8P8Gu2h6somOWJ/6VivVm/MFw0PQIXcQnXxCUnJM0vwr1EzIW4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b67306-6271-4c60-7728-08dc9a8b844c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 11:38:39.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51Uhyt5lc4YpQ6TSa8Ec8OCB3Tt1sHf7O7PjeXjPR0pB3kHa3TqluLwjINEN2+pDH2elL3jxDR3MZOcsf+VdKdUkjkXSEvkd1JRndW/jF4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_07,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020086
X-Proofpoint-GUID: ubEyAoReG2H7m12_q25d5g3L-KpB-Y4g
X-Proofpoint-ORIG-GUID: ubEyAoReG2H7m12_q25d5g3L-KpB-Y4g



On 7/2/2024 12:03 AM, Ravi Bangoria wrote:
> On 24-Jun-24 9:48 PM, George Kennedy wrote:
>>
>> On 6/10/2024 6:51 AM, Ravi Bangoria wrote:
>>> On 6/8/2024 12:43 AM, George Kennedy wrote:
>>>> Hi Ravi,
>>>>
>>>> On 6/4/2024 9:40 AM, Ravi Bangoria wrote:
>>>>>> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>>>>>>> Events can be deleted and the entry can be NULL.
>>>>>>>>>> Can you please also explain "how".
>>>>>>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>>>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>>>>>>>> This appears to be an AMD only issue.
>>>>>>>>>>>
>>>>>>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>>>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>>>>>>> The Syzkaller reproducer can be found in this link:
>>>>>>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>>>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>>>>>>               if (!test_bit(idx, cpuc->active_mask))
>>>>>>>>>>>                   continue;
>>>>>>>>>>>       -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>>>> +        if (cpuc->events[idx])
>>>>>>>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>>>>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>>>>>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>>>>>>>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>>>>>>>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>>>>>>> There are subtle differences between Intel and AMD pmu implementation.
>>>>>>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>>>>>>> amd_pmu_enable_all() loops over each PMC and enables it individually.
>>>>>>>
>>>>>>> The WARN_ON_ONCE() is important because it will warn about potential
>>>>>>> sw bug somewhere else.
>>>>>> We could add a similar WARN_ON_ONCE() to the proposed patch.
>>>>> Sure, that would help in future. But for current splat, can you please
>>>>> try to rootcause the underlying race condition?
>>>> Were you able to reproduce the crash on the AMD machine?
>>> I'm able to reproduce within the KVM guest. Will try to investigate further.
>> Hi Ravi,
>>
>> Any new status?
> I was able to reproduce it with passthrough pmu[1] as well on a Zen4 machine
> where Host has PerfMonV2 support (GlobalCtrl etc) but guest do not. I've
> debugged it at some extent and seeing some race conditions, but not working
> on this with top priority since this requires root/CAP_PERFMON privileges to
> cause a crash. I'll resume investigation once I get some time. Sorry about
> the delay.
No worries. Thank you for the update, Ravi,
George
>
> [1] https://lore.kernel.org/all/20240506053020.3911940-1-mizhang@google.com
>
> Thanks,
> Ravi

