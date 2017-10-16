From: ravi <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 11/16] perf report: properly handle branch count in
 match_chain
Date: Mon, 16 Oct 2017 09:48:17 +0530
Message-ID: <5f4372e7-8e75-bf34-3947-4b38036241a4@linux.vnet.ibm.com>
References: <20171009203310.17362-1-milian.wolff@kdab.com>
 <20171009203310.17362-12-milian.wolff@kdab.com>
 <20171013133903.GN3503@kernel.org> <20171013140834.GO3503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750775AbdJPESa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Oct 2017 00:18:30 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9G4DpqD062480
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2017 00:18:30 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dme8am0xd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2017 00:18:29 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <ravi.bangoria@linux.vnet.ibm.com>;
        Mon, 16 Oct 2017 05:18:27 +0100
In-Reply-To: <20171013140834.GO3503@kernel.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, ravi.bangoria@linux.vnet.ibm.com


On Friday 13 October 2017 07:38 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 13, 2017 at 10:39:03AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Oct 09, 2017 at 10:33:05PM +0200, Milian Wolff escreveu:
>>> Some of the code paths I introduced before returned too early
>>> without running the code to handle a node's branch count.
>>> By refactoring match_chain to only have one exit point, this
>>> can be remedied.
>> Fixing up this one now.
> Millian, this is all fresher in your mind, can you please take a look at
> my perf/core branch and check if the change i made to ]PATCH v5 09/16]
> "perf report: compare symbol name for inlined frames when matching" is
> ok wrt Ravi's fix and then, please, rebase v5 on top of what is there?
>
> Ravi, please take a look at this as well, to see if with these changes
> your fix remains valid, ok?

Yes Arnaldo, my changes are still valid.

Milian, Can you please change this patch such that it incorporates dso
comparison for CCKEY_FUNCTION.

( Also, will that be good to change macro to CCKEY_FUNCTION_DOS ?)

Thanks,
Ravi
