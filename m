From: Andrew Davidoff <davidoff@qedmf.net>
Subject: Re: Getting started with perf; a couple of questions
Date: Fri, 31 May 2013 14:35:33 -0600
Message-ID: <CAJLXCZTN1xLXk79kh5i8WbJBB+4sh0Qs1v+PndhLKSrPPvZ2wQ@mail.gmail.com>
References: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com>
	<51A83824.1090907@gmail.com>
	<CAJLXCZTzRdLYmcRVTO_AeRawmZ55AtdABcKpu5T5A-Z89iHnbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:45025 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217Ab3EaUfd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 31 May 2013 16:35:33 -0400
Received: by mail-ie0-f176.google.com with SMTP id at20so5031619iec.21
        for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2013 13:35:33 -0700 (PDT)
In-Reply-To: <CAJLXCZTzRdLYmcRVTO_AeRawmZ55AtdABcKpu5T5A-Z89iHnbA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Fri, May 31, 2013 at 1:09 AM, Andrew Davidoff <davidoff@qedmf.net> wrote:
> I will play with this more tomorrow but any further advice is
> appreciated. I feel like I'm probably just missing a switch or
> something that's not entirely obvious from the scant documentation I
> have found.

After struggling a bit more with this on the original host:

Ubuntu 10.04.4 LTS
kernel 2.6.32-47-server
perf versions 3.9.4 and 3.8.13

with no change in results, I gave it a shot on a CentOS 6 virtual
machine on my Mac:

CentOS release 6.4 (Final)
kernel 3.9.4 AND kernel 2.6.32-358.2.1.el6.x86_64
perf version 3.9.4

And perf record is working as I'd expect it to. To be clear about the
description above, under CentOS,  perf record 3.9.4 is recording
samples whether I'm running kernel 3.9.4 or 2.6.32-358.2.1.el6.x86_64.

So...Ubuntu thing? Or maybe just a 10.04 thing (yeah, I know it's old).

Maybe this'll help someone.

Thanks all.
Andy
