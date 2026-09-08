Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64353D1A98;
	Tue,  8 Sep 2026 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901499; cv=none; b=EDhAwrVZx8kEKwDADqvVsuyOJoBBkDZBwusvaByVrF3yKso4mHFKIKhHjWirmVTBsx4JWJxzs2P2ecbBRiPQdPOdxBTBpoxBb3d5EEucRR4DPsrGQBFsZmoNonsBII+OJiAOtNt3j/rsMwLyn1ZdU9FnH7VJup2aAna3hr0AH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901499; c=relaxed/simple;
	bh=y/LjqKGmSNqzBKZ4qFyaNYNfyZ0qHuEYWa7lN/MKmGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4likuoU7+MhMg0Vob4V836qinEgauvIMMDrbBkVlcta4C5byyJCz5C8wwI1xVwpchpcZLx6t+5V2y/H5JyQWWKxdB+u9O/wAAy8DSUScBl1eiDugg07B/jqg3eE9ESGK4Bl12NtWwZdvG207tLRJYzw51ntliGHeszXkLKjz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP4iqthk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP4iqthk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE24D1F00A3A;
	Tue,  8 Sep 2026 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901498;
	bh=eV5kLH6JFDoWWo+RIYDDNgLSh6DqgwmBSKFgw3+5Z3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bP4iqthkMAGumBWcKd8/VWv4gHz+aS1Cwy+y+UCa5cnfPIvWQ7JttsxpKYHSbMdv/
	 91RRSP0CqybOQ4qkL5HtEX1pZv8BEQXrd3bu0uroz7CJmNZJO/Jj9PFHC6FUz090af
	 6DJtnk2rgvwS0CwYJEdZgsPXgolfjAGgHKyPJlG8sZEWRY+XU+p6YpaFbIFoSGMrOW
	 f+BLml9uSIn2fCDnR6oTajaf3SVr8uhRN6qCNMA73vq8+SNyCg56g25U0C3WvdUUA0
	 9RlU+9nYOJV18IHa1wF8F94KxwbcoxfQ278Pk+uAt5UxIPkcFIzBu1TULWHJSTrVBS
	 /EQg59O+9MD4w==
Date: Tue, 8 Sep 2026 18:04:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2] perf ftrace latency: Do not read trace files when BPF
 is used
Message-ID: <aqB4d6H-qnPHKlSA@x2>
References: <20260831063938.756610-1-namhyung@kernel.org>
 <CAP-5=fWenUPGqNjy6CdzEnti8czpJTg14w=FTbDrTrHb9APRAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWenUPGqNjy6CdzEnti8czpJTg14w=FTbDrTrHb9APRAw@mail.gmail.com>

On Fri, Sep 04, 2026 at 10:36:08AM -0700, Ian Rogers wrote:
> On Sun, Aug 30, 2026 at 11:39 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I've realized that it didn't set up the tracing files when BPF is used
> > so poll() just returns immediately.  It ends up with calling poll()
> > unnecessarily in a loop.
> >
> > BPF still needs the loop to wait for the target process exiting or a
> > signal from users.  Let's use a semaphore instead.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
