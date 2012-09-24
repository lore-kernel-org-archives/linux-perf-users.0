From: David Ahern <dsahern@gmail.com>
Subject: Re: How to trace threads created by a process after perf has started
 recording, using the -p PID flag?
Date: Sun, 23 Sep 2012 22:31:17 -0600
Message-ID: <505FE215.3060102@gmail.com>
References: <CAHFo2uodOOiTKRbeZvFFbGry8XK85unXz+_L6imgH6EeiROc0Q@mail.gmail.com> <CAKYOsXwF-Rk97BEWk_fEHhfVisPy_q439tdx7H9onAOyFi=-uA@mail.gmail.com> <CAHFo2up0cy4A8pSX5=dJ4k95ZtUTEzvzqcvfRoaoUjedpcvw5Q@mail.gmail.com> <5046268F.4050504@gmail.com> <CAHFo2uq2pKx1FKSv5=mE7WhaqixJ2vzCSBxPeaz3DKE90vz0OQ@mail.gmail.com> <505E05D1.6090405@gmail.com> <CAHFo2uqzfukcOxiRjy1ssWhWBiEAHBJozN1DArCi9q5yCV+w9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34341 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab2IXEbU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Sep 2012 00:31:20 -0400
Received: by padhz1 with SMTP id hz1so668311pad.19
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Sep 2012 21:31:19 -0700 (PDT)
In-Reply-To: <CAHFo2uqzfukcOxiRjy1ssWhWBiEAHBJozN1DArCi9q5yCV+w9w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mikolaj Konarski <mikolaj.konarski@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Bernie Pope <florbitous@gmail.com>, Duncan Coutts <duncan@well-typed.com>

On 9/22/12 1:57 PM, Mikolaj Konarski wrote:
>>> If there's no way currently to generate externally meaningful
>>> timestamps, could we file a feature request for the sake of the future?
>>
>> You mean like this: https://lkml.org/lkml/2011/6/7/638
>
> Precisely. How did you know? What happened to those
> patches? Is there a place I can +1 and *Like* them publicly? :)

I'm still waiting for certain changes to core perf before I try again to 
get it committed. I haven't forgotten; it's just not ready yet.

And using the time-of-day patch against a newer kernel (tried 3.2, 3.4 
and 3.6) I do see the offset you mentioned. I'll need to look into it 
what to do. I'm traveling this week, so next week is the earliest.

David
