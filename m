Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0873A1684;
	Thu, 16 Jul 2026 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226231; cv=none; b=aBhN4RNBnX5ogyF9lET7TpEQPW1huqhvbxuV5eHKW+DUybXaVWlotrA1J2yMlESIhTrPs/fO2TO0A+Z6JxeYcG8TanNsLKovlQBR39wOt3n9ZbZ+bKDuYtF/tZFYnWwcxXDJNdIJp6lna9wF5qKXXK0EVhlDkckxz3v5m3Z1hNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226231; c=relaxed/simple;
	bh=j9RIaWusXbRWNI/hJakKC/QYlEWKLv3vXRTrgK4Qq+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s36j955eBfPEZD3UwBPPP+26jwHXjGn4gKhzRIq5CbU7CIABfs/8tbOzbSwfQZCXMk7CpDCvRvFi+zI5mZMOdl/zlC1+oQmwThhWcHLrumZ+nOfN1kPlCQI/z/LI9z/7+qXGEAfVnqIfIqsl8aHGyFKiNqB55SMVTEesJgf62Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE8D4IRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE8D4IRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED421F000E9;
	Thu, 16 Jul 2026 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226221;
	bh=BOdaHHSBDsbwxjJ8ErNLUZHz42KesEBc8WxD+Cc8MJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OE8D4IRncgTrz2/kzpYkt4K4dsJKucHuQCGeUm9043tk6wube2W7lhYZz5BP1CXoH
	 qg3IosOh7jD9G1mPKpKyfS3im2lBeBxkzX7PSYkGgH/QqLsl5N/KlIn8BlI1Zazoyx
	 eCfxZ1MPy/kYWZcWjkVMMcC0dGnzV3PTbsvbBxMOVFVxe+WKmJ0kS8GHRwhmrWHMfF
	 G3uj6eLK83xk1gjqQreI33UGHhW+K20SgCDI5NIcwpX2Umry5HCE6mTrJ0883WUea/
	 E51m2rV519l9ljbX+eXJfWkUlO7yDUSXq/zHrWM38sa8Qjzy70bz2d1Jtn7UPwC8VJ
	 OBE0aZCBsYsVA==
Date: Thu, 16 Jul 2026 11:23:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sandipan Das <sandipan.das@amd.com>,
	Chun-Tse Shao <ctshao@google.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Subject: Re: [PATCH v1 2/3] perf jevents: Add python type annotations
Message-ID: <alkhqxR2VXfGOY4m@google.com>
References: <20260707034019.241762-1-irogers@google.com>
 <20260707034019.241762-3-irogers@google.com>
 <alkNOWGqi5aD8HlE@google.com>
 <CAP-5=fW4Lze=nPvD0ycd4uJtTL0H=HjeXidZDya-FOt6jpD71Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW4Lze=nPvD0ycd4uJtTL0H=HjeXidZDya-FOt6jpD71Q@mail.gmail.com>

On Thu, Jul 16, 2026 at 10:25:01AM -0700, Ian Rogers wrote:
> On Thu, Jul 16, 2026 at 9:56 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Jul 06, 2026 at 08:40:18PM -0700, Ian Rogers wrote:
> > > Make mypy clean.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/pmu-events/jevents.py | 77 +++++++++++++++++++-------------
> > >  1 file changed, 45 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > > index 3c6cfeefbd5d..83a239dd69f5 100755
> > > --- a/tools/perf/pmu-events/jevents.py
> > > +++ b/tools/perf/pmu-events/jevents.py
> > > @@ -14,27 +14,27 @@ import collections
> > >  # Global command line arguments.
> > >  _args = None
> > >  # List of regular event tables.
> > > -_event_tables = []
> > > +_event_tables: list[str] = []
> >
> > I got this from one of my test setup.
> >
> >     GEN     /build/pmu-events/test-empty-pmu-events.c
> >   Traceback (most recent call last):
> >     File "pmu-events/jevents.py", line 17, in <module>
> >       _event_tables: list[str] = []
> >   TypeError: 'type' object is not subscriptable
> >   make[3]: *** [pmu-events/Build:176: /build/pmu-events/test-empty-pmu-events.c] Error 1
> >   make[2]: *** [Makefile.perf:550: /build/pmu-events/pmu-events-in.o] Error 2
> >   make[2]: *** Waiting for unfinished jobs....
> >   make[1]: *** [Makefile.perf:288: sub-make] Error 2
> >   make: *** [Makefile:76: all] Error 2
> >
> > Python version was 3.6.15.
> 
> I believe the minimum Python version should be 3.9.x:
> https://docs.kernel.org/process/changes.html
> That version will resolve this issue.

Hmm.. ok.  I'll re-add them then.

Thanks,
Namhyung

