Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6B2DF13A;
	Tue,  9 Dec 2025 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279389; cv=none; b=O3YvQZEsM/otEIfYbe5jyzvxGPIa26/2hEIpmWxKFoTQTsD/uM7J0o0NbLuD28+pBOpy53xFh5XRzJzRnk0o5JbTqx294ooW6qkY6SnIfiOdO8PPdWWy/v9hTVCH3VRE5WMuKQHM7Y/Alb5ZAog5wYE+YPu4C9pdvFXOTePUlAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279389; c=relaxed/simple;
	bh=B467VVAVr6UgzvRSsJ07jNyYx8Zn9TJtkJKdoOpxvN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEExv7HplR6ZaIDHxF+YJ/oi9eI91lZU8PhLQ+SCZrxFdAarJPV1040aMGX61llSvdycA8dolPrTDH1kIFp7LU+kHNL0tLuAqXI64VT1XwfGPndG06pxMl/FAjKMWVsjzJv0I4j5diZ9PULSdESVy+Ew8mHCf5WaljNk25q6NrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EolSHbj/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EolSHbj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCA8C4CEF5;
	Tue,  9 Dec 2025 11:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765279389;
	bh=B467VVAVr6UgzvRSsJ07jNyYx8Zn9TJtkJKdoOpxvN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EolSHbj/fia76DjumfbrN6L/RcpXgStIATx5vXe/xu19X0KM5C9NiOopn6glzYVNG
	 VhbIQysjkFdLtoO8f5UToTIDO3kXBNk5oTrWRZlKztn9COsA+XHCkcDR2zAeN9xtnj
	 nT2Zsx3vbbpgv7Q1TybOHS2pBinBsiul6+iZAVnD/f8fsCLee5BP4BCYwbRoWfO3uH
	 da3244AcQNIOp9QSFwJ7PiYbEocC0CzSoC3rv9G3TdUni8n/cJxbyJH7LyEIxesCZ3
	 0MM/k+52WS2t5VJwKpc4ubyEbmWmV9SEuF/47dyIrQzPA/ttYux+uwuYx59jyfNADH
	 okcIVgNCFjXtQ==
Date: Tue, 9 Dec 2025 12:23:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thaumy Cheng <thaumy.love@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] perf/core: Fix missing read event generation
 on task exit
Message-ID: <aTgGlzb3VKvNtE9Z@gmail.com>
References: <20251209041600.963586-1-thaumy.love@gmail.com>
 <20251209093843.GI3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209093843.GI3707891@noisy.programming.kicks-ass.net>

* Peter Zijlstra <peterz@infradead.org> wrote:

> >
> > -static void sync_child_event(struct perf_event *child_event);
> > +static void sync_child_event(struct perf_event *child_event,
> > +			     struct task_struct *task);
>
> This forward declaration can be entirely removed now.

Indeed - I've applied the delta patch below.

>
> Other than that, yes this seems fine. I see Ingo already picked up the
> patch, thanks!

and I've added your Acked-by as well.

Thanks,

	Ingo

================>
 kernel/events/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 47d5dc4bf700..dad0d3d2e85f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2317,9 +2317,6 @@ static void perf_group_detach(struct perf_event *event)
 	perf_event__header_size(leader);
 }
 
-static void sync_child_event(struct perf_event *child_event,
-			     struct task_struct *task);
-
 static void perf_child_detach(struct perf_event *event)
 {
 	struct perf_event *parent_event = event->parent;
