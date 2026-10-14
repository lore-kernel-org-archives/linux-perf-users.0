Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020132.outbound.protection.outlook.com [52.101.196.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE2953D0DB
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999701; cv=fail; b=jZzsXehRnYS1Tf8ivh1xZ12ehNZlsnBtpdlPdzngthreu5Jvox8K00ajv2qTnFISjiuODMMF3GLoS3i719lI9fau4gtEwdmD5QkZoSyN4eRfvXKrgcTkWn5lctzPeeRf4u2eer7erpEcVPgDHECdgN0vD+Lj+bcq2itw/l1iHIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999701; c=relaxed/simple;
	bh=pexHZUnSgLYefuyhDj3HcbzjYAi1oD1ouXSK3zAkVBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGF5KPMRB05KNJFrXYKmO2qpoD/f5lQPF9JyDu9SDZ/PEcuwcjUMAFqGC1DMYwHzyaezock0zy7KT54do+r2t77XWZamtpRhGAnQzu4xmrz+LfJ0uj2VYMEHW0TOaUOVnpcFQziyTMUlyKjzr4tAO9Qcr71AJ4pxLrIG4c1e99E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nt6NFHrZT/phT0Zk33pKffZfoDgQXyca4aqyD9i506Yhw8mANzI6zax3LnluErKOByCoAKDKPPYV5Yiyw25zwZhU1NsANcvQBNKSVz2aKlOsQuvVy9/+ZlnHdjRR4RJZAHZwekru4u5P6xualrmnkOA7FabDxGdj5En3rEUUlIuTXZL1wgTbwHJ5u8W9kgYlbJ+5Silp/5z1y3W7h2OmAgjeLVnOC52jv24EaSU2SpmcltOXMMBxgtzFc3+JJ5vDiidDFFMYtvqo1R5STkk+eC6b3Y0fPCQfKvlSTU/iwgpNeiDAXUDIFdbhEQcklHCImtN12g0Mk0YL94u042ADlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=F7PegGiJY3P/8NvlSdXG+ox9PjZhuB6iUjP/62CowlQ=;
 b=KMdBGqiE8EqCJ9cPVdssqf//2VOb5bonxtGLsnpy5Aa9AIysGT20MRQqhT7TZycDBTIZK6wOyvl5cyo1OHlSAV+Ba55tsG88lRMczag7FkV9N/Xeid+oWzO8ULFnkV3KlhxYsTFzuOpWcga5jBDsoXtkllsPo7mfx02XCxDBd3cD2smBHsWixChc9enf3KpsQR8qS7fjbmrpWCKRBEvq4D32pw7Wk2ZpSybe1A8fBqz31qkKRMHUFeuidiS+xKs8y+fgVSidGq+6iVHtid24bQWcasDCzrNqhTEhFlNh6mr7ay+OQLashE9H6IBk/mq4bH+CNVVlV1m31QseRvsZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3584.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 17:41:30 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 17:41:30 +0000
Date: Wed, 14 Oct 2026 13:41:26 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v4 1/5] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Message-ID: <mb534m5g6piwke3wosr6vmky7ctbebjlildlsnr66lkn3jeg5l@lrlg2qqbgqfd>
References: <20261014161457.373253-1-atomlin@atomlin.com>
 <20261014161457.373253-2-atomlin@atomlin.com>
 <sashiko-outbox-171530@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-171530@kernel.org>
