From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/4] Makes all those related functions receive the FILE
 pointer
Date: Fri, 22 Sep 2017 11:15:54 -0300
Message-ID: <20170922141554.GI29668@kernel.org>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-3-git-send-email-yuzhoujian@didichuxing.com>
 <20170922090319.GF15856@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbdIVOQK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Sep 2017 10:16:10 -0400
Content-Disposition: inline
In-Reply-To: <20170922090319.GF15856@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: yuzhoujian <ufo19890607@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Fri, Sep 22, 2017 at 11:03:19AM +0200, Jiri Olsa escreveu:
> On Mon, Sep 18, 2017 at 01:55:20PM +0800, yuzhoujian wrote:
> > Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> > +++ b/tools/perf/builtin-script.c
> > @@ -486,8 +486,8 @@ static int perf_session__check_output_opt(struct perf_session *session)
> >  	return 0;
> >  }
> >  
> > -static void print_sample_iregs(struct perf_sample *sample,
> > -			  struct perf_event_attr *attr)
> > +static void fprint_sample_iregs(struct perf_sample *sample,
> > +			  struct perf_event_attr *attr, FILE *fp)
> 
> please make sure the perf gets compiled after every change,
> I think this will break compile because of unused *fp,
> use the __maybe_unused attribute

Yes, that will save me some time, as I _will_ do this. Doing it
judiciously will make me want to review and process your patches faster
in the future, BTW.

To know why this is important, please read about 'git bisect'.

- Arnaldo
