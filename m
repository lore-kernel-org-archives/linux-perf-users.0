From: Mikolaj Konarski <mikolaj.konarski@gmail.com>
Subject: Re: How to trace threads created by a process after perf has started
 recording, using the -p PID flag?
Date: Sat, 22 Sep 2012 21:57:07 +0200
Message-ID: <CAHFo2uqzfukcOxiRjy1ssWhWBiEAHBJozN1DArCi9q5yCV+w9w@mail.gmail.com>
References: <CAHFo2uodOOiTKRbeZvFFbGry8XK85unXz+_L6imgH6EeiROc0Q@mail.gmail.com>
	<CAKYOsXwF-Rk97BEWk_fEHhfVisPy_q439tdx7H9onAOyFi=-uA@mail.gmail.com>
	<CAHFo2up0cy4A8pSX5=dJ4k95ZtUTEzvzqcvfRoaoUjedpcvw5Q@mail.gmail.com>
	<5046268F.4050504@gmail.com>
	<CAHFo2uq2pKx1FKSv5=mE7WhaqixJ2vzCSBxPeaz3DKE90vz0OQ@mail.gmail.com>
	<505E05D1.6090405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35681 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197Ab2IVT5J (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 22 Sep 2012 15:57:09 -0400
Received: by weyx8 with SMTP id x8so2601284wey.19
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Sep 2012 12:57:08 -0700 (PDT)
In-Reply-To: <505E05D1.6090405@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Bernie Pope <florbitous@gmail.com>, Duncan Coutts <duncan@well-typed.com>

On Sat, Sep 22, 2012 at 8:39 PM, David Ahern <dsahern@gmail.com> wrote:
> On 9/22/12 1:58 AM, Mikolaj Konarski wrote:
>> the "--timestamp" option of perf-record
>
> That option adds the timestamps to the samples if it were not otherwise
> added.

Thanks. Worth adding to our calls, then, even if
the timestamp is not that trustworthy right now.

>> If there's no way currently to generate externally meaningful
>> timestamps, could we file a feature request for the sake of the future?
>
> You mean like this: https://lkml.org/lkml/2011/6/7/638

Precisely. How did you know? What happened to those
patches? Is there a place I can +1 and *Like* them publicly? :)

Thanks again,
Mikolaj
