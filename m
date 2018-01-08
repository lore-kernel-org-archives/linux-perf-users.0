From: Andi Kleen <ak@linux.intel.com>
Subject: Re: perf memory metrics on ec2 instance
Date: Sun, 07 Jan 2018 21:09:30 -0800
Message-ID: <87o9m53pit.fsf@linux.intel.com>
References: <CA+q6zcXGsPT3bXhUS2gNf0_JPm+jLHBaSH+T_5CNPkZ3A9GK7g@mail.gmail.com>
        <87608i5xcd.fsf@linux.intel.com>
        <CA+q6zcWn=J6s-9=AyVYgQW+J56edeEn3EuBX78oP2QwmQKTgog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64223 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755991AbeAHV3y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Jan 2018 16:29:54 -0500
In-Reply-To: <CA+q6zcWn=J6s-9=AyVYgQW+J56edeEn3EuBX78oP2QwmQKTgog@mail.gmail.com>
        (Dmitry Dolgov's message of "Sun, 7 Jan 2018 16:37:11 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Dmitry Dolgov <9erthalion6@gmail.com> writes:

>> On 4 January 2018 at 00:36, Andi Kleen <ak@linux.intel.com> wrote:
>>
>> perf mem requires PEBS.  PEBS is currently not supported in VMs. You
>> should let Amazon know that you need it though, so it could be possibly
>> implemented.
>
> Thanks for the explanation. Is there any alternative way to get memory
> counters? If I need to know only how many times an event appeared, can I do
> more or less the same with perf stat -e 'counter_name' without PEBS support?

Counting these events should work if the PMU is enabled. I believe you
need a special setup in AWS to get the PMU enabled though.

-Andi
