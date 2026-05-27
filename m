Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355112D1F1;
	Wed, 27 May 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921067; cv=none; b=GO4XyhC6m1HOPq5A9EsaCUy9BJoXf3Y/HRxc8/6TYPHVW2GxScM5WTGt1DTJ7klllsnS7XQu9fZy449P1yMEiTKiAyiF0yxJMfDm3A0ZqeSOt/ZfOXrpxatWuuZI8ZyGMgrjqPvYdExE+OQM3+Uwul1n9znSU6JbMtSiQyEZebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921067; c=relaxed/simple;
	bh=959JmWaaNqjTRE1kUJy/QtlcvpTcnosmFJGHXyuDKdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2ZvjIWZLjktibteb7OYxmmevdTLEtTMThw26R4HlSPpRTZ5+9T8jAitDqvfKOVov+lUFsqQ6BsnA37QQf5MaG9gc5xXt/Aq5QL9d6F2sShy7igVCXcULFcB40uBKGEaH1t9rbuOVmA6s9wfAJ4xv+/lPQ/eE78foWy2AdDIuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDZinpNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDZinpNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9281F000E9;
	Wed, 27 May 2026 22:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779921065;
	bh=VPJs/RUbF5BvcxPfEa6YTmu4xeHBBJF/HKNvAnrYcSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XDZinpNJo+cDCUJjYZKHG33mcrcyCpcsX4bFUBPHzSviQhlDngm4jFUenhv4pThl1
	 B7b+ySmbkyLcySRlmQmfjsO8xPiYUAt5B6dkOkqoJMDOGQvjzbLYAHZj67vDHS78jJ
	 THV8+mqUmKVv9Qep1+eRxvKYtrhFGpX6OskVDgediFyhan6SeUw04xV7nvPxNlWA8b
	 gxZd7gl9GrqsD7fgArVYteDmLDbnaOq9RTffqXviA8oRzIMY1aMjBYIoNfn8LAAQbZ
	 WepNqqHHxI6/Uvsofu+LkujMOrRSMimHgRMPtWCrbI/ENlbSnylEsKSa0v9FIeqkGQ
	 Tw+q7Y7pQ+WEg==
Date: Wed, 27 May 2026 15:31:03 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>, sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: Re: [PATCH 01/29] perf session: Add minimum event size and alignment
 validation
Message-ID: <ahdwp4LW9H7gdJxg@google.com>
References: <20260526211806.1193848-1-acme@kernel.org>
 <20260526211806.1193848-2-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526211806.1193848-2-acme@kernel.org>

On Tue, May 26, 2026 at 06:17:37PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Add a per-type minimum size table (perf_event__min_size[]) and
> enforce it before swap and processing, so that both cross-endian
> and native-endian paths are protected from accessing fields past
> the event boundary.
> 
> The table uses offsetof() for types with trailing variable-length
> fields (filenames, strings, msg arrays) and sizeof() for
> fixed-size types.  Zero entries mean no minimum beyond the 8-byte
> header already enforced by the reader.
> 
> Undersized events are skipped with a warning in process_event
> and rejected in peek_event — both checked before the swap
> handler runs, preventing OOB access on crafted event fields.
> 
> Also reject events whose header.size is not 8-byte aligned.  The
> kernel aligns all event sizes to sizeof(u64) — see
> perf_event_comm_event() (ALIGN), perf_event_mmap_event(),
> perf_event_cgroup(), perf_event_ksymbol() (IS_ALIGNED loops),
> and perf_event_text_poke() (ALIGN) in kernel/events/core.c.
> An unaligned size means the file is corrupted or crafted; reject
> early so downstream code that divides by sizeof(u64) to compute
> array element counts gets exact results.
> 
> Three legacy user events are exempted from the alignment check:
> TRACING_DATA (66) had a 12-byte struct before commit b39c915a4f36
> ("libperf event: Ensure tracing data is multiple of 8 sized")
> added padding, COMPRESSED (81) carries raw ZSTD output (already
> superseded by COMPRESSED2 with PERF_ALIGN), and HEADER_FEATURE
> (80) uses do_write_string() with a 4-byte length prefix.
> 
> Also guard event_swap() against crafted event types >=
> PERF_RECORD_HEADER_MAX to prevent OOB reads on the
> perf_event__swap_ops[] array.
> 
> Changes in v2:
> - Fix double-skip for unsupported event types: return 0 instead
>   of event->header.size in perf_session__process_event() for
>   HEADER_MAX, since reader__read_event() already advances by
>   event->header.size (Reported-by: sashiko-bot@kernel.org)
> - Exempt TRACING_DATA, COMPRESSED, and HEADER_FEATURE from the
>   alignment check — these legacy user events predate the 8-byte
>   alignment rule (Reported-by: sashiko-bot@kernel.org)
> - peek_event: return 0 (skip) for unknown event types instead of
>   -1 (error), consistent with process_event which already skips
>   unsupported types gracefully (Reported-by: sashiko-bot@kernel.org)
> 
> Reported-by: sashiko-bot@kernel.org # Running on a local machine
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
[SNIP]
> +	/*
> +	 * Check alignment before type: an unaligned size misaligns the
> +	 * stream for all subsequent reads regardless of event type.
> +	 * Three legacy user events predate the 8-byte rule — exempt them.
> +	 */
> +	if (event->header.size % sizeof(u64) &&
> +	    event->header.type != PERF_RECORD_HEADER_TRACING_DATA &&
> +	    event->header.type != PERF_RECORD_COMPRESSED &&
> +	    event->header.type != PERF_RECORD_HEADER_FEATURE) {

Do we still allow misaligned data for these types?  I think we should
maintain 8 bytes alignment.  Can we add some paddings?

Thanks,
Namhyung


> +		pr_warning("WARNING: peek_event: event type %u size %u not aligned to %zu\n",
> +			   event->header.type,
> +			   event->header.size, sizeof(u64));
>  		return -1;
> +	}
