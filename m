Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161F38C2D4;
	Mon,  6 Apr 2026 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498004; cv=none; b=ivwMwbC6o1IfX4AevThVxPDzRxuXlZdfuPp+SswqjDzwk2COYOUQb8ifI4RQhN1WlS+WfQjLWRRH0EGyRqhvjk2KBVhc4iVCLoj47SbE34VqL/ofeH98JAbvIcWEp/Jd4GpxDt1CY7iITYU90q+hg8G3Rm21w1Xpq/iHVF35kSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498004; c=relaxed/simple;
	bh=RD0ywh7RJCkyuq7flVBjWK34hmokECYZH60WWQqb+Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju2VRSfqVAYUVa53mz/5mEzQjxe7QnTU5KL3B6AK89C8pVZi1G5gZA7A3WIM1NIgAoEQhFeryuKyfihNa0ANSE29nFqd9Z/G57DjeLZoFvFqBuVeKFvmGBI5QYN+JuGvSjRRwMZqQ3HDFblosWSAO0SA9WbU7/7lk95QHoIlB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9W4lAtJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9W4lAtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFA9C4CEF7;
	Mon,  6 Apr 2026 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775498004;
	bh=RD0ywh7RJCkyuq7flVBjWK34hmokECYZH60WWQqb+Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9W4lAtJOVKLEc0LrIPRu9YIXQxcmqO0Mi1Y85WUVLj+AZDJNxa3NiCVvwFNKAy3M
	 jSHt/4f+mAWs6u0vns1J5McWHaSW3eLYaabrjtFMRhfRkqfEJHvN75ANglO3rCnZPM
	 sd1IgqS6chVAG4IkMbuN3jXC1+sS4I6FfBCq9ocZj/1AzRK3fCuwTbeZVmotTgMGAv
	 Jcf0pRetn7qbeLSrxJhAkk1pDGSRhiKauAGJNbKVf7Z/Bb8ZjMmD4doaTE+JGsgk1t
	 kZYC6U7IA1iIwBK1N++t5t9eyGVxqYJ3bUBKevFfiYFsLWJqhbfYNWmb6T/4AmQFbw
	 oVFkmP164YyXQ==
Date: Mon, 6 Apr 2026 10:53:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf sched: Avoid segv if tp_handler not set
Message-ID: <adPzEmwDaHq4SsZw@google.com>
References: <20260321061448.810525-1-irogers@google.com>
 <acW_IHQVZnxIETdd@google.com>
 <CAP-5=fWh66OwPC0K4ZyedAWqwyXez0ya9Dz6hzbgY0AhoqMfdg@mail.gmail.com>
 <ac8pEDUKjuMxXUS6@google.com>
 <CAP-5=fXeBje03BM8D9q-0KsXg2KmyRa81CuphtSQfHp0isFc_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXeBje03BM8D9q-0KsXg2KmyRa81CuphtSQfHp0isFc_w@mail.gmail.com>

On Fri, Apr 03, 2026 at 08:29:25AM -0700, Ian Rogers wrote:
> On Thu, Apr 2, 2026 at 7:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Mar 31, 2026 at 10:59:52PM -0700, Ian Rogers wrote:
> > > On Thu, Mar 26, 2026 at 4:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Fri, Mar 20, 2026 at 11:14:47PM -0700, Ian Rogers wrote:
> > > > > Doing a `perf sched record` then `perf sched stats report` crashes as
> > > > > the tp_handler isn't set. Add extra checks that tp_handler is set
> > > > > before accessing through it.
> > > >
> > > > Oh.. unintended use case. :)  Probably better to add a dummy handler
> > > > for `perf sched stats report`.
> > >
> > > Perhaps. I'd prefer to land the simpler change as-is.
> >
> > Well.. I guess the dummy handler approach would be simpler and perform
> > better. :)
> >
> > Thanks,
> > Namhyung
> >
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index d083e2bb770303a4..9fb5447f9014d026 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -4955,6 +4955,7 @@ int cmd_sched(int argc, const char **argv)
> >                 .switch_event       = replay_switch_event,
> >                 .fork_event         = replay_fork_event,
> >         };
> > +       struct trace_sched_handler stats_ops  = {};
> 
> Oh, because there's an existing null test on the function pointer we
> don't need dummy functions, which is what I thought you were asking
> for. I'm still not convinced this is very intention revealing, but if
> it works for you then you can have my reviewed-by tag.

Applied this and the patch 2 to perf-tools-next, thanks!

Best regards,
Namhyung

