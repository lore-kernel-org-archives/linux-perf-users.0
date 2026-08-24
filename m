Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021136.outbound.protection.outlook.com [52.101.100.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C22390603
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570907; cv=fail; b=ufVi6wodZE0L7c42t1i7utp5KLp3oOG96hdBO4LOdo4Ab49bnkuoK3sy3tV9pfo8Rz4Yeb3Jv26Xdbm26XFtbMgzmuv5/tkIQdGTVqjvfVxhbuQ6ASz7W+spPKZO/CYwZjDN1b7JLfxsd+ME1TiDI2IwDmnp+ecSXKttjzFpJ0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570907; c=relaxed/simple;
	bh=OW7V9wNGjhP4uu6xOFPyuXjow8C+4prEo3nU1I0wAYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MDrRcdmMpGACMW2ICULdAgTR2rS6HTzJ2Pw2qy2JBcvkEy5MrBVFkvIIebQGaIWdI0dFKiY+i92osT/4IEOCivpJZVzClKFfTQ/+lBVEZgjowAY2lsGn1OzUc50m0FKCYcN/0zikdOHReIxjCgTeACTliiZFqXCyRjB+OINuLBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kokSGfyWCNaIJzDyw2HDH4QyzbcaR8/i03uxKR+M3Ed/xtKECOdcIK2XGR7zwZ2ITeBqZ2r/mwjcQrYYa0FkKm5W28WLFrcfdB815Lfv7zxhQsFRyKa7BLV72nIdtgbSWSFnqDFVRqVFxqu2SmkZd6LS6sWfb5f3tWbS5Xm3TfazQ7s09oMO2wNkmH3v2XfuswBGsrsInbi24LQPihxqEQvWPwEJAQ4YDBBiEGlGPXiCH3r9wkE3zPIPW/YBvJjwe18vnY1Jv+ZVYUNTE5Wvc+kXi6oS7MImTBNbbGDjVk4SNAWqYPParqnLTnW6kO86N7A5aTfmYLubM5W5uA3gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=R/ElM1EU7X843BACWD1ZD/sMiodLpp4Nk6stqY9fcKE=;
 b=sE9IVInBDe04h9CNwS0ow1YPGhZ3ms7wyV0yr+GIGb11aLNRb9+WcN6qypGRJnSQm2AZceXtgd8563wZMS4l6wIAlNh0yoIQFoRdXlXCbvCKe8uE/6WxWYGXuY40z7i4FE3Mz9FTlyttMK9tABqrfnLmC5KqdnYRYYqkNit1jzvdfPqtMurzCZpASza1KOBiNno2Su1PhvMESF/JjtRhB1ee+zPMdih3m1zQwTn/nsyJ7/MDr6SgTFXHJFOJ2fUhGf/8eBYmLzoGuGFulV57D+g3spVZ7EKjMPaf9bcyQymJfnsEz0JpyjKYhfCts8Dbm/xw0FGX6TikmwQAdwa/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB3822.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:12b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:28:20 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:28:20 +0000
Date: Mon, 24 Aug 2026 07:28:18 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v5 4/4] perf tests: Add shell test for
 kernel symbol beautifier
Message-ID: <kck6lq3iboig2qwrwnknroqsfbrjg3u4m6y2oypx7iews63mpp@x2lvdb4xa5mc>
References: <20260822213558.704018-1-atomlin@atomlin.com>
 <20260822213558.704018-5-atomlin@atomlin.com>
 <20260822214802.B22261F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260822214802.B22261F000E9@smtp.kernel.org>
