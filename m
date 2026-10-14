Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020083.outbound.protection.outlook.com [52.101.195.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF603043CF
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791942201; cv=fail; b=hr//62+1uxzpV0vzXv/XMprIGpnyCD4XwId+GprgUkYOD3yahRs6zbrtEI2vS2lezEh6FW+f2l3twNzpnII52XRP7Oj5fSjol08ynR18aelOjr+kuEFEZBM5xEgTPRLCnNDzwcljNSuYGeCmKjX/RLiH55z/oj3W0u6BoMWMrtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791942201; c=relaxed/simple;
	bh=FCEsiyG0fOeyTAu+SwFf7BS6EATn/CBeMIVcw7KS2Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qgelcoOvNODZd2IiOs82tKKhVrqSx0xOMLYCoftF7QJpx+EIY74Ch9ibW7apqEgLNsC7dvgInSyGFp/g/JMKTXHqIyxRfEZd2XRITrSiYWXOBs9vpdgCTGHbx3wh82y4FSmunZq6uv2XPlT900I43cDPRgEMEZqmo8binHepdyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTFcN/f1cSB5KIxKnSN92SZ6PHzNPqvhivUFniMRMQnFexwm/sL66VmXZqBe/b/tnx2iyv7FL0zCQaF4YiLvpK9p9dQjrgzXfGEGLfpt968eFoAx4wj8PGUcC4a/EjUUwFdD+4Jcrx647OKcEtrcuWBeTpQS6zVz3MQNFZVwx25yEwr7FeqjG35TILwtXz287spSMTZAIC3Iw0M4mHVqnVjN6rAvLaosPtYS2FllU499UfGnaM2vyvXpkuXfBgf9CrifPevXTo3RGl2sqm0pzn+UyUhnOTSnuPFtNRwYha+JC4vq96/12bpJYCUPRh8Bj6SSgGuHEWApUUvpONU6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=QzORO+cOK3R1fIafQfSeJHHaRkYISP8tkCh9QJ+dfok=;
 b=Tpx5UK3Z5r30sikRl6y/AY7kYviVXLaivDovHHCo4/KiHxl04DTu7Cg8vqbMNzx4gmjChcJwWAzt4wr8qWvs2dq0u9+O7CSi2mYh7nqGAXpsF6NkuZICx3Ca+48mNmlnmiEtb1+nyIUbHORNyL2ztv5fkdXcCy6XzGrp/OwO6oyC2TUQMfrq3n5ybYLO0xFUem02Zspr7CAwnwjj222/bChm9E6XZWXg//Aeu+UllIBuBsUugkid4DwsYn5jJ666giejY7OSls5Vn9y7zzvmIxlq4Dc/lgmRswggdAVydx8UChDx83sAz3rsS4YthnBACKhuCdbRhcEcZQkTwHEw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB8001.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 01:43:16 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 01:43:16 +0000
Date: Tue, 13 Oct 2026 21:43:12 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v3 2/5] perf ftrace: Support filtering
 return address comments
Message-ID: <4eymfgtgrzh2ni3r67wiqjvd6ed5ro3ndxy3u7ubsmf3wpstue@u7pfajcuyrpy>
References: <20261012003016.263063-1-atomlin@atomlin.com>
 <20261012003016.263063-3-atomlin@atomlin.com>
 <sashiko-outbox-167527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-167527@kernel.org>
