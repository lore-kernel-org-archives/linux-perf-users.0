From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf: Kconfig based feature selection
Date: Mon, 19 Jan 2015 21:32:47 +0100
Message-ID: <20150119203247.GA7162@krava.brq.redhat.com>
References: <CAGszK3i4ZuvCp_jSkCV26dPAeAUbjJ1PV7b0WtgmAK5Dn+1VaQ@mail.gmail.com>
 <54BD28A6.2030206@gmail.com>
 <20150119160416.GA23726@krava.brq.redhat.com>
 <CAGszK3gvpa+wd5-vCtHi1cuty-xtiQqnKz2c_BtZgqv1CtUk6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50451 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbbASUcv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Jan 2015 15:32:51 -0500
Content-Disposition: inline
In-Reply-To: <CAGszK3gvpa+wd5-vCtHi1cuty-xtiQqnKz2c_BtZgqv1CtUk6w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jan Heylen <heyleke@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org, Alexis Berlemont <alexis.berlemont@gmail.com>

On Mon, Jan 19, 2015 at 09:02:15PM +0100, Jan Heylen wrote:
> On Mon, Jan 19, 2015 at 5:04 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> > On Mon, Jan 19, 2015 at 08:54:14AM -0700, David Ahern wrote:
> >> On 1/19/15 2:35 AM, Jan Heylen wrote:
> >> >Hi,
> >> >
> >> >I was wondering what the status is for following item on the TODO list:
> >> >
> >> >Use Kconfig to allow selecting features and build minimal version of
> >> >perf, e.g. one with just 'record' for use in embedded platforms.
> >> >
> >> >David Ahern prototyped this, dig those patches and update them
> >> >
> >> >
> >> >I tried a search for Kconfig on this mailing list it's archives, but
> >> >no good hit.
> >> >
> >> >I see in the github repos from David Ahern a link to commits from
> >> >Alexis Berlemont that look interesting, is there a plan to upstream
> >> >this?
> >> >https://github.com/aberlemont/linux/tree/perf/kbuild
> >>
> >> Latest incarnation: https://lkml.org/lkml/2015/1/15/310
> >>
> >
> > and very latest one ine here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/build
> >
> > v3 is coming shortly ;-)
> >
> > jirka
> 
> Nice work.
> 
> What is the status on the first part of the TODO list?
> 
> > >Use Kconfig to allow selecting features and build minimal version of
> > >perf, e.g. one with just 'record' for use in embedded platforms.
> 
> I don't find this back in this patch series, although it looks like a
> good base to make this possible?

yep, among other things it's also the base for the rest of the Kconfig stuff

As I wrote in the 0/ changelog:

---
Also this patchset is kind of incremental version of the latest:
  perf tools: Add kbuild support into Makefile.kbuild
so it should be easier to review.
---

> 
> About the perf-feature choosing though Kconfig alike infrastructure as
> in Alexis tree. Is there a plan to pick up that work too or isn't that
> the intention?

yep, thats the plan.. the next stop is the Kconfig base and the rest
should be incremental additions of CONFIG_* stuff to make parts
of perf optional.

jirka