X-ClientProxiedBy: LO4P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB3822:EE_
X-MS-Office365-Filtering-Correlation-Id: f29d54be-75ec-4aab-53a5-08df01d2cce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|3023799007|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	s9tp0WonWUwcPa9bDCXojhXKMiWC5A7F9ygMuuq0BMcdyogv3KMh+Ni08NI6Xqqddjn3/SbF4rXhv1BHd0XrZDfhJb9yBOl/Stej9hO+KEW3UE8zhLn3pbYGKFIpwCnnq7VDeyUHDcXyNu6cSGe/qJ+JQSPeMJhTps8l5vOEvYGak/dbib3lbWO4yBpXCSwvcN7+3rgHXSUlE9KpyQZatY2uTYOint/3aSE0efaxGfPdSTEDUMwnDkkz+Scp7FJWIDqwhX1BMdqlxMozJev1b4a2Bz6lMl8MrbIWb32cifqPwC+ac4YxYrnHlmxvsl5g2170ANXZVft+vFRTAEj2aBCWOP7/uNGgon5+KSj28oxfnfZc+iLrIS6NicvMdoBHjBArI8Aj9Q2J7fbs4/AISffWkzJe5hiE7XUSWGOs5LPNX52aDPhS3ILRo0AwDKkZE4wzcar+yQT0CUYgexnhxovIBBHczAV69ASruVkHLq+gBzY/oqqnPBvPWccs5vxQf3Jp5862Dye1rIll/eFTT2h3v1ochEectD3+LJw6UdRS1cuuEZ/abd6TJvaLfNhONbABMYrAbmGLI5XcdOVfLLzOqS2VghD7gCdFVPQV6dWgrdQe9rPp7xob8PRv4BaM3BEJkDRUsgKAWYs0INcm2i2SjaQlPBJ77ALAfwdcITg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUU2UmViUW1nejhlNHFQQUp2T0RLcnVOK1RZU2x0ZDZ2d1RHOUlmTk12RFVN?=
 =?utf-8?B?U2xSRVRwZkxEdU1RRG9tdEdhQWdoOHNxYkRFb3o2Y0Z1ZHA2bTh4bWk2dE02?=
 =?utf-8?B?aWlVNk9WRnQwRWUyZU9iK1N0RnlxOHhWbzdRRnZZSkU3dWFZbUw3ak05aklh?=
 =?utf-8?B?eEFxaFBtKzNrd05JTGJzU3MvaCtmUGhXUWlQNGRiWExpNFUwMVJaK28xSFRC?=
 =?utf-8?B?V05aQnA3TEZzcStGTUc1bloxTlovT2NRd3gyMXpBVGFSU3IvRHRld1RhUWd3?=
 =?utf-8?B?MXR2SGxXdUtIV01KZTdrZ2Z2Q1Z0QzA0QTNhbndwTmFiRUpJd1M0RG0wV2Uz?=
 =?utf-8?B?RWI3ZGxwVnlkWXlCeGd3RkFENlFXSXoyOWNFU0hKSzNTRzdhRmRTbVdjdWhW?=
 =?utf-8?B?eGxaUUVNcVFLM2FiNVpYaUcwbFpmbUQxSmZGNEhUb3h3SlhoeE16SmJ1MmNq?=
 =?utf-8?B?c042eVQyWHFZOXMxYk0ybzU0aWRWZCt4YjdyZUVXVVc0MDd1d1JLazJSaWgw?=
 =?utf-8?B?V0sxc2V0VHdnd2JTeWRwa1UrelV1SDVCRFBhdGNnS0JaWXY3cjlLVzhyRmxZ?=
 =?utf-8?B?UFFycklra0VheUJVT0FtQU1vOCtFV0RRMGlDUllVOXhmdVozWHlSZjlPUUVn?=
 =?utf-8?B?QmEzbWQ1VFhJZG9la1hUN2xqaHRTOUZyUG1DMnJNYzdXQ2R1S2owdThqdDFt?=
 =?utf-8?B?REJLSDg0MXc2MWI0VHM3dTA4NlROZGRDcUtuMVllK3VxQjRYY0xHak9zU3VB?=
 =?utf-8?B?NGFkR093c0dPOFlnakUzd1QrdWZwQTVNZDhZYWpqMFh3WGluMWJDdGRGVjFs?=
 =?utf-8?B?STRtMXZXZUluYXZRM2NBM3lXU200bEE3OFc3SmE4NlNXaXhIV2t1b3JsdWph?=
 =?utf-8?B?eEJuVGY4cklrd29OMjRGNEo1cS9sWnhtSXU1T3FRV0JNclFqVHpPTDFQUTUx?=
 =?utf-8?B?SjRhN0JBMENjY09YOHN6YVBXcmJjVnRGUkNEd2R3T0EzTjlqMkx5ZlNWd3NW?=
 =?utf-8?B?bHZsWFBnM3ZXNitxSmFvN0VWd2ZSSHNCcis2clBBN1RYbzV4dXpRQ1drOHUr?=
 =?utf-8?B?dmhZQUVMZWhlN0hBS2xYQmQ3dEhpdkt3S2tpbWNaL2lodHExU0ZkeTJaaTho?=
 =?utf-8?B?Y1o2WGlNWjBxNERKbXdRSkJCeVZQY2RGdHlMb3d0bC9PUEo1ckd3dm11N0Q5?=
 =?utf-8?B?MXl5OHZtUmlTM2o0ZjN4U1U3d2xNZUV1bUdQYjI3ZzZ6ZnRlYngveGVoaGR2?=
 =?utf-8?B?dmxXMWFMQkpxRFhXVktVbnRrc2d5WSt5Y2txVEhsSmNjQnBqTjFBbHFRbDQ4?=
 =?utf-8?B?Mm9rNGhHd01Kc0toMnArOTZaM2Q3Y250V1hVNlFsTzEyV3hITFhBMzBxcVY1?=
 =?utf-8?B?S1RkQkd5U1dUOFA1a1UwRWR2VUlsd0tJbllIMHd2dkZYYlpVU0laYjg4dDZI?=
 =?utf-8?B?enJudWlCckNReGhYd0p3MUZjTEFEWDhVY1Q5Q1h4ZGIydnVyZU82V3lqNlNp?=
 =?utf-8?B?ZFRiQTlkSTNML2h6N2VacFJ5VS9ZSkhqWit6WWE5ZWpERXZqYWsxSUg4UVNS?=
 =?utf-8?B?M0R1aUxUemlzK1llaFM0YVRob1psWEFCendFT3hZWXN5VzA5M0QzOFU2aTdj?=
 =?utf-8?B?SGZ1ZHVDSVdIdFZob094M0ZWN1lnRjMvN1NKOWRNTGE0dE5ZZ2ttQTdwRE5o?=
 =?utf-8?B?d1lRWERQMnZ5c3ZpVi9yZkp0UzBVR3dROTNMV1hHMDkzaW5LWjlQdmhidUJz?=
 =?utf-8?B?WGc0RVQzRlNYMU9nMWprYTYzUWh3bXEvOXZVTmJ1azUrOUcrOXJEY3pjY3du?=
 =?utf-8?B?azhnOTFXUGYwNkwwK0p3MGNnR1R3YXhMMzRWb241cWFJY2E1NXVMTmhSbEJY?=
 =?utf-8?B?bUYxa2NzL1ZCc0Zub0o2RElSdlJrQXFFUXNQa2dKMWxqblAzVUlnNlFTOFVZ?=
 =?utf-8?B?UlZXODZLdzY5LzJiUFRVRlNwN2JSdXNGVTZId1pZY0dKMDl5cnN5dlM3bEpu?=
 =?utf-8?B?ZkdjM3E4QjQ4eDR1RUhxem9CT1ZlSWhxSVBSKzJGQnV6aTV0UnNEU05jMEh0?=
 =?utf-8?B?dHRoVFlXZzlsaUdrUjZIczhaUStSdjBrZzBNVDVaOFZPV29PTmUramViaDlH?=
 =?utf-8?B?ZDFhK0wva09aYkhWbnAyVHRyMDJUbEhiclFjK3J5emc3cUE5RlkraFU0RWFt?=
 =?utf-8?B?aDNUVEFvNkZ2L3RvdVRXM2lJQ2h5ckNxdDE5cFZ6d2Q5K2tkTlllR0dUbUVl?=
 =?utf-8?B?Z3pobUtCMmJYeWJldlhsVmJBSE5ibGViWFJNTUV1dEVrbkNXUUdoL1RFVlF0?=
 =?utf-8?Q?r+7e9kTPnxYkmXCBR8?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29d54be-75ec-4aab-53a5-08df01d2cce0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:28:20.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rlWR8AFIOHG2qG9nFW8rEklStx1eBYjhJiSa0QxneWEvrfVy+EChCjPSxcCQPcL7D0KWTgn5sLyOpxMrIRgyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3822

