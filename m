Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1841221F13
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758233834; cv=none; b=VfKDoGwCkIZVSn4MduwhJTvAGcdlGbObbw61Q9i1T3zx4Fb3wEJPxhCyASHTOIO683zYHbJS7gPPjGXmi0xk/4gH5IUVO/jGU4C/2kAyrSsDpU58avGO7OtaTF4PQr+wxmdYBhK/QUpgMPTHnZy0kyLOhdNlWHjaNCIY7mhX5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758233834; c=relaxed/simple;
	bh=1C/WMJKtQo8vzjAl5JZcM50zVvLPXUychaLZR0QYI08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dO+jQq9VRIVUVrUk8sMcP8TgyZd2WciUdr8y7IO22+tGp/3u7TPWSfk1YgnttK9KA9F559ne2RHWx+CstgIrulM0TeWUZP/c6J8rUIOj5lnR7Wdlf7u1oMw92959KVmybuE3KdqfnXEI+oEAU7yg7/vQQ+wXth+aS3AowRxDsnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1099Bmz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1099Bmz"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-265f460ae7bso68155ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Sep 2025 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758233832; x=1758838632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmko3OvS/9l5ycWqvjfswt2mLUvFiSKmiO9akP2jwm0=;
        b=H1099BmzFl2MSvyZWo9+6MXv9e0OYXdkKHkuVhciK8L0xjqc0z8LWA/jUxibb35VC7
         G339Gt6SmpvYrtjyYZXeK2kGy8CS7CI96kjWtOpd4agy4AN4/qRc3ycXjnf6iS/ke3sa
         n+r2Gia3jl1W6W/UinlioRKM3t1LJPZkWRrUOg6H6Bs/hnPJpqfK1RoMXRmkftrRpExd
         nOp5/emScteqprYpg3auL3Rqy051n8boOU1drWZZElVtB9j+p3A9OA/+2Cu3BaPAmjbA
         5xbMp1bzDAOXmKEpspkfdfcc6mGDNQgYhzmPxYO1PEImDYnINrTslEaVLzAGcRvl25dp
         oK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758233832; x=1758838632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmko3OvS/9l5ycWqvjfswt2mLUvFiSKmiO9akP2jwm0=;
        b=jKLMknqaEP3+qOtjjE89fuczptQeJrGSzEjEiFRNfr1qRg1nG7xFTPm/Mk5osnwZhf
         7YzMJnsKgzCKW1+I1V8Tg7CN/aTqxeewzytCT/5A04NncOesFT+6DQ3h7aRX7gojdMJm
         K+hKAyXf69/o+cwXE0T5mIMnltpwCMUoWFx9iG58Z2p8vWeaR9bNBw9M8CTVdEZWclKQ
         0IYBfFZcEcX/hpTZ/Tl1aYjfXycFVm1mhNrKyChmtCstvceZ15iGrVDcAM9ZzTxNpzLM
         vR8XC38eZVMvEC4I8RKOUdsIXOzwyzkPPGYlFyRilppCKDBHuAbYccg2Jx9kZPdmsU6p
         N1jw==
X-Forwarded-Encrypted: i=1; AJvYcCUifu/z+fo0qU4KpObg0xeOUm20zHiOk/a2o6iOY+NG3XIgFodsP8Wzd13TpDK7oP4P0Iei0uirhBSFNccBYDEZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EUCUuWMjkq8cyI0u1ypZTuBAj25jPRaxfHMq0Yt42sGD6BzT
	djDU62BB4KAdLAmCg0G1hrrmickTZxRecoOB1qgQ0vFJGHgzV5d6A94MlFBTROJ74SwNhy8saEA
	8Rw2tpVjfW9fWpQBTMOUtZPYKnoeLsu1GHpVV1JPe
