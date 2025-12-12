Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC532561A2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765517026; cv=pass; b=LyuZcNOqdbYOKStwyB8f4IrEJzZHrz7Szq1+g7G8Jcs1yOs3pbXV7MRKbTKDlDXg6uoY8y/sOPxj7Bl8oaK3H9TWu/XDOsuvk5QZ01lueuAiy14HTjdKY3Zg0+xxAPVnWDlplvhVghPKvvcbpv+uicAns/YnryOBIzgapKc2D5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765517026; c=relaxed/simple;
	bh=mt+E/DaRj7jc6y5bK7S+qLkyR3igp4mWF00lCEcpFVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bshynNPtnJsxYbbpYzQwvPcAfuARv90trb8+y3AwnfJlxtGfXm8t6mufLDsurTOqJn2b4//UgOE/AtsE22T4uO/Qr025Z/BoVRIMFNv2WBFppYAaG3anLYFSzaNEGrN7u8D5GDe1Y07oJ5SLjLqTA4LDjmn2X9vu70IKFyGDKcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICtR97OL; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICtR97OL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29f02651fccso192985ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Dec 2025 21:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765517024; cv=none;
        d=google.com; s=arc-20240605;
        b=KgmIjeJU4TPgWDXMmj2zpT1E8SYZhw65O6jr3b9dvphpsZvb+sZaP8G4ucJpXtO10f
         inOXeQIipJVX5IuH+OiXxvKnRHE93ccysi55GuKMtksqhsiy9OVEyPxApDu1GhPkf+fw
         6o72TB3+KQLxTuPSW7YdwvBPROUBmlgx5G9VW41HEUojbwuRKp6v/gSoKoExVyEAu2UV
         ofltcrdlhHX3dlFhDrZwEfY7ptMDxvqvO+F1T0YxIYp5GVverZ7WOf1oseg+4F8UQHYN
         meNaq/LCzDlri9ZgBv4hVoV21HCUBePJ9I9hphXzxjMCEVW5TVvZT1qpJX/q3WsOvdML
         ++iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/JQuDzBMQHRqxnVtRIu3U8yYeUMi1TgNuKJ5Vl/qqk0=;
        fh=L3YFkLKuywuRmyMPHbSPsurExp6GZ2OPVTHlEA/hQnU=;
        b=A8Z7YQVbliIFwcNCIZXQxzbubcF+9Kxbu31osvjVmxZihCFUALpo/U/1JSPDNZfTLz
         OvnOIY+/YfICQrSf8PXfqD6BBdeDO8ci/BR0Oqid78bl4AST8UVYgkziWhBMOR7Ipa4n
         Pd6Vsl8XlGzptJeoHQN0CR8wuwvcmu5JsOZVRmasTnc78bS7bF3qosGhJ6bXJHYVtbTf
         UjCgolms0yuQo/cKXDzK29UHfz0sLCwrJ+VVAaABhVMGnllHeOfcpWP8QH1RNMSD6U/i
         aHjYfXZfpfbZbnNuZeZsT02x0onz2cwGCylVeYKosKc6ikhplZ2Q8xXTv1xef0JA9pSn
         S0ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765517024; x=1766121824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JQuDzBMQHRqxnVtRIu3U8yYeUMi1TgNuKJ5Vl/qqk0=;
        b=ICtR97OLSJzIDJD8O7huXCK+aOWjxbEro5+NSb2fArlnyyo78HtgMABCPZu+yY81fX
         g5NS7J6wgE2IPjgRfOF6Fulm+OzxKJbKPpSI/RaFBab8YQb5IgNOAQU2lto9uG5Zb9l0
         aqKUndbfiC4do/cf9vl4jj+BXhBmifjVcW0AFxPLJU9hnWuWyCFfAJNffzyzAB7Ftp0V
         t9sBirlUbfzvm6Na/fOouM7DglFISBrttFL4GXnYfKC/DYfGtYETo2jqMY/1fRf1KFQ2
         3c8uq9IDuoUAnEpjhdribLTz4E/t9mqi5q1CJJ6tyYlubswdJYkw7pGAh5/kpwmVUdmy
         aDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765517024; x=1766121824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JQuDzBMQHRqxnVtRIu3U8yYeUMi1TgNuKJ5Vl/qqk0=;
        b=YPbzRfEkgfAcwhQ3oVdtpSNRXQ9B+FzqguEhu44uKI5dp7XDyttqlPZtzwAmnakEpA
         WzWy6XBB1STPsJdYqHlQywl2qTtXu1TwH7skQ0kyYE9Ip9BdTJY7MDA2lf8mR+Z8Zmvl
         5lfGSrcw0m65DshtPglRq7fgojK229DiSNLd9qdPL+IU+a7Rw/20NJl4EjBcTeQ+C1hU
         ocmXtySKP8f2qpV2uoAbY/1kUxnQHYkjgMnMZICrH/0OJUdvcrKxuVVuReACGVq23EP4
         pEF+tXvRBG4nUbQHuGScBkKTLELQQww+FuaQGr/1ncQSK4bbUu4vGVk7TTPwDmaIG5+j
         5Hug==
