Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AB3E8328;
	Fri,  4 Sep 2026 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560097; cv=fail; b=pxUL8fkCazsFRpx2UJeSbhIkA/tv20Il+1a88BDRVT9dlYzvKrdLNtpxL2e25dB4qjgSqxxt5G1i6PMeY1e7USVoITCHqF4uqYNLy+vW44c1yEr1rMlJPGUdaFbkkzU5y3Rfje6hc/d2RjEo95lU5PkfnsnGAAKoVoNtb60ODP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560097; c=relaxed/simple;
	bh=ZRV+wScB1FdhH95ReVlNHM+rAC4QQ2WBEXNOGHRNUAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VD1JFhr5uGP8G9hMaEDvzU9GN4FCdWK4e/wle8kQbneM7MnPGokTGtJLR9dP/cPm158dUqb49ZEM0lQEO4vCBrANZsngEmqyDQyQ29wJP2hN8V9JUscdoPw7hPfd8yU8rPmzXTXUVKclJi7FLcLv9cW77/bdpIuBYvQHqFrNgIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po+Ri2LTCG8WVA/r615JU1DVIxAEzsxFFoGp22+ZNzNwM19s5OPF6HMsb6xTm95AoMiEfslUOtlX2M75XWcyoyZWwcxxSKA6OoN0V3s4ivXd63YO1vjKzEzbRnSqdWJ3TByOLOBSp0SJKj0TnYYCVowA1Rq6WOY5gVi+Grrkbbccjzs0vNWkx3lZBUQjj3Uk7lsi6bGX3DshheBNASwUNMeFZR8mi2Lj7qqPocNQNlZKvIJ4s6ZpLHPaskOTwynhk9Ns7GWMbBsydmIVHDHVWWcjRMDhKWoWlQVAnwW+61CpX3LISXaeHyyeqMtGNk0oCKL8M2vWxBGihDO2ttgpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=c3fj/mWpr+GPNXRfbzIZ6nsQ4WJqa2L6kKSvr96MaLU=;
 b=NvOJA0AWEjnuoaWwPDBxfpaNUvgI85blMUg4YiOUb5xwTD+VxE/21Ph0UtROuFvjDcnyHWp0USGHRpT74yVZgX2h3CBCwYABKGvmG3HjR+F+MTsreCNS8nSXewqy3fL+z69HV/du62WGkY+BWmvOnZi4RHC3GVWRbRZFJPT58+OecevWIfL61q59owoJGcRd4tnqi1SNRsuVWwAWD0QCGYwr+lEfUZdSJVuuAlsZU5kIsOPX9NnhYh5etyFps+YlduTm30aiqNNWPuGmikAqymSQDr8S/3G+D55g3uSd1u6H858uFZ9S0D8fP93A70BwX5iHobHO3dCjv2GAg3Z6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB7757.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 22:14:51 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 22:14:51 +0000
Date: Fri, 4 Sep 2026 18:14:46 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v6 1/5] perf trace: Fix error checking in
 btf_struct_scnprintf()
Message-ID: <lcxkwl3r7udjsnotta37ccy2ywxrsapchyfelp6ne3nqhwdjxb@azgez4whasoz>
References: <20260824133122.751733-1-atomlin@atomlin.com>
 <20260824133122.751733-2-atomlin@atomlin.com>
 <aps1gjTwaMbDNQWa@x2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aps1gjTwaMbDNQWa@x2>
