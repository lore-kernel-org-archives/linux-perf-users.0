Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1627A133;
	Mon, 26 Jan 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462245; cv=none; b=Bs+aDeQZA7qnkBmESA/xdn2yle5bZytMClM7QwokP/Be8RyCd1YPnA/momKWAqmxH6ZVUYxa2u3xR/3VIJmSwJP4c1yaPZzRhKO9cGrJVFVfg2uf2YlebWeJ06XExIGivhqUmSKcnjhXdGhTtqk7TXt9/SfbvEHGM3GZwGL6ddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462245; c=relaxed/simple;
	bh=8+aBiqDm0d0xur20v2DN0X/vximpAYB4L1ijfKo0N40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl757rmvZiV/d0RnN5NdQVY17+eCZPZQpeWFjbm1wFyX1P/qAHw38qemCM48LgMMQvYmfBSR3Z4wjHiY6ev4KX4nVhbIt34nk25nThLxW5TRQYZ7DqeyCnAr4mmwy5aY2WvkiAFBnOuNfudBBb8ENniFq9Z+c6d8ov16epmoQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBvUZ4BW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBvUZ4BW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B79C116C6;
	Mon, 26 Jan 2026 21:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769462244;
	bh=8+aBiqDm0d0xur20v2DN0X/vximpAYB4L1ijfKo0N40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBvUZ4BWDbsuKSXXegVekdprIN2V7CoCqhb3grs4Qk8q/j8tIKIN/57h80jm51BgO
	 lSq5QFxBRY5YKQpLauTdcqweT3XuzqHwkUvmmZoiaVKsg1pcOWDWENvdYqLkrpXlNH
	 9lUezPE36dpoJE2jo2SMu9pPvWPCEK8z+TncMTwbGa1e02cJG7FTksQNGRcV+B9TF2
	 FTCaysDxxpIceutRaQReuEwwqWVukIWBT6s2NFj28BdLdpWenOiQxzGY+0LlkimNNs
	 /A3U+G0VA41qhca72Df67kTZk8xXFYnwgHMVExRUPUjTEoxr+MtfKsgZ32qS1LgJF9
	 kcb5/zHAvlvgw==
Date: Mon, 26 Jan 2026 18:17:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hrishikesh Suresh <hrishikesh123s@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Blake Jones <blakejones@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf session: print all machines in session dump
Message-ID: <aXfZ4dIUKJVMG93Q@x1>
References: <20260125200759.57816-1-hrishikesh123s@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125200759.57816-1-hrishikesh123s@gmail.com>

On Sun, Jan 25, 2026 at 09:06:52PM +0100, Hrishikesh Suresh wrote:
> +++ b/tools/perf/util/session.c
> @@ -2674,11 +2674,15 @@ size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp)
>  
>  size_t perf_session__fprintf(struct perf_session *session, FILE *fp)
>  {
> -	/*
> -	 * FIXME: Here we have to actually print all the machines in this
> -	 * session, not just the host...
> -	 */
> -	return machine__fprintf(&session->machines.host, fp);
> +	struct rb_node *nd;
> +	struct machine *pos;
> +	size_t ret = machine__fprintf(&session->machines.host, fp);
> +
> +	for (nd = rb_first_cached(&session->machines.guests); nd; nd = rb_next(nd)) {
> +		pos = rb_entry(nd, struct machine, rb_node);
> +		ret += machine__fprintf(pos, fp);
> +	}
> +	return ret;
>  }
>  
>  void perf_session__dump_kmaps(struct perf_session *session)

Simple enough, applying after the further simplifications below, to make
it more compact.

Thanks!

- Arnaldo

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dcbe10d6a996970d..ae62d5c9889fe2f3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2730,12 +2730,11 @@ size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp)
 
 size_t perf_session__fprintf(struct perf_session *session, FILE *fp)
 {
-	struct rb_node *nd;
-	struct machine *pos;
 	size_t ret = machine__fprintf(&session->machines.host, fp);
 
-	for (nd = rb_first_cached(&session->machines.guests); nd; nd = rb_next(nd)) {
-		pos = rb_entry(nd, struct machine, rb_node);
+	for (struct rb_node *nd = rb_first_cached(&session->machines.guests); nd; nd = rb_next(nd)) {
+		struct machine *pos = rb_entry(nd, struct machine, rb_node);
+
 		ret += machine__fprintf(pos, fp);
 	}
 	return ret;
