From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 3/6] perf script: move printing of 'common' data from
 print_event and rename
Date: Thu, 10 Mar 2011 12:51:09 -0300
Message-ID: <20110310155109.GB23555@ghostprotocols.net>
References: <1299734608-5223-1-git-send-email-daahern@cisco.com>
 <1299734608-5223-4-git-send-email-daahern@cisco.com>
 <20110310152053.GB12521@home.goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110310152053.GB12521@home.goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Ahern <daahern@cisco.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Mar 10, 2011 at 10:20:53AM -0500, Steven Rostedt escreveu:
> On Wed, Mar 09, 2011 at 10:23:25PM -0700, David Ahern wrote:
> > This change does impact output: latency data is trace specific and =
is now
> > printed after the common data - comm, tid, cpu, time and event name=
=2E

> > Signed-off-by: David Ahern <daahern@cisco.com>

> >  tools/perf/builtin-script.c         |   38 ++++++++++++++++++++++-=
----
> >  tools/perf/util/trace-event-parse.c |   49 +++++++----------------=
-----------

> I was hoping after the next merge window to start making a common lib=
rary
> for parsing events. This way things like powertop and timechart or
> anything that uses the perf interface does not need to write its own
> parsing of events, or expect the event formats to be hardcoded.
>=20
> The trace-event-parse.c was taking from trace-cmd's parse-events.c co=
de
> and hopefully the two can merge again. The parse-events.c code in
> trace-cmd has gone through several iterations that has made it much m=
ore
> robust and flexible. I purposely kept it as a separate libarary not
> dependent on trace-cmd so that it could be used by other utilities li=
ke
> perf.

David is kinda new to this perf/ftrace/trace-cmd/etc soap opera, and he
has been patient to go thru the motions with Peter, Thomas, Fr=E9d=E9ri=
c and
me, going from doing what he wants in 'perf report' to 'perf script',
etc.

We're almost to the point where his feature is implemented in a
way Fr=E9d=E9ric, the one most actively reviewing his work, is satisfie=
d,
right Fr=E9d=E9ric?

I think the merge with the libraries you mention is something that is
not a precondition to merging David's work.

And his work is at least moving things in the trace parts of tools/,
that was so far dormant.

- Arnaldo