X-ClientProxiedBy: BN0PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:408:143::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: c769d859-d5db-42ee-d26a-08df0ad1f059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b9p1NkP2Ox40D4VqCM+712UUHTkVXMmf0dl3ZQE7xBnaloBe6KfngI0EGD7qJvJG5pLOU5ltip822LCH/l+EEp2etc4wPlm4Sr7uEv49316c6QBaxOo9IlGjAOdgeI+NfTs/F4LwQyCnRMs9mjmjJnlFc8Ntb0jFgNOmWCwKYLcRMc0kThw7YRjX/bCm+gIxhO5pLfFZ2aXuPgZ+4VbB6x5v+dQoHv6xP48inUX8KCmoTVwokiHYh+bRCYSeiXOGaXZoR3gLa0flZgJGCJ64dnms4T+iAbWM3M5WkhpEZ1ymjr+8oNX4NhqRQe7MPlwvifl6Bg5WWG0Z+ZjVQ0zVF02pNxAxkANCqnS+qYcnSZQhjnftXcth38kWpnB+6PenDCqWEbf/tKlHX7S2DaoJSscF2c7U7zg97XlahKVuTuAWAaartLtM7MWEwMQ3b/2OsfXFDtH+lUmni05U73t+nh8N553iY3ycVXFfTeiWT/d+/TKaFjFkr8iJkcFV7YU7HHsFSGhiy58rD+u7yTS6KtyIl5EK86qJo1y1sKEjDLXplM8/rXRNu60Q2frazB1dfuM17wuPymcYqs0KH9Yj1490uy/LZpao/HceGUsK4gQMNnO7MLZFF18VtT7na6pSW+3+Ya3fkVL1HFCNJ7FErKvsmYOzEe5Xz6/l6fr1k2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVJOLzdlUjdNdnc1S0Y3a0ZFUHlxUEJHZnVOaFZUeTFjVXphZHNkNUFwZ3V4?=
 =?utf-8?B?MEFlY1hDUTFPSGZiV1FRaTFhS21SM1o1aXBnaHJ4aVZGeGNxNGQ2QzhwT0tS?=
 =?utf-8?B?RGoxaVFTQmFCTmpOaW5GVUoyZVNzSmY5K045TDZzNWdCbXFUU1IrNi9YWWxM?=
 =?utf-8?B?WlBYVVBMWTFsb0I2U1pnRFdPSFg3ZFBRNTFScUg4anVFN1lTeEVFR055Vk81?=
 =?utf-8?B?MTFmbkhwam5yMzlORzVmL1RaUFo5VXVtak1ZT0tCNWxnS0NzeFVXS3lWZUF1?=
 =?utf-8?B?VjVBL2Z0Z3pHUmtaUUFsSFdjQ0E5STZzV1Vkc0NlNFZmQVFIZ1F3K2RmWXU1?=
 =?utf-8?B?aUVrYWM3b1NZSnlJTzJyNHBCYStKMFdVNE9neW1VVmdMbFV3Mi9tY2NOak1r?=
 =?utf-8?B?UTF2TTlDZVNPeHJEYmlmWnZiYjBuaHVHRk1lY2R4YnY0UjRYbTRUZlM0Mnkx?=
 =?utf-8?B?dGZvUlhkTVZEc3VCZ095L3Z6SExrRDNtU0hkcXVzOTc3TmthNTk2RVFMS3Nx?=
 =?utf-8?B?UXRtRWJPS3V6WjVzUk45N2x6RXVZWjBEMmRvRFR6SU04eXVyMGovNjd3bWhH?=
 =?utf-8?B?TC9BWDZxLzBLYm5qTXhYTFhBN1pNSHEzb0U3RTJ3QW5PQnlCemZqM2VXaXBL?=
 =?utf-8?B?UXl3RGVlcHF6SFgyMzRjQUtqWmIvNEsvNTk2clo3NFp3eDNZV0IvSStWUWxx?=
 =?utf-8?B?WDdKQlFnc2ZpVlI1QXBiN29JVE8xOTlGVHVnTnN1cUFwRzVoMzVOdHUvZzV0?=
 =?utf-8?B?bmZaaHZSaDVLdWNOa3QvY3d3Z3hVb2FtWjdINjdKOEVsUEJSQ2FTcWlaazdv?=
 =?utf-8?B?dXFWQUE0bDd3ek5mRGVBM2JUMi9hUS9Jb3hEN3pPWWQ4RmVjRGhDcG9MRnNh?=
 =?utf-8?B?U1ZvdWIxdnNDd0tlQWxVQW92UDQyeFRzanp3QitGTWhMaSs0MWlmZWN1cXUv?=
 =?utf-8?B?Tll3Sm9OaFQySG5BZldGZTdGeElDYVV4d1pqQTE4TmFlc0V1c2tUL0NEQTNo?=
 =?utf-8?B?TFA5dkdlUW1taVhDY0piZHhRSmRnczI1dnJwTE82ZjdrTE9iaU1pUG5FTzRG?=
 =?utf-8?B?cVhGZnV0T1JsT09SQW0rdndoRFpRTmhGeUEvV0ZJOFR6cE8zQktoQkRvWmJ3?=
 =?utf-8?B?WHBFQXZ5bXFXMEZCRUN6YzhwV04vcE5acmFWcFdmekg2bkR4aU9qK05LWVg4?=
 =?utf-8?B?UEdZMkU2WVlQQzBMdXBXUmdrVXYwZ2E4K2dpQzlyOW1CK243TFZDT05OYklv?=
 =?utf-8?B?Wjc4T09xdGR4VHBzVmI1WVNBWkRjTFhVczdHbG5NYmYyZmppMFJoNmZqUzMz?=
 =?utf-8?B?RDJwYUJQM3FuQjN6UWJVZk9GUVhOeDBZSHk1aWJiaGM1RWJKWkEvZGRGYldy?=
 =?utf-8?B?T2NKKytNT0hJamZZcXFhc3cydnNmbUl5Wno1NXB0WlNYZzJoRWM0OW9aWG9R?=
 =?utf-8?B?QlFnM3FDU1RPRVhQSGxDeTVCT3RoU3E5Rm1MSUp5eGoralF4cmJmeWJ0cGY2?=
 =?utf-8?B?bXluS0tjWTNYLzBtOHN3Vmt4N3dNbUMrbnhZU1JyUnArWXhnRUQ0SFROTk1Z?=
 =?utf-8?B?cGRqZXBJTXMvMHM1cWJ2STEzcTVCb3NoZzZvcUZZMy9mbjgvY2drTXRvUU9V?=
 =?utf-8?B?QU1IVkNVT3ArNG9uSmg3VVB2aUJ1eWM0R0lzWXE0SWNNMC95bUhtOGl6NjRk?=
 =?utf-8?B?RWtJenNacmpMQjlLejRobWQ4ZVNubTRuWWR1RFpTcVJCQ0RPOSs5S3NKWHgz?=
 =?utf-8?B?ell3UDVzVmpLcWZ2cTJxUnF3VHdtVXFzd0pkeTQzLzJ4ZUFCcUtvOWxpNE1o?=
 =?utf-8?B?OGN5c2JOaWRmaUVkZ3dBdFhMVVNpNk04TTFFRy9vRVR3dFRkS3JtbG5HUHBu?=
 =?utf-8?B?RGtKMUFMekxQMlFjdGxpTkorTnYra25NdUh1OTlxRVJRSi9TenFwNkpxcDdW?=
 =?utf-8?B?M2ZjbzIrYXdiMjhYTStIY1VCMTFBb1JIR2Y3UXpvSWJBQUdtdUYzUUd0b3la?=
 =?utf-8?B?amQ0MUdzdDA5ZEF0dXZMelg3cEdxT2FJRnloWFJSKzYySVZrTndCTkVCQUtO?=
 =?utf-8?B?KzZFamkyNlIzVU13WlBZNllSeWpnc2dZeXN0RG5WRFBlVzBKenZwZ2ZYbmNK?=
 =?utf-8?B?MUo2STBHRWZ4NGQ5VFN5bWFqWk5sMVRoZ3RjV0NYOEFKWmp4ekovWWxSai9u?=
 =?utf-8?B?aEpsbTVVRVdWL1VVc0FtbDdyaDB1U3pNNXRwY09ZeE9jSEZCTGhOSGtXY1lv?=
 =?utf-8?B?Z0MxdzhIYXBmZVdrT2htZHdmWG1BTlo0RDdpbjBuNDZWSDdqNW9kQk56UmNS?=
 =?utf-8?B?MFI5ZVFHUi9YUzl5Y1lZMmNINklnbkZKeTl1V2R4QmdGVFREQS83UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c769d859-d5db-42ee-d26a-08df0ad1f059
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 22:14:50.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeY5qOkn1JqVdqtPAouL78EVjhWR/r6I3ni7uW/fZpvEkQwHcp9T40FsKwUnzijPXlqKc1mGo6uMTMOExs2XNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7757

