Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CB396571
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904789; cv=pass; b=qpAg4DdkAsrqqW811du0tabWcAI3qDzlVxIHX1jDUGHuwPd0wywRQo2ALufLZTeSrMLRwAbeZ9DnTkR4fo8tUQFMkxKqnB3nnhNYDFp1G6nI+k0wxZmgnDxW+R9FHq8KQtoUFUzEEv968DRjEB9psi3khV2fVBsee11UGMpaKxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904789; c=relaxed/simple;
	bh=xtCmwZUKnAlgWaRtINjky+1FTQj2+Y4qNMKFvWFvbI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcQHPrkbb7w6QaRP3bMQVTYY9mbeVeYiv+lnsLx1b3FP/TlA2ETp4ahd8ylAcQWlL2Y542j7crq2SQ/1dovGtvHt8tpui1BMoNkZ6Pkbf10Fbsb9OpCXVvB22L2olemx7XYVdAo4If5p1OGAMlehWwNU0q1/7zsBEOsWOKo60f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKp4iw9p; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKp4iw9p"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0c12be0ecso33735ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 14:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774904787; cv=none;
        d=google.com; s=arc-20240605;
        b=lCwKjk0Qgd4p+a3X2cHIK4YCGSqQ8/g2Ki7gWiv9BJFUaicfKt0NK6AvfClwU8RK2o
         ELs6pdRtR9daiDyXjPrmAFnxoC4J7ht3paT+hZgo94IiLXELD9G2YF3srEUVirw5JPrf
         R/NQvdhdLkt+/8vEi7UKAIPb/AzOPhhSnStbi/sCN/8itU1c3e8DQ0mcahvQ3rbEfYsC
         yXefFSJ1oR4xYl7+7sHw8BCkoEz3ZsnWC0Tbwi+5gsBZsMPusrUuP/CaDOkjOx7ma1D0
         EJYcEWNt99LQ+yFQdtbePyYEyV/Yhm6gylkEq4M+sSTASZv17fyuYEGI+82nHAHQ1Mkb
         WLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NS3hc5DbXuMbFGaNpQ42lZuHnAM3mQMIhkcfDCjMsC8=;
        fh=3j1vW8UmERE03iYC+OycX2Br9tuOzCnkc0ewLPH7KCc=;
        b=GGvxpd6QlR63D2jz7z11iKRT5lJuQjv5858Yk333tMfo1LsK8XgsoDpSOuib2sZShH
         H0TnyC9niN1jfchTZ3euM+pmN10DmBaHKWo4lPYuH6OwqwwR7Bm+aC3rx8toEXABWeO0
         7WIlM63+2vT+dbperX+Yd104Dxx4ER8GMIMQa3VvNLfwN6Q2M12dqNuJissaPgL5lRYq
         4alTUBDHJwjiN91VU/jVy8c6RVcEHHm8WxHHw0hRLEpDx43CwYrBnzBHVr4pbYAiTNTE
         XFXQYLVF0ork0QnY5ZzuQ0RWrvFZ05KvjqmZ8c8yfUG2hEX+RP6fRuemRP5GrYjFHofE
         IMrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774904787; x=1775509587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS3hc5DbXuMbFGaNpQ42lZuHnAM3mQMIhkcfDCjMsC8=;
        b=ZKp4iw9p8yz41O6e+yROUhP4AG+2s38XkmBeyVHVFckKC6HRjgpNJlGWxjpK3hxrjH
         tP11P5a+IoUvoVNZd5shGsoKNOn2o3NbFs3XSkQycHihgoGBMkoUXlYGRh4zErHaBQ36
         D1ONNYF7cVWfR7uXD1AktqEvLiMYjoFz+p5i7sW7+XelZOgb4d7e/Vakp8SKMTlIr4wl
         X5f1f6JZBkzQYdI30kEDl1FfRISKIw2kzTCXN+9kiBrkRNUoufhW9zh6xgaPZlKclt5p
         pljRP57fgbWf2JjNaJgScCdRUQ97smnS58dL9dBgznUc/XCFoivH3oT78bkVKyJKsZat
         W9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774904787; x=1775509587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NS3hc5DbXuMbFGaNpQ42lZuHnAM3mQMIhkcfDCjMsC8=;
        b=h3gflOCywYl26FlirCQS/Q8ATo7PyD3j84dNkXcfOyMqTEgUA7vB0MEbsRMZolqhu/
         UwqF/qznOC/Mx1pxnjI+q/lelo2SUhZewI2GyCS3qA2tUpFKSJMHLoZUdUYrTlaWaghb
         UK1VZ0OkVSFW3VXQANjkt9g5uPbL9Lnbnmk0RGF20c/z+nAsekPy0OM31hJcDCom0T5r
         JrGZrJh61VCr6AiIg+ArlncsUiBpBY3GD4ZfGfKdvt0ol1OuoM+2NAX4j21SX2QJCZ7b
         Ldy5mu4SBZ/NpW+qR0ZsmDpBqmnic/fbw4BXf/BSP9kCWeY892QUzMOi/qDeV+mIAlS3
         EEfg==
