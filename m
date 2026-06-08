Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F42A39D6FD
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955996; cv=pass; b=kpAO8dX9CgipxDz7S1gzQlL3e75lF60Q/Jm2jcacLh34t98AhXd5zUUSj3KAzACP+i2I0+T+R5O10zWf8obhcxkSbOyxFs6T6FXD2KJb7AFDXVuT5Pgyc8iMfFuZAzyzzGeelLubiXdm7NHu3UQoVfNJkWQf57E4dG6RTlVDbRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955996; c=relaxed/simple;
	bh=39IillHuuUud5ciJ4bhNqpZoiCXzxriIs8Io3wb/xIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKEaMPsbwT8W+eAz5GuT/O/zvExcD0kz/T1wW4cMv3Qc1vc9mecMGUZbwVFeAxeEMT09Lz0SOqfeaMpotnu0VfE1uQObtIv7wQRACiu9yr48lu7O5hdmCCNZxbwbm+hSQBrHTqXWCq/NVvRWiXFUs6PNii1iQsIDu5krTpK5BzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ckxf5PHZ; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ckxf5PHZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf2d865383so371025ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 14:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780955995; cv=none;
        d=google.com; s=arc-20240605;
        b=MrpQxfijJBRkXXi6rh5EriBmJO6xOPjgaf3BzlUq0grZVl4vY5arDrB+oSUIICLDi+
         6dtuZXD5Kz+HEv4vxz8rhDOWSfnCqeWyhqLrvv5PhQHwVd6VxpfcHVwnqFTTyYj0YzgL
         5dHJ7iAiKq5krocSBcE0mY/bJz5lIdBrMiiQAKmI7EB/Ee5z+M8iho3tgNp6/2/PG84f
         Xj5Go2eyS/wo4Y6JI3weCXOrgRM2GijJNGJwphOSfX/l5heiH6EcxEBR117nWrDMpAtN
         UJAeDnzMIcvWGpClxvASmK6ZueV5x22SDgH7RXr+YlCOr9chrCtnICSq0rb/tsXLeLof
         FTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wg/eM7jA9ClKRBiTabWiPAV6wD7lI+wkjLUQ4TT26c0=;
        fh=vFoqEQqrBgzyHD9iRv+r+6meQ+HDXD5XPONPsnfuNuM=;
        b=QfA6yKG5RjI0Es78QcyUqJNUyis8mIEzvmsxErCHkA/9dd082rTPRYK4Upp528LdVt
         naayg1uZuTBRPtIr3+1OpCYygGNuIb6UWr+iMfLhJAsHrXB02P7ibDtMW4EjIQVAoZBG
         cEq6PH3NgOGi53LSqknKucT67rv7aYrGoJpUfMX0R19vQGpWwoHgqvVuLOcn3tvn4wK9
         /uCLX9hpAwClTzeaFyRHGseYVvNeNGHtlXi7Jv9Y4pywxs6BimgYTMYxtHBFR0Ns+rGV
         dZlFhjO0AZDpWstnNV/k79ZaSuNxMVLXSbhvYD4XCNiU4Z6nldb05tkF+TCkdx55YM/W
         3SEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780955995; x=1781560795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg/eM7jA9ClKRBiTabWiPAV6wD7lI+wkjLUQ4TT26c0=;
        b=Ckxf5PHZipfY1pAtHpwk+JvX+TbKKxdFzLt5ZQTiaZHxjvUiuvq4HfJuFFwCwEdCZp
         dPx/1rlMP37oplWEzVUajkfVINtBlcRl/KpBrgUFIDHi0eU5f8a3OKq9+ay1U7rXdXom
         whRqkspxLtIGN54WRA+M1r5X/cBclSaabxXxvenp5MuSgAoXq+QqaAHWTzR/kw8Ytxtm
         uRRXhgsK1bCoUkRDqwUSKnCl4peeE0C5OcwyeBkXnExCNyEORM/0r2GCWCzQdx8JEZhU
         N3CuUwW0AwuMdN2GzxM8YQNcZsDcFjO3v2l3jxMvYuJ7BkOlYIdCsqyIHO+0AsEe5vLu
         1qXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955995; x=1781560795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wg/eM7jA9ClKRBiTabWiPAV6wD7lI+wkjLUQ4TT26c0=;
        b=n/wAickUmxVJCdNQulGLAi/BztOwG+N2xv1JH7BTFp3OuSRKSs5pO7tVpJ53F0WC7R
         BGhHt4W3YWWak1n2luvbY/mKY1KMYZaof79Su+PGIzJ1rKYXExJlf6lRC93s6fJJiQND
         f3yIMAemjnB9v+b4RR1E9kkSECiiz3EId9uaAAXeMSBfHjv74ntx1QoaL5xf9KZX5c4t
         1mqrjn2pFFw5ZqPTMK+B0z1w9j1m7oFIjczsvwIi4Du7bSSEGTZMjUWgpqEwRtXlUlCy
         v68eSTtgxyOFHcs06No0hMu8z9BCRyY4qhqfNamYw2WTwFQdwSum6xv7h0mnFHikZcwR
         hUIg==
