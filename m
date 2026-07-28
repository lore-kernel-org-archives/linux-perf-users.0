Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD811FC110
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198484; cv=none; b=B8pEDz99rhPli0EX9nUyUkOwXJIt5blg5+Y4DcUp4C3yJhVgujNs2oSsie0jnVxY9GY7blZF2PG/K/m1A72Fzy+q/vHXgurfly28xM44DOkGamu7PeE88AnPZitX+7IE1lY5IEZI6fznIX1DPYzhiDcDj9VEnhViNu3ko9xORYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198484; c=relaxed/simple;
	bh=58UrrrBGVaEGVINzZ+jPzXOU7si+//wFrDLwFhd/yvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAESb8gymrHPqUGAsUeYoc6ycQ1sN0qMwGmLXTZe+oUO8Bh5yAnluV9aDUrawxPvEBNI0Wtt5C1UFwqrATd2fBFS44u8E1vH8vYYqph6DzYH0Jbt8wbPF/N6yq+CebQImx+v/D4kA+JJpqHbOom+zyOm48mNareCu5q36yVIxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh2tBK+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh2tBK+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4101F000E9;
	Tue, 28 Jul 2026 00:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198482;
	bh=N0cyFmSmHoP/rTwt+6UmbBtwWXOJgIDr6hcSkE5Y6Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zh2tBK+aLIbIZdg1h4SD4zYZGt4vx5BTYahlsn3h7LRMirvkSYv4c7/M7xI0a4H7/
	 0lXrsvetGqzgpkdQaChNl754xeeKW08alf8+P+7ogFe0rrUbu3xOLOAMYIuef1HqpI
	 +6MzWBnZfpoGa6pafYnn3Yej6xhlHblQ20uviLnoUV7B/ur5BserpnqFh3NUhL3+Ac
	 3O05Ylxph/cseXIwi7vUV4XEX8hopssr9hbnUIKYPI5D37K8dKnjwFI3RzLM+k0sgW
	 U8bXkeSloGCrTKZ91Dg5jgxZ48zi2VGBoTz43/XCbtSZJDiwVee3Z1j07nkNkfoLYv
	 2v40fS2WIeezg==
Date: Mon, 27 Jul 2026 17:28:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf sched: Suppress latency table output when
 trace samples are missing
Message-ID: <amf3kcpsgjjbQcwA@google.com>
References: <20260726032533.712462-1-atomlin@atomlin.com>
 <20260726032533.712462-2-atomlin@atomlin.com>
 <20260726033725.C765A1F000E9@smtp.kernel.org>
 <sgw62mtino7m4h3whr553dijcn5hiiz46hrbqdmj6qamudo26m@nri7gkvw2t7i>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sgw62mtino7m4h3whr553dijcn5hiiz46hrbqdmj6qamudo26m@nri7gkvw2t7i>

Hello,

On Sun, Jul 26, 2026 at 03:31:57PM -0400, Aaron Tomlin wrote:
> On Sun, Jul 26, 2026 at 03:37:25AM +0000, sashiko-bot@kernel.org wrote:
> > > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > > index 7fd63a9db4574..b3cf678573e0a 100644
> > > --- a/tools/perf/builtin-sched.c
> > > +++ b/tools/perf/builtin-sched.c
> > [ ... ]
> > > @@ -2018,18 +2018,19 @@ static int perf_sched__read_events(struct perf_sched *sched)
> > >  	if (perf_session__set_tracepoints_handlers(session, handlers))
> > >  		goto out_delete;
> > >  
> > > -	if (perf_session__has_traces(session, "record -R")) {
> > > -		int err = perf_session__process_events(session);
> > > -		if (err) {
> > > -			pr_err("Failed to process events, error %d", err);
> > > -			goto out_delete;
> > > -		}
> > > +	if (!perf_session__has_traces(session, "record -R"))
> > > +		goto out_delete;
> > 
> > [Severity: Medium]
> > This is a pre-existing issue, but does this patch now cause pipe mode to
> > always fail and return an error code?
> > 
> > Because sched.tool is initialized in cmd_sched() without the mandatory
> > .attr and .feature callbacks:
> > 
> > 	perf_tool__init(&sched.tool, /*ordered_events=*/true);
> > 	sched.tool.sample	 = perf_sched__process_tracepoint_sample;
> > 	sched.tool.comm		 = perf_sched__process_comm;
> > 	sched.tool.namespaces	 = perf_event__process_namespaces;
> > 	sched.tool.lost		 = perf_event__process_lost;
> > 	sched.tool.fork		 = perf_sched__process_fork_event;
> > 
> > In pipe mode, PERF_RECORD_HEADER_ATTR events are silently dropped by the
> > fallback stub handler, which prevents evlist population. As a result,
> > perf_session__has_traces() always evaluates to false when reading from a
> > pipe.
> > 
> > With this patch adding an early abort, does this mean commands like
> > 'perf sched latency -i -' will now unconditionally fail instead of processing
> > what they can?
> > 
> > [ ... ]
> > 
> > While reviewing the rest of the file, I noticed another pre-existing issue
> > in map_switch_event() that might surface under memory pressure:
> > 
> > 	sched_out:
> > 		if (sched->map.task_name) {
> > 			tr = thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
> > 			if (strcmp(tr->shortname, "") == 0)
> > 				goto out;
> > 
> > [Severity: High]
> > This is a pre-existing issue, but could this lead to a segmentation fault?
> > 
> > If memory allocation fails inside thread__init_runtime(), thread__get_runtime()
> > returns NULL. Unlike other places in map_switch_event() that verify the
> > returned pointer, the tr pointer is immediately dereferenced by strcmp() here
> > without a NULL check.
> 
> Hi Ian, Namhyung, Arnaldo,
> 
> These are pre-existing issues. However, do you mind if I resolve these
> valid concerns within this series?

I'm fine as long as you address them either in this series or a separate
one.

Thanks,
Namhyung