X-Forwarded-Encrypted: i=1; AJvYcCVFLA8owbdUZ7ur8bxGQcw4RuQwAker7y8dmmDJBcLtGc9+Ita1ZRBBbLEBHjBkO5SCZijevT/FmXwzPvK3s9Bf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+BPx/hMGwiBvWkiEdOfk+sXkQqXjeikhpm/p3CbjPOPOTGmWU
	z6kJJG4GbPDXy6R6qigSFQIm4nEFjXvdqhJVXmKejV8oJr2zOyrS3AyQNhmNgMYkRZmkPLknK8X
	TrKSD63q/nsqZu8GP1XeBkMS1Y4vH4aKKXz2ZIO/b
X-Gm-Gg: ATEYQzxJnxS/66koG0T0li/uFOA6NHNM51wmoL+zVWLtmZ1tjdfk+FPR52feyCt13X1
	/WUmBNG0CYrVaPxxHWrAOyXhlMdnM62zOGXn0KaSBMnNYyL36lLNIBhDNEwtwTygWmig44/TT23
	Pw5EnDBpdKXy8znjDlDA/D++Z6htfIgO/jZlgUHQWFhSEUCyLBRQRtoNNT6DBO7I8BtXDkVe1WY
	VDwHI+VxFhevFqdQ0wUquiLAZWcTldHI51ioNIdT+FS8+mrAL3ybkxbTSsCz/Ni2wqoH9q05O/E
	E4GGaiQVvfysUQ4kUPCm1BiC9jX9+9Xs64ljjQ==
X-Received: by 2002:a17:903:22c3:b0:2ae:575b:2345 with SMTP id
 d9443c01a7336-2b2604d195fmr228995ad.9.1774904786516; Mon, 30 Mar 2026
 14:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330194021.212912-2-ashelat@redhat.com>
In-Reply-To: <20260330194021.212912-2-ashelat@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Mar 2026 14:06:15 -0700
X-Gm-Features: AQROBzCPa1ccy5DBZe1OZavzOardDUaV6u_HSEPJk3aai4XACNL2T8dtkgaHFUs
Message-ID: <CAP-5=fUvN=7ynEXju4jo6mWuajRRY0uC68SpUR8mTvXPqrgQTw@mail.gmail.com>
Subject: Re: [PATCH] perf dso: prevent null dsos from being added and add
 comparator checks
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 12:41=E2=80=AFPM Anubhav Shelat <ashelat@redhat.com=
> wrote:
>
> Currently comparator functions in dsos.c don't check if the dsos array
> entry contains a null value. This can lead to undefined behavior when
> doing the comparison. So add null checks to comparator functions. Also
> prevent __dsos__add from adding a null dso to the dso array.

Do you have a reproduction for this? The entries in the dsos array
should never be null, so the check is redundant. If this is
out-of-memory related the check in __dsos__add should suffice.

Thanks,
Ian

> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/util/dsos.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 0a7645c7fae7..fcfed7dd37ff 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -118,7 +118,12 @@ static int __dso__cmp_long_name(const char *long_nam=
e, const struct dso_id *id,
>  static int __dso__cmp_short_name(const char *short_name, const struct ds=
o_id *id,
>                                  const struct dso *b)
>  {
> -       int rc =3D strcmp(short_name, dso__short_name(b));
> +       int rc;
> +
> +       if (!b)
> +               return -1;
> +
> +       rc =3D strcmp(short_name, dso__short_name(b));
>         return rc ?: dso_id__cmp(id, dso__id_const(b));
>  }
>
> @@ -126,7 +131,16 @@ static int dsos__cmp_long_name_id_short_name(const v=
oid *va, const void *vb)
>  {
>         const struct dso *a =3D *((const struct dso **)va);
>         const struct dso *b =3D *((const struct dso **)vb);
> -       int rc =3D strcmp(dso__long_name(a), dso__long_name(b));
> +       int rc;
> +
> +       if (!a && !b)
> +               return 0;
> +       if (!a)
> +               return -1;
> +       if (!b)
> +               return 1;
> +
> +       rc =3D strcmp(dso__long_name(a), dso__long_name(b));
>
>         if (!rc) {
>                 rc =3D dso_id__cmp(dso__id_const(a), dso__id_const(b));
> @@ -146,6 +160,9 @@ static int dsos__cmp_key_long_name_id(const void *vke=
y, const void *vdso)
>         const struct dsos__key *key =3D vkey;
>         const struct dso *dso =3D *((const struct dso **)vdso);
>
> +       if (!dso)
> +               return -1;
> +
>         return __dso__cmp_long_name(key->long_name, key->id, dso);
>  }
>
> @@ -196,6 +213,9 @@ static struct dso *__dsos__find_by_longname_id(struct=
 dsos *dsos,
>
>  int __dsos__add(struct dsos *dsos, struct dso *dso)
>  {
> +       if (!dso)
> +               return -EINVAL;
> +
>         if (dsos->cnt =3D=3D dsos->allocated) {
>                 unsigned int to_allocate =3D 2;
>                 struct dso **temp;
> --
> 2.52.0
>
