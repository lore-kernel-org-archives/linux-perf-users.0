Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874410A1E;
	Fri, 11 Apr 2025 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332113; cv=none; b=Axmf03gcZKr8kIay9IBvbJ2cZ4CYezjQOyZThD3RSFmd1PcRNI1OBxxkiCyhLPtgI+1+FrT3i/cvqsrLIU7nyUpwcRB61LPWlM6arTLkm5G+YMfW0u9fAvjTsTQfTFJdufocxKe5441qnULBt4xRcCE8priOB3hapmT9NgbS0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332113; c=relaxed/simple;
	bh=GZ2lw2fCKwKsSyYomMWYNjvRnqTJSg4nDmIfrd7O2Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTyBZ2dH13Gifk8/UF6xs0fxpFOeR4xB6HHS8MOx68ZsOzOD/pZQRPdzi4o4TJA3YoVHhjt/L7vvZCTSgQd3auHb5lBN4DKobqEFEllLJkXPP/bEIleZRFl48d9JxsI3wDWrMFbs9Q1axiKcVau38NKSCWby1PvhIrAW24Q7dRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjIdneOk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjIdneOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F120EC4CEE8;
	Fri, 11 Apr 2025 00:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744332112;
	bh=GZ2lw2fCKwKsSyYomMWYNjvRnqTJSg4nDmIfrd7O2Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjIdneOk86LlA1Fej1UPuq8Te3y8mAHYtqtJVkU6p5pPN6edmw9G/+c87opDgfiLh
	 vJkhOGHFsojl5O22F2ujtDVSptoCSB+eyNGe5sA2lxoF70yGzQ8M8T5Ax60IqnXygV
	 jdV/4JGEDymk1hX7itbE40kgM/SdsjzeVkESLpqw9XhYFu1cx+bnIVeJqEZ17bSglm
	 PCS+oxs75pUzVwnqBzEuJh0DEzLA+2XXVVKoehMfrBuK2wdlR3K+sd8R+yDjGMI/BE
	 O8eJzJ0x6wesgrVXCcKAJdfe4TcELUqBAl6go0EaxW1e5zCW30Dt49E+fQtlz4nU3W
	 Tg5Ocw02Y0Tdw==
Date: Thu, 10 Apr 2025 17:41:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, dvyukov@google.com, ben.gainey@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf report: Skip unsupported new event types
Message-ID: <Z_hlTkkeFPydVyI7@google.com>
References: <20250409183958.1540709-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409183958.1540709-1-ctshao@google.com>

On Wed, Apr 09, 2025 at 11:39:30AM -0700, Chun-Tse Shao wrote:
> `perf report` currently halts with an error when encountering
> unsupported new event types (`event.type >= PERF_RECORD_HEADER_MAX`).
> This patch modifies the behavior to skip these samples and continue
> processing the remaining events.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/session.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 60fb9997ea0d..b4c7973c34e2 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1639,8 +1639,17 @@ static s64 perf_session__process_event(struct perf_session *session,
>  	if (session->header.needs_swap)
>  		event_swap(event, evlist__sample_id_all(evlist));
>  
> -	if (event->header.type >= PERF_RECORD_HEADER_MAX)
> -		return -EINVAL;
> +	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
> +		if (!PERF_ALIGN(event->header.size, sizeof(u64)))

I think you wanted:

		if (event->header.size % sizeof(u64))


> +			/* perf should not support unaligned event */
> +			ui__warning("Skip unaligned event type %u.\n", event->header.type);

And I think we should stop here.  Going with unaligned data will cause
more troubles I guess.

Thanks,
Namhyung


> +		else
> +			/* This perf is outdated and does not support the latest event type. */
> +			ui__warning("Unsupported type %u, please considering update perf.\n",
> +				    event->header.type);
> +		/* Skip unsupported/unaligned event by returning its size. */
> +		return event->header.size;
> +	}
>  
>  	events_stats__inc(&evlist->stats, event->header.type);
>  
> -- 
> 2.49.0.504.g3bcea36a83-goog
> 
