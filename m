Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793485671;
	b=UFMrP/MbAIrC6a6r6ydLuyOhHWCHH9u8Ay/H6iIkuB64Tjib3aZah+TIGcB4sY83X/it
	 M+QeYy7SwCKXJ4ztUu8kLAQ9BP9ngZWGfTmc3O6Gr3PLVCGhTWn5FhMSVgDwgZGlNsOyq
	 aBkRbs5fgfZRCAJMCtajVTDWFvVXaUUMJJxggdfwt1JP3RcaRnLyTNg745tsmMa1zms0m
	 gdvi3Rw5h42V1DnBfYN5k3D+fDaljUWRLpN5ry70RQK6OFUUCoBLzxZ4/lwkzhK3CCfJQ
	 vJrNi/KU+6gxN2tw0uGRBS3NKtL4z5ZDiuO8CNDMrYhHlWuWMTNtO3nLORTDXNJ5bsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793485671;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=eTCcl8xI1Nta43Dc40e2P+d2J13kPM+Eo0WmG/r7NeA=;
	b=hNzA8jf1lLHgRzsDE1HDGDNRZLsA5AGOBneRY5SvFHor0INplex14OqS9SN/phmRFpla
	 laAlQtRzQaPEl8BSMluRNEZRYe3vvO8x4m/FQ/3CV/EapA6lmvLnAqSxGyO5ZP/HFTunA
	 v53mxM3lWwyPvVnRIr+lxX0wo5RBDVIKvwY9VTvDaNcT3NLMcojx/D4OS/aBa279GbbY4
	 HkNbKctPlUVprbsNQZG+NyjMney+/giTzSMSL/r1UW1gDUEu7MIpr5MYLL2O9ICzrRTZu
	 gcy+Clx3m2NzhH4wFZ8VjClbjfhaVx/X/7gVt0r3oPQEoBRZRIaGMaPx9l6Xb2vddIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.102
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021102.outbound.protection.outlook.com [52.101.95.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE33606A31A;
	Sat, 31 Oct 2026 22:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFE33606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euNqo8nqL96hfnd1lyH+Avo6SJ32SUleAqfZirqeuQDvsWH5alfCvKDhbdzz3gFQciVRy7E5aJkefBk/O4a+2V4DOpR3cqhUg3vPDRTVwx4MgxpzK57IGDdm3FmB42oWARe9eITbEZG6UWFv/XJH9c0Fh4964C/5eifAJHxU/FmYb3dKk1dESsZLDnhsowU2yadKud/3aYUl69i0pQemmIkd+tpbVyVICyxvCPk+ux7WQwFLdRVrEZ4HsKrR0hIObupL+i6YZpLBKQWxRs4NWGtB00+UywkjgHIV+Jx+MnvjsyZOUzn0S32z6uawnicyBRmqDZevCbKrx2NO+SV33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=eTCcl8xI1Nta43Dc40e2P+d2J13kPM+Eo0WmG/r7NeA=;
 b=y7gneWXfwWVdxpwnyDWc6Q5z6KFygT0FbWfydWysbtrlL3E9l0RrxYA0XPcEqS4q5hsFiA3SGet2C9jz2SIfYZBeXHivfwGwAk6Iljw817N1hExh8X/ebuDzZ+Q7xSJbtbIg7PBFVS10Mr/S5N1urC2qDTF0BlzE84eya1YYdYH7Th/NyJxTJsgXdz+7dsFRQvHIdnRWdzZLnUXZxUt4WeP7zOKbSI1WjUQRNNtQdYKIWHran+QxCungjJwy7bHDmZbkrQ/DCErgAEWe2Cb+72tPJPABxwURu1eV+AGKdA0QbftfzBQ5YfO15KY0T48zDqnPTuNVS51yNtWgGydBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8889.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:482::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 22:27:47 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 22:27:46 +0000
Date: Sat, 31 Oct 2026 18:27:42 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, chjohnst@mail.com, neelx@suse.com, 
	sean@ashe.io, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 04/10] perf ftrace: Add basic task
 call stack management
Message-ID: <5s4fy255agvlgqdg4b4f5ekvhgmpjndydvsaadeq56cubrtgot@mrflkcricted>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-5-atomlin@atomlin.com>
 <auWTUJd4VJUI32S3@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <auWTUJd4VJUI32S3@z2>
