From: Arun Sharma <arun@sharma-home.net>
Subject: Re: [perfmon2] updating perf tool
Date: Thu, 17 Feb 2011 12:41:20 -0800
Message-ID: <AANLkTimLpuwZ-t_Y771MDq3B0QYptg2MVGb8=wrWvMRe@mail.gmail.com>
References: <AANLkTim5QGwisxLEHHHECrE1nLSYFxzXEMu7hvTRy09=@mail.gmail.com>
	<AANLkTi=h6Qb7aCB0wER-FEGMwkD6xp1sBgnQudTZ=e+x@mail.gmail.com>
	<AANLkTimqRjUTzv+AO7zHCfXvA1RZFDTjyb-r0s_MVNTW@mail.gmail.com>
	<AANLkTinYM-Sg2uQFkXFy25mSZZZEtTSAUNrA==CxJP0=@mail.gmail.com>
	<20110214194428.GE21384@ghostprotocols.net>
	<AANLkTikfaAbdFWzcvayOjYLNECKf_L08nUUEWUy=p8it@mail.gmail.com>
	<20110214204830.GF21384@ghostprotocols.net>
	<AANLkTimtE79s-=U80R7Ujs6BK2Brn4GoKqQJiN9cYNdg@mail.gmail.com>
	<20110215012405.GA22550@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45363 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab1BQUlV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Feb 2011 15:41:21 -0500
Received: by iyj8 with SMTP id 8so2773784iyj.19
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Feb 2011 12:41:20 -0800 (PST)
In-Reply-To: <20110215012405.GA22550@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Can Hankendi <hankendi@gmail.com>, linux-perf-users@vger.kernel.org, Tom Zanussi <tzanussi@gmail.com>

On Mon, Feb 14, 2011 at 5:24 PM, Arnaldo Carvalho de Melo
<acme@ghostprotocols.net> wrote:

> I really need to look at the efforts you made in this direction,
> experimentation, as in the --timehist case, is badly needed till we get
> a good set of features for easing more widespread and innovative use of
> this infrastructure.

If you're trying to marry python, cpuid, hardware topology detection
and linux syscalls not wrapped in python (yet), these projects might
also be interesting:

http://code.google.com/p/module-linux/
http://code.google.com/p/pycpuid/

Specifically:

http://code.google.com/p/pycpuid/source/browse/trunk/test/hwtopo.py

 -Arun
