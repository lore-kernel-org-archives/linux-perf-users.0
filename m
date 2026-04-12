Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACC23D281;
	Sun, 12 Apr 2026 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776024765; cv=none; b=DnxhkVbVTfxcJzd9MLMJifr3WDN+7HN6boJkN6koxtfiC7mUm6usdJQvLj/MQpj0oHvTygRnFx0Fko/0I6aSJAtTiv/B8m4vqqfdryO57371CCw9Petq/zKoFnxUaYZpSw/EVFDPnallftBIDa424sIYS/chV/dmWgAOWnhdGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776024765; c=relaxed/simple;
	bh=DU5BZHOTji9QqmJcau8Pnait08nOU5BN2cF+78oUApU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz2QOSXL45BCDg7PUFEx5qSMtR60bHO8ScNpstM0NSY/+1kJ/emfEHz8uy702TTcFGBqfZzQlsNGpVC2TEUuIbgcNY7vyO12Ny2D2DTzp9mhuwj5yMr8/57YEuEGGU/0wf0i9LAXkAAptGJlAlx5dEXVTXyhjnOwI00uv3rq61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2r2sfmt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2r2sfmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C741C19424;
	Sun, 12 Apr 2026 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776024765;
	bh=DU5BZHOTji9QqmJcau8Pnait08nOU5BN2cF+78oUApU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2r2sfmt3EOc8C+xykv/fof4QZPTI1L6C+fGSH4K+7RaRTLHZHwXDG+LSZUm0nOym
	 Knv+Bb72rdw9bFPNGZz6IZ3af3fJl5wjK8vA/vXn50NB1mqnWWuoXNRkPXh4Sspmbq
	 Vjjk/HLWCwqz0qapovo81jyH0zAhKjLshjIMgNQoji+Dr3XzSlVw4bNitQtKhOgWLh
	 iPkbpDE09BWpKxhquY12g2fFX35ZdhVBd1WjkDQM3N1HISLB5l3AuM6Af/+BEdiySy
	 oFjc1TZOI+KY17BLw/I8gVNyditBDXB+My4jZoJEQMAYqG12QCiqEU1PNzcqLRSVba
	 sQvplY5JFsZ0Q==
Date: Sun, 12 Apr 2026 13:12:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v10 14/29] perf inject: Don't pass evsel with sample
Message-ID: <adv8u4R70B1dpd6j@google.com>
References: <20260412020833.641177-15-irogers@google.com>
 <20260412024011.E0C43C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412024011.E0C43C116C6@smtp.kernel.org>

On Sun, Apr 12, 2026 at 02:40:11AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [High] Typo in bounds check for `build_id_size` in `perf_event__synthesize_mmap2_build_id` causes memory corruption and out-of-bounds read/write.
> - [High] The bounds check for `build_id.size` in `perf_event__synthesize_build_id` limits the size to the destination buffer's capacity instead of the source buffer's capacity, allowing an out-of-bounds read.
> - [Medium] The patch alters the PID and TID used in the synthesized ID sample of `mmap2` events, corrupting the event's sampling context.
> --
> 
> commit 86c6e453885cee2a25c1c4a4cc9e00545f4ba854
> Author: Ian Rogers <irogers@google.com>
> 
> perf inject: Don't pass evsel with sample
> 
> This commit cleans up the handling of sample and mmap_evsel when
> synthesizing build id events. It also attempts to bound check the filename
> length to avoid potential buffer overruns.
> 
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 85bee747f4cd2..9a6941cfaad34 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c

I've removed all new bound checkings in this file for now.

Thanks,
Namhyung

> [ ... ]
> > @@ -2252,17 +2267,22 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
> [ ... ]
> > +	if (filename_len >= sizeof(ev.mmap2.filename))
> > +		return -EINVAL;
> > +
> > +	len = sizeof(ev.build_id) + filename_len + 1;
> >  	len = PERF_ALIGN(len, sizeof(u64));
> >  
> > +	if (len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
> > +		return -E2BIG;
> > +
> >  	memset(&ev, 0, len);
> 
> Since the commit message explicitly mentions fixing potential buffer overruns
> in this function, is this out-of-bounds read another regression that needs
> addressing?
> 
> Looking at the rest of perf_event__synthesize_build_id():
> 
>     ev.build_id.size = bid->size;
>     if (ev.build_id.size > sizeof(ev.build_id.build_id))
>         ev.build_id.size = sizeof(ev.build_id.build_id);
>     memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);
> 
> The check limits ev.build_id.size to the destination buffer's capacity
> (24 bytes). However, bid->data is only 20 bytes. If a malformed file
> provides a bid->size between 21 and 24, could memcpy() read out-of-bounds
> from bid->data?
> 
> [ ... ]
> > @@ -2308,13 +2328,24 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
> [ ... ]
> > +	if (filename_len >= sizeof(ev.mmap2.filename))
> > +		return -EINVAL;
> > +
> > +	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
> >  	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
> >  
> > +	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
> > +		return -E2BIG;
> > +
> >  	memset(&ev, 0, ev_len);
> 
> Similar to the bounds check above, this function is mentioned in the commit
> message as receiving bounds checks, but does this existing typo cause a
> regression here?
> 
> Looking further down in perf_event__synthesize_mmap2_build_id():
> 
>     ev.mmap2.build_id_size = bid->size;
>     if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
>         ev.build_id.size = sizeof(ev.mmap2.build_id);
>     memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
> 
> If ev.mmap2.build_id_size exceeds the bounds, it modifies ev.build_id.size
> instead of truncating ev.mmap2.build_id_size. Could this result in an
> out-of-bounds read and write in the subsequent memcpy(), potentially
> corrupting adjacent fields like prot, flags, and filename?
> 
> [ ... ]
> > @@ -2339,7 +2370,12 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
> >  
> >  	array = &ev;
> >  	array += ev.header.size;
> > -	ret = perf_event__synthesize_id_sample(array, evsel->core.attr.sample_type, sample);
> > +	ret = __perf_event__synthesize_id_sample(array, sample_type,
> > +						pid, tid,
> > +						sample->time,
> > +						sample->id,
> > +						sample->stream_id,
> > +						sample->cpu);
> >  	if (ret < 0)
> >  		return ret;
> 
> Before this patch, the sample's PID and TID were extracted from the sampling
> context (sample->pid and sample->tid). By switching to
> __perf_event__synthesize_id_sample(), this now passes the mmap2 target
> pid and tid.
> 
> If a thread maps memory for a different process, the target mmap.pid differs
> from the sampling context sample->pid. Could this regression break event
> correlation for tools relying on the sample ID to identify the thread that
> generated the event?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260412020833.641177-1-irogers@google.com?part=14
