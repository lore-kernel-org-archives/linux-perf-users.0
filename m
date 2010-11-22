From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] perf symbols: reuse of name in dso__load when starting
 second pass
Date: Mon, 22 Nov 2010 10:35:30 -0200
Message-ID: <20101122123530.GA9129@ghostprotocols.net>
References: <1290351830-4398-1-git-send-email-daahern@cisco.com>
 <20101121220337.GB4056@ghostprotocols.net>
 <4CE9BE66.3060109@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59716 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014Ab0KVMfh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Nov 2010 07:35:37 -0500
Received: by gxk23 with SMTP id 23so3987698gxk.19
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2010 04:35:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE9BE66.3060109@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "David S. Ahern" <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org

Em Sun, Nov 21, 2010 at 05:50:46PM -0700, David S. Ahern escreveu:
> On 11/21/10 15:03, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Nov 21, 2010 at 08:03:50AM -0700, David Ahern escreveu:
> >> continue statement in default case applies when a second pass is
> >> wanted as well. As it stands the code drops down to the open
> >> re-using the value in name from the previous origin attempt.
> >>
> >> Signed-off-by: David Ahern <daahern@cisco.com>
> >> ---
> >>  tools/perf/util/symbol.c |    4 ++--
> >>  1 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> >> index d30136e..861be8b 100644
> >> --- a/tools/perf/util/symbol.c
> >> +++ b/tools/perf/util/symbol.c
> >> @@ -1488,8 +1488,8 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
> >>  			if (want_symtab) {
> >>  				want_symtab = 0;
> >>  				self->origin = DSO__ORIG_BUILD_ID_CACHE;
> >> -			} else
> >> -				continue;
> >> +			}
> >> +			continue;

> > But we want to restart at DSO__ORIG_BUILD_ID_CACHE, right? If you do
> > your change we keep a existing mistake and will instead restart at
> > DSO__ORIG_BUILD_ID_CACHE + 1, please take a look to validate my
> > understanding that we need to set self->origin to
> > DSO__ORIG_BUILD_ID_CACHE - 1.
> 
> Correct. In working on the rootfs change I noticed that the default case
> falls through to the open using the 'name' value set from the previous
> origin so it is tried twice. This patch fixes that bug.
> 
> I also noted that the BUILD_ID_CACHE was skipped, but I was not sure if
> that was desired or not. If it is then correcting the proper 'next
> origin' is another trivial bug fix.
> 
> Some projects like single focused bug fixes for bisecting. I am fine
> with combining if that is wanted.

Agreed, two is better, I'll apply yours and add a followup fixing this
other issue, thanks.

- Arnaldo
