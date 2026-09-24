Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681DC3F5BF5;
	Thu, 24 Sep 2026 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289982; cv=none; b=bXnt2Prn9wD5wX69Uy/2QwfDpNMuIDGcAsIgAgQhXIVrqTGbsnjntlXXjU2fiSBxANkUh/Qg4UF1qrh0FtwOvLHg6bjNF7M929g3y2YAPi1zHpZJ4LHXAx1scYBbElvqqscg8RWl0LluWuxOoh9mLbA92DeQkZC9bZxahFWTE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289982; c=relaxed/simple;
	bh=CyXUp7vFEYOn0lSwaA8EzsCzO3Pa/qtCqaAliLhCTcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USYm5MbA3bz2wnh9aNQ0bQDuaUw2woUTKAGihahGgtp84Yheg5v8Yk17Mpy1PkOUDRd0C2gcTYq9sYHzb8QeVYNMRZqV80+4R10VDAt3M7UuR0cyhxuZDGsUIS3hoUhUqqOpR51a8MyAJ8DNougVh0Aj8q5lI2zeF+Q3mIJBJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oohfw6kl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oohfw6kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CD61F000FF;
	Thu, 24 Sep 2026 22:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289980;
	bh=JWJZvBtJJ3ChxXcB7Dhfg9AEW1Ni2m0077+nHQHfjXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Oohfw6klPo4au0yI8XMOPZgDRtp5O4FMvPiO0TOnpQppw2ucxsOC9SmpqDVUnK0NZ
	 6FiJ5QLDwE9kqgOGhGzHJPgYUFBEQsiM/FqU1xR1T9Fji38Sl9kFwGFmigKDiZqRcg
	 6dcIax9IxMxsqVOWXuHjKh77PaDPPY0RIdPELaD3XQCg4bn33590vnc7IoizN5oDr7
	 4uQrHplDHwHDqEPB0uhUDGDxyHAAEDUhZqM+WLnrbgfNo5b1nSAIlJqBu740jcvPcD
	 GmtZTQnZWge/H4EafCxubkPQdaKRwc5WgGPXBNZKfX0YuBdlZ4SMiG1a9Cg/AyKIw4
	 JpESKNJYuJ/2w==
Date: Fri, 25 Sep 2026 00:46:17 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Christian Melendez <chrismelnu@gmail.com>, irogers@google.com,
	jolsa@kernel.org, peterz@infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf stat: document task-clock/cpu-clock in TIMINGS
Message-ID: <arWoOVJxocWIp4Pp@x2>
References: <CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com>
 <20260923135140.386033-1-chrismelnu@gmail.com>
 <arWi_dY4y15J2rqh@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arWi_dY4y15J2rqh@google.com>

On Thu, Sep 24, 2026 at 03:23:57PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Sep 23, 2026 at 03:51:40PM +0200, Christian Melendez wrote:
> > task-clock/cpu-clock appear in perf stat's own example output but
> > were never explained in perf-stat.txt, unlike time elapsed/user/sys.
> > This came up unanswered on the list in 2013 and 2015 without docs
> > ever being added.
> > 
> > Link: https://patch.msgid.link/CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com
> > Signed-off-by: Christian Melendez <chrismelnu@gmail.com>
> > ---
> >  tools/perf/Documentation/perf-stat.txt | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> > index f334aabdc809..c0d6c344f9eb 100644
> > --- a/tools/perf/Documentation/perf-stat.txt
> > +++ b/tools/perf/Documentation/perf-stat.txt
> > @@ -621,6 +621,16 @@ user/system lands:
> >  
> >  Those times are the very same as displayed by the 'time' tool.
> >  
> > +We also display a clock-based timing metric that depends on the
> > +target being monitored:
> > +
> > +        83723.452481      task-clock:u (msec)       #    1.004 CPUs utilized
> 
> I'm afraid task-clock and any other software events don't support
> privilege filters or modifiers.  So task-clock:u would be same as
> task-clock, but it can give a wrong idea that it only measured time
> in userspace.
> 
> Maybe the kernel can reject ones with modifiers but then it would have
> a compatibility issue. :(
> 
> So I think it's better to remove the ":u" modifier in the example
> output.  Probably we need to change the perf not to add it to the
> software events.

Since I'll need to force push due to a missing Signed-off-by in a patch
that had --- markers before the author's Signed-off-by, I'll remove the
:u.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> > +
> > +For a single task, task-clock reports a clock count specific to that
> > +task. When the target is a CPU or the whole system (-a or -C),
> > +cpu-clock is reported instead. cpu-clock is a high-resolution per-CPU
> > +timer. See perf_event_open(2) for more details.
> > +
> >  CSV FORMAT
> >  ----------
> >  
> > @@ -671,4 +681,4 @@ that can be used for parsing.
> >  
> >  SEE ALSO
> >  --------
> > -linkperf:perf-top[1], linkperf:perf-list[1]
> > +linkperf:perf-top[1], linkperf:perf-list[1], perf_event_open(2)
> > -- 
> > 2.34.1
> > 
