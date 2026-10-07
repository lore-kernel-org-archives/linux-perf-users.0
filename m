Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022096.outbound.protection.outlook.com [52.101.96.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87538B158
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389048; cv=fail; b=jZp657pPsztqsv0EC3400MdyubxGcSxFXH+1q2Le5yhp47JvMDmuBiCOguZakzgjFWjkydpdzyny+smbuxNKDLtwEX6qjTnFJmkNm2XBhjLGWsJl4bb/uBnWASKKV84a/BWCidpVe8FJhJEofu9CfQNidq6zbderokWP7SyE0X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389048; c=relaxed/simple;
	bh=94WPvwOF5+LzjXJCgHgPzCwIoF3pXDK60JYv82u1Q4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I/w0+VYhIj0L8WhQXbuJXein7E0LGDI/L6+BjrzYRNr63lcz+hp54XCU26B4oFoz1dL4A9PdP99/iE5Sb+pLnYca4Id5ci+Qr0Mnt+e6pGTe4vtUk9k7toVi0UogFUUtw8t0NzOQgIIF49EH7/PtGiBVxqDWMITDOob78wRrI+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e38WV8XyPSIRVpD3Zo15PKIMknsvPcD4aHV1FZbJ33M1Wwg0knrLVKsZ1NWBzBJwkff/rSmWJKhfT1kCZrBGB5usfZI+qhSVR3Ex0cb8Bs+RkaTzgyyC3TU2juebJTcbnx/OTeCBOtQHurJ+82k8/frEMLxuJduzRxM6ateVjq0MgwOqd/ywzHhfXriShgsLAGR+ijI6qRiwXZwXV+tHJl5k3zq6Ofvc84H3bbHvARa4UyqD21TOjoHwgCntaXRnQbs9tRCzYQxRLCgKP0Lk0jYgOXRfKLxsjyJ5oEvmKCGpTC9sj4xMk7exJJoYAEfRjl9KqQpgB52lfBHaV+b9aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=covI2A1UaID/n6cFQFvhWfRxCv2W1Qm6pSqxz2oMuV8=;
 b=Ve/u5MiCbl72d0BwL5TGq7tx9UOksZkJ/hP4Cc1KCqn0gYEmdvTu71nkDICS6MjDrmwh2D+8HtBRYiGPu91u0BUmjQRnzfsiQNevD2mdInVe5TY5fsh2wboSbpLpzyy3yRzgbiWXj23j004xw/CKM3d+4ViE1J0g9ppSLtp5H/wdVi7uzj4jJozJ18y5b4oNICKxichntSK3/0dqASOEWjMViwP9xeG3iGp0JkZJiwBc41JkqgC2ISxqmOqQNsRpwGB15fYelTCRPUBYDts41FA8Lfle08mCCytl60L8aZ/wy18E/x4y4SGFZvZM+mAmkAVGxUktqrdgBx70ptRlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6693.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 16:04:03 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 16:04:03 +0000
Date: Wed, 7 Oct 2026 12:04:01 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v2 2/4] perf ftrace: Support filtering
 return address comments
Message-ID: <ern7gdkhtfndho45foktcia7anawej353v27wxbiauod3f2jaf@nnbhzgwjxmsq>
References: <20261006232756.65620-1-atomlin@atomlin.com>
 <20261006232756.65620-3-atomlin@atomlin.com>
 <sashiko-outbox-162514@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-162514@kernel.org>
