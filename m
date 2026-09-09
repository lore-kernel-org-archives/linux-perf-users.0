Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2D531AE2;
	Wed,  9 Sep 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953142; cv=none; b=IonXfXmwppL4W1fT47F9WFDFBJX0qTlXZfd0+OiFcaIc4L/RyUi8+qVgXOshj2QERvyt98X+4ORRxZns0uvo+4qQhudEXzle5rP5zyzq9Y653ofakbgaQ9OwL0njDETQ31mwXfJYl3xAeq+LO91S8mjZX7xnO7/joxquXtk2bws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953142; c=relaxed/simple;
	bh=FPE8l/HG4WfBjfC+vmusbmFjkSYwJzRHTqOyzlcw0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4MxPz9Z5zZ6Ra8jCsDYAtdyv1ckuRFIw80uO7cJn2uXZ/4+Gj336eSNF/R6aIJXeWzUikmjwoa5Dku0kY8x5hBncB6MU6WVsQdLpfez3DoIY+5j6SUB3Q5EfZL9It3y0IjYiZXK6FJUQEGE7zcMbAb++Vq4/5uD1dwhKLIkKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2pmpujP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2pmpujP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3541F00A3D;
	Wed,  9 Sep 2026 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953140;
	bh=jaBFxLOdO764//rf7n/dI2a5gfJn4KqcI4GxKuMCst4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g2pmpujPnuwjDykrSvMMIUGYhcpjfekCAbTxjwUg0QFbszWQNNJJCEVS16iVQu7IB
	 y77IrYUy8pqHUH4tSkDHJ613T3EgM+He64+8RUjglHPLBrAjFnZikKY6RbfNP9kV/m
	 bHwWYvLeijt0PYHAysCmRsiT6HU7t/UqMGTBzI+OK5hDn5TBZ0kTEOkmCZ3SrLg/Wv
	 6OiGp/OWWSdJnZLWPFTbxTqiWuJeuA0JnO/lx8zAZxEJ8WdV+TgxNWHmfxyGyO812P
	 F7NdaU16oTyUfSngmuh+jG4YR0elywxqKZselhgdjH+Tq16xZ72MfFStG/xMMcaBfk
	 3nIzSML7eHflA==
Date: Wed, 9 Sep 2026 08:25:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 0/3] perf tools: port UI from GTK2 to GTK4
Message-ID: <aqFCMfb94Cdumemm@x2>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
 <aqE_QOp-x1aOQsCX@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqE_QOp-x1aOQsCX@x2>

On Wed, Sep 09, 2026 at 08:13:07AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 08, 2026 at 10:50:33PM -0400, Matt Turner wrote:
> > GTK2 is long dead upstream and increasingly hard to keep building on
> > current distros. This series ports perf's GTK-based report browser to
> > GTK4 and fixes it up so it's actually loadable at runtime after the
> > port.
> > 
> > Patch 1 does the mechanical port (build system, widget API changes),
> > including the leftover-GTK2-call and signal-handling fixes that were a
> > separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
> > port that prevented the browser from loading. Patch 3 fixes two stack
> > buffer overflows in the hierarchy view that predate the port.
> 
> I'm tentatively merging this, will test build on my distro container set
> and perform some testing, thanks for working on this!

Some fuzz applying the first patch in the series:

⬢ [acme@toolbx perf-tools-next]$ patch -p1 < ./v8_20260908_mattst88_perf_tools_port_ui_from_gtk2_to_gtk4.mbx
patching file tools/build/Makefile.feature
patching file tools/build/feature/Makefile
patching file tools/build/feature/test-gtk2-infobar.c
patching file tools/build/feature/test-gtk4.c (renamed from tools/build/feature/test-gtk2.c)
patching file tools/perf/Documentation/perf-report.txt
Hunk #1 succeeded at 354 with fuzz 2 (offset 3 lines).
patching file tools/perf/Makefile
patching file tools/perf/Makefile.config
patching file tools/perf/Makefile.perf
patching file tools/perf/builtin-annotate.c
Hunk #1 succeeded at 61 (offset 9 lines).
Hunk #2 succeeded at 721 (offset 9 lines).
Hunk #3 succeeded at 840 (offset 12 lines).
Hunk #4 succeeded at 910 (offset 12 lines).
patching file tools/perf/builtin-report.c
Hunk #1 succeeded at 83 (offset 1 line).
Hunk #2 succeeded at 1360 (offset 1 line).
Hunk #3 succeeded at 1714 (offset 4 lines).
patching file tools/perf/scripts/install-build-deps.sh
patching file tools/perf/tests/make
patching file tools/perf/ui/gtk/annotate.c
patching file tools/perf/ui/gtk/browser.c
patching file tools/perf/ui/gtk/gtk.h
patching file tools/perf/ui/gtk/hists.c
patching file tools/perf/ui/gtk/progress.c
patching file tools/perf/ui/gtk/setup.c
patching file tools/perf/ui/gtk/util.c
patching file tools/perf/ui/setup.c
⬢ [acme@toolbx perf-tools-next]$

I fixed it up quickly, now lets see the rest...

- Arnaldo
