Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247135;
	b=Ll85ar7xgUhEDEl2SkJFLKq7OyqeCSmLspxoemT17YCDtT0xvGbWY9vbd3AsMHv/IlA6
	 3jdE/iLLpYmo6PcC1uugBWr73K+SGwx2DJWBZoX5/crlcdEUdpOJYlxnnqSCCAth0yAxM
	 xsTz0qxv6XY/oTk94kHm496CwiTkEz6nNqlTk1APivHaY5QTEKOeP6u2XgQMWk42+e7q4
	 ZAy9vLdmJdWg3xWcYefPJXKoMdK1SWq4U50ohK4pat18ABaGmm0rTdq7MGtqUVwsv2HeH
	 3dPrHOjhj6hcC9pRIJsvzjzRQIYrndvCzqbh4lU0NVSuurJOh9e7TRAwAxNEM9/Oltw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9q75CrYbbx1raBGLb0OpIjYM8X7HXrQNmHLt90ZlSz8=;
	b=rCKhtMi98v2iFABwjTrTYcDwuRDE3ajkiAdEHlora4lW9gg3WizpRx3KrZdkzOTpGFXp
	 jrsUcdvjqDOXA6btGn9IIrU7fjMKnHoLaouYNyCCAJ5o2SEZ0Fjy7/A9+U6pj0o/69fSu
	 XRl96OTrYQYfUEmENoe1DeXNOp+eX/8Go98ap/LpYn6GGnZ/teIPDuZA3FMExKv41OOQi
	 6i6vLypliIiSSPzgeS9zMxyZ0LpOLRiUnPGxgKPeqTmS/VHF3S5+A4ZBXC7PVpg6qPDy0
	 AKj/5Nfsy9mfqJvYDuZ+TQ+7oKwtbVhVi6+j/A2WrvqMKdkzrTgLu1l0TcJequv/Ifg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Oblus5Sb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA35606A32A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 17:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA35606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Oblus5Sb
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so188641266b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 09:58:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794247133; cv=none;
        d=google.com; s=arc-20260327;
        b=Wd+jDTfHzNedxIIMZ6r2XBrEUHbk/7+NcubJOSQ0VDohyNbK5Qr1jNShHtqK75Xi7V
         V2R/jiZnLvtvvjAox5KvIWoWflsO8S/CA+sOYaq4QcCqW3Tm5wT8mD2uWkVz0XUlU4oP
         otQhgZfcy/cL30Cc2RCyXKgYYtIlxf+Plro+zpqTkpQWjTu+CuP1MBUd+pt62KL2eXpW
         sMXE7/z8QU0simS7jq06Z6XAUUSyPFoAKkFSt7KrLnzZQi4N9Br1ZFM6+J9TK2x6QG5A
         97zikKmCBEHJ6hSGJDu0tRe4QZvUJNFuycV7RMr1nTj6tFdyrtjk+XksnQO8LxnoLtdG
         hfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9q75CrYbbx1raBGLb0OpIjYM8X7HXrQNmHLt90ZlSz8=;
        fh=D7X1+VwMfGWEx0vOm2gegH1iShqVYt5oxpkDnZGl3kU=;
        b=IRBJwbxjzUh1waX3ILd/HuQhEhLlHFga/4iZdjmeT7M0BTWsnCJmiy8yf1UV3W+dC2
         Un9vdvhsYtV936fPx/N+B9jPaqdPUE3KWenxVR2wk+MfXQ3fGkrye443YRfXYyOKWmc0
         WEVCFF05Xr9NWG17hAn9jn5QcbOkwK7PFBuSLOU6eVXDL8djuZ1G18lsvws+KV1vl97o
         n/5i3+/R7pyuxRNL2pseL7bRtnyOqA077pQa6Qh12MrjLFUi2PXhrDeAbRQ1S5pYauT0
         pmsZozmVaTmjwgsFS3IclTv2laRXOu+n5QRD7uU0EVo9yjrMnq0/j7yqx5+8+hg+hK9b
         Q0tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794247133; x=1794851933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9q75CrYbbx1raBGLb0OpIjYM8X7HXrQNmHLt90ZlSz8=;
        b=Oblus5SbQVYBivewi2nR7J8npdN1R80u7wbVSsZOQmK8ZH8yCyKoPL05M6qt+hDUQ4
         LJfsTf4kLBmDjBlL855mlvkiC59XkRJrDoPlUxjOGIpkrC0pxxlOs6DBqpALWznUttrO
         G9Uy2QeRDcyreaK3mon5vtQ4Y9mc6MiAnQqT9teafpaH7P4t1LcdyeqxBjSsTCzFp962
         Uki4ej9hjAvEip5q3I+FO1VGn0PC5Cr7EH5rWa6j0jbKxhJRYOXhBaKWLDwDaBuZM72u
         VOfTuGNivY+sXn4D2bfJ7De36GLPIyXhVS7Z+Mppq9GrG7HhO9ZwsMsTVfaLm+n/xvUU
         bPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794247133; x=1794851933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9q75CrYbbx1raBGLb0OpIjYM8X7HXrQNmHLt90ZlSz8=;
        b=zcuJjzmr179vCQNu8oIzeaHZ1lPvMujWG6dTcskHy0DLdTRZoZUwu8+Ae3+tDA2tUT
         Z9qU9PDLb8kw/oNgt08Prs3ziKWu28BNP+n0Pg0pVYUTcG1vBO59QMxHIHX6WiFkvjBl
         Epk5hcE/CPd2JaF9E8wwc31ocaGYbuHFKEpJkx3hvSejWZJ+YEfXwiE0emGph+BkH4Aa
         nT/anM2YRTZXIcSiaNLolFX51fZU6ws8nbsEH0SK4rYMZEx318IA0du3S/tQdSxfm+z7
         TmLA3wewsGlzxvJc3KFTEaX/V8M7N/8qE5aKs7fh1xH+chetwYpkuVMfmpGyrc1IZOKt
         kDTw==