X-ClientProxiedBy: BN1PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:408:e0::35) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 483b2422-6914-4137-1a54-08df29948422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|5023799004|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	m22PcmGxI0QlpWRmnKeTEHJDPHOE4Q8mhsmAJ54BlxFWJqIxf02sQJ1NuafsXheOsZAHrbfvBPbtjR5M9mcTreE/JNeW1Z94pNb4K5s637NAneD1mfkYwEho+bCh1YDB4K8Mg7OpgJGUXUG1N86vO6a8BSGNFhN7otdnXYsrWCZYLjmwmH7UpBoxHM9SdC7foEdO5Fz9xbhWYUIaIaYo7ituTgwtU+4JK9UbZ7l1JWMCtfXstmeDai0XBZCikn4bqH4NDFWwNDrUA/FaPDbZoTutvAMLQmCIkG3v3ViARtBIYehaCll0hOGumyHhdCZ81yt4+ZMNTO4aA0tpzkVUOQHdo535E/n+mIK3AWfixmC40sF8G7OGYNaF8Qi6L26M+E47I2/u/UeC+FBYcke6oEX2k8x9QflX9g2e7MNtRZhY59PZTARFyg087JEVJmyyBCsR1QCSmx2vdFueguZnqP1z2UJC6xiAownRuTZAROTQ4bWj7+MPBUEF+dbHYYVmeo2fjDr/+4+6j0qydD4xPGxcQvQLIYQdAg8VZvGLRkOWtaYJiAnlSuCeA67eWjhnKuBSna2/gNS6x6yMgC6qHKw/mFrEiTvT3RBvEoKUgpMi7ltfcFIzo0d52ADv8ZmEAAf1ZIzVd0n1V4B4PMapUYrYlawx4M2UW+GkKANPMfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(5023799004)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEw3VnZIVEFOUDd6WXZTL29aOHBzemwxVVVFdFZOQU9CMmZKQnoxTGlub0dy?=
 =?utf-8?B?MFA5cjRRbWRsTUZwa3k5blBnVXJLUGV6Y3RjWE50SzlVbnY5ejNWSFMvMThP?=
 =?utf-8?B?TXo1WXQxVjFrUzRRZG9BRGlTdkltc24wMGMyVlIzV2xPN3FMUjRQY1FQL0NN?=
 =?utf-8?B?YUFFQVlrL25JaFNYeDd6UkpPSGhZQ091TDhpSzRUdWx0OVd1QW1QQ2FRUzZT?=
 =?utf-8?B?Y1R6YjVRZ2VwMVJQRzVhTFVYbkovQlprMVRBdDBaZytLVzhaM2NiQ1NWWlBG?=
 =?utf-8?B?U256QTdMSDlCbmNEZU8vNVd3aGs4M1lSWmJZeFZRZlZCamdWZGxzYUxQN2NV?=
 =?utf-8?B?d1ppSkw2aU5OcmYyc01uck9QZjFQbm8wRzZ2QzBnRnBJcG8yZFBZeDllekE2?=
 =?utf-8?B?ZTJKTzFUMzVyY3ExNEMxRzV1VEVEL05SLzVFa0ZpeEI2UU10dkFHd1FRUmJa?=
 =?utf-8?B?OW51Yi8wblJHT3R3TFljRnJiVkxNRTFzUVV5cTE5QXpPWVRDNkZrRjdzd1pF?=
 =?utf-8?B?YUM5Z2l4NWNTcldQRHMxdHp2NTVrSjV3bCtTUDMrbkZSbDhZVjdLb2JGcVhn?=
 =?utf-8?B?cnR1TUVTeXB2NnlnNC8za0pZc1llblRQZzdDcUs4TnZlQlJVdk9jVlhpWGJl?=
 =?utf-8?B?cGxtcmdQZlhLMlh4cDZxc29GM1FwdXAzbEE4YUlKWFNubEVYNUpCb3hiYW5B?=
 =?utf-8?B?REtXU3JpU2lZY3UrZUtaajFsV3VqelZ5OWtaaFNUREJ3K0RjSEIzbTlBeUhL?=
 =?utf-8?B?QjdiQXd4SFFXQzR2UjYxTUFuOHdvK3RmV0pxMkY2QVJTU3dwZDllRUhvb1pt?=
 =?utf-8?B?YURVOUd0bkpoditYTFprYW9HcCtib2RSRStQUWxHc1ZnZTF1bm0rV3FBVTBy?=
 =?utf-8?B?dXFOdmJ5djVYM1FrZHhObS82dUVVckFFN0ZtMDdSSEZMM3RkdzBSSUZLWDlG?=
 =?utf-8?B?V082SStxckNzc05GOXVyUTY0SXFldVFUQlBSSDlGaTVQVjk1VG9WSnh5N2Za?=
 =?utf-8?B?eDd5R2k2SU94Wkt4TXl0V2NrTk1TV1l4L2N4Yy9VUUptZ0dkMytPdjN3N04z?=
 =?utf-8?B?SXMzUFl3NitXdWQ4V0dQWGVRUGNrMzBFd1FrUDdZc0dQSUFxbklGSnNuQ1Fp?=
 =?utf-8?B?b3NoS1JEaEIrMVZWYUZmV1VDS1h1Q0ZtOEE4ajVYMU9GWDNld2d4ZSt1cDN6?=
 =?utf-8?B?TlFjRnh4QVNtZEdvZzZkdzZzd3BRUm03Wmt3M3pZU0hEZXpvT1pGVktqM1JY?=
 =?utf-8?B?QWtkNjB4emF2cVl2VU0veXI2SUhBdGw5blRhczZlc2RSZXl0K1FabWN0MXFk?=
 =?utf-8?B?RXJBUlkxN1VUYUlaTysrS0dWV3AzL3BqMjVsT2hTUCtOVXZ1aHV0blQ5KzNV?=
 =?utf-8?B?dkdVLzk4MnhDa2xZZmJhSDArZFhWM2ZnVGdXZGZTdXM4enBRTHFZMm9MWXNB?=
 =?utf-8?B?blRXQk5PM1ZyLzFLYXJPYTR4Zm9oWUlGOHpMR0tiZUc5amZaZ0c4NER1QmR0?=
 =?utf-8?B?dVJqWGY2enZOV2FMVklrbjJTYy9YdnBVbDk2YzJKNFF1dnl1cFdsc0VrSTNy?=
 =?utf-8?B?U1pqbWExZjVTbXljelQ3ajVlaiszaDNMTWxNd0hxZmpXUnQ3SEthUzVteGE0?=
 =?utf-8?B?eHB4YzEyWENMYXIvSy9iWVRvWUFDeUpML0R3c0hCRHJpM2g4NWViQmxyMldI?=
 =?utf-8?B?Sy9HUC92NG1tNTFyYXUzV0xWRWlFdTdHenkxL1JkTVE5SmNYNFk2SVZHRjdP?=
 =?utf-8?B?TmlZYXpNUmVvclJtVURnb2Y2L1AxYUh6Ni9FZVFOeW9sUHlqVkRhb1B4enJO?=
 =?utf-8?B?U2l1NFhjQ0JwUERIK2Z5cFNGRjNrUUZxSFp6enpOZDRMSWdsUHc1OFNkQW5i?=
 =?utf-8?B?QTZkbEdMR1VLdFJJYmJWclVROENCdVFDY3l5MDJpMEpLRm1oQ3ZHY0VEZitu?=
 =?utf-8?B?NlRiakNnQWN5VThSYyt0M1ZpdjhicDNJbmxPc1hkeEcwRlZ3QjBuWFQ5R3oz?=
 =?utf-8?B?MnMrYVJvcG5ZOCtpRDAwMEhOVitsSjlGdnZOWTAzcXorRTJCTk4rWWhBbklC?=
 =?utf-8?B?LzlWZDNYTVNGOTkvcU1UMVZLdCtsU05uUWpMa1ZoR0w3cHZ1bnlLUVRFVkJY?=
 =?utf-8?B?UEg1MVV1TFBLZUxsbWtzZVJtT21IZXF5ZTQrWGlkcEFHc1dPSjBORWJyVmxm?=
 =?utf-8?B?MDBVSHcwOXBYVURXcXhUUkxwTlM5ZmdzMFdjVEdPSFp4U29OTklxSlh1UW40?=
 =?utf-8?B?eU1mcjIvU09keEpYSU8vZjE0U0Q3OU1XZzg5UEVUUmY4aWJsTWhFNUMyZEVa?=
 =?utf-8?B?aGlBeEFZdnN3NThJOGhMb3VaaUUxL3hsTERhWFU3YWg0YkZuaTVWdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483b2422-6914-4137-1a54-08df29948422
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:43:16.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyrPJfm1ctv82I2Em3EvFofGTG1nU7iiYwPfMfvw9Si9+UkqejUxw8i4xci3R0NUFntK6deQ+kDIp9tkxtqeGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB8001

