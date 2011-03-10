From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 3/6] perf script: move printing of 'common' data from
 print_event and rename
Date: Thu, 10 Mar 2011 13:20:38 -0300
Message-ID: <20110310162038.GC23555@ghostprotocols.net>
References: <1299734608-5223-1-git-send-email-daahern@cisco.com>
 <1299734608-5223-4-git-send-email-daahern@cisco.com>
 <20110310152053.GB12521@home.goodmis.org>
 <20110310155109.GB23555@ghostprotocols.net>
 <1299773135.15854.352.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40971 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1CJQUq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Mar 2011 11:20:46 -0500
Content-Disposition: inline
In-Reply-To: <1299773135.15854.352.camel@gandalf.stny.rr.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Ahern <daahern@cisco.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de

Em Thu, Mar 10, 2011 at 11:05:35AM -0500, Steven Rostedt escreveu:
> On Thu, 2011-03-10 at 12:51 -0300, Arnaldo Carvalho de Melo wrote:
> > David is kinda new to this perf/ftrace/trace-cmd/etc soap opera, an=
d he

> Lucky him ;)

:-)
=20
> > has been patient to go thru the motions with Peter, Thomas, Fr=E9d=E9=
ric and
> > me, going from doing what he wants in 'perf report' to 'perf script=
',
> > etc.
> >=20
> > We're almost to the point where his feature is implemented in a
> > way Fr=E9d=E9ric, the one most actively reviewing his work, is sati=
sfied,
> > right Fr=E9d=E9ric?
>=20
> You must have one of those keyboards where it is easy to make that =E9

gnome makes this all mostly easy, and my native language, as Fr=E9d=E9r=
ic's,
have those pesky characters :)
=20
> > I think the merge with the libraries you mention is something that =
is
> > not a precondition to merging David's work.
> >=20
> > And his work is at least moving things in the trace parts of tools/=
,
> > that was so far dormant.
>=20
> Note, I'm not saying that his work should be put on hold. I actually
> want to start it up again. Maybe I worded this response wrong. It was
> more about bringing David up to speed on what I want to do next than
> saying not to do this work.

Right, I just wanted to make sure he doesn't spill his coffee with what
could seem like yet another requirement to work on infrastructure to ge=
t
his legitimate feature implementation merged :-)

- Arnaldo
