From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/5] perf-probe: Improve probing on versioned symbols
Date: Thu, 7 Dec 2017 18:17:51 +0530
Message-ID: <15c9f3d9-e1c0-72eb-6ba6-28b8355f457b@linux.vnet.ibm.com>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752793AbdLGMrS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Dec 2017 07:47:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB7Chmjj095468
        for <linux-perf-users@vger.kernel.org>; Thu, 7 Dec 2017 07:47:18 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eq57r2gu4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2017 07:47:17 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <ravi.bangoria@linux.vnet.ibm.com>;
        Thu, 7 Dec 2017 12:47:15 -0000
In-Reply-To: <151263115609.13843.6362262297053841418.stgit@devbox>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>, linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>



On 12/07/2017 12:49 PM, Masami Hiramatsu wrote:
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

Ack-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
