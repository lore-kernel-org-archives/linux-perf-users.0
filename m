Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793485777;
	b=e/s9ljnqa+zW+Igs9daM1nS01uvBRI+H3BEEVm/Q8gd2urDo9N2qqMjI6o5lQa3KwlQg
	 StXXDdXnS7BBwaNi2QAGhVLpsRg58YkBFisvgxYAE+cr/CYOxjbH3k4101GxLIXF4yo/u
	 lKWsFXBmtVrU/1VjS5Idi0fHFpzqO9IMNMi3OXXQGcyxtdbJHFs9teywias87GJWY5HaA
	 IYnJ16FHkcs40ILrPK5/kZ9nLmnBiNRjRog/2pNFE2FkwEaeXG6vvm92QTG2fg+k6s9rX
	 +BLCGBPbwn1XMTQs5aCy0ifolvomcQ6kTHL08ZaKYeCJZ+o1ztJ5efZa5cEUREUSaFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793485777;
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
	bh=YJ5zpnlIoFNX7HOXl0AyMj0DdV4QetBaPDRLmbrM8kM=;
	b=VyYTC1yi9v0wdLCvJxjZ//1PjU/WVctDmnzNElSchEx8Jkrzi7ysrwbgX2nLhkVyGrEx
	 mLhcgAY9HgPeau79ytCPxFWnKhLexMazulWFX6EHpvfZCZ2VK6ubW+Od9gND8toomliWs
	 LiAjz1LtqEJoyESLagRu9XXox8wRtkbX7vI0S4pymoAN/chObJzFzwNKBt51EFuAazNA8
	 7xy0bL1FYSbnmxH4pErMLthiLCYexKNw7ejr5IW296gr1Xl2E9jg0zD0IKaJ9o9jq+KAH
	 HnCT0esH0oKEEj5DqqOB6umlyeoK6oOSUsGBH5b9fnOQWnGLAkwfXoMKPyqPeNJ5OWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.74
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021074.outbound.protection.outlook.com [52.101.100.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67A606A31A;
	Sat, 31 Oct 2026 22:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F67A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqNuA3uYEmYndED/DqetEnCDnXqVaG2mKL0UqiDTrgTtW2ZWNYYHHyu6Qa2HTUyWzDm/RHwxAox7xJks8RbLi4X/pO/p31iwDbpJbys/5jP9AGC3vu/jcMgkSJKcsVmlXyayA6FdvggKCl9UjMas5qTzq6VKvEY8UhFmHytnCIiObh40wGfDQ6WXNtg4LrXecOf4L9uE/GltVYxNfukU3p9LkeZfTjv3ECFwZwGZki9QAPdYp5TSJZCkJ2XlRYVBjUvkWMQEt8ZRhiO+Fp0m/HlFU+2Bztvke51b3Ae/KezJro9U3D02YSxt/g1u/vI5RzMgjdb9gNzRup7oPrmcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=YJ5zpnlIoFNX7HOXl0AyMj0DdV4QetBaPDRLmbrM8kM=;
 b=zGF05RTZR4tTSpAp07ss+xsUM/f2OE9IRpDyOHtJhlTuJL/ztsnGqO+W4axkV+muMGMR+dRUjgHA8QNJWfGJrnXVq8P/rxZpcbcUT8+8h7Ok7hz5NSeHbckSu8lg+4vH5a15m9o45NkXK2dalX1UQP2NNPQ2akR+iSzqbJXmcDTV6wlwkvhL3ks7yFFLDVUYDi2S6FDAg2TeYZwv+rSzvpFNfs8FR3oEAOv3xgFlYd/e9jjCpyDY0nYEh0oYjxrv+Q5y97wswsh9K1xaPjZhrMxdothPoaXMdiFiI7hVMktL42XQftVviDT8h1icL/RaqJUnO9ajwPvixjGyHuJ6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8889.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:482::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 22:29:34 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 22:29:34 +0000
Date: Sat, 31 Oct 2026 18:29:30 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, chjohnst@mail.com, neelx@suse.com, 
	sean@ashe.io, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 01/10] perf ftrace: Handle signals,
 non-blocking reads and pager exits in __cmd_ftrace()
Message-ID: <gv2ojndchlo5yuwpqas554vgavuixfoenmaqsulvmqc65itz54@fjumgdv777w4>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-2-atomlin@atomlin.com>
 <auWU4JndXjxKzBbm@z2>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <auWU4JndXjxKzBbm@z2>
