Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C61E47D6;
	Wed, 19 Feb 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973168; cv=fail; b=OLN+NkIXv4DBWECL0c9CCkk+IiQ/uEPIvOU0vBk4ZKByF7vYL6XpKswPlM5Aja6axp3kpu8kPDmj+Dk4iWYhvzfT0l4AOcBA1o4wXtAGg1UPadgvLCuYUCbBCMevWigmfDMcPq/xEoHQoa8KjyovAcHJMNma0uTNg6N6W6FwbQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973168; c=relaxed/simple;
	bh=jRljsKGUqGqhNdclz22Cu11rrcUtT1d19in0r8O1pt0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LZoqKGqMKC9fqZQOQG+Yh/Ns5ETSSUl+PfaWU/mwROpZywu6XE99fcD0+CMgREjq+WmWkXPD3jZFlLn8+1+yrrDr6AYkHD3lsGsNWhkC6jdwOYaaPGO0DrSTkMHCZZsT2en5MjEuMTJUvTG/xnnb/LAgq8sMOwVKF6TYk3D37sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FKrgisYH; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FKrgisYH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dnwo6EoG3V93F2yMH4NEVLTSp1Jy7wv57u1Ryt9bCs8dlQxLpmA+O+t+afLWlGCXjLnwePg9uATcwPN5qaMoe5SxlgXxJ18T0D0AdEN0EUbcY+rQK6KJkqD2lG3Rcj4orAnu9wE7LGLeFuUTdBpmogS7Lvt9mi0R1tqk9McCPzj+V+vo8Exx6mo+TOcI8qkbTLJ9E6vrXIbYPqDkaecXWKWSc/e7DnUL9aeCkUJ0C1w4V3LRcHxBLM+HU5CMA/tLQTU2d+2FjrefmVZG3loO6EXquJmbByA0HsBAifhS4yjNQEHKNxNtQ99lRnBI777iGUHB3VcyTM/cyGlXd1XZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDGKIWI7BGeik2jL8Q4HJQ/k/wO8Qhqn94Nt8SRxb1c=;
 b=QtwXHofXuIUNDhRk8VglInwtfoC1UkmFTusstWtRUDCLz9+FPKzRcKQqWuVPHR0iULhuzV5B9ScXeLE5Uq5MwzrLb3C2N8u3C2OR9y7W4ukvo/bKDyTGs2BxJHeYTslkuZN01WszWhBkC8qjeLO8PEpo7x6go66Mmx5PXE7vsJGXjxwVulbDrVsdkJDZ0WpGMg3hsyQw2qiCz2wx8HTb+2IRJrs22qDTkMjU/piYVfrQv7JRIZtDwEV26R2par72wh2xpGm6ANjBf3WShuPLIu+T1bjpHGZEuhOM46q9cWRC8gzLT6jzbtVId5BNzWRDh5QUps3Ap6K40TrA268Oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDGKIWI7BGeik2jL8Q4HJQ/k/wO8Qhqn94Nt8SRxb1c=;
 b=FKrgisYHKu0qfweg7bYVaeadIvIQ58CO5GRUmqmjezPFtD7pz0nMag9w17VuNLWgAsCHHhMxWfoLn4v+av77APliM6KNU8wQ1sq0qqyY8b925S7Xp1+sGXjHYdnlJR4EULjz4Av4rhYrlM8FHRr9a19zVZUnfQg7VyUTDnIOjCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 13:52:38 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 13:52:38 +0000
Message-ID: <71c5323c-5bf9-4503-8dbd-717372461550@amd.com>
Date: Wed, 19 Feb 2025 19:22:28 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RESEND][PATCH v3 0/7] perf/amd/ibs: Add Zen5 support
To: Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
 namhyung@kernel.org
