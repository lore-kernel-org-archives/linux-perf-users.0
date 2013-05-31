From: Andrew Davidoff <davidoff@qedmf.net>
Subject: Re: Getting started with perf; a couple of questions
Date: Fri, 31 May 2013 01:09:18 -0600
Message-ID: <CAJLXCZTzRdLYmcRVTO_AeRawmZ55AtdABcKpu5T5A-Z89iHnbA@mail.gmail.com>
References: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com>
	<51A83824.1090907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:52583 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3EaHJT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 31 May 2013 03:09:19 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so3092714ief.12
        for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2013 00:09:18 -0700 (PDT)
In-Reply-To: <51A83824.1090907@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi,

Thanks for the quick response.

> add a -v and see if more info comes out.
>
> perf script can be used to dump events.

I tried again with -v on record, but I am still not getting any event
samples in perf.data. Looking at an ASCII dump with report -D, I see
43 PERF_RECORD_MMAP entries, each of which appears to be related to a
kernel module, but nothing for any of the events I have selected to
sample (each is simply listed like "page-faults stats:").

The run ends like this every time:

[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.004 MB perf.data (~194 samples) ]

"Woken up 1 times" seemed suspicious, if record should be sampling at
1000Hz. I tried using -F 1000 and adding cycles to my events list both
in an effort to get 1000Hz samples, but as far as I could tell, there
was no change in the recorded data.

Also note that when using -v with record, I get the message "failed to
write feature 2" at the very end of the run output. I do not get that
message without -v. I don't know what it's trying to tell me and
haven't looked at the source code yet.

The command I am running is a threaded python script (spawns workers).
As I understand the documentation, I shouldn't need any additional
flags for perf to collect data on all the threads, since it reads like
counter inheritance is on by default. In other words, I believe perf
record should be working in what is documented as "per-process" mode
by default. I tried using -i with record in case I wasn't
understanding correctly, but that didn't change anything.

I will play with this more tomorrow but any further advice is
appreciated. I feel like I'm probably just missing a switch or
something that's not entirely obvious from the scant documentation I
have found.

Thanks again.
Andy
