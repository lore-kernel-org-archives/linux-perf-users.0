Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020109.outbound.protection.outlook.com [52.101.196.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632BB3B0AD3
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787524111; cv=fail; b=KYLVDDQ9twnDFHukAG7xy6pdYZQ9Zyc+t2BprO+YZjfcZAUfRfigJ6J6vbNQIH0YDh9zSTFqMVJhQN836xKkzm+6UGiIXUpjg0ajYAXcfVjq+EzYg6QDkczdsBYs4PduUf1AR23E8O8EQgJRffWfES2oMmxB0ElXFueUgPeWWCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787524111; c=relaxed/simple;
	bh=JTcgiiML2ouD4HcrSvCYGtq6D3Gvf0L6s9CeayRL3Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yh7U7vaQcy/zKuhFCAMXeqdDWmApWNun2EsSLenJ51PlCvcB/28cPIy4r16iD+Ukds0k8AQm/8BS3eflF+bASGsfhS3WU57KNeVvJi2WjT7edPqye290YeahjX+5zr4xQCo7xcfzCf0nSTPdeTtrVKP12i9W5GDzSwnpD4rFOcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voWvCbnHtab/+bfdBk+XK7wXxzVjnFMPVHxuwNeHFR6qr2hVlOO979tJ+nUvVp7ybWyVVVmm5Yntk8lOIRyfkJbD+1ZiZSjtBeXfux4y3SGwjBzS+D3ujsnMLGk++M9zR5dH4LvRH1KTtUc+WHYrC3sxL0e1Z3kI7VNLmZtxplmByTjKDSD95oXWYBrNe/p7FQyu/oUuY2yPvKRwkTlOyBy1A+pCzOhM79AtnbjAstcJr5+8SSypIJywxm/jcv5uj/7iwaSf56GeBRYZl1JkzA7Z+kkxdh4K7E8IP6ojiH1cKvcxJ4NEYSVg2hON6JmiIB8dFiiR5vurdDNN0qKgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=RNo7RKA2hVMOOJLzjPUlWZrET/TZT5dAWN3qCQs9JfU=;
 b=Vc01hrqgkCAIAAWkWcGywTHqPcyJ7lCcPEfISyOCCLnUaJwTcUXjMGjeoGuvuj85/FjhtXYygobebHImtsvUuM2p2aIXoi1ibu1l+8cpdf8dcGUqjodtUipxznA2BUiRF8TyXzzc9x8BHIq/gwURek+dbyLLi5NHIc/qNZnLEIzD+wcMTayHuxJ3NOpB3yV7RlnMAAs/5WIxCKoqJkfPh8/pYiqUBwsPTSdqEKG/EenIpZBbTGDXII8M+4dJCp54s7LnTtubSOfjaHM0B+LoZyFQ7dXTjGE5XbXQgyDn/F2yY/nm3Gnpt6kMsKyBwOhIXazLxf7E4pSQeS4qaeSe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB7025.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 22:28:24 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 22:28:24 +0000
Date: Sun, 23 Aug 2026 18:28:22 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev, namhyung@kernel.org, 
	irogers@google.com, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v5 2/4] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Message-ID: <uucootaojpdtdl3j5lovvepi7x3mp6wj5gev7s6eznvszlpjmk@ffoaimzow5pe>
