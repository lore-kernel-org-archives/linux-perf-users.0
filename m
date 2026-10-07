Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021132.outbound.protection.outlook.com [52.101.95.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68E43E9FB
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387996; cv=fail; b=YquXOedkxlLh4mfKhVPa6rMWLyerOmF5koNbIT9dvajD/MtdsN7GEmR4Sub8cwjAM3wP6BbMb2fTv/deZTfIbfJWK89a6Q25JXZuPCH/Y9MFTyRUbuK7qARfyFKbay/5uUYPizcLkJoJI6vcZleAgZSV72IDS3KD4R30HMngKFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387996; c=relaxed/simple;
	bh=N7yjPZV8Iy56YsZMjc36TCev8X520BHhY7H7ZevXK9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T8sgPQJRQ/BLW9W8WjpDqOS00wQxNygYz+6YbDpnONADS1ivvwMt2UuthYhRfMgwa2I9R02JLx+5RoVsv2jUjHGfSk3Mw+knupnfgSaozE53WY/MaS8ohQV+XJ4enYZRQiXAY4sQ2WkGBYt6+X/Q5zU/XO4+hBX/lmXo3IBRPxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4cbwKBD1dkRSWsJfqpOMB9aQZMQwlq2MGXtbqv0TTZQWx1osAbYeRX5ChLWJLIZwgorIPt1gRNjulaTjeNTvFxsIXE/79F2VUEO04WDiyJkIe6h2xGVDLtYNoeh4802B91jRy1f1bd+xg4WsKgVBOpVwrQc3FYnY/FnDAmpUzmGL8h6NUps4bgtuMP5u9PAYpl7O9Ey8JN7ITxP2h/2/4pFmiYutoZl2H5JqcbcJWOfoCU67KdVVeaRxm/TL6JB91jXhYFdDqINEAgXC9rH6BPo1IQVlMj4UlXHRa5oZfNowsqIkzsh9sNo7gno6DCGwxGMLfnrG6KBoS18qiKWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ziBBFTqgEZvSCtvG3XTDPA1N2gU7GfvK85ReeV7l32s=;
 b=YC8dNy+ahGO5nDVnZgQ4LuAAglIxq3zl8m7HahvrBfYU64vcYb2nFQSk+su6rF4ioQ9HBZkCZGdT1QQrdGD2Z9fc0OV+m8dwUMeER+RFaBwAaSQ85MSnhpo6/Qi/2MXETlwc7SLGUpQDuMpPfiHqEwvy3ALdIc73C2McuPZGoZ6DCaYVITjiKXEsMSefwD6ya519sbnw0kJ2GR9Kveh13LsJErrdXaGVw9b7osnwtW40Ce/h0h5e0k11qmUtSI3jgpHgmrVqjmJtOSq610wIvKt/VOGo/OBHxdkNIRad/WmAxd/ktZnI1S+9+G3x9EtZN0RBUtZYkon3n3y5qf6few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB4283.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:16c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 15:46:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 15:46:29 +0000
Date: Wed, 7 Oct 2026 11:46:27 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v2 1/4] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Message-ID: <4aeowvntpaa5mwidjrcghxo7sqxfpvgitxsipvybbee5rwk3nd@3vknropgc5ep>
References: <20261006232756.65620-1-atomlin@atomlin.com>
 <20261006232756.65620-2-atomlin@atomlin.com>
 <sashiko-outbox-162513@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-162513@kernel.org>
