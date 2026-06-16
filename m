Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020129.outbound.protection.outlook.com [52.101.196.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3727BF93;
	Tue, 16 Jun 2026 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610373; cv=fail; b=QeEdF0kJGGp9qsr0FjAxi1xgNKfXuPcdo10ve9H3ZaN7mznHtTtpzBoFWLTDmK4NfQTWMomL48f9oHJ/hGPzqKndNL3D2a3WehJplKGB5LyPs50GJLFxVHcR0ISxghSoNdUIbcCvPydtJhOcveuT9S2Vcglwe3IRFvmubMkgi04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610373; c=relaxed/simple;
	bh=226vXcyYuCyRcXmWAooSNMTll2EDb/cjL7cElqUWgiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E1bFjSB9ac8wfBpyUktja8IHMHBQ4KfOvJykt6d/dJ6N9APQ8hJ7N7nv5wr+wJe3Q6Q3V5x+vJY1SjziQcyDVY8kahW/DtCG7z0XB/wi1HN7G/B4CWQk1oEOitF4fZwC7dIfG44spMxZqgX97OmIyCW75Kk1yvLkFmL/cTk+pxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7vgfCWByfJqKQ0t4bifZGBOmW0oQkB0n0d8mNJowg53Zz0KKfu316ZG19ra0YlKSqRp9TbvsRUPDMc6N2gzo9Hwl0GTUC8faRc94xKowBFgSUwVqCa2u5YU06r4GrErTN4VQWO3NERZF3Z7+xoBIOjoRjuoiLPp3AhNC6G0YqGIIGD0QFacfO95DiVj7oR7zHEiLcm2JIQZbBA0/cf9HmQ2spqg8OnB5uTf+W6GvGs+CKyoLHFY8nmHS4dn2QJgY716Jay/1h20jp2oV1pAUjG6kDK2kdnVkFSNYhFFFHkg4ZIR5/bEoJBTRGUH0Z2Ms+onSJ/DjHXDD7sC4ik3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=2yOqbcO1IUV2cQvJxrsd/6iEDgJy2q4xgr3dV2Acexo=;
 b=ck/oyJZgmuE7yr+02F/OGCO4nOU2wEDJllcDa91qbK2eUsLOhDUEu6u9cnER/zc8wIlpZWmGaXfhLvPVZ+Oc7kCnVL5LJd/4ro3h0PTWQgEBBsmhnJ168KW6EIjuNkmJDpbsqEI5dfdVJ12qyG20Bei2TGcgN36X5F052ykLGYBdw2a6Blk5WY12tsgHIYzbG0tAblTqcyeziagRsKkwVALlKj99xbJwfkBmtOi2SVdYiwWahIpsbZjkQ2YYwqNpxOYYotNzcsTHsSKfIgZbv67w77ah+1VqOSjrrT6dDwOHrC59Xf+ZrP2cuDrhJi7uIunfIyenEsX3M6l0SS51sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8555.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:48d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:46:08 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:46:08 +0000
Date: Tue, 16 Jun 2026 07:46:06 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Claude <noreply@anthropic.com>
Subject: Re: [PATCH 2/2] perf trace: Guard __probe_ip suppression with
 evsel__is_probe()
Message-ID: <3zd25ylkgypmxgnhhsih6x7iuclyol772gvgfuh4hs2w3ok4to@nrnbopov37kn>
References: <20260616013157.38960-1-acme@kernel.org>
 <20260616013157.38960-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616013157.38960-3-acme@kernel.org>
X-ClientProxiedBy: LO4P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 92869474-c718-4c01-33e1-08decb9cdaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|4143699003|6133799003|56012099006|6123799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	1a3bqLyycZgGTb4vFr0hfUcrj2JQjN7+6sZWavWfMjoZl+w3ToBhSdoHwZOWNniEjTsH3om0J2LTDwjWVP0Y3rqzZZW0OUFKms0R4+v3lJchdnbn4j0/bjDiELV4EE5i+lVnXY0svEyqS9g7gFFubbI7RlNHVbiv2Ajsyz+bOkXWrKIeyENOC3prHaVYdj1F2C7BDscSdku6edZwEM13SSjpkHwte/rNO92gEJvIElFPl1hb3N2a6o13Fo9xACN/Q+Ao7fCzfGfX1uFLgKLhsCwBXp/b82r6ivH+oxs+cDSgsvavZzyYrNQME8Cph+BZo+U4e5P0rrAzX/d0nD9nKkRuBYSniCkjTNj3fxbSmrhYm6gDQM3DH+rmkIQzwZCkS0BlpYe6gMzTzUueLxi+9kVyvS77t/9gq9dNh9n2XsxoHY0FfQnJr3X06REx3JBZJ/Nw5viK72o4BKrFWf0iYtS409c++MOZneCYqyoT2l7dxBlUpdax3ahM0lDsGgtdLJ48DNjHbPW7edzf2PqjP7BPcH+ZcOfhjI3CUcQbSOWF3jnbDw3E7wO+woAB7+XHOuGECOBsjGyw6bd2dW+8JQenn0Xli8dGMDDrlkRlaHEqy3XB4D8R83Aqz3KaPDc+rwZbvpE3OuxQBElS49bd3EAFfz6ZbYpcuSpXOJn4zMHJJqyBo/VASGSW6vbHSEtr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006)(6123799006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXo4ekxSS09YdWpvVkRXR2dIOG40bENNekNtSWxJVk1lVVlxak5LVlE2M0Vz?=
 =?utf-8?B?TnFWcmJqRTg2UjhRdDFLQ0ZoODFRT1RYcFZRMTI0REdVemdOVEgxRnM5OFZU?=
 =?utf-8?B?U3RjWUhrbnM4L1Btdm1CS2FpVkZTcmt4Q1pvTGdHQVBpZEFxSGlhRXRCMnha?=
 =?utf-8?B?enI1R3J4NzNCOXZ0bGExQjNtUG9Xdk1jclZzNDRqVmdhclVpWEVtMEttd2w3?=
 =?utf-8?B?TVpGcEZLWFRCSTREenJDeFcyZW5qWEZoRGk2TW5QbFh5OWsyTTdCM2NXYThH?=
 =?utf-8?B?VDcxL2NlMThCbGtaM09WTHZLVStMbnhYMG1ncWx1N1k4Ymo5dTY1WGRpdEMw?=
 =?utf-8?B?TllFRmZyVWJKK3Z2Zm1sa216Y0pDSWhnNEhrQVhxR3VzZUJubUF3SGJ6bWdU?=
 =?utf-8?B?b2lYZFpXTkwwcW4yWWpUbjB0WUM5M3JQZHlWMUEyQm9LVlMvZzZoeG54cVht?=
 =?utf-8?B?bU1LU1llZ1lUWUxhUVArTDlrMzhoaHNac09XN0ZLYVh4UnVmeVJ5SEV2WUhY?=
 =?utf-8?B?QnhrdjRJNXJ0L0VlYXZKdVhWTWRuaXBCQVdRK0pFeGhlOG92NDVQK2hYR2Fz?=
 =?utf-8?B?SThkeEJXcE5lSFAxTE9QRytyZEZmT2IyTzBteWdUNjJYSHRLRWxhcm1raWNJ?=
 =?utf-8?B?c1MyTmZVN2ptNFN4ZUZnU056b3pKb0l6R29lczAySS9BUkRiRWFHT09KSGxq?=
 =?utf-8?B?SXI2QjNYeHNERTBaK3YvRVA3M0dscHA4M2NuRVphUWJ4TXR5WjhaZ1pQK2E0?=
 =?utf-8?B?akQ0cWIyb3ZQSGM1Y016YlU5eDdpeTgyU09waUc3eGF2RDVrUVQ1U2cxd29K?=
 =?utf-8?B?RWRYQzY3UTFoREF4UUZVdnR0Y2NrVnJMZzN5VUkxZkpZRWxJTzg1OHM2T1Fu?=
 =?utf-8?B?dGxidG0yUmZCZG5jVjhkNFNPakNNaUpKdVNSeXJESm9mTVNUQU1yR0pUUmwv?=
 =?utf-8?B?UlhMTk1PVHNaVERucXhiQ1JFdWtmRHhDM3hsKzk3T2hDeTZ6MWcwZmJGYVRm?=
 =?utf-8?B?TU4zU0g5TXgvK3grM05INDRYbWZDNmV3a2UwNVZOeXJNVFdaK1cvcVJ5eERp?=
 =?utf-8?B?OXJVM1Z0NGhVSEVicFdwY3Q2d0J3WVgxTzBmRWJLYVBJQ2lObGlGWGtPMkIw?=
 =?utf-8?B?VEk4OUt2TFVJVWJ5WlRhQ2tFNTBmK0E4a1Nwbi8wMnZkVElxT0FZS2NmV3VR?=
 =?utf-8?B?V0hiQzE0S28wT095RGpicVptWEFEd1pSV1BJenQwUG81TGxWOGFKajBOeVIw?=
 =?utf-8?B?UEJHd3ZmRWtYc1lHSS9WM3Y4YU1qbm5WTnNnS0kxdkZFNVNNZ1RHK2gxQUFC?=
 =?utf-8?B?MDR4RE4xWjE2MEVCa25kRTJld25YZzlEeHUxeStWRGh1bktnSXJNekI3Yzgw?=
 =?utf-8?B?MGZWbXB0T0drRndTdXlNOUc5YTRuRUxRZlJ5N2tQWjhPdVc3UllXVGxQK3lz?=
 =?utf-8?B?b1NXa0tsdnlTaFF6WWE1cTNLZDNKREJMM1NZRi9tRzVRZUpaTzRNRnFPNWJN?=
 =?utf-8?B?V2g1RUlsbEk3MDhlS2pZUGhMZit4YVhWWDNTTUdCRUVyVVVkb0l0YXZkUkI3?=
 =?utf-8?B?ZUVHbXc4SzNONExXMnFTMTc3OVF1R2hwc1Z3bFZGcDQ4OUg0RzkxN3VwM0NB?=
 =?utf-8?B?S3JNMUgxQkxWNW1yMkhpZFpOQjc4cnhvWitENEp5djR0RU5SNHpyWnUyQk5q?=
 =?utf-8?B?RnU3U0FDalI5VTB6THY2RGNHQTBBc3lnK2dnSUJ3cVB0cmNKUmQ3K0ZnUXIx?=
 =?utf-8?B?K0NHNWxEQkxnQU1BWHptTnV1UklzVkNJWXVLTU5vdnVDSVBVelgrNERrUVdL?=
 =?utf-8?B?NzZmL0VZVXljbXd6bHppQ3IwMzlyYTdvWExmbmc3R1VOc2VHbTFtd0JNZGpw?=
 =?utf-8?B?VnpXNGc1REZ4Nk4wRXplQlQ4emNIOUl0Y1BRcnhjRnRJWElHRHZ1emxhTHRR?=
 =?utf-8?B?UFk0UHNjN0hudzdFUWU2ZFZRamNYZ1FzL3o5Y2xhLzd2S3dPckJ4amNpMmVz?=
 =?utf-8?B?bFBMd2E1RFYzSTJycTdmN1ZuUzJoYzV0L1htV0N0WmEzTUQrR243WXE5MjdT?=
 =?utf-8?B?SzR1WnNaa2NXWEgwbEM4ckJwYlhDYXMzY1U5Rk9idHdZeWN1eDdXc01ndTdl?=
 =?utf-8?B?Q2N6QThNbjAxQVlabThOU0c0bk92aWFvMXljcXBIeG9BVFB6ak1SM1dha21W?=
 =?utf-8?B?NWdUNVRZTFo5YTFTS3dsWVJmTGthczFBak5MdGNzSXJUT1FLbzhwRjJENWQy?=
 =?utf-8?B?L3hnOTRmSTRuTm5xTzBsN2lPRXV0WGRBZXFoNW5ZSC9heDBNWlhwWjhDNWw5?=
 =?utf-8?Q?UdInK8mwtZPBaa9mRQ?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92869474-c718-4c01-33e1-08decb9cdaa1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:46:07.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjd8R7z2Gda0wRq/leBLz5WusDerxzvec6BRV93zROHRDdlWQDM8Zs3aOFU1FI9eM6jxLudzfqPXA5Nwm6+awg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8555

On Mon, Jun 15, 2026 at 10:31:57PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> trace__fprintf_tp_fields() compares every field name against
> "__probe_ip" for all tracepoint events, but this field is only
> implicitly added by the Ftrace subsystem to bare dynamic probes.
> 
> Add an evsel__is_probe() check before the strcmp so the string
> comparison is skipped entirely for non-probe events.
> 
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Assisted-by: Claude <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index a8492da23a9cc178..57f3f14c5d435805 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3267,7 +3267,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
>  		 * If verbose mode is enabled, ensure it is formatted as a
>  		 * hexadecimal memory address rather than a signed integer.
>  		 */
> -		if (!strcmp(field->name, "__probe_ip")) {
> +		if (evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip")) {
>  			if (!verbose)
>  				continue;
>  
> -- 
> 2.54.0
> 

LGTM.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
