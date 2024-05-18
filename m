Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB144A2D;
	Sat, 18 May 2024 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716023745; cv=none; b=PlmvWJ7UHkjjbkm1WePRPEmDOUHb1owRybF4l2A2JLgFV4PFsFrYDs4fKNAbOZRmNm1RLIl2yHbO9alVejhKNC9y0zfaBnCO0fz9DAYa46ESuOxyche2H+Kv8Arz9Zr9D5GzCi4TTnpkKfhy8YFycTX0FblcPG9DA5D/8E1skhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716023745; c=relaxed/simple;
	bh=qmyHIIKcPVB794MM9BsicZz6ygBU5n10mGxUG2Nh+sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MR5qHLiGY9etdTB7iEwZi0r6LYYN7xToN+S4Wbu3H+je56uEmObOBk8z6QyUxVclwONqHij8HccZzwC6pN2Zl62x6MpkRA8Einj6dVbiOydhvDZcRcmDXZkydF6xl8hQhAHVrwQXoJJa4aLnIPuqvMkSw1ouJR4ajjskDOT7/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D97c34ws; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D97c34ws"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59e4136010so588699366b.3;
        Sat, 18 May 2024 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716023742; x=1716628542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIcX/mNWbGbXqi1DrcVgyMGxih1ay8vwVcGDjl7azI8=;
        b=D97c34wsffoVBzmRtjDV2RqxJ/AflERloo2hQPGncW2zycsCOvAwigJPl0CV6/qAwH
         leqNS/IEML3ljip9CaGYfnorTRzNPcl9xwWRaSQ7XlzAUdv0b4E3o75y1dlphCWaTqdd
         7tanAD73pWFM6Wqd4fjc9X5hs0qCoN+K1lWof+FdVxfKprDYS2dSI4fcP+7gDQ0J5vzH
         lN4Do264Qp7+THgUWN5i/LAM0TQbS5ELFU+o95QSSlrNhoWZUoRJfpQO8F7Lxc/ErrIA
         CQ6RaVh3wHHt0dVrJIEhoP9Nnmtm3n4ISZl6lVmkHP0IiAuFohR4+q5h0A1ekwuM6uZ7
         pQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716023742; x=1716628542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIcX/mNWbGbXqi1DrcVgyMGxih1ay8vwVcGDjl7azI8=;
        b=AVk8sXCoVR2ivF16mvJgGAT1ECcJAePdcs5yhhMkLcXUHrXt4lsptlh0bmbU/GQhM1
         lFK8KDfm4PRmIq4E7cnWoilk6gxQw08kpG81XDNbOy+Xj3L91EgsymsmQfSyFofIMxzC
         VI8PoOgg15zIC8sDCB0b4FCivrB1kvDNVxuv/2SW4gvRSyY6VifF37EIWxi8z3+N91nz
         pGVWZ/cYa1/rAnKj3LCkgxOgcvwMDeJbZhbYODUrw0jxHvdzJvB4S6m9tq6lPgTJJYuo
         oLclBDOzwVF9DDqMzw0kzXOv1bsVlEtt0AgjWnVYzjz4Rc0s8rDwvPVaLDC6Mv+68WWx
         49Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXUY8RYuCWq/S5lXNjkOIvJJy1r5TMk8nEu/sl9XE4tl/qEGnN4J/ZLt9C3oIZxyb7KWS67xyEJBj4wD4MkrK9UfE0rJnqEl043tIKS/zZv60SCHsBzTIV1wxog75K8GVN8Qj2fLd4z3kc41Amgvw==
X-Gm-Message-State: AOJu0Yy+vfxm84Ls05OzR2x49qhLTPCYKC52RlP6ZhFyCG0LMDS5YFWz
	ejxV7sN257z3h3yg+K9ps0GeBt3VZ5cwefv/oZeVQBINTLH4GrTp
