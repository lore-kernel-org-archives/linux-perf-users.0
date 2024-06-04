Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFB1482E7;
	Tue,  4 Jun 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527735; cv=none; b=RVGix98LnrgOfr4us5Q/VhN2zIwv5VNrrodxQLI8INWrMYyLbW5E4ojbuiZB+a1108FrcG492HC6zbnOf+gv/J+N8mJGlPeCL4Ps3F5M2Z1m+xKiztD0UhvuAP/vY5V68HpFxhFue1PHkyC7tS7CblKmBKUe2SbdGNXxmuNWDxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527735; c=relaxed/simple;
	bh=RkN5Y3HmGlKLDqvR91ATdvyLyqquL2+fSb4Vj+4qCXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McWI99pYjd1UsuEDwouSuNjqHmLiwr3pZdjYeb6ngVVDqQC3BnMe1SOnjQpJELQkno7bK/auUgaM8aAvRwjAvVdzzG9ZvEFPllXgdY7EbvJx9S2iwbE2HdJ681A0BwZfBvKRCYG3Dwsu6sS9KcxBhpeKq4rLacV8bmbeZNHVHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrTiIcOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrTiIcOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90958C2BBFC;
	Tue,  4 Jun 2024 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717527735;
	bh=RkN5Y3HmGlKLDqvR91ATdvyLyqquL2+fSb4Vj+4qCXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JrTiIcOCw5JPVRMul/mUQjyu+td7oOtApNUepXHrPNp47lp8/lbdZHAwUOj1JamyH
	 IG+rhfcbtIb5Jn/I7SQEBvUbcs1WhAORSiQ9FqiANc0cbnNKy2AvXwl3QELlb39ute
	 Qswr2DlBIct3ErRXEPtYM7cEKC/R0bbogwbPNPDfyRBCkgwo5lN6v+YHD8KV9K0B0Y
	 GYmtX0mGXSrJDsOZgRnbJiALdfQQKRo8miov9b7X8BbrTd8Qy26Q92HfIJCzVJjLoT
	 ivCBjOZDmAEQa/w5baIJkwwl6WbpgZJ0rZlmYurSNl7mCX9kcMaCVjs+WQLpcaZeVb
	 zTQUbnXDScCaw==
Date: Tue, 4 Jun 2024 16:02:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kenel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf 6.9-1 (archlinux) crashes during recording of cycles +
 raw_syscalls
Message-ID: <Zl9ksOlHJHnKM70p@x1>
References: <23879991.0LEYPuXRzz@milian-workstation>
 <Zl8bhWfHSXxs35r2@x1>
 <Zl8g1LxRCYgTSxhy@x1>
 <CAP-5=fVJRr2Qgf88ugEJ2FGerzKNv_dD6XOT_dSuFyYp2ubwSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVJRr2Qgf88ugEJ2FGerzKNv_dD6XOT_dSuFyYp2ubwSw@mail.gmail.com>

On Tue, Jun 04, 2024 at 11:48:09AM -0700, Ian Rogers wrote:
> On Tue, Jun 4, 2024 at 7:12 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Can you please try with the attached and perhaps provide your Tested-by?

> > From ab355e2c6b4cf641a9fff7af38059cf69ac712d5 Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Tue, 4 Jun 2024 11:00:22 -0300
> > Subject: [PATCH 1/1] Revert "perf record: Reduce memory for recording
> >  PERF_RECORD_LOST_SAMPLES event"

> > This reverts commit 7d1405c71df21f6c394b8a885aa8a133f749fa22.
 
> I think we should try to fight back reverts when possible. Reverts are
> removing something somebody poured time and attention into. When a

While in the development phase, yeah, but when we find a regression and
the revert makes it go away, that is the way to go.

The person who poured time on the development gets notified and can
decide if/when to try again.

Millian had to pour time to figure out why something stopped working,
was kind enough to provide the output from multiple tools to help in
fixing the problem and I had to do the bisect to figure out when the
problem happened and to check if reverting it we would have the tool
working again.

If we try to fix this for v6.10 we may end up adding yet another bug, so
the safe thing to do at this point is to do the revert.

We can try improving this once again for v6.11.

> regression has occurred then I think we should add the regression case
> as a test.

Sure, I thought about that as well, will try and have one shell test
with that, referring to this case, for v6.11.

- Arnaldo
