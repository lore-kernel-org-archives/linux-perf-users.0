Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021124.outbound.protection.outlook.com [52.101.100.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C242393DE6
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116836; cv=fail; b=PoTZ/RaT5laCbOn0wRDDt70UgZCFQyX25xexoJKQ2ehjNtEYGXezssRPrGRsO8ZqmvX/un9STl4o2rTM4fJ+KIF7f8GcPeJ2bDIdbkDcPJZojXGuaART+iLdk0I5RUphz5SJ1j+e6IlE/ZrDfiXpuzLXQevIJjl664g02z2uL6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116836; c=relaxed/simple;
	bh=fgnjFknYnBzdn224ogCqr2oMzFNuFLl1SYsn+N+EYhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NN5rjuy694i/bD1pZS4Xo2rfMmL7gThdmr9NVxeQkg46d2bObuTBkqzpcuLfZbV/yTv6oMN/i2QjOYNLVYlN2Gz9lbThBkLaRC8CaCxJ/8IUNFNbdhZNGTryTK5bZmyDc89vIq9IgLdug81f7DRObfE2IW4hsBMiy/RuRlSIcFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggsKR7nmtT48/O8bzxJ4dohIW72YrlP6Ymp09/S/RaSmuVBaUqdQl+LuryaCRPnYWGIkSfvDtEMFY/X+WeMX6Bb06VgZFs6kippbVKo/wI5hqXKOA9TGNS63CSZLYwKcGJqz/6TPxvrIEnxazQNDOKYFeR06rb9HgccfdH9qKJS9pyNO4noorZX+9zYXQO/IhtfEZrtB74wIz9bbIxe7U+mKCqCyw63/8M8pO/DiB1fzdcpaORCl7H/Z4Y3VJJr0k+aoIhbS/WA5OWn3/MPst9PDJqFmGZeSGP9GXSqFTc9s+xQsKIyJ5v6duryBC1QeU3pms2r20DZNh87W2a7S6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=QAZg8eCC/8oDkc/bN++5ssX/LPE4aKrS3WZDsga9Ddk=;
 b=B+klUxgAMaUfGGuGrvh7gac3Op/ZWJKWTTJlZjhOOO2SJKhIqLJroeg/4OgTocYoMchKEoF6kNmYuYFsF6HZs88v6JQNzJ+XfWofGzCVpg4PJ7+mc05C0ADyuc54rOuWhNw5vIh/9hTnx38Tr5kCm6/x30J+pi4IMtL0mQzXde2mX4Q3ZCuOlel/y38a5ibneV3tq/M1t6wOZJaPQ6YRfP86dRH8QQa6nQ+I2fc+2wDbSnNAyC2Vo7JXAQpmDjRm7dMVoANlLyVY/6WSGI4C2Kl7skFuccYal2xLN+R8HxLkkbomk1hGAAs/gbvfvQ+dowf/cn64Q9KgTIHTNnAK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOEP123MB317428.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:500::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:27:11 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:27:11 +0000
Date: Sun, 4 Oct 2026 08:27:09 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev, acme@kernel.org, namhyung@kernel.org, 
	irogers@google.com
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Support --bitmask-list with --libtraceevent
Message-ID: <roxqzxhbk5lciajncvrttpz7kzszj6bie6xp5v3z7rh2i3khgi@lhtwjgsyfsce>
References: <20261002213145.333100-1-atomlin@atomlin.com>
 <20261003013401.9EDCF1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261003013401.9EDCF1F00893@smtp.kernel.org>
X-ClientProxiedBy: FR3P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOEP123MB317428:EE_
X-MS-Office365-Filtering-Correlation-Id: 54182e50-8e83-4d80-8694-08df2212d08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|6133799003|4143699003|18002099003|22082099003|27256017;
X-Microsoft-Antispam-Message-Info:
	xpsL8KrhfjktjAugi+6UzMlHddUIJ2qzADdsPYJVOL/yQgy/3BvbSDFzIjQAE7WpFkooarK5o4CAZDjLAiYO0kqzoibmo4wTa943D86Gdrh5bgJ3xamT5JISh/H8osnP9XUE2WDFLzYLhWwHYN2ZCi+gb6KBa5rvoM65eosABg3LMy3fSMeGVxVy+KU49rYjZPkOJH/2gy/gM7jYi7ZzP0WCupsPynC+DKrjg3WYbZOBUjNQBdJaL4MF9H0pa/ODpfxJKyQnrBw7b4b6Zs2GenxxrQz0cp4mfYiIGKYVr7UCpTgmLETGVkwZsfHlTJlIHzeXBYyG0xsbv/PWfBD+gvyu4pq0CDT1bCJhwjBUGUC0VsrVZ+IuxWXbW268h4epEuJS9+t1ip25f4eafjrjatZWQzqps1S/KZsntjJ5xLT9cna8eU78/MDwikTLEzvQ9fdrqZ4BrVMml/m9I18N9tVkRDBY3O3KY0T7Tju6bfcEUjoB7Sttuk9vZsEdry+jzC8WZLvZ+wtRXhJQi6WPEt7UajIi4GKYMteqLC0cBALV1wHpkWXeWU+ac6+y52zWbxjWRdG1IVta27Tgvv0qZ4gXpuMATeMs2MiG5wqZGrDAsBkvzOdxzDMGA9jvd9atZ8oeTn3YFFt2wNKxqCUL4SzuElkYSAQsPW00joAKsy/fOpVxsqo4pxOAsP6c43zDNB8fLLpx68Kf7J4583obvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVBYQ2FUL2dHSU9IM3ZaWDRwTTZ1VXc2WWVVa25BUkYzeHhDNUcrb0lSL3RT?=
 =?utf-8?B?Qm9tYjB2K2xOWHpGMmpISHRKVEpqL3Q3T2g2cnEzeThCb2hETmxZQkhNbkxm?=
 =?utf-8?B?Zi9uM21GcVZuQWxwdUhmaHZkVjZHNjE0dC9ZdGZlVk5va1hldGRRdFN1amFy?=
 =?utf-8?B?aVdRdEwwQ1plT1ZVc3NXUDBoOHN2Sm5HL1prTllvVDJmanZFOVVvbjJuMDQ2?=
 =?utf-8?B?VURFTlJRTi8rVWNXN1oyaktrNExQQUw1RTBHdmI3T0NDQ1V6L2tJcHF6VVBU?=
 =?utf-8?B?TWJHa29yNjV2M1V6azJ6a283WEJLeVZXd3gzbGRrYjgwejJOWGJUS0g0L0l4?=
 =?utf-8?B?SEJlTnhKMVhHTWc4UVZlTXVKdzQvV21nQWZmUDh1bXJpTnUzRHdIWm5DaGJP?=
 =?utf-8?B?bHduVk94eUVvVFUybG9hV1llYm4rWVlnQU1DTUhTSFZveHk3NDBYT0ZoVGtQ?=
 =?utf-8?B?L1dEMytsNjZ4Z25UNytpT3ZQYkdJV0c2VHdUY0ZEMHE0aDcwYTE5QitxMDNi?=
 =?utf-8?B?VXBHNG5UQ1A5QTh3OWVsSW9OYmJaUVJWZFZOYXhQeTNXVXNXdGVqQjJ0eVhp?=
 =?utf-8?B?bTZPT1U0SjVaVnZlMmdkR0swYmNtcFB0SlI2TUx3dm5zWVI0dG9hNDJoUnVW?=
 =?utf-8?B?U3R4OEVpVDNOdElXNEVQK1k1d0lHdWdWM2NrR3JHdU5tNG5CekErdkZkbk5D?=
 =?utf-8?B?SXBrMGE0REpKeXR3T09qcU5TYmJtbEJVN2o3Yzh1enM1bEtnemVFWEVvbTNk?=
 =?utf-8?B?d1BCWVpzbHF6Rk5DaGIvWUpmZnpobU5ydVpRMkMxdHR3bWl3clJDeWlCdEhx?=
 =?utf-8?B?UWlGN3IzTUxGWFRoVHRTTEliLzEvNk1EcU12NHVwRGNBTFNoUXprZHNwYVJC?=
 =?utf-8?B?V0ptUkZwSWd5OHNET29Wa3p1c3o5MFRGS1JzTE9oVzFXNkxiak1kYWo5UzdH?=
 =?utf-8?B?ZmJQUXRQWW51dnM0T1hHa0dPMVd4UHlRWTdrMy9hT2N1TkxxWHV3NTlnNHFX?=
 =?utf-8?B?d3g1Zm4wMmdzcjU4NWwwZWxHUmdSWWY4QUExaUJsYUxjTlhtZkFGcFAyNDZy?=
 =?utf-8?B?MVJpc3FSMFhPTmhFOFpjT3NseFlQblpVcVRGTE51MVkyNDBnRWkxMzdxenR1?=
 =?utf-8?B?YjYrZFlwbVQ5OHVlVFlXSy9VeHJRNE92TWZoN3VkVkRRRDdxOHo4c2lzSGVh?=
 =?utf-8?B?Rk4vaGlWQUxvR293L0JCZnJMREhqNGIrcmdnMGdzNUtiUktKQU4zdGpjcUdZ?=
 =?utf-8?B?eVNTRndaaW9XMjIrUHQyZ2N4dVhaaElsSXpWMml1V2pLSFQ4cnArM3hLVDJx?=
 =?utf-8?B?YU01Qlg5SmhISEZxNGQ1ak9qL1kxK3VUZmR4S29kakVqQS9mUFdVUEtXazhy?=
 =?utf-8?B?ek1DaHp4bDVZUlRmVFJuV2xEK0c1ZHQrYkczckg2UmEyOXVHL1M1RmhuRzVp?=
 =?utf-8?B?bWFZcVZOZ0xHenl5L1BxU1VsUTJTYXBtOW9EUjdmUkMxbEFPQW0xdVB4M1k0?=
 =?utf-8?B?UzF0Z2czMksyaWhIcEg3MFJaelFKTGY5ODRha2tsNk8zNnpWY2lQSzdkb2E3?=
 =?utf-8?B?TTVSc3pQUXB0ZGx3QTgvNU9TM1ZTMm9wb0RndDlCRlh4dFRIbDhHaW5yeThC?=
 =?utf-8?B?SzZpQjdaT2w1dkh5YVBmaUtzNzZhMmlNY05xeFdzYnB3NDFXMDB3OHNOZWYx?=
 =?utf-8?B?Z2JIdXgvMjQxNTdQU0ZDYkdJcGwrdzJQZjhMWG9aV0p1eU5OcmlsSjQ1MWZ2?=
 =?utf-8?B?b25VQUZTYit2QWo2anYxcFBGS3EzcEVDTUdFTG85MExpUHNKaFZ3OEsra0tC?=
 =?utf-8?B?QlRyZVVsMzV6TE5aV0lPZks1dGEwNjR0bVMrT2ZnTElHcFFCU0lidFpCd3By?=
 =?utf-8?B?ZmVPc3VyWUd2S0NCemYxVzBObVNyRUUvdWdrV1JWd01hY0d1S2R0L2tCbWVy?=
 =?utf-8?B?eW5XWjRGN2tsdlkvWVVta0RBQlJJSmg2VTlIWmlPaTdGWkkzSW4rYWdJTVVB?=
 =?utf-8?B?dEx0eVJKRmJlV2daZUZhS3QycCtWNlllL0MxSFVkOFFYY21JL3FZUHArY2F5?=
 =?utf-8?B?Z28xaEdiWURHTlY3U2xzTklwM3RRZnZXMDlBT0o0bXgzTXpkK1VyQ09FMXA5?=
 =?utf-8?B?UTdCeWh2ZlRMNEVjb1R6eFhSdWw3UmRiQlMyaTFLVGlOZ0VOOVU1OW0vZzZm?=
 =?utf-8?B?WklzcnFnNDdkeVNlTU1IbFJlU2tZTms3WXMwL0RkcUp1aVRzRGU0VUdEVmlZ?=
 =?utf-8?B?WXZXbnp1SUdtTGRuT21RcTZDSUM2Q0RTSkRhOTZtcUpzMVRIVWpZSFpkYnJ4?=
 =?utf-8?B?ZjVtZyt0akhoQ0xKYWUvY2kxYkJQc25vbHBXNm9hN1NCOTRuaG50QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54182e50-8e83-4d80-8694-08df2212d08e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:27:11.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vK5BM2uNB9oYPLn9DCEcFeNj3/jQAZ9zedsG8wmqiO1vKZRZPizSecoLPUGP7qQuSRhPs0HzidXSp3/sVyKrRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOEP123MB317428

On Sat, Oct 03, 2026 at 01:34:01AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Will this cause build failures on future libtraceevent updates?
> 
> The commit message mentions adding all enum values of tep_print_arg_type to
> satisfy -Wswitch-enum. However, because tep_print_arg_type is an external
> enum from libtraceevent, any future updates to libtraceevent that add new
> values to this enum will break the perf build due to -Werror.

Good point. Explicitly enumerating all external enum variants is fragile
against future upstream additions. In the next iteration, this is resolved
by casting arg->type explicitly to (int) in the switch evaluation

> 
> > +		case TEP_PRINT_BITMASK:
> > +			arg->type = TEP_PRINT_CPUMASK;
> 
> [Severity: Low]
> Can this cause a build failure on older libtraceevent versions?
> 
> If TEP_PRINT_CPUMASK is missing from the installed system libtraceevent
> headers, this unconditional assignment will fail to compile.

TEP_PRINT_CPUMASK was introduced in libtraceevent 1.7.0, so building
against older versions without a version check breaks compilation.
In the next iteration, the transformation and helper are guarded with:

    #if defined(HAVE_LIBTRACEEVENT) && \
        defined(LIBTRACEEVENT_VERSION) && \
        (MAKE_LIBTRACEEVENT_VERSION(1, 7, 0) <= LIBTRACEEVENT_VERSION)

> 
> > +			break;
> > +		case TEP_PRINT_OP:
> > +			tep_print_arg__set_bitmask_list(arg->op.left);
> > +			tep_print_arg__set_bitmask_list(arg->op.right);
> > +			break;
> > +		case TEP_PRINT_FUNC:
> > +			tep_print_arg__set_bitmask_list(arg->func.args);
> > +			break;
> > +		case TEP_PRINT_FLAGS:
> > +			tep_print_arg__set_bitmask_list(arg->flags.field);
> > +			break;
> > +		case TEP_PRINT_SYMBOL:
> > +			tep_print_arg__set_bitmask_list(arg->symbol.field);
> > +			break;
> > +		case TEP_PRINT_HEX:
> > +			tep_print_arg__set_bitmask_list(arg->hex.field);
> > +			tep_print_arg__set_bitmask_list(arg->hex.size);
> > +			break;
> > +		case TEP_PRINT_INT_ARRAY:
> > +			tep_print_arg__set_bitmask_list(arg->int_array.field);
> > +			tep_print_arg__set_bitmask_list(arg->int_array.count);
> > +			tep_print_arg__set_bitmask_list(arg->int_array.el_size);
> > +			break;
> > +		case TEP_PRINT_TYPE:
> > +			tep_print_arg__set_bitmask_list(arg->typecast.item);
> > +			break;
> > +		case TEP_PRINT_DYNAMIC_ARRAY:
> > +			tep_print_arg__set_bitmask_list(arg->dynarray.index);
> > +			break;
> > +		case TEP_PRINT_NULL:
> > +		case TEP_PRINT_ATOM:
> > +		case TEP_PRINT_FIELD:
> > +		case TEP_PRINT_STRING:
> > +		case TEP_PRINT_BSTRING:
> > +		case TEP_PRINT_DYNAMIC_ARRAY_LEN:
> > +		case TEP_PRINT_HEX_STR:
> 
> [Severity: Medium]
> Does this skip the AST traversal for TEP_PRINT_HEX_STR nodes?
> 
> The fallthrough here prevents the recursive traversal of arg->hex.field and
> arg->hex.size for TEP_PRINT_HEX_STR nodes, which share the same structural
> payload as TEP_PRINT_HEX. Nested bitmask evaluations inside a hex string
> length or field argument could be silently ignored.

TEP_PRINT_HEX_STR shares the identical struct tep_print_arg_hex payload
(arg->hex.field and arg->hex.size) with TEP_PRINT_HEX. The next iteration,
TEP_PRINT_HEX_STR is grouped together with TEP_PRINT_HEX:

        case TEP_PRINT_HEX:
        case TEP_PRINT_HEX_STR:
            tep_print_arg__set_bitmask_list(arg->hex.field);
            tep_print_arg__set_bitmask_list(arg->hex.size);
            break;

> 
> > +		case TEP_PRINT_CPUMASK:
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> 
> [ ... ]
> 
> > @@ -4908,6 +4979,8 @@ static int trace__replay(struct trace *trace)
> >  	if (err)
> >  		goto out;
> >  
> > +	trace__init_tp_bitmask_list(trace, session->evlist);
> 
> [Severity: Medium]
> Is --bitmask-list broken for pipe mode streams?
> 
> In pipe mode, the event list is populated dynamically from synthesized
> events during perf_session__process_events(), which happens later in this
> function. By calling trace__init_tp_bitmask_list() here, the initialization
> operates on an empty evlist, skipping the AST transformation.

In perf trace, file replay (trace__replay()) expects to read from a
recorded perf.data file where the session header (including event
descriptions and tracepoint formats) is read upfront by
perf_session__new(). Existing tracepoint setup in trace__replay() already
relies on session->evlist being populated prior to
perf_session__process_events() e.g. evlist__find_tracepoint_by_name() for
raw_syscalls and syscalls.

Doing this transformation once during tracepoint setup avoids adding
per-event checks or lookups to trace__event_handler() in the sample
delivery hot path. The commit message has been updated to explicitly state
that, as with existing tracepoint replay in perf trace, this expects the
evlist to be populated from the session header.

Kind regards,
-- 
Aaron Tomlin