X-ClientProxiedBy: YT4PR01CA0380.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3584:EE_
X-MS-Office365-Filtering-Correlation-Id: 606e3bed-2c08-4b41-0d96-08df2a1a617e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K1yPgdviGTWYvwHVLpTTXYOgkWOsi7r+FrTHtvbCyVJ/ZckVJxPrbrUEU5bMy4RV+U2ZOxewlXo5I4QAdx8nksrm9adOtFmDsVHpsHqSjFPlufXhOEKClFmzauNee6+FmRDT4nkvuyCc833AoheOY32INR++uJGmyslv97sCuu/+LER2q2wpFl9iP/q4RSwRS4+tk1DXKC+RIiG7bngyzoDbqTUOGn0XzBC/u9sr5oExOOnqTY23y3rVFkJrJQPhKmSldiPgv0Pb3jYKxgKiMlqCbLKONSXHDdEAd67/k9mSlSHYN24aqQP27JWeK336LHY9ymo5s5C6OoVEipGUr6BFIjlhWdL+QFm8mQekQEjn8JxvQX4an5CG1T+XGA0VsfJj5gxTtd2B4ABoEozNjL20EWAXojzoR96mAc/RUT15aqMo83n5Gu/en9/+DxbMfPH+LWdMZeyo89x2jwmVmxWMqXQth150lEZD0CqFCQHryTBVHmGBLP6GKxyW4vpNBZzn7YWFP+hJfKABEmOK8GU99595Ox126siaaJpt0kCg+oJtRy9fl/7Y0V+cKsP0Tp2BBqCSp8xRnD3bHYxNxjRoojfAvTrQ5rGU9jKDxUseo1tr05I37BPmRa1+qIKPFY9Saxd8zJl40sNFMZTGGGt242GbZpXI4Mb6B+6P2c0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTh6WXNIdUxlYlF0N1BkMmRrR2xSMEJDdURqclVoaXhFcmJ6VGJsTDkvcjlo?=
 =?utf-8?B?Q3prbDEvUjB2U0dZcjU1U3JJei9JRnhVM1NFVzd5ekZRdDVwNFh0TW13QmRx?=
 =?utf-8?B?cmR1eVluL09kU1MyNzhlaWpIZWU3MFJNU3FsRWV3Y2V2akRGbkZQVURmYWR5?=
 =?utf-8?B?R0dyMi9OK2JJRnhTRThPczloZjFtVmUrTWtYc1NaV1dGbVg1SzAxOEN5Vm45?=
 =?utf-8?B?TFpPak85VUxmQ05QcVUwTXRuV2tPemV2WEdwVS9xUzd1SXpSSk82dC9LV3Ju?=
 =?utf-8?B?SE13NEVLR1JZUlptN3NSTUZSZzdJTGZvVWE2Zkp5NDBJWjR0Q0szMS94YWhq?=
 =?utf-8?B?U2NIMVo3MzdEOXkvSVVXU0JUblNXdXhPcUI0T1B6MDZrQXNCdFFhbWFUS0hE?=
 =?utf-8?B?KzF5VDZ5andIZENVc1dNKzZHczR1YWNEQTVxOTI3ZHBjdjFhZkFuRVlqdTZs?=
 =?utf-8?B?dTQ2V250RlVEa0Y5N1RVRFB0WmM3aXBjMXFqWGhaQ3E4RUlaSTYyMDZwN3Fq?=
 =?utf-8?B?SU9kU1VhTWQ1THBYc09YemNtcy9RdC91S1B4bEliMlI1MFI3NlBjRjRqNXk0?=
 =?utf-8?B?ZWZic2U4Y1BPVHVSYitKZUNwVEswdXBGRERSN2g3SHFCMUZqWE9UMmN1STMr?=
 =?utf-8?B?NmZ3K2hlKzh0TWQzUXZDeWZWQkpBSWxDam1YdmFSUWc1d3Qvc25KcFFqaVdR?=
 =?utf-8?B?V2F6UEUyTzVNNlcxNDY1OG1jQXBWNVRqa2U3YXFMZW9CL2xXb0FmR0hHbzJn?=
 =?utf-8?B?d0dsWVR4S3M3Rkg2ZGFVYUZjUkpUZzgvVStxTU5WTnFEbFFlUHFid0R2Qmh2?=
 =?utf-8?B?cUlCSGlUeWg4ZHFYSFV2U2dBTUVCQzNuSDlZT1JIY2hmQkN4VTJ2SkdGRE43?=
 =?utf-8?B?clkyYUtDTy92aSsyRE9VMkhFRjUwdGJKbzlLdmI5cldlN1FSZGJDaVZKRTBG?=
 =?utf-8?B?N3puTndlYUhjNjVkdUhXczZEMURmQU5oK0x3cGtBYVdULzhMZlpLUitHUVVX?=
 =?utf-8?B?NFpjZEE5dUNPK0E2VUpRTHp4YWFPanQ3dE5qa1RNWHZuQ0FQU2xZbG1veXFK?=
 =?utf-8?B?dGVLU1QvNnN0SERBMVRhRXlDRzYzSzU0T2ljSGlMSDhpd1hnU0JlQnByUFZ2?=
 =?utf-8?B?WkYyeHd2UC92TmxaYXlWN1VjTjlXKzZtcGNDaHRCUVBmbE1OaUQyc1o2M1Bu?=
 =?utf-8?B?Uk9RNFNhLy9PODVyeDE1eTNvMytmNEQyR2VRYkJRVEZrd3VwVTYvd294VHBw?=
 =?utf-8?B?MElZQTQ4UEMwOEM0UE1mclJaWCtNNUxOc0MwcUh3L1BCZlE3Q2cyUVRFRVdB?=
 =?utf-8?B?bkZOcFowSmNOU3RBOGUrWUxqOU9qSC9NM3VHVDUwaVQ1cjF3SWx2RWNPbmp2?=
 =?utf-8?B?M2RoeklZMGh5NWMyclg0TlRSSjJENmpqZEpBWVFiem9GakRtK2kxZG8vWUpN?=
 =?utf-8?B?SkZQNkVvTXZTaTFpc2NKNVF0Zzd3bGJsNWNUZEhUUUkwSzV4WHJDUDFXTWNl?=
 =?utf-8?B?TGczRVdhakxFbzZTRENEQTdUZEdjL0RxR1k4aUFXcWhNZG1qR1RXc2lQTzYz?=
 =?utf-8?B?TmFEeG95elgxbVZvR2kvaHM2K1BreGVqcjJGbEZDRmlXOGtydFJtQjVNZHNw?=
 =?utf-8?B?Y2ZOZi92bHFIVjBaNitFNXkxTUpyRDZZZ1VEeHFjeFd4cVdXbGdUYWNFYkhE?=
 =?utf-8?B?cVoxby9GR0FTRTFwNW5KdDlFV3hhdUVZQXJ4TFFzelpaYk9kRjRKaHpteHZZ?=
 =?utf-8?B?dXVyQWdIVFZBbE5DTDFubjlmdnpiN09WZnJrdXJHZFpnOERZQzhqZDRiUERn?=
 =?utf-8?B?ZzBkTllhdFhQalFKbGU0YVpKOHJVUFN4dUd1UXFqNkJ5QXMvdDRrajJpdXlU?=
 =?utf-8?B?VGJKSnpnYVRTeWtaeEcyS2NKRExvdm5wK0lnRXZDSFcwY3F6R3h2eGM0ajJH?=
 =?utf-8?B?NzlyWnpscm1lclhScG5GQ0o4T0s3VEZ2STNNQzlJbkFFWk9TcGk4MHkvSS9k?=
 =?utf-8?B?VmcvQmZhMkpmR25sMjJjVG5RYUNtNnRCNGQvdFFlSHF0Tmc1YmMzWGd0MEVw?=
 =?utf-8?B?a3hLeCtnNUduUHR5NExMc2UyUWdzZHFGL3BwcHNEVVFXQzhLZlJMQWtIbWJz?=
 =?utf-8?B?eEFYclVRSVBaODJNZkJialQ5VHk5UW93ak9pSW92aXY4TGVZTXVFZmdWMW5y?=
 =?utf-8?B?RkpMZjE0dDZoQkg1bmZzVHFDQ1VIaWtUZzFSRndKRXhGNnp6Tko2c3hkMHRI?=
 =?utf-8?B?S2VIN05IbzBLbUFSL0dNR3VnMmZGOXp3TkVCRC9RVEJXR2dBZkxjU1Q2ejUv?=
 =?utf-8?B?cXFNSFFVb2RsYnZuN3VPWVVXS2dKOWtMREQxOE1ING45TUF4RWdRdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606e3bed-2c08-4b41-0d96-08df2a1a617e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:41:30.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFzdhh/jxhNwbi0V9CfIRwCEsA9c/wIEmpWEKhfmXesURbswZG4unpZ0mjFFBmXqxUavA5O0CoiL7NfMVe7bXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3584

On Wed, Oct 14, 2026 at 04:26:52PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Since trace_pipe is opened in O_NONBLOCK mode, can this lead to premature
> termination of the perf ftrace tracing session?
> 
> If a spurious wakeup occurs for poll(), or if a non-fatal signal
> interrupts the syscall, read() returns -1 with errno == EAGAIN or EINTR.
> Unconditionally breaking out of the loop here stops tracing instead of
> retrying the read.

Yes. Because trace_fd is in O_NONBLOCK mode, spurious wakeups from poll()
can result in read() returning -1 with EAGAIN or EWOULDBLOCK, and non-fatal
signals cause read() or poll() to return -1 with EINTR. Unconditionally
breaking on (n <= 0) aborted tracing prematurely. I will address this in
the next iteration.

-- 
Aaron Tomlin
