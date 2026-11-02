Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793626840;
	b=tjG4JwwdsYeK0lokv6AbpR9YTNzn2BJqtE28REVQej1mUOPiEsoYk2KeHtAiMSBIsvUV
	 HH943IAKeM+iAikIw6eiewT/zhMBfz93m8m9p/FItfXZZ7udVaJA+eCVR7SwBY/WBrjB+
	 1J6Bzxh8U9Qr8ZnfoJY3Dum92Zg35qOyoUPt/IhFR2G+ZG99cFEo0yKzX+P3xdXWbQWRv
	 aKy4MGgSg3VaNgkFiP7VoP4yCwAKqa6wnbpQgP7qGkIitbIPLiR26IGZtdDTZ28rTHtJh
	 0qY2MHcuh4wb5FYcNWpFAY0QuPEetU3MviQipWFhPTSD1okACxJw5MVP7Nyq+dvz3fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626840;
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
	bh=ILFWDuxNJGma6gu5yf9tAXICIQqZq8xz2ARtbM89ebQ=;
	b=ejq957jt7FJNpNZcOnEJ7EAoxhJ+/2q7CcvgTJ5F9Kr5OagKNH4LXsmQemMU2CILhzWn
	 QsGGaSqmKD/dqNHptX3/FpMasD7cLD8ibr4EdsXTjAQ1FKBKLhb4yHgVtrYUbTn++88x5
	 LGRKmxJdKqlRle2XNHxYvpuG+XHU00JqEkvv6brrhyOTBAjr7mVraCafzeR/pRoxGfAmf
	 GRhilP2pwqq/ThiAUTdxl7Ee4FzDx+bx7RJYWaWCl9ZDd8igkJMNRHygvQje6Ot5Z6t4d
	 Y32rute7AQx2PxIXNf1lwPVvizFwlEUejxK5kiZ6sTxF3OJqqUd3kDtIoGx0h4oTfxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xuX1fcIk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.34
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057D60A2605;
	Mon,  2 Nov 2026 13:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6057D60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xuX1fcIk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpNSFrvfGnheTeD0bYtaBf/O3rpLLDRK0tI54TOKOxAWrhWOSm2cNjlT+wvLm5awQkVZzbQXVD9SmflGPLB7oBSspSYyx7AZ7raA0vNt30FF1v6rmhs9m9wI8ITTXsLMI+RLOMhBQLT+XaVEMpx+WTadIDOKH0geWeN7T+GclBOZEsYT1c6tuPaRz8+2SR5127BfhbD10bFBbpHcS8YWMlAQoOUhG2XC0F8SJ5s0ZwOBiqZUncOaWpfa0Jw6UUv+mHz/r6qsgaBUiErP4yKOSSS3ybOl5HlsDviJPFKeQ1rAnt5vei67YIgAb/edjfrP51Def4zmgk1L//q94szvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILFWDuxNJGma6gu5yf9tAXICIQqZq8xz2ARtbM89ebQ=;
 b=YNzvRpgOwA7IlzffeBXY+xCNspzciDe7DknZbvoZXJAda9IG0mfnN8lPT4tzIXkYQKplqTM2VIolLuZ4MQrZDPeRRromoPDZd+1Vuc8q8Xgp9dZcsFLuCV/wIFz1IUKWLEI7vcAJvCrNDJiHjxBHl8wm5Dkz3oFAzXGgUniAOs34/RXuR7zd/JAsiMmT/8+PCXttxWSgs59cFs4NUjI8bzuRQXa6j8W+CmM57s51iRvaCDxvGPBVTSlQFX9rAZwdsdy6Z5sCmQYxAhNWuMO89PhrePUgaO7BXxrZlASvS6wW2DUFuFFZU/ZNPDJjp1RQ0j/2j6ife3qGCSKIkTNv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILFWDuxNJGma6gu5yf9tAXICIQqZq8xz2ARtbM89ebQ=;
 b=xuX1fcIklhiIAFzqIO5sn1XvtfJv6wgrPZG8mWVwxDaQxE9vHHoCJwPvydlKKn/G7JBEX3q/fj875OzS+tdqfCDN+ozRpb8ScxQWAyYIP/VbjQw+OAKCcAOMkfmeBHuOKue0fPK7Bmde5lCVwe1TPFgEElLX3jXS3uB7BDi26UM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:40:35 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:40:34 +0000
