Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73728285C84
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075762; cv=none; b=JhMyIoIRKgi0ILr1rgOYM1pSgRnKxiaMytPkNiP6wm1ZRrsLgmsa/kYPPX7EWDDUXigqy77sw83jgKkir/DWT/FVvq+rJYVmW1ms44ErSsGMbPc203DA93uBmbDeKr422Ts6Mg3F3bcCYlr3UvUVchL8CDBFQRVytpe27W1MtlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075762; c=relaxed/simple;
	bh=N8lJFPOlxJuGnNzcSZHaqB6OKRGn99rucfnx664Zc1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9SJ+aw7mWavAGNxxtpBxM+Ehdrj8szry/76Tlq0pUloE6vto/qKVmuxQnf0KZnTk1TfWKC0a+qogCYkniWuN/mfCYYWg3i9chbhGRD0B8KlMQiUFLwaLmD55GMexT1Q6OvRf3/lbz/1B/6pvfj50hHFzYp0wIK42Pmip5i47m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1pujeWd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1pujeWd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so12422525e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 01:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769075759; x=1769680559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yujnH9wU+TNdDReDnr98/rum5BScCCRa/k+ogGj8Y8E=;
        b=C1pujeWdiS5+a4Jnl8J2LCd6JU0XyfPEU16eWpNw0+gW/B1rrDzSLXrYh5AehAmWHs
         4tOp6K8qsj79AOhtBxZRbDtHz0+70BIEZJF4Xg0dxaD8fr877SAAq3j8KUa+aUlbdHKZ
         fvBUOqfQZ+8CelrLa+71UtrM0FOWqN3U9O+wSfbmjTi8GzRSxZehH37Xjakd857MeU/4
         aeOiLLD4M0Dl1GJyj9a23I4jP6OUrJOjEa87xHeIWXeoYbs/mX4H0bDNG/dVWXxGzKSX
         egFYIdtgkSS4KqWQAps4Qh2/Eldzuqm/Lph7TP3SfdsgwqVsjNHoTaBJrp/Ye7gB3U5k
         oAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769075759; x=1769680559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yujnH9wU+TNdDReDnr98/rum5BScCCRa/k+ogGj8Y8E=;
        b=kb7cH5H1bnRJ6nZEsd/YniIjh2Xdb+r/eoehzOGog4cQJDlHrHQ6xsgFrjSsZTSG9+
         kFPrhcw1ZyRfmoueQSX1wYHm/nsefLnOaTxj5+ZnLlBV+p7Q2bmYxdBs5Nb8cYp/7U5N
         Gzk6z9+ROzsce6ZWMlnRD56A6BpLUbhW2wuF5aTFlAYQcbD3KMPl/cW2IAf3pCUVmWxa
         39YUlW1wYeA3fHnF5iQ02R9sejcR55HAc/fsOxL+R3TS8aEJ7nSUKE6G3PrSNNcaPwCp
         birk4vIW03+tL4BO3U8Lm/xkupK2Y3y0QbriPPuvDwWzS6mpr4g5bL8hx2tryRx37UmU
         1vxA==
X-Forwarded-Encrypted: i=1; AJvYcCUEv1LIvMx0MEnnAOQHkpZR0+vv2F2lUCxogKwQhOWVJ47XOBr6B/qfhg8DO1DcIJBxPYz9hkmDOiTG58Rq6AJr@vger.kernel.org
X-Gm-Message-State: AOJu0YxjkRKnx6splnattlbGkkz5bWZcYKxc6LmsFzzTWJXxpZsdqoCe
	Azi5HVIFeJKwdYg0k5UA4Bq0p+dr2DpbBAodXs1uCxLMvlvfS3p3BiHN
X-Gm-Gg: AZuq6aKkDfS904nCo026oQYgti5yCSLuSFOwDSE3nFIzLa0b7fWKqayo1+pDor6Jnmm
	chaU0Kbf6KXM+uK6vaAKgB1vYlhZOaqO/hCpbbGD+rH8Unq+tTTIIbL5kezw7He+NvwXY/7qyfu
	p4HU5d1cZ7q0ZJFzu+oIBlUH5IxulXfdX3LUAYzzX8MP17AdM7a/TQXhyJ/FihzUWOONaqDsmVM
	vUHr0I1kJPhHJtiH0dtaC9C7j5qh+3AcqWi62T2IjiSbBGXaR+gk/cieaqGUuUb/02vFhzUEYcm
	ILJ6kXtaXjxIwQHPJBihm80DX1ykiUPMjCui4DbKMoiew8/6q0D2F15kKwvm/9uQdW8AMtfmx9I
	NVrqpilbK6yZsBCtlnW9JUKArIh4cvmPa0l57Zl7jEz0PjnEVDDhMQ3PU+wlAghcC3QJL5auZX3
	n9GQSY+vW9hlTwIx20XtM1iQ8HdZtoJv1JDAS0poQdOAK4LKP2CA2J
