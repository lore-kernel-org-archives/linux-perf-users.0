Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7591F12F4;
	Wed, 17 Sep 2025 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071189; cv=none; b=obGrs1p6WxQ0OVl+DO/vCuavPmqxmk7+aOGRUGedKR8glDf7hhKTGytbdgpXZfhiIjPsEIm3uR0EhhFi0rVyYKJDDCpwNV7SDXfiv2wGGUW23x5gfYwBKrCzonLVjcc/gqR6RE+RPzbfyxMyJlPpCvTUez7p8b6wtm1vYUr91DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071189; c=relaxed/simple;
	bh=4crGF2aGY4utlqr2/67CjRQgwFCbHiWJJ5SEj8nk+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIqBTzIshPu3YWC1Yujedf/HhRTRjpRSczFSCMRFjmK5rL0Fl5M7ZOIG3cirkuFUK2n70RPaVG5uO+QV9h3AAhTDKqA4h6FrixtUi/ENnEHVWTFNaoqIP8j+BisBq0dW3CBx0ZAJgSneFfA9cNEcBEv23RmOThnd///u7y+Jitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6O8J5uR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6O8J5uR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A692DC4CEEB;
	Wed, 17 Sep 2025 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758071188;
	bh=4crGF2aGY4utlqr2/67CjRQgwFCbHiWJJ5SEj8nk+YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6O8J5uRDNHIW8S92YNdO7KRhzN15wAtHZ/9xQ+Kx2/CjpXPwN3qFkLi/KPSrDHD+
	 tRdyCbM2yAuaZMdlR0J6TnROM2o50EKq9jLGcQ1AjiBapyhlyA0TNQg5sFjHnutnJE
	 82a3e6Hv6R+3+TOh/B3XFqVaSkIj7BmpVIq1F6lcbz3enJ7ip6OuYB06bLUwySyhDl
	 /ehHwa8NE8R/CnyKjrc0tLjqbJXFEEhZP2L95ynt+FUW4pP1js3AP6ztjIyQFTC6Cw
	 YtOcAOsF9OGbVd6N+QIPj/0VRG9aQJsKO6mLj2fmqghFZBCLAGNmlLzxeyb4wZC0E2
	 ekMMuRrltv6cg==
Date: Tue, 16 Sep 2025 22:06:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/4] perf test: Don't leak workload gopipe in
 PERF_RECORD_*
Message-ID: <aMoJkR_jtzrGCLKI@x1>
References: <20250821221834.1312002-1-irogers@google.com>
 <20250821221834.1312002-3-irogers@google.com>
 <aMm0qUcdeDJmwuyI@x1>
 <CAP-5=fU8NXY+mbnkmhq15yncXx0TxE7Zc1zu23o+d+3ZyXjSjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU8NXY+mbnkmhq15yncXx0TxE7Zc1zu23o+d+3ZyXjSjA@mail.gmail.com>

On Tue, Sep 16, 2025 at 12:08:58PM -0700, Ian Rogers wrote:
> On Tue, Sep 16, 2025 at 12:04 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Thu, Aug 21, 2025 at 03:18:32PM -0700, Ian Rogers wrote:
> > > The test starts a workload and then opens events. If the events fail
> > > to open, for example because of perf_event_paranoid, the gopipe of the
> > > workload is leaked and the file descriptor leak check fails when the
> > > test exits. To avoid this cancel the workload when opening the events
> > > fails.

> > > Before:
> > > ```
> > > $ perf test -vv 7
> > >   7: PERF_RECORD_* events & perf_sample fields:
> > > --- start ---

> > ⬢ [acme@toolbx perf-tools-next]$ patch -p1 < b
> > patching file tools/perf/tests/perf-record.c
> > Hunk #1 succeeded at 130 (offset 15 lines).
> > Hunk #2 succeeded at 142 with fuzz 1 (offset 15 lines).
> > Hunk #3 succeeded at 154 (offset 15 lines).
> > Hunk #4 succeeded at 167 (offset 15 lines).
> > ⬢ [acme@toolbx perf-tools-next]$
> > ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -5 tools/perf/tests/perf-record.c
> > 576bd7a8c90c48e9 (x1/perf-tools-next, x1/HEAD, five/perf-tools-next, five/HEAD) perf tests record: Update testcase to fix usage of affinity for machines with #CPUs > 1K
> > b4c658d4d63d6149 perf target: Remove uid from target
> > dc6d2bc2d893a878 perf sample: Make user_regs and intr_regs optional
> > fd8d5a3b076c033f perf tests: Add missing event.h include
> > 9823147da6c893d9 perf tools: Move 'struct perf_sample' to a separate header file to disentangle headers
> > ⬢ [acme@toolbx perf-tools-next]$

> > Can you please check that it is still ok?

> > I processed the first in the series and now I'm going thru the other
> > two.
 
> Thanks Arnaldo! I'm not seeing the patch on:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next

Sorry, I thought I had pushed it earlier, should be there now.

> I'm happy to check.

Thanks!

- Arnaldo