Message-ID: <a2d9067b-c5ec-495a-9853-0c1cc2625d0c@amd.com>
Date: Mon, 2 Nov 2026 19:10:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/uncore: Avoid context migration from
 non-owners
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <273135a6d33a40f442fb18e140a90689fae7cd32.1793614726.git.sandipan.das@amd.com>
 <20261102125543.GH1813469@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20261102125543.GH1813469@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2bb::6) To MN0PR12MB5713.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: f85470e4-fc35-413b-b915-08df38e6def4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|10067099003|56012099006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|11063799006|5023799004|4143699003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	98XhcXCKwkvcGmSGoKB9B5Pi3aCqkg/OC+CvSoAVzQjHdJN3t0N/ul5qLqRSnW000FfBSo5HRWfD++p1WpX+815Bjf5ONQTBnNxq4Wq4P0ttxMXbRZGKDhd4Azufs3hJsKp54l5dirFjpSGjVY/pJx9nRIxGLxJDiMGOydg7xQxSDFZJdqvCxMetfbJAEc4HC5M7e4wjkfwqpBq9G+gg4ghNHlI09FGFWLdg8F8Fdp8ctcg19qE63Bpf9tbvHmMpkF7fhqcA0dS3xMGrDCgO6LM2lrZgu1XNzrkzZWwC4Iq3B2NR/pJjxcIh2hhQJV8dKg0ZaN9PpBTHByfbSQekkuZgRSvfieVVN3ECqR4Mak/NYZX35HFKBRAZx4RdRpJY8Wl6++NyhO9PCYLfgZZ1GIkhFGAeONRTVBV3OrgO13HiYSwGyTi1StKhdi1gIw6H+uKLZUO45ToFTQ2njx3e3mrNGIjHzMdaq5W67VOeXjzuruM4dd6mrOmuFIQon1omuQEqftDFtHJZ+5Ta8B9bRvwlvNKGFCVNyjYUzAtw3xzONxa62vRzY6640ISJiMTsGAl+dtmjxptN1KHLAZurcC8ELDIxPGePlNNRY9X6bWaFWtd3cKkc/ZoDgSnsS6G+XUlxnmOUuf7ZJf+p5hEL/ci2oYCjAPTTXXx4+B2d98U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(11063799006)(5023799004)(4143699003)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUhmcUwzNjBHdWlpaTNtdy94bnRtNFYxb2lCR25uaExxZEZuVFp0ZWc1ajh6?=
 =?utf-8?B?SzVhTEc1Z0RVRkVJSk8reVdqcnNRYXBzTkdrekt0RWNXWTN5ZWVhK0FYRjBX?=
 =?utf-8?B?RjFpOVhxKzhmVkw2cERxSlVKVnpydENkdmZhTzNMdG9qUk9hZ0VJbHpaTVdI?=
 =?utf-8?B?NEJ4bWJZUTlETlNIVElnVFE1WEI2cTdEby9SOXpNRGFZcTZ6TjVRczZOU29K?=
 =?utf-8?B?ME5RbU4xblFXaWd1eXROUUZPQ2NtVXBUalh4ZHV3dDNZL2Frbkl1Y3cvd2hP?=
 =?utf-8?B?VFdpVFVzNXF4MURHUUhSS0NzYkU5OGM5ZHdHQ0VhYXBxWjFBUWZ2aCtaeVl5?=
 =?utf-8?B?eUlXTGpHeXhrM2JzVm5GTkkrMFVoZ1NZU1h4SWZVbTdVeG9YUklzQmw5enJr?=
 =?utf-8?B?L0RQYTZON2VyeGY4M3lVK0g1bHh5cXJKc1hSVFRBZ2d4cW9zbjhuTVJsdEtW?=
 =?utf-8?B?cTVCSENaNFA4ZDl1cDFsSUxUa293bnlCMDVhOVJ6V0x5OG1YZVg2NE1Gd01Y?=
 =?utf-8?B?RFpjTUZvcDFoRjhzTzNGMk1RODJYTWtTeHViNHhNdzJmb0ZKKy9nY3JTdXlR?=
 =?utf-8?B?b2FkZWlEeHNtU0tkOHJSWnhOS0pIdHFJbmo0V3FCOWxUS0FKSFpqcHJCOG1p?=
 =?utf-8?B?NFpobndzWXdaQ3BKdnFJNGhCNlU3VktEK081aU9UU2hjeC85VGpnT3pmajE4?=
 =?utf-8?B?ZnJQaXllM0ZTWVplZDZ4SEZSWjlmaW9BdkhZcytHaU1hbnRxRzc5TXA5VTlH?=
 =?utf-8?B?Z054aVd4TmtRNEJWZWloQ1BCQlZkQU83QVlCK1ZSQjlDeGM4MUwvdXlUWHdT?=
 =?utf-8?B?MG1HTjNMRHByWnh5aWVPOXJSdDRVNXFsMXFIRHhmTHdJQnAycnozSDkxMmhl?=
 =?utf-8?B?Z05DR1pmQ1hZcmNKR0Y2UVo1dTBQaTJTRlF3R3hvSEZoL0VZaVd4NDFIYXZn?=
 =?utf-8?B?YkFpTk5Zdm5aLzBKUSt4ckQ5SWltTE0vQkovZzdMUVRVUEFLaWpIRmd0U2lw?=
 =?utf-8?B?bmFkUkRoNEZOUWxSQ2JMd1B1dTcrcWlRSU5FajVGVEo2OXUzL2Q4SHQ4SmxI?=
 =?utf-8?B?V1lTWVMyOGllaUl3c3NNVGZ0SDVhb280bE1KVVk1bzh0SnBoaThHRTc1bWsw?=
 =?utf-8?B?VW9lemZrdHpQRWVXeTFjdU53eWI0MlJod3NHYXZHcWJzZlVQNlNJaWp2M1Bx?=
 =?utf-8?B?ejZDUldDbHpoYm1JNm5zTVVhZWFMbitUL05HWDNwaGRqdjRqY2VZNk5IZ1Bu?=
 =?utf-8?B?QTVaaVBwOUIrSG5xemtoQWMzTDFEa0RYL2tkQXVzbzcrNFF5djlpWm1BUDBv?=
 =?utf-8?B?UUJIYlJacHV4cTdVWmxLSnFma3lvVG14a240Mk9wTWcrQ1lzbnY2UGtpYldX?=
 =?utf-8?B?L0JaSm4wOURESW9JVFJoRTR2cGd0amdCakNieDQxUkVsUFpuQ294TlVtQlMz?=
 =?utf-8?B?UWVORVBFZ0NnQ0p1Y2lDamhrZ2c3M3plQkF1WnAxYUVTRFRzczRDUTZyRmZt?=
 =?utf-8?B?bGR0WGdsWVBlek14Y1ZaSWM4TGVNZE1ZYWFZOWZlQVlidThJTGhwSll4V3lm?=
 =?utf-8?B?S2VIZkI4RjBCdEJnZDdiRHpWbkorQm5yUXAwSVJRcWNzN2oxK0ZVSENYZ0Zp?=
 =?utf-8?B?Y1NwSGxrdnN1SkFyR3N4cE1xVlAxVVpuU1c1dElPOUp3TnlXOVI1OCtZbzQ1?=
 =?utf-8?B?bW1kdVJkSFQ1UWpXb3V3QVJieWNXRE9XOTYwT29QM3h3ZnM5OUJFYjNBWGk1?=
 =?utf-8?B?SHpieHArdEJXUW9RakFLcm1YWVFZRW1ZMkxEelBSZkhPTDVqMHpENjBGazd2?=
 =?utf-8?B?QWhhaUdWcjFrelNjM21qN0FTZXpqYVEyZVlwQlRvRnNaUWJHbWp6YUc0MDhr?=
 =?utf-8?B?UUNVcjRtNGE4aFJNZCtVQjJxVEZObnh1d05FMkhVazlvZDQ1QlkyMCtTRmhQ?=
 =?utf-8?B?YXBRR3NVbExHTXUxRTRiUlh6OWlENld4SDdqWTZSbUwxVm1ORTVhdWF5L0Fm?=
 =?utf-8?B?M0JuV1RKZjZSem0xWWVialRwR1UxTFprVW56UGdNR2VPOEVKd3BKMDRodmkw?=
 =?utf-8?B?anFLNG40S1lwMXo5ajBIME5xSTRNQUxEMFltL0RSTUFyMENycUVJTlliUzNq?=
 =?utf-8?B?SjZyQTJPaks2ekt1a2tRMnh1VGtmVDlEaTJ5dWYvaG5DdmhRZnZIZmVpVVZx?=
 =?utf-8?B?OFM5UVI5WHVzOG1FWEsrS2tvUVBGYlZZam9jbE9hTkQwYjhiTXFQNjJuUGc1?=
 =?utf-8?B?TW9DaWtOOTdQMzk3elFIWStFQkdjMnpaNmU1aDIxWTNaQlVnZ3oydDc3eURq?=
 =?utf-8?Q?TZmxYkgWkPQJsp0Dq/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85470e4-fc35-413b-b915-08df38e6def4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:40:34.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVwf+0WlFVaqz9hDHRzU9gp1/KfXvi+FRHq+ChR0shX1n/AHP7ghNggD1rdDt70NQEVFPHe6HZQFsFZh/jq1vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458

