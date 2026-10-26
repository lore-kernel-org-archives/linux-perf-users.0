Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792982717;
	b=5KTmDA1zBZjTeCZR/YTQDTUrZFuM3rmQ3OKApm6vBmK4HbRaq0tC9R2Idg2hkXewCUCj
	 42Yp/X1X2ewcImtXiyr1w3jScqcpemr2wyJTQnoXXfqviDv6D40j9Mc5NM93BiWYbiPhy
	 Gj52r9yZCuICKo5meTfMcVRnnTdNgsfFN1+1TxZqbdcAQq4cGMVCKcOk1nXTGUMV8OQXF
	 jfB0Pe8wN8HKrwWm7pV53c/rrTiceJ1WBW9WizYLVbX32g4z1nJtNaHGaLOTYTcYRzhFk
	 dE0rDRkYQ8+bbfWGcTN/OhDlxAdpgsxfqsKIz2p7fZnzV4fD+gIkVbm4FeBgpRfngLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792982717;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=h0nEinRlpbybUdQrVguh2XopPpg9hbAWT4zSalqImkc=;
	b=5NqgMylENVFcMMXdGdo9O0EZPXh4mFABhBy1t+Ss7hoiVQOQOOkKyWMnaq6C+zHiefvO
	 2UKmsNlJMH6gKBvGfQA3+G/mvEO4Rw2rJWq/0VBxc8mdCjA13eOW14lP19AjnRzMwWVfV
	 yB2eOl3RaPBf68FLwY4kBAgP8KmgfgXBpBFlxdzEZPIB1QJGTCphj85CXXIWyhyYAX940
	 it4gf48yzPNG2zLDBqrnisLcHfRGC5giYNJvP0Z8EzUyx6X/77LT/1R97AS2Mwn0xTWwW
	 U9g80tWVuiw1vXFsZsmugDGIunhmi19MmaEA1eGuJPpkon3Vfrpu+0APTt2lhC83xkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.73
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020073.outbound.protection.outlook.com [52.101.196.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B4606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 02:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 998B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiaXp4aNFeuGlW0WZ9qi+mzP0JTpS+Q07WIIhL1JCX0I00WgvUkrU71Q/wpA/nnLIPijkqvPi9BZCZdVgbsh8BdnHQ6NQlFuquMmE5IR0cN0e6hdlv3NxK1dsYBEJJAIVFcvy6WHFi+v+z1sYtcuWYUSCPHcN/BHXyBAkQi8i3FCB/cRu2JDIpkHh24oPLq5b6VL/qJywBV5a/am0P/Jk8zkesSA2i73n2BsuGcDeS0MIW3V9r+IPM0c+CJo2EUMBYGgjnNDy5rFaQrhkCvz8xap+zuN6HfgWQdcK6Ta4+B1l59NENuTRlJk5UGnSwbvuEdEvr9v6MtJjQCxw2RLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=h0nEinRlpbybUdQrVguh2XopPpg9hbAWT4zSalqImkc=;
 b=SA8R6smkupernRSUXnjoymw9QLx2WmrsZdrYDcU2Fma3jDXN/733kA6CKyF6HZgyTOw9VxSAjW8/0n4Hu5xRQQAHbacmSaJb6ic+edyBih7UpjaNiCRShW++jrdLiCiODz84hBTjYrX8nyfYo4aVKne9bZLXEqEwDnnyzV6oOFjgEZcMOsQ12jPXqMbLFkDFLZWdb35OzFdcRucTq58vz4hx1+UVVlm23ZJYEuD/Rqn7J0ZuwlyHGjp51tSG3FYvacnwDcZLSg6VACH7Y0ef99Q+2jDLsJd5znEmWYQUfXqN0rKylaOoE3sI9dCtRrBnU4ibHH6N74LebMif40l0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB5942.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:45:14 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:45:14 +0000
Date: Sun, 25 Oct 2026 22:45:09 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v11 10/10] perf ftrace: Filter extraneous
 functions in function graph tracer
Message-ID: <xsywpsoninmyql6w7f6uf5quktgvob35og25zsiiv6rn4pgsfa@yryvosduzgnq>
References: <20261025181125.514372-1-atomlin@atomlin.com>
 <20261025181125.514372-11-atomlin@atomlin.com>
 <sashiko-outbox-184340@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-184340@kernel.org>
