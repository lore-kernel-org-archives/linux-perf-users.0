From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: perf buildild-list -H dumps core
Date: Tue, 17 Oct 2017 08:15:36 +0200
Message-ID: <5e1a332b-78e0-5cc4-776c-d86f558444eb@linux.vnet.ibm.com>
References: <6ec683e8-f23e-0595-5674-d5ef20ae03f5@linux.vnet.ibm.com>
 <20171013144805.GQ3503@kernel.org>
 <0dbfaac2-46dc-8c63-05b7-004f3604b8c3@linux.vnet.ibm.com>
 <20171017002831.GA2244@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752629AbdJQGPr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Oct 2017 02:15:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9H6EJFX056887
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2017 02:15:46 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dn82gj680-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2017 02:15:46 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 17 Oct 2017 07:15:40 +0100
In-Reply-To: <20171017002831.GA2244@sejong>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, kernel-team@lge.com

On 10/17/2017 02:28 AM, Namhyung Kim wrote:

[...]

> 
> Looks like due to a NULL namespace event handler.  Does patch below
> fix it?
> 
> Thanks,
> Namhyung

Thanks for the fix, it solves the issue.
 
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index ceac0848469d..b3fd62f7e4c9 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -374,6 +374,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
>                 tool->mmap2 = process_event_stub;
>         if (tool->comm == NULL)
>                 tool->comm = process_event_stub;
> +       if (tool->namespaces == NULL)
> +               tool->namespaces = process_event_stub;
>         if (tool->fork == NULL)
>                 tool->fork = process_event_stub;
>         if (tool->exit == NULL;

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
