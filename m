Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10114A0131;
	Fri, 25 Sep 2026 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341832; cv=none; b=U6jJh9SndgpdvuDKcl7LeN/6JsF4+xx/8kX+HNJlhZaqlbYZhKY7Haj+ZnYN1LkPfM6EoG8UK1vkXlXyPfmm/w7thFQukRg0Zwtf2a7He4BvjOA0OFzyjlJgPL/wisbhq8YaVUjscye6dGBV7CmNirfpA7j9j/9JVvoS8RBsQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341832; c=relaxed/simple;
	bh=QYQ1aEoRgf3fuGNUoQar6iHm4qSgJXlU7tdvQpDQiDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnRSkjmay7jY9lbg29rI7ffySmhLttU0sq/XF547tMZf3rPBRfLM/xByRnkSXQYMBE5E2IfPPAf9hOld4jAndKTkS+tcoHdIQeA+45Yaza3/1r2EXYgyjXpN9xWaCj5n21ae4Asw9IQdHkolNuaDPoZUte28Zl1J1RpjLhJZJM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONEPlcg7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONEPlcg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A4C1F000FF;
	Fri, 25 Sep 2026 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341830;
	bh=cPa597NShYE/T3uZcC6cK3626lAodvtRaLC8LWlQUN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ONEPlcg7ooQxDwESCDW6fBCJrq0t01wgdUKGVTaMUaP2X7YhfGienlU1l8f6quPBr
	 bEwAU44SDVHk42u4mwHe1nSUH5z6owDHNQlvz5iFsldRUNhbUzLHc6XutnL6SPKCGY
	 P+rITdNZ79OrDAT4FnKxViWjZzn+IZg/8zFzjLBbUqCTppoLyFCOwFljw9n/IoXtrQ
	 uJMysPC+GZaUn8ece59iLb6Li7I9/O1JEP03NzM5Ph5pdEqqPNzZgtjRc79AqLauuT
	 EEhDKBbuznWu6oGz/RtLm2e+9aK03da7B7fRuU29ym9xJ8nwtTHffDuepsVLTLdRTA
	 vDXCQszEk9l6A==
Date: Fri, 25 Sep 2026 15:10:27 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] perf: fix repeated word in log message
Message-ID: <arZyw5HCRm5EzF3L@x2>
References: <20260907065843.34410-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907065843.34410-1-hemanth.selam@gmail.com>

On Mon, Sep 07, 2026 at 12:28:43PM +0530, Hemanth Selam wrote:
> Drop the word written twice, reported by checkpatch.pl as a possible
> repeated word.
> 
> Only the message text changes, no code changes.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  tools/perf/util/synthetic-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 0c150193cca8..b9e5a5da5f6e 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2266,7 +2266,7 @@ int perf_event__synthesize_extra_attr(const struct perf_tool *tool, struct evlis
>  		if (has_scale(evsel)) {
>  			err = perf_event__synthesize_event_update_scale(tool, evsel, process);
>  			if (err < 0) {
> -				pr_err("Couldn't synthesize evsel evsel.\n");
> +				pr_err("Couldn't synthesize evsel.\n");
>  				return err;
>  			}
>  		}
