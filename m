Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04B52FE28;
	Thu, 17 Sep 2026 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654139; cv=fail; b=EsCR13Usl5Z/uzl8Zf9gtKwhddrUEOGWnbl5xeNteS2Grwqm3zJ8tUPLhkqHQF8aKRXbfzJWLRbgp3pQsIy9JEmYaV5tTZVKDkfsP0Gyccl68PtP4itKFslWNqYSOMaHH/ZPU83RyCIa9QrYwDNinjxqoRKqcU1iiD4eUseaxSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654139; c=relaxed/simple;
	bh=gHwFn48LKNN4YhJuD8w3RGbBux1DlY+qyfVt2IKp+Pw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DrZSr+4/LmzHzcubcQX/3VhurkBXNQACrg6ZOSGI1PAF5KguJetKlxMrk5XqT8QmEWeTFkdmF4tEibg4LXQIwSazZTuOmqoZhWUtYJYVgMS/DhRGI3Ga48BNSRMtO7yUsoVY09CkfHtgLqT4GxEvR32r5DxlKRDsRBUsTpT0D04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4A19W+zS; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4A19W+zS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD6cYxzn0Btu7O+d7l0fIYO7WYPEv8TZGIzTZ6or+9JXnO4dmdhWBeppogqFa95HrMgLOQ5s0Re9oSIj9pZlDPTDqFZNx2OaUu3QRW3N6FgkB5LC7oFySAuAxuZhh/LvsG7+JeQHdslBsnxkWLMV80ScxqasbsP3jTj5JqRe2iKC6f8r6jujhIL27uZS7lu3ASRpoA/DLSMmBrH44hqnJ7/8vKIJ/jFyFrCNpwXzdC/DwvbfERrnzYTgMxJnYEfVkPCXnw/LqH2IKmlf589cVwNRbjVYT4+ozynR2pH717BRmPrqi1y+S7k0Phl5hMCwDTQzHqslByF9fX04RXnX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0htdcLLjr4MeNa+SHGYijR0P8V6PUD1/ecZ8U1atdI=;
 b=gn9VxTvrl2zbuQF1i62M5lBpdT/LF18g0+m5JcKMruLdv7MMJHGVbvRNQpn+Q186P44XxGpoy055XbPvjXFuL1EZ+z1ldAgpCiwURhDqKA6JFAAmA0G5Hfdt+4M+IEg+KrM/Qynf6h9NyZ/5fX35Vcmt1tCoRxt2lHN1I9xG2/AoGBca4L3L+ryVuy6I6zhw5wW26Vc2Or9s4gqzwwMlQWGFGmOXgcxCKo6v/T++Ii7EWWSKalHLuQuSvs1CRFCkpklaSJJnIf4yAdxCOwJz6kWrCB0ZvCmZdLvqHufHXNMzgpWF72qviXU4imSv9rHz+Ol8DnRrnKD/BnazPEFt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0htdcLLjr4MeNa+SHGYijR0P8V6PUD1/ecZ8U1atdI=;
 b=4A19W+zSwHWKIRJ338pU+BRasGkhBXyoL7mbN+tlzFoamMo8rt+D7AuIWH6adW9v7cSKB/cxAWaCXF0mirUuaqeUyVap40iNi/lSrqoHZNUkcYcxDVBBkTdAApSVfez8qQPds4HtSHBYApxP9oAbOq7k6PaK4PRSznwpAx6m2AA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SA1PR12MB999252.namprd12.prod.outlook.com (2603:10b6:806:4dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 14:08:40 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 14:08:40 +0000
Message-ID: <4240334a-621a-4ac3-91d3-294fddf1f05e@amd.com>
Date: Thu, 17 Sep 2026 19:38:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] perf/x86/uncore: Add L3 PMU support for Hygon
 family 18h model 6h
To: Fu Hao <fuhao@open-hieco.net>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, tglx@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 james.clark@linaro.org, hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 tingyin.duan@gmail.com
References: <cover.1788404433.git.fuhao@open-hieco.net>
 <d45936ac077e5a62dae6f40edcafa13644620ed5.1788404433.git.fuhao@open-hieco.net>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <d45936ac077e5a62dae6f40edcafa13644620ed5.1788404433.git.fuhao@open-hieco.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0091.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::13) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SA1PR12MB999252:EE_
