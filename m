Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24213790B;
	Tue, 10 Jun 2025 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749536582; cv=fail; b=JkccvlPLElDvXGJnPMT6jljwXZlYsjWr1ii8MaX0gCm30d5S30Txj9+GOHUrrMZWiXBrj5gtckrYd3kRHl82TisBYexSETlNt+r0c/epBG0JLeML8Cn71mCTrYT6ML/DXOn6f//LCMDSc70U1SkP5QLp8yAbMqaNM9J9PUqMXb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749536582; c=relaxed/simple;
	bh=KTTGtHKtVG+NTNPXmeFAdFpATncsPWeJJBHc1y/4/DU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=naN9ELhGS6Xfumqd2kx1PKK/BL6fuP2j8lZ4hJln8cJ5qur/ktbsdg2lo/SPHDFOZO2lDzNvsO18uw8rUA0dKg8e87olYY85THZAGe+K//ahc7YAMjaqdmYlzfBAamcvZ92FI40J9fI6Q6LRm2x0UkPOdPrFsroAOp9pyT3DGl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pY0hCJEQ; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pY0hCJEQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqCPq9HHbuSUvD4C0Pd4DS9CMrhSFtlEn0O7AiXtCv6EU+niLDyWOWHW7pVCrQcppSAxDmBZ6ovaiTTeRRKT00/xiAFP5nsj9bocJ5MiH1crqFHefnmGhp/ueWRfSVcA7kv1YF+xs4s+GfL/CZAi+gs8PqEoJYVdvN34r7swovYYX9+b84qEJu4gNq0vbbNYvsVFHcaEYD664mTIt4PKFgbGdW3JRxhpLYvdBiA9nptJrzjVUutAzq9WHzNmafcSIprJvPmlxreC/QZxe6lbJj9X7AW4ZBKgWRBcgwz7GSvpbshAclo6ANQkArE12zatI4w4scM0jqDj/YSkVdgpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTFIUGZRisUhZSC6QkjUvEmoaRCK9U6cFuBdBTiwPoQ=;
 b=wRstAp7YXTTYybbywFXQgSkYcrNsEwPg7bTo387FbH8TkbJU5krOSSkIz7ulLx+qXlNHLaJAmwCMB2avXxAtnjY4N/EaqeTigVEERdWrkhgISlr9nQPUsK/goIieK2kdgYPe7B8mWxKExZBrgH9z5QSuzS6q5SPN+MNuMhqg9l6qwKU/o6ccvoELRbAWVbbq2/NufLl92us+RScjbqYPLOX+MVUkljnHgvfU+px695WEzoYCuiLyRHbz5H/wYzqaJzIuTzXtXDRGcW/Ow5yi5Z4fCORR8ybnqDZeBrK5nvoNut3/krSYeSXbNWTWHmMX4V46WdIyI75h2VoZbRnEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTFIUGZRisUhZSC6QkjUvEmoaRCK9U6cFuBdBTiwPoQ=;
 b=pY0hCJEQO/IZs/fTg7/WpOk4RqUw+m0tfjbiIinKCGdgBeIj3ab8P1cbkHByLILTbpMClGSZCaIBcNNu/rBhexOPaDbU6FVlOCYsMHUVc+ZPbx7nYn40FreR6ArrkO5rYnLGF2bEfbQPO6CTSQxnXgC5jmCxCFJuzIIjFkIbH9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 06:22:58 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 06:22:58 +0000
