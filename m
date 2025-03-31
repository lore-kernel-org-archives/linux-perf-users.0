Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003573451;
	Mon, 31 Mar 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438692; cv=none; b=FEaYL5IX6W8rgr3337KIEd9VVdz05OqQl8Fnq5EAb8yXtbOcFcQGdINMHBpHPuI5iYp9J4PkvDlZLuJOu3olf22sSGQF37SGzge4t9CuC1x0XKJdcO/iDKk/evgMC/I3VMHsXMnKcmn7Oe3upkIX5C+qcT1KWV1l2Y9gaV1dQv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438692; c=relaxed/simple;
	bh=ehlkfaS9lKpFL24+Rr/vhdhKnZG7IHXo2LylZBw987I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0HImZNY+S7qbwljjH0vcBlPZ/hMecEYhFoHQY1BlUzfX/A5HxfkHr2sj1eIYQVOs14yt9dVo/TZTjx5kfHhUAuuMJh1ACtrb1NQyRltv84X6k6kvPDgQkZlBmtkpv+NQQX9DpmUuCR/d7de0X0KaOtxZVEUq2/o5HmHwfmEOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6ypVXjM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6ypVXjM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264aefc45dso117276645ad.0;
        Mon, 31 Mar 2025 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743438690; x=1744043490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGXUzRNndah0bIhWHa4wlLRiZRRMDWz7PNkLOu/SyKQ=;
        b=e6ypVXjMP1Z3fiZ3j3sRMQz+WcHELqfcxp6U7TeerC6VhcTLcX7fLu0BYvYBtaAHWr
         bbQqyRe68qHfgxJrqsoNckQMzb7LrH3BPBtGB42Iczvs4X+lUcRasPNo/yAv5D5NtMjq
         ddHGvOyDiqS83PyLyzwejow6ihBM+8qXGRhTwUKFN6QdFtU/kZypnLKWkEWjqWqpuLyO
         /7S/o13R+qmunTPfCO4NrUY4CGKolU9v4nGEkxYdxOZxNB8g2u5lxkKv+2qt8zLaXnnE
         vFVm+Mmk7tRcRq/JTYSsm8bLssxHUpm4ukRgdf8+tL02eQLz+U8OHniL/3nUP4zZbxEO
         EiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743438690; x=1744043490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGXUzRNndah0bIhWHa4wlLRiZRRMDWz7PNkLOu/SyKQ=;
        b=I70t6EwuC3pXB+xnt9J98v4LGNWCX3f0510sQq9jWNXzFahXXn7lrL7dsvAYnKUZfN
         j2o121PqpVXnEERBAZZkD1uhbH3hRsnToPv2rjHaaqhW9RJjsrICDNbmU+PaXfSqvx0C
         /y6Timn6+wLQHNHvMG0tEJlvObxpahgFKb73KGVz+5fhCCK7q0LJgVzjf7umK1t7AIWU
         mPbrd6uHH6lrQ6TJqNPBqMMoougirS2f4L/gUqQeWWnBmaz4LNABCe/Z4fgBqeaDPc50
         JVCxjOz6/XC8ikL/IYz61HEaiASVd4eAYKiLAPTYOF2tg3SExSS4fAVLLqM0S6WziIEz
         boCA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ubxA32nRATRP8n9zrCe1Hm45lxRK5z+/GFNisWfBegyb06GUAdeAIC9w4vFxuI+Zqy8eeuAlfbxtgCo=@vger.kernel.org, AJvYcCWQJoQ4VP7wyfYWxTv+ILb9geKXZk2cKKRuiWUKkvCs4if8X+fYfGtozOXzUyLg3U20WAjk4eG4A/r+d9ldd6wHcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxV7OUhsAgJjriJgMt3YMmaxdfmXcoRVJKCY6Ns9Lr3JxQkQm8
	mpKvv3JZPzoQp3i4YSOPxrytqCW59wwUzH3SE7S2/UfQk3cW9+Wc
X-Gm-Gg: ASbGncuIeVn3acb1LAbGRTLPHQzF4MAkXOpvjUMeXveys9fMYgbhhVoI4l4YkQY0hEY
	Trco5K79on50Z6YN8gsvCna/CUCrGifU4tmFwWK8euttTZMi4vlpWjrccjr09S+kEo4HsK4F7Nr
	f6NsFcp4J/xYS8gyPmrch9opG6VKIuFwSPAWR23MdGzSqOWVXcTUu5PfUwLf3zq1fKh1ukAeSxH
	Czq3O1kF5Aa7M+fyCv+bh8WDiAzAESF0aoQLNVyvpIn3dJMsJl1X12qhdSnp1WWYiPQ5S157sZT
	L3CHKiw1xnwBxMJgpPds+yfyhik2IF3zCqrk2wyVwiFaK7Xo2Tg6FErFuBlktHIkRj2IZS0Ibxu
	vd7Y=