X-ClientProxiedBy: VIVP296CA0103.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 7625bab5-257a-4d58-28c9-08df248a2728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fGRap7OfnBnewcc0UNFyOyDXJljC5MsIWA8EkQpQUHPb9/TkqUvZn1Cr+GBZY+9aC6ZlIcaoNpJolzJMygj6kZVjZ+oaVzN26PvpZl3bFAwIRxGsaiFazdKi3G+857mj1xK/E5eIrQHvp49on/4TquEYL9TXASun1JwMbGo7TxClwBiPF5/4Sw4Z7UrC+x0Ygmiw2d2TxXe6cSQXt1SRoda49ijAJRtSwZ/bady0X9MTTST1R+vZODomDrkJUcFHISGAp7kumWZW12hKvtlIP0rnBEmdB+52eH43PswLtPGpUOYIpJkgEd5oDLwIHabSgedmtKVTLAxekMwx4gKyE/9I1mEtGPqVl7HqqrAiZljJTNlRf97MyvWB5NXTF2+jKR44ZcomFMG7GzzF0BzEinsC+RwnvpgASDiSV8Ei2HUTSsV805lNmuwUi12iDXbouK7CEBm1rdGQcFv6y1izRiPtIeKqY98lTZ9ueqDTv0nsKjcGkAPUWT1+9PvBqeHTWKO8XmwGUT8JgD0QpdFsre9Gf4VVkOvfXJD2Vpu4PVQ2/1AjoPGqHUbAIzHJPgsP3lxH9AMbnTcpKvvrDRhzxAWD3kVZ2COfmjstffB5DsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVh6eEVVTkY3WlU4Y1NxREN6Vk1NRGtVOXZZbmtMQjRydDNvbmZ5RWpieEtT?=
 =?utf-8?B?Mit4SXJlY1JVYTlZdzJVa2hmTk94Z3Z1VDZLV2c2WGlaL0F3NXpjTnVRMU84?=
 =?utf-8?B?MWpIQkZab1gwNzdGUVVzU1JQTjNPVnV5cHlMQUNKU01jWUVPZ0hPZGJna0k2?=
 =?utf-8?B?Qk5JZGZoMnp3MmNOa0dDdnM0K0c0aGdpaUwwcWRoYlFZSnBOMzhBQTlDMzFy?=
 =?utf-8?B?bEZxREJ4NmZPc2Y0eDFUNzNBOGhhMUFVdmc2Z2x4bmJXWk1mZnhOV2QwM2RJ?=
 =?utf-8?B?ZUhySG4xRmg1RmxDdFpEVnNUenBxbTFOWThWcXZpeVZrcmtxWEo1TkdDSmVR?=
 =?utf-8?B?a203NGsxM1JlZ3FrSHovdCtqNEUvbVJEUmUzWk9MeVV6bCtPbnpCL2xnRTcv?=
 =?utf-8?B?YkZWVGRzMVVSS0M0bERlVGg4dTVGTnoxam16QmNWZnlIY2VPZHJRajR2WU1U?=
 =?utf-8?B?MjJFS3BFdWNWVjE3UXZwUlFxa1g4TllUZWw1R1Mvdm5EcWxwNnJGVG5NeEVu?=
 =?utf-8?B?N0xZT2tKa1FRREQ4a3I3cE04SndYN2FJUXBXVktnOGFGRW0xaUtsbnlSREs4?=
 =?utf-8?B?bThwYjlFWk1OdW1hN3Y4eXUwc2dHSjdlRHQvNCtTQXNKRWtpOTh3b1RQcDFk?=
 =?utf-8?B?bVduL2hMM2NsKzZNZkMvNGlVU2piOTNhcDJpUnQvbzZ5T3Y1ekdVV0lIWDNE?=
 =?utf-8?B?VGZhbXFkKzk5dFQrME5HVGZWWS80QVNQZ3M1VTgrTFFBNDQzRTNzNi9rUlJX?=
 =?utf-8?B?QklBZ0NBR3A0Nk1mU2FuZTMyVEwzbmR6aFZ6NzVaNTJ0RE5ZcU1acUFzQXdV?=
 =?utf-8?B?c1IxLzlWVkoyeVRVVkV2bGxGWks3VkVtL2tKQnU5UDNPMW8yZEsrZGMxcURl?=
 =?utf-8?B?VXlvclJDUWRwMFY5N2pXR1VzbjJyWXZaNitXb0xsN25ncVpsUm92cVZiTmk0?=
 =?utf-8?B?eExwSER1cERUT2RBVmdETlJZN0pMamRXNXJHaUk2YmtiRUQ5MkpSS2F0Q2pk?=
 =?utf-8?B?ZHlLdU9BOWlKdWFJdUtuZ204WllWSUk2eG1yTVVKc2R3bTFpdFplQjduc3Rq?=
 =?utf-8?B?NjlsVDZNM2VkZnhIdkRvRzRWQ3dSak5wbU1SbHVXeG5PWWJSd1YvdWJTWGNL?=
 =?utf-8?B?NjM3MWlJUGhieUhOM1hJUGJibnhHdUV6T3lYRDRwdCtUNVVMZmVHbEt5dGky?=
 =?utf-8?B?aEV3K0hZcmlOcW9wTjNxbFlzenJ5ZkJnUXpMSmZmSTZ6dytZZkpwNEV1bFJU?=
 =?utf-8?B?ZTRxMTRKNWM5WTA1bUVaS1h6dWczVUZmOS8ya3dERjhIWWc0RVc4dEVyL3JS?=
 =?utf-8?B?TjdDNTFzdFRoTWhVdmxLMWhOSXFGUGRkTUd5K1ZPYnc0TC92UERiZndlV0dO?=
 =?utf-8?B?R1E2dTdqYThNRytzWG5DbXA4Y0VYOHRpa2RPWDJoaVBGUVJaLzdhVUtLNyt5?=
 =?utf-8?B?ZEE0TitJcGt0YlBjMk14SVZFRzROejQzdlBJS29NVkdTODFoMlk3anJLT0xi?=
 =?utf-8?B?RW9tZVkwbEpJVkdkbk1vVE9hZlNDSHFobS9MdFhTM3BLUEhaeStnYVoyZVdQ?=
 =?utf-8?B?bitiT1hRV0U5RjI5NUVsRWRXTXo5MWlDL29pTVQ2dUo4ZFdMaUF0VTk3ekhM?=
 =?utf-8?B?cDZxTndxWGxVODR2VHJkTyt2ajJZVDVmdmEzcXhxMC9Pa0dzVGhUNjVqcjVh?=
 =?utf-8?B?Vi9yMEJyMVJha093SjlJbm1CK1l2eEUxSk5TYjBPcVZTSy9ZVzJzS1FSZklp?=
 =?utf-8?B?dGJSMU9Va3YwYU8yak51Nlhldk0rYzlSaDI3QjhsTkc3cmxCNlF3OWh0aDFE?=
 =?utf-8?B?Nko1QnFhWG9oK1d3a2FyWHZidysyZmNsUjBGYUJyYUVTZnJ5TXJhcmtsTlZx?=
 =?utf-8?B?THRQVGFLaGhoQllBTUdYRWFzTnUwRWdRU2pRMWNsSDdFV0xuMDFPWlFhZzhv?=
 =?utf-8?B?aWtRRlRoMEJkNWtDbjJqVFpDdENYejB6L2d3RWN4TTg3SEJ0bmNGNVFzL29o?=
 =?utf-8?B?SlVrWmRPTlA4SHZKQ3I3TTNuZWhEOFo3SEZDZUZBT05mQTVQYTZxWUM2L2JE?=
 =?utf-8?B?V0syZkk0YzRPY2dzZnc3WURvTW9iM3g3OU83T2JQMFRscmZ4d1FEYnM2WFpu?=
 =?utf-8?B?OUd1dFNDTzR4V3IvYWRNZFBXbU9jNzlCTEpQaGZxek9vdTdNZkVIeDBwTWQ3?=
 =?utf-8?B?ZDUwcXcvMENHKzQ0ZzNzNU1sSENpYzFCM0l4bFdPaytjaFl5MVVmcGtkZUdZ?=
 =?utf-8?B?cW1MU0tLTmtRRUt0QTFNcjRud2lwVU51WTVGTlp2TE1rNy91NnpyRHpDT2Rw?=
 =?utf-8?B?cUpjTDA2RlA0MmI4WFNrRlJXcDlGOGdJQlg4WDdtRnZMRFQ1eEJsQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7625bab5-257a-4d58-28c9-08df248a2728
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 15:46:29.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np5f7rNB5aFnoskrtbM9BXDKt8Hf+tSho2FYu2jLPeKHV4kNGEfulCaDKy0dtlSr8QwGD9ptY/iTwEpVQlGepA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4283

