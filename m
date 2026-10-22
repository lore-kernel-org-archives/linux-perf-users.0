Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679474;
	b=X9f9PCXuGMKhsGhhVjVaakfBNtcrS8LisS+m8dKowaEwoYqH4O7mRx2IeOJJe6f00uzV
	 A7MXcLp6VRqIOxAxN/owFtqXyys83/w0tJsLdukrZ7O6xUsL7A+F1vJCxIwRHJrMJWOZU
	 Qg3hbnI0vAixMgUdQYhYDrvmlm5RYd41kbudDgjNXjEatIkR4ZIyR6j3vsb3p4q/rbj47
	 RUMxI1hyOyu3l3UxBi1A7nSDV/0sUbSLTTBorCjeZ6Lo4OLadCWzXvhcljevxzA1w4EuZ
	 SHKAYlY95pUvPh+S89hvTisuCLy5jgf4Jh29UZvWBLbCFRH08GGDLTfCK2Z1te8ZuiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679474;
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
	bh=hXCTjJuClfQgaUB0biMMgiEoiG7JI5xsZjnMtUaMqjc=;
	b=bVqjRYxBIhBdKEya+v9StKeb89IDeBnZh19BuM9YRYZakBEUt/urtof+/PxjWy+D7Ykm
	 xqHbwZ31UqsN1oDNbmUd14qksr0Iqjp8+JEQo8MCdf4kPUJ7/0m6X1QbBazr1NOnqTRk2
	 VYX5MdxoTP19H7+2rnnA96VXHgAFgVApny/eHgN7Yko6erfWHPqmzmx7q9xLErhphS3Aa
	 m1hU1mS3D1fKPCMxGAE73Ok7ldiwGWBbBU424Vj31lSaGO9nPLIYKNXCGurTYnAoCnBa+
	 Gu/7EA+ryLja5RYgczoKC1OBEz+mNOpT9ZxOxNP0pr2gjxHsZFf+n+7ISEKMxr/Rzhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.80
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022080.outbound.protection.outlook.com [52.101.96.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD6606A31E;
	Thu, 22 Oct 2026 14:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DDD6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDy1Q5CVgGMGi31T28HEBxGhDgq7xZSbwDgG+kyI7KKltCimxgaqXco8ZA9U0ynry9mkd8W7rUdadaf0cgJ9rtyHE2Qij5nvFa32tS/UE1soyYcW+LDcUcTNeC5raTOznoMCufUAA9A3DPa1Ni2WWBHUXCKJUvaSxiHhuHFhbOl/aQnVn1lwzRL/mFyRV4POFi4opieVNaYRlNVXD3Lg5eb7dq3U77unZ/tkHBrj7vd2blT/eD2ieYCmtQOtHxy3kOW2QbQ39I0Cg2Ie/qaMV+7wrBDy8xoQEeq1+Sj2+UgujcqENzrwfhP2PJYezadQ7pLuZ377x1iS046ZX9308Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=hXCTjJuClfQgaUB0biMMgiEoiG7JI5xsZjnMtUaMqjc=;
 b=SpX4BjsHWrvCT1PjauUDayIDkuKi5Df9me3GWnLLU7whZn9RqMTphVWdwPyrDRXcw0bLPwMnxxQ9xvWvMcR1A2aAq6GtHlTLwFKlo+FWZ1p49TpxVK8+ZnXgvepr5l0XPjVXC5z40xzemGMI3fLTREFTMv/HSNo+VuTd2eF9PRZuJxW5uF42CwG+Ovq1IVo8A811LSOnrST6RWLObdA17/GQiumqc2n6nZLQXXrekWmFHyABxFT/gKig/rW2OwPT1rMn6ozw6YKTPi0EWfNZWtLjtV+NcYbGzsp7W/fePQynPs3yQzbASAKM5VTl9jLe30Fx7Sakt1pVnvplpZ/UIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7023.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:336::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 14:31:08 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 14:31:07 +0000
Date: Thu, 22 Oct 2026 10:31:04 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v9 1/6] perf ftrace: Optimise
 __cmd_ftrace() stack frame with strbuf streaming
Message-ID: <xk67hbgc4vluketlqbzyggvbl3nqa3mkxaxxyn276ijcdmlobo@2fwziiugn3xr>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-2-atomlin@atomlin.com>
 <atlRFHWsyxcO8PQJ@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atlRFHWsyxcO8PQJ@google.com>
