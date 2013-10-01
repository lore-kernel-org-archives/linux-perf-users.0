From: Johan Tibell <johan.tibell@gmail.com>
Subject: Re: 'annotate' confusingly reports 'add' instruction as taking most
 CPU time
Date: Tue, 1 Oct 2013 08:14:17 -0700
Message-ID: <CAK-tuPaSEXhoQjtHGNayTKjSqzc23N4nYqZAW+Fzjn=t0ZA4-g@mail.gmail.com>
References: <CAK-tuPbbbWcbJxk88xO_urj2ktk861xnG+tkOs0cZBjnowjMeA@mail.gmail.com>
 <alpine.DEB.2.10.1310010850260.11671@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:50346 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab3JAPOi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 1 Oct 2013 11:14:38 -0400
Received: by mail-qe0-f46.google.com with SMTP id x7so5033744qeu.5
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2013 08:14:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1310010850260.11671@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org

Hi Vince,

On Tue, Oct 1, 2013 at 5:53 AM, Vince Weaver <vincent.weaver@maine.edu> wrote:
> It looks like you're noticing "skid" which means the PC returned by the
> profiling is a little beyond the problem instruction because it is hard
> for the CPU to stop in exactly the right place.
>
> Typically the problem instruction will be a few before, not after.  I
> wouldn't think an unconditional branch would have much performance impact.
>
> What CPU do you have?  What event are you measuring?  If you have a new
> enough system you can look into using the (I think) ":p" flags to try to
> get more precise results, if you aren't already.

I found this table of modifiers:

    https://perf.wiki.kernel.org/index.php/Tutorial#Modifiers

But it's not obvious to me if they will improve measurement accuracy.

Cheers,
Johan
