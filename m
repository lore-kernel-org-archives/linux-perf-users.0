From: Milian Wolff <mail@milianw.de>
Subject: Re: Perf event for Wall-time based sampling?
Date: Fri, 19 Sep 2014 11:08:05 +0200
Message-ID: <2443884.bonfbbPyvc@milian-kdab2>
References: <2221771.b2oSN5LR6X@milian-kdab2> <20140918203625.GM2770@kernel.org> <5770573.p6hpIeRPQV@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:34164 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbaISJIM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 05:08:12 -0400
In-Reply-To: <5770573.p6hpIeRPQV@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

On Friday 19 September 2014 10:11:21 Milian Wolff wrote:
> On Thursday 18 September 2014 17:36:25 Arnaldo Carvalho de Melo wrote:
> > Em Thu, Sep 18, 2014 at 02:17:49PM -0600, David Ahern escreveu:
> > > On 9/18/14, 1:17 PM, Arnaldo Carvalho de Melo wrote:
> > > >>This was also why I asked my initial question, which I want to repeat
> > > >>once
> > > >>
> > > >>>more: Is there a technical reason to not offer a "timer" software
> > > >>>event
> > > >>>to
> > > >>>perf? I'm a complete layman when it comes to Kernel internals, but
> > > >>>from
> > > >>>a user point of view this would be awesome:
> > > >>>
> > > >>>perf record --call-graph dwarf -e sw-timer -F 100 someapplication
> > > >>>
> > > >>>This command would then create a timer in the kernel with a 100Hz
> > > >>>frequency. Whenever it fires, the callgraphs of all threads in
> > > >>>$someapplication are sampled and written to perf.data. Is this
> > > >>>technically not feasible? Or is it simply not implemented?
> > > >>>I'm experimenting with a libunwind based profiler, and with some ugly
> > > >>>signal hackery I can now grab backtraces by sending my application
> > > >>>SIGUSR1. Based on> >
> > > >
> > > >Humm, can't you do the same thing with perf? I.e. you send SIGUSR1 to
> > > >your app with the frequency you want, and then hook a 'perf probe' into
> > > >your signal... /me tries some stuff, will get back with results...
> 
> That is actually a very good idea. With the more powerful scripting
> abilities in perf now, that could/should do the job indeed. I'll also try
> this out.

Indeed, this does not seem to work as intended:

~~~~~~~~~~~~~~~~~~

#include <csignal>

extern "C" {

void signalHandler(int sig)
{
}

}

struct Pace
{
    Pace()
    {
        signal(SIGUSR1, &signalHandler);
    }
};

static Pace initializeLibPace;
~~~~~~~~~~~~~~~~~~~

# as user, run:
g++ -shared -fPIC -o libpace.so libpace.cpp
LD_PRELOAD=$(readlink -f libpace.so) somebinary
while true; do killall -s SIGUSR1 somebinary; done

# as root, run:
perf probe -x libpace.so signalHandler
perf record --call-graph dwarf -e probe_libpace:signalHandler -p $(pidof 
yourApp)
perf report -g graph --no-children

Nice! But there are multiple issues with this approach, compared to 
potentially offering it in perf directly:

1) you need root/elevated access to not only create the probe, but also to use 
it then during record. this also requires you to to attach to the debuggee, as 
you don't want to run most user-space apps as root. while runtime-attaching is 
a powerful feature, it is cumbersome to use for the simple case

2) all of the issues of signal handling. Try the above on my initial test 
application:

int main() {
  sleep(10);
  return 0;
}

After sending it the first SIGUSR1, the sleep will return. So we change the 
behavior of the application by profiling it, which is of course very bad. 
Sure, most of the time such sleeps are run in a loop, but even then one will 
influence the runtime behavior. And you will never find the spurious 
"sleep(100)" that you forgot in a debug session in your application...

3) What about multiple threads? One could potentially get it working by 
overwriting pthread_create/exit via LD_PRELOAD and propagating a custom signal 
via pthread_kill to all running threads when the external SIGUSR1 comes in.

So, I hope this shows you all that having such a feature in perf directly 
would be a good thing.

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