X-ClientProxiedBy: SA9PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:806:27::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: b436f658-78aa-45bc-eeda-08df330b2954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007|27256017;
X-Microsoft-Antispam-Message-Info:
	9ZGdhrq0fM4SIfeBXRZ/g7RYWvud+bDWpOiE05EpH8VT4Bt4EUtrdVYi/NFo7aGjiWA+Urrzqxm80TZDNoIgXksaSGhTisUB2YiXY3u3K7CJx1EpiA7QvGjF4d8cikxSQp8Yz6cHaMzWJI08HsQ06GgdTry+oP4VADaCOokv335hyAGLBzHHXrmn5SWwisvCuyhmlejmMlTstYGsJqC7+fhTvFmn4cNIdEMrBsvZriuS2JbvQ1q6XRto6jG55FDo9nPyo64PgEmg7xv1kpPch39l06fCfpR9EVYLWpvm1EcRRBU6NNHEq8PRsUuxm7EGC9qGIV/JQg7x1SdA7986s4xPkj4sQWdSI3M1jD3sbOD5ceiSCr7DdYurNLDwTFzQ8wmbUDPlWwPjOXWlUmQ/5ASxMjQzLC7+eqoHLMpcMNG9GxtmeqLar/R9iwpsgpYciVlDoyfwfwOybJxZeUusBbK7SJHIzJQAmscjpx3SrOhz5pq0Y/aKdxfr6FNW+7zCh+pzvyGwvG2neGkHQiM5OEGyX8N1Wgyxtgy4zKkhETF9Tah9D3Lx4qugVl5X1QeCHwG8D7J+m9rHPaOlv+htZmg3ryT0OK1RyvGej/iE0cjz9OW17abRFdxfco+zVwnuPBKHEj/JfgT3BcVsjU0LK/qB+zKATLJ1Ljcokl558T0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ZESjVYRlRaTzlzYkQ0YTRmTmM1aVpKOVcxa3BxeUE4V2RFb2EyNDd1Tita?=
 =?utf-8?B?U0F4TnBBdjd3RVBZMFNDSmpmLy9TYVdHRjgrQzl2RE5HRzAwNURVWC8rS1BF?=
 =?utf-8?B?MThVcVExL0dqS2UxdVpGL3BhbWZZYXFOaFppbTAzSUh6dkl3RFd6Q3lydm9u?=
 =?utf-8?B?azJxU2dncHYxQUdDZ2I4dFV5YXVDNlNQMmlrcUZ0WHRRVVBleVRXbXh1c1JV?=
 =?utf-8?B?RnJDYUxqQ1lVQmh5cGloZndRdldrYS9EWDFmRTBCckpuLzJmNGxKYk9JWUJZ?=
 =?utf-8?B?Z0EyYzdQZWZMSU9VSmJyU0hVR2hvZHNvbHVPdWpmcWZiUjhoemljbTFMenpY?=
 =?utf-8?B?MUhqUndySnVHLzZYaGx2cEFiNW45eCtjVk9sNnVIQ2I1T2FORXUxSEZBOFBq?=
 =?utf-8?B?TXVnQ2lhM3NUemRoaDlJeE5Mc1pUNlBKMlpiWExJdGdkbXlXeExSS3JMQWVT?=
 =?utf-8?B?S2JMcm9XNEorYWRrczUrYnJnM0J4WmNNdUhvd0NIRUIrSXZEYm81Mi9lQ00x?=
 =?utf-8?B?bUhoREsxNlpNVmRORzhmWUkyVTRqVmZVTW5UaGRUNFdMYWo2WEpQRHVVdVZi?=
 =?utf-8?B?dG1sd215NE04QjJFMzJ5ZE5CeHRBcmJKcVJkdjQ0RXRlZGVHZTA2bHRVMHkr?=
 =?utf-8?B?RUREckt0YXdqb1lXUFF1bG5zSGNsVi94bHNpTTBSbnNrNFgwQklZSHRqaVFq?=
 =?utf-8?B?anl2RXl2NEpVZFp5L0pvaXFrM3dOUXdicWxaWnUzS0ZMY3EyMlBTb0cwUjh0?=
 =?utf-8?B?UTlRQXZZTDI1NTAwUEtqNXBUYURiRWh5dXgzOUUzMUFkQmNraXhvNmFFQURi?=
 =?utf-8?B?cnhZRXIxa1RMcFBLQWNwanE4ak44WlU4N1VhNTVlbTFjT0MxZUlsL2k5aEhk?=
 =?utf-8?B?SzJwQUhycDFLU0NySVAzU1RHRDI4ZGlJeG8vL0NvS1J2OTN6a3BOcEFTYWhl?=
 =?utf-8?B?ZjlDNXBEK014dFJVcTdCZUVZMUdSR1dHZXorRVNzUzBZbmlzcGxObG1KemRE?=
 =?utf-8?B?VUFUQ2hDTGhScjJxUFFyQS8zTEZmTGRkMlJKaGdwL2RvbktMOVRKL3dVeUxz?=
 =?utf-8?B?cWRhTGprNjVtSXkxWmwwSU1POUVVQk12UDRaQUZ6RHRmL05nWWhUenZ0UDkz?=
 =?utf-8?B?VGF2RFhYQ1JmMXJGRUN5Y2REK1NNaDF0bmxBdjBnR2pzRnFrdThCY1IxK2Qv?=
 =?utf-8?B?TTNVemd5anMzdXg0Ykg4SDljcWVYN281bWJ6MkdOVGZNSEcrUWdGd0NOQ20x?=
 =?utf-8?B?akZ1cDFLK01BaVoyVElESmtVczc0bms1SlA3WTdUOWhmbHVqaTVTak1RWlFC?=
 =?utf-8?B?cHVhL2NPdXJVdzhlbkVKQ2ZOaUJSaThOS2paQTUxRjlaWWI2QjBNQ0RtVldY?=
 =?utf-8?B?NjNVOTBCUUxSTDgwYThEdVMrd2FkRk94aytoM1ppVVhKS1hSSzRqeDArUi9l?=
 =?utf-8?B?QjZrdVIwYTJCS1JoWEpybXVZSHh6T3oza1pMN2lMSi9rREV0L3JnUnRqYWVy?=
 =?utf-8?B?RVlMT1BaMVg1ajF5bUpQSXFNNDNsWE1WMUZjQ0hYTU5rSW1kTWNaUWhtV0ZH?=
 =?utf-8?B?UmFGYmE3Qi9Idy9sYzJYcUxMQTgvZ3RueDJuRGlqRUt1elZHZXpJa0Y0b0RX?=
 =?utf-8?B?RjdueDhPUUpEcUxaazllQWFrNEdQQzRsaWJJQ2Q2V2tQWklNWmo1RWg5U3dp?=
 =?utf-8?B?ZDVsNlI2emd2TzlJV2M5SlFPem5tTVljc2sxd2VTS0h2TTh2OWNKd2w4NE5I?=
 =?utf-8?B?TWlmTVJCREgvR253MjM4c0x6V0hlalFoTW5FakJzd0NNeWxMNnU1SXhQZWtl?=
 =?utf-8?B?OUorcFVrY25WRTBZdzJmZVp3S3lyU1dsZGV3ODJMY2JjNTRVbjBjVExHNVFE?=
 =?utf-8?B?WlAxTmNBUkJkazFCcmRyQ2VMSUVtblJrRkM4MklrNkRhRmFLeHdEVTNXanB4?=
 =?utf-8?B?VEF2eG5BdHZGcklmVUM5UWs5R2FiTDRIZW42RFFvY1JaTEZac0tHbHZlQzdv?=
 =?utf-8?B?anFUYXNGdzF5VUdoa2NuN3ZzRVE0aU91bzZ1MHRUUmI3YjFzN3grMFBUSGN2?=
 =?utf-8?B?VWFWdVNvaXpYMjVNbmVUd25yMGd1b3VrbXR4UXpBVC9pVGNMeHRoVkN1ai9N?=
 =?utf-8?B?RzY5QXJMd0VEMjdhOGFzWnIyOGZCV2JoYUpxUjBPMGdzV05GN3hQbUhCcUZ4?=
 =?utf-8?B?bnBta21Ra2pRWTQ0dWx1cURzSStRN2tlbGh3SlZwY1J1MnVMQmlsT0lYNWNU?=
 =?utf-8?B?TGlDUERDUGZhaXZkQUhLRDFJM2lhYmpBZS8yOXVTckovNmRNRGh1Y01CVmVw?=
 =?utf-8?B?R0lCNlE5T2tHSDhabXVFV3hpUGpvM3VPbUYvRWx2UWpHSXdaWG00QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b436f658-78aa-45bc-eeda-08df330b2954
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:45:14.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNPdLcOrpohTABEErOWdMyYNiP+aJaEEqPjXgv5yWtG3PuekjGIPCLj3QbNaAI0BUYEHcXHs38DqyYhiWD9Zlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5942