X-Google-Smtp-Source: AGHT+IG4tFl30LDPvdokscC5SmNTqPEZA266aLkDHCR4ADSz+/s4hQbQtbrw8GrXI1BtUL6RtlCEYQ==
X-Received: by 2002:a05:6a00:180b:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-73980487652mr16666540b3a.20.1743438689567;
        Mon, 31 Mar 2025 09:31:29 -0700 (PDT)
Received: from gmail.com (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970deebd4sm7373735b3a.16.2025.03.31.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 09:31:29 -0700 (PDT)
Date: Mon, 31 Mar 2025 09:31:26 -0700
From: Howard Chu <howardchu95@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf trace: Fix possible insufficient allocation of
 argument formats
Message-ID: <Z-rDXsgIqvvd7hFk@gmail.com>
References: <20250327150712.1966188-1-howardchu95@gmail.com>
 <Z-jXFffv8MMuo2p3@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-jXFffv8MMuo2p3@z2>

Hello Namhyung,

On Sat, Mar 29, 2025 at 10:31:01PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Mar 27, 2025 at 08:07:12AM -0700, Howard Chu wrote:
> > In my previous fix of runtime error(Link:
> > https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howardchu95@gmail.com/),
> 
> We usually handle this by adding a footnote style link like, [1].
> 
> > I made a mistake of decrementing one unconditionally, regardless of
> > whether an extra 'syscall_nr' or 'nr' field was present in
> > libtraceevent's tp_format. This may cause perf trace to allocate one
> > fewer arg_fmt entry than needed for the accurate representation of syscall
> > arguments.
> > 
> > This patch corrects the mistake by checking the presence of'syscall_nr' or
> > 'nr', and adjusting the length of arg_fmt[] accordingly.
> > 
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Fixes: c7b87ce0dd10 ("perf trace: Fix runtime error of index out of bounds")
> 
> And add the link here.
> 
> [1] (actual URL here)

Thanks I'll update the commit message.

> 
> Also you need to keep three dashes "---" before the change log so that
> it can be treated as comments (and not added to the commit message).

Oopsie, got it thanks.

> 
> Please take a look at my previous posting.
> 
> https://lore.kernel.org/r/20250326044001.3503432-1-namhyung@kernel.org
> 
> Thanks,
> Namhyung

Thanks,
Howard
> 
> 
> > 
> > Changes in v4:
> > - Make the patch apply
> > 
> > Changes in v3:
> > - Add 'Fixes:' tag
> > 
> > Changes in v2:
> > - Simplify the code (written by Namhyung)
> > 
> >  tools/perf/builtin-trace.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index a102748bd0c9..439e152186da 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2022,9 +2022,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
> >  {
> >  	int idx;
> >  
> > -	if (nr_args == RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr_args != 0)
> > -		nr_args = sc->fmt->nr_args;
> > -
> >  	sc->arg_fmt = calloc(nr_args, sizeof(*sc->arg_fmt));
> >  	if (sc->arg_fmt == NULL)
> >  		return -1;
> > @@ -2034,7 +2031,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
> >  			sc->arg_fmt[idx] = sc->fmt->arg[idx];
> >  	}
> >  
> > -	sc->nr_args = nr_args;
> >  	return 0;
> >  }
> >  
> > @@ -2176,14 +2172,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
> >  		return err;
> >  	}
> >  
> > -	/*
> > -	 * The tracepoint format contains __syscall_nr field, so it's one more
> > -	 * than the actual number of syscall arguments.
> > -	 */
> > -	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
> > -		return -ENOMEM;
> > -
> >  	sc->args = sc->tp_format->format.fields;
> > +	sc->nr_args = sc->tp_format->format.nr_fields;
> > +
> >  	/*
> >  	 * We need to check and discard the first variable '__syscall_nr'
> >  	 * or 'nr' that mean the syscall number. It is needless here.
> > @@ -2194,6 +2185,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
> >  		--sc->nr_args;
> >  	}
> >  
> > +	if (syscall__alloc_arg_fmts(sc, sc->nr_args))
> > +		return -ENOMEM;
> > +
> >  	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
> >  	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
> >  
> > -- 
> > 2.45.2
> > 
