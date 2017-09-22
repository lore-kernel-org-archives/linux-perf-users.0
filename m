From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/4] Add the fp_selection_helper function to set the file
 pointer for the related functions
Date: Fri, 22 Sep 2017 11:18:40 -0300
Message-ID: <20170922141840.GJ29668@kernel.org>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-4-git-send-email-yuzhoujian@didichuxing.com>
 <20170922090327.GG15856@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751928AbdIVO0O (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Sep 2017 10:26:14 -0400
Content-Disposition: inline
In-Reply-To: <20170922090327.GG15856@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: yuzhoujian <ufo19890607@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Fri, Sep 22, 2017 at 11:03:27AM +0200, Jiri Olsa escreveu:
> On Mon, Sep 18, 2017 at 01:55:21PM +0800, yuzhoujian wrote:
> > Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> > ---
> >  tools/perf/builtin-script.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index f709f6f..89bab68 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -1527,6 +1527,13 @@ static int cleanup_scripting(void)
> >  	return scripting_ops ? scripting_ops->stop_script() : 0;
> >  }
> >  
> > +static FILE *fp_selection_helper(bool per_event_dump)
> > +{
> > +	if (per_event_dump == false)
> > +		return stdout;
> > +	else
> > +		return per_event_dump_file;
> 
> when's the per_event_dump_file ever set? 

And my first reaction with this "helper" was: what is this needed for?!?
Why not have a local variable in the function where the whole chain is
called from and there set the output doing this 'perf_event_dump' test
_just once_.

Also, using 'per_event_dump == false' for a boolean variable is valid,
but utterly uncommon and unnecessary, why not:

	FILE *fp = per_event_dump ? per_event_dump_file : stdout;

then use fp to pass to the initial function, etc?

- Arnaldo