Cc: mingo@redhat.com, eranian@google.com, irogers@google.com,
 jolsa@kernel.org, bp@alien8.de, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250205060547.1337-1-ravi.bangoria@amd.com>
 <65818316-434e-4468-9ead-2e55c15b62eb@amd.com>
 <20250217142445.GA2076@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20250217142445.GA2076@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::25) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bb8a8a-0a03-45e7-2385-08dd50ecabdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0QzRlhDanZVbW9NVEhoOWJJem4zeCs0cUh0Wmx1ZTFWQS9BNkczOGpKNXFI?=
 =?utf-8?B?T3FXU3JwZG5nMWx2RUR2b1ZVQUJkZ2N5a3E3YzhpekR2dlBWeEMyRkNtMUtQ?=
 =?utf-8?B?WU9tdVpFa3FEVTdid3N1K2FFNTdLamlPeW9nRjVRbDN0RTgrRktJMy82NWhy?=
 =?utf-8?B?eG1tYmI1TDVKNGtIbTIySURJblp1cEQxU0lSZmxzZVdzTXFYL1hoU2tnV09V?=
 =?utf-8?B?bEhxbnFLL3VlYWZvVVQ3R2xMWmRxV2VCSjhvZ2w2bkVOZ2lyc2VTdGpsWGtU?=
 =?utf-8?B?emhIWElvU2dUdWVBRERRdHpIMFd2Q1J2TWRMUm4xQnIzeEFUY09QZU8xUlRp?=
 =?utf-8?B?UU5WWUZaMksyWG5hUGhnb2c3QXZnazRvRklMRG9teXY3d2FxaTFKNC9oRGdz?=
 =?utf-8?B?ZGYxRHV5UkV6cWVRNzNNK1pCbk00UU40N1Y2ayt6QTNzd0VjQW9hT0NQNFNl?=
 =?utf-8?B?VG13STB0OGpwOHhsS3kxaXVKbWtIblE5MUpUTHdiQmhvcVdaVXRDTGNxeDFm?=
 =?utf-8?B?MTZ1Rktwb3RLUk5GaEZoRnkzaEptbmN0cnMvUUpXOFB2aVArMk5DalRCTEVt?=
 =?utf-8?B?cXZwb1NjbDBtSDlZQWx3ZFY4T2pJNnhhRTdoNmdWOUhUd2tUQlBvdGd1NllH?=
 =?utf-8?B?M1ZlK2p0MzlVd2V2SXlmeWExSWt6Nk0yd3VNNklFOHJrZVIzRHhWUXF4bFRJ?=
 =?utf-8?B?RVVtcmt5aHVIa2R6UndrTGhZT0x2bm9ZQmhwRTJsaVJFSTc1RzNxYUVZTDdo?=
 =?utf-8?B?L2ZPamkwdjlnU3BEUnNQNmZMU1VmVlV3WVZMVXpXOUp1Ym1aTVpIelpqUi92?=
 =?utf-8?B?cm12VC9KTzZjWWZxeFBxbGQ1cjAzQjJjUStONW9DdmFrZ2xsNFdWd1hkOUh1?=
 =?utf-8?B?SWdvTzQ1RzdqSWVOdmJwZUd5ZEdXcWtPZVdRVXBka3NxTjQ0NmIzY1JFSnN4?=
 =?utf-8?B?NWNtY0pPU1BQdXhMS0hNeVJjNTJMTDR5TGs2WVFQUzhheGtja3JaTm1Oc0s2?=
 =?utf-8?B?N0lFTDE2UlBZVTRhSW5rMU5VT3VibTdQTG5EcjNBWWlCNjJ5T0ZOZy9LcExZ?=
 =?utf-8?B?ZEFYRW92R2VocEMvOG8rZWEzUnNWazAxb1ljZzlldU10ODQ5Zmk1bldmQmU4?=
 =?utf-8?B?R0RDTG14akhuUEhuWHMzblBic21NcjN3bkdEdDBTS2xRWDdreEVZVVlhYVNM?=
 =?utf-8?B?L1ZOU0k1VzBBZHZ1U0JtSTFiQjFuZTN4SXZuc1ZCNjlFVFNQOVNYcUsyVUxL?=
 =?utf-8?B?T2xPNUxwRUZaejVuMDUyNjJmSWE2eGd4VTZheFBZa0YzSmNJeWFJeFdUOGZL?=
 =?utf-8?B?d0Q2WVkxSk5rQ2k4NUhuMXhCd1VHZ3NaZFUwM003TG5DbEhVRXZ3VHdJYVJj?=
 =?utf-8?B?eVA2L3ZjeExscUd5RGx4dVpyZHV0M0VZNUp2dlFxK3RtU25ERllGSDBtaFMv?=
 =?utf-8?B?RUxLOUdvRkduTlhQUUdnTTdiSDhnMVB3MWYyZHFmK0FoT2hzOVdjai95ckVt?=
 =?utf-8?B?UzJTVmtEay82Mncyb1hod2RwVmNpK3ZNRGxEMFhpYnE4SWpSeVFWdVhBMzNa?=
 =?utf-8?B?bFk1MWNtR1JTTGlaWnBuUEdvcFlnQ205dEdITDJTN2ZTc3ZGZHRYMGV5TVdv?=
 =?utf-8?B?OGFVbXRUWkdva3ZqOGdVa1VFenIxTWxERmI5VDQ0eWlhdHpqWEFYaE53djlz?=
 =?utf-8?B?UGEvUFF2TUU3cDI3Y25yOWI4WWhid3JSTndvb1U2VUplK1d4Tmp2cTlsZ3Ey?=
 =?utf-8?B?QWorR2ZFT0pmNWQ3V0FRSkxrYVhTVzdvRGJ3UlpZS2d1VWFNTXJCQlRTYUVj?=
 =?utf-8?B?ZG5NdlNaTnBId3pocCtuUTRmcFQrQ1JRNVBxUFAzaTdHcHFNZnNQREFHNHRO?=
 =?utf-8?Q?pnBcNXfqRDe9p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2VxNFEwWFRtQVl3K0M5N0Rvc1p4dDMvaGFGcUsrSWRNZXRQL2dVS1p2MTBG?=
 =?utf-8?B?WXRIdktUbmdXWGx0WXkvdnl6S2NXMER3MnMwUXZQN3ZxZ0R2OHFCMGdVQzNW?=
 =?utf-8?B?NG9xMG5oVmhXSlJNMVRVU0pGL1pqQllPdVBGTjhhUk1oZlR3L0M1bDJuQ0pC?=
 =?utf-8?B?OTRPOWJlV2tNRFVyakpSbHNDTVBpbmRZT2NDS0tyM2FLSzhRdUt3eWRRUXFx?=
 =?utf-8?B?Y2ExYlhHM0Y2eGhndEJ0ekkxcitLWXlYdTEzRHVVdFd2eGs1WnFJU2lyRW8v?=
 =?utf-8?B?MVpxTzJnbHpyUEhMSGN2Mmc4UW5RNlhMeTk4cHlvODFHVXFac3ZnWlU2dnpR?=
 =?utf-8?B?MGFaeHdzNDRTMk5XdjFNMGlpU3R4ZkpoR3kyOXVJKzBabnBzQ3JFSUl6Ymcy?=
 =?utf-8?B?S1RYZkt3b1gySFNIazJlRzdHdjF2MWNGNlhreThEU1lGZEhwN1JqNDhBUEFp?=
 =?utf-8?B?SnhXNEJIeHMxdWJjTzBWb2loYm9rajVvdENTcGlLSVBJdXFMeUFyMDNkcDNG?=
 =?utf-8?B?QXBMM3J5U3lpaEkzNXJiY1pBa0hCUjNjUnh2ZDdkQzF6Qkc4cndXRDZxNlJY?=
 =?utf-8?B?WUNIUURNbmhmNExiQ3hrOHBUK25mSlZKbC9HNDFHcFdFUmxFVTIxRnp5ckMv?=
 =?utf-8?B?STFsZXpGa3ViWGRBcHE1NklhenYzZEFzaUFsWlcwY1g3TDR3a25aQ2JMU3Rl?=
 =?utf-8?B?MWtDNWlTT0lRQWcvOVZtYXRUSlFOYVZhcjdwNUVzQUZERFhwRVNxeGNHekJQ?=
 =?utf-8?B?VE5MOUdkYmE1bklUc1R0UWJacVZ0WTcva3JpYjFnTFJheExtaytyejJLaHFM?=
 =?utf-8?B?ZHFuZ1ozekpjKzk3bm1Ba2hpVTJhb0hkZDM2aXF1b1NDQjBuZmxJdkNyQjVV?=
 =?utf-8?B?ZjhvYUJCeE5jNnhHSHk4WUs2V0krZFc3OUU2NnMzdHc4dWhZWDhSc2ROTWpZ?=
 =?utf-8?B?V01IbDVnWVJFeW11WjlRSzZ4SE9wRWZsbFVkYjBnOWMwT0FRKzVWSmZ6WXJr?=
 =?utf-8?B?dWlaSzVySW51akYwblN5V3ZOdGhHN2dHb3EvZFhOdzN2emt3Y2lpTmNEYnNM?=
 =?utf-8?B?UmZESjZSaW03by8zcVBQeG1JZ2N1TTQxMjFBdTNiVXRuUXJHMFJieDdKR25B?=
 =?utf-8?B?M0NXZWFad01mbytsMGhUQWdNcERkekhyN3RPVXhLcENGVnJpSFRzT2hZcHNU?=
 =?utf-8?B?SVFkOXBuc08wSU5yUDljOEhKRS96MCticXR2WFZWY3ZLUlRLNzdxTi8wbTg1?=
 =?utf-8?B?eHZFWjdSRVp2NU1hU2szYlRka2w4c2paRExBdzkwekRpUFp4aXozS0wrVmhw?=
 =?utf-8?B?UEVSWWFvODRTcW8vY2pZa0kxRDk4ZW1wVmsyVmh2dXkya0w1Z05YOTdHZU1Q?=
 =?utf-8?B?bUJuWTdDTHFDTmRpd1RjaytFclFiUDlJdEIvMHpNejZvNTZyYmtkWkpWWUNq?=
 =?utf-8?B?RlRkZDhDYTl5SVdzUWNWZnluMW9sRjRuR3RYV1U0VVJ6MkpQUk9ucnBDblNT?=
 =?utf-8?B?ZDVCU3pUSWtKdkZudEdLNEhQd3VlMFhMaHFRdnVuWW5vTklhc1R2QkVYWExG?=
 =?utf-8?B?UDBVWTY4RzBjYlNvSml2a1ZZUk96czJ4dWpUYnFYc2Flenk2bVlaYlQ5bkw4?=
 =?utf-8?B?dlVXdU0yZEZRUVBrc2NsVDczR2xnV2Rub055Z1l3Q1NmV2ZTUjdlTTJZaGRF?=
 =?utf-8?B?WStVc05XYXR0NFVRb2VKMzd1RktlMXJ2b3ZZMTJHbWlZWnhlNFhWc1BBUE5n?=
 =?utf-8?B?M2dXdTY3cWlqbzNjcGVVbUVlWDJUZzZHdDlnYlg2ZEJ1czJKZVZWaFgwTEpy?=
 =?utf-8?B?SGNvOEFYMXcwQUxWNlhvNHM3bmcvWWp4eDUxSUoybytob0MraG1TTnFMMlZD?=
 =?utf-8?B?d0RxbXRyN3FFZ0FiTHREa0FmOXVWekVWRlZVOUwrUXBkSVp4SG8xREIyTUU3?=
 =?utf-8?B?VVlCT3NzUE9tOWFGS3BuaXZLNGpucEgrdU1RZ1JrT0IvMUVvUCtWUXQwQzhn?=
 =?utf-8?B?bGYzSnJOay9vbG9CYnVJcnFCMW90K0FZbzliU3liSmlwRmxDVWMyTVl4QXU1?=
 =?utf-8?B?MmJxNnVIYys1VmhRUmZTdGorZ1Y2RkorbWJSdlFLa3hRcHBwR2Y2UmpEVjY3?=
 =?utf-8?Q?hrUkooDuH5hhYiZ4fE5rtNrD8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bb8a8a-0a03-45e7-2385-08dd50ecabdd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:52:38.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6B30FNiMVBppRtizAvO2pg5xGG4Dn6bKhtHDf9xuBd/B7QQhTWF2HtAgE9N2lHrWaJB2ZpUdf3Yn1N7eQoPfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

On 17-Feb-25 7:54 PM, Peter Zijlstra wrote:
> On Mon, Feb 17, 2025 at 02:00:14PM +0530, Ravi Bangoria wrote:
>> On 05-Feb-25 11:35 AM, Ravi Bangoria wrote:
>>> IBS on Zen5:
>>> - introduced Load Latency filtering capability.
>>> - shows DTLB and page size information differently from prior generations.
>>>
>>> Incorporate these changes into IBS kernel driver as well as perf tool.
>>> Also include a perf unit-test to test IBS sample period constraints.
>>>
>>> Patches are prepared on peterz/queue/perf/core (cffa473a06d2).
>>
>> Ingo, Peter, gentle ping!
> 
> First 3 patches are in queue/perf/core, assuming the robots be happy,
> I'll push it into tip/perf/core.

Thanks Peter!

Arnaldo, Namhyung,

Patch 4-7 applies cleanly on perf-tools-next/perf-tools-next (commit
20600b8aab73). However, perf tool build will break without patch 3.
Wondering if you can pick patch 4-7 without patch 3?

Thanks,
Ravi
