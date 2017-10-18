From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 2/4] Add fp argument to print functions
Date: Wed, 18 Oct 2017 09:22:09 -0300
Message-ID: <20171018122209.GF3707@kernel.org>
References: <1507746240-34638-1-git-send-email-ufo19890607@gmail.com>
 <1507746240-34638-3-git-send-email-ufo19890607@gmail.com>
 <20171017140137.GD4204@kernel.org>
 <CAHCio2ggZapg7KvWOO3OonFTHq5CZ02c2sghTpP73QBJ0mi9jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965078AbdJRMWM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 Oct 2017 08:22:12 -0400
Content-Disposition: inline
In-Reply-To: <CAHCio2ggZapg7KvWOO3OonFTHq5CZ02c2sghTpP73QBJ0mi9jg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Wind Yu <yuzhoujian@didichuxing.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Wed, Oct 18, 2017 at 07:54:13PM +0800, 禹舟键 escreveu:
> Hi, Arnaldo
> I have done it as you said in v1 patch, but David had told me to separate
> the patch :"Makes all those related functions receive the FILE pointer"  to
> two patches. Below is his opinion.
> 
> On 9/13/17 9:10 AM, yuzhoujian wrote:
> > @@ -1621,8 +1634,12 @@ static int process_comm_event(struct perf_tool
> *tool,
> >               sample->tid = event->comm.tid;
> >               sample->pid = event->comm.pid;
> >       }
> > -     print_sample_start(sample, thread, evsel);
> > -     perf_event__fprintf(event, stdout);
> > +     if (tool->orientation_output == false)
> > +             fp = stdout;
> > +     else
> > +             fp = orientation_file;
> > +     fprint_sample_start(sample, thread, evsel, fp);
> > +     perf_event__fprintf(event, fp);
> >       ret = 0;
> >  out:
> >       thread__put(thread);
> 
> "The subject of this patch is replacing printf and stdout with fprintf
> and a given fp. Please keep it to that one change. Meaning the above
> setting of fp something other than stdout should be a separate patch.

I have done exactly as described in my and David's suggestion, this
"orientation_file" change is not in my patch.

> And it would be best to have the fp selection in a helper, versus the
> same change in so many places. "
> 
> So, what should I do??

Please consider continuing from the other suggestion I made in a recent
message, about how to use evsel->priv to store the perf evsel FILE
pointer.

- Arnaldo
