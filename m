Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BDC330319;
	Fri, 14 Nov 2025 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137034; cv=none; b=j9CT0t7TGrwqekcrYso0CeNHumIXMpIRFmesYWHXFARhLoHO7z8Ca3/UnNsTzAZhrghLGHu0AaWhBMoarvFAt5uMrXudtp5KFkA5S7/lhofVXr7/8ry6HIN4LA6OTG3+U/clZMyECi1YcJVqlLly5ceQlpE8TsjsJfXZ8RMd/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137034; c=relaxed/simple;
	bh=Px3lKZdUS5rdr+F3zZSev4T8mg958AG9l4kRlO2wCqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3GZYZtepM7wQrdVwGSvK3uBo5r3MWdIMJ51YX9aeepaUE+LMD272fUPuog51qv4hP5YZKBcy0wmYKIkS8h7cjUiBzdRiYFPI9J8Xxy7qP4S/GuY1U2gd2YnTynaQEdlbjz/6A5HjZ9OOVHfjSZFKYEXG7Uw5+UnXzE2MPmko0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBPYejEz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBPYejEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343EBC4CEFB;
	Fri, 14 Nov 2025 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763137033;
	bh=Px3lKZdUS5rdr+F3zZSev4T8mg958AG9l4kRlO2wCqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBPYejEzrwCn4Zb5hqGfAGsRuk9RtKOvK6DJboD4IPKftcJOdg4oRRU5uT8NPBLE+
	 OCllQlduZ42OJyJUua2necJE+0YSdMcHbdeLObYCCvkrn/QwTZwzPnKXqb38rWi4fx
	 mw+gUSWQ6/Z3DVBAUUf3g6ei/hgWhfp7oWapApA7/2onlPDePp296sVo1FRqC2qZLi
	 VseGB5u3t8eCfXy0RDuL7FaQz+qNhJB6BR4RzMRRyHWBM8G63G1zF6mSYIYV2yixgW
	 x5bf4nJawh3kaT0tOsY4WlKO02LdPnsxSPRrLeRVJEoXJ4IYeL7vJVSz00VvRSHbOa
	 FVxXdc/8ggRbw==
Date: Fri, 14 Nov 2025 16:17:06 +0000
From: Will Deacon <will@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] tracing/wprobe: Fix to avoid inifinite watchpoint
 exception on arm64
Message-ID: <aRdWAshGkWjgXW3L@willie-the-truck>
References: <176179481538.959775.12326313742393696258.stgit@devnote2>
 <20251104223735.4164f224790ea0aea267dff1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104223735.4164f224790ea0aea267dff1@kernel.org>

On Tue, Nov 04, 2025 at 10:37:35PM +0900, Masami Hiramatsu wrote:
> Gently ping.
> 
> There is a bugfix (or strange behavior) on arm64 hw breakpoint but
> to fix it cleanly, it should change the perf itself (but I'm not
> sure why arm64 changes the behavior only for the default overflow
> handlers.) Anyone knows it?

It's because GDB expects to handle the stepping itself when using the
ptrace interface (with a custom overflow handler to deliver SIGTRAP).

Will
