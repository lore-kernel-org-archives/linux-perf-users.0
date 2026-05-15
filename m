Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1B35E1CC
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887677; cv=pass; b=Ncd9WSM5dip+leoNQGHo+Mz7IPvT/zswAkabVuXXXS3SmDVgO1ThoRNYbPeTJPkEwtl0HqrVXoxXShqU21fx8bUzSQ9kQZ5qpl+E+Ryh2m2wgW/xd7j3UwCFsLmvXaiHCliILwzz9izxzUlGZUSrHRqNy1i30yMbhwp1wWEms8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887677; c=relaxed/simple;
	bh=YwWC4WFrkmp2ONYjnJoQn8j2jErDcE/QFo/5x5YPLwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwiIK97Ey2lOu81ZZMrH0be8iKTZAtjgZydT0nBwxfZUY9qVPNGd6/AXfd3QjNKcfZupydE3keXwal767GkMEp1cvM3leSdHrZju69mG/A7WaYvagER4DHyo4mQ39aRlM86AVs1q8PJlmGjB2FoyyZvI2ulxcjlY0VlcvXL6wWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9yLbqKo; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9yLbqKo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so475ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 16:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778887675; cv=none;
        d=google.com; s=arc-20240605;
        b=lvp2THtwH4XT9wyEa7lMMFJqds71TORF6+ktTW7uhRr5QG8R8tEwW6AUr+hUVCQJ08
         uN+wK3DUs5D92gDSVvm8TRs8VXMr/dwlNTNDPn57KBypncN+MhAbL7yqWMOy8xvP7hPe
         Dy31yjPM2kum4lYOA/uGpInmXF22MbZckn7hPe3gDxVs1Y6rWUytI8CFDHMns/WDMPPZ
         /BP26rZTV18c3wsgWoh9TOygB83zsTJDLq6oXpc30tLWtXm+cOYzppwta+9eLU2y+5jU
         zv5VEGrgR9GkWmas5Tg6jUQ4bnKK1zPjfUYTDDZ2Nn+5EGxzMoZtoOw8OpszfPSEpbjd
         e/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XU6/qLMq0pTyP8x21lr53W/CjJX1qRINA5YR5iUfpIY=;
        fh=R5501XR4sg7u+GOi5YoTeIL/or78auoGZcT84EChpQQ=;
        b=DpK8HURxmckHafdwgtQsq72IwCsh9DS6VasUmVOdB5qv9QWDqrgXp9ZpHe1HpE4fz2
         E9K8NWIe71uPlkZTFdilyKXlkGANWQ2mgIyZHQGwUI7YtrgDjxOa5jnaD0b02VdHuQ4n
         pDCD8VwdgDD66FrXwK3ODYq+o8LpQ2Q2uaSQIdNUAtiiikTXJSEsalrXqwdrvKHDRLzS
         erRR14Ema7+Okdj9vM0OOS0puVMllduIwBotFaBgw5eJzMJJqW86LQbzGEgtIBi+GcRS
         oKkDsZmvmHZpJKYrbsDom008S34GPCLnVbtv+XCuYfozHYuEfNMjZmsdu20LgsFCIWIo
         qZQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778887675; x=1779492475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XU6/qLMq0pTyP8x21lr53W/CjJX1qRINA5YR5iUfpIY=;
        b=G9yLbqKofRAeoIhYzNvT+HnabE6pPgN6lrb58BSked20tQcEBWAubJy2ipACGMwcO7
         bfFqyDwKJA95jekdg8vCv0q61BZIPC0LP/VvZdmzVZtXcATpbbgVAo5IpdjONrgvdpBL
         eASTQujWok/U8SUcspWYMCKGKmL/3j8q8p6hNnxtCCPeU22+vnSZOm3mcYl1QUR6oEpI
         7rFUH7rMxXHneLthzUq34/Ey3zZCsu3WR0NChDi5WZNzjXGGvuEz5gHdcc6Jqtb08OnI
         PNx72xFwR7NXhP1KXIyAgV9haQyGyMtOq1kWPVryI/dKPUWzmo4f43hAOZKXgX03D0oV
         7hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887675; x=1779492475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XU6/qLMq0pTyP8x21lr53W/CjJX1qRINA5YR5iUfpIY=;
        b=Zo2dI0QRUtTkcq7UVQ1bWlDvNaWPuYYzyzI2PKHtehyP4yhCUD+qHW/IlgOiRaUKNj
         ZP61adWnHEaSyJIocxPsqonBNbNZs8e6TCEYprK80atNIWPIITlM6ddQDyrOwICcC4D3
         ISQLBjWu99sZaFoguD8NENcOTUJSS20AlOaG3MxnOMc4eTuUEya5zet5gjHU15pT+IC0
         PTMU7FY3YWvT+I9YQ3XyLhqLp7YHnshf0IdXqyR+2TAV8K+p2I0+cn+8mHxmkIG9vDUU
         ubqPvjjbGLw6Zy6gXkATqlfsCuEkltfy1GueGbofIGQ904JqQKoI0X2swf4bE+/ai5Rm
         Gpig==
