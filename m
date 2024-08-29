Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC914A4EB
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913141; cv=none; b=oV9LUQLbMln6CA9MvY3TPiqyhS71cwDhg/yqQWAdXmTqR7KhSqb1tiXXgBU7CRKNc/wsif8nBuJ+sLU2yp+YZWY0CNrWQbb46bGeXLXktsg1ESipZXmaMKS5pamzpIJT6yFmAtUD3aaj5CM5wl2Cpj+3v891JzqipVbcezXw3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913141; c=relaxed/simple;
	bh=GUoe4R5n0pDxD2C1Es3g5kp8GiffOjVUblfHh9WwSvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svX55u4nOhnf7+7kP7NxCo2dKZeudD77aopOrPqgUOmGEQ+g0BKWfiJKVom5mIrVyhCDQEneyXQE7Ve7zuDYvp+gyShp8VNuPm+8IyqO4KFkyz8lMJiQ8W703zGlHOqeim4snmThbUv/6CARpI6LAX4JZ5cvvz2GLwgnQehWEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nX0pz0CI; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nX0pz0CI"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d2cad030cso134525ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 23:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724913138; x=1725517938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfgIRxVT7Ef98/Q8EkLzF2XWR0ePSyt/jN1rlVa3xyI=;
        b=nX0pz0CIM/GgbE/c+pmu8ehUxzjv9RCzSBCqW+k5VzLDIRt/20ZcFcHhrO4xDKl8wc
         6BRllEG9gtDeRz4tE/vA+v8hwR/m6l2SaZ8VKZ6zEBkRtyeEUKha255SC864goJ3ttzI
         P3FcBEic2FIiFxJrcABUF2wCFx5GWooc57iaWvbswoCEz9QGeB8i+Eg8zUJVx3ueOX7o
         bT7H5v0Rr9C/4nW0E65siu7qwMgjiRe8EerkMhW+EaClCdaJDLZKxL0g1MtJqqcsl9ty
         p6i+hh9ojSuG9bhq0SclloyfhwCHh7PBielTAFGVFFJQMhJ8kMk+2IXmA9iyEYxpEmz8
         YITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724913138; x=1725517938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfgIRxVT7Ef98/Q8EkLzF2XWR0ePSyt/jN1rlVa3xyI=;
        b=me1H+1bcocSEVIaSR0dxyg5oLXqv3/5ztU4OJMJOviC8ElUIE308MsUdk9UGYblkt9
         2nlZcoHS1T29EngPtO4vt+yQIvZohAt80pypJE0Wl0796T3/FwAgNTWe1adiZrxSPqBk
         puzKR8QBTYHGyQQATv1t9IixzVUFJ9CgmPcuZxoT/Wr1PEieCAqvDyOD4eR5e3e3RWCL
         AQnQEgQG7MmCDENCLZZAONl/ZckI0h4QtmkbWnX+9kBdw2gc+FjRG75qO/48nqwsRuOA
         B55/L0/mXo6FvXyT/faTvZ+Zhk250Ze6rfDgKFJ1HFJLwI5KtuMyZT2D1AD8XSW+qTrL
         dz6g==
X-Forwarded-Encrypted: i=1; AJvYcCXhC8eQ1xrli/ZRaUVfUWkZp2phaCuQLssVsZGXD78xT7+Cx9DOuR78QOeVN5GxHgBVJCX/4M104SpyKJUlPH0t@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77b0T70ZyLqRfaFzQYQJRRVYaCIRxzcbE+I4ucgjNEEAIo9qy
	lYK7X0+KHqB6n/vrg5xwz1WhDKuhSmjljWLp/dKzeMVpwxANjw0d6C+nv8+e79kofCZU/GDQe0V
	5nQVR7xIDMNqANefR2Tm6eoqraxzH1dZI1sXqzI0gxYvxUC791MXYQMk=
X-Google-Smtp-Source: AGHT+IFtCfsrhtn8mXjAs3tCgE4MVJvHd9sd/dkTW88EJFAO+M8DVX6ODJ8YaQB1sYLm4W/Sl49nSmqVKG3pe13HJk0=
X-Received: by 2002:a05:6e02:1d12:b0:39d:3c85:9ba with SMTP id
 e9e14a558f8ab-39f3949bb1fmr1622065ab.15.1724913137935; Wed, 28 Aug 2024
 23:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zs-gjOGFWtAvIZit@x1>
In-Reply-To: <Zs-gjOGFWtAvIZit@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Aug 2024 23:32:06 -0700
Message-ID: <CAP-5=fX-Viz40=J+WQTT8PUDQ+Wtsj1sjA5ZPTxXY4eZo2eXUA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools build: Remove leftover libcap tests that
 prevents fast path feature detection from working
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:11=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> I noticed that the fast path feature detection was failing:
>
>   $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
>   /usr/bin/ld: cannot find -lcap: No such file or directory
>   collect2: error: ld returned 1 exit status
>   $
>
> The patch removing the dependency (Fixes tag below) didn't remove the
> detection of libcap, and as the fast path feature detection (test-all.c)
> had -lcap in its Makefile link list of libraries to link, it was failing
> when libcap-devel is not available, fix it by removing those leftover
> files.

Isn't the feature test still in use by bpftool:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/bpf/bpftool/Makefile?h=3Dperf-tools-next#n103
I'd deliberately not followed up in removing it because of this.

Thanks,
Ian
