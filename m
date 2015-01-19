From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf: Kconfig based feature selection
Date: Mon, 19 Jan 2015 17:04:16 +0100
Message-ID: <20150119160416.GA23726@krava.brq.redhat.com>
References: <CAGszK3i4ZuvCp_jSkCV26dPAeAUbjJ1PV7b0WtgmAK5Dn+1VaQ@mail.gmail.com>
 <54BD28A6.2030206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36435 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbbASQEX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 19 Jan 2015 11:04:23 -0500
Content-Disposition: inline
In-Reply-To: <54BD28A6.2030206@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Jan Heylen <heyleke@gmail.com>, linux-perf-users@vger.kernel.org, alexis.berlemont@gmail.com

On Mon, Jan 19, 2015 at 08:54:14AM -0700, David Ahern wrote:
> On 1/19/15 2:35 AM, Jan Heylen wrote:
> >Hi,
> >
> >I was wondering what the status is for following item on the TODO list:
> >
> >Use Kconfig to allow selecting features and build minimal version of
> >perf, e.g. one with just 'record' for use in embedded platforms.
> >
> >David Ahern prototyped this, dig those patches and update them
> >
> >
> >I tried a search for Kconfig on this mailing list it's archives, but
> >no good hit.
> >
> >I see in the github repos from David Ahern a link to commits from
> >Alexis Berlemont that look interesting, is there a plan to upstream
> >this?
> >https://github.com/aberlemont/linux/tree/perf/kbuild
> 
> Latest incarnation: https://lkml.org/lkml/2015/1/15/310
> 

and very latest one ine here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/build

v3 is coming shortly ;-)

jirka
