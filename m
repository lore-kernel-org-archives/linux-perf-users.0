From: Alex Newman <posix4e@gmail.com>
Subject: Re: Bug Report
Date: Mon, 11 May 2015 10:56:39 -0700
Message-ID: <CAPMERtji+=bZffRL-kFpvkte-P_U3DR3fs+FXe=zS9L91JphhQ@mail.gmail.com>
References: <CAPMERti9KnqyR7U3upPz0wh14CEO=W1T=0_cDQ61cBASdKH-yQ@mail.gmail.com>
 <5550E37B.8070209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33350 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbbEKR5B (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 May 2015 13:57:01 -0400
Received: by qkx62 with SMTP id 62so92247472qkx.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2015 10:57:00 -0700 (PDT)
In-Reply-To: <5550E37B.8070209@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Ah sorry for the typo. David, that's correct. But you should be able
to replicate that the error message is not revealing.

On Mon, May 11, 2015 at 10:14 AM, David Ahern <dsahern@gmail.com> wrote:
> On 5/11/15 10:57 AM, Alex Newman wrote:
>>
>> Hello mailing list friends,
>>
>> I am sorry if this is not the best place for this (where should I
>> report improvements for perf).
>>
>> This command works when I have the correct permissions but if I don't
>> rather than getting "bad permissions" I get
>>
>> posix4e@posix4e-P27GV2:~$ perf stat -e 'ext4:' -a
>
>
> that's an invalid event list; it should never work. Did you mean -e
> 'ext4:*'?
>
> David
