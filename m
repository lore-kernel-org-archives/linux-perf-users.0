Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022120.outbound.protection.outlook.com [52.101.96.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286136B913;
	Sat, 10 Oct 2026 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666469; cv=fail; b=oEe4qPcbZLq1dG4/1dKOLiNif1qtrTv7xf6HnWZuDt0zkb9Yn2jnjVnjCtQ5otaANrJLafUIdeh+M2YqMhcKRAYiymqCfemKMu9y5F7/J+bYsIEk405DjYqueFcFibBToEDwRFb3UIiycR+eqAWU5YskCP1heNNdKL5hnd4X324=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666469; c=relaxed/simple;
	bh=KIoutVoRFC9EphMySWPLq0l8mZ+ufbg2e60oetuvuJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nZK8phsTJ5ruge2C5roi+dji6jyC0FWTi/j1EgUq8B5yYYxxgpIk531TwlNzYPZTzahHw+GO4Ahwp5TpBo9CUP1oXF8+T8WjFRFEFUkpRxwQdiMN0Q0iudEc0ce4igJWZ9lMy1BN1fOEPi47lTEsr+rwAqr6XYf3Q4++sr/R7ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijd1TK0LUNO4UnZ9fvWx6edxBKQuNAlaGB4ykEnpzbH34wRHF6gwehwg04tUnT5vTA58Eca+9xKynDTZ7y/6i8pRw0XuK139WNGSq6Ir3Q9QpP0sBIwVlSAsuvEC0Espv6GsklXrFvr8e7Y+sCGgf8XeFUyPh+ZspF23wqt0V4gAzPGDcP/UE1OTd488BwL3EmzcsbYDRMWvjqhicDAOO/Xst7HJ7DPcJC6qwswx3LSp96RLno1ILpuWc2k5cX0oUmerS4HEDOof6DxOhhsGnuo0KWMaKSSpjIVQdjZ7nft136WRUr8xE7mDZtFQ40u1e67DJaDq30qxX/mAYL/tWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=WIuk8a/dzXXq0B5kIpXyHI/jYX27RbIoxf//uhM+WFc=;
 b=vQ7NmnouiIfZ4in9TJ/iDfqnH4r3MyiDQam4+tCOz5Pt7vAGbzDQCJPf2yAimNvh8Etca1GF9ZE1KZcVKNOi3K44GT59qvva/BaxD7U7bxYK53MpcFXXvnFYEzZ1EeNEKL6kI6ir38IrXi2EK9299L/jNR90Z/B3COv3CC0SKbbtHlX2HGgjSoqx5wb6b3H/1Uutk+eZxMOfA7QFtvM0iCf8sg/hdA90J9koVaSCsrvetkduCTWdG3XyvFAbKdpn999dBRARIDcWnXfroxzg+51JgGrY3m13KmV+XQxpAFpyFPSzTztW80jE+9HAWdLj5uHm2KsgcsQMNRJxghTpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3720.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sat, 10 Oct
 2026 21:07:43 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.019; Sat, 10 Oct 2026
 21:07:43 +0000
Date: Sat, 10 Oct 2026 17:07:39 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v2 0/4] perf ftrace: Support inlined
 functions and display enhancements in function graph tracer
Message-ID: <5pob6u6znv5w3uwpt4vhuz5a45mii44lazftge5377iewb22ub@f7zq323yt4cw>
References: <20261006232756.65620-1-atomlin@atomlin.com>
 <asbUwDTKJ54HvNYi@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asbUwDTKJ54HvNYi@google.com>
