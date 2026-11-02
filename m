Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793647256;
	b=yyUhMce0ndXprByoJPWfj+FPmDYyLwrngnG1T3R3LDS9YNxk5/bEVMrNRbQsk/MmzjK7
	 fqFBNRXdxCsSDeLbWeqMt6nu2bQZq4PvzB25mYtAFYghonzcWFY0htnzjhvTgG2F1iheW
	 ccdK/a4okgFdgz4Qh42oYJ9BEFi3XDNmttamQOtsJP9kSclQaZobaub0J5TEZqiF4bcSP
	 X6Dqpy1/3EFiljqyECEr/APuGbn4WiMiokXgGI2honnyryr/yW88wJ5dSaW9cmqYSW7aW
	 l8UjuDLSUZIze1m3FoA8Lq1nNk8sSmRYoVoIAGfK30jBYVCSCoWb+rHnOm6nO/E/1MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647256;
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
	bh=hq3Os9kVWaSQzwpzXZzdLcGnI71pAFvaHsKFUitNMfs=;
	b=kS2ML+MOi3HdkjtAIbiCAuXQDjZNk4aMxP0l93qfPlvMNJlR5vaO9QT9EEOIeQ2/y1An
	 ESVCRelBrFsNLkpb3CLeNcjwoEC8nANH+j0zeal7UHwGSvcys/efJHJP1C2qliTEw6m+2
	 ivVtdUD3ZrHAguOMYaVXEA3z7WKpzZVYIaRodkITEkj2ui9559x/4ak0upEfq1fvzOYer
	 2pi/tB6az/4V8KtUNJjTm4TR+TcE8gznPC+4fstJWL5vBXmRsKpWTrkcu/iuh0etb4htv
	 RfCMdiBXNpXeINqsLID5ZirS0yJEUwhmonjOl+h9DkjTvTVvW66oY9c26peYGFJON8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.79
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022079.outbound.protection.outlook.com [52.101.96.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC677606A32C;
	Mon,  2 Nov 2026 19:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC677606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9CLVN1sCo4s1WEXxtdNYTxfDXXwcVodXeI8GXcaj0NlC8LhuM/Mb1bCXPoToZ6XCLKuQNEYfT6iBTwbuVGNQNpUMgRKwzZo8rRWuLojz0yqStZz/8KHzbn/KR/xOymq7dC2jFABCcYewzhfUZK85QXTuzzxtbwCpcUGbcXTuiiIQlRs/B7wz0X92Dc/E6t0x0R7/EpHiH3SvggiBQuj43/3bfPjJ1lV6npCi/+w9E/v/O65kSzThW/LrVj51qTVPARKIQxDvjKnztaLq3KocynwR2ePYZht5+6PB5ifGqLbjYI8MzfLESc8VvlRb9/+Ueebb129SmKNjPytRWZZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=hq3Os9kVWaSQzwpzXZzdLcGnI71pAFvaHsKFUitNMfs=;
 b=gy8br4cM+6ejtV+XM12ob0ls3CIcVgxdzQYu2abc2ukG4erfZAv/iklSV5073ikPgQ5Hkd2ikzQC9/H/2yEB+yJMoxqQX8KwmQibrOpU6CJHvNTr7Kq8eWU899Zcc5UR5ADEVuk508CJrbUj8EcgfSMK6ppqn9sLTaZMhfbHyrzaVsJwJE3EauGC17EPywTvp+jTGspz8RSltgZxWXbilA2B8VIAx0OJiMGlIfUjwijCjphfKjtaueYStsfU2rv9KZzW2I70k+hbI5fc7uQP17EFhD+MOiD8soaCyCHtOo23xrG3KTRSd8PXV/HbvvoTKUAXbpk93pDwM0zYtCP9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LOAP123MB8880.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:498::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:20:51 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:20:51 +0000
Date: Mon, 2 Nov 2026 14:20:47 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, chjohnst@mail.com, neelx@suse.com, 
	sean@ashe.io, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Message-ID: <zri4x5jfbpykc7jxdicixkrjdw4f7tui72t7is3mos6cnzbhj5@2wct4vkl7sno>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-7-atomlin@atomlin.com>
 <auZ6tj_5-m1MNGDM@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auZ6tj_5-m1MNGDM@z2>
X-ClientProxiedBy: YT4PR01CA0403.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::17) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LOAP123MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dd157b-fecc-425e-c076-08df39166814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|56012099006|261009223027099003|261028144727099003|261022115727099003|261022075727099003|261026140227099003|261021121427099003|261026121527099003|261022105027099003|10067099003|22082099003|18002099003|261102123227099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fXPO7C5L8MT+LqsfwskeTkhrVA3EFJQxbx2FJihpoqiKv5sTm+e4aFV570lKBamjQreQa2TdHIdpQiZCsh1CQFC/jQCrHWFCF4IOZCOpRoAPUypjBG6A/+oMh1KFJDgV1hAX9wLcDUefLbF0c/2hoRJH27ECyP+LgZ4VVNd3oLlhytvsjeWOYnGmn9+sXv9n1WmOOdJooy6c/ifg+ltYpCXZxrz5nmViTf1Q17m6w+ctMQmyF7DDG4V/FtTowV8unwG6NvFxRCRlcjzOxtULnda8afYQvzRs2cQ0lHlK/CKB6KnOXWRrL2Wf4tmF3KdNAEAkmChz20k5SwyBzPjJeWzrNzobOjCdNMBok/JBBPimQFaOEUkRsTN77bX1EOfKQBpK1v0/QEh3sRX0u6niVTGGl87qxlV3ux7QKDKNWIl3RTUc2+RQTJKpZDxx+nBZDlkFzztE+/dtCcc90A9Kb1Wz1q1X6zdKduPkFG0nhGFt1kctxfmGsme1kDbDF82qykhTdYF4XyzAMcfvBaXo+xOU711VROFqrLBR6I6Jssw/ImxAffigUpaYBQKDg57Qqhi3hpogsnV2N3zLOFrdNHYKhwUe34OBZXVMfmkUGp+TjFyQABKNWWASxO8lse97REBAikHIwSTygR55FXnOiRwqWX84nc8pf0D4brGMHW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261022115727099003)(261022075727099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXVDYmIzeWpQV1JOTTFlRHRkWHRnalAvcWdYNENRb3ZtWCt0dlVYcnRHOHN5?=
 =?utf-8?B?YWxvS3FOMFRGaHQxbWFjTEpWd3ZTZWNrTFdhL2RHaXpEcWpPMGw4NWxWNjFX?=
 =?utf-8?B?ZW9wMStyY1ErNlJKNXoxQ3hvaXVTMjF3WVJ6c1BmdlpUUjg1a1FKaEhYbEZu?=
 =?utf-8?B?SFJRa1VObEdkMEg0S3Jqck1NT3NWSGc3UnRzY1poWFhSWkNMWkNnTnlhcjBt?=
 =?utf-8?B?c2k0cUJ6Y242SExkNlVpOHFOYTVBb1ZGSkgzbjZVKzFZaFpLbHp0VHJ5cEc3?=
 =?utf-8?B?QTJZeDdPMWV5RllqQ1Vjb1dRL084QTVTWi9KeDk1VlgybDJqRnVoZWdrd3NU?=
 =?utf-8?B?QUtLRHRSM0NqRExRWHZBVmd6RnZ6VlJ3QnZsUnFWU1FtaEJzUksvTVJLWEZj?=
 =?utf-8?B?a2VaNzd2aEo2UkRXL3VNd1ZKSEd3MjZERnBVV2RPT1grZjNXcXpiR0NPcW9E?=
 =?utf-8?B?STc0SkZWSWhJWGZGWk9PU2tkbDJkeWhGS1RTMjNCeFZxOEh4K3J1ZUlGemxm?=
 =?utf-8?B?RkxaVDNQbWg0SWR5M0kvM04vdlI2Qkh3US8yWUQyR3RuekM4RTZXczBYVTNC?=
 =?utf-8?B?aUhZT2xMMEg4aTh3NWNUYlFrQ253a2dmRWxpbG9RNmliclBtMzVyOGYyRnQ5?=
 =?utf-8?B?ZXFwYW9CUHFZekdLbDNSaHBvSHdvQ01lc2JHQktlVDRFUXRFMSt5NU1KM1VE?=
 =?utf-8?B?VWFSL0NXcTBNcXdUV2paYVZHb2duUGVheHdyVjZQbGsyZVhqT0t6Zm1QTEZ1?=
 =?utf-8?B?bCtGUzBqN0VRQTY0WU9JNVp5N0xyZG1wL2xxWXc1ODMrclpMQUpVU0pqOVZH?=
 =?utf-8?B?Y0hUQ1JZZVhSVWREUGtCZGNPcytnQkJNaG5OdG5jZFdYaW5EQ2srdDEyZ1JX?=
 =?utf-8?B?Uy9GV1N0UzU0THpVQjE2akpwZHV0MVQ4WmNJbzV5RnFZVGtoY2FUdUlhcGIz?=
 =?utf-8?B?V2ZQZFRRTHJEdk9LV1RkL0tBekJ3MnBkelpPWWlyOUJ1dDVkQk0zUmNpTGZM?=
 =?utf-8?B?bDBVclpjajJyQkZvazRXZ1ZQYmJIQml3U0tQTTlaSTlEbVZuWFd0VVYrOGt4?=
 =?utf-8?B?ZWdqV1pVSk5mdFB1R293STQxMWRMR01vTGJLYnVDVXo5bDhlV25UczlLNUZM?=
 =?utf-8?B?ZnM1dG1TbTUzc0U3czBKZUJ4OFFwWGFpTEQ4WkRVV0Z4YkkvMzBxQ0x6cjNP?=
 =?utf-8?B?ZERUdlhQU2JWNVNIaHRVVDZCcldRcUZDTVNLWTcySGhXQmtHTUNCSWR4Wit4?=
 =?utf-8?B?SkRJR3JiWWY0KzB1THFwV0NOSXYvK25DYys5TkRvQjBmZEJqbnN5N0YzQjFE?=
 =?utf-8?B?Q3FrSmpqQU9TNUxUdjBmNWFFU3VtdklGYmtYUWlZdW9nUHI4aW5WODhWQWtO?=
 =?utf-8?B?eGhiRURGdVJGSGd6ZFJqS1pOODF4WWhCa204WXQxRHVlTm5rMnR1MTFiSWhG?=
 =?utf-8?B?RGY3aW9RS1FTeERwWlZ4eGxIWE1ldExKYW5zbDFVdDFOSHg2cG5ZczdJNUls?=
 =?utf-8?B?aWh3Z0J5N0F6NDMxSEpmSmY0anVQbnRGNVh2RjI3MjZPaG5TSEUrcXIxTE41?=
 =?utf-8?B?d2V1WmJLNXNGZ0d6TmFXVWhoTEl5VXJCa1V5YzNVZlVOMENrTmxVY0pxT0Mr?=
 =?utf-8?B?NjVOVThUTloxeVc1cnhTZUdjaHNBbjEyRzFURGh5dnkwcmRmblZYVG92eDZO?=
 =?utf-8?B?bE1sZ2dmUUkwMXh5eUdnQWRaaTZrZnFpMDdyb01aMks2MEVDaW5YZXVaNzU1?=
 =?utf-8?B?SWRXelNFUUhuT1VMZ0lZWWp6bTd2V2ZBdUtIcDA3c2trRzN0NW1LQ3NXM2xo?=
 =?utf-8?B?cURpb2dpSGFTamVZSzhxWGU0UmlRNENFaktmT3JDR0J1Z3Y5eHZTejUzTUdy?=
 =?utf-8?B?VjQyNGdjdlpwY2EvNGRzdlA4NENtbjR4MG9PQmdIUG1HVmhObE4yK3EydUpu?=
 =?utf-8?B?OWhNclZoaVE0Q1QwZHZ0ei8zbmc2cENtd0Y4ei81S1IvTGJkemFFNmcxRXNS?=
 =?utf-8?B?eGxkRTB4dDZ4QWNJVFdDVHo3ZWJRYlZTWXh0d0IrRFZpVnNPYW9QR3BLY3FK?=
 =?utf-8?B?dHVQR0RJQ1FOU2ZPTHFhMGpGMTU1N21DSmZ4dXF4US8rTkpzTmx1SGJWajdE?=
 =?utf-8?B?R3E3cUx5MTNVcjMwR3hiV2JqQ2dHL2k4R1Q3T2dUaEo0Q3liVzJ6ek9SWURj?=
 =?utf-8?B?Y09XaTREcm1JSWUvNmVpQ3Baem1YS2wrTkZ5YWdpMENhQmRhNWtrQTUzS1FE?=
 =?utf-8?B?YTFwSFhxcDFxcEVEaG02OVZnOU8yMnRzMGxkZ3lpR0h0TU9MeXRkOXJmVHBB?=
 =?utf-8?B?RzNRUnJrcWJYQjE1K01UVVBUSVppOUF4eHA1WkFVcUxScXNEUXFTZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dd157b-fecc-425e-c076-08df39166814
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:20:51.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgvT/xjswJDZcww08h7G3IHe9iImHCjlaKFqLuToHDSXZXY6vNaiGCTTrc6v3HBJlBxFSNvKwE/E9GBcseCITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8880

> > +/**
> > + * ftrace_resolve_inlines - Resolve inlined functions for a return address
> > + * @machine: Perf machine context
> > + * @sym_name: Name of the caller function
> > + * @offset: Instruction offset within the caller function
> > + * @inlined_names: Array to store the resolved inline function names
> > + * @max_inlines: Maximum number of inline frames to resolve
> > + *
> > + * Use DWARF debug information from the kernel image to resolve a caller's
> > + * return address to its inlined callchain.
> > + *
> > + * Return: The number of inline functions successfully resolved.
> > + */
> > +int ftrace_resolve_inlines(struct machine *machine,
> > +			   const char *sym_name, u64 offset,
> > +			   const char **inlined_names, int max_inlines)
> 
> Why not remove 'const' from the inlined_names?
> 
> > +{
> > +	struct map *map = NULL;
> > +	struct symbol *sym;
> > +	struct dso *dso;
> > +	struct inline_node *node;
> > +	struct inline_list *ilist;
> > +	u64 ip, addr;
> > +	int count = 0;
> > +	int j;
> > +
> > +	if (!machine || !offset)
> > +		return 0;
> > +
> > +	sym = machine__find_kernel_symbol_by_name(machine, sym_name, &map);
> > +	if (!sym || !map)
> > +		return 0;
> > +
> > +	dso = map__dso(map);
> > +	if (!dso) {
> > +		map__put(map);
> > +		return 0;
> > +	}
> > +
> > +	ip = sym->start + offset - 1;
> > +	addr = map__rip_2objdump(map, ip);
> > +
> > +	node = inlines__tree_find(dso__inlined_nodes(dso), addr);
> > +	if (!node) {
> > +		node = dso__parse_addr_inlines(dso, addr, sym);
> > +		if (node)
> > +			inlines__tree_insert(dso__inlined_nodes(dso), node);
> > +	}
> > +
> > +	if (!node) {
> > +		map__put(map);
> > +		return 0;
> > +	}
> > +
> > +	list_for_each_entry_reverse(ilist, &node->val, list) {
> > +		if (ilist->symbol && symbol__inlined(ilist->symbol)) {
> > +			if (count < max_inlines) {
> 
> You can reduce the indentation by inverting the condition.
> 
> 
> > +				char *name = strdup(ilist->symbol->name);
> 
> Why not just save the pointer?  You may not use some of them, also it
> copies the string again when it's added to the stack.  It'd make the
> error handling a bit easier.

Since the inline_node is cached in the DSO's inlined_nodes tree for the
lifetime of ftrace->machine, we can store ilist->symbol->name directly in
inlined_names without strdup() and without freeing each entry in the
caller. I will also invert the condition in the loop to flatten the
indentation.

> > +		cs->stack[cs->depth].inlined = true;
> > +		cs->stack[cs->depth].indent = entry_indent;
> > +		cs->stack[cs->depth].raw_indent = -1;
> 
> I'm curious if it's possible to get rid of the indent and raw_indent.
> I think you can get the indent from the depth easily.  The raw indent
> would be from any non-inlined parent if needed.  Also having inlined
> depth in the cs/ts seems unnecessary.  What do you think?

We still need to record the trace line's indentation rather than deriving
it purely from ts->depth * 2 because tracing can start mid-callchain (or
after ring-buffer drops), where ts->depth == 0 has a non-zero kernel
indentation (e.g. 6 or 8 spaces), and bare "}" exits must be matched
against that kernel indentation.

However, we do not need both indent and raw_indent on struct
ftrace_stack_frame, nor do we need inlined_depth in struct
ftrace_task_state:

    1.  In struct ftrace_stack_frame, indent was only used for inlined
        frames and raw_indent was only used for non-inlined frames, so they
        can be consolidated into a single indent field.

    2.  In struct ftrace_task_state, inlined_depth can be dropped
        altogether and computed from the active inlined frames on ts->stack
        when needed.

I will simplify both structures accordingly.

> > +#define FTRACE_MAX_INLINES 32
> 
> Isn't 32 too big?  I guess 8 would be enough..

No, 8 is not enough in practice. I will prefer to keep 32.
For instance, after a -O2 kernel build:

❯ addr2line -f -i -e vmlinux 0xffffffff816916e9
      __do_trace_rss_stat
      include/trace/events/kmem.h:427 (discriminator 20)
      trace_rss_stat
      include/trace/events/kmem.h:427 (discriminator 20)
      mm_trace_rss_stat
      mm/memory.c:169 (discriminator 20)
      add_mm_counter
      include/linux/mm.h:3469 (discriminator 20)
      add_mm_rss_vec
      mm/memory.c:492 (discriminator 20)
      zap_pte_range
      mm/memory.c:2087 (discriminator 20)
      zap_pmd_range
      mm/memory.c:2151 (discriminator 20)
      zap_pud_range
      mm/memory.c:2179 (discriminator 20)
      zap_p4d_range
      mm/memory.c:2200 (discriminator 20)
      __zap_vma_range
      mm/memory.c:2240 (discriminator 20)

Another example:

❯ addr2line -f -i -e vmlinux 0xffffffff821c34af
      constant_test_bit
      arch/x86/include/asm/bitops.h:202
      arch_test_bit
      arch/x86/include/asm/bitops.h:232
      _test_bit
      include/asm-generic/bitops/instrumented-non-atomic.h:142
      test_ti_thread_flag
      include/linux/thread_info.h:133
      test_tsk_thread_flag
      include/linux/sched.h:2102
      task_sigpending
      include/linux/sched/signal.h:384
      fatal_signal_pending
      include/linux/sched/signal.h:406
      ptrace_report_syscall
      include/linux/ptrace.h:427
      ptrace_report_syscall_exit
      include/linux/ptrace.h:477
      arch_ptrace_report_syscall_exit
      include/linux/entry-common.h:233
      syscall_exit_work
      include/linux/entry-common.h:266
      syscall_exit_to_user_mode_work
      include/linux/entry-common.h:297
      syscall_exit_to_user_mode
      include/linux/entry-common.h:334
      do_syscall_64
      arch/x86/entry/syscall_64.c:89


Kind regards,
-- 
Aaron Tomlin
