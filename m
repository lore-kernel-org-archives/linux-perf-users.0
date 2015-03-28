From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Sat, 28 Mar 2015 13:24:12 -0300
Message-ID: <20150328162412.GO21510@kernel.org>
References: <CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com>
 <CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com>
 <CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
 <20150320203922.GO16485@kernel.org>
 <20150320210709.GQ16485@kernel.org>
 <CABPqkBRjHMOzNL=vWqzTUNA_8FidDk=THBErj4c6Tj=6Yw+0hg@mail.gmail.com>
 <20150323002708.GB2782@sejong>
 <CABPqkBRee=X_UumuZfW_9d50f1gjFj4NG_rqchityfYjGQvWXw@mail.gmail.com>
 <3FAA059E-DC0F-4290-BDB5-AE2950D1E1CA@gmail.com>
 <CABPqkBQ0gVCqPVC2BCSLFLrXmeNnP-yoo7sAfxJyZf8qp6vCiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51165 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbbC1QYJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 28 Mar 2015 12:24:09 -0400
Content-Disposition: inline
In-Reply-To: <CABPqkBQ0gVCqPVC2BCSLFLrXmeNnP-yoo7sAfxJyZf8qp6vCiw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Stephane Eranian <eranian@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Ingo Molnar <mingo@kernel.org>

Em Fri, Mar 27, 2015 at 04:05:03PM -0700, Stephane Eranian escreveu:
> On Mon, Mar 23, 2015 at 9:56 AM, Arnaldo Carvalho de Melo wrote:
> > Le 23 mars 2015 13:49:24 GMT-03:00, Stephane Eranian <eranian@googl=
e.com> a =E9crit :
> >>On Sun, Mar 22, 2015 at 5:27 PM, Namhyung Kim <namhyung@kernel.org>
> >>> Did you play with acme/perf/core not tip/perf/core?  I got same
> >>> problem but then I realize it's not the Arnaldo's tree.  When I
> >>> changed to acme/perf/core the problem disappeared. :)

> >>I was only trying it with tip.git. The patch looke simple enough to
> >>apply to tip.git but clearly it relies on some other infrastructure
> >>changes which I don't know about. In my case =3D, I care about gett=
ing
> >>this feature in tip.git or older versions of perf.

> > It is all in tip.git by now.

> >>> But unfortunately I got this segfault instead..

> > Needs a patch that is in perf/urgent

> If I pull tip.git now. Does it have what is needed to work?

Yes, it should, but you may hit the bug Namhyumg reported, fixed in:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
tools/perf/util/annotate.c?id=3D3995614d9b0320e10ce202836c8477e1bcf1a2d=
4

perf annotate: Fix fallback to unparsed disassembler line

----

Humm, by tip.git you mean tip.git/master?  /me checks...

[acme@ssdandy linux]$ git log --oneline tip/master
tools/perf/util/annotate.c | head -5
571564babaa3 Merge branch 'perf/core'
2c7da8c590ad perf annotate: Allow annotation for decompressed kernel mo=
dules    <------------------
3995614d9b03 perf annotate: Fix fallback to unparsed disassembler line
48000a1aed74 perf tools: Remove EOL whitespaces
0fb9f2aab738 perf annotate: Fix memory leaks in LOCK handling
[acme@ssdandy linux]$

Yeah, it is there, should have everything you need.

- Arnaldo
