Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC881B87CC
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991776; cv=none; b=GQgRFFVdF9LGst8Y0LQSD5PtG3rTgIWfWNBpFva1Ijjo2vkQhVYTA/aHZBhyC79KHlZAZ/l6atB8iL4zUlwR+jzgJSOwvYBBk2j5xvZ0rKyb1pZ+GOTc0OFJ3BgT2FTOpETlxkoeYV6IJhvf0Jzf/GlznCfZAfRr5pt8gpS/6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991776; c=relaxed/simple;
	bh=xqCqR/hufhb5P8/CLi7BzLgbexyw/GGhmOMSc6YxdVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NHrZdJusmsL0UmYNQHCaMxYfaM+aluGXOd4o1xxmZUDpvuFd/pRGGQFIAWd4I9fRS1eGtveByiLRlH6vnuKE9nMwTzCf48CgPlqzEOg77G+GbSrOyklrktgwUwlUPf82vsfKBqbIFBsY1HmsboJiFAmkzFzYnpkoCdxuV8JWBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GuSu2DcH; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GuSu2DcH"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so14265ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 11:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739991773; x=1740596573; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqCqR/hufhb5P8/CLi7BzLgbexyw/GGhmOMSc6YxdVA=;
        b=GuSu2DcHnkPqOPuI51GdTuhRJWIOuRFR8z7JBtf+mrOCFAOKH+uurXURgXHI3tXEdo
         Rqu443aZNwn5GUz4h6jzokPcuBY5OFh3sjbpQCRLp97X2COi+q4I6F6eFd5DvFIJ0cnf
         GaEnZ8mbcEAgaPt7LvTzBfFHcb8t/tfNVe7dMOMswp/0gNtTN5O0XMX6QYAB4uSEuwRx
         FS1s1CppzNEOmsepLs3726/CPLAJgHukkuS/HkzZvrEApKRN2PAZtq1MhnhooI6D7Ehb
         nBmNP83ArDm2HxlR8HxaNlyp4QerB4N7a094IqBzap7wixOTkpf9e0FdSjPFAyGTRS94
         JKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739991773; x=1740596573;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqCqR/hufhb5P8/CLi7BzLgbexyw/GGhmOMSc6YxdVA=;
        b=i/qWovtgIC3+pVvXu3AhIshObo5xkh17A3NmlRnSmknPX7HBseNKZ4bRemaCBsJrRz
         V4FgGlRfRIYJUv6+5nDJ6oKDRf2ylv6FlStCqgcINi4WHPmcZy/4GuNJVRbpCsIcG41E
         Kx1xl611QoxotWUrvK0xeZ3fId3MouUnGLd+y5cHyNtXEFbyiMOnZrHfQR66NFC1chHW
         ZAq+PfF8qCMUu2srDutGuIZFUKUdD31p0GUE9gu6FZF7+5zbW/KTGCCwsZFbodA1NhsW
         Fxebzz9uEskfryeQfEO1aABylmQmTWBEtm4XknJQyw+pelJ28JBZavF/tc7iCl954doT
         a4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI2SiCb/c9fJBVm1/NNK7iaCUByOmWbA57Jl1VccRQ/UYH6LurwGbA1hdZbzF66JCeZ5U0UfwbYWEW8fXQKu8t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TsDcqKIXxpH0dG7MHQiDDs0Bb9Hum7/VFszPj4LUjVJ0teNT
	doJ/9GnpjVoGLywFOlj9JJhAlz7ubShJ4eEMo1f/TZDEijLDgrtm4SHQQapPr1JFHskOeJCuI05
	prdJs8KUiTAUdfMZEiQdULQEU1h03FlMX67OD
X-Gm-Gg: ASbGnctIVdXCew34SCK1EEZqJ4OR4qAprsOQgHQV9J7PxI4U5Qk3Ts5WjmFSlSDX+/b
	B+ayrXi47IWV+iUqh0FH8Nw1Ch37IkBU5AlbfiUnkcYLvTsyZl3jnaPBl+BMLzrL69426qrpwrg
	zlhTCzNEAMLJRZk/E8ETuYjwpHQw==
X-Google-Smtp-Source: AGHT+IFTTa9BmF/cvrRnLMexuFSYqNhnGoLFlnoL7/Nc/YaDz0GVAvlFhZqtew98n6t59Vt1hUPih85IrbvbGbZZDxs=
X-Received: by 2002:a92:c56e:0:b0:3cf:fbc9:5c10 with SMTP id
 e9e14a558f8ab-3d2c0b75e6fmr148655ab.26.1739991773534; Wed, 19 Feb 2025
 11:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109175401.161340-1-irogers@google.com> <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
In-Reply-To: <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 11:02:40 -0800
X-Gm-Features: AWEUYZkGjeOagc7NGuKyV-tf79xYdyrj45f5ezlrCbEQXR619UXdXuxCSPih_AY
Message-ID: <CAP-5=fWZAk7XqtL+=CanefkuFxhDsJ22+-uHkrxXi4g8123oew@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Tidy name token matching
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:23=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Jan 9, 2025 at 9:54=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PMUs
> > before parsing") names (generally event names) excluded hyphen (minus)
> > symbols as the formation of legacy names with hyphens was handled in
> > the yacc code. That commit allowed hyphens supposedly making
> > name_minus unnecessary. However, changing name_minus to name has
> > issues in the term config tokens as then name ends up having priority
> > over numbers and name allows matching numbers since commit
> > 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with digits
> > "). It is also permissable for a name to match with a colon (':') in
> > it when its in a config term list. To address this rename name_minus
> > to term_name, make the pattern match name's except for the colon, add
> > number matching into the config term region with a higher priority
> > than name matching. This addresses an inconsistency and allows greater
> > matching for names inside of term lists, for example, they may start
> > with a number.
> >
> > Rename name_tag to quoted_name and update comments and helper
> > functions to avoid str detecting quoted strings which was already done
> > by the lexer.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ping. This patch addresses name parsing inconsistencies, in particular
> events may start with a number without a PMU, but not with. It also
> aims to give better names to patterns than name_minus and name_tag
> (with term_name and quoted_name respectively) that have drifted from
> their original meaning and become to me less than intention revealing.

Ping.

Thanks,
Ian
