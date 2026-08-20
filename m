Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022094.outbound.protection.outlook.com [52.101.101.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021573803E8;
	Thu, 20 Aug 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246167; cv=fail; b=nza0jIQ/DCMJwthMOGpKrPC373nWpGEPxsc8hzm5O/QIn/9wb6CuvEMzj13tYbW0kMBzKePisOuZetE7SHU8Vw4JJqnzh/iTKucsXNWGBL/GYP53Gsa1WcdaYxmyrnn2+Ik7eodHgKjrfUh6g1WHhf1hZcI1mPPyZHXUVLLHVb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246167; c=relaxed/simple;
	bh=K4iJZ2E46jjSbHnAJC9dZBgRvzwbiCAulNbi4bSS2TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G5JIcEMv3K8nU3xkbO+QiiTpEMvGGQaLVYdhmh2YmZVEiG6Ftk8BIMQcOqQ9xm2pQCVkMKVCXskdnPRH93EjXMJ8e03DBVTSZVRNRHDEa7sorp5bU0W4PzawA4dnyvneaju7oXcMJAIvMIyJyy8A7eYTxFGN4n3zwCbgXlNZqR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYZG6emXHRygkvzeiopv3wwYasFn0UuPH7O2Mxm+wY3hkn30oWl0U5YczbeBoV7fd8W1JyYcmY3xNGSNacGdIYssrs7OhQiu1c4iw1nXbv+70YZds3NiET0e3HYmb7QwXRLJTKpWFfYEOSQeXUraVzBc0F/WTRNbzpmM8PnFTxhHcCqwn01RaCbyR0Eg5qVMuF/wTyosc939H1UOAjxdBjoD+gRbtDE2UK06ex3N+Uyvtr9aJtHmYimnxZ3kulxo1o3vHLXlEYYNR3/OSRtS+AnEF3wnACpHnvkEiI1DgN1euM4gsXoSn+RlYTsHiB/237dGx6RL+PqDms49E3hdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=0+1W/MDs14HCQ3pQJaBz4FJf85tMswfnQCqi6lLxQwg=;
 b=jiLqcQL9W5eKZpJGAFmxHPF026tc4Z7ODPIHP4WFnCUtoUspGY4Jf1bpQIhy6rSDRqn3E3YbXRjv2K7Sz2GqYZZ/V52+XPqmJ+wcdkmtUCtGlLPqQtZeJRpJcUD5iXzwTK3hqyZjixLAQmnl4eNJBwjBATid5ZC2tMY7yS35LMToYx3hDMwkdoogSJxMdZ3dOLpUmwgj5jO/TBCNPb4L0DBU8pK+xAx2862KTggv2WsLWu/ULCbhljaT+2BcHVMBUJJp2yFuZYzv1aymvqAT22lhM8GVioYQDqwbGD1m80c/EhZ5DsXDQMfi9HuOBPDSar5LWDuK0CG/Wf+Uj81/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB4203.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:155::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 17:16:02 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 17:16:01 +0000
Date: Thu, 20 Aug 2026 13:15:56 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v2 0/4] perf trace: Symbolise kernel
 virtual addresses and function pointers
Message-ID: <kq4m6kjetnnkkgpxd6zypalu7rlov3xwruswk5camvvq5nmomw@opml2baj2upg>
References: <20260816205921.576365-1-atomlin@atomlin.com>
 <CAP-5=fXfpP_GN=DqeOMrrLUyy6xJ6GEcVo0TVkej9f0KTPfK+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXfpP_GN=DqeOMrrLUyy6xJ6GEcVo0TVkej9f0KTPfK+Q@mail.gmail.com>