On Mon, Oct 12, 2026 at 12:38:24AM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> > index 3f3808e513fe8..3dbb7e8e783e9 100644
> > --- a/tools/perf/Documentation/perf-ftrace.txt
> > +++ b/tools/perf/Documentation/perf-ftrace.txt
> > @@ -1,5 +1,4 @@
> >  perf-ftrace(1)
> > -==============
> 
> [Severity: Low]
> Does removing the document title underline break the asciidoc generation?
> 
> Asciidoctor strictly requires the document title to be underlined with equal
> signs of at least the same length as the text. Removing it renders the
> document malformed.

This will be restored in the next iteration.

> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index d6604be593a34..f3221089a4793 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> [ ... ]
> > @@ -1827,11 +1833,14 @@ int cmd_ftrace(int argc, const char **argv)
> >  		     "Set nograph filter on given functions", parse_filter_func),
> >  	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> >  		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
> > +		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,noduration,verbose,thresh=<n>,depth=<n>,tail",
> >  		     parse_graph_tracer_opts),
> 
> [Severity: Low]
> Does this extra string literal cause a build failure?
> 
> The OPT_CALLBACK macro for graph-opts was modified by adding a new help
> string literal without removing the old one. Because they are separated by a
> comma, the C preprocessor treats them as two distinct arguments, causing the
> macro to be invoked with 7 arguments instead of 6.

