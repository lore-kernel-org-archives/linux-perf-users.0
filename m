Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020087.outbound.protection.outlook.com [52.101.196.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8C4AF679
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327596; cv=fail; b=nnc2ydUDwhwIygCOtG3D/Zv6xdjZzSy4PUg+U+FyeWOviaMRTaaDp1xe1ZGdO9YNReDY6Rj/tld5g739FmaQjTGL4fL+nzC++2plZtNR7YV9ZJg7vCHy7isrg/03UEcAcMl7V8aH6SQ70PBvPqwsTmrZZKpipkepSoUETVgDj1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327596; c=relaxed/simple;
	bh=ZOxMXrnYCzvjni5el/Wl3HtVJIF6FCmfz8CmGECdeJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XKtJwzDbmZNybaChmxTF8ctSxczpwb339N1w+FEV6iW3fmvyErBZkr/ol0L8+iBLfn/8q6oQ9oxmjAGf5k3HQlGo2OFRvmQGgIUBNhY/SPWOg7ws/M3/4AR13h+VULCJTGc39Xnn2nGdIe3fzPY93Yq4fXcsiu7bjYm8loDGuOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7nWgc2h1MFnS3DyHAjIfPaVR98ImZYFEGdMO7zL+gGpHihLf4zyoQbaAD9S+9Psmp/c+yh6lX86HlZMhnRbiEEXiDpvNzrY/mDoFMczyWzId8c0qu6vRRWViJc7oRXYbS1TfM3KR2Aot8au9QIGMnW/zRBEqY2slm4UX0F02TyO+boxwA1M7u7OsBm/cfoW35sn9n5SxPkhigHfyiZkA/polLZoxxLMWDo1JACYATHmtjDy91h5Wk/GFyxS43944ChnBcQN2eWKEzO8RI73dgz9dKbvnbANigriWUAOea70BMsWBiMEiVzO5FSGPkYUt0tgwz0kL4pZdkiVTpt9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Fd3GvHJ3abvh8tTN/z/3DhQmR5YdFf3ykwhad4HerA0=;
 b=xpIKRVIO6Xaqq/xoBxeDiuSGTMymxzvRtBQ5mcyX17pPmbovBzWkfKlJjsD5TAtjswrzHbg5wItpLU8707kBBblE5bHzU5a4jkADA76mS/zR7Np3cRvtJVasdbdcNxjP1nuQK0OTevGhHDHuCUon26ndcMET6TddJ5HPiDQXCvSiQMtBzC0ON/GtUeXDJ4PFuTdzwLYa8r2K7mdNXEkKbWxBdXLOcwJIrx69GWe0xEUt0fZltYBHkUMc2il217NnA7dmyWjfiAGvYFK1oqZDPa0qqOdynrR5Ls4LasIB3OXDeWiAPnTAu4bZS5PNT5qdp9KDajHlYVz7UqeDfbCzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB4324.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Tue, 6 Oct
 2026 22:44:25 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 22:44:25 +0000
Date: Tue, 6 Oct 2026 18:44:22 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf ftrace: Support display of inlined functions in
 function graph tracer
Message-ID: <wazrk4noul2skfbguiqqimzhytpi4orzwtau2y2eduwjvd7inr@7mc6g4rrwh4v>
References: <20261005211518.26786-1-atomlin@atomlin.com>
 <20261005212707.824CE1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005212707.824CE1F000FF@smtp.kernel.org>
X-ClientProxiedBy: FR4P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5023e0-a2d0-4b45-7e43-08df23fb5ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4143699003|5023799004|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 q38CI02i/nCB2vQvS+O6ZCyNbBgFnQlW12BuGhzubDaE1A2eUlZbg057yFMmIU+rBjFztUY6ME1b5EdY7sn7pR/GTRgJ9OS/lzXmf2JV7u0Dt/sKFHQT1gTf4e+eEr5aUbjEWPYJzFIGln6IdpIhJoX1Yx2zEqMDPbf2SNBzN0+MPT03Jf9HZ7FQxNaETV6CcBoe8LOKtTS2gS6CRNbe2CNmb8CWmk4JSb4Qu9inkPjVMus9ZqGHriLV92OW22WcrfDR21aMTS0hV0Fde0i+oOMGP1GjUGUfyb4v2UwS1C+JpQli1KjYYSP3EnhTlk0d9T6EKlrJ4WDkkWpRY4eNbfl9TBOTmvD0RqOcD3BXDrDmdemGWtC1rETwbLnPw5AWNFG77KKHRg6bLJbT/GhVuwZqaAmzxls8CjnMvDNHx8WTbjEecb+ZEI5OIKskK228h24oLOUFWIpu6RSoojWrrPI61eT19yibYVGX+ZYbm+VCFM872TRZmgNgHZB6sXsMrGzYgRX4M2LfdFJgiqeC8nFqSlqTRMuYep7i077/dPfhjo9OFjlH/zfKp2xFZb0xFbA5kCcgI5jHviR204zFGTS1nvVSPOkdxmZwBDlX804=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(5023799004)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cDFTMDMxK2JRQ1BkRm1UelRaRmFwVWNQM2hleWFBUnFucE4xdEw1OVpWMTVu?=
 =?utf-8?B?QVo1U1VQOUpPd2VoY1hkQTJTWFFxVDZwYmNHbFlkRGpRN1FMZ2VPY252LzNQ?=
 =?utf-8?B?NFdVY0FlTzN0bVR4VURJbHdmNmtYQlFDWE1vLzFsMWZVWEVvenV0RkdlOEJK?=
 =?utf-8?B?eUt6ZlNVTFg2RU8wUUg0RU12czFvNHBrN3MwREFSa3BDdFEzVHJxSE9NbUM1?=
 =?utf-8?B?VmpLVmZDYXMzdXBRUjd5WGtXSFRxdDcySW0vR2xRdmpBSjluRkMremtUbmVs?=
 =?utf-8?B?cTVwL29NWUJzeDFLVUxDeDcrd2hsVmxGVktVMXBhSmdxd2R3RVgwcE9vcGNY?=
 =?utf-8?B?N1RMTGk1YXhMeEVaQS94VGE2ZEZQRHd5bThvbHNleFZiVGpHanNmVkprdXFl?=
 =?utf-8?B?eHc1V3lKSklFU2srSUFLRWhSV0xpY21kaWhYYStSMHZrdnFTZldVRmN2S2h3?=
 =?utf-8?B?MFVrekVkWG5HeFhCamJyQ2hsMFNKaFRjeTlYdit6ZFFUSzUwTU5xSkM5dTUr?=
 =?utf-8?B?VFpJSnM0UStObUd2aWw4OFhaeEZkb0tYVEw4VWUwaXY3OHA1TEkzSXhZZWlG?=
 =?utf-8?B?Q0tESlI4dWJaUHdLOG5VTnhuQ3VSb1Myb0N2bWNsS0xlV2dKRms1d0FWeXpT?=
 =?utf-8?B?a0x1UVA3Qy9BN2gxL0FyWUxHc0NoREtndlRxbmFObkJ4UWxZcHZDVTNWOU4r?=
 =?utf-8?B?emNOWEVvcWVJenRwNWJZQU9reFpEdHAvYTlBTFc0Q1dsaGJKSjZWUG4rSnJD?=
 =?utf-8?B?a2EyaTJ6YWN0T0FmL0kxcnowVUZPV1UxbjU4ei9KOVU2bWpYSUh3VXMvMHZq?=
 =?utf-8?B?N2hNODY4aU1LaUJUMGdxZmtobnJyajVGRVJNL0xGOHhQZEtoMTkzdWJZa3hV?=
 =?utf-8?B?dCtIS3RsbGNuT2tBM2xheEM2L2gzbGFjNlVGN0xIa0hHK1Y3WlJXak9uQWx1?=
 =?utf-8?B?blMwcFQzVFdpbm1aS1dzdGM0cGVPZ1FGOVlTbHhnOHFkc0pzRnk4S2NNR2Rj?=
 =?utf-8?B?b1VBblRtZ3krc0FmUjFTTlRHRU02YmY3NWdoL0FqQURhaWNVbUZ2c2hldy92?=
 =?utf-8?B?KzV2N0pBby8vdG1hSzhHRVRheHRsem9kTmFXdzlvN2lvRys5VmhPaEhjdzM2?=
 =?utf-8?B?bDVrY0d5bjkxYnBScUswYnYyekNPbVR4bDZWN3I5RWdjWFpjUWhlcXA3Z1Fh?=
 =?utf-8?B?VmovNnkwU21NYW1lYXhtSkhlTGVmcndKTkgvdzBHL3pPc3Ewd1h2SG0zUk5T?=
 =?utf-8?B?UGN2bFd5SjFqVTE1Q1VPemc1ZUxHLysyQ25HTklQY0thSUFQaU9JRDNHb29m?=
 =?utf-8?B?TXgxY0I3RU5rRlcwOE9kVjZoQTUrSzFRaUJWQVJOTDc2VjhuNjRVclo2bGNo?=
 =?utf-8?B?TDFJVU9ieFVnanNNT0hSQW1DeW5HL2VwbG5mS3J3enBkOE5WR0hoQ3haL3Zj?=
 =?utf-8?B?YnpxR3F1bjVURVRGUUZEOEFCS1lteVJZYTNLaWoyUGhkY0pyNGRaQmh3bkY0?=
 =?utf-8?B?YjlaakZWdXVLQk1yR1dVSW1waGNxekRrMS9pV1hoR2hWOHJmcmRYZXJNSTlr?=
 =?utf-8?B?bFF6STIwRWdyRGRJNmRnQXVaN0h3U1ExVWx2b21lT2V2U0tPR242MmJoZ1Ft?=
 =?utf-8?B?YUU5cFR0UnArZ2tHOWNCendlTy80cjArTlpZM2YxYi9DdmE3d0NlSk9ldXRX?=
 =?utf-8?B?UVFrSEVpd003LzRjOUhLTUp3TWROdTJyOVYzTmpnallETnF4WDM1ZUxoajUv?=
 =?utf-8?B?YlRXSjNUSE5kR3ZIQmxPcUI3VFdhMlQrOXJ2VmUzT1JTcFQyMWtjcjJBZTZu?=
 =?utf-8?B?OWsyZWErTW1IbHlJdzNCRVB6bEJyYmdWWVkxNlJMTmhlTWZCcnhUam5XL3Ra?=
 =?utf-8?B?ZGRMalBhTFpTVDBobWRMK053aTlLWG13SmhPK2xuTFFDZU5CYm13R0NlVDFF?=
 =?utf-8?B?Y2hsRjVkb29LNnhQK05sOWthZ3Eyd2NuNjVWekxERm1RUnIvbzY3K0E5b0Zk?=
 =?utf-8?B?WmxxMDBIQzZMOFZYdEorbW5oWm5zM2czVllnT2hMTURGVmVPVlZ6Rksza0VS?=
 =?utf-8?B?N3NCRzhIMEVVRnJYQzAzUkt5c1NkWE42TExoNFJ6UmpFWDFGemxyeUQzaGY4?=
 =?utf-8?B?VHVHSUVvcEJXNE5aSlMrTjAzQUo5elBxcEtaM0N1VnRnZ2V2U1ZYZ3hudXdm?=
 =?utf-8?B?aklYdHpjUnJZWGovdmZCeXFCaXdmMnBqVDBreG5FWlVQVjZGRUtCdnlvUWNo?=
 =?utf-8?B?TnpzQUtnOGliZXQ3NWgwMUYwRWM4U3IxUzl2MXdFUHZRNnRtYS9tUkxINnBw?=
 =?utf-8?B?NXJzaTNHdGdqeUJRK1RqS3lpWVZGNk8yU1dCbDNjQUxDZmVKWXVCQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5023e0-a2d0-4b45-7e43-08df23fb5ef8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 22:44:24.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUdI5RJcJyqUga/MrbObFFIXbGXopHzGaZw79UeYLFk03p7fwhh6hqI9vz4ojsK+iZda3/JYOOiRd5jQCE1wTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4324

On Mon, Oct 05, 2026 at 09:27:07PM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > [ ... ]
> > @@ -810,11 +829,24 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
> >  			break;
> >  
> >  		if (pollfd.revents & POLLIN) {
> > -			int n = read(trace_fd, buf, sizeof(buf));
> > +			int n = read(trace_fd, buf, TRACE_BUF_SIZE);
> >  			if (n < 0)
> >  				break;
> > -			if (fwrite(buf, n, 1, stdout) != 1)
> > -				break;
> > +			if (ftrace->use_inline || ftrace->filter_retaddr) {
> > +				for (int i = 0; i < n; i++) {
> 
> [Severity: Medium]
> When the trace_pipe reaches EOF, read() will return 0. The old code handled
> this via fwrite() != 1 which broke the poll loop.
> 
> With the new logic under --inline or --filter-retaddr, if n == 0, the for loop
> is skipped and the outer loop doesn't break. Does this cause an infinite
> spinloop on poll() when ftrace reaches EOF?

When read() returns 0 on EOF, skipping the line-buffering loop without
breaking would cause poll() to immediately wake again and spin. This has
been resolved by explicitly checking for EOF (n <= 0) upon read() across
both the polling loop and the post-tracing drain loop:

        int n = read(trace_fd, buf, TRACE_BUF_SIZE);
        if (n <= 0)
            break;

> 
> > +					if (buf[i] == '\n') {
> > +						if (ftrace_process_fgraph_line(ftrace, linebuf.buf, stdout) < 0)
> > +							goto out_close_fd;
> > +						strbuf_setlen(&linebuf, 0);
> > +					} else {
> > +						if (strbuf_addch(&linebuf, buf[i]) < 0)
> > +							goto out_close_fd;
> > +					}
> > +				}
> > +			} else {
> > +				if (fwrite(buf, n, 1, stdout) != 1)
> > +					break;
> > +			}
> >  			/* flush output since stdout is in full buffering mode due to pager */
> >  			fflush(stdout);
> >  		}
> > diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> > --- /dev/null
> > +++ b/tools/perf/util/ftrace.c
> > [ ... ]
> > +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
> > +{
> > [ ... ]
> > +	if (is_exit) {
> > +		char exit_name[128];
> > +
> > +		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> > +
> > [ ... ]
> > +		/* Close all inlined frames above match_idx */
> > +		while (cs->depth > 0 && (match_idx < 0 || cs->depth - 1 > match_idx)) {
> > +			if (cs->stack[cs->depth - 1].inlined) {
> > [ ... ]
> > +				cs->inlined_depth--;
> > [ ... ]
> > +			} else {
> > +				break;
> > +			}
> > +		}
> > +
> > +		/* Pop the matched real frame */
> > +		if (cs->depth > 0 && !cs->stack[cs->depth - 1].inlined &&
> > +		    cs->stack[cs->depth - 1].name &&
> > +		    strcmp(cs->stack[cs->depth - 1].name, exit_name) == 0) {
> > +			free(cs->stack[cs->depth - 1].name);
> > +			cs->depth--;
> > +		}
> 
> [Severity: Medium]
> If funcgraph-tail is disabled (the default setting), function exit events lack
> the trailing comment containing the function name. This means
> extract_exit_func_name() will yield an empty string.
> 
> Because exit_name is empty, will strcmp() against the stack frame fail,
> preventing the real frame from ever being popped?

In the kernel's function_graph tracer, funcgraph-tail is indeed disabled by
default, emitting bare closing braces '}' without a trailing function name
comment. Because extract_exit_func_name() yielded an empty string, strcmp()
failed against real frames, causing them to remain permanently on the call
stack and preventing inlined frames underneath from closing.

To address this, frame matching in ftrace_process_fgraph_line() now
supports both formats:

    1.  When funcgraph-tail is enabled (or comments exist), it matches the
        innermost real frame by name

    2.  When funcgraph-tail is disabled (exit_name[0] == '\0'), it adheres
        to standard LIFO call stack semantics and pops the innermost
        non-inlined frame (match_idx = cs->depth - 1)

> 
> > [ ... ]
> > +	/* Open new inlined frames */
> > +	for (i = common; i < num_inlines; i++) {
> > +		int entry_indent = leading_spaces + cs->inlined_depth * 2;
> > +
> > +		if (!inlined_names[i]) {
> > +			pr_err("Not enough memory\n");
> > +			for (int j = 0; j < num_inlines; j++)
> > +				free((void *)inlined_names[j]);
> > +			return -ENOMEM;
> > +		}
> > +		fprintf(out, "%s%*s%s() { /* (inline) */\n", blank_prefix, entry_indent, "", inlined_names[i]);
> > +		if (cs->depth < FTRACE_MAX_STACK) {
> > +			cs->stack[cs->depth].name = strdup(inlined_names[i]);
> > +			if (!cs->stack[cs->depth].name) {
> > +				pr_err("Not enough memory\n");
> > +				for (int j = 0; j < num_inlines; j++)
> > +					free((void *)inlined_names[j]);
> > +				return -ENOMEM;
> > +			}
> > +			cs->stack[cs->depth].inlined = true;
> > +			cs->stack[cs->depth].indent = entry_indent;
> > +			cs->depth++;
> > +		}
> > +		cs->inlined_depth++;
> > +	}
> 
> [Severity: Medium]
> If real frames are never popped, FTRACE_MAX_STACK will eventually saturate. Once
> cs->depth reaches FTRACE_MAX_STACK, new frames are no longer pushed to the
> stack, but cs->inlined_depth continues to unconditionally increment here.
> 
> Does this cause infinite indentation growth, since cs->inlined_depth will never
> decrement on exit due to the stuck real frames blocking the popping loop above?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261005211518.26786-1-atomlin@atomlin.com?part=1

Indeed. Once the call stack reached FTRACE_MAX_STACK, new frames were
dropped while cs->inlined_depth continued to increment unconditionally,
leading to unbounded indentation growth. This has been addressed with three
safeguards:

    1.  Clamping inline frame generation

        If cs->depth reaches FTRACE_MAX_STACK, inline expansion breaks
        early, preventing synthesis of frames that cannot be tracked.

    2.  Synchronised depth tracking

        cs->inlined_depth is now incremented only when a frame is
        successfully allocated and pushed onto cs->stack.

    3.  Underflow protection

        cs->inlined_depth decrements on exit are guarded with
        (cs->inlined_depth > 0).

-- 
Aaron Tomlin