X-ClientProxiedBy: CH2PR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:610:55::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d25d0c2-4dd3-48e8-85db-08defedeb55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0bAZIw2JiDGIIsvprr9Z2U29ZFFppPv24tNujtId0iJ3WorkyKxCFZc5TE/twhnqJ5yz7UmEqxXGe4h0MrFr7jtTUpzljRY2GvhsFyjCq2K9SbVlpjKXAmWTfaW65EEiE+2RqELy0QuY+a3v24ONS34hVVHifh4yf4TXmWfNabUgg4CC4uVYiZitCEETq4C0UDXjhEFh9KkoNysgmz+KZi9qW9QYfWNInSI9DrmNqhyEgHsaFLKWf8VLVaq2JarH5XZwGqX4Sw9Mh4NgmN+hakgkXe2r0LdZIi/BOoYJnti/l3BQvmZ0JGWGT/NZsGuwDq3kGGfnf1IJNOsubbDoBvr7PlSsnIr1UMHVXuwEgKI6MZBm67P6ICBK69lO+tML1hehVKsaPzh1LFIke3elOpEubtRKHpkubmj+usW5wocpx1paD1KOwWN+BSxRqP0amzwy4Fvbc3kTQnZRzDM0IZ5WSTQWMhsFe1cRzoyb5BHAaMQXovyoccqEtFpkB1wmcr3MUhJrdtRCV5hENXpIhlfMr/Wby0ZkR0268tA1IwPF5Tz4hE1uD4Ku/RFQ80CG7GUihVj3itFsl1d9G9IFGnvMIsK8qY0aXlYcmlZFG3MNyUklsqyp6SvlhTsstpuDwnaxXXDWD0AySxnEQE9OdSodiDwGHIk5bLXHj7oo88M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVNzR0VGMEM4My9XR1hHVWJWZWY2bkZ4QVVkbGYxZ1kwc3ZjYUJqVjlJa05W?=
 =?utf-8?B?MG5ad3RjczY3NGpIUzFaTld1U25HRGJQS0RjREdQWUw3U2wyWEt5V1Z6MnNC?=
 =?utf-8?B?SndkckdhUDUzZjVDS094UDEzbHc2dXR0eEFMNzY1UGRQTzgwM1MwM3h2R2sw?=
 =?utf-8?B?aUZ0MmV5UlR1ZGZoNHdqZTAvblNvdW5KSkpTMGtiUDFlUlY2SE5MS1g1akRa?=
 =?utf-8?B?ekdvc296N2J4QmtWWWZOdXkvem5rRmFad0gvVHFOc1F1RHJQaWoxemxVWlgy?=
 =?utf-8?B?eHRjczNwRkxUbE1mOCtDaUZvTjQrRHpVWjNNZ3dkUEdCRWcvdlhRelViU1JU?=
 =?utf-8?B?dW1WK2VBYVVDWnFZNWh2dEJocGpJM2VuRmgxSW5tRGZlRmR0b0YrTGkxUTBa?=
 =?utf-8?B?L0ZObHVUSWt6RXFVNmFMQXFFL2NPTmEwWHZ0cC9DcTlLYXpoUml1a0F2ckx2?=
 =?utf-8?B?Ui96K204OHBPU01rQXNVeVRlNnJRL2p4NnhtSnNUUHhVZzdRUXN6R1RUVXlV?=
 =?utf-8?B?QlNVaEVXZjIxd0tUYzR6ejdCL0NPWCtpS3VHTTh1UzJML3lCQzJoQkw3ZWgz?=
 =?utf-8?B?dmMzS21QRHNSOUJHTVpMQjdCWEtxT3R0UmhXbDFaSEdyc3Y0T0pkWGRSZXF2?=
 =?utf-8?B?dXk2bnFqdnYxTGdiYmJlL2gvcU0rOS80STFqUG9hUVdTb25ZQzdZZXR1WENC?=
 =?utf-8?B?QUlNWmJXajJveU44YzBpZ1JsajdzQ2x5YWluQXNMYTdyS2IxQXZLV3hSdXA4?=
 =?utf-8?B?YXV0c2ZqenQ4TVhnUlJFeTJybUJ4WEcwLzNlV3EyaTZGdGc5aU5rYUFFOGtr?=
 =?utf-8?B?NnlvQUJzUTdHRzdBeHhTNFBvQkI1eTFjZjhDSzdCNHZrTVVDUHowRE10RUtM?=
 =?utf-8?B?amxqazBpN2dFWVBpL2cxcEErSkhrQU5HT09HbXJ6YkpKUG9DdWtFSkhlMFAw?=
 =?utf-8?B?UmdaMTd1bmU3aVlKUi8zTnc5WGZ6N2owRVpod2xGb0FUWXFoaHJuZXpNb3Ay?=
 =?utf-8?B?TUkvS05BSkxReXphU0pNTUJ3MmhINUE4Y1JaUmx0TDFXeWFQaEE0Y0xjazEx?=
 =?utf-8?B?Wmx2UnNYMnVJVHRiWGVxYWZ2WVhDWGpVWm8wOXFXUXJRdzRxVlJFTHFieFRy?=
 =?utf-8?B?NnNwRlppeVZ2dFhsdDcxY3hyYmtoaXhwWWZ0UUZQdXNiN3ZNUUxaVUZXWXBI?=
 =?utf-8?B?dkJYRVdkM1kwb3JNQm5JZUx0QUZLNGp5cERWSUh3MTJ5NmRmaFFvWDJMKzM1?=
 =?utf-8?B?SWRhTUR4b1QraFRtdVlCREE0eVBWaTRJWUpiY2JjZDVoRDdyMml4ZTZ0cytP?=
 =?utf-8?B?VnJqZDl4Z2ZnS0pERXorNENWY2lvbW96RHhZWEp5TDZFUzdJNnY0QnZSaXRZ?=
 =?utf-8?B?Nk1ZSWp1b1VydmJjWWNkZEZkRk9ocWRjeDBnRGx5NFN3QTgzaE5waTVOTzlL?=
 =?utf-8?B?c2tRT1RlUk1FQkJVa1prZlBqaHMydzdvbWpmaG55VEVDRTRsTEtoN0NGWFJD?=
 =?utf-8?B?NFNVTDRlMDJhc3lJalBHclY0d3d4ZFpROVdrWldiRHFaTlZKdEhOZjNxaHVO?=
 =?utf-8?B?cmZBZzhxQWozY2NuYmxqZzJzSlhpTDE1VklSSWtwOGJ0VU9GSWx2Sys3Y1Fy?=
 =?utf-8?B?V09FMWRwUGIwenc0bi9saVZnK085SlQxOS9GMlg2N1daV25TbVBJcVcya2RM?=
 =?utf-8?B?TU5OUk16bUhyTDlCN3Q5eisrTnpqc0tMNkZ5ZUMvaUZPc2FBS0ZlYmUrc3I1?=
 =?utf-8?B?WWJudnd2OVNjeTNaTGFyRDc2UUlkanV2R09xQUJvSVJJS3dWL3RndTNNUmhG?=
 =?utf-8?B?NnZkUzIxd210SFcwUGttOVQrU3FOaWMwVm50RE9DcU9PRzl3OEZuNEpWb2JB?=
 =?utf-8?B?WDF2YlZUQWljK0pJa2wrTW50aldKYlJVNmFsMGNqdWhQdjJNU0hhNWNnVmwx?=
 =?utf-8?B?S2s2RjV1NU9xb1BEdkdZSWZnTlkzYUpCTHFoaHN2Vnc2WXY3MElRaCt0bEtL?=
 =?utf-8?B?ZW14b05NWkxGUW56VyswTjRacTFCaUFyU1hkVm5DdSs0M1FRZUxWaUc5NnJS?=
 =?utf-8?B?ME5aYTBwWVpXcU9JM3ZGays0YXpMRG1BZFlQUGtLd3JJOThjZmpRUjFjLzNz?=
 =?utf-8?B?Njg4TWJSRC92TUJ1K2pQWTRDUFpjdlpBQnlReUh1NWFnTVlhbGVGaGt2STBG?=
 =?utf-8?B?TTRFQlNFanB3S2Y4SWxkNEZoQnpHcFZSWHQzVFBjSkMvSjdJY3QrYjBEOFhE?=
 =?utf-8?B?NFBVQmR3b3loeExjM2lXZGFQUUJZSEVNWVp6ejlaVWtoR3FBZFhKRGNwdFAx?=
 =?utf-8?B?Z0huM0EwVG9qU3V3cDNxQmxDVENESFRNWWpJVEIwclY3Z2hTYW9uZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d25d0c2-4dd3-48e8-85db-08defedeb55f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 17:16:01.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4sJhVDZio6+8DOBA/QvCz1BE424nr8f81V7sxFak44g7RMGRA5ZruYy99/CjsTRNXkotQ0zICPgwNjJpLaIrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4203

