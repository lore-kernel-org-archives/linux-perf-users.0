Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602091AC88B
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Nov 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482022; cv=none; b=sEuTpO932h+QGmEuRfO0CvcnTc6+3HanA5d1OT/oEiiSYEwnUwF8iBAz1nhULFdOpoF9gqRJYlSkSGDs4SQ06f0mVR7K+oJEY6XW6eALkqmZ+lE99VkwjX+8p7gl0+5i/aQvCi4WPj/bGARWJQWBvOqk5GKIs4nfW9ny+AX6ilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482022; c=relaxed/simple;
	bh=NBKrUa2D8PdIine6KKhRjU2cZe/eh8+ftp3+IJxVdbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoL1wZYVW9V9mEHnKI0kUmzwfLDUFbexmCU3jg0oAUX8oH6YqEyZ0rUG17zV6XUOU3dlsAH2zPgWIAgvwepnaQaU3DqSIZIjetHoSrawRayXHvOgXpe5Bin4Bln1WV3rQReOjZ6YzAdGREfdfUN190DmhDCE8TmpJJTzE8eWf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=nItvnCW9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="nItvnCW9"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso303111066b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2024 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1730482019; x=1731086819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGBQ7XiponedQH0G8oMlRjgnXQo5xUlTuwl2T9Kpqnw=;
        b=nItvnCW9T+4JASN5eNg1MotDHC1Km+A8RZekcfru+VJni2xU/avqQGrdIMzDwiD4zS
         FNHQXkqS72SUdnNGnL5SEaU1Fpu20++PF2x5zwt/fY5sbTExdzTL1MfCrNCWGy7jZuf4
         TIABtd+bADKi6v8I/Xv7U1Owjjjo5/VPofF/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482019; x=1731086819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGBQ7XiponedQH0G8oMlRjgnXQo5xUlTuwl2T9Kpqnw=;
        b=LF4WxIfFaumHFkuHzz+kQ/90zq0R+Wwhsj133yS8jpsC6KhoRTIuTFyfFOeHt364P5
         pvjNaNql8UUN7/J2vkVfA045PLvy5H5Y40AkcRf5rqQeIH8BB1YVtlnma3M4Aka5FKnO
         3EoLWjCiEIVnOu68K8O1Oh90EZzICxkXR9IKJar690KoHBunwFlFOG/G0vtBZxq2c0pD
         jh04d6GAlQgFAAYyisQI+Iop9aBTfVt77IF/SdtCbNqAFISqJ6I17KT4HrWftwhczxYp
         B0WR9yiFSHiTcIE+yroMClyDbk2U82PsoHnHzUzDI3jWKazEUmZOPJlRytlB5QSWOI/2
         MsbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmPvRF5jN2r27hjxsUiT8eZUMdECL4NKP/lyCEj3QcES4lfvx9NrIfC8VA5uL0KH+0B6K2Ut37XLPEp/W3wD9w@vger.kernel.org
X-Gm-Message-State: AOJu0YwRj8eMPb6XTXanfgz6YkFgkREnDJ/uGDsz9zpMs/C7eLuRWH3H
	AeVkUUWXORM0zPXTCvEBxV6qOEh5Ksp8cSLV98QBO43oUC31Ml/c6rowTjndyz5p6zKJkYYd/hl
	fV/at0LcyqjmCkCw3AA60zs1c+V/SpvLQc5tyDdMIZymZbiAktHVTKQ==
X-Google-Smtp-Source: AGHT+IFzgCGrZUUaa0PkReVBTHl3jpfSyZhs+aIeDp9osq3Msp5djF8lvKve28gmzyjUnNxOGidzVg5tXv42Pszx1r4=
X-Received: by 2002:a17:907:8693:b0:a99:5ad9:b672 with SMTP id
 a640c23a62f3a-a9e6553b27amr356811666b.10.1730482018627; Fri, 01 Nov 2024
 10:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101005338.5846-1-benjamin@engflow.com> <CAH0uvohLu-N+SRu=ddaHnLhC48JAj_=Pf-ZthgOTyFJ44AEumQ@mail.gmail.com>
In-Reply-To: <CAH0uvohLu-N+SRu=ddaHnLhC48JAj_=Pf-ZthgOTyFJ44AEumQ@mail.gmail.com>
From: Benjamin Peterson <benjamin@engflow.com>
Date: Fri, 1 Nov 2024 10:26:46 -0700
Message-ID: <CAEmfU+sBLFzfRLGjWaaT66=DZjiK+HDcZikLuLvzsMWZiDFPpg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: avoid garbage when not printing an trace
 event's arguments
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 7:03=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello Benjamin,
>
> It does not build on my system due to this warning:
>
> builtin-trace.c: In function =E2=80=98trace__fprintf_tp_fields=E2=80=99:
> builtin-trace.c:3090:35: error: field precision specifier =E2=80=98.*=E2=
=80=99 expects
> argument of type =E2=80=98int=E2=80=99, but argument 3 has type =E2=80=98=
size_t=E2=80=99 {aka =E2=80=98long
> unsigned int=E2=80=99} [-Werror=3Dformat=3D]
>  3090 |         fprintf(trace->output, "%.*s", printed, bf);
>       |                                 ~~^~   ~~~~~~~
>       |                                   |    |
>       |                                   int  size_t {aka long unsigned =
int}

Thanks; that's what I getting for building with clang rather than gcc.
v2 incoming...
