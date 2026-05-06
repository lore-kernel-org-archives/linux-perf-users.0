Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8AF33C518;
	Wed,  6 May 2026 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073736; cv=none; b=pK3CPKOGG+iobrTUqOQ+tac6YTdS7qKAClMcsxIWPyt0Vi7X6R5AlfAKOW7FvTRaro/TksdTTFKV+uGgJZdguAmH/Ux0y52EOLcbh/JBCC0AGIW3Zq3uvNrOHwhpnWj6MfNs5CfhUpES8b0/ENQazc+dEejA6/ZvR5bQTQ/wtf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073736; c=relaxed/simple;
	bh=Gosprb6NHOtSZdpo4NIBSA6G4/cGhh9857B2IH9WK+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9ZAeQWtFaHwKZqsnXqPSOZvBeLM0ekiwJ6ZeA4MuOqkqrMBf2zJB6PDkQjZpuXXb8PdK18wXLrzVbxQTFk2ZUkKCbVJ0JtTL2VkQdBHSbBvPO0aj+tnQbXfW5K24cg5ihpIWl0F+T7OVWMczVJsvyZCHIh9Tr1vel/PLvwzpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz5HjMO2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz5HjMO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B57C2BCB8;
	Wed,  6 May 2026 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778073735;
	bh=Gosprb6NHOtSZdpo4NIBSA6G4/cGhh9857B2IH9WK+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mz5HjMO2fi1oU0Lqw4/Rn0NzNnlDIB7wEug3f0dFP5doLrCa8J/YjLch30B4CLa8M
	 Q8VV+PJm9NG87E4G2j/0ecDeL244CfD/uwIqzzt+epdTYg4q9K+J5brASv+cbzhG6b
	 DjMypqBGw6ysSxkF4qOg7cSaNhYteFR1x3lfZQjuf9cmWeRacDmT6dju8wIkwenJPY
	 f3ROkyi8IHMYYbvLrvSZG4RrXkFAp14oDrNjaDJ4RuBR7enyIXx+M+VJCjabERDwXW
	 PpVn7sYo5UT7+owHcA6eMfp3BathWS10FN5De/TTN3OFxmWlwRs69rAEiapGd62vxp
	 WBf92Zt5Tzo3w==
Date: Wed, 6 May 2026 10:22:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: gmx@google.com, namhyung@kernel.org, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v5 1/5] perf sched: Add missing mmap2 handler in timehist
Message-ID: <aftAgoXnB6xuYGAt@x1>
References: <20260504072937.2103453-1-irogers@google.com>
 <20260506004546.3140141-1-irogers@google.com>
 <20260506004546.3140141-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506004546.3140141-2-irogers@google.com>

On Tue, May 05, 2026 at 05:45:42PM -0700, Ian Rogers wrote:
> perf_sched__timehist() registers event handlers for options using the
> sched->tool struct. It registers handlers for MMAP, COMM, EXIT, FORK, etc.
> but completely omits registering a handler for MMAP2 events.
> 
> Failing to register both MMAP and MMAP2 handlers causes modern systems
> (which primarily output MMAP2 records) to silently drop VMA map mappings.
> This results in uninitialized machine/thread mapping structures, making it
> impossible to resolve shared library instruction pointers (IPs) to dynamic
> symbols/DSOs during timehist callchain analysis.
> 
> Fix this by correctly registering perf_event__process_mmap2 in
> sched->tool inside perf_sched__timehist().
> 
> Assisted-by: Gemini-CLI:Google Gemini 3
> Fixes: 5bbfec0ad93c ("perf sched: Implement timehist option")

I'm picking patches 1 and 2 as they're simple and passed sashiko review,
but:

⬢ [acme@toolbx perf-tools-next2]$ git show 5bbfec0ad93c
fatal: ambiguous argument '5bbfec0ad93c': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
⬢ [acme@toolbx perf-tools-next2]$

The right one is:

Fixes: 49394a2a24c78ce0 ("perf sched timehist: Introduce timehist command")

I checked and at the time, mmap2 was already present and it missed
adding this handler.

I fixed it, in case I'm missing something, lemme know,

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-sched.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 555247568e7a..241c2f808f7b 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3299,6 +3299,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  	 */
>  	sched->tool.sample	 = perf_timehist__process_sample;
>  	sched->tool.mmap	 = perf_event__process_mmap;
> +	sched->tool.mmap2	 = perf_event__process_mmap2;
>  	sched->tool.comm	 = perf_event__process_comm;
>  	sched->tool.exit	 = perf_event__process_exit;
>  	sched->tool.fork	 = perf_event__process_fork;
> -- 
> 2.54.0.545.g6539524ca2-goog
