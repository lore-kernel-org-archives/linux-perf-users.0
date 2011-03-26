From: David Ahern <dsahern@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Sat, 26 Mar 2011 08:23:32 -0600
Message-ID: <4D8DF6E4.1070804@gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>	<AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>	<4D8DE695.3000606@gmail.com> <AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59155 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab1CZOXd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 26 Mar 2011 10:23:33 -0400
Received: by iyb14 with SMTP id 14so1484015iyb.19
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Mar 2011 07:23:33 -0700 (PDT)
In-Reply-To: <AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: zhao bao <baozhao@gmail.com>
Cc: linux-perf-users@vger.kernel.org



On 03/26/11 08:00, zhao bao wrote:
> 2011/3/26 David Ahern <dsahern@gmail.com>:
>> On 03/26/11 06:31, zhao bao wrote:
>>>> It's used to trace kernel space page faults, not for userspace code.
>>>>
>>>> Lin Ming
>>>>
>>>
>>> From the ouput of "perf report" command, I think  perf can record the
>>> page faults from userspace code.
>>>
>>> [root@localhost lab]# perf record -R -c 1  -d  -e  faults ./hello
>>> hello,world
>>
>> '-e faults' is a software event. perf-trace does not handle S/W events.
>> perf-trace has been renamed to perf-script, and perf-script recently
>> gained the ability to dump S/W events:
>>
>> https://lkml.org/lkml/2011/3/10/3
>>
>> David
>>
> Thanks. How can I apply your patch?  May I need upgrade to 2.6.38?

You can compile latest perf userpsace and it should work with files from
older kernels.

David
