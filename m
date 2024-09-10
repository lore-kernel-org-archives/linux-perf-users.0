Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593EF1779B1;
	Tue, 10 Sep 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958878; cv=fail; b=cGCE1669GOObN7VDf0CWtk8aMhuHXx9vkEOyC1SKDjJ++MMhDfmI7cqo/JPVzkOi5NqWWYv4c1h/hEFwZ+UjqEhhnc9qC42HbXusiaoj/UD9USgxiSxeBQEdGThAA86J3UJXKBcx0J1TayrGhSRaa/n0pyNgjuPBcSv2uSvjgEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958878; c=relaxed/simple;
	bh=B4isRad4Jgz7B2MDC2yrz8ZP8UBNG4bXHo4fsC7MpDU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=We6sxLyYgr/UjkrI7XGzS5Rry2HOcwqebrYXKVoOAMxVYYMAIMeJlEAO63kHs3NB9G7Z50wr08d6bttD8coKIMVwst82/BWr6c7960xWcfDsRRv2TO0O7V2leHPNAHNQzIGvWIzF5CGnoXV8vnLsPmPiC+8zbU9030pfFnvV/BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FVug310O; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FVug310O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrvTI6EU4lbxdR6YHTJ3dIrAEMpB9yzwFqYRua/bit+Co8+Dbtm1pbobEP+BPTUYWOmobisP9sw4FE7JyfymMRGgrz9gmZ17hIQ+b/ruwqWexS6NGk592xGnCqjyzR4bzCWZeKx2gj5z3g7S++aUWZZB34W8rIYB6xlYm50SKwG+rzAmlgFirR+M7Owd09oXnIt7fejOfkUrOHfUXHrCDN2JkLEGrjuQJt/FfB8K/wNw6V7DxK4qlThLG1hphbAnFdsrdpbgaloGUx+dKskXVn1w8HhaXT4KucX51T8pKztoG3GEu7hmz5NMNADdux87GKEnbOczJh1T5Ji7kcPVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhdBbD4BRS1frqBg0t1WJ7H9BDePzV0/ajtwAP00J7A=;
 b=frADiFTEs1hZDoOyRfDS89I7y31Ue5XON8+MS2P0OjjnQF81akZTD+pxth1spoiz6pQnzSL7cmmcL55D09Qn9pYNYQytR8hhzUJMVNcTb7nXvbu1KzO03Xxa8s2/pMk2yhUVOWF3l2US0R6TyLZNvVoxxG0htczL29kP60ZsWjREUmnOgPYOUcYgNKTBrYw9Otm0hxguiIMQ+oL1Hm91p0EbY4eafDK5oqFCjpQa8ONSs9nlXWflrzbYgboykLz7CoMtqlEBre5A0EYi5xEptmLTtPe7IZt0ZPEBXtHDq+I5t3qWjLxQHIW7581gTtpqRnsEbUJ06eT6meAFqu1eTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhdBbD4BRS1frqBg0t1WJ7H9BDePzV0/ajtwAP00J7A=;
 b=FVug310OTcoZr2xlzQog65iD4Zf24cfViZMrRGQe9MNC5Haa+inhtNcDzY59tYad5chPPlwI+WxVQRiHz3DImuXa46Hq3Yl1qoKyTOLIffOOHSZRJhfVDYmjWRSKfB4pA3/m8r4XtU1NzrCDYkjdn5IY8/asVYg4IPBs1kQq+dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 09:01:12 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 09:01:12 +0000
