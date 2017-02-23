From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: [Question] about symbol__get_source_line() in util/annotate.c
Date: Thu, 23 Feb 2017 16:02:19 +0900
Message-ID: <1f7c58dd-cf2c-5ba4-c37a-8a60da6823ac@gmail.com>
References: <13ff5742-c651-0211-c0e0-0961c2d1ab64@gmail.com>
 <20170223051413.GA30710@sejong> <20170223052640.GB30710@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33089 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdBWHCY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Feb 2017 02:02:24 -0500
Received: by mail-pg0-f48.google.com with SMTP id z128so11830732pgb.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2017 23:02:23 -0800 (PST)
In-Reply-To: <20170223052640.GB30710@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: perf group <linux-perf-users@vger.kernel.org>, kernel-team@lge.com



On 02/23/2017 02:26 PM, Namhyung Kim wrote:
> On Thu, Feb 23, 2017 at 02:14:13PM +0900, Namhyung Kim wrote:
>> Hi Taeung,
>>
>> On Thu, Feb 23, 2017 at 12:31:08PM +0900, Taeung Song wrote:
>>> 2) Why use the if statement as below ?
>>>
>>>     if (percent_max <= 0.5)
>>>             goto next;
>>>
>>> I think it is more correct to use 0.0 instead of 0.5
>>>
>>> What do you think about that ?
>>
>> Well, I think that the summary line doesn't want to show too many
>> (small) lines.  Using 0.0 instead seems meaningless though.
>
> Ah, that includes 0 percent..
>
> Anyway I can see print_summary() uses MIN_GREEN for this.  We can use
> it here instead of the magic number, or might change it to something
> different if needed.
>
> Thanks,
> Namhyung
>

I understood!
Thanks for your answer

P.S.
Hum.. And I think there are many things that seem to need to be
modified in util/annotate.c
The for loop util/annotate.c:1653~1676
have similar logic if compared with disasm__calc_percent

Anyway I'll keep trying to improve perf-annotate in terms of its 
features and its code..

Thanks,
Taeung