X-ClientProxiedBy: BN9P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 2735e3cd-5488-4bfc-42a7-08df379e70ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|56012099006|261028144727099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	45UM8S5VxC+5DNcQWvwblX0zcwCQkaq1AgX7avtMi6xXIUEFAGwV5n48ZsxCjbunvJiBPP+SZ/syIERgznGoATyIEowDhcnEa1x/8Mvdd7rW3T6Unmkk1QPUa0llnPoHVU3hKowBGcpsOfRdkGnSW315BI045VYVskB+I4FQ8e8wg7pH4cbEM1FTmX8W5cjzVZyrhdv4+v6whNXmR8JJ3HknhYf4UzCXDGbMWz9/Mx6xZOYCilEytLPWzmPuT3MV7fz+lYgX5yMvU4rsN8W5lPVvfEECLFFHTR9f5gSzZRatkN3iKsl2j+W92YdAa6WRm/x/D72Z+MRIuN2zIlJA1g754shnL5QrqPE0mfvfEwod/Ivt++LssPRdxOQySjevdZTJ6vIsvZhq1N+ScI8izgrL9bVYk22NxZNT5TSNznH0KYILFwkUYogHowv0ZSEN1njfdBz+/hjfvE1V/UQCAlXyvQUxqEnm63fHRlhRGsmOABguJXxpMxjLZa9ZgmOKZWiMLApIYELgcOtfhbYhKcnM+40uoJ578vcHJO2AFkjfDxwMsYFVEQOLSFghPw7pAqdwj3M/Qy/IlB/m3K+qkkK0sh1Ucm0rlleAe3j1RuASJK51oMXSm5aMa2tqSEaErO16hbh7BDCR0ODd9k/ZQZGsHL/SKUIQb5YbSuY1S/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(261028144727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FPYTF6UHN3cGlqa0FiblVHS2FTNUZFWDVNR1U2a1JiYjc3ankvZVR5VTUw?=
 =?utf-8?B?U3p6UlRnb053dU5VcVo0ODlXTWFIaHRNd0VsY3JqWlVnNUh1UkR4c2dqekZQ?=
 =?utf-8?B?eEQ3cTRrWjNQL3NvUCt4YW9hamFpc2wvUU1XOE8xVzJQa3JMbkk1MEU5amkx?=
 =?utf-8?B?aUQ4SHcxL29XeS94Rmp2T2hSZHRvYldIMElnVklISG9wRlBKQk9OQTFpRzE3?=
 =?utf-8?B?L3NrMUVEdk9nekFiSEQ4VHNUa2hMK2Z1M2R1SE1Tb2d5YmdMdVVvejQwTTVC?=
 =?utf-8?B?eHU1ajRoVjJ2VEtKcXhYRS9xaWFuYjhvaU9wdXZEM2IvMnNoczNoRHdmT0wx?=
 =?utf-8?B?QS9QcmtGUHFzRmdudElGLzV0c1REeGlpLzZ1Y3RPZm1lamdNK2hOUWZpb0pE?=
 =?utf-8?B?K2x4NE15aWhNSHZ1aTRsMDJIMEx5TC9zWG1jS294UGkrRlJ0NGlCTmd5NmJ4?=
 =?utf-8?B?Tjh5V1JYaUxSakp3SnJ1K0pzOVgwV1RRYjBkZER0ZDl2azRXc3EvK0lzUHFt?=
 =?utf-8?B?TnU3aHlhRDdCTkFDOVJWOWl5aU9wbjNaZmZUVW82TmJQU1V3WGFnT2xCc3pi?=
 =?utf-8?B?TC9WTzZpeHN3Mm9SQSsvaW83SDBwM3F4Z2ZVSGt5U3hjWGpUYWR0aGtYMzd3?=
 =?utf-8?B?NU5welErSWtORUNZUjFmWWFLU1hhU0E1K3JseTRCL3kvb0NySkc1bDBMS1Jp?=
 =?utf-8?B?c2pUSEpBb21WWForQWEwK1psM2N1U3FmNWU3dHZFRWFxZDcwbGRwbXB0RzJL?=
 =?utf-8?B?NWFEV05pYUpxM3lYUkdjV04zS2JZd1A3OG5Sb2pHcy9iSm9aOUQrZ2xYOEE3?=
 =?utf-8?B?Tm9sdnpiTnNCNURCWXEwTk45dmU1NEc4dERaN293Vms2ekZDZnVQem1JVEZG?=
 =?utf-8?B?TGdDUTMzMWpqclpYa3JDaTVvZ3VpM1pTRU84b1J6R0hhWDZMdEh4ZjViNkR3?=
 =?utf-8?B?L0dDMjdxSExieEFsOGNzZC83dm1lSkVyUkZ4ZkhhSk5zWWl1bmtJbEJ0REFx?=
 =?utf-8?B?WmszMSttUXhCZVl6dDhSWTR4YUwvZkpEZUsycEZGSW9TK3lsVmFQNFYwRG51?=
 =?utf-8?B?a2M2RGJpOXZ2RlFZTFRaSm1sOGE5R3J0ZEljeHByNmcxNG9sQ1AvUjdQemkr?=
 =?utf-8?B?S3gzd2pJVitCQmFnd1N4UG1zZ1d2UjNMZlQyVmRRTUlUWWE0Y09GWEJzMjI5?=
 =?utf-8?B?alhYbnVFblJjYTdtbXRFaEVDTmdMNVZkR1hSblNoZmN6WkszMm8rYSs0cjEr?=
 =?utf-8?B?Q3ZReFFnRGgzNXQ5NlBabEdtL2NBT29XdWFUaHFNK2UyTE5QaW1OMUt1QllZ?=
 =?utf-8?B?YkJuTnNmbzhNKzZVWFlSZlpSc3FJOGRyTHZraEh4K3ZYLzRnblgzY0JrY1FB?=
 =?utf-8?B?MVp6amRTMEJ5WmI1YmxpZE1WUm1VOWF3TEpFeHJUOXk3dnpDZnRFbnNVVnV2?=
 =?utf-8?B?ZVdWTllSazgzYW9hMFIyUkdsSE5WQnBTWFRUZjJaUGVueFplMTNyQmQxYTRh?=
 =?utf-8?B?K3ZtbitXajZCOUhwV2xKaWliTnE0a3ZseE9UWUJCZi9tTXJFMHBkVktFOXBy?=
 =?utf-8?B?c2VNdklYMWpUamhRTXVsVGVNd3Y1S01FbTRzYzAxbW1KVm9oUkZsSGp0UVl4?=
 =?utf-8?B?bFZ3Vk9wQllvT2w5OHpRdVJjeS96Z0crQ0NnUmRpNENPM043S1VWYzhsdHdK?=
 =?utf-8?B?NGxoQzNtTStPbS9pTWNTQi8xaDc2Z24xblpqdW5xcU53RWxEUWpXT1NGdk5s?=
 =?utf-8?B?aXFwb2h3RExIWUcrbFNqQzNlSUQ2akRGWUx4aGUyemRjR2hDb0hSaHhHTDY0?=
 =?utf-8?B?V0laN1ZzYXEzUGRVR0s2dnRvWE0wNzR4QTlEODFlMmJTUzhLb2pGUEFBZTFi?=
 =?utf-8?B?Qm5yZU9PTDFzTXNWUGhDdUVPUGhqbE1PcjVnYmQ1U2c3dklMMzdQbkVPcGhX?=
 =?utf-8?B?aHdLaVlNTGo4OTdPWFB6RHhXVDhLZnNPYlg5K2dKdmlpbFV4QTlDdmN6ZUhY?=
 =?utf-8?B?dE1HV3ZoWDVlSTA4THJoVWFDcDF5WEVhQ1lIZVA2N3ZLN3FHdjBqYmJ1UGMz?=
 =?utf-8?B?K2pxb1QvOUlTT2hTNmwvU1Z3Wlk0REJNd0NCUFIyakY0YW5sbnlKK0k0RTN1?=
 =?utf-8?B?dnE2RFhiZkN4VWFzZ3lieUpva0QvVjgzc1lVWkcyVUp6WXJPZkJJcGhXOWpt?=
 =?utf-8?B?aEtBNGlUNGxJUjBlZWFhZlZrdVZJWlVQcHBjeldHaC9NT2xhWEdiOUNLSVgr?=
 =?utf-8?B?TGRPN3k1UElNL1o1M1pqWXI1N2dlajQrdGtWZDhxOG9tS0JXcDRtV0QrT0c5?=
 =?utf-8?B?QWpkT1BzNWJaNU5XYzJBd1M2cS9sekNkclowSFNYeThSb25SZW9VZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2735e3cd-5488-4bfc-42a7-08df379e70ac
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 22:29:34.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raSDtL63Xk4tywLZCprITiBFLf2lpFshqC2wg+QFD6v8tRWrmUGIH3Ww2TG8bixe0+ve4B0e2TVDAH28aFcKmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8889

On Sat, Oct 31, 2026 at 12:12:32AM -0700, Namhyung Kim wrote:
> On Sun, Oct 25, 2026 at 10:57:26PM -0400, Aaron Tomlin wrote:
> > In __cmd_ftrace(), trace_fd is configured for non-blocking I/O via
> > fcntl(trace_fd, F_SETFL, O_NONBLOCK) and polled using poll(). However,
> > the polling loop previously treated any negative return code from poll()
> > or read() as an unrecoverable failure.
> > 
> > If poll() or read() is interrupted by a non-fatal signal (i.e. SIGWINCH
> > upon terminal resizing), errno is set to EINTR. Furthermore, read() on
> > trace_pipe can return EAGAIN/EWOULDBLOCK even after poll() indicates
> > POLLIN (for instance, under concurrent readers, spurious wakeups, or
> > block-mode trace iterator options). In all such cases, breaking from the
> > loop causes perf ftrace to terminate tracing prematurely.
> > 
> > Additionally, output errors on stdout (i.e. when a pager or consumer
> > process exits, closing the downstream pipe) were ignored by fflush(),
> > leaving __cmd_ftrace() polling indefinitely until the workload
> > completes.
> > 
> > Resolve these concerns by retrying poll() upon receiving EINTR, retrying
> > read() on EAGAIN, EWOULDBLOCK, and EINTR, and breaking on EOF (n == 0).
> > Furthermore, detect stdout errors and broken pipes via fflush() and
> > ferror() to exit immediately when the downstream output sink closes, and
> > handle EINTR and ferror(stdout) cleanly in the subsequent buffer
> > draining loop.
> > 
> > Fixes: d01f4e8db22c ("perf ftrace: Introduce new 'ftrace' tool")
> > Cc: stable@vger.kernel.org
> > Tested-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung


Thank you,
-- 
Aaron Tomlin