X-ClientProxiedBy: BN0PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:408:eb::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3720:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9ab1a6-7e53-483c-7494-08df27128669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jwGBDNTLBacz6b6nIMKKFgS8K9Ek1JclXZdqZCe0q3+AqoJk5buDx93TPrq/oKgmNoJwtq38FQTEw+ImM3LdIEcKj6CYzFWAYmk6wfTTlxI9mi5WYAhwtzyH8cKacLF29RpzcpDQg953rQDp5cS0SIKeMRZZX8yWXW/ckkaQQYsY2ZZnIqS4SzfEEO+DlhXX/KJZpi3bhlt7A5FnUtDcK6oupQJXCc+Tec8iKqzZrLt0C80SW1ftyyhsJwK76AS/mD2INla7RhplBwzpPtTJRVNm8SrInLHbeKU/ymmWBJJKqukWfrctE3Ya28z2x+fwwn8/OZBwSnb/hWbke/xpa/ggidgLWbPPgA5+Eazi1wDZy/B3m/yshdwH0Cvs9O9S7vZSCDbla1eizBzn6Bogi9FcC+fIa9l/46S0oQxiEvhvSlQJmGojJqlpYl888fTaES1KX5UcA1Z4X+nsc5mxt4o7DzM3IPWSjBh+qcat9sFiIl2hu8B+L2lk1smIU7UE+To0PJ+Gb0TetxqYN1GNFRu9l1sqYUBKbbkk8K9A6AHhBFFeNtFtJ7rmJijoWcY4MQJ4rK6Za/91T3aLKqamr6oere0e7xvs4YBRULpQqoM67q4F01h6fcCcq/En6sLaZzed+GTFrMf1hL7zTDmDK1kdO+s2ZIpjRNLYF2/Z7vI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2xmQVE4WHZJclRWcWFkWWFSTjBSZVplb0FhU0FEVFlpOG04bDJUVXNCV3Uy?=
 =?utf-8?B?QVNQL0xxTmN4a0VHOVo2elgrSDlJOVhKbEJobWRTZTZMTE5aTGtMTG5HQmt2?=
 =?utf-8?B?WXFLaW5uVERyMThkUkszUFQ4eGxyRzhSaGYyUUcvbHpTbFRBYkduenlWOWxs?=
 =?utf-8?B?eXpibzBpcXJsUUxvZVVQbTkzNXBjbW9may9zM1M4TmJRVkt1UkdLQXhOZmVP?=
 =?utf-8?B?Y1pkYkpQc3VWT1loVUxVc3lBeUNEL09tdnJiOGxGYzFyeGUrc09rbnN6V1Zp?=
 =?utf-8?B?d3pRdGYybklwdDU2L3Q5Zjc0REQxaDNTeWJwaW5BeG9nUENrMzdJZldXZlh0?=
 =?utf-8?B?UXFiL0pPdm9uSXVtMzZONWp4bWVmZEw5VUxuM0ZSOENQVFVLMHQ1Qy9JTTBk?=
 =?utf-8?B?dzFkNFlIWVBBWVZXVHBERER2bkJYUWIydWgzZ0NYQzZuajVFMFVnY2JzOVN3?=
 =?utf-8?B?QWZGeERKeHVmQjl3SDlzd3JnRFRGQ1ZYdXRlaHh6RDBROTQ3WnZWOFQxVWd0?=
 =?utf-8?B?VmlPbUxydHVqM3J4ajEvUFArb2c4dW1FZisyNkxrOWFhVmxlcndGV05zdjhL?=
 =?utf-8?B?aURjOGdzNEZ3K0NNbW9mZGJvUndZY05SRk5QWDM3ZExNMEloK1RSc1lrNkVy?=
 =?utf-8?B?RUh1UVRoU1lvdE1FQnNVMWgvSzlzbzNyWVBCMVgxNHZ0TEFHWFNCYlRqblBs?=
 =?utf-8?B?VzNrWFV1anl0dGhhaWVJcDkwd3d1OGZvSjVjVTlPenUyQ0tSL3lVWnFBNDUy?=
 =?utf-8?B?b2JpOWl1Q2FzMkUrVWk4S3lvQTFjNm13aVYwMTB0bWhOZC9YOTBQQ09EamxS?=
 =?utf-8?B?amt0RlROVXQ5QWFqMnM2eWZNSnFHbWFnMEdoNTJtcE55ZE4vT0hSVmhUZ1g3?=
 =?utf-8?B?WDZOVHJTN2dMcUtxNUwvenBUekRPWmRrbWRQNUM0ZHRLWm5SVTFCbHRsV0th?=
 =?utf-8?B?Tkcva25LZjExWWhhUGV2NWgyZmFaaUxGSE1jeGRBOHl5WDQwY3hIdVZudHYx?=
 =?utf-8?B?aHgxa0M0TWFzQnhzU2cvZmdreUNuVEZmTDUvNVpPMEFZSjlrMWNPK2tUai96?=
 =?utf-8?B?eEZ2ZWwvMXVSd3Yvc2Q1aGgvMUdOcDJsQysydnFsOHIxMGV3T3krVjVETE9w?=
 =?utf-8?B?VncxWlRLSWVtanZobHBUV1BVUHBGaGpOQ04vbzJydXcxU25OaWxUdEJmTEtY?=
 =?utf-8?B?bGtFYWZvdkhNWUxUalV5Mm9QWmQvRVF6amxpOXF3V3R0RTNYT3c0OTlzWjBF?=
 =?utf-8?B?UmRtZ2NYSjk5WC9GYUtaWjYvTWNOMDRJTDRMenZDbDllaHB2TGZPZ0xENjY4?=
 =?utf-8?B?YkIwTFByTjUzZnYxTkJZS1ZLeERWemhnNHowSWcyVXE0bmllclJ1Qm1haVBX?=
 =?utf-8?B?YVZPVXc0bkJsRGRGOE85c2s0NVMra3Jzc21YQjZpRUdRYlNsN0JuSDhITWlI?=
 =?utf-8?B?ZEtoYlRaYlRGUmFHZlp5TXFhdDQ2SnBManBWZ2pNNkpadHRkYlRTeWh1VnA3?=
 =?utf-8?B?MTliWFBsOUdwTXVHN3o5OGV1ZmNUMUxlZ01YSWlGOTJWMzdMOGxUaVJ5R2ZQ?=
 =?utf-8?B?cU1QUDVLQVphWHlnK2F0eWJ2MjAzQm1QZ2xoZjd3bHRNUVdYaUhXc2V4b3d6?=
 =?utf-8?B?SWY2KzJwS0ZYTVZEYk16YytYbFRJeVQ3R0RqM2FkcnJRRWtCVU1OQkNJSXZF?=
 =?utf-8?B?UDlqaVhma0hTUGdFaE5NMkJEMEFsRGI1VGNpL2NCdXE1aE9USXZaNGd1S24r?=
 =?utf-8?B?bktndmVFZFVBaDVFb0pHckNTZW1GdWxDYTV0U3RrcXJ5QjlaaXBjSDg0ZSto?=
 =?utf-8?B?REtHMTQ2RS9EbUJGUm50OEhWQXpoZ0g1eGwrVXhjWWZTaXdmUGtiQUxXN1Z0?=
 =?utf-8?B?WkcrMEJhbWM0WDNJeGxWU0pGL3cvdEFQSXUvZUxNcVZEeE56UkRYNG5DZC9W?=
 =?utf-8?B?ei9FOTB6cE5FWFo3Z0tSQUNWa0hOWHNSSHlpLzRHYnlvbEd3bWo3b2RLeWcy?=
 =?utf-8?B?VEZHYng3TVE5RWFmNkNNRnBpWnFLTVpTbDZsNFZwMC8wTURrd09uZGUwd0Fu?=
 =?utf-8?B?NDRZSTJWbTlyVDZHRW41V0xKZ0Q2Ykt1c2RUQWRXTmdlSE5uY21PSGgzL0Mr?=
 =?utf-8?B?dURPeVJ3K3BWdGRxeC8ydkIrNmYwNWVWWEhUQVNXR1BYVnlXZ2pVcE45czZH?=
 =?utf-8?B?SzJNbzMwV3ZuZjVOS3o4WmdzSS8wZXh5T2NBL2hMdjJUNVhCL2Z6dldqa2Mw?=
 =?utf-8?B?Zk9JMXBoNWdRZFBGNDhzMEFRQTZ4Ukx4V2FDZWhPeGpyQW1hUmRMbXV2ZHhF?=
 =?utf-8?B?NVQyd1lHRVJmT3FpWVIxbWNzcGRVV1Rwd01sVGczbmlYTHQ0MldMUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9ab1a6-7e53-483c-7494-08df27128669
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 21:07:43.0489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WJcxYFtw8gN/xXt8W7+lXYotuV+lUF/qSil+nDNm69M2P1E0hUSuJXP4dS6Z1WNM/Bc7eAHHF8X2SzoRez5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3720