X-Forwarded-Encrypted: i=1; AFNElJ9aEWUqzVMOqce7wgU31D6EcZKkp6launobggiz+XkNVuGqwbV+n8beTNpi9cTPmxjZULXp9JuSJQZz3vM51H3a@vger.kernel.org
X-Gm-Message-State: AOJu0YySC45GPMN11vVru95HCIryeEhjcRXQ+R0iH42aCgDhg7KXUt2e
	iEJdNyhLd0M9UcqScP2iTzS0nUgAsPiyEEvprEQOtcME99yf2aC9Y2moaA8oknAw+IKa8FeZQUl
	8ow2pGZ6CJiFlpwGCGRMR45/N3YKbOiApTs4FGuQFSs7yw5NlFxFlPbdv
X-Gm-Gg: Acq92OHEewNimjQvOfD0XL10F+O9xCm3OAZYD0qMyZIf5cgc160a6wUaBJwRksy6tpU
	oLM3M81Z03wDncVxxN6avNV35WvmXJ1RxybxhssUtlmiPwkNseaRxZqeb4sES9t0zcQtgXrYkiA
	UiG7u6vhmElahxUMwBKlFs0X1KD2OY5uZn199RJIQNtKOirC7pfc18XWHMnbykyIrUxBgeU1QGY
	/8Cyb6KSHztqSvvXcgL/UdmvekxHwDqpQyyIypx4cnxUcpuhwpj+ejmCbEayn6gbDLMnUgIzBVy
	QDqBn5fmBZAtK0huFrM=
X-Received: by 2002:a17:903:2312:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2bda0deeaffmr1117315ad.2.1778887674217; Fri, 15 May 2026
 16:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515193314.1593560-9-irogers@google.com> <20260515195302.B0AD5C2BCB0@smtp.kernel.org>
In-Reply-To: <20260515195302.B0AD5C2BCB0@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 16:27:42 -0700
X-Gm-Features: AVHnY4JgeNjpXX7_zw_F_IFv0Az7NoDc8QDwKILAiMbLPJlzNoJdyG58uLM06zg
Message-ID: <CAP-5=fVnZXqsoeh_4+uxHyyVeOer-zMiSTh-nbbihDR1HgEZig@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] perf build: Move libsymbol dependency out of
 prepare step
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:53=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Removing `$(LIBSYMBOL)` from the `prepare` step breaks the `make =
check` target and manual object file compilation (e.g., `make util/symbol.o=
`).
> --
>
> commit 6df47358116c567d6b28b1ca848835d2f69dc679
> Author: Ian Rogers <irogers@google.com>
>
> perf build: Move libsymbol dependency out of prepare step
>
> This commit moves the libsymbol dependency out of the prepare step and in=
to
> the dependencies for the bench and util libraries to reduce serialization
> during the build.
>
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 876065a02de6f..96a68723109fc 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
>
> [ ... ]
>
> > @@ -637,8 +637,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
> >       bpf-skel-prepare \
> >       $(LIBAPI) \
> >       $(LIBPERF) \
> > -     $(LIBSUBCMD) \
> > -     $(LIBSYMBOL)
> > +     $(LIBSUBCMD)
>
> Could removing $(LIBSYMBOL) from the prepare step introduce a regression =
for
> the make check target and manual object file compilation?
>
> Both the make check target and the generic object fallback rules, such as
> make util/symbol.o, depend exclusively on the prepare target:
>
> check: prepare
>         if sparse; \
> ...
>
> $(OUTPUT)%.o: %.c prepare FORCE
>         $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3D$(buil=
d-dir) $@
>
> Previously, prepare triggered the $(LIBSYMBOL) target, which installed
> required libsymbol headers like <symbol/kallsyms.h>.
>
> By removing this dependency, are we no longer guaranteed to have the
> necessary headers installed when running make check or manually building
> object files from a clean tree?
>
> It appears this could cause them to fail with a 'No such file or director=
y'
> error when processing files that include libsymbol headers.

It would, so the user shouldn't do this, they should just use regular
targets like "all" or build these targets incrementally after running
an "all" build. Putting the target on these rules would be equivalent
to putting it back in the prepare step.

Thanks,
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515193314.15=
93560-1-irogers@google.com?part=3D8
