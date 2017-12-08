From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/5] perf-probe: Improve probing on versioned symbols
Date: Fri, 8 Dec 2017 12:56:06 +0100
Message-ID: <bbe6b71a-86ac-bc1c-7895-d3bcbe35b782@linux.vnet.ibm.com>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752209AbdLHL4N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Dec 2017 06:56:13 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8BrsNv081174
        for <linux-perf-users@vger.kernel.org>; Fri, 8 Dec 2017 06:56:12 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2eqsx4h90a-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Dec 2017 06:56:12 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 11:56:10 -0000
In-Reply-To: <151263115609.13843.6362262297053841418.stgit@devbox>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org

On 12/07/2017 08:19 AM, Masami Hiramatsu wrote:
> Hi,
> 
> Here is the 2nd version of the series for probing on
> versioned symbols in libraries. This includes 5 patches
> to fix the issues discussed on perf-users ML 
> (https://www.spinics.net/lists/linux-perf-users/msg04637.html)
> 
> The first version is here; https://lkml.org/lkml/2017/12/5/1124
> 
> Here is the updates;
> 
> [3/5] Add a description in Documentation/perf-probe.txt
> [5/5] Add a description and examples in Documentation/perf-probe.txt
> 
> Thank you,
> ---
> 
> Masami Hiramatsu (5):
>       perf-probe: Add warning message if there is unexpected event name
>       perf-probe: Cut off the version suffix from event name
>       perf-probe: Add __return suffix for return events
>       perf-probe: Find versioned symbols from map
>       perf-probe: Support escaped character in parser
> 
> 
>  tools/perf/Documentation/perf-probe.txt     |   18 ++++++
>  tools/perf/arch/powerpc/util/sym-handling.c |    8 +++
>  tools/perf/util/probe-event.c               |   81 +++++++++++++++++++--------
>  tools/perf/util/string.c                    |   46 +++++++++++++++
>  tools/perf/util/string2.h                   |    2 +
>  tools/perf/util/symbol.c                    |    5 ++
>  tools/perf/util/symbol.h                    |    1 
>  7 files changed, 137 insertions(+), 24 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro Ltd.) <mhiramat@kernel.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

If you fix the findings for patch 4 and 5 you have my 

Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