On Wed, Oct 07, 2026 at 04:24:48PM -0700, Namhyung Kim wrote:
> Hello,
> 
> Interesting work!

Thank you Namhyung.

> On Tue, Oct 06, 2026 at 07:27:52PM -0400, Aaron Tomlin wrote:
> > The Linux kernel's function graph tracer operates at the machine
> > instruction level via compiler instrumentation
> > (-fpatchable-function-entry), recording entry and return events for
> > physical function calls. Consequently, functions inlined by the compiler
> > are invisible in the resulting call-graph, as no discrete call or return
> > instructions are emitted for them. While technically expected, this
> > omission frequently obscures the logical execution flow when analysing
> > kernel subsystems heavily reliant upon inlining (such as the scheduler,
> > memory management, locking primitives, and RCU).
> > 
> > When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=y, the
> > funcgraph-retaddr trace option records the caller's return address on each
> > function entry, manifested in the trace stream as a comment
> > (e.g. /* <-wake_up_new_task+0x1d1/0x3e0 */). By interrogating DWARF debug
> > information from the kernel image (vmlinux) utilising libdw, perf ftrace
> > resolves this return address to its inlined callchain and synthesises the
> > intermediate inlined frames directly into the streamed call-graph.
> > 
> > Synthesised inlined functions are rendered with an explicit /* (inline) */
> > annotation at both entry and exit:
> > 
> >      # CPU  DURATION              FUNCTION CALLS
> >      # |     |   |                 |   |   |   |
> >       1)   0.856 us |  mutex_unlock(lock=0xffffffffbc28bfa0);
> >       0)            |  wake_up_new_task(p=0xffff8b1f183bac80) {
> >       0)            |    rb_irq_work_queue() { /* (inline) */
> >       0)            |      rb_wakeups() { /* (inline) */
> >       0)   1.374 us |        housekeeping_any_cpu(type=3);
> >       0)            |        arch_irq_work_raise() {
> >       0)            |          apic_wait_icr_idle() { /* (inline) */
> >       0)            |            x2apic_send_IPI_self(vector=246) {
> >       0)            |              instr_sysvec_irq_work() { /* (inline) */
> >       0)            |                irq_enter_rcu() {
> >       0)            |                  instr_sysvec_irq_work() { /* (inline) */
> >       0)   0.673 us |                    irqtime_account_irq();
> >       0)            |                  } /* instr_sysvec_irq_work (inline) */
> >       0)   1.697 us |                }
> 
> Let me read this output..
> 
> It seems housekeeping_any_cpu() is called from the inlined chain:
> 
>   wake_up_new_task()
>     -> rb_irq_work_queue()
>       -> rb_wakeups()
>         -> housekeeping_any_cpu()
> 
> But I think the actual call chain would seem like:
> 
>   wake_up_new_task()
>     -> rb_wakeups()
>       -> rb_irq_work_queue()
>         -> housekeeping_any_cpu()
> 
> And I don't know how wake_up_new_task() called rb_wakeups() directly.

