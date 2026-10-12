Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD212D5C7A;
	Mon, 12 Oct 2026 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848252; cv=none; b=ixzf2AHhi0fR3gRKBwx9pvEP6m+kuWOH6/IQDGBUopBMb7FV/xN6qlgGkSXUDTugO3MMzz5u1JclgjGYyzKFO4htbTxzNiRhKB+f8GsPx7wTT8U7T9u9ddmTKtlyNUofCdTbfPiwco0IlCMUX68LSsJyxL6STB2Qf/i3lFqdBWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848252; c=relaxed/simple;
	bh=mjam7B7KG3Lo8EfgIDo6DxqAJwrrKKLmN/D8NHa3vKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXHlT5iSev2rDcbmlsOOg18lBN5CDTcnHrmiSvCDAW74EiDZXwtHzHFhiAwJrtURjaYcIr5+O4tha3FUPno0KB2aGMy6BKPC+wPEz39StLPXnx3CP9JcWwdpQlIfdkSDA4LlN2IBNYtpKGIYPezg11l/HDlazBuUlHM/RHpAvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyTesx6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyTesx6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1651F1F0089B;
	Mon, 12 Oct 2026 23:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848251;
	bh=uaF0AHGeju78t1dzRA2spJP4IMG/G6YYDFVPJLlkQeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MyTesx6yPP/+ttXSTtyOb8YzzrLXo20CD4oxy+WmWDA7/e/GqvqBnKuoe+QGuPd+m
	 088f33mA99kiTfINeh/+tt6C7z8t6VE3NkobP+a8ZuI4HIIP8o4cqMn0A5fJ0xkTVp
	 qHq2Y5UICyGULSRXu58qj0l3cRY/FvcC2NeB3plU2tAd+wzKQ/nC/e3+4incwBNZMW
	 Wd5RZLI0Y8JQ4fWnQ/6w2B5lSwAsCYuuq0G3JdKouHydunYP+yuaxrxmGdUrflymzD
	 J2Qny1cCezM5uWJo5f4N1T10TUumUcg36nBf3d/XtFkKiQCjRfimefNRP13Km0l/gl
	 ZjEuZ5e8MSwew==
Date: Mon, 12 Oct 2026 16:37:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 4/4] perf test: Update PE file test for other locations
Message-ID: <as1vOLA3Ew_0N0V5@google.com>
References: <20261012053013.14378-1-namhyung@kernel.org>
 <20261012053013.14378-4-namhyung@kernel.org>
 <CAP-5=fW1SSoyGKjaujZewF=b3rJ-0vp4kJ-friWNzOQWk+ki5A@mail.gmail.com>
 <as1n8CgDZxYlQkSK@google.com>
 <CAP-5=fXeufoS36+660zMnWksONa8UzbUo_MXyVzDtSDXVnWbfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXeufoS36+660zMnWksONa8UzbUo_MXyVzDtSDXVnWbfw@mail.gmail.com>

On Mon, Oct 12, 2026 at 04:11:27PM -0700, Ian Rogers wrote:
> On Mon, Oct 12, 2026 at 4:06 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Oct 12, 2026 at 02:51:52PM -0700, Ian Rogers wrote:
> > > On Sun, Oct 11, 2026 at 10:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > The test__pe_file_parsing() expects the test is in the tools/perf
> > > > directory, but it could be root or a separate build directory.  Let's
> > > > update the logic to try other paths like in the shell_tests__dir_fd().
> > > >
> > > > Also add some debug messages to inform users why it's skipped.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/tests/pe-file-parsing.c | 13 +++++++++++--
> > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
> > > > index 3979f38bf127c218..78dae7e43603b9f8 100644
> > > > --- a/tools/perf/tests/pe-file-parsing.c
> > > > +++ b/tools/perf/tests/pe-file-parsing.c
> > > > @@ -74,10 +74,17 @@ static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
> > > >  {
> > > >         struct stat st;
> > > >         char path_dir[PATH_MAX];
> > > > +       static const char * const tests_dirs[] = {
> > > > +               "./tools/perf/tests",
> > > > +               "./tests",
> > > > +               "./source/tests"
> > >
> > > I'm not sure where "source/tests" comes from?
> >
> > AFAIK it's set when you pass O=$(DIR) option when you build perf and it
> > points the source tree.
> 
> Ah, Andi's change:
> https://lore.kernel.org/r/20240807231823.898979-1-ak@linux.intel.com
> 
> > > nit: could we add the exec_path case to the list?
> >
> > It's checked right after. :)
> 
> Right, I think you can avoid the duplicated logic by having tests_dir
> also have path_dir as the last entry. It'd mean always doing the
> snprintf but performance doesn't matter much in a test.

Ah ok, will do!

Thanks,
Namhyung