Message-ID: <31aa6b64-f8c4-465e-a724-6c42ddb8ee5f@amd.com>
Date: Tue, 10 Jun 2025 11:52:50 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH for-v6.16] perf mem: Describe the new output fields in the
 doc
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250610005742.2173050-1-namhyung@kernel.org>
Content-Language: en-US
In-Reply-To: <20250610005742.2173050-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b93bf7-86f5-49c2-dfeb-08dda7e73e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEdHK3FLb1djS0MxeDJTbm1CNGdMaGpOL1FaaWRkTkZ6aU4veHliRlUrWVpK?=
 =?utf-8?B?dHdvdjhlOThDYlRobitVNEN3S3FZUXY5Y3c3R1o5Umw5UU8rZlhkbXZlQWlV?=
 =?utf-8?B?eUhzaVh1dndaUzJMU3VwT1hJcTZJMy9qQ29icG5iZUZ1b2I4OWFQNEFzVXpV?=
 =?utf-8?B?T3A5ZDloTmt6UmlUaWlQaGZoYXdaZjFIdGtsbG1KN250ZnY2Q0lwMDFzVFZ2?=
 =?utf-8?B?eGpzU29IVGp3TTNwTmx5dlZYbllNRklSamNTaDJsSGpRNUlJajg2c25qVTFN?=
 =?utf-8?B?MlEyT21FVVduVlFSbGRYQjJGdkhJS1lNNmUySS9Kak1JV2o0UHQ0K1g4dmNT?=
 =?utf-8?B?OXJPdkI1eFNRWDI3cWJjUFRVYXBkSlprMFhsM1VWRGxSYlZSdGVEa0doTXhi?=
 =?utf-8?B?cEd6SiszU2wrWGVNOU5sbFRENU5pOUxoUmNXcHUxb0QvVkF0TUlGZFFUZjll?=
 =?utf-8?B?QzRaQ09IY0krcm05TjlPQ2U2bFF5VzF0WTJ1Ykc2a0UvSnFob05nTi9SUFZK?=
 =?utf-8?B?SWZjemlScDZMWWJuRUpSVUt1d3FRUXVGWnhteU0wSzVkZ2JVb3lUQ29PcTlj?=
 =?utf-8?B?enh4em1JNGZNMGxmY3gwcWR0cnlHVlN3UXhEdnJSdEFySkdDWGJPUVY2bjhl?=
 =?utf-8?B?WGZKbEZYdDJpUmNVUFhMbGhmY2p4RkZmbGtlSTh4RW1wWWxGMnpzelY1RFVj?=
 =?utf-8?B?Q1RrSVFxa2N0bkhCcnBrZVhEUEdDeEthcEZUbEZHenpQNFBwajBLcmVOektY?=
 =?utf-8?B?QUZ1anJRVEQ3T3JiUmpobEhSZkhLb2xiQkZEMUEyV1ZDRGF1MlY3S1pJcHhL?=
 =?utf-8?B?bGxRSDFNSlJnWXFIN0xwU3prZlBOODhEZGVlRGRvV2p5akdZeUlLSnA2eVNm?=
 =?utf-8?B?cm1za1JyK2xxTVp6RWxkamhaODFpTjgzcUZuVXdsSkRQNFBlSVA1MmxrcGkx?=
 =?utf-8?B?QllFbXkrMlZMaWFUY2l6TGFUZkNvYjRvMzlla0VaZjdZMklaQWZ2Q3VRR1JI?=
 =?utf-8?B?S2dWZW02T2c0SmV0Q1FaSC9mYytYb21JVXV3OUVOb2xVeGpwZTdUbVVJbEh3?=
 =?utf-8?B?ZzNVYXpUVWVESXJISy85NGhMQUVvTUtFSVBvb1RHdHY3Y1htTElUOXJsNWZY?=
 =?utf-8?B?cmxBM1BiT0oxeW90UkJKV1pPTXlDOHN5Tm9KVUFOZWtjdkpXVy9qYng4bHBN?=
 =?utf-8?B?cTF4Um5YZ1JzN285YmZkUVRrRjBmRFI0V3JCNlcveURZS0IzQmZpSUJpNWJv?=
 =?utf-8?B?UUZvWTlNUUUxV2hBVk5kNVZwM05VZ0QxVTNtQTJtL3QzcHBnaENiVlNkcEgy?=
 =?utf-8?B?L1AvVW9DV0R2bjA4SlQ0dExOY0N4VlllV2h1L2lpeHpBRytudGFvaXpwSll6?=
 =?utf-8?B?RGwvWEFGZ01RQW92eGg5R2YzdmUwS01EMFJDK0h5K09McllDMGNicXVRTTBQ?=
 =?utf-8?B?MkQ2WHZpVVdWTllTTVJJRGh3Z3hQak14cnVRd3MwZkRuTWFGQTh5b0pxamZm?=
 =?utf-8?B?dHJyMXRxQkJiTnFGMnNaQ0pCcFIxS0JqZjB0YytSOVZPZlc3eURYNnZBbUJa?=
 =?utf-8?B?eWVVN1NEVlFIeTUvZHpGWXdHTUpUMktYUFo2QlphbkRDeU5yWi9Hc0thQzZ0?=
 =?utf-8?B?YzJ5VVJ6TUl6UTJwdWtuUUgzTFJ2YXo4NHpOVFdFdTZEdlRBV2xoT0J1YzFN?=
 =?utf-8?B?T21sd2s3WWthMllWM0ZWNUVueXRwNy83UmhISk1NMWFCWlZ4SWt1WnlmSVVW?=
 =?utf-8?B?Y0E4d2ZBNHJYd3ZuVEcrWlA5VEQyczB3R3R5Z1pkc05UVVhHV1ZFVGVGL3cw?=
 =?utf-8?B?L2hLTmVhTkZNd2JURWVlWll3RThxakhRVmVnaFdSdFIzWmJ0ZCsvdjVWN1dy?=
 =?utf-8?B?UkVseXBMSThoejlWeDNVOGtNdDdMMWYyUjQ3Y2U3QjJZeE5hUnhuMDZlYTRi?=
 =?utf-8?Q?kzoVQvpAqsk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk9GcnNFUzhNT1RTUXJ2MnQvMWNhdzBTOGY4dnFDR3MycnpmdGZxSER2bERS?=
 =?utf-8?B?RVRaMWlwRG5PcHpoeURISkdIeXY0a2FmVFhiVUs3SXd2TG53TWFZQlZQMDNq?=
 =?utf-8?B?Rm1zd3Ayc3RaQ3BXY1dYRDRWNlBxM3F0aC9BdXhqa0NWS28vT2J1RDE2TEVO?=
 =?utf-8?B?RGxvY2kxMGtlSUM5eGMwRklOSmNUQ3RHU1M4dFJ6UllKOFVtdUlRRm9tSEZj?=
 =?utf-8?B?VS9yVXRSVFltYk4wNW1wUlFlcTlWb0RRU1pxei9UYXZuaTdLV0hzTTQxM2tP?=
 =?utf-8?B?NW5aZUIvSFdMOGlTRFMyaVRyR1l5b05pYWRZT3gwTVJ6UHM1bTg3SExmYXNB?=
 =?utf-8?B?SHZHMEpieE10VmE5K2NNZVpzZ0dDZVo4RE43OWRPaXYvMHhGUkJzbHR1eXNO?=
 =?utf-8?B?cGhVYXdGbWI2K1pISEowVUNDUERKczYxVUdTMVJYQTdqLzQwSFFNa1lSTUlI?=
 =?utf-8?B?MXBpWmlKaGd6UndMUG00Y3l4WGVyT21KVTUrTVJHaFJ4L3dnUmZoRkVrUHFM?=
 =?utf-8?B?WVdLVStsNFAyWXV6SkNiblYxaWI3UVV3eTNxMDREMndpMlMrQW9tOVViMVpi?=
 =?utf-8?B?YTRUNlN1NUZjTm5td1g0RWRiZUhPaE9yUGNaZUhvdHEza2hwOTh6a3RCbjZl?=
 =?utf-8?B?ZGhqNm9lYUxxakcvTnJISHpTWkdCU1dLbSsweE11RnVwd1R5N0kzMkpTdGxt?=
 =?utf-8?B?aDVXMjRjYnpsdm5Fak82STJNRTJMZlJDdkwxSWZxa2lWUEc4VDdQYXpidFl6?=
 =?utf-8?B?TFpyQVZ3WERISG1rbXpvS21uU3dSSytaMTF4Qld5ZlE4QmFiTGxsKzBteDds?=
 =?utf-8?B?Tk5QL2NkTFhweWk0cDA2SklJa1RhS1ZYb09qdFpGTkpiRHdCQW9CT0dENU5W?=
 =?utf-8?B?dU5TRzF3YjNWSjZwV3VIN0hBSllla3FIVGZkZG5zdjlxM3pyU2xmekNNSGJE?=
 =?utf-8?B?SE1ucjcyUVZZSW5ITU83YWxVV243N25PT3dJYTEwNzdoZTFDUUNIRnd0WnZm?=
 =?utf-8?B?NTVhUFh6QnNtaFpjQVNZdG5hbzF6SEk3cWh4Z09HcE1Mdk9LL0RCRnJHdVor?=
 =?utf-8?B?SXNrYkpLditNUS9nSkQvZjhrWDBuY3B0NXpQNTVwUXBxWGZjaHQ3YUdqbkdQ?=
 =?utf-8?B?Ymxmdnh5aDViOWR2SEw0MGcrUnBoREhaa2dqRUQ4Vm5VcDhFSm9tOWk3NVlC?=
 =?utf-8?B?eG4xWTdwZElxMXVjZDZPL3VuNzI4MFovRjFDWUp5S0ZvMGRHNXpQNEVRMjFV?=
 =?utf-8?B?UnhpWVNGWTFiMDcySU1jYlFNOGl4QkpLNlJwaVZtOGVaNE5XcytuSnNzQXQ4?=
 =?utf-8?B?OHA5ajZrdVRHK2w2aExtT1VQS3M1eHZjTmdMaXVsMjVWVFhma1NhaDdHZWY2?=
 =?utf-8?B?eWdleWtHeW9uTWZ3bisxQXlXVFNyQ1grMnUrNUQ2dVBNYmozZmRqRS9xK25v?=
 =?utf-8?B?c3FmRlVyekVYU3dSejF4NE5HK2JaRXhETEpVUnVpWnNPN3l0aC9uWnFlMVpQ?=
 =?utf-8?B?UDJaelB2NDN0VzZxMEUzOFpzRWlDdGdCZUFkMUdDa1MwUlhia0pYVkZsOTY2?=
 =?utf-8?B?cFRZUlc4YmM5azk4SVF4OTVoemNNaGtrUGJZRzFWdGJMTG91dUJCeDAwdlNs?=
 =?utf-8?B?R1pSSU1kQ0hxRDh6V0Z0OVYxTWdSUUg3TUl1T0ZNNmhVaGROeXAzNGZPRUNW?=
 =?utf-8?B?T1FJWnV1dG5LS0tSVk8zN293RTRjNVhTYXFyUEY4eTBzekhLUFBlMDA1Sndr?=
 =?utf-8?B?c1VRdTNzZGNyc1R0TkpSUHVKZ1hlVlY4V0IrZG5SRUQzY2VLMWozdFdrb0sy?=
 =?utf-8?B?bGlyek1uV0ZneU9lUDFoc0trYlZmYm9QN2pINlRhT3F1K0o0a2Y2UmwyakV0?=
 =?utf-8?B?Uzh3b05UcGlrU2huNDFMV0tzOGpZU0FEYytuRUl6RHFxOWtOaDkrK0djZ0Zq?=
 =?utf-8?B?dWhsblIyTGplQjc4dnpYWXViZkNRc0RhZVdCbkxlZGJBYXd1elZFY1FIQkN5?=
 =?utf-8?B?WERzNWZ4eFNqLzFGNVF2UzN5SVRhby9JdEtOckdUQnl0WDFUZWIyYm5vTnNy?=
 =?utf-8?B?ME5MWGpQMk5mOE44aUVic3BCc1k4UG9YTzFSNVZPM0x5M3JWcWV0ZndVZ0Zw?=
 =?utf-8?Q?rmTxmVWAC/I1J/6+2L0OlQDon?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b93bf7-86f5-49c2-dfeb-08dda7e73e35
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:22:58.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3opyFrk4mefHjpgyBlBd8p/WBgIthFCnKMYZwsZSVzDR5Ttnmrhf8XDVOlTqf2Gcsvl7pPd62J6QryB0BBFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273

On 10-Jun-25 6:27 AM, Namhyung Kim wrote:
> Update the documentation of the new fields with examples and caveats.
> Also update the related documentation for AMD IBS.
> 
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

FWIW, this conflicts with:
https://lore.kernel.org/r/20250529123456.1801-5-ravi.bangoria@amd.com

But I can resend those patches by dropping perf mem/c2c example hunk.

Thanks,
Ravi