On Mon, Aug 17, 2026 at 03:52:07PM -0700, Ian Rogers wrote:
> On Sun, Aug 16, 2026 at 1:59 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
> >
> > When inspecting kernel execution flows using perf trace (e.g., when
> > monitoring workqueues delayed work items, timer callbacks, etc.),
> > tracepoint payload arguments containing raw kernel virtual addresses are
> > currently rendered as hexadecimal values (e.g., 0xffffffff81234567).
> >
> > This requires manual symbol lookups against /proc/kallsyms or vmlinux to
> > identify the underlying kernel function being executed.
> >
> > This patch series enhances perf trace by introducing kernel virtual
> > address and function pointer symbolisation using perfs native symbol
> > engine (i.e., machine__find_kernel_symbol()).
> >
> >     Before:
> >       workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: 0xffffffffa8046b50)
> >
> >     After:
> >       workqueue:workqueue_execute_end(work: 0xffff8ac2c420f270, function: wb_update_bandwidth_workfn)
> 
> This looks great and a test! I noticed Sashiko feedback on patches 2,
> 3 and 4. It looked appropriate and actionable. I'm looking forward to
> the next version and testing!
> 
> Thanks,
> Ian

Hi Ian,

Thank you!

Kind regards,
-- 
Aaron Tomlin