X-Forwarded-Encrypted: i=1; AL+hErFpjvDeT/BEAGODYWlXa5FmhTERASixj7nIfYtkm7rYbbtCk7UT7VQPX+L5cmRHz0V6wudrNKNSWZh6wCpgOHwx@vger.kernel.org
X-Gm-Message-State: APuU4Z8vAgQ1dk+Ip4am+e9n0YRo4ZMhtpa3Dh10GFKFMAvwl8e2k3a5
	g0QZJ2UMmfz7MKQR/DzfNIo1UuTSGd5RCag3tQkRDeBHg+3x/R/eeTh3SaU+8LTFYO7L6Gjxt9r
	QWKPhUcJoUTYITfc2OozHftbxnGHIR9IhSCducmPx
X-Gm-Gg: AYBFou2D1bZw6BBOQPPER1A9Tm5/S79T6Z0PQfF38kI3aGzsvW9kDZqosmr2BZhND41
	oXq/AOcsAy/Y+8xUqtS0Bbs2cbdniyBMYCovDl8fMFNe//Be9c1oe8HdrBjtAV/mcxCw/gYJTDi
	PEFQ7TTMgkvTP6CgljRzw7JEZx2K/7aNQO3hmEB928BEkzK1D+1RjOLBRdysO7NxOzMzkTXmCPX
	rRlCIw4nZD6Zp3Fhx9dCMdfSziY3jqaQbsa5Ajs6pWfTvZHG9Vp2CeZhzMbTG9qki6r8GzzEL7a
	PI60k8+k9NlErhL5Sf++1lNv+jB/PELhGBI6CRoRRX/3ERp/YsS+zWHiQCOkViW0LEqjikQGo3B
	uYt5yELZwc76EUuV/dzXMAZDC+x/9Hzp9jZdfLTwD0sgmU3Ht+nk6aSxGwzpSeWCozp5HQlMn+O
	E0mc24r/cb/U5q6nw=
X-Received: by 2002:a17:907:7f9e:b0:c46:645f:cee2 with SMTP id
 a640c23a62f3a-c5049451e5fmr16322566b.4.1794247132202; Mon, 09 Nov 2026
 09:58:52 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018074528.974953-1-lalitmaganti@gmail.com>
In-Reply-To: <20261018074528.974953-1-lalitmaganti@gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 9 Nov 2026 09:58:40 -0800
X-Gm-Features: AclHuK_v7qaIr6WMYbYXezDLEd8d-dWLqSsdsr8a5s62qgaMbJAwuZ4_uyen8YQ
Message-ID: <CAG2KctqPvou3A_EGiov9yZJrCWMmoEX-k4-Or-RGj_Cxdtc7Fg@mail.gmail.com>
Subject: Re: [PATCH] perf python: Accept events larger than union perf_event
To: Lalit Maganti <lalitmaganti@gmail.com>
Cc: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	james.clark@linaro.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 12:45=E2=80=AFAM Lalit Maganti <lalitmaganti@gmail.=
com> wrote:
>
> Samples recorded with --call-graph dwarf carry a copy of the user stack
> and are larger than union perf_event, so session.process_events()
> fails on the first one:
>
>   $ perf record --call-graph dwarf -- ./workload
>   $ python3 tools/perf/python/stackcollapse.py
>   ...
>   TypeError: Unexpected event size: 4168 < 8424
>
> This makes all the standalone scripts unusable on such recordings.
>
> pyrf_event__new() rejects events larger than union perf_event, which
> guarded the copy into the union that pyrf_event used to embed. Since
> commit 2c672ffdad4b ("perf python: Lazily copy events and samples from
> process_events") the event is borrowed, or copied to a buffer of
> header.size bytes when a callback keeps it, so nothing depends on the
> event fitting in the union any more. Remove the check.
>
> With this, stackcollapse.py and flamegraph.py process a DWARF recording
> of a two-thread workload, with the same per-symbol sample counts as
> perf script, also when the callback keeps the events after returning.
>
> Assisted-by: LLM
> Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>
> ---
>  tools/perf/util/python.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 60dbe2dad5eb..8b4b2f3d0926 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1792,11 +1792,6 @@ static PyObject *pyrf_event__new(const union perf_=
event *event, struct evsel *ev
>                                     event->header.size, event->header.typ=
e);
>         }
>
> -       if (event->header.size > sizeof(union perf_event)) {
> -               return PyErr_Format(PyExc_TypeError, "Unexpected event si=
ze: %zu < %u",
> -                                   sizeof(union perf_event), event->head=
er.size);
> -       }
> -
>         pevent =3D PyObject_New(struct pyrf_event, pyrf_event__type[event=
->header.type]);
>         if (pevent =3D=3D NULL)
>                 return PyErr_NoMemory();
>
> base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
> --
> 2.56.0
>

Reviewed-by: Samuel Wu <wusamuel@google.com>
