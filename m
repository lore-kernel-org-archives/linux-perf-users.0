Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A874274B2A
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180438; cv=none; b=PK+9kEHnJUbUt67wQ7qb7QDYMaQvDaqeNfqIIeyFCgTE8sEFL/s5SWghpFJGuoxDoE/4dbST7VkNVJUwaNx6grt/6zag/NRrZmVJDJUNFkruwtTiMZwXtABbFwcU7ianwQR/vjS08BYALP1ZdgaPVgEVy6Cu/se0i8zjmoS9QNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180438; c=relaxed/simple;
	bh=H2Yf3Z1qsgrZjdr1WJOu3Uuczn/2maq7eE/Tf1Sfz2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3kUfrYkWVdl89gnkNuse64fq50zcIRX+k6G43dwfmaQUb/yRKkWPKtiz95zljfF56i6JdBU0zcPyNLPL37S/X6HdyZdg5jiof0if5iBSiY5aXsvUI9Uw14jBRI4dBIDC08cu0h6GCrSqJh1dg+VESHwGdVX5AkzrO+T0TresRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKuC0diF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKuC0diF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0179C116C6;
	Fri,  3 Apr 2026 01:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775180438;
	bh=H2Yf3Z1qsgrZjdr1WJOu3Uuczn/2maq7eE/Tf1Sfz2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKuC0diFcwk8Sq9dasYEfLqzNvAzJUuRivJMv6Yhh8NZEj3Z8BVf0OCui8KRIYUsL
	 RAdV10jEXBSfo0kBKbC/aig6rMc07dOb7KIN5pNbl8KVXujA0Cg5hAK0YvDzYe0RYG
	 GSGRN/oaARx0x4itlvTSZOhJkoYsp1Mb4G0U8vYjGHAPmEunNUjNaKC8ZzBWuoJcIX
	 y/+99Ix1xKMy5xZellPcYJO58rmst+Ypwmr+gl0SwT/Q6dsSDABFRdCgg8Zf9A/exy
	 dP4YD32wndwysRJ/pV+8x6OOgmxEM/WEKrIUKhz0XUg7bECvBRO7aUDA1HlTK84QWL
	 5nujKrDH0xgfQ==
Date: Thu, 2 Apr 2026 18:40:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org,
	acme@redhat.com
Subject: Re: [PATCH v2] perf trace: Fix potential u64 underflow in duration
 calculation
Message-ID: <ac8alE0Nm-DL20a2@google.com>
References: <20260331101020.1270363-1-mpetlan@redhat.com>
 <20260402145118.1379546-1-mpetlan@redhat.com>
 <CAP-5=fUo6GVurv8qQnMfpgN-hYa1ukNLhF_5n2VfEv=X6APBTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUo6GVurv8qQnMfpgN-hYa1ukNLhF_5n2VfEv=X6APBTQ@mail.gmail.com>

On Thu, Apr 02, 2026 at 08:09:12AM -0700, Ian Rogers wrote:
> On Thu, Apr 2, 2026 at 7:51 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > Although it happens very rarely, in case of out-of-order events (i.e.
> > due to CPU migration when a syscall is executed), the calculation of
> > event duration might underflow and thus a bogus value is printed:
> >
> >     2.804 ( 0.001 ms): :49553/49553 rt_sigaction(sig: QUIT, act: 0x7fff403ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) = 0
> >     2.807 ( 0.001 ms): :49553/49553 rt_sigaction(sig: CHLD, act: 0x7fff403ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) = 0
> >     2.815 (18446744073709.438 ms): :49553/49553 execve(filename: 0xbb173a30, argv: 0x55aabb171930, envp: 0x55aabb171120) = 0
> >     2.815 ( 0.534 ms): pwd/49553  ... [continued]: execve())                                           = 0
> >
> > Check for possible underflow first and in case of a bogus value, do
> > not print it.

I guess this means to leave the duration empty and print the rest.  For
clear communication, I think it's better to put examples before and
after for user-visible changes.

> >
> > v2: Use greater-or-equal to handle "zero" duration calls correctly.
> 
> Nit: This normally comes after the signed-off-by past a "---" to
> indicate it should not be included in the commit log.

+1.  I can handle that this time but please do later.

> 
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Namhyung

> 
> > ---
> >  tools/perf/builtin-trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index f487fbaa0ad6..9c59969de2af 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2956,7 +2956,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
> >                 ++trace->stats.vfs_getname;
> >         }
> >
> > -       if (ttrace->entry_time) {
> > +       if (ttrace->entry_time && sample->time >= ttrace->entry_time) {
> >                 duration = sample->time - ttrace->entry_time;
> >                 if (trace__filter_duration(trace, duration))
> >                         goto out;
> > --
> > 2.47.3
> >
