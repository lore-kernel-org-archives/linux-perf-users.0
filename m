Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793028969;
	b=nDi6BDzcnNIquTq19WkVu8gZ+ReLjAc89z5PptME3qge7dhXPoLnqiLtQucIJtylhmtH
	 8NZ+zOWSUfmP38/UD5/eX4UtWLFaD8Wdr4iM4q3pEbPNtFRFqkvnzUVrzSYhgoUf014gU
	 u2QAyBwvHRU0cuCyeZ87KT9HjpidYip9CMzdtKZcOHGSRFI2VqQSTV+6FIIN9LS7aA28J
	 GkbcD+sVJ5fefysBIMa8IHB7NTtjeCJvOIKw9JII8h4LYJiI/14q4Psj6OTc5rA3R1Haq
	 v03U0r1F3GSYMmTidB82nz3BCbTmj3n2/2WWurOm544t2oqB1pNEdt7u/VoSnVB8RRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028969;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tb5NqycnOWhkCAJ6uT2wrpETcIw8dKghVbryG52zlRU=;
	b=E4jTqutuGeit7544lY6ULKg1FHGkIaBo0um03dISgZFGIewoX/qynQHyNmr/TvbBGNyL
	 Zcn5r1l9NuxS+01uNHXm1/dt0bxpcVWKN6b4bdvZY4z2cuUICVce1EjTrp5ZievklQx1c
	 1rizFVoTcLqcmjAHPeeRnxFu8DiGQcIrvj6KgW1yop24nsk4lvdc+ZUXb6maCxaNYduo5
	 CQ1Jmmq1sZBZFzpcYRvAj15L5+4nbSry8wVaPyeB1ayfWPFbHm6qK+aWyVGj6jNMJ0mNc
	 wUYYXKLdMEW60giHU6c93Q3c/AJIUKzS+9Yr4ve+LW5wLn3pg9q7cQu3mQy1zJYViPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G+WCytBf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.10
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEBA606A31A;
	Mon, 26 Oct 2026 15:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EEBA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G+WCytBf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jurg86qc0BhI28HyqsnB74UMAi/4/zs37pBe4jC6DAbodM30ot992tWrWZ/9mxLWzxlfjhvcTsZqlaPDHEK1E/WI0TOi2CtskAFb2F1YD/uL1bT4JR4RZXi/q0IlYO5N9WI5kbkDTaTX0yx6VexW8aVCo3u74lHDOFYXuJfy+Yv6LEasoFhHF250DqqLQcf1SEh+qQmXYEMc6Nbsh0JAGnTEA4VfXUo3n+sihXrJfp8nZDQ1HHlz980sak9pK4MX6CXHIROiAczsi+b6UIm4c/wpv1De+TraTpq1PCDj3v/crj4yWxz22tskgC6WU4EPsDg+jgC93kmllkuq/Uhzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb5NqycnOWhkCAJ6uT2wrpETcIw8dKghVbryG52zlRU=;
 b=N2brAulKq87W/Y/5xTxLmC57OucQeyt60c/YGvxM/jeFoiAcCMMVG7Dl5male/XUoVWI+eiaRjsmHTeSM1oFIGIj8B2zOuMU4NJms7HzNT5uVCOgLChd0Owrhtuq7Q7+PkH4PCfhfKlb0jkGL7qTwZxCLsZwWFQAb9j/lEzwTxYKGidrDKur2aY6hJf8UqdSN4Y79DxXJR3RtPy/KMgui4XVT//AoRQ9bCsS9SwQSqb11p6fC9t+FEoP/RgX6Kz6KDY9jJTjrqkIf0WjfJcoCpMxLSmThq/cqotndIrLAsPMiOW4+29LyMIlRByGawPl4ju9WQzl8jzcdW8P3+sdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb5NqycnOWhkCAJ6uT2wrpETcIw8dKghVbryG52zlRU=;
 b=G+WCytBfrFAp8jRNMvhhzAA/DaE40uUIQN7T4JhPjdxbLYk0sFWcakN7yyrvdZENrsQ0bsOX0WeTRTYOK2ampp1uMJIpJTIPZso0DeVd12vl5mLtSwIiCRKM+UXXtf9iFvkUUnBRjNqguexuutJECzZ3KMlqb3LMq8/HNgZiGyo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:36:01 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 15:36:01 +0000