On Tue, Oct 06, 2026 at 11:35:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: Memory leak of buf and linebuf on early ftrace setup error paths
> --
> 
> commit e5886f5c4e0cc584a5a7ac05c7c069ab1b80f135
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
> 
> This commit refactors __cmd_ftrace() to use a dynamically allocated buffer
> and a string buffer for streaming trace data instead of a fixed stack array.
> 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 6017493ff1797..4e77a0b2513f8 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> 
> [ ... ]
> 
> > @@ -767,6 +771,13 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
> >  
> >  	setup_pager();
> >  
> > +	buf = malloc(TRACE_BUF_SIZE);
> > +	if (!buf) {
> > +		pr_err("failed to allocate trace buffer\n");
> > +		goto out_reset;
> > +	}
> > +	strbuf_init(&linebuf, 512);
> > +
> >  	trace_file = get_tracing_instance_file("trace_pipe");
> >  	if (!trace_file) {
> >  		pr_err("failed to open trace_pipe\n");
> 
> [Severity: Medium]
> If get_tracing_instance_file("trace_pipe") returns NULL, or if the subsequent
> open(trace_file, O_RDONLY) fails within __cmd_ftrace() in
> tools/perf/builtin-ftrace.c, the error path executes goto out_reset.
> 
> Because the out_reset label completely skips the resource teardown label
> out_close_fd:
> 
> out_close_fd:
> 	free(buf);
> 	strbuf_release(&linebuf);
> 	close(trace_fd);
> out_reset:
> 	exit_tracing_instance();
> 
> Does this permanently leak the heap-allocated buf (TRACE_BUF_SIZE bytes) and
> the internal buffer of linebuf on these early ftrace setup error paths?

Yes. I will address this in the next iteration. Since buf and linebuf are
allocated before attempting to resolve and open trace_pipe, taking 'goto
out_reset' bypassed the resource teardown and leaked both heap allocations.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006232756.65620-1-atomlin@atomlin.com?part=1

Kind regards,
-- 
Aaron Tomlin
