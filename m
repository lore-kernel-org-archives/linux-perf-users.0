Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021139.outbound.protection.outlook.com [52.101.95.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EEB54B1C0
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990561; cv=fail; b=rnoKv8LOLloCYDB7tJvkudg2K64zva1kedYzSHkGJ+cIQJcpstbnD0+MIW4tT4roCUhude5kABy1xcI+ri1xMlkXq71iNevMSsw9CQ4oxc7ndpMJzaIykftAUotDi3zR65jSAvqoO03dgwgxjtTQkIlMSdmKaoTR1vlx9hixj9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990561; c=relaxed/simple;
	bh=Z+uI8Yv4NsvyAjnrrBwoTxSplQZYNujERJbC0ovA6es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R5RgRhcdPjxTr1tDVChfR7iiPepC82h4aPgIZo/giOLVM7bbLQh/YLT2CC0anGU3pynGk3blajsKEf7jdhz7SjPU6SNGesKRpxMciOwN4Oar31KisubaPehzmCNFLs4DW1G5g9UvqG6kMvp//uWQYQe1azBs6lyA33D0byqA4+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqb/i5N4K9C3TS6AoKjQM7u8szUZ8gq+QThtLD/kCvfP9ByebyvNCx1EYEOT41TEQOxCSwIft3ZvYUY6k+REQNJgD/YBoxUf+COVOra6C80Ln/aUqoEyIgdeljy1+3mUR9tSel8Lhm+Guhhv5qhY6T23xioeaSQxmX10gF4cEq57pcd0XofGqlyBfpq8Yl3zfuIJiZMwBM+PkeT4kkovnaJFHoD6Uh/vd7X08yQ3peWZRqVeZRfDtnH4X8hfGgCv0dmUG0S0RZ/IVEo17QpRZDPLYSniRDxxsgqEDB319dyDUnT0Gkr65O6okSK1j8/O99BlsAEOy+vFPJhEoOS/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=kenGzEPhMwZdAaO9xnNVJYHggpIqEyS7SFq7OIvW8Gg=;
 b=T1or789BIh1+8/jM/VGRR7kBTOJeXYWvh9Uz9uRGQdymFNcI0e0T+WGsYy8HAiC463dZqeYTRZv80TXOcM4RhjB9EoGuTjbRZvMgTfnhTQjdVHSmfSeiqwXXJgZRvkt/pATXjWHq0Eo/bCsZLk+4U1DZy2eQJFuRUUCFFbpzGuDD3y/MTmiY9oJiNX0SQuX1A6KChMpNZKBaAtNeDGv02x8szZc+Qvf/s2qWEpraRC5+L5iz/3nEoR/cKqNFuIYU5i1udyikXPKjmMrPJYub8kUPPxXaqSKyDqfF4QOR7NtLHNBKVe6MkoBpKoTiulgq8JSlEFvKOoc+s32GemAEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB6192.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 15:09:12 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:09:12 +0000
Date: Wed, 14 Oct 2026 11:09:08 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v3 5/5] perf ftrace: Filter extraneous
 functions in function graph tracer
Message-ID: <iwol2bjxm6m46nbwtaysch2dlxvrylhk7cb7werpddjygalh4r@mw6xqdlo5uwz>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-6-atomlin@atomlin.com>
 <sashiko-outbox-167526@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-167526@kernel.org>