X-Forwarded-Encrypted: i=1; AJvYcCUVEl7PUdQj5mipSHG9xfTmP4Y0vG7vEaUUZ0yW1WRJwyhb62JocXYnwWRQoGciH50KqWXWTdc4ZKP/WkZTWDj8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+u0kxckjc+HQWdsq3vxRCBYTi5v/AHCW6HXmc86oz7ishEGVd
	sGUa6vuKSACgL3TLhffT09+KWYGgjeb5ggUgF22/p1X8lCHlGVHnyfAkfzRamh3TLB+34jYW7zO
	bYF+C6P/RZZm7f3vw7lcT1x3d3zDAkMV89BGasG5M
X-Gm-Gg: AY/fxX6jFe+Y+O1D3apZaIIdxF1PURyLIyhGMXVJz9yEnqkQ/rYyFS+lR9R5wdh577s
	yDePFKIHVOv01B8sEYNrgL2a29fZpLv1O7nyh9a4Cw2KStl4IHRZzhzxjZw49pvBbGYHGQp8GlL
	548a7dZkWFzys5Tx2vSAepYTIxi+cpLdrVG7ACjF97PlPPAqayaD36vDHSq7qFPN9G7S9N2w4FJ
	XezMy0HXZ0Zugll1U6zKjNM+xmMq5IdQLNTTMxhSvRaEXqPf1WMIKyF9xGZb371qyLvFA92
X-Google-Smtp-Source: AGHT+IERXYAsAHeezYU9FHOniekGuKA1ZOI9CwYSZjXBZ9PXNEKP7/UUMgT7aahUXVSBNyHET5g2DddOZstlKPXpFJ8=
X-Received: by 2002:a17:903:2f8f:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-29ee9dcb749mr6000845ad.6.1765517024222; Thu, 11 Dec 2025
 21:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211221756.96294-1-acme@kernel.org>
In-Reply-To: <20251211221756.96294-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Dec 2025 21:23:33 -0800
X-Gm-Features: AQt7F2pomOalTPbtLhk4xka815UWMUD4i6_ICKjM6jXQqfuNI0DItBvhx-W0TxI
Message-ID: <CAP-5=fUaGbbd4z6RcdsV86w=Tta6-s4GikuwJZjFDFjnTQzjwA@mail.gmail.com>
Subject: Re: [PATCH perf-next 0/4] glibc str functions const return fixes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 2:18=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi,
>
>         While building with Fedora 44 I noticed so interesting warnings
> about touching const memory, fix some of them in this series,
>
> - Arnaldo

For the series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
> Arnaldo Carvalho de Melo (4):
>   perf list: Remove unused 'sep' variable
>   perf diff: Constify strchr() return variables
>   perf tools: Use const for variables receiving str{str,r?chr}() returns
>   perf trace: Don't change const char strings
>
>  tools/perf/builtin-diff.c       | 12 +++++-------
>  tools/perf/builtin-list.c       |  4 ++--
>  tools/perf/builtin-trace.c      | 11 +++++++----
>  tools/perf/jvmti/libjvmti.c     |  2 +-
>  tools/perf/tests/parse-events.c |  4 ++--
>  tools/perf/util/evlist.c        |  3 ++-
>  6 files changed, 19 insertions(+), 17 deletions(-)
>
> --
> 2.52.0
>