X-MS-Office365-Filtering-Correlation-Id: 5909d9ca-ceed-471c-d44e-08df14c52c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|4143699003|10067099003|11063799006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ynCoYZgcCLdv53D65I0hrJwbdZ2snGB7sFqIm6OwubY3LRW2AFq++NtfcoaQLCwda1pZT/34nXD3xC+4GXoGJX0f8n2PZwEDgfqoKl27SmKhuFzmMW3lMiGMkkmuBUl7Kup9ieq2gPQyQnSKiExJh8RE4gNHFnZVtzWJXgwvgKdZ8PPxeIlwpy/UFRo5A2LHovQap9MxY9a7qa3v4z5xmoblDH2sgjpROp9zOsMQkdtAkq+wsnfkhLK+9iQaTDgQuBnUXOwSxm2nvfbWURqAf5Ctz1s/A/DdT54KGdmAnuXSgvndhY31WBHBcZ25jkCKzGE4ml5eAeIlKDVCpsqctdM+h6SLQogXchWgYqhRUdkhHh/ybkoyYv86GEtoRnrrOM1FJgICkp4ruaHBFNTTQG83nV33zeOGNpWI/6COqMQ9ntvLbfQeeduSSTXYn++nM+sq0VmkPOY0fxdQAN6u2HiIxBen5E3kX2p2qCCDp3z+2uxiiE1WMurHTSdhmLM/VrP2BHvr5OK3tn8Gxusi7MJl5paKEob5UtczWZcDlfVSaSz3Nj30Zsa3RvT3ZvJMv2VEYgToA9IMsxWYH2ai9AMy4g7vS7BPdv/pU9vifrNLLbzYfB6qNFAtkrqlqt3Z+HznDaQIxBdPx0n8hIVijiCLtzpMFUY46MH/S1Tc5eFzTyC127oy0wdg62OC/eKkY03aNLQ3cuPHknRcqIWpvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE43dE1WRk9mRGtIZ0pXWHpMb2NOamI5OUx5NnkxVHRlWU9zSy9ycERuU09K?=
 =?utf-8?B?ZGJPMTI4ai8yQlZvR2dsT3A3TmdYNHhkanZkTmVVWncxU2FDOEtJSDFyUTNq?=
 =?utf-8?B?STkvZHl6UXhsZXVDSjUzRm9HTVFOTUNZUnpYNkRmMTVBdVgrTHhBMmk5UkZX?=
 =?utf-8?B?bW5JTldIbXpDZWVYMGdXdDJEc0R2SHJpOUgwNzZabUVNM294SDQzNFl6WWk4?=
 =?utf-8?B?Z09sVU5PTlE5aytxbDl1SFBsbUxOZEFhdnRCU0pUWVlxQUVCSGg0VkZHT1ZP?=
 =?utf-8?B?UXRSUkVrL3ZWeE1ERStxNHFFUkdnanphd1pTSEp4QWYxcmNjSlZmSkVVd0I0?=
 =?utf-8?B?OEszOFduZzZzTGxlaEJENmZBSGdyenF6UmpGMXNvb2d3SWlSNnV3RUZLUEFn?=
 =?utf-8?B?OEVDVHhVZlJjNUVUMCs2MXdhVzlQaVdlK0xMTHROU0RVMDVQYXo4ODJRWUda?=
 =?utf-8?B?WUpJWm1DSDJJaUxxS1FNdmpiTGlNSllHR2ZrQ2NPa1ZFN2lVNFNCd1RRR2g5?=
 =?utf-8?B?RDJaT2pEcE1ySGRGdGVyamJxSjNnNnN4QTVEU1RkRlhKbHhIN1NuRURLMk1N?=
 =?utf-8?B?dG1helQ5eGJ5MmdNUHllL3ZnTGhLamVLMjU3NEp1TU5EMXlYc0E1OVI3UGFn?=
 =?utf-8?B?MGxSRUZXTVgxUVJ1YmdsSDgvbFYzUy9oZ1N6QWtvcFJpSUFNNzhxbjhJRjA1?=
 =?utf-8?B?ZkFIYmpVc2tHUEJEWXczQzBITzBOK2RGTzhMb21DME5US0xFaW1TcVVjNG1F?=
 =?utf-8?B?VitFZkJKendLNWk0OTF1SE1JTHBFam1abUQrRHA2L2N5ZXI5Z1h0VUJNdS8r?=
 =?utf-8?B?QisrNmVVWXlRUmh1SGFSbnEyZ0tReXZtdkNHZVhBaWRhMm9uZitsZkNFSGxl?=
 =?utf-8?B?bml1djJDbExPRnpUa29BVG1oRlM1UTE3ZHJBZWZrNEpsWVpuMDZiZGpTOG5i?=
 =?utf-8?B?WFpSVGMzSzVPZUdPZTZPSm9HUTBnTmlVMEVNcFB0K1p1dlZsSkRKcTUwYllk?=
 =?utf-8?B?S3l0bU5NMitwYTlMaGZPZFRuaVVFVVZEeVZpUEZ2VVpXTkpMMFQwL2ZUY3E4?=
 =?utf-8?B?TzM4cjFTOFdZTHhvYjRKWnNKOFloTDhSRk0xemFJVnBKYUdsdkF6dStuR2VI?=
 =?utf-8?B?RGZKR04rQVNncHRXRVFRb0V6Q1JzNEtKQzVFS3V1akMxeGdEbUREVFJVcngr?=
 =?utf-8?B?dDI2MnZmczZsRzJaczd5UVI4aUJ4M2ZYS254b1dMVmttSlZLWWVGMVdLS2Vx?=
 =?utf-8?B?OFYya3hCUlFBbnQ2aUdNSjB2MTJYb3FZYjNCTGxSNkJXcmFLdlQ2RzdPOEo0?=
 =?utf-8?B?SWNiMGt5Z0gzMHdsWnlOS1RBKzJIK01YUmJlWTNDNjl4elR3TnQ5cWJlSFcy?=
 =?utf-8?B?Yy9xN21mcGorVUIrdGRxeVZheElQem4yUm1nTzZVdjBFNFBjVHVpNStmQ3pt?=
 =?utf-8?B?R2c2Nm9Kd1NsZjAreFBGRnFzOG1vUytjNk8xUkZxeCtCVTRCaWdGL3hRTGU0?=
 =?utf-8?B?TzdJSDc2aEI2RmRoYlBFMFdoYWYxTFZOM1JkQ1U3WEFEbC8zS3BDdHUxdU12?=
 =?utf-8?B?MHdFaWhObG12QUIwSk9pWEV0eCtqNCsrdVJFcFRLMlJmczVhU1gxV2dZYVU3?=
 =?utf-8?B?SjRHME8yNUNVQXl1OW0xbTdoTmxYNXpQZ2w5alc2QndDZlhkeVk1UExUK3lk?=
 =?utf-8?B?OXBwL0o2NTkwUnkvWXdiNnVtbGppL1FKVUpiRkRqOElZWDVma25jMlp0dlM1?=
 =?utf-8?B?ek01ZHVsRm1SVVFZNjlibmRZL3A3bHlrRGExUkVwUEk2NFVWUCtxMDdNTXYz?=
 =?utf-8?B?Q3JJOStCaGRaYTliNDVtRXBYcjFzSGpvK0pGQXhxdzFiZi9vMjVvcGNFWW0z?=
 =?utf-8?B?K3lKZ0dZRk9LbGlxZk1VZGgwWHVoZng4WHo1VTZ1M3JZcEtwaEx3Sy90cHJK?=
 =?utf-8?B?TXhhZDNyaHdOTVhVblNUUzFOemRYeWNUOGNHSmlEM0lFdEYwdkF6dEx3QUpW?=
 =?utf-8?B?cS9rZGlaMFNEdHUxcVM0bUxxeGl5empQdy85SDJLOVo3S1dqbVlxTktlMjNa?=
 =?utf-8?B?dkNKWG43c1lOZkpXTkVQSUdIa2lrMXJ6VGd6Yk1jRzc3eTBRa0x4YVRyVFpu?=
 =?utf-8?B?RDRGNVpWYkxEVVZuSWg3dXQyQ2tOS2F2b1FodVJURnJ1dGFCNGxhTlpqQktu?=
 =?utf-8?B?dGdWb05WRWtad0RqYm50UCszMXJkbGM3Ri8ya09XY1U1QW9Yb1NBU2xPTjJS?=
 =?utf-8?B?c0owRWxBcXMxdmtFbGRLZ0JLY1hncFhFTWJpYWtRdURhT29vVEttNERBV3Nh?=
 =?utf-8?Q?M+HyTsV4474w0URgli?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5909d9ca-ceed-471c-d44e-08df14c52c99
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:08:40.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irQg/k3RimevnI/GDFXPhWstcQ/a+SeVOEeaSZ0dZHx+hjNWkiVRDhHGaWr6Z02RNKyEBrrY5bLBOrhIjseosQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999252

On 04-09-2026 08:42, Fu Hao wrote:
> Adjust the L3 PMU slicemask and threadmask for Hygon family 18h
> model 6h processor.
> 
> Signed-off-by: Fu Hao <fuhao@open-hieco.net>
> Tested-by: Tingyin Duan <tingyin.duan@gmail.com>
> ---
>  arch/x86/events/amd/uncore.c      | 48 ++++++++++++++++++++++++++++++-
>  arch/x86/include/asm/perf_event.h |  8 ++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 

There was a proposal to have separate uncore PMU drivers for AMD and Hygon.
The latest version of that series can be found at
https://lore.kernel.org/lkml/20260818100118.12944-1-liuqi@hygon.cn/

Can these changes be adapted to that?