X-ClientProxiedBy: BN8PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:408:d4::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: e033673b-7109-4f84-64d0-08df2a051a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|4143699003|5023799004|261009223027099003|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AQGZBwoKZkyGXZGA20hgz/RS9DVug86mh9UBdOXpXSc6FgzMa4RwCMB6d88Q67gwpnpyPCQA3m3UU+ICVoNq1sZJodLqfeokFF/ailSeDJM2s5UWqJuKQbsl7H6od+lXjZZUpl0RwEHaxKP4atdZTtCzTvwNM4QwFktSRVdaR5vEtVIo2uWRYgX6KVwATxMs5llfLV269jQlyhK1lCR6dQj5BI9UNOWQjg3war1VCLB4N/tPLMSFdUVbUegzBqyUWUsLzKZAYWUyohSVjXxlK0h84ayx32s523i+e+8hKB5cVR6ShP/foROJWk7a2ttEiS1ohV56T7dbfDUBGheTxzHO8Iidq10xINUTUq0zQPZf2uvrtZi3H9MRYzbpLWKp/f7WJRQ7TFZwbY2w9WSIs+zNELxWoU7/Gq7H+xhaAs0OKNd5G3JWSVBEQcxgV0Nak3zrZ+QtYX/byl9S5ArsLnGC0H3WsAv6nREHA862x1wrPIy+Axd1MiNa4bMI2iXvFjSsBC4z+2h1Cwq3ScFS1YsIA6U+YtksQAty6ywaWvRmtiNfbiECo3zd3Hg3h1ZWnxHvnJQMSgksyiv7aKVWTX0azxDgI7RxWRAjDKDHB66Rfupxsl4n6AL2ubJek/Rs+tFVUg/JzmmNeeq6Ein2hwf2k9h2zESotuPAP4GSNXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(5023799004)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxHb1lxZS9jRG54Ti9OTUFodGdiTExTMVdUUEd2U0Vub1JFcjlUUW5ia3hl?=
 =?utf-8?B?WVBuRWsrRlNFQmYvUmNSMHNoeUFDeThhVndkTHh2ZW1oNkxKbkpUdi9yUE41?=
 =?utf-8?B?ZmRKeXhMdHhKVEkwcE1ZNTd3VW5ERmwvM1pjTC9DVHVWMWt1eDNRMWpLUU5G?=
 =?utf-8?B?bmpJUkNNalB3L0picXNFcGxnYzQ2amNzOW11Y3RNNSs3eUo2NjJFajBseUhU?=
 =?utf-8?B?V1RJcW1yT2dXaEY5RWdDU0VoRFZnUWZ1NUlMOUxhQnc4Y2FYM2lPWDluQ1RS?=
 =?utf-8?B?V0V3cWliM0RaRnVqODBBRGJya2tQbVFmOGVBc3l1TmhoTTZDWVlBWGl6ckRC?=
 =?utf-8?B?R0tDUUNsL3Z1cXdBQWZWYXl3d0ZNS3dnR2NFNnIvVWQ0Mklid0lMWVR3QVYw?=
 =?utf-8?B?aEZYMHdlYVo1aE0xMEt4YlJYSlZMSzhxNDhLQ2VHYkJ3ZEJCZ1o1c3U0L3V0?=
 =?utf-8?B?V1pKdlJ6WnU2WjY2VkdubEtMNnNCL3FxV1grRkppT0RiMGFNOWRMaXZSM2NQ?=
 =?utf-8?B?Z1dLbjVabHc1VXdTWmtlZDM1MmgxSGUzc0F1bnhweTFZMEtITEkwdFNiNlZC?=
 =?utf-8?B?dmR6eU1TL0IvREo2WmhRYzZzdjBKeS9Ra0o5dVRSK3k5ejY5R0V6MnF5N205?=
 =?utf-8?B?NGlMWTZrOEhxZ0dxTnk0U3FxcmxxRFVVaUJNUHJHQmNWSE5JcGJxWDM2b1By?=
 =?utf-8?B?c005azRIK0tKSHdjY1BpcUhzOHpMWlplNVB4WmJVZS93OHltaVJSNnBLWU1t?=
 =?utf-8?B?RDdPMysxY3VzYkl2S1lEN2J6V0pMcHA1NmJ5VGRyTU01ejhDTXhrQTUyODIw?=
 =?utf-8?B?bGpMSEdZNzVzcVhjL3JlQW5yRjNyOWVFUjVMNmszTmRhOUJUdStGZFFEQ3VE?=
 =?utf-8?B?YytWeWpIYllnanZUWHQ5elh2eHZ4TTJtU3FqZnc2T0pRRGFwdGdGelN0OC9S?=
 =?utf-8?B?ekgwQVpsK1JBOGxuQ1JKbjlGdEZMKzI1NmNrYjg3M0lXRUczK2FkYkhyWko5?=
 =?utf-8?B?eUQ4Rm44WEpkTDczOGRKR0MwS1RseWo5dlBOSmhzYm9pUkxyTG9nUlRVQzhk?=
 =?utf-8?B?clR0KzFZTDJnRjJSZFplZDE5dnlxNTJVUTFOM0ZCYTlmbXZJVlMwUHVhaDdq?=
 =?utf-8?B?KzZVS0FDbnRlcDV4Zk8xRXA1alhyRWNBdzJ2SU5SWUxaVmQ0RENSRUZPbnNS?=
 =?utf-8?B?RytNdkwvemNycmFxbXZjQ0xLRDI3VUMyZWZKRC9tVzhWSGMwbEordURmKzV0?=
 =?utf-8?B?SmtCMHN1bjFYclVqbEFqUFVJR1FMNzlxL1VlWkRrR0JCRWtDOWhKOXhhdC92?=
 =?utf-8?B?azdWYndIM3lhNXpvNVV1YkNDQ2RKdWJ1UFVYRGJUSzJtY0wxMDhLY2M2T0NH?=
 =?utf-8?B?NVkvdkxrbGF6SEtsNWtrOWVWZW5oekdDNnQ2UmJGY3hGSWhOclRGRTZnQ2ox?=
 =?utf-8?B?NUVPMENGTWV1NE9Eb3ZtSVZpWEhnWDVSbVcwVFZ5Y2x6dHhtUlRiZTFCbDc1?=
 =?utf-8?B?dUVZQUxTbS8rTHBuQ1ZTd29TcGI3TnNBWFc3MFdMN1RkVEdmcVdBQ1RndHJ0?=
 =?utf-8?B?VTQxUTc2Uzh6V1ZWVGxVMWg0WHNaSGFjemNHbDJFQ1pPUGxzZ0h6bE5BTGgw?=
 =?utf-8?B?eG5nU3VrUDA3THZlbXR4Y05kdmhqazFFeFhJTHFrMDZyZ2xmOGRzYjZsdWli?=
 =?utf-8?B?bjdzOE1WenlhNHRNUXhNVElwd0Fyd2cxdEIrZFZoUDQyMXhNZG5iYXFnWjhM?=
 =?utf-8?B?K0NHSkpaMTgrN3MxNXBjZ2xZQkMvMENZRnJmMXJ4cDNxSGJFMlJ3MWd6UnFH?=
 =?utf-8?B?Ym85dGhsRmdJZ0Vibkw5d3JFTGVzcFQ0cjM3b1BDY0RsbytldC9HL3dqR2xC?=
 =?utf-8?B?eFlibytpRk10RFhlMjVnbWhuejVUdUd1NDV1cDczcGxEUXFoVkd3WktsU3FD?=
 =?utf-8?B?c2NBb3AwZ3VJVUFiSzcva2VFREVrTnhPckhhSHhqTDQ2Y2tPa2JEUlFxbk9n?=
 =?utf-8?B?MUVhRnVTZC9BcVJBZlprSm9wQzFOK0dobjlZUEpqeDM3a3VFeVgrdVJYcHZQ?=
 =?utf-8?B?Z1RvU1lZWWJFVW1PMThrcHdSSENrdlpjMEZNZ1k0QzlsbjFScE8yZTdRTXZI?=
 =?utf-8?B?d1pOajZQdityMGQ2OVV0Y0hOSjNaWUlrb1poRXo5cmM2bDVnSm1oUmxBeFJK?=
 =?utf-8?B?dWQvQ1hqU0E1YUcxRnV0cElhc0dhYzQ2RHkyVjVTbHhjK0hHQkEybGcwa1NT?=
 =?utf-8?B?bFFsbFRPR2RKN0ZZcmd6bko5WTF5UnhPSEUyemZZUFdmT1pFZm10R3RqQlRD?=
 =?utf-8?B?WlJCVlp1cDIxYVdVbFpQMUFvYjZ1Q3RvU2pES29DOERrdG0rZmRJQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e033673b-7109-4f84-64d0-08df2a051a8a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:09:11.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6R9wfbpST9zDDEZe3GgOlE/4umgsPTiuLrETJhTIsYyTROCt2+RcJx4bUGtIu8+EQysc7dNeBY13yMmDMYDiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6192

