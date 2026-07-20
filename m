Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020088.outbound.protection.outlook.com [52.101.196.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB243E9D5;
	Mon, 20 Jul 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565333; cv=fail; b=SakalSDyQSxSJsL5DeBs4K9vt6ja1PuMiG2nVyIAXVoqMhYWsAWiiB3B1q/J2DSQ2605LFuzvlddNF1XYD0P2yWNsfm5j2vpNXawEWd4u54z5T2Erxxza6NgcWPFzR+hcKpBf+JpXbNK0TF/HNKGrga8fUQraNgRloXe/ncHb+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565333; c=relaxed/simple;
	bh=L1XPHxXCkKObSo5Mg7Ul8KHLewfTUTyFk6+C+xupahs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TeSyfAJPZk2FrxP0rCevq5ZCjN7yaWvj8sQxOkhQtMrvXeEyjrCIc6/m2VbWP0xuUrtz/e4pu5uQH9uaRMsBDjutAUmJGalViQqsNSijqfC6+DzGrDxcg2aRGknp0sogoYC366yLVAZpBj8KlIWwuzuEdoLKWFn8w6C12f0hjLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6yF8p/x7k/UfSLqoOdpz1PHHrtsS4bFtOMDRqUdRIO5yHpSyNwDWLXRL+ydKcdUV+3ojvg7iI2/kTH5Uqg4Ki/EOYnxJH/qlwpMxLuKqxTC2KAbPI+jPicMPXlyAEr8dlIuH2DmSDhN8AvZeB1D7UXfTBUh2V6i0WTn9riSXyQc/7Zyj5MiD8oxn0OSpKYvHZ7cYyGDu5FoNRD+fxk+6nsRJXY+sQU/tvC2r2W+xSEGcea2G3FNAPj9gPImc+TpSmsEbRL+1Z+5ECw2uL4ZWvhIhAfnXk5loC8l2WY1ajiJerT/Oj+bhjHu/a5I0dY0Nvdi0oQRsB/5RZshyjChqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=wci7JtONNmFL9LkJG5G2qptXeB4E4jeI9zWFtzfkeFU=;
 b=GjJgomkVMQf3lMWqRUPgGcHj8x6Us9armWupZgTDpIjMQF+FtRDdDO6c3zyvZ7xpXe4dnxq9GNd1jrLSYUzPgYBddMb0lyJGR/lSOEaU4t3773xXvtflVFxvnyQ4n5yhJNzbXcWreyXOAiqznFMblkckJa2E8MIQpqu/76LV4gNROF01aB/uh0eik11apBw3FskkL+VfQtVl4XgW1fY6ck3Rd+lTEvXvCZeOPLTOLUWCCoYvbjdb/2m4Q8HMIMLoyuoxOj64qWxvghEEXB5254K9aYtBxpX28ItfXjzmM5x0KZFdKkq+Xwx4m8fYbBmoK0mrwFLDTt7NSILFsRwoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8859.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:47e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:35:26 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 16:35:26 +0000
Date: Mon, 20 Jul 2026 12:35:21 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf trace: Correct default cpumask formatting to
 hexadecimal
Message-ID: <dhxhdx2gcyz3wd635fwwepr5hmdgr2gqnm35uo5ypurbypqd2p@p57omxedkmnx>
References: <20260719001510.398616-1-atomlin@atomlin.com>
 <20260719001510.398616-2-atomlin@atomlin.com>
 <al2r_MoSrBkbLAmA@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <al2r_MoSrBkbLAmA@google.com>
X-ClientProxiedBy: MN2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:208:234::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 99179257-69a6-4e53-b88a-08dee67ce6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|18002099003|22082099003|4143699003|56012099006|3023799007|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1zr60VV/VadjwknAXASOXXsNzGJ7FDdcNiavf3nj3DLgjZp/kISkQl0E3H3CbpU4etl93J/l78FU13Ra+jCAGS7qZ/b09KFY2cstWLfqkoC0vnE6DgSy/wc8NXgukjgMC1rJOID4ZYoTSBU4MjNgxDU6g4H1Js7yHHd+YQTVUXPANZy+eIsHzwIhxTM7aHgO2ywjkKdFlwkQTHYi4g09zuJqcDb7SumGB23xV0zZHxskqlXzWGLK5TFp+uKx3Jg9wght7aB3eaKdUVDDy6hS6N5TI4/DDnl8CMsvxWVTCrYN0fMqBv2tp6Gv9edFYRKO3jUfFYRTZ8OB85CYpNWLk82VygsIQwB8aazE8hr/t8Hp7dzpuIV4xR/CA1BHDWi7ZjyDqBDyvlM51FOJY+oSTdAtqpUM7JUSCmAK+HwWDy+Dnu7QWhTsusBd+In7peZrHMYg3chb98k24I/zueZLfr2PSIXwISEj1RUczRY/hkaYXRaU147p9kwNaq8FNMSkWHEvVGEmC4MLonN6ZwGXdvIipEKQ4BJ/Y1wzmKWE7NIjWqLGqTuds4dNVuQgAon8/0UqMOWkEF31TpI2xPgHbgaXPUdOBJrYc8v93xxXfc4WnPpj6uO+wbzQ5I/1N84I1mZMyQTYouM9wmp5dUfvUfQusUTLK1ImhHysHsNLBME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(3023799007)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N21NYTAwdnlyaDR3T2loUld2TEZ4ZWJGZTdQRkdaaU44SitndFFIOHRaZ2lW?=
 =?utf-8?B?a212TElrVzd6eUV1OUFHek54WnVwUXdUYnlxTGFrRjRkdmszOEVjaE1vY1dU?=
 =?utf-8?B?emJlRjY1TEQvb3RjQTlwcllCNjdUVEN6Vy95ajdTazFQNDJXaHAxSDR1dWtw?=
 =?utf-8?B?eWl1TVUwOWlneko2SkhUSEkvcU1jUm50U2xuZ0FkRmNxRjBBTzdQWXhOK0tp?=
 =?utf-8?B?NWFJdWxXZ2I1cDh4aVhsNnZMN1hQcmM3RXdnTExTR1BFNGFJQ3hvUWZGT3ZK?=
 =?utf-8?B?TEh4Y0hOSTJQZXdFYzhzbFZKamI5VEdQYllvUHphTzVQVDlJU2VtcnBwdlZJ?=
 =?utf-8?B?MEZKdjF0YUl1MEhiU1J4K0kyMFlaQXRTaHdCdDE3Z0NlcmxrLzV5bzhDL05S?=
 =?utf-8?B?ZFQyYmZZUUhKUjVnbFY5SnFrT1JLaUpjS2U4eWJzWGRkd3ZWemVGeGg2a0hW?=
 =?utf-8?B?cnhoTzgrRGN3YldYNGVJUlFpSTUzcXJWNDF2VDYzREM0TVJGVE9zQng4dXAx?=
 =?utf-8?B?R3pZbk85Z0xVOXR1Y3JiOEEyNStOdTNubVIxRkJnbGZDOVJES015R3RCTDhQ?=
 =?utf-8?B?d1FJZ0pMaVRncG1KYW1USTdZR2tIS2U0MlI4bzRka01kQXBOUzN0eUNyQmZi?=
 =?utf-8?B?eCtWUkVqZ1BCeXJGNGlFTEdCZkh3SkFnU2FvcTBSQmtRTnZTVC9hTWV3YmFm?=
 =?utf-8?B?YjkzRVZjaWJaZWJ4OWNZSFMvSHNvSHVHbXVZUi84NHUwR1pUYzFRNW9odXRr?=
 =?utf-8?B?b3IrS3FETWduZjRoaVcrVjhBOURxTGxUY3dEcGJobHJJajJObGFhYzhvU0dQ?=
 =?utf-8?B?N21UeGl6dk5xOG84TnB4bXhHL2pGOGUxNkovRlhOZHJ1eGRwRVBTckxLNG83?=
 =?utf-8?B?NTlac2hPamR1YURBZmpUNWJJNzAxU2VsdDM1UWI2UEJ5RkI4VzVSdFRmL3Bi?=
 =?utf-8?B?OFQ1YW9mQjFCWU13MzdKc0hiSkZhRWIwMExIeno2QkpkM1Njc1ZReVBLMEVL?=
 =?utf-8?B?cnJlTWpHQkpsNnlQV0c5OWh2OWlrWlJ0RXQ3TEwyaHdEYzhlQjdyeDRFSkdS?=
 =?utf-8?B?c3hrd2pnVVh4VkdFSWRzdHg5SVo2ZnBGMDE0dS91dzhCVUJOVkNnS3paeWhq?=
 =?utf-8?B?dWxZaU5ET3dZS292c0RNT1hDZ3lRTGkvNUIweW9vZDFMU0l5L3lIemRwR3pa?=
 =?utf-8?B?alhhNDZodmlnb2ZtTEtSUHMzU2Exc0VDbSt2Yyt4MmYrN0IwK3ova2hqdlZK?=
 =?utf-8?B?SFpwbWJkSnZtL2xxZjViTnR6ZWpCWnR4cWpYdzR1aGZRQlBncG5oeFN5SEZs?=
 =?utf-8?B?YVRpTHpyWHgzUjl6Q3ZSNVpqQU05ZGRlM2tpS0REbG4walpvaGJISmxOWmo5?=
 =?utf-8?B?OFBJdWJaV29uWVhtVmNHbStLNjJLNll5TFovRU5wVXZ4UUFENnpJcVRwZUpl?=
 =?utf-8?B?aytCNTNmZ1QyUUExVzEvNHBSN1R6aGVUMDRkRm9RUmdRbEFTWUhlOXRoVEto?=
 =?utf-8?B?YmRZaTNDUFBxdE9MaVJ3QjNMTmFERXhOYWZqdFhjTjRxbkJrTzJDRE82Uy9r?=
 =?utf-8?B?QlNCYXA2WW1BazdkVjlDMWpJUk5HL3VOZEl1d1NyUDNVZ2xpdDk1dnFudlFF?=
 =?utf-8?B?WFhHd1hBTWI5dUxyMFRRUXVDeDJOWUJ3OEdFVUVzV2NaUlU0ZUk4OWZ5RmdF?=
 =?utf-8?B?V3hRRnZWRzhkSU1tZU9KSUZQVkZ6SWRMbGNvSzA3dXFWUVp1U2FLNFgzdXA5?=
 =?utf-8?B?M1poWXFkaFhHeDhSd0lEQXhRcnIxMElTS0QwTU5Jalk5b1MvbklmWCt2bnJ5?=
 =?utf-8?B?U0Z0YXNGY1Q3K0YyUW4wdVZWODNpZEg5QzhxdHkvZzloUzZRSEkvYVAxKytT?=
 =?utf-8?B?N3daNHAvcFJRN0ZYeXQ0bGNvNDEzbXNCR2w4ZFVTUGppV2l0QVhiRUg5Uk5U?=
 =?utf-8?B?cjZrRHdlb2NnbFh5MEtWT2tTUFdpSldvZlhTZ0Y0dkdhb2xXeStBcHNlcDNP?=
 =?utf-8?B?M0xENmt6ZGtXM0xKOFRtYUQxSHhMZzdKVGZWdUppbUJtbTE5L3NWbE5OM2l1?=
 =?utf-8?B?cmk0YXljUDArZzZhQkhRRDgwT1hBdDNHUmhFZGVhMVdoSHBkM05TN2pwQ3hY?=
 =?utf-8?B?aHZVcmFEcnV5bzRyeWtGTWY0NTRjN01sOHBFbGtQcUlTbnRCQ0tjOWNmaWM4?=
 =?utf-8?B?MUxOWkFBakp5a2VpclhkcVZYd2U1OVdtR3ByRklFN2lVS1VDdlk3Tjh3VG03?=
 =?utf-8?B?RVZ0SmQxSm5NVTFRZThmNkp6cW44VlNGeU84Q1IwS2ZqdmJtVTU5VkR2N1BX?=
 =?utf-8?B?R3dhdmNDNmozem1JajRJTW1OMzJRTHQvUWQrRWNsbE1ZMjRkN1M2QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99179257-69a6-4e53-b88a-08dee67ce6d0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:35:25.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnxUcbFje7yv4jjoVVRPHqW6nG6t51WxQFqpriryzGldtzuDDAY+nr0NrZnFRH1p0bQz5FkkRLNc+8+3ceZgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8859

On Sun, Jul 19, 2026 at 10:02:52PM -0700, Namhyung Kim wrote:
> Hello,

Hi Namhyung,

[ ... ]

> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index ba0f8749fc7d..f8b8431f9543 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3207,6 +3207,21 @@ static void bpf_output__fprintf(struct trace *trace,
> >  	++trace->nr_events_printed;
> >  }
> >  
> > +static unsigned char bitmap_byte(const unsigned long *mask, int byte_idx)
> > +{
> > +	unsigned char b_val = 0;
> > +	int bit_in_byte;
> > +
> > +	for (bit_in_byte = 0; bit_in_byte < 8; bit_in_byte++) {
> > +		int b_idx = byte_idx * 8 + bit_in_byte;
> > +		int host_w_idx = b_idx / BITS_PER_LONG;
> > +		int host_bit_in_word = b_idx % BITS_PER_LONG;
> 
> Better to add a blank line.

Acknowledged.

> > +	env = evsel__env(sample->evsel);
> > +	target_is_64 = env ? perf_env__kernel_is_64_bit(env) : (sizeof(void *) == 8);
> > +	target_word_size = target_is_64 ? 8 : 4;
> > +	nr_words = len / target_word_size;
> > +
> > +	for (bit_idx = 0; bit_idx < nbits; bit_idx++) {
> > +		int w_idx = bit_idx / (target_word_size * 8);
> > +		int bit_in_word = bit_idx % (target_word_size * 8);
> > +		bool set = false;
> > +
> > +		if (w_idx < nr_words) {
> 
> Nit: Can you change it to something like below to reduce indentation?
> 
> 		if (w_idx >= nr_words)
> 			break;

Acknowledged.


Kind regards,
-- 
Aaron Tomlin
