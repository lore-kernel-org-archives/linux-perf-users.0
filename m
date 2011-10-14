From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: perf for analyzing userspace contention
Date: Fri, 14 Oct 2011 10:42:08 +0100
Message-ID: <CAJSP0QW9PCjRjQdRQFxVi3DEi4F1PV-jFw1m9p=rmMdjpZb1Kg@mail.gmail.com>
References: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39231 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab1JNJmI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Oct 2011 05:42:08 -0400
Received: by ggnb1 with SMTP id b1so193072ggn.19
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2011 02:42:08 -0700 (PDT)
In-Reply-To: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Roland Dreier <roland@kernel.org>
Cc: linux-perf-users@vger.kernel.org

On Fri, Oct 14, 2011 at 7:36 AM, Roland Dreier <roland@kernel.org> wrot=
e:
> Anyway, suppose I have a multithreaded userspace app that uses a bunc=
h of
> pthread_mutexes, and I want to figure out which locks are hot and/or =
heavily
> contended. =A0What's the best way to do that? =A0Is perf the right, o=
r is there
> something better? =A0(This seems like such an obvious thing to want t=
hat there
> must be some good way to get this data, I hope)

Hi Roland,
I haven't tried this tool myself yet but have been wanting to for somet=
ime:
http://git.0pointer.de/?p=3Dmutrace.git

Here's the full overview of what it does:
http://0pointer.de/blog/projects/mutrace.html

Stefan
