From: Benjamin King <benjaminking@web.de>
Subject: Re: perf probe an addr without debuginfo
Date: Tue, 30 Jun 2015 22:44:13 +0200
Message-ID: <20150630204413.GA4234@localhost>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com>
 <20150628154651.GA3953@localhost>
 <20150629150038.GA1225@kernel.org>
 <20150630064457.GA20873@localhost>
 <CAE40pdd3NRDQsPBA0WPgGiGs8RAN4riT6rE9f-9thZdSqJdjyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:55950 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbbF3Uob (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Jun 2015 16:44:31 -0400
Content-Disposition: inline
In-Reply-To: <CAE40pdd3NRDQsPBA0WPgGiGs8RAN4riT6rE9f-9thZdSqJdjyg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Hi Brendan,

>Nice - and I'd been thinking along the same lines, that it wouldn't be
>hard to write a helper, and published something to do it all from
>ftrace: http://www.brendangregg.com/blog/2015-06-28/linux-ftrace-uprobe.html

Ah, missed that one, much cleaner than my attempt, thanks.

The only thing I would miss is the "match symbol by regular expression"
feature from my script. Needing to work with C++, where each Foo has new and
exciting ideas on how to implement Foo::bar(), tracing the bar's Pokemon
style (probe em all!) often helps me maintain sanity :-)

Cheers,
  Benjamin
