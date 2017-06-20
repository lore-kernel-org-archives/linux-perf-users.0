From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] RFC perf test 14 add platform dependency
Date: Tue, 20 Jun 2017 16:06:15 +0200
Message-ID: <127c689e-be4d-ef31-bf06-e09fc1cd7c47@linux.vnet.ibm.com>
References: <20170613090937.72899-1-tmricht@linux.vnet.ibm.com>
 <20170619205944.GA19183@krava> <20170620014036.GF13640@kernel.org>
 <4349df01-bc7d-32bc-aa31-04c25ab970c1@linux.vnet.ibm.com>
 <20170620092431.GA2380@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751102AbdFTOGV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jun 2017 10:06:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5KE62Q3054649
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2017 10:06:21 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2b70eu677n-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2017 10:06:21 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 20 Jun 2017 15:06:18 +0100
In-Reply-To: <20170620092431.GA2380@krava>
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

On 06/20/2017 11:24 AM, Jiri Olsa wrote:
> On Tue, Jun 20, 2017 at 10:12:14AM +0200, Thomas-Mich Richter wrote:
>> On 06/20/2017 03:40 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Jun 19, 2017 at 10:59:44PM +0200, Jiri Olsa escreveu:
>>>> On Tue, Jun 13, 2017 at 11:09:37AM +0200, Thomas Richter wrote:
>>>>> This is a proposal to add platform dependency into the
>>>>> test case 14 (perf_event_attr). It is based on a suggestion from
>>>>> Jiri Olsa.
>>>>> Add a new optional attribute named 'machine' in the [config] section
>>>>> of the test case file. It is a comma separated list of architecture
>>>>> names this test can be executed on. For example:
>>>>>
>>>>> machine = x86_64,alpha,ppc
>>>>
>>>> 'arch' sounds better to me, but machine is ok I guess
>>>
>>> Agreed, for consistency with other places, like in struct machine, that
>>> represents virtual and host 'machines' that have an 'arch', etc.
>>>
>>> So better to rename "machine" above to "arch".
>>>
>>
>> Ok lets rename it to arch.
>>
>>>>> If this attribute is missing the test is executed on any platform.
>>>>> This does not break the current setup.
>>>>> The values listed for this attribute should be identical to
>>>>> uname -m output.
>>>>> If the list starts with an exclamation mark (!) the comparison is
>>>>> inverted, for example for
>>>>>
>>>>> machine = !s390x,ppc
>>>>>
>>>>> the test is not executed on s390x or ppc platforms.
>>>>> The exclamation mark must be at the beginnning of the list.
>>>>
>>>> could that be per arch? this made me think that it's not s390 and it IS for ppc
>>>
>>> yeah, having the ! affect just the arch right after it looks more
>>> flexible and clear.
>>>
>>
>> Does this really have any benefit? Assume
>> arch = !s390x,ppc
>>
>> I will scan the list from left to right and the first match wins.
>> Checking the first word in the list determines
>> this test is executed on anything but s390x. So the 2nd word in the
>> list (ppc) is useless. Specifying more architectures makes only sense
>> when you negate them such as
>> arch = !s390x,!ppc
> 
> ok, makes sense
> 
> thanks,
> jirka
> 

I will rewrite the patch for Linux 4.12 as soon as Arnaldo agrees 
with us.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