On Sat, Aug 22, 2026 at 09:48:02PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test script `trace_ksym_beautifier.sh` intends to verify BTF type routing for function pointers using the `timer:hrtimer_start` tracepoint, but this tracepoint's `function` field is of type `void *`, which bypasses the BTF function pointer routing logic. The test only passes due to a hardcoded fallback for arguments named 'function'.
> --
> 
> --- Patch [4]: [PATCH perf-tools-next v5 4/4] perf tests: Add shell test for kernel symbol beautifier ---
> commit e969790d116081081634b0e3ece5c71834b3fe8f
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf tests: Add shell test for kernel symbol beautifier
> 
> This commit introduces a shell test script to verify that perf trace properly
> symbolizes kernel virtual addresses and function pointers. It checks both
> the default kallsyms beautifier and BTF type routing.
> 
> > diff --git a/tools/perf/tests/shell/trace_ksym_beautifier.sh b/tools/perf/tests/shell/trace_ksym_beautifier.sh
> > new file mode 100755
> > index 0000000000000..45c803338d4ca
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/trace_ksym_beautifier.sh
> 
> [ ... ]
> 
> > +test_ksym_btf() {
> > +  echo "Testing perf trace kernel symbol beautifier (BTF)"
> > +  if [ ! -f /sys/kernel/btf/vmlinux ]; then
> > +    echo "Skipping BTF test due to missing vmlinux BTF"
> > +    return
> > +  fi
> > +
> > +  output="$(perf trace -e timer:hrtimer_start --force-btf --max-events=1 -- sleep 0.01 2>&1)"
> 
> [Severity: Medium]
> Does this test actually verify BTF type routing?
> 
> For the timer:hrtimer_start tracepoint, the function field is declared as
> a void pointer in both BTF and tracefs. This means btf_is_func_ptr()
> will evaluate to false, and trace__btf_scnprintf() will return 0.
> 
> The output is successfully symbolized here only because builtin-trace.c
> contains a hardcoded fallback array, syscall_arg_fmts__by_name, that maps
> any field named function to SCA_KSYM.
> 
> Could a different tracepoint be used here that has an actual function
> pointer type in BTF, to ensure the BTF type routing logic is being properly
> exercised instead of the hardcoded fallback?

Let's drop test_ksym_btf(). We already have trace_btf_general.sh as the
dedicated BTF test suite, and it tests btf_is_struct() via clock_nanosleep.

Kind regards,
-- 
Aaron Tomlin
