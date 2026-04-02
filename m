Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274632860F
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140273; cv=none; b=D4N+KjmuOt4hzeRYzNbBi5GoWKiyQTp2OWNeF7iyE4OHfnHNW9Z9Y+ZcwqmDN+oFn7j/qaUkSiQIV4rjeR8tp3PoZtMudHenIQRIQq2755AGXYsgF92+OUZ5wLqfkr9KvBKtR+ZOBV0a4OYa406CiNtYTjrIt1gThIb8d5Vci0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140273; c=relaxed/simple;
	bh=FXklIs/0ntNKxNriNhQBgzklsEj5LiATmC4F1M3W+R0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K5EFFRVtwFeXRtLq6UfFg4Leb0bGET20rdI/ffQJfJ1CRMHbgwNjItlD3ffsfHl6XtW2pTTh6SXX5FPEMZ5WS2GgUoQYBx9KSkNyghQpvtWzYdFXBArpfcMc7Ofas1C3raUC96tfjgRvW+OYK8qpU1rYZLjIo4ByKtrxIXd8xcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCv+iwh5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCv+iwh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775140270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4d+XmoEYPVWGPx+yum5HLak/JmTgnfH0boypFl17lY0=;
	b=DCv+iwh5fsjOMIgbaDD22xCOnYLw62zCeDJMc8dVJPkBkdaDn2g20qwF+4mFUn9Sd4tsbr
	GmGF4k53bOZaq3uRbgGO/FIH/lEq1f/HRu12z2AoCvbCcskEJT+/wloqxnwbfM/RrlooM4
	HGtEPbsc9hvNz9KtLROAjSPy95s5uak=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-tU-1cBrRNdqQ1OU25uf3Lg-1; Thu,
 02 Apr 2026 10:31:08 -0400
X-MC-Unique: tU-1cBrRNdqQ1OU25uf3Lg-1
X-Mimecast-MFC-AGG-ID: tU-1cBrRNdqQ1OU25uf3Lg_1775140268
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA4CD195608C;
	Thu,  2 Apr 2026 14:31:07 +0000 (UTC)
Received: from Carbon (unknown [10.44.24.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1A5230002D2;
	Thu,  2 Apr 2026 14:31:05 +0000 (UTC)
Date: Thu, 2 Apr 2026 16:31:02 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
To: Ian Rogers <irogers@google.com>
cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, 
    acme@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH] perf trace: Fix potential u64 underflow in duration
 calculation
In-Reply-To: <CAP-5=fX51zhteqMNsHb=oiB1L7QcXuZm71-_-RB_+TrfvS8_RQ@mail.gmail.com>
Message-ID: <dfec5c3e-3fc9-fa99-e859-29f38412027@redhat.com>
References: <20260331101020.1270363-1-mpetlan@redhat.com> <CAP-5=fX51zhteqMNsHb=oiB1L7QcXuZm71-_-RB_+TrfvS8_RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463776256-1444501064-1775140267=:10470"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463776256-1444501064-1775140267=:10470
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 31 Mar 2026, Ian Rogers wrote:
> On Tue, Mar 31, 2026 at 3:10 AM Michael Petlan <mpetlan@redhat.com> wrote:
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
> >
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Sashiko notes [1] that maybe this should be >= so that 0ns system
> calls still have a duration. I'm not sure how sensible that is.
>
OK, although there is nothing of zero duration, coarse clock resolution
is a reasonable case. Sending v2.
Thanks.
Michael

> Thanks,
> Ian
> 
> [1] https://sashiko.dev/#/patchset/20260331101020.1270363-1-mpetlan%40redhat.com
> 
> 
> > ---
> >  tools/perf/builtin-trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index f487fbaa0ad6..c9de6bb9b0ea 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2956,7 +2956,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
> >                 ++trace->stats.vfs_getname;
> >         }
> >
> > -       if (ttrace->entry_time) {
> > +       if (ttrace->entry_time && sample->time > ttrace->entry_time) {
> >                 duration = sample->time - ttrace->entry_time;
> >                 if (trace__filter_duration(trace, duration))
> >                         goto out;
> > --
> > 2.47.3
> >
> 
> 
---1463776256-1444501064-1775140267=:10470--