X-Google-Smtp-Source: AGHT+IH2qJvBbJ6wUL4UhTv0nNvel2Mx0MyqzvvEBVnb0y3+J7k2Q2D65xKrV+7GS9pibaaaA85Rcw==
X-Received: by 2002:a17:907:25c5:b0:a5a:6367:717e with SMTP id a640c23a62f3a-a5a6367bc70mr1470315266b.17.1716023741430;
        Sat, 18 May 2024 02:15:41 -0700 (PDT)
Received: from gmail.com (1F2EF1AE.unconfigured.pool.telekom.hu. [31.46.241.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1789247csm1199183466b.82.2024.05.18.02.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 02:15:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 18 May 2024 11:15:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] perf/x86/amd: Use try_cmpxchg() in events/amd/{un,}core.c
Message-ID: <Zkhxuo1yWUUcK11d@gmail.com>
References: <20240425101708.5025-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425101708.5025-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Replace this pattern in events/amd/{un,}core.c:
> 
>     cmpxchg(*ptr, old, new) == old
> 
> ... with the simpler and faster:
> 
>     try_cmpxchg(*ptr, &old, new)
> 
> The x86 CMPXCHG instruction returns success in the ZF flag, so this change
> saves a compare after the CMPXCHG.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/events/amd/core.c   | 3 ++-
>  arch/x86/events/amd/uncore.c | 6 ++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 1fc4ce44e743..c1b8aeff7bc0 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -433,7 +433,8 @@ static void __amd_put_nb_event_constraints(struct cpu_hw_events *cpuc,
>  	 * when we come here
>  	 */
>  	for (i = 0; i < x86_pmu.num_counters; i++) {
> -		if (cmpxchg(nb->owners + i, event, NULL) == event)
> +		struct perf_event *tmp = event;
> +		if (try_cmpxchg(nb->owners + i, &tmp, NULL))
>  			break;
>  	}
>  }
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 4ccb8fa483e6..cac7c20d1aee 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -162,7 +162,8 @@ static int amd_uncore_add(struct perf_event *event, int flags)
>  	/* if not, take the first available counter */
>  	hwc->idx = -1;
>  	for (i = 0; i < pmu->num_counters; i++) {
> -		if (cmpxchg(&ctx->events[i], NULL, event) == NULL) {
> +		struct perf_event *tmp = NULL;
> +		if (try_cmpxchg(&ctx->events[i], &tmp, event)) {
>  			hwc->idx = i;
>  			break;
>  		}
> @@ -196,7 +197,8 @@ static void amd_uncore_del(struct perf_event *event, int flags)
>  	event->pmu->stop(event, PERF_EF_UPDATE);
>  
>  	for (i = 0; i < pmu->num_counters; i++) {
> -		if (cmpxchg(&ctx->events[i], event, NULL) == event)
> +		struct perf_event *tmp = event;
> +		if (try_cmpxchg(&ctx->events[i], &tmp, NULL))
>  			break;
>  	}

Note that's a newline missing between local variable declaration block and 
the first statement after that. I've added all 3 to this patch (see below), 
but please keep an eye on this in future patches.

Thanks,

	Ingo

================>
 arch/x86/events/amd/core.c   | 1 +
 arch/x86/events/amd/uncore.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c1b8aeff7bc0..18bfe3451f3a 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -434,6 +434,7 @@ static void __amd_put_nb_event_constraints(struct cpu_hw_events *cpuc,
 	 */
 	for (i = 0; i < x86_pmu.num_counters; i++) {
 		struct perf_event *tmp = event;
+
 		if (try_cmpxchg(nb->owners + i, &tmp, NULL))
 			break;
 	}
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index cac7c20d1aee..0fafe233bba4 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -163,6 +163,7 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	hwc->idx = -1;
 	for (i = 0; i < pmu->num_counters; i++) {
 		struct perf_event *tmp = NULL;
+
 		if (try_cmpxchg(&ctx->events[i], &tmp, event)) {
 			hwc->idx = i;
 			break;
@@ -198,6 +199,7 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 
 	for (i = 0; i < pmu->num_counters; i++) {
 		struct perf_event *tmp = event;
+
 		if (try_cmpxchg(&ctx->events[i], &tmp, NULL))
 			break;
 	}
