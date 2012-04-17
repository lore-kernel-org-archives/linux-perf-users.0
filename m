From: Lin Ming <mlin@ss.pku.edu.cn>
Subject: Re: Question on perf hardware event_ cache misses
Date: Tue, 17 Apr 2012 12:31:25 +0800
Message-ID: <CAF1ivSZ8UuLs7_K+Ymtv0M=YAn9XP8h2XmosKtyU5sL=hPEzPw@mail.gmail.com>
References: <1334346399.20093.YahooMailNeo@web120703.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from [124.207.24.138] ([124.207.24.138]:50965 "EHLO
	mail.ss.pku.edu.cn" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2DQEiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Apr 2012 00:38:15 -0400
Received: from mail-vx0-f174.google.com (mail-vx0-f174.google.com [209.85.220.174])
	(Authenticated sender: mlin@ss.pku.edu.cn)
	by mail.ss.pku.edu.cn (Postfix) with ESMTPA id 1F74CDBC50
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Apr 2012 12:31:28 +0800 (CST)
Received: by vcqp1 with SMTP id p1so3810594vcq.19
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Apr 2012 21:31:25 -0700 (PDT)
In-Reply-To: <1334346399.20093.YahooMailNeo@web120703.mail.ne1.yahoo.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Junjie Qian <junjie.qian@yahoo.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Sat, Apr 14, 2012 at 3:46 AM, Junjie Qian <junjie.qian@yahoo.com> wr=
ote:
> Dear all,
>
> I have one question regarding the perf event "cache misses =A0--hardw=
are events".
>
> I am not sure which level of cache misses does this hardware event me=
an? Last level cache? Or total cache misses number? Or others?
>
> Could anyone give me a hint on this? Or where I can check this in sou=
rce code?

It's last level cache if your are using Intel x86 CPU.

>
> Thanks!
> Best
> Junjie
