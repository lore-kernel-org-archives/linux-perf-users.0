Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BA1553A3
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231785; cv=none; b=jw0C66qVpRiVf8dWJzkepPaPEkgkY6/pi8dVlWeSWesb5bJXcO0nkm/vtJPDdoH9ujNqEPaop4zBoD7nHA5GBaYVitPcTDxtX4pBmP9SdLXJ3bs9Zy3T8Mcuc2k8PdjjQwyJ5DtK830c9HTO6aLZ5JKvMNTkpG30KZwZsi1p5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231785; c=relaxed/simple;
	bh=y6+fLLQ7kbH+0CzU5m2E0zr82FtMW+14mkUqDwtuBgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SClKFLV8XctSSkCu4GApFatM7OrtJtks5T6HhoLWZE4hrqvhqRWZl7lnsCryz7iEtFW30j+U3Qo3OvG5ftmbFIBk5ySCmU1CNwebVgs4wR4T2/Iz828AfVheOrkWRVg0j0SZ0uf4mtDXv5FgK77Fz8vwAmVmmDggNj1IHGO7L5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePmGmhB1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePmGmhB1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2242ac37caeso9085ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742231783; x=1742836583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfFvXsXXQ4EwlZ+MVnsfd4i68TdMbHdFmvhxBUmT1PY=;
        b=ePmGmhB1uKNtuXQYhldQphoFZOkE7v9H9pgnT+SuGwLzzGvJmpDJ7NpdnEPMBeFD9f
         /eXbdWbyZExF0FhHz2NEBzuhr0vWEfb0n0qtKKF5BA9NZeuGHIT/9nSuDj6825oao94L
         C8+EqVtGvfovKmAIfwQp4FHWXeQ3vnZvrTcu/mH6C0HrlOJZ5iPNNXyxk/gg/FoaAVQT
         By9Rf7VNpwXbHt70fFNdM7mk7lFvnKV418JkisPm8ELeRBYUF+N+5VeAXkSQQO0dpCYe
         VJflBM+h+a5lLmEqVW6fBnkJ1bySyPW9cruMx06RLN89pmQq3Ur68ifMDyTxXuU5nAwj
         K7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231783; x=1742836583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfFvXsXXQ4EwlZ+MVnsfd4i68TdMbHdFmvhxBUmT1PY=;
        b=n40ihjCjTjb6FcRu5wNkK27UqYeQNuwCLq1mDrF/4FpdJvLRgxWuyMzJ7g5sb2s2XW
         /UpMPBc4Zt6BpIKs5gmyJ7RgqPMguAvW42WXUTfdfQcIUA5fnf05Aj84LPp2ZDYVA7Qp
         32wFh3PZZ2HnfEQFzOYm8rOF8cVellbcTVPvImQos0FHp9YNiRBVHMVN52bZDYy0vl5g
         LGeeTFY0NvocsKkMJQBM/T/eL6eK53kY8xMcx5FgEtXEUJ1PKqI+sG67hs27twe+ynta
         3SSc/L9kedgsFlibNDbM5LbcmNWf6579wPqXv/MeIsBRzGxkbjgnbWUf+N7Cam4G8x4e
         WjeA==
X-Forwarded-Encrypted: i=1; AJvYcCXj4JOP38kvLf/vmBOMS24vP+XkYXTQGGGpSZJD5knxdAKKJ5fZbHHPkBT5CTqleArjM2DeF8m1khXBwi3oEq0m@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVhHN0CNybGKqmm2huKH+IeC3pJwn0HvlNQdKlIkYiexXTC3w
	aIdd+rYD2neIHhiYjKbj0zjGfi4vP0A8Gtl5RNZxUWGcol4IjgRaDKtWKmcu+BhVglhgJvwEPaX
	HUZxjWlWrgtkflU7RX/YWditzYr8PY7v4WIdb
X-Gm-Gg: ASbGncvbXn1xcyU+zk5HcrD5OmY+hXazUHG8we+ls7s2gmJx5hWQoejMrSVlffhb7cW
	eiUsCxkxic/ikeL2Pt0l8SjGG5JMQphtAE/gKaV6geXBeOYUJcAQ/OT+gECAojh9L3X9DieUGM/
	elABvdyE9iyJLavYojI/j2ms8FcyufontphP2x6p1vW8cNuzBof89p9IE=
X-Google-Smtp-Source: AGHT+IFhZ062stJ/0U82tGKw9QwiiDMz/O63ruW8fttZu4gPEgpShZspW4XGSrAF3kxnv/LvZFzzf24xhBBDXgeBowk=
X-Received: by 2002:a17:903:2441:b0:20c:f40e:6ec3 with SMTP id
 d9443c01a7336-225f3eb1adbmr4633195ad.22.1742231783195; Mon, 17 Mar 2025
 10:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzpfAUi8zeiFOp@x1> <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>
 <Z9hWqwvNQO0GqH09@google.com>
In-Reply-To: <Z9hWqwvNQO0GqH09@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 10:16:11 -0700
X-Gm-Features: AQ5f1Jp2d5UNDltp-P8jxNkRsUA61xne765QTZDlm7pFAHdCAdLEjY7qowx3yLY
Message-ID: <CAP-5=fWCWD5Rq5RR7NSMxrxmc1SUkK=8gg+D-JxGOgaHA7_WBA@mail.gmail.com>
Subject: Re: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-devel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:06=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Mon, Mar 17, 2025 at 09:10:29AM -0700, Ian Rogers wrote:
> > On Wed, Dec 11, 2024 at 7:45=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > We have a tools/build/feature/test-all.c that has the most common set=
 of
> > > features that perf uses and are expected to have its development file=
s
> > > available when building perf.
> > >
> > > When we made libwunwind opt-in we forgot to remove them from the list=
 of
> > > features that are assumed to be available when test-all.c builds, rem=
ove
> > > them.
> > >
> > > Before this patch:
> > >
> > >   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=3D/tmp/b feat=
ure-dump ; grep feature-libunwind-aarch64=3D /tmp/b/FEATURE-DUMP
> > >   feature-libunwind-aarch64=3D1
> > >   $
> > >
> > > Even tho this not being test built and those header files being
> > > available:
> > >
> > >   $ head -5 tools/build/feature/test-libunwind-aarch64.c
> > >   // SPDX-License-Identifier: GPL-2.0
> > >   #include <libunwind-aarch64.h>
> > >   #include <stdlib.h>
> > >
> > >   extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
> > >   $
> > >
> > > After this patch:
> > >
> > >   $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
> > >   $
> > >
> > > Now an audit on what is being enabled when test-all.c builds will be
> > > performed.
> > >
> > > Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind d=
evel files by default")
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: James Clark <james.clark@linaro.org>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Sorry for the delay on this.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks for the review, but I think this part is used by other tools like
> BPF and tracing.  It'd be nice to get reviews from them.

Sgtm. The patch hasn't had attention for 3 months. A quick grep for
"unwind" and "UNW_" shows only use in perf and the feature tests.

Thanks,
Ian