Message-ID: <19b42c2e-e2a9-4b28-8a59-87350d28e752@amd.com>
Date: Mon, 26 Oct 2026 21:05:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
To: Puranjay Mohan <puranjay@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20261023124157.75524-1-puranjay@kernel.org>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20261023124157.75524-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::8) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: c72f4e9a-bbd1-4ba6-454c-08df3376d6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|261026140227099003|11063799006|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|10067099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yzINoYRveKQPV8tyEuyk48MgKYh8ext9hgulgBF8cKwXYSmhambub0jj0nQqQpYtHWfgnlVly1cGy2+cdsotlSn5m+9CTGdKeLWgcx3ki8nyX3vr4u1kCpowT39mZ1JHHWISb2pXgKD0LdnB8eq/1y+GufIYJpWzb5SwIY5mFjTRRJ1i1eLhbN3NCLEYopXZjjr2joqA8qcyhjFe4AxQYeo8Tkm6BR2Tcj2Js8Nly2nQQnI0vNCkdPTsxAMzxLXn3CzVsHLkqHqfvpJ4sHrBNl5hOLgCBsBfRMsk657/1zdH5kVHJQjZr95agN9G2F8ABV4HSMqvsQFZmsVWWomkqSrv5ZJcq7yjpxzs8oiGB+vq3n7hXK1Gh5fT1p0e9iSY12jNYkEvCSjR67Lr+Dg5lKT/vwiDq+v3KizhSirsS6asvZPwsBzf70Gi28BbkbOPCfp9Sf8ncCBSoq5E4vlj28NSIASsdvyPiQyrLyi/WCPHVsHjabmi4bYHn8d7BcfPyrjUKiwaVVPIRl1J6fz4YgpD22mVrCghsNoGR4PEoVu3v0lrI1XrCjKJPKEAC/0Uo2IHdjxlPZAJesY/BDf8dTw4g+y4Z/ekUC94ClB27SJaX32fWoXjtbtGl0zJ+RCPIjY2RGQlvNtQ+AWqebZKVA5ayvHdYIhVG9M04jDPzMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(261026140227099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkw2aTVrTGJML2ZYakxkMnJVZy9nVjJpT2lpeS9zbXF2N2o5TUVYU1pGY0xH?=
 =?utf-8?B?VTBINlE3M3ZmcWFvdEZiZGRWRDl5d0dSdUJoU3FUcDBnamRIZm9jSVZoWldV?=
 =?utf-8?B?VHovU0paYUVsUEY5dGFXTUNCOEJxVVg1a2hMZEF2UDZCL1FDNXRSVVRyUTNk?=
 =?utf-8?B?YjFYb0k3Y3QrL09HMzRqL1hsMm1MVDhUdUtkZjkvbklQdGIrcWZ2NVpQMDQ2?=
 =?utf-8?B?T3FROU1jazFFOElHR002SVpJbHBCaFlsUi9MUU02NU95TDR1OHpEdWdrOHNm?=
 =?utf-8?B?VnAycDNKckNaRWlmWU1YdUlYTEM5YnF1NW5BakpRNk1hbWxFK1drdzNmQkhZ?=
 =?utf-8?B?YmdTdlFuMUVhdFBCY3FVWkFNV2RmYzk1WFhHMnV6dFI4N3Y0R3pHRzBJTXFH?=
 =?utf-8?B?SXNRdFJ6aStPanIwSU9UQXA4RkRkZXdwUUlYRitJdzR4MW5rWXVJengxdHhl?=
 =?utf-8?B?dkZ6RldMamVKakxzbmFUVC9JUGZiUDlnTW12b2FwY2RqWEpSaEh1ZENuSFp1?=
 =?utf-8?B?ZFZNTW51TXljcXU2TkR5VkxGejhkR1FiMjU4bFhub2NEWXcrTTVsODdwVHFZ?=
 =?utf-8?B?NmREdXBKcXFVUlBkM05vWjhLUzhmWHZXQnZZL0dQS21IN0N0dEcwZnZBQk9m?=
 =?utf-8?B?THlHZmxBNjFlYlhwSkF6QXlQUGhBdU1oWUk1R1g4Zk9nM2c1ZGVYaG0xL1hq?=
 =?utf-8?B?b05yNWFJYkwzSVZ2SDhYSUxFYk4wejNsRDBBTFpmcEc4ZDFad3ZkQjhFMXZC?=
 =?utf-8?B?YURhTXVQbXF4enhpSm9rbTNOUEo4dmxYaWVQK0R5dm1xYUoxMXRJL09SK25V?=
 =?utf-8?B?L0tTYkltcTBqVlNuTnkwYTVPeUdkNkhUeWdVTnVvYXcvKzJBd0pjc1dXaXVo?=
 =?utf-8?B?MDB4U01qajQ1aTNQVFBpZDdGQ1BGaVVlT3dZa0hVS1BMdU10Z0hVVTVzTVlB?=
 =?utf-8?B?L0dvaWZLWFEvVW15ZHpCSVM0RFlQdHUyK085MEdZaWRoNTN4OGZZcXZnTmZq?=
 =?utf-8?B?Z0YvYUdnc3k3L0VtQ05VbG5iOWMzL2hMYS9SR3ZWVDcwZndjazYvc21yS0ZL?=
 =?utf-8?B?elZZaHNQRnBIanhrTzdRTDdtaW9ZZUZka3BtRk5FUHVsUjRHaDdHMDBtYnZ4?=
 =?utf-8?B?aCs3R2tlSVlIY1JmMzVQZDlZSGhvU00zdW9JR2liZlFESThYbEFBYmJvNTJq?=
 =?utf-8?B?L1UrcC9EcE9JRnlDaWlwdjJoQ0dnN0xKTTI3R0RpSGJaa244UFBWZEN6NkVH?=
 =?utf-8?B?NjhRMnloZzVFMlBPT2xnNXMwTHpiQmRGSUxHS0NBeHBCNlA5aDN6WGhGT1Vi?=
 =?utf-8?B?Y1lXUjBQMUIxN1RaNGJIYTFDZzVWQ210aFdFdDBkNldFY3FpZEcwRFl2Mkl3?=
 =?utf-8?B?cmsyTHdLVVF6ckxpcjdlZGZjenpHaC9uMk5ZTmNabkphTHlzalpYZVlZUTJq?=
 =?utf-8?B?cWxLYXRyZEozMUFNaGwrMEZzeVIrMkVMN3JQem90b2RsNVRRVFo4TDloTWhT?=
 =?utf-8?B?MFQ4NU44cG4zc2w1U2NZbG1IUjVIaEhCZUFPRlhuT2FDWkV0RDU1ajFKWDVI?=
 =?utf-8?B?ejBxVUs0Q2xaQW9ycEtnTmtyNk50WXF5VWpJa3d4M0hneGM5enZ2MmliL0U4?=
 =?utf-8?B?WTgrYURyRjlaNXkxUXEyZVM3U2ovVmhpamdXa2Y2UGlYTU5pbW5aMmk2Y3Ev?=
 =?utf-8?B?Z1Y0QVk2cmtVamFxZ0NvZ2FDNzdPQ3V0NDJ5ZCsxMEJJVTVOSFpRR05VdW94?=
 =?utf-8?B?RWZjL3l0UGpxQy9ONVhNM0VwRWs3TmNkRDVLZUcvMHFwYXlQbzhkbFB4bnlq?=
 =?utf-8?B?NlorU3Y1TmY5a0dtWmdSUGtZTlI5Q3hKWTRobE11eHMrdVRBSElRQk1XZjlW?=
 =?utf-8?B?WXUvanE3QWhhUTFybG05VnY3bW5oZGF3dWw5d3h5Ni9FYzlTL1YxNEdsbnMz?=
 =?utf-8?B?M3hRRFdWcDgrL0o4NnhoeHlMa0lkYlRKNVFyWWFFM3plY1hBV1RFQysyQTAr?=
 =?utf-8?B?cFFCK2w2eU9hZ2h0VTdGdytFQnNtM1dOK1ZpZzNlNE9OWVRRVmQwVVVxdmpK?=
 =?utf-8?B?OER1OEhobURXZDBMUWpqdUxzZWgyTGplczdDRmFySmJUS3RNNXFNNkwrRlNp?=
 =?utf-8?B?RERDOUZ3TjM4NXIzemxrWmJudlpaeFdCdm9RSi9WQnoydi9LSWU2OVF0cHY5?=
 =?utf-8?B?NVd6NC9zbTFzbU1aVGprT2kvNm1BNmxldnIwUExkRGxYUDJKcWJtL0lEUlRG?=
 =?utf-8?B?TWdoWVFucGVXY3d5MnkzL1VhTFBGQTk0UitRRVp6bFcvNUhHMFZVMkVTVmc2?=
 =?utf-8?B?T2dqd3dPN3lzQUZUVHJCcTkxYmtCQ3ZWb1N2c3hRcmhpODVtTmJrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72f4e9a-bbd1-4ba6-454c-08df3376d6cf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:36:01.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzj4s+jY3NDmpSGKYsFGAXJSmy17+UhvHncB5bAErgOiZI04+qDoTnHFUJN4bD+pP+UU5UKYPqPBqWaMagrCIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183

On 23-10-2026 18:11, Puranjay Mohan wrote:
> On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
> PMI, so the branch stack ends before the IP and callchain, which are
> taken when the NMI is delivered. IBS rejects branch-stack events, so
> there is no precise alternative.
> 
> The freeze only keeps the PMI handler's branches out of the stack, which
> matters only when branches into the kernel are recorded; without it the
> stack fills with the handler's own branches. A user-only filter does not
> record them, and parts without the feature are never frozen (see commit
> 598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")).
> 
> Freeze unless the value written to LBR_SELECT, which is shared by all
> events on the CPU, suppresses branches into the kernel.
> 
> With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part running
> CPython, the function of the sampled IP differs from the function of
> LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it.
> 

I think the reason behind this observation is skid. Without freeze, LBR
keeps recording new branches until the PMI arrives and causes a privilege
level change. With freeze, it stops at the exact point where a PMC
overflows.

The sites where the overflows occur are the potential hotspots. So if
skid is large enough and the intent of PGO workflows is to always capture
the last branch right before the overflow/hotspot, then having freeze
enabled may be necessary.

> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/x86/events/amd/lbr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index a55646fcb8465..7ec50380ac81d 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -392,7 +392,7 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
>  void amd_pmu_lbr_enable_all(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	u64 lbr_select, dbg_ctl, dbg_extn_cfg;
> +	u64 lbr_select = 0, dbg_ctl, dbg_extn_cfg;
>  
>  	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>  		return;
> @@ -405,7 +405,12 @@ void amd_pmu_lbr_enable_all(void)
>  
>  	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
>  		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
> +		/* Freeze unless the filter suppresses branches into the kernel */
> +		if (lbr_select & LBR_KERNEL)
> +			dbg_ctl &= ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +		else
> +			dbg_ctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>  	}
>  
>  	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> 
> base-commit: 0f443787a7f6ae907975742680aac2600483eaf1

