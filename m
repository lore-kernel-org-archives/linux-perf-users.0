From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Filter option should follow a tracer option
Date: Wed, 23 Aug 2017 10:22:51 -0300
Message-ID: <20170823132251.GB31893@kernel.org>
References: <2141818167.39420.1503049431846@office.mailbox.org>
 <20170822190011.GA31893@kernel.org>
 <a214874a-a271-729e-d253-731e648a10e6@intel.com>
 <98754540.17249.1503478275998@office.mailbox.org>
 <de75121e-cafc-0389-039b-fb038e0ff7c6@intel.com>
 <301454280.19507.1503490276770@office.mailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753973AbdHWNWz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2017 09:22:55 -0400
Content-Disposition: inline
In-Reply-To: <301454280.19507.1503490276770@office.mailbox.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jack Henschel <jackdev@mailbox.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org

Em Wed, Aug 23, 2017 at 02:11:16PM +0200, Jack Henschel escreveu:
> > Adrian Hunter <adrian.hunter@intel.com> hat am 23. August 2017 um 12:33 geschrieben:
> > On 23/08/17 11:51, Jack Henschel wrote:
> > >> Adrian Hunter <adrian.hunter@intel.com> hat am 23. August 2017 um 08:06 geschrieben:
> > >> On 22/08/17 22:00, Arnaldo Carvalho de Melo wrote:
> > >>> Em Fri, Aug 18, 2017 at 11:43:51AM +0200, Jack Henschel escreveu:
> > >>>> I'm using perf version 4.9.30 with kernel 4.9.30-2+deb9u3 on Debian 9 Stretch.

> > >> It looks like either your CPU does not support Intel PT at all, or it does not support address filtering.

> > > My CPU (Xeon CPU E5-2680 v4) supports Intel PT (intel_pt flag is
> > > present in /proc/cpuinfo), but this is not an issue with Intel PT.
> > > Here are some more examples (with various syntaxes):

> > I think that is Broadwell which doesn't have address filtering.
> Indeed, it is Broadwell.
 
> > >> Have you checked the value of /sys/bus/event_source/devices/intel_pt/nr_addr_filters ?
> > > I don't have that file:
> > 
> > Which definitely means address filtering is not supported.  That is
> > mentioned in the man page for 'perf record'.

> Ok, thanks for the clarification. It is mentioned in the perf record
> man-page, but the perf error message could be a little bit more
> specific for this issue. (e.g.
> /sys/bus/event_source/devices/intel_pt/nr_addr_filters not present ->
> "CPU does not support address filtering").

Right, I'll get that into some __strerror() function. Will CC you when
that is done.

E.g. __strerror() function: perf_evsel__open_strerror(), that helps the
user wrt errors returned by the perf_evsel__open() function:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evsel.c?h=perf/core#n2669

- Arnaldo