X-ClientProxiedBy: VIUP296CA0043.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::19) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: df527df6-e282-4fea-db81-08df248c9b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|10067099003|3023799007|56012099006|4143699003|27256017;
X-Microsoft-Antispam-Message-Info:
	XOz5nvmEsa9W2CGPoTCHhVy+t2VZ3bezep0lmBWbvUZ6MZyUV8hFRK/+VRKRqyywemlMcJt7SSJd8ZPh+8u9ml8UsRgCEGKMY62G3PuR5Wp8Gw5MDLNTEUttBca/Y6OVtAWS7vO0/SoNyxVTkzejKtKjdA9FP4QakY0cgzYUiRn8LRFJmopjWKFq3wqbwlrQTQ9AjNrbypNIkecdaTv+8h1bPNkIMKIsh+OH3KNRsBpq8fqMqg5z4JbUQXRTR5TzNc43/pAUFfoLhXKwAUrYucfoWnxQLhUK80UsxfnnSlw9Fyvjn9eMl2xo/Vm0dlLYeD6uI1En6ySbOcuxXnvw32Xi3gGHwKlXjtvbFW/zkscec37WUnaKtPxQeGSA3/9B3EVxX4unYwD+aZjGzli6tf2BZTIL7vmzIioOeUvtnqpIBc53aAnzHj+uHq9MdbieT8gRpH3e9PDA/J6mOuHxK+Zv+sHP7236U9xa9k5PVOVD37JCgdGNQQ08ZnzlWTCt7oq7iONnnt3MXCwQYH38PlS79rEhGZ0Dfa6gu5CHnr/XQW6euLDcgPqrg+W2ORRBai7bBbKIqf6deUm4+LnnxwB04fDAzFUjAG1YGyF9Nm7etLVcuA7q3taaXcpI2vMfRcqwnR8N9CQWbX7rIaoF67pNcdMvun6B60+t19BxrYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006)(4143699003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk9jdUNKdTdFcjA5dFBuOEU3RGxXTGpDUXNuWHNtSmJVSFA3REdsd2J6N3hH?=
 =?utf-8?B?TTRyNk9jV1pQL1dScmN3MGx1aklnanEyZUFaNHJwcmxQUi8wMHJHR2UvcEND?=
 =?utf-8?B?czhsMzMybzhURllxYjd6dnRtTk8vUk82b1QvQWlYTHErTjJvbW9OS1dhbjZo?=
 =?utf-8?B?SWlQY1RCc2E0aFgxem9XM003M01GNUtUZlpCenBaZ2NqRkNXZFptUHlCTGM1?=
 =?utf-8?B?V0JhY1hPd1NIbGh5d2g5emJ0RkpxR0xwZ0pENDVoY2tKN2g1dmxkOHZtY01C?=
 =?utf-8?B?QWtDUytxSUs0d3BKZGdpbms5Q0xzQVNUTWRxSlUvU1VaeEF0QmpoN3FkVmYw?=
 =?utf-8?B?OTFZcWdiNWdFQklEc09OTDJHSnpqam9TVEIwMkZGN09nK2tmeGE3T2xaZ0N6?=
 =?utf-8?B?RHE1Sjk4dVBxWVkrMnQ2MDlLc1FmTTZicXJHRjJEWTMwOHF2R0pCVWJjMElB?=
 =?utf-8?B?THd2WmdkUy83azJmaVlXbk90U3RCT2FKYmpVRVlhcTRXeDhzTUdiS01MeE9w?=
 =?utf-8?B?MWJPNHlxZnBsZHIyZzBMOGZibVBWUTBES3pKRHlLdklPQWN1THdGMkxuVGVM?=
 =?utf-8?B?Skd5R05NdWFaWjEza3RRSzZaQUxwdE1zeVluS290THFjRThOc01MQWM0R0ZX?=
 =?utf-8?B?ZUxzNVRoL2tqSG05RGl4ZUV0b3Z5RURIcmNCYmp1TGo1V0hiUWZWUEFxMTky?=
 =?utf-8?B?QzY1M3R0MHU2eXlPdWtOZndhZ1JBYzAzSU05a1RRU0ppNHEzQzJ4TDVld3ly?=
 =?utf-8?B?R2FXWm9EdW80VVA1L3NOVUZjRDkwbkZFOG1jWTVTR3QxdXYrTzREZ1ZIdy9u?=
 =?utf-8?B?UitGSWZBeWxGcTg5ZVY5cjlNOGZSUlRVa2U5ejlvSFdGN3k0VkpKSlNtLytz?=
 =?utf-8?B?V21jSGQxZXcyTkxYaTIzck5NMGlyRE10TG9MV0NZbndhYi91VGpGZTZtYksr?=
 =?utf-8?B?ZVlHOHNhVXI2aHlNSTZyUFpUUkM4LzVmRGtPV0hRNFVocTMxUjl4bXhRUEYx?=
 =?utf-8?B?d1hiVWpDSEViY241aWpJSWhBYm81YysrTk16SnhXVERBejJaekc4MkxOSU5F?=
 =?utf-8?B?dFRCYlU4UFJVY1V0Z00xbGM0K2JKQmQ0RmpKT0owSXpVRUVQdUxWaXhQUEJv?=
 =?utf-8?B?Vk5mZ0NSMnM3Sisvdm5IWUdUZzJzU1JzaEhjektwbzFLZGZoTTJrbHNLdGR0?=
 =?utf-8?B?Vy9pcEtPZk5mU0puNzc0OUc5R1l2ZGhwd09xU2p1aERYOXJwVi9OYUFCM2hr?=
 =?utf-8?B?UDNBQ3U0TDJjRDVwNG1QMzFmN24rTkErMGlYY3I2TS9RNWpldDV5TDF6Kzg5?=
 =?utf-8?B?UVZkK0xLUktrZzYrelpsL29BSnRYMlpUMUpTNXpNTHBjMWhQYlJnM2NDckJC?=
 =?utf-8?B?dFVDRzhFUURQYUZieE9CNytzdVZpM2s1bWVEY1R4ZjYzMHRoQVRkWlpaMmR3?=
 =?utf-8?B?WERKeUtCNHRMMlRaT212MWRmR2dSWFdSbTNac093M2NmbEQyZFlCOWhoVW42?=
 =?utf-8?B?Y2NOT2hxSzZPcXhzbW1qd1pJVkZjc0VpZWt2MDBUUUg1L0hMdldhREVVYWJi?=
 =?utf-8?B?VnFHL0c5bUZpZnBVck03c3g4VGlXa09qQm5FTS9hZmE5cEpWWG0zclBldHRn?=
 =?utf-8?B?akpqRk1GeVZGck8vUlU2NDdTK2VPdGtTK3hRVnhCbXVldUp6dHZJSnVPSUZC?=
 =?utf-8?B?K09IUysvTVd3WTBNdTVzamxTcTJtdWd0Z1AyckVFbW9JL2dyWEZuSmFvOUVP?=
 =?utf-8?B?bmc4SjBwZzBTMlJ2K05TYktrTTRhS2UvemZnWGVxQnRTYkxNKzZCOE9ZWGxO?=
 =?utf-8?B?NGdydDBld3Y5M1diL3VZTFd3Qmh2bk1KaytuQktRUmJMVm1XMjM1UDlQS3lS?=
 =?utf-8?B?VlpwN1p0bERiMmRFV2VtRDhjV0daeXJhN3RqdTh6Y0tXVlIxWTdnWU5qZFRi?=
 =?utf-8?B?UVhTaHFndE91UG92OG5rZ3lIQW5rWGhvYUdWcVM1TjdEOXk2eEFwZWVzb3dJ?=
 =?utf-8?B?clZiV2pCMGpXYkFScmRURjdRaGRLR2VsSG9maE9WQzliUndPQ3ZKTnlKZStl?=
 =?utf-8?B?K0c2UE5UbFg3ZzBSZmp0ZFMvcHk4VFZDdTgwNEgydCtvRXZUUG9KT0t1SjVR?=
 =?utf-8?B?N0JKZmp2a3NEV0I5cmRCNUdXSmVHcUJiWUxPak93a0cyT0F1SURJUXhwNzRx?=
 =?utf-8?B?T0ovUnhST0Z3ZHZyTjlNaC9PODFwZjhiYVJqbTBnTnNRN09iTVY0ckJjaHZB?=
 =?utf-8?B?SG5xTHJMaVBOcCtYV1owdURORWg3L1RJci9QQVdIREVTQ0psLysxNlVqNlYw?=
 =?utf-8?B?ejl4UUNyVG13VUVVRjBzSnIzemRYMkVlMGlKWVZMN3hJdXdzVDlNQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df527df6-e282-4fea-db81-08df248c9b58
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:04:03.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uSUg5bXaWFBCFiLs0ruLG/MycthLd3+fYn+lYkcdZ9H0M+LDAqWVrgpFNE1G0EcWFdwa/hF14lm4yaESE3X5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6693

On Tue, Oct 06, 2026 at 11:37:04PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf/ftrace: memory leak of trace buffer on error paths in __cmd_ftrace()
> --
> 
> commit 473e334ba892f3b7d5261168be5e86956a4de438
> Author: Aaron Tomlin <atomlin@atomlin.com>
> 
> perf ftrace: Support filtering return address comments
> 
> This commit introduces a feature to filter out return address comments from
> the function graph tracer output in perf ftrace. It implements parsing and
> filtering logic, adds a --filter-retaddr command-line option, and includes
> unit tests for validation.
> 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -827,6 +827,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
> >  				break;
> >  			for (int i = 0; i < n; i++) {
> >  				if (buf[i] == '\n') {
> > +					if (ftrace->filter_retaddr)
> > +						ftrace_filter_retaddr(linebuf.buf);
> >  					fprintf(stdout, "%s\n", linebuf.buf);
> >  					strbuf_setlen(&linebuf, 0);
> 
> [Severity: Medium]
> Does __cmd_ftrace() in tools/perf/builtin-ftrace.c leak the allocated buf
> and linebuf on error paths?
> 
> Looking at the initialization sequence, buf is dynamically allocated and
> linebuf is initialized:
> 
> 	buf = malloc(TRACE_BUF_SIZE);
> 	if (!buf) {
> 		pr_err("failed to allocate trace buffer\n");
> 		goto out_reset;
> 	}
> 	strbuf_init(&linebuf, 512);
> 
> However, if get_tracing_instance_file() fails or trace_fd fails to open,
> the code jumps to out_reset:
> 
> 	if (!trace_file) {
> 		pr_err("failed to open trace_pipe\n");
> 		goto out_reset;
> 	}
> 
> The out_reset label is located after the cleanup for buf and linebuf:
> 
> out_close_fd:
> 	free(buf);
> 	strbuf_release(&linebuf);
> 	close(trace_fd);
> out_reset:
> 	exit_tracing_instance();
> 
> Will this bypass the free(buf) and strbuf_release(&linebuf) calls, causing
> a regression where these resources are leaked when early error paths are
> taken?

This will be addressed in patch 1/4.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261006232756.65620-1-atomlin@atomlin.com?part=2

-- 
Aaron Tomlin
