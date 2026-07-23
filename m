Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF33A4523;
	Thu, 23 Jul 2026 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784735; cv=none; b=N+2Pwp2gSWJ3+3sNjW5FKeJASS8ql/qz0I9/naZ/hzj6je/iboyNtfg4wIxv+qKUJEWJn2NZ05CljaIhyRsxzTRCpvAeL6DwFM6JA2URxibEDqePlXsbm4LTWNxhL42PPscXNPVtuptcKPnorz+PFJBzzSswwUCCJb++7dmZ9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784735; c=relaxed/simple;
	bh=G9PDI+ZbmPt6gGJfs59ianlbHCDNkJy3O5/VUBWU+n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzZVGJiLQqufA/tDbZXWuwlMXN1LrlSvP+F74wcUCKEHd2aMhlrFQtq9baXjzYFOfScxIMAwMGrNqdz3vkgY8zIwxBVcVxMz/A2/hR47CkA8AHV1MS1ELnh6vuyNikyawUGh6ou8n6teBtM0sS5KN0/6IFxJ+pUWMwg/HL4HBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1CC1F000E9;
	Thu, 23 Jul 2026 05:32:14 +0000 (UTC)
Date: Wed, 22 Jul 2026 22:32:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf python: Clean up and restructure setup.py
Message-ID: <amGnWXQgP9Hu5xUT@google.com>
References: <20260521175535.1531810-1-irogers@google.com>
 <CAP-5=fWD+zy8NKWyUieF-Kk4q5yEjr+qYVbU-vhT85McLeaxUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWD+zy8NKWyUieF-Kk4q5yEjr+qYVbU-vhT85McLeaxUg@mail.gmail.com>

On Wed, Jul 22, 2026 at 09:51:34AM -0700, Ian Rogers wrote:
> On Thu, May 21, 2026 at 10:55 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Clean up and restructure the python setup script to resolve pylint
> > warnings, improve code quality, and increase robustness and
> > readability, targeting Python 3.9+ (the Linux kernel build minimum
> > Python version).
> >
> > Changes:
> > - Restructure the script to use a `main()` function as the entry point,
> >   leaving only imports, classes, and pure functions at module level.
> > - Eliminate all global/module-level variables, making them local to
> >   `main()` or the respective classes/functions.
> > - Make `clang_has_option` a pure function by passing all necessary
> >   parameters explicitly.
> > - Extract clang compiler flag filtering into a new
> >   `filter_clang_options` helper function. This function uses a loop
> >   over a tuple of options, replacing ~30 lines of repetitive blocks
> >   and reducing branch/statement complexity in the main flow.
> > - Cleanly define attributes in `__init__` for `BuildExt` and `InstallLib`
> >   and read environment variables dynamically within the methods, removing
> >   their dependency on global variables.
> > - Replace legacy Popen with subprocess.run for safer process handling.
> > - Use list-based flag filtering (split, filter, re-join) instead of regex
> >   `re.sub` substitutions on space-separated compiler flag strings. This
> >   avoids boundary bugs and safely handles flags with arguments (e.g.
> >   `-fcf-protection=full`).
> > - Safely parse `CC` env var using `shlex.split` to handle quotes and pass
> >   compiler arguments as `list[str]` lists to helper functions, avoiding
> >   redundant string formatting and parsing.
> > - Remove unused `import re`.
> > - Rename setuptools command subclasses to PascalCase (BuildExt, InstallLib).
> > - Add type annotations to functions and methods.
> > - Add missing docstrings for module, functions, and classes.
> > - Split long lines to adhere to standard limits.
> >
> > Assisted-by: Antigravity:gemini-3.5-flash
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Sorry for the delay.  Can you please resend the series?

Thanks,
Namhyung

