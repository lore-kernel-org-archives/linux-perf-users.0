Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D541B34C;
	Wed,  6 May 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084253; cv=none; b=dkk2evzNsZKTlWbDZaSznTWgTIMQeQmjlc6Ru+pg+micJSBdP+tdQf5VPfc5zZfK/G4Vb5ohiofWAXxobBwOHd5pVDku6mSPvwTiEsebtshIkzQ7kfmM98GKO1lblE2hxgBVqea/apzPioiMSDbyrLMhpdoSk84qJPO2tpyF1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084253; c=relaxed/simple;
	bh=QZEGj+zGbPB4xRjUECGEQpFYJV7SWrByqjQ3P+rMW8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sokBZ9bTan9SrCco2/yJL98R4nY6KAc1jnQAZRcYbzAAbRFqIPOpqOmNPRPkkN8NZ3QMvUhaVKE02EZruJ+ykfJiCFYySA1jmNWtDktBtgsjyx+MjNdnrE61VPPuixixCPmo1V6Rcr5Ue7T2kYFfDGH2khE1Uhv7VBxgcv4C+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m20SaIk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m20SaIk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A19C2BCB0;
	Wed,  6 May 2026 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084252;
	bh=QZEGj+zGbPB4xRjUECGEQpFYJV7SWrByqjQ3P+rMW8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m20SaIk+8CaM4eHR47J1kr4kR+Fr2/yGqCKc/biHg8+rCL9TlciNvDNI7i8sNUZa6
	 G2xTlm5MItGwYl4buq9g7/EbHaURcS2FZyeUSS+Ih4KXJF0XDrdo7QGvpJzXMstpT7
	 hKVF7sVpkpfQzI1Gn0B6tbqU13IwpIaohLVKE8VzH/PV1aZFxebmdQUj1KcVh/FXbt
	 JIpiwBaHfM3/f5lAVM+eY39r3jAwdd3151Ov2zzZ3g4TdftgPTMrJluiA6eqMqsk10
	 em5BJivfKTAMqubNgPRmEB33ooJxcId3+mJpqMAAw26z86w5iNGVyGlZtxgkGMrOSD
	 yuPJGYMQ6hVlw==
Date: Wed, 6 May 2026 09:17:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
Message-ID: <aftpmFmahaykG7Rg@google.com>
References: <20260321061448.810525-1-irogers@google.com>
 <acW_IHQVZnxIETdd@google.com>
 <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com>
 <ac8pEDUKjuMxXUS6@google.com>
 <CAP-5=fXeBje03BM8D9q-0KsXg2KmyRa81CuphtSQfHp0isFc_w@mail.gmail.com>
 <adPzEmwDaHq4SsZw@google.com>
 <CAP-5=fW-H-ri3MdVv4Vh4xiyB-qpDqnO3gqXR+XyfMK+kXpHQA@mail.gmail.com>
 <afs9tx6hpi9CiEzN@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afs9tx6hpi9CiEzN@x1>

On Wed, May 06, 2026 at 10:10:15AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 05, 2026 at 02:56:02PM -0700, Ian Rogers wrote:
> > On Mon, Apr 6, 2026 at 10:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Fri, Apr 03, 2026 at 08:29:25AM -0700, Ian Rogers wrote:
> > > > On Thu, Apr 2, 2026 at 7:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > On Tue, Mar 31, 2026 at 10:59:52PM -0700, Ian Rogers wrote:
> > > > > > On Thu, Mar 26, 2026 at 4:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> > > > > > > > Doing a `perf sched record` then `perf sched stats report` crashes as
> > > > > > > > the tp_handler isn't set. Add extra checks that tp_handler is set
> > > > > > > > before accessing through it.
> 
> > > > > > > Oh.. unintended use case. :)  Probably better to add a dummy handler
> > > > > > > for `perf sched stats report`.
> 
> > > > > > Perhaps. I'd prefer to land the simpler change as-is.
> 
> > > > > Well.. I guess the dummy handler approach would be simpler and perform
> > > > > better. :)
> 
> > > > > +++ b/tools/perf/builtin-sched.c
> > > > > @@ -4955,6 +4955,7 @@ int cmd_sched(int argc, const char **argv)
> > > > >                 .switch_event       = replay_switch_event,
> > > > >                 .fork_event         = replay_fork_event,
> > > > >         };
> > > > > +       struct trace_sched_handler stats_ops  = {};
> > > >
> > > > Oh, because there's an existing null test on the function pointer we
> > > > don't need dummy functions, which is what I thought you were asking
> > > > for. I'm still not convinced this is very intention revealing, but if
> > > > it works for you then you can have my reviewed-by tag.
> 
> > > Applied this and the patch 2 to perf-tools-next, thanks!
>  
> > Thanks Namhyung. Did this get accidentally dropped? I'm not seeing it
> > in perf-tools-next.

I think I've applied my approach and test fix.

Thanks,
Namhyung

