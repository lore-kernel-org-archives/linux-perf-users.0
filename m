From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: A shortcut to select generalized hw events
Date: Tue, 31 May 2011 21:03:07 +0200
Message-ID: <BANLkTikE_E9oQGSp4-M7ArAip+Wd63xvgw@mail.gmail.com>
References: <BANLkTinxXczFsG8hd8fQULiCch8-FnMbBA@mail.gmail.com>
	<4DDFAB2B.90107@draigBrady.com>
	<4DE50793.8040607@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36721 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab1EaTDH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 31 May 2011 15:03:07 -0400
Received: by pzk9 with SMTP id 9so2157302pzk.19
        for <linux-perf-users@vger.kernel.org>; Tue, 31 May 2011 12:03:07 -0700 (PDT)
In-Reply-To: <4DE50793.8040607@draigBrady.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

Hello,

2011/5/31 P=E1draig Brady <P@draigbrady.com>:
> On 27/05/11 14:46, P=E1draig Brady wrote:
>> On 27/05/11 13:01, Francis Moreau wrote:
>>> Hello,
>>>
>>> Is there a mean to select all counters of a certain type ?
>>>
>>> For example I'd like to select all generalized hw counter with
>>> perf-stat, is this possible ?
>>
>> I was looking for that too.
>> I didn't look too hard, but there was nothing obvious.
>> It would be very useful for example, to print all hardware counters
>> that are supported by the current system as you say.
>> To do that, I'm using this perf-hw script:
>>
>> #!/bin/sh
>> hw_events=3D$(
>> =A0for i in $(perf list | sed -n 's/\[Hardware.*event\]//; T; s/ OR =
=2E*//; p'); do
>> =A0 =A0 perf stat -e $i true >/dev/null 2>&1 &&
>> =A0 =A0 =A0printf -- "-e %s \n" $i
>> =A0done | tr -d '\n'
>> )
>> perf stat $hw_events $*
>
> I've also just noticed the -ddd option recently added with:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D2cba3ffb
>
> I've attached some more documentation which might be useful?

Probably more useful is to update the man pages too with a '-d -d -d'
verbosity :)

BTW, can't this new option be part to perf-record too ?

Thanks
--=20
=46rancis
