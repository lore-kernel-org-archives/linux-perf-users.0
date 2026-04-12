Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D42DA765;
	Sun, 12 Apr 2026 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776024666; cv=none; b=krl1/UaNPanPR4SjXJFMTCEXyfG7jXcquc0roAlG9Z6+fZ8P9L7+P5SYEPylcAP0Lhn4Ua0lmbj0CGKEsXjxhjcjDVv1Yf6iUyBErXOeMBF+glw7uqQxjSDK7pAALtQDlHWwmmOdfKC8QGScti1hs7TlalO4GhVN1Ujy+AvHqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776024666; c=relaxed/simple;
	bh=xD9D7/AznUZAG41N43xvNIp4+5G8oFDLC2TRiZWI4vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwf7VfBzIFsvHhOZceoAwz9ZAZGaeTSnKe1NxCUIxjQgdaXc+p9aeicmwBR+93w6EUqameAwBIXVXAnLWDTBKuW6CjdbRbGdKjLa8iP4IEE53fVMgq9DRXRTjDaV5UYFX3Tn74nlWA3plbHM8wdZHho3k1kJFEsULn44Muxf2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFrpTY4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFrpTY4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CF1C19424;
	Sun, 12 Apr 2026 20:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776024665;
	bh=xD9D7/AznUZAG41N43xvNIp4+5G8oFDLC2TRiZWI4vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFrpTY4BxdtqBszLyDvBodcMtpKAgqP40mXa2bZoy8zy7gbsXkjMGg2jmwzFgxyIQ
	 9nEZZoFMVOh4TV6kYkXbedawSzkaW8MtCC3Ly5ty9j5pVu2b1cLmzIQ5QqyPoaqKWI
	 2LkmtrvEvc8bu3RPftS6FsFmDkER1hU7MYOIXHe5Ha0W2TyUKY6izLIqiMJiAd8hkq
	 GW5hYUcwqJVKPMmAKbAZWyWYgLKcuX96+N7gt9coM+1Zrrrj3/Cy+97x2Hzx61s3DM
	 9oJNvlEwivAldoMwUGehfgX5AaRvvdysxRR23bNlPVf8MTyorC0dXZsByfr/wfGzhs
	 eD6GagbOyX9fQ==
Date: Sun, 12 Apr 2026 13:11:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v10 04/29] perf evsel: Refactor evsel tracepoint sample
 accessors perf_sample
Message-ID: <adv8WGAZUBy3q4MV@google.com>
References: <20260412020833.641177-5-irogers@google.com>
 <20260412023420.44E47C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412023420.44E47C116C6@smtp.kernel.org>

On Sun, Apr 12, 2026 at 02:34:19AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] Removal of `strdup` in `sched_work_init` introduces a Use-After-Free vulnerability when storing the task name.
> --
> 
> commit 0d7b6945ae0c6b8ad53d53aacf54fb3b747a99a7
> Author: Ian Rogers <irogers@google.com>
> 
> perf evsel: Refactor evsel tracepoint sample accessors perf_sample
> 
> This commit removes the evsel argument from tracepoint sample accessor
> functions, renaming them to reflect that the data is being read directly
> from the sample.
> 
> Please note that the issue discussed below was resolved in a later commit
> upstream, specifically commit 5e8ad46aaa11f37f17084b59fcd84e6b4bbc3d6e
> (perf kwork: Fix memory management of kwork_work). It is included here
> for completeness regarding this specific patch.
> 
> [ ... ]
> > diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> > index d4bb19ed91b59..8ba5ea201bf94 100644
> > --- a/tools/perf/builtin-kwork.c
> > +++ b/tools/perf/builtin-kwork.c
> [ ... ]
> > @@ -1310,11 +1309,11 @@ static void sched_work_init(struct perf_kwork *kwork __maybe_unused,
> >  	work->cpu = sample->cpu;
> >  
> >  	if (src_type == KWORK_TRACE_EXIT) {
> > -		work->id = evsel__intval(evsel, sample, "prev_pid");
> > -		work->name = strdup(evsel__strval(evsel, sample, "prev_comm"));
> > +		work->id = perf_sample__intval(sample, "prev_pid");
> > +		work->name = perf_sample__strval(sample, "prev_comm");
> 
> Does removing the strdup call here leave work->name pointing directly to
> the raw data inside the memory mapped ring buffer?
> 
> If perf_sample__strval returns a pointer to the sample data, that memory
> will be overwritten as new events arrive. When the reporting phase later
> iterates over the kwork_work tree, could this result in a use-after-free
> and output garbage strings?

I've removed this part for now.

Thanks,
Namhyung

> 
> >  	} else if (src_type == KWORK_TRACE_ENTRY) {
> > -		work->id = evsel__intval(evsel, sample, "next_pid");
> > -		work->name = strdup(evsel__strval(evsel, sample, "next_comm"));
> > +		work->id = perf_sample__intval(sample, "next_pid");
> > +		work->name = perf_sample__strval(sample, "next_comm");
> >  	}
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260412020833.641177-1-irogers@google.com?part=4