X-Forwarded-Encrypted: i=1; AFNElJ/Tzf2kL+NqBFJULEkk/aPITGWcHA/D/GyQe/ogHjR3uNl1ww5X8o8WcPEpbW/ojC8wt98gsI0ncBYXdxVVs5KH@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzVPcFwXVmPRulr2swVAvew8ESh1c7J5vmEkn7zi51mBGUEz7
	wvT/IN84yr5lkUy3bjp/OWVGm2yQNO9hk3SuLXxZFw2NUH4eUwMoxC5B0uUNV5euDq66T/i9EqS
	/HNHae5uUXJoI99MX5+n7mjvu0In/eDFxg2ErJy2r
X-Gm-Gg: Acq92OF+ap6ejdVIJ+IcxH+03sZCdi1yvyv02rFC2K1JHBjaZSUM0R1FqoHaJCakReT
	cgV2DV02YKk4vSgjqf9TZuReYWfiGew6iv3TFhxLys4ypcGLMiL/mHOX3NiqRDMRZhpHNDogcSj
	d9bsKLl1S/0AQ+CtcuPlagmXb5fMcwhQb96IygLYPfAEMWPXlTrAm9kwN/ATU69wg9Do7YjkyTu
	g0eTns9kgtyLm39UBtPjheqOfo5aJJTbeolbANA6Ge0+Yc9ioJEB5RAyzvix0mrRl/YTXi4RuFh
	hJ9kdWqimh2wt1xaMq1s75YlorGaBpq3KSdxECxmTlQ+ZelW
X-Received: by 2002:a17:903:2309:b0:2c1:ee6e:be1d with SMTP id
 d9443c01a7336-2c1ee6ec5camr5324315ad.27.1780955994403; Mon, 08 Jun 2026
 14:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-1-acme@kernel.org> <20260608201753.1979464-7-acme@kernel.org>
In-Reply-To: <20260608201753.1979464-7-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 14:59:43 -0700
X-Gm-Features: AVVi8CfgdslsnawBXI0Uyz-H0_rw_jqpccm3w3Gwdbxcvd8DHDtsnpYZhnVhPEo
Message-ID: <CAP-5=fVv60k=uGJBiGN=pd0-aj3MWkehEAMep3V62E8EzeoG-Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] perf sched: Fix idle-hist callchain display using
 wrong rb_first variant
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> timehist_print_idlehist_callchain() calls rb_first_cached() on
> sorted_root, but the sort function (callchain_param.sort) populates it
> via rb_insert_color() on the plain rb_root member =E2=80=94 not the cache=
d
> variant.  This means rb_leftmost is never set, so rb_first_cached()
> always returns NULL and the entire callchain summary is silently
> dropped from --idle-hist output.
>
> The original code in ba957ebb54893aca ("perf sched timehist: Show
> callchains for idle stat") was correct =E2=80=94 it used struct rb_root a=
nd
> rb_first().  The bug was introduced when sorted_root was converted to
> rb_root_cached without converting the sort insertion path to use
> rb_insert_color_cached().
>
> Use rb_first(&root->rb_root) to match how the tree was populated.
>
> Fixes: cb4c13a5137766c3 ("perf sched: Use cached rbtrees")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index ded511d8518803a0..85f11d388392d316 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3130,7 +3130,8 @@ static size_t timehist_print_idlehist_callchain(str=
uct rb_root_cached *root)
>         size_t ret =3D 0;
>         FILE *fp =3D stdout;
>         struct callchain_node *chain;
> -       struct rb_node *rb_node =3D rb_first_cached(root);
> +       /* sort() uses rb_insert_color() on rb_root, not rb_root_cached *=
/
> +       struct rb_node *rb_node =3D rb_first(&root->rb_root);
>
>         printf("  %16s  %8s  %s\n", "Idle time (msec)", "Count", "Callcha=
ins");
>         printf("  %.16s  %.8s  %.50s\n", graph_dotted_line, graph_dotted_=
line,
> --
> 2.54.0
>
