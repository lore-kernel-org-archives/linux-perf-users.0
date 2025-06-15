Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830071A76D0
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750030859; cv=none; b=JXxR6Y4RIS6AbRn+vRuVeJ9dOgXt8ILpwsnNKE0Duy3l9PEexDrzbrkoZIHZmwdOVNrc0mepGvBb3zNErGwpQcllTqL3T2nJCBXVTpKrdKdYMeYc4vJHv3WFn3cgWJl76tMCxSbSQcplkmLaBlFbqy1lf+LgNDZCmV7aYtHHaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750030859; c=relaxed/simple;
	bh=KpJP0dy117AMxckG49vmRlF23+PVI63MeKxWPlYCMVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrr2zjXNWJk86l4uAiX2wVzzK8m7TgFcx8nerM7e7dwGatlc+02fNmAHGYiQLaK718F8IOiyovHeSbyli5/ceGaVe3a7VPk4avcL4mU47UoH638jiY+m7GXp/pG4fyMR/3B4kDsMzbsyLLwAvE+BZVYLg3UB6Ur7tOTwlhBIBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXy8f06J; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXy8f06J"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so210625ab.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750030856; x=1750635656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpBHuz/HEp/6nWlgBYT+qLfKH0s7nFem8lXkvyO+wos=;
        b=cXy8f06Ja5PgFWGKPhzaoMGgIoWP1Hp6n9oqdHboPRsB/pCIjaHBMirWNdYNnncf9X
         7dTdB3up9lZH+fa3DhHWicLj3ttRogCIHay1Mcz+AitgJ+UJn7CK0tLrVUiXvv6YXxiR
         kgNKSWgBsCswRfZXyJni1L3ooaFkZXcdVlhk5i4vNTMWkbe+uR2/8j3Jq1J8KWED/WwA
         k7lQc1xdkCpkPF4OQrQD9192pIMonDDiHF/e9n3b2IiRDQD8XIEzaVwL3sFcs9YOTw7w
         txaX5wDclLrLwl11xdyF195XbtYN5iZm9S+fWQOHRdR20Z+ws5T00NPs3JOVMnPDlRek
         sysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750030856; x=1750635656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpBHuz/HEp/6nWlgBYT+qLfKH0s7nFem8lXkvyO+wos=;
        b=NRDC+ik2CcvrwinKdycfO4PaR4EQe7m27YmgcSxuv/qoIoa0H2PlnpPeOPzmeDKQqQ
         QY1PABgNf/YXidLDX067qg3UeeVYgulK/UrUJUzDRHGXp4kuAcXnmNVfLBdlfs2m1Pfv
         b8HsPa+hDpyfaXwbbWC5FXylEyKVBGxBShJRwT56LCNNfdZqvrIUPwi8UIbF8yXxKOVF
         AOTdB9YtqxBe+TrFpLWKv1w2eXRcFno6/0XaOFMNmmr3V/N1N4tgpv3Dzh01It6Y4l4j
         uH/Q6wEeh0QD5BiPAJfvknaJVBrv/moBU9LxV6ceqqBFySBHAm9LjzGPV24tYkOZ+BT/
         3lZQ==
X-Gm-Message-State: AOJu0Yw0ya6UFxaZhkhzh/h4ZoUDAoUGFiJ8+PWbTSslOboz/TIAlgUe
	9xI1mTl63mekB4AKmmFVGAavniPMQ0cq+9y7QsLYuskMHkaMcoB9I3P8F6Imc5cVaeVDNHK7I0F
	WtbCNABKDYhLIHMSKTl7OPvtlRZOqu8YTOBMUnpQJgUQDKIdrq/i7v5LkiEQ=
X-Gm-Gg: ASbGncuTb5BrFWBwWipDMnj3kODYT/qXOZqFhcPuXfXl5HHL63zGiDqCwljz+thvp6v
	l89kpiO0gINgFm+xHe4+NIt+z5ENVSGu0vtUI2R503VztDxO00TYLs6OutLzzCaDRssrksd+8T5
	IO+fe66SWLFUes1YJ9kgY487VFKB1wn+Z7Za+cPpXqDRm5Gcoeci+b828=
X-Google-Smtp-Source: AGHT+IGbsWpvnH6DVDc7fRN926+vMrf4dYRBE2E8qWEIOI/xPmLfRYxbCN31rxqcXeuGTdXjzHz8ieXI1gb0wwej/PQ=
X-Received: by 2002:a05:6e02:18ce:b0:3dd:c9c2:820e with SMTP id
 e9e14a558f8ab-3de09fc2fd5mr2507345ab.23.1750030856387; Sun, 15 Jun 2025
 16:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614044133.660848-1-ebiggers@kernel.org> <20250614044133.660848-2-ebiggers@kernel.org>
In-Reply-To: <20250614044133.660848-2-ebiggers@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 15 Jun 2025 16:40:45 -0700
X-Gm-Features: AX0GCFt2OyNR7onsva6LNhdJ12BmP893yyuUxD4l1css5JXoQNvR9w2phvtqFdk
Message-ID: <CAP-5=fXLCAN_8PpPRYcLpLXG0oPDqGMzn8VwuxPdg63+zFNTUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf build: enable -fno-strict-aliasing
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Yuzhuo Jing <yuzhuo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 9:43=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> perf pulls in code from kernel headers that assumes it is being built
> with -fno-strict-aliasing, namely put_unaligned_*() from
> <linux/unaligned.h> which write the data using packed structs that lack
> the may_alias attribute.  Enable -fno-strict-aliasing to prevent
> miscompilations in sha1.c which would otherwise occur due to this issue.

Wow, good catch! I wonder if -fsanitize=3Dtype could be used to capture
when perf's code is broken like this? Perhaps we should just remove
linux/unaligned.h in tools because of this, the alternative of using
memcpy doesn't look particularly burdensome. Given the memcpys are of
a known/fixed size I'd expect the compiler to be able to optimize
things just as well. Perhaps we should rewrite unaligned.h in tools
but perhaps the kernel too. Something like:

#define __get_unaligned_t(type, ptr) ({
                 \
        const struct { type x; } __packed * __get_pptr =3D
(typeof(__get_pptr))(ptr);     \
        __get_pptr->x;
                 \
})

becomes:

#define __get_unaligned_t(type, ptr) ({
                 \
        type __get_val; memcpy(&__get_val, ptr, sizeof(__get_val));     \
        __get_val;
             \
})

Thanks,
Ian

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tools/perf/Makefile.config | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d1ea7bf449647..1691b47c4694c 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -17,10 +17,14 @@ detected     =3D $(shell echo "$(1)=3Dy"       >> $(O=
UTPUT).config-detected)
>  detected_var =3D $(shell echo "$(1)=3D$($(1))" >> $(OUTPUT).config-detec=
ted)
>
>  CFLAGS :=3D $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNIN=
GS))
>  HOSTCFLAGS :=3D $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>
> +# This is required because the kernel is built with this and some of the=
 code
> +# borrowed from kernel headers depends on it, e.g. put_unaligned_*().
> +CFLAGS +=3D -fno-strict-aliasing
> +
>  # Enabled Wthread-safety analysis for clang builds.
>  ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS +=3D -Wthread-safety
>  endif
>
> --
> 2.49.0
>
