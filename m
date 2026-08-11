Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE376390601;
	Tue, 11 Aug 2026 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461200; cv=none; b=ohNPYUrdGw9EnIouhxhjJz0gg6oodX1VIRQBV4G2T18goPGrPlaXF37D7jL5Axay71vZ9+gY5gTNwBelixFmNxabMo1gyxeoMNXbo6aEuNw6MejoRpZzIg2Vi8AYOouw8AtosKIwWRhFPNgvbWsVOqO60sCC30JjQZorBrSrZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461200; c=relaxed/simple;
	bh=CK6+CKxwpFoYQ02Kii8umv29Yu1APWcZ8fBbuWbVlfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLjJjtHK9AWbyFPSAyAo9cKf0UHrS8JleLQKreoKTcyUHc7YPL8RYMhtw7wlCW71fGGZtQpcW/oR6JMkz5FfBDOQFbrqbKkTC/wmmAkZN/kk02kJlKzszNLwxAN/55uVxd82ougqLoQuqLag0W/sWfCOVob6WtXqMDvNhixAgkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt5cCc7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt5cCc7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD791F000E9;
	Tue, 11 Aug 2026 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786461199;
	bh=+seHgNE8h3LqiHS83vd6AXsJKXhEWe9/30/GNfYIKWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vt5cCc7TqKI+4dpyy952mPzzw/enwCUAsA6BTlppa5oFeCNKUkLw8idDP5tADvYe0
	 ACh/GaRxoIWt83GIvQb5jBgXCn26H/Z+Dc4ZR808hh2SFITmWygGJf0rIoV6y0R4JR
	 hHahREP1x7VkkhkYpIFU95ceDDWv8IypLzlVR3Xqbom8mmHgqC0XYK53I35s81GFqm
	 Ks06DLCnzZ5u8qAOwBa7ByVz1cf+BD+dAIEWTc3KH1H5m61Z5Cl3WVW/CgKquUiYoy
	 wPzjL7mcMYXBYkXfHEn0UTRVvlvJAGGtPwjFHeFj1m/dvQxwgv+1fXqIE2QIb5aIU1
	 cowrqSw0Z6Qcg==
Date: Tue, 11 Aug 2026 12:13:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 6/7] perf build: Remove leftover feature tests for
 removed cxx and clang support
Message-ID: <ans8DNaxA-p57gI-@x1>
References: <20260810005127.289896-1-acme@kernel.org>
 <20260810005127.289896-7-acme@kernel.org>
 <CAP-5=fUFyq4Xme36ScLjqa+0kJbLAdrwzxvU-SprzFeu14Gggg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUFyq4Xme36ScLjqa+0kJbLAdrwzxvU-SprzFeu14Gggg@mail.gmail.com>

On Sun, Aug 09, 2026 at 11:03:36PM -0700, Ian Rogers wrote:
> On Sun, Aug 9, 2026 at 5:52 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for
> > compiling BPF events (-e foo.c)") removed the test-cxx.cpp and
> > test-clang.cpp sources, but left behind their entries in the feature
> > test FILES list, the build rules and the cxx and clang entries in
> > FEATURE_TESTS_EXTRA.

> > Since the sources no longer exist, those rules would always fail,
> > making the artificial feature-cxx and feature-clang results to be
> > perpetually disabled/absent, remove the leftover entries, making the
> > feature test scripts list match the available sources.

> > Assisted-by: opencode:deepseek-v4-flash-free
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> Looks good, perhaps a Fixes tag given the commit above?

Done in v7, about to submit v8 with the explanations for the $CC checks.

- Arnaldo