Yes. OPT_CALLBACK() accepts 6 arguments. So, the accidental duplicate
string literal caused a preprocessor failure ("macro 'OPT_CALLBACK' passed
7 arguments, but takes just 6"), breaking bisectability.

I will revert the unintended edit to OPT_CALLBACK(0, "graph-opts", ...) in
patch 2/5. Also, replace the help string in patch 4/5 where noduration is
actually introduced.

> [Severity: Low]
> Is ftrace_parse_retaddr() ever used outside of the test suite?
> 
> The commit message claims this function is implemented to robustly match
> return address comments before stripping them. However, looking at the
> implementation of ftrace_filter_retaddr() below:
> 
> [ ... ]
> 
> > +void ftrace_filter_retaddr(char *str)
> > +{
> > +	char *start = strstr(str, "/* <-");
> > +	char *end;
> > +
> > +	if (!start)
> > +		return;
> > +
> > +	end = strstr(start, "*/");
> 
> It appears ftrace_filter_retaddr() performs string replacement using strstr
> and memmove directly, bypassing ftrace_parse_retaddr() entirely. This leaves
> the parsing function unused in the actual execution path.

ftrace_parse_retaddr() is used in patch 3/5 to parse caller_sym and
caller_offset for DWARF inlined function resolution, as well as in patch
5/5 to validate caller hierarchies when filtering with -G.

Also, ftrace_filter_retaddr() intentionally does not invoke
ftrace_parse_retaddr() because comment stripping only requires locating the
"/* <-" and "*/" delimiters to perform an in-place memmove(); decoding the
symbol name and hex offset would add unnecessary overhead.

The commit message was poorly worded, conflating the stripping logic with
the parsing helper. I will clarify the commit message in patch 2/5 to
explicitly state that ftrace_parse_retaddr() is introduced as the parsing
primitive for subsequent inline resolution.


-- 
Aaron Tomlin