Message-ID: <e6dcf103-56a3-4d55-a7ca-9abf06a0f893@amd.com>
Date: Tue, 10 Sep 2024 14:31:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
To: Ingo Molnar <mingo@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 gautham.shenoy@amd.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
 <90028792-19b0-4371-a8b4-0a37612b4c9b@linux.intel.com>
 <ZtmC8hhpUvQTXFDn@gmail.com> <a310b7a1-b11d-4efa-8352-c57875047ac3@amd.com>
 <Zt7Ayphs3F5FDCQh@gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <Zt7Ayphs3F5FDCQh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::24) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: d3700425-7422-4208-3b99-08dcd1771e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUFHZXk4TEFRZmo4SHpWWWJDVGZmNGxhQXJJTHVMYXh1MWJtbXJSdDVLS2dp?=
 =?utf-8?B?YUhUaXZESmR4Z05wZE94aXdhakRWNzQ1WWVTcXh2cVl0N2svMWxNR1ZnMS9u?=
 =?utf-8?B?enJRWFI1NS9lbVpQUXpwTkJ1ZGpMdzdKNmpVdGtpUnJmNzRqVXZqSG96ZnNn?=
 =?utf-8?B?K0dqQU5HeGhkY2JUeEM0dE9MbTJrMC9qLzJMZEg2dnZDNytCd3F2RXlHcUdo?=
 =?utf-8?B?VVpSL0cwTDNFYVVMbEFlME9PZEtIblVLM0x6TDdMcS93Q29kNmVGOEN5cnM1?=
 =?utf-8?B?bUdzYXNUWHlNbENIM0FlRWM5U0ExbnE3ODRPeVo2YWlrWjVya1ovZ0MzWktl?=
 =?utf-8?B?cVFrd1MzNHVaVEs0bkZXWUZzNlc2cmVRWmxYMERCRFFaYVRGaGkyTWtQbWRp?=
 =?utf-8?B?OUR0cEg0UEhFOW9PR2xyTkdKWWtDTENvTGg0bkpOSW5ucWtXVjlSanA2VTdJ?=
 =?utf-8?B?cWxBMFpubmtqVVExdGZkTnFaMGo3VS8vREZRMmtyaE5sZDlDOTF2Q1lHYXRZ?=
 =?utf-8?B?OENzbS9GZ2tIVTkraTVaVGVwbG4xTkhRV1d1ZVFkUlNUbVd6eDZ1cE1GMlVW?=
 =?utf-8?B?N3FyeHFDM09jeUNoQWFuRnhzb3BrK010S2dnckRIZGx2c1ZrTC9NWWtROGwr?=
 =?utf-8?B?ZGJPQ2tBVVk5N3ZOVXg4RkdpeGJoUExqRDk1WW84Z1R4WTlBWGpITWhUcERU?=
 =?utf-8?B?TVhsbk1MMDRFVmE5TXZhZW8xN1JYN3IwWDgxU0wza0djRExRS3cyU2RGUW5t?=
 =?utf-8?B?VE9oTWVSdTRJWlhKSVZCZW5NemUxSTNjczBUYUVtWXR1QTV6bmlFSUt3Vytl?=
 =?utf-8?B?RktxOC9XNkhHaUZJSmMzdk13Sm11UFVTYUJMRkJzQzd4cTJvaUVTRFhVaTVr?=
 =?utf-8?B?TDg2WnBwRi83Nmg4cEhHbkRiWHlHbjVwbE5IS3BIaWZJSHpjdHZ3bjUxUmRr?=
 =?utf-8?B?cWZWY0Z5aldxUWo5SFpuZXJPYzhoaWRjUUswZmI0U0d1YktkRVJYQkpxS2xS?=
 =?utf-8?B?bzVWb1FhejZMK1RDZ3pYdC92YXlHb0FHeXRMUE9MMGZiaHhpcWpENlNmOXFo?=
 =?utf-8?B?c0VFa04zeGlyV1A0alVrR2pzVG85NmFLTFpMN0tGRDJxWm9FdW5PRnNud011?=
 =?utf-8?B?bGxoVlBxS29kWnJqVmtJWk5wa24yZlI3YThGcENoRUVrNHBqNUhMRU12cG9F?=
 =?utf-8?B?TXV2YkZQL2JmMzRXQXdrVElyMkg2YTFqZVh1MnB3NVMzRGFqRVYxcXRibzln?=
 =?utf-8?B?L1UzZWJpejdIZERhZEFLQ25wS2tNZzFWYnozdTlqWVRjWHdFaU94SFVheFhF?=
 =?utf-8?B?RVpNaG5sZ0tvd3ZpdDZQNktwOVhERXlQS05TS2FNYlA4YjNqemYzYkw5cWln?=
 =?utf-8?B?M21NeVMwRXF5YmJkN29rTnNsTHNLcGhqWmk2R3RUZUcrR0FuT2pkQ0FMNXlk?=
 =?utf-8?B?L3o2OWwzTWNpVHNCV0tHUlVhbDdtMTVCejJMNDBmZmcvTkl6bldwbGxITjYx?=
 =?utf-8?B?ZkszcStHOFlPZGVPK1VJd3J5UUxBTEtTRDZDTE5uTXk2RjBuQmVIQTZqSDAy?=
 =?utf-8?B?NytNRi9RRXpMcDlzRWJqWEpmUDF5eHRobWlJRDNEMEQ3Q1MvdmUyS0V3Vm54?=
 =?utf-8?B?emxjZmdRVFNmZXYzS3BZYVc3cFBocGFJZkFwNkNBRHl5MHJzZ3VPVDMzUFZx?=
 =?utf-8?B?MFl4QnpMdGRuM2hJbytjbWQvZnFmS0xIQjJmTEFKSWhhQ0R1VVlReTJXb3BS?=
 =?utf-8?B?enNmcGg3b1ByTXFLMEZLMWVmZ0xORTh1SFhrZTh5NlMxL3dKNXlGYy8yVmlN?=
 =?utf-8?Q?p63nvh0SfSZmxxuWMElPhWrN5Dsivalx9kMhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3RSeThKMUJsVzdUbGlPcjZYRUg4c1NqUVRWV1NzeGNLZlhjMzZKWDl3YjZZ?=
 =?utf-8?B?RGVPQXU1MjVyTFkvb2QwVVFQY2RaelN1dDlNRVlJbkVWR0JlMUk5ZVBHMDE5?=
 =?utf-8?B?S3N1cnE4MjFHSytpQzdIcU1vY1NvSjdZK29CQ0plOTBLM1d3SDJRT01Tb3Bz?=
 =?utf-8?B?SjhiZ0VibFBvRGl3dDdkSXc0TkhRVEpXdStkTlphV0U0dll5RDRBOSs5U2pm?=
 =?utf-8?B?NnF5aGlwK0JqdnRNQ2hjYWgwNU50UEU0c00vWkx5amNsb0Rud2RQZE9Mdzdo?=
 =?utf-8?B?WHhBTFkza1pFTzdkVzJ4d24yZVlKeXAvK2ltQ3drbC9id2lMVHpkNVA3QnVx?=
 =?utf-8?B?cWU4alRZeHAwa3R4SVBzTDdld2wwMUkyU1RFREM0VmE0dG5sRUV2WWJ2NEdU?=
 =?utf-8?B?VmM3U254RUxWZ211TEk0dHV5K2dsbnNaMW54aFFidzB4Vm9aVFFZMDdjc2Z2?=
 =?utf-8?B?eEl4QTVERlhsYzBWalBWRDhuL3BqSnlYRWpFY2lNRXd2bUtpYUpDZTl4bXlt?=
 =?utf-8?B?cEdUNnp1UWJBeTJjRWd4VzkvSWszRTl2UkFDTUdKckxVNlE4WXhNZTUvS0s1?=
 =?utf-8?B?eXlpZU5rb0MzSVlOaFBxT3dZbHBNZFlMODREa3I3YmVIMkZ3MndIbUZqUDVD?=
 =?utf-8?B?eFFLK2dMbk5kZVp1V2wzUWdHQ3Q2ZnRCOFVyd3VHOWhIL09Qakd6VlJQUk1G?=
 =?utf-8?B?SHRpYmRWaytEcUo3aFlVSEtPWWhsVEZkeTJKcTNRUWJ3TkM2UnUwTXZ6RlpO?=
 =?utf-8?B?K2krNW51MUQ4VnJENTdNVElQOW4zb3dIUTR1UlJzaThrdlpQaHl1OWc4L2Nt?=
 =?utf-8?B?bGxWQkx0SFRKNi9WVVloeHN5TGxQQndKNGthQlhkSUp6V2R5UEtTUm5FR1hW?=
 =?utf-8?B?bWpFbFQwaDk3OEhGQ3FrR09NaFNGaDdjWDljZFAwYzBrM29FN0k1ZjdQeDNj?=
 =?utf-8?B?VlRPcFhzRlJPeXpqd2xXVkovZ0ZCc0NjN3l3Zzl1WEo3REpwRUdVQUd1S0hh?=
 =?utf-8?B?SWZCSnhyQ1RWYWdGT0I5UG5iY1gyblpKNDA1azl5K2RQa3dkM2lxcTdVSVVh?=
 =?utf-8?B?QnFka0NhWXI2dFJwWmUyM0xyZlBmaDBXcGdTMEpQUHdVQkVUOGxXSXJqUEhJ?=
 =?utf-8?B?bGNkZ0tmdFJIL1R1RnhnNy8wNFpCU1ZaeHRsdUVJWDdhdjJJWVhCRDVEREpk?=
 =?utf-8?B?dGRqSFJNa29tc0hrUHVxSFZNNE1mdnNQSEc0QTdERnJteXd6a2dDOWZ1RWJW?=
 =?utf-8?B?NzlGOGs1NGswenpJN0djdmtJbmNCOFdNU1JheFVxVllPTDBQY0hsZHY3QnlX?=
 =?utf-8?B?cnFWckRXTWphdy96dHBUeFpqdGUxc3VpVjNzM1pMb0lmSFcrVkhXMnVja2Rz?=
 =?utf-8?B?SzYxQmFRaTJKVEgvSXNkYjl3U05UZHhjWFpnZWxrZi95UDdXTENYV00yUU5C?=
 =?utf-8?B?eUs1czlPa2V2YTA0NnR2czdHdmVFbmNERWJBeEVKVEp6eUxDMDRZUFJMR2ls?=
 =?utf-8?B?UzZDcnZNQkdGbnNZSTZhOW0xTE9XdE1IMW93T1ZtNGNVeUVZQ204eFRtQ3B0?=
 =?utf-8?B?ZS82c1JScHFzbzBOZkVBTC82V1J1dFg3WDE3cFVoRGFTK2dXTW9HU3FVK2hs?=
 =?utf-8?B?ZDFZZlRYMDJDU0JKRnA3UEcvNUl5OVh3SkJOSEFvN29ZZGlGQ2NEV2Y0M3VV?=
 =?utf-8?B?WFpobGJTRnpKK1FGYnQxU2ExMVR3UEFTbU9NN0hPYmpnSzZkNHE3V0JudSs2?=
 =?utf-8?B?bWEvZlZIejdOdXM5K0Z0LzMvblBRVjNnR3JoUUo5Y0pZU202eWpIWkR2VHA0?=
 =?utf-8?B?YWVncW9wM0hmWXovQUJ4RSsxYTRMVTJsbWFOSldneHdOekw2Uk1iMGdiRHM4?=
 =?utf-8?B?TjdxZnR0VWl6dDhKWVlUaWVsQjJDN0FKZW9JZzYwVFlZaFoxR1RJZjlWczJ2?=
 =?utf-8?B?aWpRdmx0S0ltTGtrOHU0cUVCYWliRkkwWEFETHBSa0dyQWJXYWpORlo2ZW1w?=
 =?utf-8?B?cUgrVnQrdVBldEI2dWlZV3kvUEowTWhyWU5aOTVaa1o3VzQ4SUUrazI0amNv?=
 =?utf-8?B?V21oSTF5TmlGaTFraVZxczRVcC95OHZMQ3hmYXdTY1dzamxFQlZwWUkraGNS?=
 =?utf-8?Q?83tUbtiKEvb2IYxfLPwtYU9mi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3700425-7422-4208-3b99-08dcd1771e85
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:01:12.6102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpaSAU6VJF+yuIcG9Xxdr2VWCDq/tWz7oc5HcvGvr5cDQC7E3vrkvlX6FtUMIspOjOazVh5TEMthCXKLqP+KoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280