X-Gm-Gg: ASbGnctVoaU2Mb0crm3X8VOfTD/owz6n9lnrGgp+clIlVyTtsxV1lItDjDxyVAnmmes
	KIgqA85gupQWXqpVv9jQwgoM+9XyLn3ms9vAqdMDncayX6ehoq0jmKXKZ/7LpI2ZjJS5bqk3NYF
	xonvx9JCKEBfSjI0CCEQ7gE/6jAFrpkWFMrJhPiiQoGbLyeMLEz8chHaKKZHtQk5aPaDIcENqlp
	jBq/6qoMrsIMQuXytmltnTqYY1o/k2WtgCaJR/RvulUy1TNg9KDAZROc+oANJg=
X-Google-Smtp-Source: AGHT+IGgbBpI5qfORq2LydVT4KdkKDxeESDMGfCybkmCA3dakv8bYWdY0l9Cqq1QKiqR1zDDrnK3kjymczMB4bEfFCA=
X-Received: by 2002:a17:903:183:b0:249:1f6b:324c with SMTP id
 d9443c01a7336-26808af17c3mr12784375ad.13.1758233831580; Thu, 18 Sep 2025
 15:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821221834.1312002-1-irogers@google.com> <20250821221834.1312002-3-irogers@google.com>
 <aMm0qUcdeDJmwuyI@x1> <CAP-5=fU8NXY+mbnkmhq15yncXx0TxE7Zc1zu23o+d+3ZyXjSjA@mail.gmail.com>
 <aMoJkR_jtzrGCLKI@x1>
In-Reply-To: <aMoJkR_jtzrGCLKI@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Sep 2025 15:17:00 -0700
X-Gm-Features: AS18NWDkdqKrS8HuhxoDI1eQwC7VATGeZjvnERNh3_-dJXnsBswabed7Jr9O_GA
Message-ID: <CAP-5=fWKu1y=7k9+1z5sbxLO25M88OGW_641F1Jg+AZWS51AKA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf test: Don't leak workload gopipe in PERF_RECORD_*
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:06=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Sep 16, 2025 at 12:08:58PM -0700, Ian Rogers wrote:
> > On Tue, Sep 16, 2025 at 12:04=E2=80=AFPM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > On Thu, Aug 21, 2025 at 03:18:32PM -0700, Ian Rogers wrote:
> > > > The test starts a workload and then opens events. If the events fai=
l
> > > > to open, for example because of perf_event_paranoid, the gopipe of =
the
> > > > workload is leaked and the file descriptor leak check fails when th=
e
> > > > test exits. To avoid this cancel the workload when opening the even=
ts
> > > > fails.
>
> > > > Before:
> > > > ```
> > > > $ perf test -vv 7
> > > >   7: PERF_RECORD_* events & perf_sample fields:
> > > > --- start ---
>
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ patch -p1 < b
> > > patching file tools/perf/tests/perf-record.c
> > > Hunk #1 succeeded at 130 (offset 15 lines).
> > > Hunk #2 succeeded at 142 with fuzz 1 (offset 15 lines).
> > > Hunk #3 succeeded at 154 (offset 15 lines).
> > > Hunk #4 succeeded at 167 (offset 15 lines).
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ git log --oneline -5 tools/p=
erf/tests/perf-record.c
> > > 576bd7a8c90c48e9 (x1/perf-tools-next, x1/HEAD, five/perf-tools-next, =
five/HEAD) perf tests record: Update testcase to fix usage of affinity for =
machines with #CPUs > 1K
> > > b4c658d4d63d6149 perf target: Remove uid from target
> > > dc6d2bc2d893a878 perf sample: Make user_regs and intr_regs optional
> > > fd8d5a3b076c033f perf tests: Add missing event.h include
> > > 9823147da6c893d9 perf tools: Move 'struct perf_sample' to a separate =
header file to disentangle headers
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> > > Can you please check that it is still ok?
>
> > > I processed the first in the series and now I'm going thru the other
> > > two.
>
> > Thanks Arnaldo! I'm not seeing the patch on:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/log/?h=3Dtmp.perf-tools-next
>
> Sorry, I thought I had pushed it earlier, should be there now.
>
> > I'm happy to check.
>
> Thanks!

Not seeing it, but I see the first patch. In any case I'll rebase and
send as a v2.

Thanks,
Ian

> - Arnaldo