References: <20260822213558.704018-1-atomlin@atomlin.com>
 <20260822213558.704018-3-atomlin@atomlin.com>
 <20260822214848.5D3291F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260822214848.5D3291F000E9@smtp.kernel.org>
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: d356a383-31a7-4e85-5aac-08df0165d83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ymq9lz2Yf5fDS7QWNlO//uaBzYSepJ+JefBkZrDHerBl2XDIw97OXdtgYQ/JRj3rksKfaFAgDI1hK0KwduARDka6AprynMo6JUYRxoxeu4MPIGjWaRMEfmeFRnpWA/dDqHWWY0Vqztj6FMOLISmFAzE1PrSohSeH6Nxc4CU7pVTnYvKkif7OMuQWBawv9900iNxATYCKNshFm2iMNsD5vLpuBBa4iAuX3JhoJhYKsBDSVx6ta6OekI7rsUKmwV0wpQUjNvvRMDZtEZcCL19pXgQ6EXqKCu/zl4qvxSnegA6HGTSjFcrcoLQwgjmig+Rq13hSxfMdwWUqAT9V/ApTLA94/2PtI7XGv//dRwqwaWIAt64olBYovuJU5wPe/5lB5hdlmZBDDtv9BTkOehfcG4z+1vR2FLkKSp3PLwNcxMno1lmG/l/QuoNXpY2/X2h7bk9BcK0hI8Ib1DG9ha0hbXVJOgtAxTeG6jXuMYF/UIp20rHukXTTQ3ZASYH78YKTwVgMnQ2qrmmoT1XFBA/lD1fxo86E5Pf4iVDzu/z6FycG+vaxD1hYZGT1cMP/t/qc6zsS/lbOd6BdbJKabZ+Wcs25kNdRMV2UVGJ9P7W58loQHng06CsFoqAoVDeVEruFL0UJbpOFPZzi3Wzx8BziUMYgV4npU6GydU1iMc0T4Ac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkZkTFlxdFBvMTJ6N0VhRmxyZDVNZGVScVRHRjFDZkpYOTdxU1BpeTBpYURP?=
 =?utf-8?B?RGVXK2ZpMXM5UW9oSDUrU3BpNkVoclVwTVV4UG9WbS9MRFA0aWNkZlJqYm05?=
 =?utf-8?B?SEFIcnBWT1o4bE00MGpnMWF0czEyN05XSjRHVERlcG9LMGxma2RUSG16eW1v?=
 =?utf-8?B?M3VwNEovOWxkakJTQm9Jd2lNYTNRRVdxNVJrNXZsMnpUKzlRQmlES2c3SFlX?=
 =?utf-8?B?akRGajZQNWdRdlVlOXdRWmRxK28rTll4a2lLb3Q5M2dxSFJKelMwbmpDMFFY?=
 =?utf-8?B?NnJWUkRyRzdHcFRCbHRTcU5uWVBpdXkzbC85UWVqZ2MrclloWXRqTHRZTHZ5?=
 =?utf-8?B?WVppempON2dEZ05GdGtrU2lKWVRyck91RGs0RlJmeTdjQUlSRnhyS1hGV2cy?=
 =?utf-8?B?QXJ1SFh0SzI0OHRFUkQzN2N6VmliRW4rQ3VsTllGeWlYbkszanlNVGhrT25k?=
 =?utf-8?B?a2VhMFZBb3RnejhhOWVJbEJ5MjhFSWVMcncxa2x1SHNoc0tsbzgvcEJmL0lE?=
 =?utf-8?B?dmVMQnE3V21OTW1XYTdiZ3JVaHdEQzhaeG54dTVENXNzdi9TWHBGeXhqWUMr?=
 =?utf-8?B?a0MrU1BuelZHeUxCNlFFVlFtTHNHaVVFU25Nblk2Z0wxWlB4R2RYSU5KbnJ5?=
 =?utf-8?B?UUMwZ0xmeXRKd1ZjNHR1N2dYdUhtaXdSUzF2a0ovc2dha0xubUFYQ0d3SUNr?=
 =?utf-8?B?ZGFQS2cvQklLcGtQSnc2Z0EyeGJVMnpheEYwNE1LMEk1ZkZaTCs1SFQyT2hp?=
 =?utf-8?B?MWhWUmZ3VU1WYUh2ZmRjMGZsaVdibUNJb2lmTHF5Tm1EaXVKQkNybEF6N2dT?=
 =?utf-8?B?SGlVejJ6eUdGTzhsZWdMT2EyN01JTVRYQzhXK0ZRZ2xBRTNqcTljMnNXN2dQ?=
 =?utf-8?B?MFVSd040cjl6citoSEpIOFh4cENvWjl2bTFpeVUvNVR3MlIwaGdLWFBQNWR6?=
 =?utf-8?B?OUl0OHk5S1V2RTc5ZktLOFJyNmZONEt6eWRueWVqeHFMVURhQUdmWXYvVSsy?=
 =?utf-8?B?WjVKcWpQVThPbjdBNTh1OXNZYkpRR3FoKzlhWEFGeUpoZ1FrVkNvWEdxbGo0?=
 =?utf-8?B?Y0ZtaVF4Q2gvM0VhYXlRVTJ6Nld1VjZyc3J0eXcxSHhPMXpaU2xtS2FRM0Zs?=
 =?utf-8?B?NFBjeEVHY0ZFWVFLblZKUnU3TWU1aVpsSlM2TURqZmdXZ3BWdjlXVWpJUlhV?=
 =?utf-8?B?NCs0VnNudmc2eGdKTWFQWGdwaHU2TWVpWkVoSTRQR0Z3RTFId0k3aUVmTmNp?=
 =?utf-8?B?eDNSNVZoc2NjaTh4QkZ5eENVM0p2Z2crWVk3MjI5K3VsajVrQ2hVdUpsUWMy?=
 =?utf-8?B?VTVSRC9ya29lSHQyTE5aRHRPVmZ0Y0IrWWxJRXc5aUNYeXd4RVNtR2w3bHFM?=
 =?utf-8?B?RTVFb3UxVGl4NUt1dU40VjJKS2Jrc01ZNVFwSWNOQ245WUdEVzNPajQzMzZs?=
 =?utf-8?B?dloxbThEcmhYS1pZb210Z09EUTVPWXNrMnVkcWE4NE0zU3pUdUNSTjk4ZFhI?=
 =?utf-8?B?WU1vYjZUZkJBK2VVQnZnM2lYMkg0Qkwvc0hEblBEM21pTXhyQmtOQVBTcXpw?=
 =?utf-8?B?VEFOZDJXclFyZTVPOVhSZCs4cHBCK3U2SU0xUWpqTitkWHU4Znc2L0V2OHJY?=
 =?utf-8?B?K3EzUnJtTXEwUEg2VkhRczZIRTVFbmpIOFlJaUg3S0VoVmcrd1BTWXdqQ0pR?=
 =?utf-8?B?QjRGb0NuM2NLSSt0RkM1TzhweWxENmRvUldZWjNaRUNwUFc1bEJIQktxVzFi?=
 =?utf-8?B?YUxUZFdXRXhNMU5sYjkxTm1TcG9VRzRoaGlxNUlkN3pYWll3V1U4RUtKcFNK?=
 =?utf-8?B?L3F0TVVDSFpJQjdoRXdwZUFMcWdlcUthNVJHamE2WnlLVS9OL0NOcHlIZFFi?=
 =?utf-8?B?QURjNHorY0dhWUdRQnE4dzZkVUFZQVZPR2VpUGd3NENTQktPakE1RVRubWpD?=
 =?utf-8?B?RDVRTnlqbmx4ZzlsbFZpSUQxN0o4dU1GTkxZd0k1bmtERC9vYjd4eUlTd1BX?=
 =?utf-8?B?dHlBWExoTFU3UG13eWRFKzhIUEZha3VuL2FHeG9kT3U3d3l5MW14YTZuVFF5?=
 =?utf-8?B?VUMvK0RjSnpyNUluZ1plMlNPY0duMDU5d21EczJwOW1zVTgyNGJRcXZsQk1u?=
 =?utf-8?B?NGg3OTF2NWdBcXN6dWdrMWFMZHp2ZnB2WFMrandwUVdiUytZa0p1R3dGSk51?=
 =?utf-8?B?anVXbURyaHNSaEp6aVd3T2VxL2M0OTZYRXAwUld2VytaaVVySWtwLzgzLy8z?=
 =?utf-8?B?NHZJWnRMVXRuZmtwZ0lqeUc2YTJvL2NwOG15OVRLaHhIZmROU2luTWxSL0FV?=
 =?utf-8?Q?Dlby9TKmb1I58JNVxW?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d356a383-31a7-4e85-5aac-08df0165d83d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 22:28:24.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+gtU+bpDM1fjpweoubLZMtGjakJlEq78MAE7VlSZ5s1feFafw0hcRjx8x940a+DKbo7Mnc8vhHHjGK2lnZFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7025

