Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668C3822A0;
	Fri, 13 Mar 2026 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436643; cv=none; b=B/1f/vU0CAqyUs9XYAXypMyrDgqjZF90U9UY9Jrt1yJXYrdPZzitmKoYfEFcnFUjD2k3f4Z9s8xZGm+tATAQ7QSXZuvjds1CxiX8XT87wq7ygq63y8NzXfyAlmRt5Iv2smrJHjV9sveLGF5bsRus+9oPslhibpF/gJKE9ptFEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436643; c=relaxed/simple;
	bh=myel91aE8wQs1det+Z6kH8GZ8AHOc1SqZetl9raqle4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJThHaZgPKqXOMqsAzHEdDyemKBHt4+fcuy4yyatyY51plDY0R9scZGhu7duhoqszEfvbf//HEFdEAXmesF0/sVL2SJcKBxnAq7ovqj3jb6bNZyHon3hgnBifG7+y2SGog16dw/1wnRjTEFIJoFLTozmVagnlD9EihtpzMO70as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIBUics/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIBUics/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5101C19421;
	Fri, 13 Mar 2026 21:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773436643;
	bh=myel91aE8wQs1det+Z6kH8GZ8AHOc1SqZetl9raqle4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIBUics/X+9NcGHEF4KwWAo4oPdMnhsLssS5FzDYauWU1X1YT3jWDWViommnyL9F4
	 eZ9kLO9xZQ1bGDOs/23yJMl/H+KZ8kn1WNmXKgAGE9Ol3hUjIVhIbrt3JhrpWTL7sm
	 PFxIbQraVme01U06mtVV8TcilvUSP5WLwD7UAgnTQTrZ3Tk82r3g1Y9qmrHz0TD1Fe
	 bgpAYFqWYV2TmfqTmVZXxE+ejiU4Xs682uBUZ37+cQSHYVT4xv4/GR9IGo/o1VntXi
	 7eoPqB7xSHFCaePviJQCRKuiYrUDMdUOZPtUaTqawVy4GS/PskpseCEapUu2NCHCja
	 hcKvHsPTCbaDg==
Date: Fri, 13 Mar 2026 14:17:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v1] perf build: Revert "enable -fno-strict-aliasing"
Message-ID: <abR-4crLwfNW2R7N@google.com>
References: <20250904174430.1414548-1-irogers@google.com>
 <20250904204117.GC4067720@noisy.programming.kicks-ass.net>
 <20250904205924.GO4068168@noisy.programming.kicks-ass.net>
 <CAP-5=fXneV5fawTncLH13p_8-9OAxwpTERXk5ty=8m0s8U1ANg@mail.gmail.com>
 <CAP-5=fUod99LkN6mX0iNizracGaHCtuDZQzU8iE7Ua61Vkb9bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUod99LkN6mX0iNizracGaHCtuDZQzU8iE7Ua61Vkb9bw@mail.gmail.com>

On Thu, Mar 12, 2026 at 01:58:31PM -0700, Ian Rogers wrote:
> On Thu, Sep 4, 2025 at 2:33 PM Ian Rogers <irogers@google.com> wrote:
> > Anyway, the intent with adding -fno-strict-aliasing was that it was
> > temporary as part of removing the libcrypto dependency and when the
> > unaligned code landed we'd do this revert.

I don't remember what's going on here but as it's not there originally,
I think we can revert to the change for now.

But it doesn't apply, care to rebase?

Thanks,
Namhyung