That resulted in the inverted nesting of rb_irq_work_queue() and
rb_wakeups(), as well as the unnatural parentage under wake_up_new_task().

In the actual implementation, DWARF inline resolution via libdw traverses
function DIEs from parent to child (using cu_walk_functions_at()), so
synthesised inlined frames are always ordered strictly root-to-leaf. In
this scenario, rb_wakeups() correctly precedes rb_irq_work_queue().

In the next iteration, I will update the commit log in with a genuine,
reproducible trace from the kernel (e.g. wake_up_new_task() ->
activate_task() [inline] -> enqueue_task(), as exercised in the test suite)
to avoid any confusion.

> Also how do you know if arch_irq_work_raise() is called within the same
> inlined call-chain?  It seems rb_irq_work_queue() indeed calls the
> function after housekeeping_any_cpu():
> 
>   rb_irq_work_queue()
>     -> irq_work_queue_on()
>       -> __irq_work_queue_local()
>         -> irq_work_raise()
> 
> I guess you compare the callchain with the previous one and merge the
> call if they match.  Then it would support partial match and close some
> parents correctly like when other function is called from rb_wakeups(),
> for example.

Yes. Each CPU maintains a call-stack tracking both real and synthesised
inlined frames. When a function record arrives with a return address comment:

    1.  We resolve the inlined call chain from DWARF information and locate
        the enclosing real caller on the stack

    2.  We determine the longest common prefix between the currently active
        inlined frames above that caller and the newly resolved inlined
        chain

    3.  Any active inlined frames beyond the common prefix are closed and
        popped by emitting synthesised closing delimiters: "} /* <func> (inline) */"

    4.  Any new inlined frames from the common prefix index onwards are
        opened and pushed onto the stack

