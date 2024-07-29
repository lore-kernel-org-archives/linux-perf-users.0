Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55022161321
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275711; cv=none; b=mYUtbx3oaZhbdQGHGFSumpSiAaQSYU3bj3Ltkw84HhlIwQ2Lb8xy+Zz5cxPrzkKCKrCgfRXpr+Efn/LaWoZx1D5lReGRPZV6TwxQnVS2OYhE3zK3fK/1b4dJH+0NHJ3jdgPsF6nR47c67ce+cI+giJVptJItmYCTbBN68IxGO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275711; c=relaxed/simple;
	bh=DoIJpy99FTW+bEHlnX3jUMPvg+d8O+WGv+hlbXue1HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2UkHh5kPMriPKlj4klzdERxja4iC8eRlpXjp0GSwvbHO4dHkCrfnRwZxSDetkYUnyMQG4UOiGIrWileK8Kuw5U0l9bfp7hPpAYf7UtRGGl/IxdX8hRRPgGBfcoV8+9+lGJQ3tRzPC8uTxqzplTEJFoZiWU0FoGPZMxpG26M9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vqIana4k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vqIana4k"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc6a017abdso19956965ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275709; x=1722880509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TabnT56p6n6u7EjWMrlt9344sgcBYi9lrb3FrnTUST4=;
        b=vqIana4kvSTUptqKLC8rSirKY9x0Xk33osDrfUMm4nL9Dg3pgY0JaQHLB6UX+j2L6D
         YhHrC0bvka1g1B61v+S+GR7yJZMQkhYzROwmkqCN6RaOuYLW1mjkmzDDBCt1m2EV4xRE
         IVk8lLQ7rl38SOOjZaiIHoJvkdgQU35c61qM/Ll8gmYOW2AY2czHYOMzurqdPoGakSBH
         P5e8bLIkHx11c76zheUBDuqy9I1XSY4xg5LXXtiJT4FswWzcnH2H7eFeUb+r9e1xc/4k
         hGwbamDjyyGJ1vIXkSi6HcPxdEKIr5bRzIavUD0/4EWvDXyVLnaXKaHA1UTa8eFBppzo
         zedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275709; x=1722880509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TabnT56p6n6u7EjWMrlt9344sgcBYi9lrb3FrnTUST4=;
        b=eb2C0vhNza+a8w2cQ/8sSpoxZ7gWzLSQ4v39AqaKUleZsWfImxOul32cNsPynsr+Wx
         rUTTifBS2PZC0h0FZkrXaR6jYU7MaKSzTSt5+Lj29SVW4e1B1vs7MZQJjJweqmiMPxf1
         PRE4PbwrzFTgqk+STkvrJvpyLNvzTbPS2xdOGw/Q8wSs5hOH5SdPC786YLDszghBRGj1
         3M3vEWUjZo5DhJWOzjvqNwenWzQKscZZ7HuT5FDiwBoBt3tyd6W3zXotZzTfqN8zgddZ
         9b4y/tUdRvCwNSF0iGOUbW/pYHzJxLpYyrfN7ZM3in0n9uT2jBCGW8mU+iWU/BQpsY2n
         FYsg==
X-Forwarded-Encrypted: i=1; AJvYcCUu629jRoaXZvxuAt8Dev89IrXcaJNg1G6Z/X5g/XLdaIunz/rLItM/gQ/FYaoCQWNSxH8lI/QnScDsd5AWa71pbi8PYAcrEsxqI8KC8XPjoA==
X-Gm-Message-State: AOJu0Yx9sJa166pY4NxPVUWqGZ7WCJIBswDIUZFcN00eZk7ItYJmnNu5
	EkrZ9QTX4lQMyWBiqQQjOs3qMngPRrtVHgpV+j/l1t9Fr8rsEyx3gc+xW67JrC8=
X-Google-Smtp-Source: AGHT+IEC0OBdLKSfBqiPGkG2qzUWP07kZSB5gov01yr1ZIEZz1rTwFjiFPH+JlVAD639mT74NrOcOg==
X-Received: by 2002:a17:902:e547:b0:1fd:d3db:bd06 with SMTP id d9443c01a7336-1ff047deaf1mr67630745ad.2.1722275708599;
        Mon, 29 Jul 2024 10:55:08 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee15a9sm85993855ad.151.2024.07.29.10.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:55:08 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:55:03 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/8] libbpf: Move opts code into dedicated header
Message-ID: <ZqfXd0FKtXCJ5dwH@ghost>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
 <20240726-overflow_check_libperf-v2-2-7d154dcf6bea@rivosinc.com>
 <CAEf4BzZ8MGa8Ywp_9ztJh6naywqtfrbeGWs4=izw-e-p4GGxcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ8MGa8Ywp_9ztJh6naywqtfrbeGWs4=izw-e-p4GGxcA@mail.gmail.com>

On Mon, Jul 29, 2024 at 10:01:05AM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 29, 2024 at 9:46 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/include/tools/opts.h      | 68 +++++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/bpf.c             |  1 +
> >  tools/lib/bpf/btf.c             |  1 +
> >  tools/lib/bpf/btf_dump.c        |  1 +
> >  tools/lib/bpf/libbpf.c          |  3 +-
> >  tools/lib/bpf/libbpf_internal.h | 48 -----------------------------
> >  tools/lib/bpf/linker.c          |  1 +
> >  tools/lib/bpf/netlink.c         |  1 +
> >  tools/lib/bpf/ringbuf.c         |  1 +
> >  9 files changed, 76 insertions(+), 49 deletions(-)
> >
> 
> Nope, sorry, I don't think I want to do this for libbpf. This will
> just make Github synchronization trickier, and I don't really see a
> point.
> 
> I'm totally fine with libperf making a copy of these helpers, though
> (this is not complicated or tricky code). I also don't think it will
> change much, so there is little risk of any sort of divergence.

I did this because there were two comments on the previous version of
this patch that asked to change the functions that were copied over.  I
had a couple of choices, have the implementations diverge, not change
the implementation in perf to keep it the same as bpf, update both perf
and bpf, or share the implementations. I figured the last option was the
best to avoid immediate divergence. However, both of the comments can be
safely ignored, and also perhaps divergence doesn't matter.

- Charlie

> 
> [...]
