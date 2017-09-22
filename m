From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/4] Makes all those related functions receive the FILE
 pointer
Date: Fri, 22 Sep 2017 11:14:42 -0300
Message-ID: <20170922141442.GH29668@kernel.org>
References: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
 <1505714122-39141-3-git-send-email-yuzhoujian@didichuxing.com>
 <20170922090312.GE15856@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbdIVOO4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Sep 2017 10:14:56 -0400
Content-Disposition: inline
In-Reply-To: <20170922090312.GE15856@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: yuzhoujian <ufo19890607@gmail.com>, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Em Fri, Sep 22, 2017 at 11:03:12AM +0200, Jiri Olsa escreveu:
> On Mon, Sep 18, 2017 at 01:55:20PM +0800, yuzhoujian wrote:
> 
> SNIP
> 
> >  out_put:
> >  	addr_location__put(&al);
> > @@ -1605,6 +1617,7 @@ static int process_comm_event(struct perf_tool *tool,
> >  	struct perf_session *session = script->session;
> >  	struct perf_evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> >  	int ret = -1;
> > +	FILE *fp;
> >  
> >  	thread = machine__findnew_thread(machine, event->comm.pid, event->comm.tid);
> >  	if (thread == NULL) {
> > @@ -1621,8 +1634,9 @@ static int process_comm_event(struct perf_tool *tool,
> >  		sample->tid = event->comm.tid;
> >  		sample->pid = event->comm.pid;
> >  	}
> > -	print_sample_start(sample, thread, evsel);
> > -	perf_event__fprintf(event, stdout);
> > +	fp = stdout;
> > +	fprint_sample_start(sample, thread, evsel, fp);
> > +	perf_event__fprintf(event, fp);
> 
> please make this simple 'adding fp argument to print functions'
> change and just pass stdout in here ... and do the rest of changes
> later on

That was what I asked him when I first reviewied this patchset.

- Arnaldo