On 02-11-2026 18:25, Peter Zijlstra wrote:
> On Mon, Nov 02, 2026 at 03:52:07PM +0530, Sandipan Das wrote:
>> Each uncore context is owned by a single CPU that hosts all events for
>> the corresponding uncore domain and is advertised through the sysfs
>> cpumask attribute. When a CPU goes offline, the context is migrated to
>> an online sibling if the departing CPU is the owner.
>>
>> Before commit d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore
>> management"), uncore_down_prepare() checked whether the CPU going
>> offline owned the context. The check was lost when the function was
>> replaced by amd_uncore_ctx_move(). Hence, when a CPU that is not the
>> owner goes offline, ownership is always handed over to the first online
>> sibling in the uncore domain irrespective of whether another sibling
>> already owns it. This goes unnoticed as long as the owner is the
>> lowest-numbered online CPU in the domain, since the first online
>> sibling is then the owner itself. Once ownership has moved, that no
>> longer holds.
>>
>> For example, consider an L3 domain spanning CPUs 8-15,136-143 and owned
>> by CPU 8.
>>
>>   $ cat /sys/bus/event_source/devices/amd_l3/cpumask
>>   0,8,16,24,32,40,48,56,64,72,80,88,96,104,112,120
>>
>>   $ echo 0 | sudo tee /sys/devices/system/cpu/cpu8/online
>>   $ cat /sys/bus/event_source/devices/amd_l3/cpumask
>>   0,9,16,24,32,40,48,56,64,72,80,88,96,104,112,120
>>
>>   $ echo 1 | sudo tee /sys/devices/system/cpu/cpu8/online
>>   $ cat /sys/bus/event_source/devices/amd_l3/cpumask
>>   0,9,16,24,32,40,48,56,64,72,80,88,96,104,112,120
>>
>>   $ echo 0 | sudo tee /sys/devices/system/cpu/cpu10/online
>>   $ cat /sys/bus/event_source/devices/amd_l3/cpumask
>>   0,8-9,16,24,32,40,48,56,64,72,80,88,96,104,112,120
>>
>> Offlining CPU 8 correctly moves ownership to CPU 9 and onlining it
>> again leaves CPU 9 as the owner. However, offlining CPU 10 then makes
>> CPU 8 the owner while existing events remain on CPU 9. Both CPUs are
>> now advertised for the same domain, so tools that open an event on
>> every CPU in the cpumask count the domain twice, and the context gets
>> modified from two CPUs without any synchronization.
>>
>> Restore the ownership check that was lost during the refactor.
>>
>> Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  arch/x86/events/amd/uncore.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
>> index 7aa5a5b652a2..c307323f6390 100644
>> --- a/arch/x86/events/amd/uncore.c
>> +++ b/arch/x86/events/amd/uncore.c
>> @@ -595,7 +595,7 @@ static void amd_uncore_ctx_move(struct amd_uncore *uncore, unsigned int cpu)
>>  	for (i = 0; i < uncore->num_pmus; i++) {
>>  		pmu = &uncore->pmus[i];
>>  		curr = *per_cpu_ptr(pmu->ctx, cpu);
>> -		if (!curr)
>> +		if (!curr || curr->cpu != cpu)
>>  			continue;
>>  
>>  		/* Migrate to a shared sibling if possible */
> 
> Now, I see the Intel stuff cancels the hrtimer here; but AFAICT the AMD
> bits tie the hrtimer to the ctx, and when the ctx goes empty -- due to
> __perf_pmu_remove() it will get stopped there, right?

Yes, my understanding is that __perf_pmu_remove() will schedule out all
the associated events and when the final one is stop()-ed, the hrtimer
also stops.