X-ClientProxiedBy: BN1PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:408:e2::35) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 844d5439-43b8-45ed-ea4b-08df379e3043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|56012099006|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WOwfXCQMCtMegUHbJP2T/uHGAPz+ZoxfgVPp5BDF/0g7uWYUUNOPV+HQ2UewaozVctr7Sc2RlEJ4NPH9CFrvZrv9zRyJvq0nV9QZqYobuPg79Hajl8by3nw6v9FZKCKnpJgqVlhrSdfnb7wF8f1CAbveGFlqqekQdyB3zzsYOjqxb4s5/2TyrZFS3sY8Rhx7UK0eWxJ+FDMDYqart4uh1s9bMkScwowV8pFIdV5SkgU5FRAelpSLoeaq/Al/M77lws+a75jTFj1b9mCv0w5qFL8X9+1ixZ8F26b7M4AU19JT3wd0wISoiZXYzOb8/TdpZf2emuIyg7CWzu+S5g23RwFk/EjufrbCSxhJu9057LfNFYr7Os8ZD2IbS80DyNNa27W8T3iKFddzFypBlIJ84H6aZhjX1Sk8QDZt0n3aRx31eSF0RuffvePKtbTT1u7Cyp0/80afVMtZFrl8CAGDLWU+GgUHBmSpjza0O1FpefxEm0/sLJFGTfqtURp0FR/rM7DCsrHPKaYa9eJAckDv07idNl16tT8v0jvfpMWsEha+Txlkd3TR/JTMy5MQMpeaZc22MwprQ2W50Wf3GxW3XgMNv8PQrGgkPwowSSSsPyqrm0kGGstAujxVFLT1ARroj/HtklCEqgBNx0qHedE+N3Ip5/0I7+8pMRv2M4lvJAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qmo4VmtOU25JWHVTSjlsRGFFUm9VSFJ2MmY5cTFkSitzQ3pwYkUyYlpsNHlh?=
 =?utf-8?B?SjFvbkpTMm5VMjQwQUxEZko1c3dOUU5Ea3h2aGNBSzhFSGExbU1xK2lEcGdK?=
 =?utf-8?B?dnNNR2dIZUg1SzFYWHZVQXhuTEZsWmhsNVhtaUVDd3pHc2NQbExXTzNlS1dN?=
 =?utf-8?B?dTZNejROOE9wa2pscTdDdlE0bnZpOVpYU0d6YkNrZUxFRThMNDRoZ3JvTmZo?=
 =?utf-8?B?bVFEV29ERkNHOWJlUmZnQzltY3NhWGs5UElncHZDeUl4Z3NZdWEzK3BDbjJk?=
 =?utf-8?B?WFN2VjB6MzU0cVA5VDNHcFJiVGpLakljRUJhS1lmSC96WmVkWEVFYTF0b0RQ?=
 =?utf-8?B?ZEliRVpLalBnamFGdzgydEllZW5ZeEJxV3pSZ0xpM3pxSTMra1VvcnJLeGdJ?=
 =?utf-8?B?bmZtd1NBbVNtZFdLUzJ2SEJpczM4c1o3ZVN6cXBtdDkyN3BiaU10YVJmcEhh?=
 =?utf-8?B?bnRwVmpQYzcyMTN3WDM3YjVYS1JramdBS2FvdTYxZkx5ZDNMRjRDQkJUUWhV?=
 =?utf-8?B?MWtqTTVMZzNCQUx5SWVKTkQ1TmJiR0RLRksvVWcvWUJJaGxYcFlRSUw5Y2ZB?=
 =?utf-8?B?LzkwcW9nMkh4bFBKL1o2MklEbkxOM0hKN0xXV0dVL0t2Sm1qV0x0S3hmYWM4?=
 =?utf-8?B?cis1QUErb3M1QTVjK0Rna2NqUVNFSmdBYUFmZXJtcnRQMUdBaCs2RTQrU3VI?=
 =?utf-8?B?Z3pqQXk3NXRHdG1ZbUxnNXNlV2lJLzhLTmpmdy8rUE5xNjR4QVQ1RjFsQ3RN?=
 =?utf-8?B?U04zZTEvT09NVEduNER5N0FmL2ZwRnFVS24vY0IwWlB3RHFtcEg1b3F5UkVC?=
 =?utf-8?B?OWgyektlOE9jeGRVWDZiZ1B4TUo2ZVhlUS9lU2NHbGduL2htbjc4Ulh0MWEr?=
 =?utf-8?B?NFdzdXF3V0ZuY05UNXJFYzI2T0s3Y2oySkRMNmZyYUVYbWtLckFuUTRwYUlD?=
 =?utf-8?B?TmJ5NExEU2xwemFtdzhIQ2I0azRlVmhOMUZtQW5NckVaeWs3WFJxTFlsTTN4?=
 =?utf-8?B?QVlGcXhlL0xZSEp6aGxxM3hNc1lGNmZuSXJVQmlBNklkdHYrWlllYTdLNzJS?=
 =?utf-8?B?R3NzUDFldW12RUlLbEJxMzN6RDFMS2UxVklUWkRhRFRXL01zc1BsMnJtYjdX?=
 =?utf-8?B?aVhjenkzNW5tNXhyN2pyQTRtYWxPM0Uyb25JNzRGd1ViU0ZORW84bGZhZ0ov?=
 =?utf-8?B?YmNvZG9nTk1PK3hTWksvV2dWZHdOdUpQNkdaZWEwbU5FZkgxblNJeEhkMXYz?=
 =?utf-8?B?ZldaZ0tWQTZ1L2dvQmdxOFFiSHp0T1BVeEhCbWtmalJXSVI0MFpRSkRydUdp?=
 =?utf-8?B?QkZLSENsdmh6WURSclhHcGdqMVhQVnBwSXc1eVc5aWJYYXlCalBjS3U0YlF3?=
 =?utf-8?B?bm5MUUtYL2QyTGlvMEZ1b3MrR2xFR1ltZGhsd3Z3NmR3dXNva3lYUnkwc0I4?=
 =?utf-8?B?V0FKRkdjSkZlZzFnb0gvNnErdDFnaTF2cmM0bjAwbW02Z1FXdFZtZG00RFk5?=
 =?utf-8?B?NHh0WXpLK0JzT1d3SEVMSk9VSS9DZHkrN3UrejlVMUVVQThPSzVJbG91d2lI?=
 =?utf-8?B?bzg3MlR4eG5jYjZFdm9QeWZFSFk0V0laQ01uLzA5Sm1ZV2tZbXowZ0ZQZjhq?=
 =?utf-8?B?ZkFHSEpSaGdjNHpUcGN6OTlOWUFxYWtDYlBzcjJtcmRuVjlzcDBNUlp4VmZ1?=
 =?utf-8?B?MTJnaUNVT2pMbXVwTkVLWE5jUkpmVms3MVdiQzd3SzZPV3hBRzBsMG9TUHhG?=
 =?utf-8?B?LzBvYXd1TVJMMXRNYTZZWEY1ZEhzR3pDMC83QVJsTzVrSUhWSU5vTkVPV295?=
 =?utf-8?B?MlU3cGVCK3BLY3NOVUdkZVJkd0txSm45UktiSWZRZFAyaFhGSEcvQ2lEZ1VJ?=
 =?utf-8?B?K09SQ3FoMjMzdnQzZWthZzl0V0pkVXkzMHZxZ2NZazlVenMwcVhhWUZteWI1?=
 =?utf-8?B?b2doaWMzMStFei9udEJBRTRVc2RxbGFuOEoyMktrNjYzdWF2WlEweWt1Z1Bk?=
 =?utf-8?B?QlU1L1l0RTFYN0R5WGE5dDViRi84cU1GTm5WQVBpdEcxRGx2TDBXeGdFMEUx?=
 =?utf-8?B?RjlQcWJjS2Frb1RPTGJBRllrK2gvTGJNaHRnRDJXeFhUbS9EOFJpUENSWTdv?=
 =?utf-8?B?eHRyY0dwR0UwR29MbzR4cWlhUUJpL0puQSs2K0JvcmthUDJ5TVpUOGpLN1pX?=
 =?utf-8?B?dE5TdG9SeHpDemN1aHg3eFc3MDZDVEtVNC9Wc1RTSWhiM1NBTnREV0Y5Mjlw?=
 =?utf-8?B?aVl3TlN4Z3d2VXpMbHgzakxVVm5aeFJwbWJPeTgxKzAxUXAwNy9SUk1EZ1ZB?=
 =?utf-8?B?clE1Skd5bVhVUGVmY2hTWTY1TUpxaldrZEIxYXdMbjYzNkUyVElZdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844d5439-43b8-45ed-ea4b-08df379e3043
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 22:27:46.6657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxtGKaiyUo8Eewwc3QLW53cOw2TJbESu0TcI5t8n0jhJ0M2A6UTdorrevaTCNIy/8aya0w6r/W7A95JkdhdwDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8889