Consequently, when sibling calls are made within the same inlined parent
(or when a subsequent call branches off an intermediate inlined ancestor
like rb_wakeups()), shared ancestors are preserved while only the divergent
frames are unwound and replaced. When the enclosing real function exits,
any remaining open inlined frames above it are closed as well.

This partial matching and stack unwinding behaviour will also validated by
the unit tests in tools/perf/tests/ftrace.c.

> > This series decomposes the feature into a modular, bisectable progression
> > of four patches:
> > 
> >     1.  Stack frame optimisation in __cmd_ftrace()
> > 
> >         Replaces the 4096-byte stack array in __cmd_ftrace() with dynamic
> >         heap allocation alongside struct strbuf streaming, reducing the
> >         stack frame footprint by over 96% (down to ~160 bytes) while
> >         ensuring complete line-delimited records and robust EOF handling.
> > 
> >     2.  Return address comment filtering
> > 
> >         Introduces ftrace_parse_retaddr() and ftrace_filter_retaddr() with
> >         --filter-retaddr and --graph-opts filter-retaddr to strip caller
> >         comments from trace output, accompanied by an initial unit test
> >         suite in tools/perf/tests/ftrace.c.
> 
> I'm curious why do we need options as we already have 'retaddr' graph-option
> to enable it.  I think it should work the same as 'retaddr' is not
> given, no?  Otherwise, we could add 'noretaddr' instead.
> 
> Also I think it's only useful with the --inline option.  If so, we could
> handle that automatically when it's given (and 'retaddr' is not given).

That is a very good point. The only reason return address comment filtering
is required in the first place is because --inline needs the kernel's
funcgraph-retaddr option enabled behind the scenes in tracefs. Without the
caller's return address and instruction offset, DWARF cannot resolve the
inlined call chain. However, leaving those raw comments (/* <-caller+offset
*/) in the stream creates considerable visual clutter when the user is
primarily interested in the reconstructed inlined hierarchy.

Handling this automatically is much cleaner:

    1.  When --inline is specified

        perf ftrace enables funcgraph-retaddr in the kernel for symbol
        resolution, while automatically filtering the comments from the
        rendered output

    2.  If the user explicitly passes --graph-opts retaddr alongside --inline

        We retain the return address comments in the output as requested

    3.  When --inline is not specified

        The kernel's funcgraph-retaddr option remains disabled by default
        unless --graph-opts retaddr is supplied, in which case the comments
        are shown without filtering

For the next iteration, I will drop --graph-opts filter-retaddr and
--filter-retaddr, folding the filtering logic directly into the --inline
implementation so that it behaves automatically based on whether
--graph-opts retaddr is present.


Kind regards,
-- 
Aaron Tomlin