On Sun, Oct 25, 2026 at 06:29:50PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf ftrace: unshifted target_root_depth in ftrace_task_state__rekey()
> - [Low] perf tests ftrace: missing ensure_synthetic_inline() in test_graph_target_filter()
> --
> 
> commit 79ad3a54d36210f71bcd95c62c94ed00575efdc0
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf ftrace: Filter extraneous functions in function graph tracer
> 
> This commit adds userspace callgraph target state tracking and return-address
> caller validation to perf ftrace so that extraneous top-level functions and
> detached orphan calls are suppressed when filtering with -G / --graph-funcs.
> It also replaces the fixed-size call stack with a dynamically reallocated
> array and adds unit tests in tools/perf/tests/ftrace.c.
> 
> > diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> > index 0aef2cd9b07fb..3591883b32041 100644
> > --- a/tools/perf/tests/ftrace.c
> > +++ b/tools/perf/tests/ftrace.c
> > @@ -1492,6 +1492,2259 @@ static int test_context_switch_handling(void)
> >  }
> >  #undef TEST_CS_ASSERT
> >  
> > +static int test_graph_target_filter(void)
> > +{
> [ ... ]
> > +	vmlinux = vmlinux_path__find();
> > +
> > +	/* 6. Test targeted leaf call with synthesized DWARF inlines closing and resetting filter */
> > +	if (vmlinux) {
> > +		const char *inlined_names[FTRACE_MAX_INLINES];
> > +		int num_inlines;
> > +		int j;
> > +		const char *saved_vmlinux = symbol_conf.vmlinux_name;
> > +		bool saved_ignore_buildid = symbol_conf.ignore_vmlinux_buildid;
> > +
> > +		symbol_conf.vmlinux_name = vmlinux;
> > +		symbol_conf.ignore_vmlinux_buildid = true;
> > +		if (perf_ftrace__setup_inlines(&ftrace) == 0 && ftrace.machine) {
> > +			num_inlines = ftrace_resolve_inlines(ftrace.machine,
> > +							     "wake_up_new_task", 0x1d1,
> > +							     inlined_names,
> > +							     FTRACE_MAX_INLINES);
> > +			if (num_inlines > 0 && !strcmp(inlined_names[0], "activate_task")) {
> 
> [Severity: Low]
> In test_graph_target_filter(), perf_ftrace__setup_inlines() creates a fresh
> machine and loads vmlinux before querying ftrace_resolve_inlines() for
> wake_up_new_task at offset 0x1d1.
> 
> Other inline tests in tools/perf/tests/ftrace.c, such as
> test_inline_processing(), test_stack_saturation(), and
> test_context_switch_handling(), call ensure_synthetic_inline() first:
> 
> 	if (perf_ftrace__setup_inlines(&ftrace) == 0 && ftrace.machine) {
> 		ensure_synthetic_inline(ftrace.machine, "wake_up_new_task", 0x1d1,
> 					"activate_task");
> 		num_inlines = ftrace_resolve_inlines(ftrace.machine,
> 						     "wake_up_new_task", 0x1d1,
> 						     inlined_names,
> 						     FTRACE_MAX_INLINES);
> 
> Should test_graph_target_filter() also call ensure_synthetic_inline() before
> ftrace_resolve_inlines() so that subtests 6, 6b, and 6c are not silently
> skipped when the host vmlinux does not have activate_task inlined at exact
> offset 0x1d1 of wake_up_new_task?

Acknowledged. In the next iteration, test_graph_target_filter() now calls
ensure_synthetic_inline(ftrace.machine, "wake_up_new_task", 0x1d1,
"activate_task") prior to ftrace_resolve_inlines(), matching the other
inline test cases so that subtests 6, 6b, and 6c always execute
deterministically regardless of the host vmlinux DWARF layout.

> 
> > diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> > index 384fc03850f27..4e916096a9380 100644
> > --- a/tools/perf/util/ftrace.c
> > +++ b/tools/perf/util/ftrace.c
> [ ... ]
> > @@ -313,6 +345,26 @@ static struct ftrace_task_state *ftrace_task_state__rekey(struct ftrace_task_sta
> >  			for (j = to_copy; j < ts->depth; j++)
> >  				free(ts->stack[j].name);
> >  
> > +			if (ts->in_target &&
> > +			    ts->target_root_frame_idx < ts->depth) {
> > +				existing->in_target = true;
> > +				existing->target_root_depth = ts->target_root_depth;
> > +				existing->target_root_frame_idx =
> > +					split_idx + ts->target_root_frame_idx;
> > +				existing->target_root_indent = ts->target_root_indent;
> > +				strlcpy(existing->target_root_name,
> > +					ts->target_root_name,
> > +					sizeof(existing->target_root_name));
> > +				existing->orphan_depth = ts->orphan_depth;
> > +			} else if (existing->in_target) {
> > +				if (existing->target_root_frame_idx >= old_split_idx) {
> > +					existing->target_root_frame_idx +=
> > +						(split_idx + to_copy) - old_split_idx;
> > +					existing->target_root_depth +=
> > +						(split_idx + to_copy) - old_split_idx;
> > +				}
> > +			}
> > +
> >  			existing->depth = split_idx + to_copy + post_count;
> >  		}
> 
> [Severity: Medium]
> When ftrace_task_state__rekey() splices ts->stack[0 .. to_copy - 1] into
> existing->stack at split_idx, existing->target_root_frame_idx is shifted by
> split_idx, and the else-if branch shifts both target_root_frame_idx and
> target_root_depth. However, in the ts->in_target branch,
> existing->target_root_depth is set to ts->target_root_depth without adding
> split_idx (and the guard checks ts->target_root_frame_idx < ts->depth rather
> than to_copy).
> 
> If a task enters non-target ancestor frames on one CPU (leaving split_idx > 0
> on existing->stack) and then migrates to another CPU where it enters a target
> root function at ts->target_root_depth == 0 before the context-switch banner
> is processed, existing->target_root_depth will remain 0 after the merge
> instead of split_idx.
> 
> When that happens, won't ftrace_check_target_caller() and
> ftrace_process_fgraph_line() treat the pre-migration non-target ancestor
> frames at indices 0 .. split_idx - 1 as being at or above target_root_depth:
> 
> ftrace_check_target_caller()
> 	if (has_retaddr && caller_idx >= 0 && caller_idx < cs->target_root_depth) {
> 		ftrace_unwind_to_depth(cs, caller_idx + 1, blank_prefix, out);
> 
> ftrace_process_fgraph_line()
> 	if (!has_filter || (cs->in_target && match_idx >= cs->target_root_depth)) {
> 
> allowing non-target ancestor calls and exits to leak into the filtered output,
> or unwinding into ancestor inline frames when the target root exits?

Indeed. In the next iteration, ftrace_task_state__rekey() validates
ts->target_root_frame_idx against to_copy before merging, tracks the
relocated index (new_t_root / new_e_root) of the outermost surviving target
root frame during the sequence-ordered stack merge, and shifts both
target_root_frame_idx and target_root_depth by the exact displacement
(delta = new_t_root - ts->target_root_frame_idx). In addition,
ftrace_task_state__prune_stack() and ftrace_task_state__rekey() now
synchronise orphan tracking state against the merged watermark history and
sequence order so pre-migration ancestor frames and stale orphan states are
handled accurately.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261025181125.514372-1-atomlin@atomlin.com?part=10

-- 
Aaron Tomlin
