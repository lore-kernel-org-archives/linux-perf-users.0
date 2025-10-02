Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153619C569
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418481; cv=none; b=skG7gYhZ7NJxRnMXA2KIGW4udDowipvA3sOEKzUia+Dt92UCGD52s0o1A3kRZiWHniZtkVFHOUtyFTkbICuDpL0gl/Olwvq3cg0wumQwdfgHpoKgOEUGwWvbrlXi7uWTQFRvOBJS/11V9089oATAYMmqtsnalhCQw8XVxYEAKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418481; c=relaxed/simple;
	bh=au0L0L5y1Va8qmlbtxSp7z32qjebxGENjTcKRT+huE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teGZ3MyLaapzNdlKJhCXqeeY1iNmga1T6IJaDWmR1gSNTtdovZPqInv6lOaiLcukWc0hYteBOi3XpcPopvRd5n+LxpKkDf7rPWeZ8fWR+lJ9pvhPs/ch/7aw70QfocXOSfiUpn9yJbeR8RL/kohvKdFbCSBVsgiig3OKAlEDt34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVCkjtH7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVCkjtH7"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d67abd215so227155ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759418480; x=1760023280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzuD0Qbpcsv+bB7o0y2z3UTAxu+Q+U8P/zH57agUqr0=;
        b=mVCkjtH7bB0qQcEEd0z+KSdSCYOneexJwUTHNHhjPtCPNMhVv530Jl1KnGoYzbTkDJ
         IHqc8kfNsjTq8txZXfiIjKh4b4EUeaD0k1EU5+hQbpis2jyJaPLjUmrB3jPVHMZ7rC2z
         dUhAc5L9UHxJKmXL9UAsW6U5g+J0r7YB3XIkjkPNx4uaYxkrZ2xMmL3yhAknSghiTOZz
         oiWRYV0GuzB3XTm8Ie0513rLicaecsCUEDYybcUNxlsg7woqne02iwDlD7TdWiWtEyWI
         TfIuH9UrRFRUiBD2eJ4nbnHlr8I4zXoJkHovCaSCGKSoljRhnGPWKiyLHmh5belU+eq6
         cX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418480; x=1760023280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzuD0Qbpcsv+bB7o0y2z3UTAxu+Q+U8P/zH57agUqr0=;
        b=D2IItUi6v4cELZgopXT7AY7m604H0kSOQA8fZnk2kAk9fXS/ONAyfijtChAt3whr+6
         y68g1XJTXdZVBZNAvMZt64CILrAAmCrnJKjGF1qBMBOfgpfhNWsmyVmMWmKVk4J2mdEW
         vjCQjvGqCCUiWtM4FhAbe+fzw51lFm3iW51WCIRAw6yM3s5kiUg4HdIPuTtRCbBqcpfP
         Z0BIiuh/mOTPX9Q91X+/sHux73ENlJ+8pqoj/ftelwU85TgxYjWVjDm5Gyby+BZHGrV7
         tpit/oJTCWbma9++ndBxhXNSYXYjAHQu/CVFPIlmc+5X17RPagCAmr5wWDIj1TpT6GQm
         5V7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUglxIiVgZzCG8law2ZcP9QKYbxCZvLXYteV/zdhEbWgcLgEgkAwdQWCXcJz723VUOAgN3VcAkW5ot48v/DnBpK@vger.kernel.org
X-Gm-Message-State: AOJu0YzED7BBX04GDtkmQRTIarynegongWYwS6M4kbo1G3txjvdf292r
	PX9o7Dqzwsez7k6eHu+6DcfKfYswW8jb2y2qArprUXr8vjcsED2jy4f1M9KYTWYF0MP8zI+LmR6
	1GeHpS1sJRREXwr3B3DyiokquRZZwZ4khzA/3ILlu
X-Gm-Gg: ASbGncthz6zGaj0ghqqGCaDFuah3fGO1eVN+mqhuV+FJnKrtRmuF8jHJy7vt7i+QAyn
	QbcadxgH20sYCjESFVos1U77n1gEiBVlcj2Az9RzdF3rV4T5pFxbqO6fMzfbbcFblkqRILxntK7
	ztOyzETIkE0QgNx7gs2/HyXJ5rFs53z7hNxPjwrNxojZZIIHXbkE/1YKdBwilER6zCXVnmeaA+s
	+RDl6B6dszetzuStzhBtu1Rx2kchkVbZqDNl678bMP+1l7gqW5kUp2E03nyR1Wh7M3V
X-Google-Smtp-Source: AGHT+IGPDOrxe5jkTqdZP2fGXdmC5UXMtH86TTeBanybD5T6KXcL/otW1ZKqETuBaYFxoV+HYe1rpuQvvash/vcmxJM=
X-Received: by 2002:a17:903:2311:b0:261:83d2:9d91 with SMTP id
 d9443c01a7336-28e8ea94067mr4001035ad.15.1759418479089; Thu, 02 Oct 2025
 08:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN54leQ54ozcUXBO@x1> <CAP4=nvSekQeTZvxLdajCp8FH2Xva1eN4=a8XhXODR9TMHKK3+w@mail.gmail.com>
In-Reply-To: <CAP4=nvSekQeTZvxLdajCp8FH2Xva1eN4=a8XhXODR9TMHKK3+w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Oct 2025 08:21:08 -0700
X-Gm-Features: AS18NWD-KWXKQwTjwoUcQOpcNDl34rotcBCKuH03fCgN2iki8OY_tRBPChx1Sgo
Message-ID: <CAP-5=fUfBzUTOJG7t7nwvZkcf+LKVakGnNqgVLSW8CjsLxFkDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools build: Don't assume libtracefs-devel is always available
To: Tomas Glozar <tglozar@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 7:13=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> wr=
ote:
>
> =C4=8Dt 2. 10. 2025 v 15:05 odes=C3=ADlatel Arnaldo Carvalho de Melo
> <acme@kernel.org> napsal:
> >
> > perf doesn't use libtracefs and so it doesn't make sense to assume it i=
s
> > always available when building test-all.bin, defeating the feature chec=
k
> > speedup it provides.
> >
> > The other tools/build/ users such as rtla, rv, etc call $(feature_check
> > libtracefs) to check its availability instead of using the test-all.bin
> > mechanism, stopping the build and asking for libtracefs-devel to be
> > installed.
> >
> > Noticed after applying Ian Roger's removal unused libtracefs
> > configuration in tools/perf/.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Gabriele Monaco <gmonaco@redhat.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tomas Glozar <tglozar@redhat.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Acked-by: Tomas Glozar <tglozar@redhat.com>
>
> Perhaps it would also make sense to clarify in a comment that
> test-all.c is to speed up perf build rather than rv, rtla etc. (which
> don't use most of the dependencies listed there)?

There's a big comment in Makefile.feature:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/build/Makefile.feature#n24
I think that FEATURE_TESTS_BASIC tests are covered by test-all.c so I
think this change needs to remove libtracefs from FEATURE_TESTS_BASIC
otherwise  $(feature-libtracefs) will evaluate to 1 even though no
libtracefs testing has been performed. We can't just remove the
tracefs feature test as there are dependencies in rv, rtla, etc.

Thanks,
Ian