On 9/9/2024 3:02 PM, Ingo Molnar wrote:
> 
> * Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> wrote:
> 
>>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>>>
>>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Note that I just merged the older v2 version into perf/urgent
>>
>> I'm not able to find the v2 version in perf/urgent right now, tip-bot had given the below link before
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514.
>> Have we changed our decision about keeping the v2 for backporting and "revert v2 + apply v4" post the PMU scope patchset?
> 
> Yeah, so initially I thought that this comment of yours applied to -v2 as 
> well:
> 
>  https://lore.kernel.org/all/b34e30bc-a003-4529-bcfe-8189ca7ddc5b@amd.com
> 
> ... but in hindsight, it's -v3 specific, right?

Yes, it is only applicable to v3 and I had posted v4 to fix this and now posted v5 to rebase v4 on top of a recent fix 
in the PMU scope patchset(https://lore.kernel.org/all/8c09633c-5bf2-48a2-91a6-a0af9b9f2e8c@linux.intel.com/)

v5 Link: https://lore.kernel.org/linux-perf-users/20240910085504.204814-1-Dhananjay.Ugwekar@amd.com/T/#u,

Please "revert v2 + apply v5" post the kan.liang's PMU scope patchset.

> 
> So I've restored -v2 and it should go to Linus this week if all goes well.

Thanks!,

Dhananjay

> 
> Thanks,
> 
> 	Ingo
