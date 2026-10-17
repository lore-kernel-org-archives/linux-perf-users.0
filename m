Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021097.outbound.protection.outlook.com [52.101.100.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB6351C17
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792244548; cv=fail; b=eNv2JG9smz4BfKuksmnbUF90S0oH6Gu+2Gd6YpYIGqSvV4UOfLJM/CgI508a9DUPNlv4zCgg9h1TnbtGDAkLRFQfbtth8xrnuVNylPQov5qbJyhWYzr90la0PvK9V6WtMYHOEpB56meAY9WoYRdvJjdmw60Hho9cehq+aQRRcMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792244548; c=relaxed/simple;
	bh=jJYrexM4oUeKLOXF6EP0R/YwR55eQePJQLrCqLUkXHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TR9qHjrGGaqJM8/SVm5dacf0W3+a5qdJBiBz+R0XRr/Zeg1IulsqFTtO1kO/HYTqYShQZl/IYTS65nL5mZPzS25KAEtx6wqdxtRpZ02CgrBui57+/WzOCSP5BZzzImyGYreBI1sz/nT19cxkRmGmI7TtSdfvwCYyVnm8k2SV2ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWn4jLP7cDZDkK0EOpazKw8XnfH/TaLSbaAv3CAylEY4oa50eCritUgKmzN02uM98vaS4YWnCZ8lxjJPHqKHZ8BPcr2ZRIwWoSwGeKXIqN8ry9jFD+8JI/HA+rD429DMaWmf7HdofP27snFPAYv01OYbLq5UyqjY5DSPaAQSqs/j53gaoSXVpiBTYpFWYGIHwftEB6LjVWpVRfZ9CNelds5ZgtVyzb1IPTYxB2nb1ty7iER2EGa6gGXwv3KvwjyXyS7DaIDCV7Rr3+h68ilmzcwwVJYCt/1ADlHqEaiv7tKJTfrz99+oZrzOzmlX9tpA1pSoy9uohcaweHRj7OcDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=rRBioUlT+MjITP94mE2CxXifEAB0QhJBnjy9Z4NpiO4=;
 b=My/cB8So64HHvypkYxaU+S4fhLOE87xa3AKL2wr7m+HWA3SHTjLh3AggX1K0smMcV8UOwz8DeskKZxaccvYDvbIWkdaMAWQLWvV8CPJACeAemLhVbthPOLbO52dvPD/l/ReTe7lfI/WbjTBYN6gFVTN7aZ/5yJQxphaIYtEHyi+0WWoSaueKWLSoDfgZgrJqP06lRnl+nWp2DgbNsfH3+5XhjNF/Q7GM++QEV0Yw4avdludhlPbrKCGsZaM9wJ00MWj4o+JH69nxxsPlLC7BWWxdS+cuIEm9RJ78d8HZfC/cm+ZPXf5N9ciS1wEe5NsBGTNWdmdq7njN8VVpY/04Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB3962.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 13:42:22 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 13:42:22 +0000
Date: Sat, 17 Oct 2026 09:42:17 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v6 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
Message-ID: <erftuvk52hiyir5j37pqay62v6qllij3ejrwh6ry4bwcvnvbha@5gp5nnd4dgbs>
References: <20261016040310.482876-1-atomlin@atomlin.com>
 <20261016040310.482876-4-atomlin@atomlin.com>
 <sashiko-outbox-173772@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-173772@kernel.org>
X-ClientProxiedBy: BN9PR03CA0643.namprd03.prod.outlook.com
 (2603:10b6:408:13b::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB3962:EE_
X-MS-Office365-Filtering-Correlation-Id: cd36928d-7908-409e-596d-08df2c54785d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	E1Kx6JTGDZrpfkh5QhoReNBDBd+uY8CDVdczAgrixQsH7zESCo6YdsfQm3tfRv2D9ERa076i56vgYXiUnR3KjH+MrRvaNY1MfUgRbPEzd1OHKg5Yd2rHp6kZAlvInuD2NmlUTKzRpLMIrRXbz2FKARdqfUhE7+cQb0ZFDa+srcBpKgxmjRR2XiTYfHanLuGcu2f0wz0duKDGJj9KOAM/oz8d6If489FVm38aCbGnpWX4frJlN/XCo6e0xe8X8fv4oGFBpAYWItXbcX/i3+2z3RZwuHpk+4Pv4N2eKpc9vxwdmNaTqDcWkEsbEJiKubj+rRaS+c+r0l4r+8BRcMzb/IRhd3HnHajW+qh/HDFzHCVAzqlV03aBA6vv/p3MgLWV9UWDfbOfV5Vsa79xk+L3vdEEKp2gxu7oMbGbZpGUMRVxGczstoHrh+afEsuwWStZav5vTcUOxQZRwc6fHshMuQg7aprOwChfu9CU2F6QuF3y/XjPzvH3KHK0kI1rwYU+HqJI/nwMwJIs+Diyd90AjLU23zwZqgdo70ujJIMtbxt3Vy5g72cwcY3Fh9jHsfgItxStU0p2GPH5Unu8+uvoyVpx48XJmP/I3BPrfnT8WLwbv6IgsSM608pR0UccsEdHFL1/jOMdTRXSe88JVH92E/OHMdbGehW117JbsM3Oik8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWgxclA1cnRRWndvaStrRGJ6Rk51emNnZmwwVWJPM2M3VHN5VXlCQnNXZng4?=
 =?utf-8?B?Z2RWMnlYYSthNU92bHpGdjljTEI0TEhNaHp2Nm5WOXJ6ZHU1NWJwRThwQnV4?=
 =?utf-8?B?TGZIUjJaanFRbnp1V0VlNElTUktLRm8xaG5JS3NvdlZLekY4OEdOdlU1STVM?=
 =?utf-8?B?N1RqL3FySk1UQlptRTN5MzhEd21URlNoZ3Bod1JPY00vaGVPSVM1NEVjNjJP?=
 =?utf-8?B?TWVJbktIby9VUG9Wc3NhSGZVVTI2Y0hpZDl6UUtBcWh1TTRRcWUvV3NBVzFE?=
 =?utf-8?B?VGhGQ3FPekt4OG1pYlBoZElxelZyRUtuY3hNTm5GR3NHZXNRdklQYTY4TStr?=
 =?utf-8?B?Ty9QTHk0eUhoeDZ0NzIvTGd1TWdQY3JubTNla05hRUYxSUhFMmZpRXNLZFZP?=
 =?utf-8?B?OThEbHNGa3ZqZ1dva0V3YmNDVVNaSVF4Znp5QktLVVArTUxRQ2xUOVdVa0Js?=
 =?utf-8?B?dG1IVm9ScWJFbnMzV1pMK0RJTzR3dXlPZVdTQ3ZsMkVWZzhvYU0raW85eVE1?=
 =?utf-8?B?Rm5jb0ZLSmgzcXJBVlBpYlUwNEptZGFiWTl0czc4NWdpMGZzenJITVgwTXNT?=
 =?utf-8?B?dkUzaTQvNW9TdTZkQWEvc05xQjg1cXRpQ255bDZvVHFPeE1vRkR4SGxMM1Jv?=
 =?utf-8?B?amVUUEJOZXgzN2tDNTBXNlZORkFnSmJoaGVTRDQvMG52Q1plMUxrZ0QzU2dN?=
 =?utf-8?B?cnA5SkFHQVBUdmNVTlZUNE5hOExYQU5ZUVV3YnZINWUrRE9tYnp5U3NieE1M?=
 =?utf-8?B?ZlR4dHpETWYwZ0hwK2tvWXNjVHhHVFJyNFJydFZFNkRZanRENE15cWxPUGpK?=
 =?utf-8?B?UnA2ZStqY0VjaGFiSGVVdUp0dno2czVyNk1ja3ZGY0cyM2FHYUFyY0hzNitN?=
 =?utf-8?B?WkFGUnA3SjdzWUpJOWRtNjk2RDJHVnVJWUdzUCt1a3hTcTBaSzdXeDc5UjFT?=
 =?utf-8?B?cXNvL2VQOUJCU1ZzTWhBUGY3U0lPZ1pHN3NZM2pRRXVOQ2xjcmk3TW5BQ0xL?=
 =?utf-8?B?UGRralhzd0xNVVd1bWpnSERlQTU4bitkTmx3aWRNcFY3UVVrSXlJOGJFTGN3?=
 =?utf-8?B?N0Y5dGtFZG8reW50cUdodWI2TlRtY1NQTlkxTHN5Zit2TElVbjViQ3htc3Jl?=
 =?utf-8?B?YjJMdWpOeVhDY2RaYmZSalIvSHcvalo5S1U3WmVhM3BYK2ZTRlZCZlZpRDRw?=
 =?utf-8?B?SG50emJQRSt1Qi82eVIwN3BDYnk2bUFVMGk0Y0VxT0RUMlYyRkdEaXBvOFE1?=
 =?utf-8?B?TjRpeG14djR1cGdGNmtRVUlBN3hFZ0VxeEs1QncrUW5PMDRITm92RkJzYWhK?=
 =?utf-8?B?K2VqandUUFJTV2haL0xNN0NlRXR1Yk1ZcDkyQjFlcWVPLzNNSThJQW4rUGFO?=
 =?utf-8?B?Y1dsRHl5bUxXaXR5a3RFNFpNVjExUlpuM1VmckIxdVZWSkZsdHZlMXlYZndu?=
 =?utf-8?B?ZFJ4ejUxbWdIQldsbnNwT0xpR1FRVG5RZlBTRTJmWkorMXlPSzByT3ExdTlv?=
 =?utf-8?B?ejUrd2lhWlhQUzlIQlhhRDN0TTdPY0wvK0xOVkhHTFRnYjhhdDdmeldtVnJT?=
 =?utf-8?B?ZUpUa0w2WGw0Nm9EYUg5b3ZRbTZYUU5rS0VEcWZ1YjJMRVBNMERTMkxVRE5u?=
 =?utf-8?B?djcxV2RUQlpXazBkcCtESHAvdVN2aDY0dnREMkUwaHk5QzFsWlU1ZGVVcGhj?=
 =?utf-8?B?TzdXSm5oc2M4eWlYSExhZVU2MlZsZ2tNc0lKQUg3dEFuUjRQTU1XOUhnd28v?=
 =?utf-8?B?akduVktwZ25CZklOUjdPc3lFcmo0U3ZGMzVITEc3cDh6ZHg5M0sxRWwyU2t0?=
 =?utf-8?B?L29KTGdBVkFXYk9zd2pjRUNMQ0p2WEI0Yk5tTGdTU3ZJZVFlc0JqK1NnckpR?=
 =?utf-8?B?T0VBWC9xTmNTeXBCNHpDVWhPSmJwdXhDNkpINm5ESy9NN2VSdDZ5cWZ2MzRn?=
 =?utf-8?B?SUk4bDhyTW8xMTViS0RyUDJTZllpSDBkdzRNSUJyaTBxWDIrcVNBMkQwaFVU?=
 =?utf-8?B?ckk4MEJ3ZTRFR1VBTlRVT1l6d0txRUlnMHFvUTlHMjNPa2R0RUEwNFprcDFs?=
 =?utf-8?B?Wm9NczIxczA3YlY2alBGRVYxN1FrdUd6c1l5RjU5N1pPemUrU1VMdk9HY01l?=
 =?utf-8?B?cVFxMUVnb243N0ZYMk9kWTlTNzJNSmZtMWpIUDg0OVh5M0V5L2tzRDRpT3Y1?=
 =?utf-8?B?SHphS0w5Q016Y1hlWERPOGIrSnFRMjlkV1dCbHJyZFRwZnNiQnlMUkc1NXdM?=
 =?utf-8?B?aGl4RGJEZ1hUbTJ4MlU5YVVmekpHVmlSaW8xOENQM2txaUd4eUxCK25XRXlX?=
 =?utf-8?B?aGpkNHhjYi9QdWVzV3BOVVhSZTBoZmxEN2Uwbk8xWWU2ZnVDTVd5QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd36928d-7908-409e-596d-08df2c54785d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 13:42:22.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOev9gPeiN4ZPcZlbb8BoCCRjF4jwTh/Oc5NMG7gu6UjcSRHv6zPROxyKthCEpDqGSvoGbdTGXe/H9Rs2UmptA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB3962

On Fri, Oct 16, 2026 at 04:23:51AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does this code handle context switches appropriately?
> 
> When trace_pipe output is read, it contains context switch banners when tasks
> change on a CPU. These banners cannot be parsed by find_func_column(), which
> will return NULL, skipping the line without clearing the stack state.
> 
> Because the state is tracked strictly per-CPU without task awareness, could
> this cause the newly scheduled task to erroneously inherit the preempted
> task's call stack? Furthermore, an unmatched closing brace from the newly
> scheduled task could incorrectly match and pop the stranded frames belonging
> to the preempted task:

Unfortunately, tracking the "synthetic" call stack strictly per-CPU causes
preemption and CPU migration to corrupt the call hierarchy, either by
polluting the newly scheduled task's indentation or by popping stranded
frames from the preempted task.

To address this, I have transitioned from per-CPU stack tracking to
per-task stacks keyed by PID:
    1.  Per-task state storage (ftrace_task_hash)

        Call stack states (struct ftrace_task_state) are maintained in a
        1024-bucket hash table keyed by PID using hash_32(). Each task owns
        its private call stack, inlined depth, and target filter state.

    2.  Context-switch dispatch

        When find_func_column() encounters a context switch banner ("=>"),
        a helper (parse_context_switch()) extracts the CPU number and
        incoming task's PID, binding ftrace_cpu_tasks[cpu] to that task's
        state in the hash table. Also, when --graph-opts verbose is used,
        this binding is also corroborated on each line via the comm-PID
        column.

    3.  O(1) fast path for trace records

        Normal trace lines only require indexing ftrace_cpu_tasks[cpu],
        incurring zero per-line hash table overhead.

    4.  Migration and preemption resilient

        If task "foo" sleeps inside an inlined function on CPU 0 and later
        wakes up on CPU 1, its stack is preserved and resumed on CPU 1,
        ensuring synthesised inlined closing braces (} /* ... (inline) */)
        match cleanly. Meanwhile, task "cat" on CPU 0 starts with its own
        clean stack at base indentation.

> [Severity: Medium]
> When the function call depth exceeds FTRACE_MAX_STACK, the logic starts
> incrementing cs->overflow_depth. If trace events are dropped, this recovery
> loop pops stale tracked frames above the caller.
> 
> However, since the caller was found in the tracked stack, does this mean all
> overflow frames logically must have exited? By only decrementing cs->depth
> and failing to reset cs->overflow_depth to 0, could subsequent valid exit
> events mistakenly decrement overflow_depth instead of popping their actual
> frame from the tracked stack?

Because the synthetic call stack tracks frames up to FTRACE_MAX_STACK and
overflows are recorded beyond that depth, finding the caller in the tracked
stack (caller_idx < FTRACE_MAX_STACK) proves that all child calls initiated
by that caller have finished. Any frames previously in overflow_depth were
descendants of caller_idx and must have logically returned while trace
records were dropped.
  
Failing to reset cs->overflow_depth to 0 leaves a positive overflow_depth.
When subsequent valid exit events arrive, the exit handler checks
if (cs->overflow_depth > 0) and consumes those exit events to decrement the
stale overflow counter instead of popping the active frames from cs->stack.
This permanently desynchronizes the call stack tracking state and indents.
  
I have updated the recovery path so that whenever caller_idx >= 0 is found,
cs->overflow_depth is reset to 0 alongside popping the stale tracked
frames.

> [Severity: Low]
> Does this header file need to explicitly include <stdio.h> to provide the
> declaration for the FILE type? Relying on implicit header inclusion can break
> compilation under musl libc.

I have added #include <stdio.h> to tools/perf/util/ftrace.h to ensure the
header remains fully self-contained.

-- 
Aaron Tomlin