On Mon, Oct 12, 2026 at 12:37:54AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> When a targeted function is a leaf call (no braces, only a semicolon) and
> occurs at a call stack depth greater than 0, doesn't the hardcoded check for
> cs->depth == 0 prevent the filter state from resetting?
> 
> It appears that cs->in_target will remain true indefinitely if the target is
> not at the root depth, causing subsequent non-targeted sibling functions and
> their descendants within the same parent frame to bypass the filter and
> incorrectly appear in the trace output.
[ ... ]
> [Severity: Medium]
> The identical logic exists here for the use_inline code path. Should these
> checks verify cs->depth == cs->target_root_depth instead of cs->depth == 0
> to properly reset the filter for leaf targets at non-zero depths?

Yes. When a targeted function is a leaf call occurring within an
un-targeted parent frame (depth > 0), cs->target_root_depth records the
depth of that leaf call, but the leaf call does not push a stack frame. The
hardcoded cs->depth == 0 check therefore failed to trigger, leaving
cs->in_target stuck at true and allowing subsequent sibling calls within
the parent frame to leak into the output until the parent frame exited.

I have updated both code paths (with and without --inline) in
tools/perf/util/ftrace.c to check cs->depth <= cs->target_root_depth and
clear cs->target_root_depth:

    if (has_filter && cs->in_target && cs->depth <= cs->target_root_depth &&
        has_semicolon && !has_open_brace) {
        cs->in_target = false;
        cs->target_root_depth = 0;
        cs->orphan_depth = 0;
    }

This mirrors the exit delimiter ("}") logic and ensures that:
    1.  Leaf target functions executing at depth > 0 immediately reset the
        filter state, suppressing any following sibling calls.

    2.  Child leaf calls executing inside a non-leaf target function (where
        cs->depth > cs->target_root_depth) do not inadvertently clear the
        target filter.

I have also added test coverage in test_graph_target_filter() in
tools/perf/tests/ftrace.c to verify that targeted leaf calls at depth > 0
suppress following sibling functions both with and without --inline.

-- 
Aaron Tomlin
