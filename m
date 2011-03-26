From: zhao bao <baozhao@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Sat, 26 Mar 2011 22:00:55 +0800
Message-ID: <AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>
	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>
	<AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
	<4D8DE695.3000606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36560 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1CZOA4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 26 Mar 2011 10:00:56 -0400
Received: by gyd10 with SMTP id 10so496601gyd.19
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Mar 2011 07:00:55 -0700 (PDT)
In-Reply-To: <4D8DE695.3000606@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

2011/3/26 David Ahern <dsahern@gmail.com>:
> On 03/26/11 06:31, zhao bao wrote:
>>> It's used to trace kernel space page faults, not for userspace code=
=2E
>>>
>>> Lin Ming
>>>
>>
>> From the ouput of "perf report" command, I think =C2=A0perf can reco=
rd the
>> page faults from userspace code.
>>
>> [root@localhost lab]# perf record -R -c 1 =C2=A0-d =C2=A0-e =C2=A0fa=
ults ./hello
>> hello,world
>
> '-e faults' is a software event. perf-trace does not handle S/W event=
s.
> perf-trace has been renamed to perf-script, and perf-script recently
> gained the ability to dump S/W events:
>
> https://lkml.org/lkml/2011/3/10/3
>
> David
>
Thanks. How can I apply your patch?  May I need upgrade to 2.6.38?
