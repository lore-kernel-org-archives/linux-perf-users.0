Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056712C544;
	Wed,  1 Oct 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325676; cv=none; b=e7b9Bbfe/mr+92uRAKvAJul6n5XpNG4sL50zOFcHhYdjnjZ4swtY84me3N7W1cLbQX7iyapSXljpdNvUcALu+G8KxR/3dwPBh/XC5ZiLmhaEePPfA4PBT9QP1b210mZf3DXTZWTEJSr0r1nNGD4E/ZpKCi52rvHic+U5BCArn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325676; c=relaxed/simple;
	bh=ZE4N66J3ktY8IRfvtbMhGxcc6MKDZ6AJh2VWt6887no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs2MY5GoTU5W9nCd0aG3HZy+Yy0aXX3W5zBvKB47xnGtR5+eaNc6ZrkhrO6jsUn7C25LMzdRLG2Su0PpzcIcTE44203LShEM0mnq1UY9oodW41RpBjwFj5kyBdSg/0VEJy9wzj0tfkUJ1YXm5yW2DQDEyZ3podMVTc2j35uJKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htDhPPR8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htDhPPR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80094C4CEF4;
	Wed,  1 Oct 2025 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759325676;
	bh=ZE4N66J3ktY8IRfvtbMhGxcc6MKDZ6AJh2VWt6887no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htDhPPR82n+Azi7xVfwV9rx1ZLKXr1DAbbOstPZbz5WID7FmNghgZI18zRXPN1QhS
	 ZpzqVLoOUQ/gGfCQZ2Sf/taK7lVlMJyY6fzgdNKdtLRpWScoo9UFu0ONM8h/bhJU2A
	 s8iNwkY+g9cbtXZ83gEaeCYSDAtTqT8DaD6B2IeOSOeq1OdYYq3n3uwNioWt4tLBY7
	 mLx7GxeqbiFKj/DT6GrVq5xgbIZbX2PSHP4zE9DcOJoaLO3EZxnRuHhs3vFdfaUs75
	 gsEoAYOWwL+1xRq7+nNiXwiWqnXM4U4uSTSGjuvJMGjn7ezehq/jHuMSPTay9J8+iT
	 0J+AOl99jAE8A==
Date: Wed, 1 Oct 2025 10:34:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 0/2] LIBBPF_DYNAMIC=1 fixes
Message-ID: <aN0t6Bcd8MKmeBn7@x1>
References: <20250919210654.317656-1-acme@kernel.org>
 <aM3SCGOXZsP3GZal@google.com>
 <CAP-5=fX6=7Ycp=Su2ahZS1R0wS9s4eozPPcBgMBG25UCaC6uBA@mail.gmail.com>
 <CAP-5=fW6tPRW2qdFE4AbXg+47CzTjDX5HEjenjTxgOZ35fFa8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW6tPRW2qdFE4AbXg+47CzTjDX5HEjenjTxgOZ35fFa8A@mail.gmail.com>

On Tue, Sep 30, 2025 at 01:10:59PM -0700, Ian Rogers wrote:
> On Fri, Sep 19, 2025 at 3:10 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, Sep 19, 2025 at 2:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Fri, Sep 19, 2025 at 06:06:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Hi,
> > > >
> > > >       Please take a look, noticed after processing a patch from Ian
> > > > for another such issue, on a hurry now, haven't checked when that
> > > > emit_string was introduced.
> >
> > emit_strings was added in Linux v6.17 and libbpf was tagged as version
> > 1.7 prior to that.
> >
> > Thanks,
> > Ian
> 
> Ping.
> 
> When this lands I can rebase:
> https://lore.kernel.org/lkml/20250830053549.1966520-1-irogers@google.com/
> on it.

I'm testing this now.

- Arnaldo
 
> Thanks,
> Ian
> 
> > > >
> > > > - Arnaldo
> > > >
> > > > Arnaldo Carvalho de Melo (2):
> > > >   perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
> > > >   perf bpf: Check libbpf version to use
> > > >     btf_dump_type_data_opts.emit_strings
> > >
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > >  tools/perf/util/bpf-event.c  | 2 ++
> > > >  tools/perf/util/bpf-filter.c | 5 +----
> > > >  tools/perf/util/bpf-utils.h  | 5 +++++
> > > >  3 files changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > --
> > > > 2.51.0
> > > >
