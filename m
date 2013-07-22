From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: How does perf collects per thread/process events ?
Date: Mon, 22 Jul 2013 12:25:56 -0300
Message-ID: <20130722152556.GE2157@ghostprotocols.net>
References: <51E566DD.1070006@insa-lyon.fr>
 <1374466784.17730.12.camel@concordia>
 <51ECD63E.5070305@gmail.com>
 <51ED3743.4010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ye0-f174.google.com ([209.85.213.174]:48218 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab3GVPcp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 11:32:45 -0400
Received: by mail-ye0-f174.google.com with SMTP id q9so367304yen.33
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2013 08:32:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51ED3743.4010802@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Manuel Selva <selva.manuel@gmail.com>, Michael Ellerman <michael@ellerman.id.au>, linux-perf-users@vger.kernel.org

Em Mon, Jul 22, 2013 at 07:44:35AM -0600, David Ahern escreveu:
> On 7/22/13 12:50 AM, Manuel Selva wrote:
> >Thanks for the answer Michael.
> >
> >I just created an account to be able to edit the perf wiki page. Before
> >doing that, I am asking here if someone knows the policy to update this
> >wiki or who are the maintainers to ask them ?
> 
> Arnaldo is the current one I believe.

I wonder if there is a policy for all of wiki.kernel.org, checking...
Couldn't find any.

Policy in what regard? We expect people that know what they are talking
about and want to help write content that they are entitled to
collaborate in a lawful way so if you think you can do that, go ahead
:-)

- Arnaldo

> David
> 
> 
> >
> >On 07/22/2013 06:19 AM, Michael Ellerman wrote:
> >>On Tue, 2013-07-16 at 17:29 +0200, Manuel Selva wrote:
> >>>Hi,
> >>>
> >>>My question regards a platform equipped with 2 Intel Xeon X5650.
> >>>According to the perf wiki page
> >>>(https://perf.wiki.kernel.org/index.php/Tutorial), "by default perf stat
> >>>counts for all threads of the process and subsequent child processes and
> >>>threads" and "By default, perf stat counts in per-thread mode".
> >>>
> >>>So a first question is what is the default: per thread or per process ?
> >>
> >>It's per process, which is as described in the first quote above. The
> >>second quote is just wrong AFAICS.
> >>
> >>>Then, independently of the answer, I am wondering how does perf handles
> >>>per thread or per process regarding the scheduler and migrations. I
> >>>didn't find it explicitly in the Intel documentation but it seems
> >>>natural that hardware performance counters located on a given core are
> >>>only capable of counting event on this core and not on other cores. Is
> >>>it true ?
> >>>
> >>>Moreover, the wiki page says that "When a thread migrated from one
> >>>processor to another, counters are saved on the current processor and
> >>>are restored on the new one" (this seems to confirm the answer to my
> >>>previous question above). It means that the scheduler is aware about
> >>>"perf" or that perf is able to register a hook into the scheduler. So I
> >>>guess this is done in the kernel part of perf (in the implementation of
> >>>the perf_event_open system call) and not in the user land part, is it
> >>>true ?
> >>
> >>Yes.
> >>
> >>cheers
> >>
> >--
> >To unsubscribe from this list: send the line "unsubscribe
> >linux-perf-users" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