On Sat, Aug 22, 2026 at 09:48:48PM +0000, sashiko-bot@kernel.org wrote:
> --- Patch [2]: [PATCH perf-tools-next v5 2/4] perf trace: Auto-assign kernel symbol beautifier to function pointer fields ---
> commit 7d955fc9994a613ba6129e3ae693c4d493643489
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf trace: Auto-assign kernel symbol beautifier to function pointer fields
> 
> This commit enhances perf trace to automatically assign the SCA_KSYM
> beautifier to tracepoint fields conveying function pointers and call sites.
> It identifies these fields by their type signature and via a lookup table of
> common generic field names.
> 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> [ ... ]
> > @@ -2198,38 +2210,52 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
> [ ... ]
> >  		} else {
> >  			const struct syscall_arg_fmt *fmt =
> >  				syscall_arg_fmt__find_by_name(field->name);
> >  
> >  			if (fmt) {
> > -				arg->scnprintf = fmt->scnprintf;
> > -				arg->strtoul   = fmt->strtoul;
> > +				if (fmt->scnprintf == SCA_KSYM) {
> > +					int ptr_size = (field->event && field->event->tep) ?
> > +						       tep_get_long_size(field->event->tep) :
> > +						       (int)sizeof(void *);
> > +
> > +					if ((field->flags & TEP_FIELD_IS_POINTER) ||
> > +					    (field->size == ptr_size && !(field->flags & TEP_FIELD_IS_ARRAY))) {
> 
> [Severity: Medium]
> Will this size heuristic mistakenly match non-pointer integer and enum fields?
> 
> If a tracepoint has a generic-named field like action, location, or handler
> that is actually an integer or enum (e.g. 4 bytes), and the architecture's
> pointer size is also 4 bytes, this check passes and assigns SCA_KSYM.
> 
> If SCA_KSYM is assigned here, the enum BTF resolution logic located in the
> subsequent fallback block is entirely skipped:
> 
>     if (arg->scnprintf == NULL) {
>         ...
>         } else if (strstr(field->type, "enum") && use_btf != NULL) {
>             *use_btf = true;
>             arg->strtoul = STUL_BTF_TYPE;
>         }
> 
> Could this cause small integer or enum values to be printed as meaningless
> hex kernel addresses or NULL instead of their proper symbolic enum names?

So, some kernel subsystems (e.g., XFS), tracepoints define instruction
pointers as 'unsigned long caller_ip'; instead of 'void *caller_ip'. For
instance, xfs_freeblocks_resv_class:

 - File: fs/xfs/xfs_trace.h

    #define DEFINE_FREEBLOCKS_RESV_EVENT(name) \
    DEFINE_EVENT(xfs_freeblocks_resv_class, name, \
        TP_PROTO(struct xfs_mount *mp, enum xfs_free_counter ctr, \
             uint64_t delta, unsigned long caller_ip), \
        TP_ARGS(mp, ctr, delta, caller_ip))

Consequently, since there is no '*', libtraceevent does not set
TEP_FIELD_IS_POINTER. Earlier, I proposed the use of tep_get_long_size() to
support cross-platform analysis (i.e., 32-bit traces work on 64-bit hosts).

Unfortunately, a known entry in syscall_arg_fmts__by_name[], (e.g.,
"action") now falsely matches SCA_KSYM and skips BTF enum resolution.

Perhaps a combined solution:

            } else {
                const struct syscall_arg_fmt *fmt =
                    syscall_arg_fmt__find_by_name(field->name);

                if (fmt) {
                    if (fmt->scnprintf == SCA_KSYM) {
                        int ptr_size = tep_get_long_size(field->event->tep);

                        if ((field->flags & TEP_FIELD_IS_POINTER) ||
                            (!field_is_enum(field) && !field_is_plain_int(field) &&
                             field->size == ptr_size && !(field->flags & TEP_FIELD_IS_ARRAY))) {
                            arg->scnprintf = fmt->scnprintf;
                            arg->strtoul   = fmt->strtoul;
                        }
                    } else {
                        arg->scnprintf = fmt->scnprintf;
                        arg->strtoul   = fmt->strtoul;
                    }
                }

                if (arg->scnprintf == NULL) {
                    if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr") ||
                        field_has_hex_fmt(field, len)) {
                        arg->scnprintf = SCA_PTR;
                    } else if (strcmp(field->type, "pid_t") == 0) {
                        arg->scnprintf = SCA_PID;
                    } else if (strcmp(field->type, "umode_t") == 0) {
                        arg->scnprintf = SCA_MODE_T;
                    } else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstr(field->type, "char")) {
                        arg->scnprintf = SCA_CHAR_ARRAY;
                        arg->nr_entries = field->arraylen;
                    } else if ((strcmp(field->type, "int") == 0 ||
                            strcmp(field->type, "unsigned int") == 0 ||
                            strcmp(field->type, "long") == 0) &&
                           len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
                        arg->scnprintf = SCA_FD;
                    } else if (field_is_enum(field) && use_btf != NULL) {
                        *use_btf = true;
                        arg->strtoul = STUL_BTF_TYPE;
                    }
                }
            }

> 
> > +						arg->scnprintf = fmt->scnprintf;
> > +						arg->strtoul   = fmt->strtoul;
> > +					}
> [ ... ]
> > @@ -3404,14 +3424,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
> >  		 * Suppress it by default to avoid cluttering the output.
> >  		 * If verbose mode is enabled, ensure it is formatted as a
> >  		 * hexadecimal memory address rather than a signed integer.
> > -		 *
> > -		 * caller_ip and call_site are also expected to be instruction
> > -		 * pointers and should always be represented in hexadecimal.
> >  		 */
> >  		is_probe_ip = evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip");
> >  
> > -		if (is_probe_ip || trace__field_is_ip(field->name)) {
> > -			if (is_probe_ip && !verbose)
> > +		if (is_probe_ip) {
> > +			if (!verbose)
> >  				continue;
> 
> [Severity: Medium]
> Does removing trace__field_is_ip() cause oversized IP fields to be formatted as
> signed base-10 integers?
> 
> By relying entirely on the SCA_KSYM assignment in syscall_arg_fmt__init_array(),
> we depend on the strict size check:
> 
>     if ((field->flags & TEP_FIELD_IS_POINTER) ||
>         (field->size == ptr_size && !(field->flags & TEP_FIELD_IS_ARRAY))) {
> 
> If a tracepoint defines an IP field like caller_ip or call_site as a fixed
> 64-bit integer, but the trace data is processed as 32-bit (where ptr_size
> is 4), the size check fails. The field receives no beautifier since
> arg->scnprintf will be NULL.
> 
> Without the trace__field_is_ip() fallback, won't the default formatter in
> syscall_arg_fmt__scnprintf_val() print the raw kernel address as a signed
> decimal integer instead of a hex pointer?

Wait, currently there are zero tracepoints defining caller_ip as u64 or __u64.
Anyhow, perhaps the following?

    static bool field_is_ptr_sized(const struct tep_format_field *field)
    {
        int ptr_size = tep_get_long_size(field->event->tep);

        return field->size == ptr_size || field->size == sizeof(u64);
    }

And guarded SCA_KSYM assignment in syscall_arg_fmt__init_array():

    if ((field->flags & TEP_FIELD_IS_POINTER) ||
        (!field_is_enum(field) && !field_is_plain_int(field) &&
         field_is_ptr_sized(field) && !(field->flags & TEP_FIELD_IS_ARRAY))) {
        arg->scnprintf = fmt->scnprintf;
        arg->strtoul   = fmt->strtoul;
    }


-- 
Aaron Tomlin
