From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/9] perf: test 15 fix python error on empty result
Date: Wed, 9 Aug 2017 13:02:54 +0200
Message-ID: <54a84a21-71ec-dad9-c395-25e21b0bb7e0@linux.vnet.ibm.com>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
 <20170809103921.GA18900@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50943 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751977AbdHILDC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 07:03:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v79Axf6G062248
        for <linux-perf-users@vger.kernel.org>; Wed, 9 Aug 2017 07:03:02 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c7xwmqgnr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Aug 2017 07:03:01 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 9 Aug 2017 12:02:58 +0100
In-Reply-To: <20170809103921.GA18900@krava>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

On 08/09/2017 12:39 PM, Jiri Olsa wrote:
> On Wed, Aug 09, 2017 at 08:40:32AM +0200, Thomas Richter wrote:
>> Commit d78ada4a767 ("perf tests attr: Do not store failed events")
>> does not create an event file in the /tmp directory when the
>> perf_open_event() system call failed.
>> This can lead to a situation where not /tmp/event-xx-yy-zz result
>> file exists at all (for example on a s390x virtual machine environment)
>> where no CPUMF hardware is available.
> 
> hi,
> what's this patchset based on? I got 2nd patch failing to apply:
> 
> Applying: perf: test 15 fix python error on empty result
> Applying: perf test: perf test case 15 result ignored
> error: patch failed: tools/perf/tests/attr.c:166
> error: tools/perf/tests/attr.c: patch does not apply
> Patch failed at 0002 perf test: perf test case 15 result ignored
> 
> any chance you have this on a git repo somewhere?
> 
> thanks,
> jirka


Hi,

I have cloned branch perf/core from

url = git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux

dated 27-July-2017 and last commit before my 9 patches is
6b7007a perf data: Add doc when no conversion support compiled

I have no git repository to clone from. But I can rebase the
patches on the latest level and can send them again.

Thanks.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
