Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D51D61BB
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 04:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739249034; cv=none; b=kONPjoKEpK5JtXwXh57LFU4zvMMprB3UQO8oL8JGW9p4yKdB7lv6VOQI3HY+jAOuoanqKuH4TM2CPqamy9OLzeSWp/Y55NNSKTE5Zqq0gLnlFeAStLIw/nsIEeu3F/fIiPFjLMM/L5+UYQr70hYyoP50L/T0k3o4xlfFGpOnAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739249034; c=relaxed/simple;
	bh=e2RvQfe11lwkDPvak/int/5CM+LmQ/H7k9c9hDb7Geo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzdM0LqToWYEm5qRogxTCvv9xTyPSIU7aNpg71xQUN5j244CrKyO9pI4xi/wxdyBJuL23BsqGeSSl53evFrvkO+rVFRmziBhVxnXlX8tWvlh/Uy7jRtJO7UCMyTpeTGrJWQPIGk4gvkZKhCf2JjJq5chAdsaHW0OjuEhr0fqp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rymfkDEC; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rymfkDEC"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d147331fb5so101045ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 20:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739249032; x=1739853832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+ac/mznBbI8mYN5cF+80SdkSapmBtg1Uk/QlDfucw4=;
        b=rymfkDECfeO5SzRupMbzUEoSQSFjTyK8ox7sN5aF+yBMv0aj37/nWGnhFH/CQImUvM
         2dBPPV3ibgeiMmIyC4mZZ0ZZzx9RmPIt3X15hnFFRL2b5xnupJ6YxvD9b/8oeC2KgEBT
         Y3rx29JmpYBbWdRaM57OgM4LuyjeyBpAmarHtGps883X/VanRMSC3t7nPAHSJX5Z8ukH
         Rcvjl2tNT4YoGEyHeFGoknKfSXbWFUY4ko1ZZlkcXy5PeVEdy7Xj9YLvTGhdOtZ7P5Dq
         ix9ApeyP+ygs8zvUZuCJnspjUOP9ppsBekg0O7AXt3SfuHZO3mR5p0kvxRBcztxIGMl2
         WjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739249032; x=1739853832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+ac/mznBbI8mYN5cF+80SdkSapmBtg1Uk/QlDfucw4=;
        b=UZ1bv3EHaEfPALNsTQ9Yf+AF9oi7EYQekTCyCJqymF3gu7T8DGJSOD3P2tnA42gpwu
         VC/DR9aF3/zYqhto9FMEG49o94oSvEwcSgRNDPZ/fzuxRpJ87zmaKPHhCGbZeZQKIUxo
         daL31MNXsnxbsyMR+WLIKZqHGwUsKhy3tamvPrw6hl4hcjTflcy3AXcU49B502Mci2AZ
         /4BGsm8j6ZPTDZ/VnCKqZGBTNOm/cJvAfmY8cl+A6wIjre/CI0Jw23eNKaq4SIzLaBiN
         detXIcy7I19Ctsb5D8dw/3aH/hsjEx6mptOt0K1+FNZkbuRf5HBJPbk4EZWRhfi+wXgW
         vgYw==
X-Forwarded-Encrypted: i=1; AJvYcCVT8ClWucMFH82bf0OQSRQ3NbOzLeHY9SQvWUIvj+EdCd4YNcfGP7H6SJ3fbenvlxqVplPd5IPOpAKFkmc5SpvQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFy7yzhBvw6Pjfq7EqueflBQFsJdaU44FWdfS4dJe9NU2Nrdk
	oPrpHCQixDiiuL/pSY6k/zfNU9yVw95Wdd3rIlRkXXlrwWWZPZS9Mn5L3Y9FkXWX8ie/5mYbGjn
	qjQZZqrwt3SjU6pwLFZWBYyyPZHT2Gqi+2vmC
X-Gm-Gg: ASbGncu+K1aeTrL7N3ehoNurEgYdh5nIh0Pmkp/arDdReFc2Y/PcSMi+u9eV/FnMkNW
	kjJBYUdXlC9mKq/N7gKHGKJswqrifaTyR0YBGNhh7sPYdwfZHKx2N5e6CUyD8/xZAh3TKpDn5Pw
	==
X-Google-Smtp-Source: AGHT+IH62zwJb7vIiK9ERZyEtFIzirwQ84WAwSIX9q0lCtyh886O7Fe7cr+mPRTC7OAQyfkYd0fUaBmzY4ORVNBa/B8=
X-Received: by 2002:a05:6e02:17cb:b0:3a7:e3b3:2e3 with SMTP id
 e9e14a558f8ab-3d171e154dcmr1187055ab.17.1739249031726; Mon, 10 Feb 2025
 20:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113194345.1537821-1-irogers@google.com> <CAP-5=fVoQRhd-8jyXfjc2dCuwt7_o1sU208aADT1FriwCNa9qw@mail.gmail.com>
 <Z6q7EZxAvskBE4H3@google.com>
In-Reply-To: <Z6q7EZxAvskBE4H3@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 20:43:40 -0800
X-Gm-Features: AWEUYZlNlwzE1WVHvCpGkcFTuyztJRuv0e871Fx8DlqLQ64oyq26UJ8Sd2M_W_U
Message-ID: <CAP-5=fUTBJ_15f1WFuHjZzbWDwsAo3d90WX_hobfVWPjSOe3Vw@mail.gmail.com>
Subject: Re: [PATCH v1] perf sample: Make user_regs and intr_regs optional
To: Namhyung Kim <namhyung@kernel.org>
Cc: Tavian Barnes <tavianator@tavianator.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 10, 2025 at 10:15:22AM -0800, Ian Rogers wrote:
> > On Mon, Jan 13, 2025 at 11:43=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > The struct dump_regs contains 512 bytes of cache_regs, meaning the tw=
o
> > > values in perf_sample contribute 1088 bytes of its total 1384 bytes
> > > size. Initializing this much memory has a cost reported by Tavian
> > > Barnes <tavianator@tavianator.com> as about 2.5% when running `perf
> > > script --itrace=3Di0`:
> > > https://lore.kernel.org/lkml/d841b97b3ad2ca8bcab07e4293375fb7c32dfce7=
.1736618095.git.tavianator@tavianator.com/
> > >
> > > Adrian Hunter <adrian.hunter@intel.com> replied that the zero
> > > initialization was necessary and couldn't simply be removed.
> > >
> > > This patch aims to strike a middle ground of still zeroing the
> > > perf_sample, but removing 79% of its size by make user_regs and
> > > intr_regs optional pointers to zalloc-ed memory. To support the
> > > allocation accessors are created for user_regs and intr_regs. To
> > > support correct cleanup perf_sample__init and perf_sample__exit
> > > functions are created and added throughout the code base.
> >
> > Ping. Given the memory savings and performance wins it would be nice
> > to see this land. Andi Kleen commented on doing a reimplementation,
> > which is fine but out-of-scope of what I'm doing here.
>
> Yeah, I like the core of the change.  Andi's concern is that it touches
> too many places.  It'd be nice if we can do that without allocating
> memory for regs and eliminating the perf_sample__{init,exit}.  But I'm
> not if it's possible.

Moving from no allocations to 2 possible allocations means there has
to be corresponding frees. Putting the frees into an __exit function
is the norm for this kind of cleanup. I don't see how you can move to
the approach presented without adding the frees and not introduce a
memory leak. I don't see what's actionable for me to do here.

Thanks,
Ian