On Sat, Oct 31, 2026 at 12:05:52AM -0700, Namhyung Kim wrote:
> On Sun, Oct 25, 2026 at 10:57:29PM -0400, Aaron Tomlin wrote:
> > The function_graph tracer records kernel function entries and exits with
> > nested indentation. To perform call graph analysis and subsequent inlined
> > function reconstruction, userspace must track the active call stack on a
> > per-task and per-CPU basis.
> > 
> > Introduce basic call stack management for the function graph tracer:
> > 
> >     1.  Data structures
> > 
> >         Define struct ftrace_stack_frame to track function names,
> >         indentation, and inlined status.
> > 
> >         Define struct ftrace_task_state with a dynamically resisable call
> >         stack array, tracked in a hash table keyed by PID alongside per-CPU
> >         active task bindings (ftrace_cpu_tasks).
> > 
> >     2.  Trace stream processing
> > 
> >         Implement find_func_column() to isolate context columns (CPU,
> >         timestamps, duration) from function graph trace lines across
> >         standard and verbose layouts.
> > 
> >         Implement ftrace_process_fgraph_line() to parse function entries
> >         ("{") and exits ("}"), pushing and popping frames on the tracked
> >         stack and matching bare closing braces against preceding frames.
> > 
> >     3.  Integration in __cmd_ftrace()
> > 
> >         Stream complete trace lines through ftrace_process_fgraph_line()
> >         in __cmd_ftrace() and clean up allocated CPU states on exit via
> >         ftrace_cpu_states__clear().
> > 
> > Tested-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
> [SNIP]
> > +/**
> > + * ftrace_process_fgraph_line - Process and output a function graph trace line
> > + * @ftrace: Perf ftrace context
> > + * @line: The trace line to process
> > + * @out: File stream to output to
> > + *
> > + * Parse function entries and exits, maintain the task's call stack, and
> > + * output the trace line.
> > + *
> > + * Return: 0 on success, or a negative error code on failure.
> > + */
> > +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
> > +{
> > +	const char *pipe_char;
> > +	const char *after_pipe;
> > +	const char *func_start;
> > +	struct ftrace_task_state *cs;
> > +	int cpu = -1;
> > +	int leading_spaces;
> > +	int top_raw_indent;
> > +	int match_idx;
> > +	int i;
> > +	bool is_exit;
> > +	bool has_open_brace;
> > +	bool has_semicolon;
> > +
> > +	pipe_char = find_func_column(ftrace, line, &cpu);
> > +	if (!pipe_char)
> > +		return print_line(ftrace, line, out);
> > +
> > +	cs = get_cpu_state(ftrace, cpu);
> > +	if (!cs)
> > +		return print_line(ftrace, line, out);
> > +
> > +	after_pipe = pipe_char + 1;
> > +	func_start = skip_spaces(after_pipe);
> > +	leading_spaces = func_start - after_pipe;
> > +
> > +	if (*func_start == '\0')
> > +		return print_line(ftrace, line, out);
> > +
> > +	is_exit = (*func_start == '}');
> > +
> > +	if (is_exit) {
> > +		char exit_name[128];
> > +
> > +		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
> > +
> > +		top_raw_indent = -1;
> > +		for (i = cs->depth - 1; i >= 0; i--) {
> > +			top_raw_indent = cs->stack[i].raw_indent;
> > +			break;
> > +		}
> 
> This loop doesn't look natural.  Why not just use an if statement?

Hi Namhyung,

Thank you. I completely agree.

A loop that unconditionally breaks on the first iteration is
unnecessary here. I will replace it with a simple conditional check in
the next revision:

    top_raw_indent = -1;
    if (cs->depth > 0)
        top_raw_indent = cs->stack[cs->depth - 1].raw_indent;

All subsequent similar instances will be addressed accordingly as well.

> > +struct ftrace_stack_frame {
> > +	char *name;
> > +	bool inlined;
> > +	int indent;
> > +	int raw_indent;
> 
> Can you please add comments that explain why it has two indents?
> Also inlined field may be added later.

Certainly. The two indent fields serve distinct purposes once inlined
frames are injected into the output.

    - raw_indent: Records the original leading whitespace count after "|"
      as emitted by the kernel's function_graph tracer. Because the kernel
      only traces real stack frames, raw_indent is used to match entry and
      exit frames against the raw trace stream.

    - indent: Records the adjusted visual indentation (in spaces) used when
      rendering the frame to output, accounting for any extra indentation
      added by preceding synthetic inlined frames so that the closing "}"
      aligns with its opening "{".

Agreed, these fields are not used yet. I will move inlined and
inlined_depth into the subsequent patch that introduces inlined function
display, and add explanatory comments to both structures.

> > +};
> > +
> > +struct ftrace_task_state {
> > +	struct hlist_node	node;
> > +	pid_t			pid;
> > +	struct ftrace_stack_frame *stack;
> > +	int			max_stack;
> > +	int			depth;
> > +	int			inlined_depth;
> > +	int			overflow_depth;
> 
> Ditto.  What are these depths?

    - max_stack: Current allocated capacity (in frames) of the dynamically
      resized 'stack' array.

    - depth: Current number of active frames stored on stack.

    - inlined_depth: Number of active synthetic inlined frames currently on
      stack, used to compute the extra visual indentation offset for
      child frames. This will also be moved to the later patch.

    - overflow_depth: Number of nested call frames entered while stack is
      saturated (at the maximum depth cap or on allocation failure), used
      so their matching exit braces can be consumed without prematurely
      popping valid parent frames.

I will document all of these fields with comments in the next revision.

Please see an example. When synthetic inlined frames are injected, the
visual display column (indent) shifts right relative to the kernel stream
(raw_indent):

    1.  What kernel function_graph emits:

           |  foo() {                 <-- raw_indent = 2
           |    bar() {               <-- raw_indent = 4
           |    } /* bar */           <-- raw_indent = 4
           |  } /* foo */             <-- raw_indent = 2

    2.  Rendered output and stack state:

        When perf injects inlined function inline_helper() onto cs->stack,
        inlined_depth becomes 1. Every subsequent child frame shifts right
        by (inlined_depth * 2) spaces so bar() nests visually inside
        inline_helper(), while still retaining raw_indent = 4 to match the
        kernel's closing "}" event:

           Rendered Output            cs->stack[idx] and ftrace_task_state
           ---------------            ---------------------------
           |  foo() {                 [0] foo:
           :                              raw_indent=2, indent=2, inlined=false
           :                              (depth=1, inlined_depth=0)
           :
           |    inline_helper() {     [1] inline_helper:
           :                              raw_indent=4, indent=4, inlined=true
           :                              (depth=2, inlined_depth=1)
           :
           |      bar() {             [2] bar:
           :                              raw_indent=4, indent=6, inlined=false
           :                              (depth=3, inlined_depth=1)
           :                              ^
           :                              '-- indent = raw_indent (4) +
           :                                           inlined_depth * 2 (2) = 6
           :
           |      } /* bar */         <-- kernel function_graph emits "}"
           :                              at raw_indent=4. Matched against [2]
           :                              via raw_indent=4, but printed at
           :                              [2].indent (6 spaces)
           :
           |    } /* inline_helper */ <-- Popped automatically; printed at
           :                              [1].indent (4 spaces)
           :
           |  } /* foo */             <-- kernel function_graph emits "}"
                                          at raw_indent=2. Matched against [0]
                                          via raw_indent=2, printed at
                                          [0].indent (2 spaces)


Thanks,
-- 
Aaron Tomlin