X-ClientProxiedBy: BN9P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: f902ebd1-4dbd-414d-fc4b-08df30491c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|10067099003|56012099006|261021121427099003|6133799003|18002099003|22082099003|261021123027099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	3LhbQtd35Ixvt09SUxirBZIQQaDMGwyYzrxQsIu2C7B/91QQydT8WdVWqI9fyRnDrfTvYevcyI704Z9+S7Ef57NO0Qcb4g5mLejGAjb9d4nt5adH8PuChcfXSIWPd0UIWRt8Pd0F2tVuCbT03aPOgytv8Erm52ehVPZaZbjEP+2U1eEIZoD1F6ZFSa+2JJgJJbbXHorebp9BXtaa2Q/uKOlQjekwYfuiKi7kb9bTsNZqgQ+sZojMzrIfN9mQ5PwcIrgLOCgPiwL+hMKpan0qOm5/9mXFfLpBthJKatLZsYoTOiqQC7W/kR4eSK1qkGqTFwUb/rk5BBo6EwhwGbXEo0lgRhRoZOJ3bd+vy+nURYP+sCZz3V9Ob7GfItZjRpcZikUYpBQJGcHB5YRD8Vbx9BWWtBr3lSOfrihYxX0p3EWIqr1QOZIoZ93LlVQ0bMHOZ/5xx374Grw0I3YcaAUEHuTMv4/q1yaBWb+EreqKW1IdsKrDoLvxxiXmn4Wpp0xMDWl+O5bL0/7s7FMFP5YQaSDNiDy7rGRQ0a6FbGX64wbScQvg4dCMa1UaNnt+s64RGwy0iC89hD/XsFBBZ1ILE4nM3ZV6QhXSniaLTRtgZj6rhLxdZsLM+XBDVfygzoHaQzzXcgq1V0JbjIL40AopBAKPj+K94H/Eb/U9FQ77ULk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(10067099003)(56012099006)(261021121427099003)(6133799003)(18002099003)(22082099003)(261021123027099003)(4143699003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlFCQ2VlUk93NmRhSGVGaGxxN0FLNzUvT1IzcVJaV3FRUTl5Q0RaZkZFYnZh?=
 =?utf-8?B?bmJONzBuVnRINU1seEw2WTVWR3VJZ0huWEJlaVJHek9RbnRMZStDRk05L3NX?=
 =?utf-8?B?Nk02SXJVN01FTVBJUUpBNW9QM1RkNmlPT21GMnBLUzRXd3VDY3JZTzBRUVRZ?=
 =?utf-8?B?SVdjcXl3TGR0UnZXMkgyb05JOTlHOTBGeXVuRWs0TTgrUlV3UkVUZUZTZWYy?=
 =?utf-8?B?M3BNMUF2UTdoTGVRd1FwamoxR0hFTHVYSUdWalQ1QVhaUDJYQ1l3ckR4SXMv?=
 =?utf-8?B?UElDTTdYdjJBb2dpY2hFZVV4dW9XQTVCeHp6aTN5MkFEODMxZ0FNQlJDYWpF?=
 =?utf-8?B?YmJ3MGZubkZicCtEUmZvMEFvSFhyaWV1VlUxSjNSM0RqaFErenBONlBnaEdJ?=
 =?utf-8?B?NTdYQWgxbyszKy96RTVYZ3JBb21WSGFPRmpDM1dZWkk3a3JnZ0NZeGhhMUIr?=
 =?utf-8?B?N1FaK1lZNTc5Y1BVT1ZnNkswNmFKbkJQQTlTYlB3bWtzTE1PZURwSlhFTTN5?=
 =?utf-8?B?RUtUazNXSjUxSEs5aWZyNElIcWpYdUxmR1hWaGo2Qm43YzdqbWFZUVdlNUhB?=
 =?utf-8?B?YXBmc0JERTQwNU1sbVdsajl2bVZ5WmRRWW1pTjJSMUQ1VUk2dGdRanpvbkNO?=
 =?utf-8?B?SGV2VlROUkpUMk9qMEw5V05GUU9aNHRwMm04cURkU2xYS3JIZEduU1Zoc2hi?=
 =?utf-8?B?N1E0YlJjSGpWYjRoMjJUN0dRR2JmRW5PUnBoMFRDYUFtOW5LTGxlSjRsSTdp?=
 =?utf-8?B?a3pGUnRpTWNEMWErTWR4REVjeW5OL05HUHVFZ2JQTW91SDJ1STlmNXFzemdE?=
 =?utf-8?B?ejZGT2hydWZWSVVQRUdnNDdTanBEWVJLTXlSS0JFT0lYWktrNjB3d1ZDQUZa?=
 =?utf-8?B?aTVJSmNLMlNtZ1FLRjViTTFJRXhmRjhPeDloWlpCckJtMEdLSXMyRGkxQmgr?=
 =?utf-8?B?dWt4Y1BEaDkyeldxaE1hRXRKOGZXcklkdm1HSWJMRDcybHNyMXJQcU1ONys0?=
 =?utf-8?B?QktpMnJYaDkwUFp4eldZRzRoT1hWZlJBZjhqcVlxUDFqVzZRbVRUYW9rMjRx?=
 =?utf-8?B?bjVMNCtoNy9DaTFHZ0gwTjgwUG95d0NwRE4ybTFJd2E3b1Yva1N3bFg0bEw3?=
 =?utf-8?B?Ri9JOFRuaS8zNDRyU3d3RTR4a1c5R05zVUwxci9mQjdSblR2Wll2YkNqUTU0?=
 =?utf-8?B?VHptZW9nRDdSOHN3ZlFqdDNHdDlSaUZnTkJLMXlQejh1UlBsZEJrOEc0eTM1?=
 =?utf-8?B?MmFuenk0Z0xqRCtUWCtOd2ZJSDFjalk1dlpzdDJUanhvdU83Vlp3QWV1RUFy?=
 =?utf-8?B?bUk4b0pNcnc2QXFuUXpOWTFMVHowa2k3a29GSjZ5UENQc0V5Sjd5VUtmbkpR?=
 =?utf-8?B?MEFlR3RaZk5YVzNhZ3Y5UDlxLytYVktraUErWEd1eW9KMW1yTGJuSExWT01J?=
 =?utf-8?B?czgvYzZHR2ZTZm90ckJNdmFDR0J3bHp6V2hQWVRYS0F4UzB5bDRuWEE4V3R3?=
 =?utf-8?B?akh2b0crcXBnYUhDclBrQ2hjSFJSaUcwNnhpckpwZ3RYaE5MT3J2ckFSRDh0?=
 =?utf-8?B?ZGNoT1EvaTFXUy93QUZBbnM4T2RkYXpxVmgvZS93YUZzYWNlWHNiZllzUDhn?=
 =?utf-8?B?eTBvRzNaaDFuREV3anhRNjI4NWpUMU5QZlJPcEdmMkJNT1VvU2Y1K1UwSW9O?=
 =?utf-8?B?ck9XeFVxTmlxbWhRQTY5Zk1Ma2l3TXdmdFF4UDRzQUhOcTZNWkJSeGJ1YUtw?=
 =?utf-8?B?YTlmWWlkKzB6QVpxTWk1RUdVTGdUU0k5Smx0RitzY083TzRxSjM0RHRISlI3?=
 =?utf-8?B?NzdqUGplckJwMWhCSzRkdlhFWlVZY2xJNCtRZDZWS1NjRGVQUndNdEwySzdp?=
 =?utf-8?B?bXA2TU1DSmlEWXZXZm5hY0Fib3I5clpibUo3WWIyMUgzT0FaNFVjZStjNkF2?=
 =?utf-8?B?SkZCTjQxcmpmODFzd0p2OWxmMUQ0Mnp2LzhHVDU2SGUwb1hEc1NFSGMrMWU3?=
 =?utf-8?B?alpBZ29waUNFOGxoK21iNWR3WTVlak5wSTFQby91dndFMW5vOGU4NDBveGk4?=
 =?utf-8?B?cElEWVNLeWdlRTYyMTBGNHdENVdTSTJlZklnY2I5c0JOK1Y5M083ZEsrZm90?=
 =?utf-8?B?VHo2Z2Z1RTYwcGlWNGc1cFJmdXVTbHNzN3Jvc1pIL0F0S3pRMi8wdy9NU1J0?=
 =?utf-8?B?WHg0Szk5L0ZEUHV3amZWZ1NHWlVSTW8zYkcybk9vZDVpeUNjcFNYV0MxK2Fp?=
 =?utf-8?B?SnF5UTE4VUlsYURqSENnSlRObEpnTlpXQW02NzQ0MnE1K1FwSjIwRjFUSTdV?=
 =?utf-8?B?T1ZEWUtlNi9EVHBYTk1NVmNTWmNXWmIvRUNiaUQxRTlqQzkzdzllQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f902ebd1-4dbd-414d-fc4b-08df30491c4c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:31:07.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BGNImpuANB3oojp7sRtKgukQqa5daG3UGS22IEz1DIoGDU4DhV9lV2cXu/lI4TkAlhNb9nALiAb4nnSm4Flow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7023

On Wed, Oct 21, 2026 at 04:56:04PM -0700, Namhyung Kim wrote:
> On Tue, Oct 20, 2026 at 10:33:32PM -0400, Aaron Tomlin wrote:
> > In __cmd_ftrace(), incoming trace data from trace_pipe was historically
> > buffered in a fixed 4096-byte array allocated directly on the stack
> > frame. Furthermore, reads were written directly to stdout via fwrite()
> > in arbitrary chunk sizes, rather than as discrete, well-delimited
> > trace lines.
> > 
> > Refactor __cmd_ftrace() to employ dynamic heap allocation for the read
> > buffer alongside a dynamic struct strbuf to accumulate streamed
> > characters into whole lines. Pre-allocating the strbuf ensures that
> > line processing incurs zero heap reallocations during steady-state
> > polling, while the stack frame of __cmd_ftrace() is reduced by over 96%
> > (down to ~160 bytes). Robust error and EOF detection on stdout and the
> > trace stream ensures polling terminates cleanly upon pipeline or pager
> > exit, while retrying on non-fatal EAGAIN and EINTR conditions prevents
> > premature termination on non-blocking reads or signal interruptions.
> 
> I think it's better to split the error handling into its own commit
> maybe with a Fixes tag.  But I'm curious if it's possible to get EAGAIN
> on read() after poll().
> 
> Thanks,
> Namhyung

Hi Namhyung

I agree with splitting the error handling and signal resilience into a
dedicated commit ahead of the stack frame and strbuf streaming change.
The error handling and non-blocking retry logic is an independent bugfix
applicable to stable kernels.

Regarding your question about whether read() can return EAGAIN after
poll(), yes, it can. With trace_pipe configured for non-blocking I/O in
__cmd_ftrace():

        fcntl(trace_fd, F_SETFL, O_NONBLOCK);

There are indeed several [not limited to the following] scenarios in the
kernel where read() returns -EAGAIN after poll() reports POLLIN:

    1.  The kernel implementation of non-blocking read on trace_pipe:

        When read() is invoked on trace_pipe, tracing_read_pipe() calls
        tracing_wait_pipe() in kernel/trace/trace.c:

           static int tracing_wait_pipe(struct file *filp)
           {
               struct trace_iterator *iter = filp->private_data;

               while (trace_empty(iter)) {
                   if ((filp->f_flags & O_NONBLOCK)) {
                       return -EAGAIN;
                   }
                   ...
               }
               return 1;
           }

        Whenever trace_empty(iter) evaluates to true on a non-blocking
        descriptor, the kernel explicitly returns -EAGAIN.

    2.  TRACE_ITER(BLOCK) trace option:

        See trace_poll() in kernel/trace/trace.c:

           static __poll_t
           trace_poll(struct trace_iterator *iter, struct file *filp, poll_table *poll_table)
           {
               struct trace_array *tr = iter->tr;

               if (trace_buffer_iter(iter, iter->cpu_file))
                   return EPOLLIN | EPOLLRDNORM;

               if (tr->trace_flags & TRACE_ITER(BLOCK))
                   /* Always select as readable when in blocking mode */
                   return EPOLLIN | EPOLLRDNORM;
               else
                   return ring_buffer_poll_wait(iter->array_buffer->buffer, iter->cpu_file,
                                                filp, poll_table, iter->tr->buffer_percent);
           }

        If block mode is set on the trace instance (e.g. via
        trace_options), trace_poll() unconditionally returns EPOLLIN |
        EPOLLRDNORM regardless of whether the ring buffer contains any
        data. The subsequent non-blocking read() immediately hits the
        trace_empty() check in tracing_wait_pipe() and returns -EAGAIN.

I will split this into two commits for v10.

Kind regards,
-- 
Aaron Tomlin