On Fri, Sep 04, 2026 at 06:17:54PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 24, 2026 at 09:31:18AM -0400, Aaron Tomlin wrote:
> > btf_dump__dump_type_data() returns the positive number of bytes dumped on
> > success, or a negative error code (e.g., -EINVAL) on failure.
> > 
> > Currently, btf_struct_scnprintf() checks if btf_dump__dump_type_data()
> > returns 0. When a negative error code is returned on failure, this check
> > evaluates to false, causing the function to proceed down the success path
> > and advance arg->augmented.args past the unprinted struct data before
> > returning 0.
> > 
> > Consequently, when syscall__scnprintf_args() falls back to the default
> > argument beautifier upon receiving 0 from trace__btf_scnprintf(), the
> > fallback beautifier or subsequent arguments read from an erroneously
> > advanced augmented arguments buffer.
> > 
> > Fix this by checking for '<= 0' ensuring that on any failure or 0-byte
> > dump, 0 is returned without modifying the augmented arguments pointer.
> > 
> > Fixes: cb32035214b9 ("perf trace: Pretty print augmented struct args using BTF")
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
> >  tools/perf/builtin-trace.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index c3c7f1f85c53..1bc39f674f11 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1066,7 +1066,9 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
> >  		return 0;
> >  
> >  	/* pretty print the struct data here */
> > -	if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
> > +	if (btf_dump__dump_type_data(btf_dump, type_id,
> > +				     arg->augmented.args->value,
> > +				     type->size, &dump_data_opts) <= 0)
> >  		return 0;
> 
> Applied the series, only change I made was:
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c3c7f1f85c530196..4c8f91f0f854b382 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1066,7 +1066,7 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
>                 return 0;
> 
>         /* pretty print the struct data here */
> -       if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
> +       if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) <= 0)
>                 return 0;
> 
>         consumed = sizeof(*augmented_arg) + augmented_arg->size;
> (END)
> acme@number:~/git/pahole$
> 
> As this source code allows for longer lines, having it like above helps
> in reviewing, we can see straight away what the change was. There was a
> clash a few patches later that expected that reflow to be in place, I
> adjusted that as well, no code changes in both cases.
> 
> Please avoid reflowing things.
> 
> Thanks for your work, appreciated!
> 
> - Arnaldo

Hi Arnaldo,

Noted and thank you.

Kind regards,
-- 
Aaron Tomlin