X-Received: by 2002:a5d:5d0e:0:b0:430:fdc8:8bd6 with SMTP id ffacd0b85a97d-435a5fa70b4mr4276032f8f.31.1769075758458;
        Thu, 22 Jan 2026 01:55:58 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm44726792f8f.2.2026.01.22.01.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 01:55:58 -0800 (PST)
Date: Thu, 22 Jan 2026 09:55:56 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>
Subject: Re: [PATCH 3/4] perf list: Don't write to const memory
Message-ID: <20260122095556.6e9fe2bd@pumpkin>
In-Reply-To: <aXF4-vLA9DvhsPdc@x1>
References: <20260120220900.366451-1-acme@kernel.org>
	<20260120220900.366451-4-acme@kernel.org>
	<20260121221713.1e7e0cf9@pumpkin>
	<aXF4-vLA9DvhsPdc@x1>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 22:10:18 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Wed, Jan 21, 2026 at 10:17:13PM +0000, David Laight wrote:
> > On Tue, 20 Jan 2026 19:08:59 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >   
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > Something now detected on fedora 44, where strchr() returns const if it
> > > is passed a const pointer:
> > > 
> > >   util/print-events.c: In function 'print_sdt_events':
> > >   util/print-events.c:89:29: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> > >      89 |                 char *bid = strchr(sdt_name->s, '@');
> > >         |                             ^~~~~~
> > > 
> > > Fix it by using strnchr() if strchr finds the separator instead of
> > > temporarily scrubbing it with '\0'.  
> > 
> > I've just looked at the full function to see WTF it is doing.
> > You've fixed the second strchr() not the one the compiler bleated about.  
> 
> It complained about both, no?
> 
> > Line 89 is followed by:
> > 	if (bid)
> > 		*bid++ = 0;
> > but if it is NULL there is a fair chance the code will just explode a bit later on.  
> 
> Why, can you elaborate?

I don't see why it can't end up in:
		if (show_detail) {
			char *path = build_id_cache__origname(bid);
with 'bid == NULL' and the function just dereferences it.

> 
> > I suspect it is an error if the strings aren't "name@bar"  
>  
> > 'show_detail' seems to be set if either the previous or next entries in the
> > list/tree have the same "name" - which seems strange to me.  
> 
> All this is strange, a corner case, it looks as if we may have multiple
> binaries, differentiated by buildids, that would have different SDTs.
> 
> The code seems to be trying to reduce the amount of info (not showing
> the buildid if there are no more at that point multiple versions of a
> DSO with SDTs in place).
> 
> Further analysis of the changesets that put all this in place is needed
> to clarify, but looking just at fixing what the compiler is complaining,
> do you think the patches are bad?

I didn't see a patch to fix the first one.
But can you just change the structure so that 's' is 'char *'?

	David

> 
> - Arnaldo
>  
> > The while thing needs more work :-(
> > 
> > 	David
> >   
> > > 
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/print-events.c | 13 +++++--------
> > >  1 file changed, 5 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> > > index 8f3ed83853a9e468..898cf426509790cd 100644
> > > --- a/tools/perf/util/print-events.c
> > > +++ b/tools/perf/util/print-events.c
> > > @@ -97,14 +97,11 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
> > >  		} else {
> > >  			next_sdt_name = strlist__next(sdt_name);
> > >  			if (next_sdt_name) {
> > > -				char *bid2 = strchr(next_sdt_name->s, '@');
> > > -
> > > -				if (bid2)
> > > -					*bid2 = '\0';
> > > -				if (strcmp(sdt_name->s, next_sdt_name->s) == 0)
> > > -					show_detail = true;
> > > -				if (bid2)
> > > -					*bid2 = '@';
> > > +				const char *bid2 = strchr(next_sdt_name->s, '@');
> > > +
> > > +				show_detail = bid2 ?
> > > +						strncmp(sdt_name->s, next_sdt_name->s, bid2 - next_sdt_name->s) == 0 :
> > > +						strcmp(sdt_name->s, next_sdt_name->s) == 0;
> > >  			}
> > >  		}
> > >  		last_sdt_name = sdt_name->s;  

