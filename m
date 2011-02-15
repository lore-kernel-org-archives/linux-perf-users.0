From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [perfmon2] updating perf tool
Date: Mon, 14 Feb 2011 23:24:05 -0200
Message-ID: <20110215012405.GA22550@ghostprotocols.net>
References: <AANLkTim5QGwisxLEHHHECrE1nLSYFxzXEMu7hvTRy09=@mail.gmail.com>
 <AANLkTi=h6Qb7aCB0wER-FEGMwkD6xp1sBgnQudTZ=e+x@mail.gmail.com>
 <AANLkTimqRjUTzv+AO7zHCfXvA1RZFDTjyb-r0s_MVNTW@mail.gmail.com>
 <AANLkTinYM-Sg2uQFkXFy25mSZZZEtTSAUNrA==CxJP0=@mail.gmail.com>
 <20110214194428.GE21384@ghostprotocols.net>
 <AANLkTikfaAbdFWzcvayOjYLNECKf_L08nUUEWUy=p8it@mail.gmail.com>
 <20110214204830.GF21384@ghostprotocols.net>
 <AANLkTimtE79s-=U80R7Ujs6BK2Brn4GoKqQJiN9cYNdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:34836 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab1BOBYL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Feb 2011 20:24:11 -0500
Received: by yib18 with SMTP id 18so2336734yib.19
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2011 17:24:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimtE79s-=U80R7Ujs6BK2Brn4GoKqQJiN9cYNdg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: Can Hankendi <hankendi@gmail.com>, linux-perf-users@vger.kernel.org, Tom Zanussi <tzanussi@gmail.com>

Em Mon, Feb 14, 2011 at 02:04:35PM -0800, Arun Sharma escreveu:
> On Mon, Feb 14, 2011 at 12:48 PM, Arnaldo Carvalho de Melo wrote

> >> Potentially, perf itself could be structured as a set of shared
> >> libraries, which are then glued together using a scripting language.

> > That is what I'm talking about, see above commit.

> Sorry, I misunderstood. Looks like a step in the right direction!

:-)

I really need to look at the efforts you made in this direction,
experimentation, as in the --timehist case, is badly needed till we get
a good set of features for easing more widespread and innovative use of
this infrastructure.

On another use case, take the 'perf script' case: as I user I keep doing:

perf probe -L somefunction
perf probe falias=somefunction:line alias=long->variable->expression
perf record -e probe:f*
perf script -g python
perf script -s perf-script.py

rinse, repeat, using the shell script history to speed things up, surely
this can be shortened, as --timehist can be detected by report as
present in a perf.data file, etc.

Finding out use cases fast paths is the end goal, I think.

- Arnaldo
