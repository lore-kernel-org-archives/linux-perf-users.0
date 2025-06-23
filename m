Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B61E519;
	Mon, 23 Jun 2025 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702489; cv=none; b=DqR4GU44AbJJ26QJBSt2eXvFBd6YAorQN0wT01Uw1NsSGA0N3rPCg8OF1cdaIdE7jZ7WJEW1e1fd4eXEjW2nBO7R0XtH6MAdy1jDH13dCBs1DFYQtuPVpPsYw6Dfr374I17dsWHCSx/QztFG1N3JdN7iCpqUbixzhu97Dpf8yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702489; c=relaxed/simple;
	bh=urwMnBXcD8mJyiYmvRbPoesYOHCCY3+cEnEX0Q7bL7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnWWvFSUyO+zRXmalCRZhkGwbFVk9z/k2oNvsTni+WB2TB+CGGIdDcTS+syTChInT+RVqzINqSnGsebvZEt4XDnglOPLN9ge7DMPyskVJ8/fVKnTC6Km/kpz2VlbJ0yFY07qlIEoxGucK1y2xzvH2WwsSCWxrTmjY7/UtCmVBiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGRoYcKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGRoYcKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7C3C4CEEA;
	Mon, 23 Jun 2025 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750702489;
	bh=urwMnBXcD8mJyiYmvRbPoesYOHCCY3+cEnEX0Q7bL7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGRoYcKpPs19csIxA2ZU0CdSirvzn2c73cFG9RIOOnBBZpVa3fkWwYMfWj/8Dr25J
	 BlWdBSIOY15A9rpgrCKV64/dpX7i8mvVVNHc1R1ITBs68mF33nwfKfyaaWrl1eAcnI
	 abx1WkQDRVAcSWxTj9CHHa5ctQjwVZsQJIxORyfNNfnT5z0dyyY7ZmFTLFHTg/hNUG
	 Q1Q37wW6EPChJOwpyRSuU1Zm0WBBWr8cOKqMQLYSpB8uh3Gp7uDlVqpNt2dUOjvBFg
	 80M+ZBAD2P0Kk17ztyEt3K/Hc6tWTHOGnR/zAK1kireFQrP0gtPr696KLr0QokSjZT
	 KggKYh1lt+B6Q==
Date: Mon, 23 Jun 2025 11:14:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf test workload noploop: Name the noploop
 process
Message-ID: <aFmZl-SUT85Im8BJ@google.com>
References: <20250619002034.97007-1-irogers@google.com>
 <aFW4VJtk96JD865U@google.com>
 <CAP-5=fUpnW1DE68pMW0q3vMT+n6d5SeNkwXd45XLaf01-eP47A@mail.gmail.com>
 <aFmSuSyZ1ZNT94Tq@x1>
 <CAP-5=fXms87LVH-Y5V3OpVbwUjY=hWAe0NTX4uKQf1q3Ax-WSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXms87LVH-Y5V3OpVbwUjY=hWAe0NTX4uKQf1q3Ax-WSA@mail.gmail.com>

On Mon, Jun 23, 2025 at 11:05:41AM -0700, Ian Rogers wrote:
> On Mon, Jun 23, 2025 at 10:45 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Jun 23, 2025 at 08:12:47AM -0700, Ian Rogers wrote:
> > > On Fri, Jun 20, 2025 at 12:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > I'm afraid it'd introduce a build failure on musl.  Please see
> >
> > > > https://lore.kernel.org/linux-perf-users/20250611092542.F4ooE2FL@linutronix.de/
> >
> > > > I think <sys/prctl.h> would be enough.
> >
> > > we could do that but in the glibc man page it says:
> > > https://man7.org/linux/man-pages/man2/prctl.2.html
> > > ```
> > > #include <linux/prctl.h>  /* Definition of PR_* constants */
> > > #include <sys/prctl.h>
> > > ```
> >
> > > It'd be nice to think musl was slowly getting fixed. I notice we're
> >
> > Sebastian reported on the musl libc, its maintainer replied:
> >
> > https://www.openwall.com/lists/musl/2025/06/12/11
> 
> Ugh. I'm not sure how we're expected to resolve this and have glibc
> and musl be happy without basically not trusting libc.

Maybe pthread_setname_np()?  It seems musl also implemented it.

Thanks,
Namhyung

