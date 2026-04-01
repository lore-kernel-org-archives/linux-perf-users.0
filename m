Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4C222565
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074624; cv=pass; b=MXC7eMh0W9wPuWddxGa/iQrZ6nDWozUtVJBxe10XwWjs3zUt+M7YU1/ss74xA1t8yzv50iaQ36HJP/ku3qqHVE/KG1Ln9RQUE7srHPzJa0Gq7H+KNzrWVAhLH19Ev3Zag2JjdvHQEW7cwFAv4XCnYaRg98D6gh7fDvtRDkARNB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074624; c=relaxed/simple;
	bh=KNlh1ao7abq8SKedFeMDNKmxt4YaufitflC9v99QlqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKP4tNsBLKp+bzYqPUPPW7hBUK+lKgr2jdYxLWy22ow9UxDYv/E/samd8FyrGlwxPpNGFwCFxMhdm1GE8/dYIXd13+bcRPbI/ff55Ar5nJKns+7TuV+ydDvTunTIyUGa29XBQwKxbRJVHxcClc1A/HgF7VgslsV+/oqAV2LkAqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PAhv9s4l; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAhv9s4l"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b0c12be0ecso8875ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 13:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775074623; cv=none;
        d=google.com; s=arc-20240605;
        b=GwJEdTyfAoqPJPqpcdwSHt3I4Lb+WCta9P3JzrMlKxpX3/xpdVuA/4M/N443KO67WK
         DVWmCom+R3OTW1ut+qE9HfwyMjh3M2lL8+cKEF0WkC+XdBj1AojtlQhUZ4azkiddFguf
         gqzrEDKNA9U26UynayImqhlVxuf0Miwm4dJW6fvD5n0M1a6/6rFaki4bG7cPAIdZ76ii
         rMBGrZZFQ08F1cZQWgtylqDO6fIXuVbtCLapeeUXA445gNKXTl4lxtQiIUDy6oUcldPo
         RFZUmI9IRFqqGnTEdUo2mlIlmgK5AxjWY3Uac3eZtO9jEBg5HnXOh1/eHO+7Gaus4BLx
         ScRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jmWL7bW8RurZAnS8O95vtjMLCksx/fEN0GvMZvUi1Ow=;
        fh=a0LYqt9tn0391SLRI4xZE8WnGid4ILDkqAJyUCJbvgc=;
        b=Nyj30JgLuutP9NqucLSGWR1g8k4XB81EDMCN+344eeA8q17eJDCiuL1/oDUFXkuW2z
         b6vQiO4LfCWkhhlYAOs04KXehUh98NnlvY763+GszsUP/OD+F6XC+WlubUSf1SojywRs
         nznXVtN8Clvn/ERzcp+9OQTCRVvQCFNbCBXAcoEWdwMdP8TgPDja5CjHGFoy0YKchUuI
         wSw2DtQQ2JlIKLBYSRbJeWHLTLWbbOypu4//87m1iI7GteF9ZPOhjuEEoHNDjUyBiVRu
         unzK9xxq9GFWx840v6puzTtWux0CfsD/zYTXItQzhNyAQoxcHxuK7mqDk5fTMdTFIcwS
         Gakw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775074623; x=1775679423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmWL7bW8RurZAnS8O95vtjMLCksx/fEN0GvMZvUi1Ow=;
        b=PAhv9s4lpeDTRjujkRB6lUybSukRu2af9Ct1hZ7Gppqlwa2XP4+YsOq+K9QMzSXxb6
         WPZuc9GGVNUMPDKRdqbbVK2bkx7byc6c4ws7Tq7jpvP5uKNgsw+kiQxnz3o/hWfnKpQw
         oHXkzlzJlLAgQnJa5nvwvtrzWMrep9dF+D1MzcPpJmB93qwvlQIZG6IPpAUGHw6ujSr0
         bD/pMUSwRAsPYAQzEHkTR/MOs0k216etqUewD2HKJzwaKBb71mZZGEWBpBq6Rma/I4zg
         hpT2hsC1tOvK57x8gSL8KCL3hnCMNBZ9KiaFQz3mQTz4JfeFVpSeHswZa0Pp3IHlsrCL
         K5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074623; x=1775679423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmWL7bW8RurZAnS8O95vtjMLCksx/fEN0GvMZvUi1Ow=;
        b=MtFISmcMFxyaghXtr7DOBp/YbS7b5VbVzd4WXPunYKTJg2hNhYWcIA9NKw6YJRay76
         Baxgv012iXbo7K7yzxlj5+HPlBof3V4IwJAo0P54sMJuhzXBxwNorhAkezwV37GosEOw
         iimTYW24h0RWcv+Bx7pq07d9XJrrFRxUNkfuSbb86fS1bHfE39V0xQskwHEsndC3nQcX
         U9CoS6Ur0yPcsjIFK2R8J3prmTV1SIzVMcRE5kMRWkQxhqJozAeoUKzLD3dWQSyjoZ3+
         kM8Hkn0mOL6YUVZAM3AcqtirW53ZnxsdkSxJpgSahvALZeLeH8DX/SKtXgxt6IiA1yeY
         csGg==
X-Forwarded-Encrypted: i=1; AJvYcCXXkrxJe6cgnL5vIqGleUAJYtMladdLUeKqv4US7h0I+JGQZEu2aTD5U/TJF9DaaksmLLEjHFRO5jQSDZbBmZV+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+lR9zAiJ2axV9mD7jWIjnv0ThH4xwkGvsexa3dGVjPQYM0Hu
	+5hi1T57o9nGSNoYOLbp+82GwZpbLeKADIlTpIaVEXPVH08nJye6If8+ph1Y9lFzgpqBu00alQ0
	/7dwnH4P65p4hmaGaCS5O9xY9QQnv3MaVA8rD21XM
X-Gm-Gg: ATEYQzxTfOtoNV/Zm1xC9z/bpzZfiHG5ndIRcmx6lAOF1Z732HEWh50EMraQGzTYtGt
	Xg5q/fUuChNe3tD4BbidykVIMMDCQs/iz77H+GDfldu9KLm5EqFUd14WPOooWOpeT2123gSm/lC
	wAh2fhloLS4hlhlyymJ6IiwIU01pZATLDjCjxY+puxdeHvWjnr9eqez79rw54MhQtbgSFUXEoj8
	R3s1C9NyER5SKFvcDqT2jbfiueg5xvJczmx7CZ0nrOkOuIHQ3AFukPljWad1teR4cmfDD78W4s3
	P1szEB9IsxHeY4Xdhvj57xa3jQuTFIx/knf1E/nOUcr+XjY=
X-Received: by 2002:a17:902:e84f:b0:2b0:5683:1cf with SMTP id
 d9443c01a7336-2b276b64878mr353665ad.13.1775074622487; Wed, 01 Apr 2026
 13:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
 <20260325205914.GA356832@e132581.arm.com> <CAP-5=fWkbhffgL6BJjpiwRV6rD3yd=KkOz7-ODH2FnORBf70bQ@mail.gmail.com>
 <20260326163926.GB356832@e132581.arm.com> <acZcG634vXs2_EWj@gmail.com> <5CAC1C39-9E69-4952-95CC-D84919D81F8A@gmail.com>
In-Reply-To: <5CAC1C39-9E69-4952-95CC-D84919D81F8A@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:16:49 -0700
X-Gm-Features: AQROBzCr77hHy-FPqsyaRy_jY9Tdfd-OUJDHwYwBPgE9yGDxzO5_kakMIwq8x_Q
Message-ID: <CAP-5=fUr4RdrGnnDE96GTQnpfj9anHVMxZ+gy7SwMEXGgm70uA@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
To: Arnaldo Melo <arnaldo.melo@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Leo Yan <leo.yan@arm.com>, cme@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>, Dmitry Ilvokhin <d@ilvokhin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 6:48=E2=80=AFAM Arnaldo Melo <arnaldo.melo@gmail.co=
m> wrote:
>
>
>
> On March 27, 2026 7:35:19 AM GMT-03:00, Breno Leitao <leitao@debian.org> =
wrote:
> >On Thu, Mar 26, 2026 at 04:39:26PM +0000, Leo Yan wrote:
> >> On Wed, Mar 25, 2026 at 03:27:05PM -0700, Ian Rogers wrote:
> >>
> >> > From the stack trace I don't see anything that should allow this.
> >> > Either the list of metrics is broken, or the struct metric_event's
> >> > evsel is NULL. But that should never happen as we wouldn't have a
> >> > metric at that point. The sorting shouldn't affect that. If you can
> >> > reproduce the issue, verbose logs may help.
> >>
> >> I believe I encountered a different issue, which is irrelevant to this
> >> patch.  So Breno's patch is fine for me.
> >
> >That said, are there any concerns about merging this patch in its
> >current form?
>
> I guess not, will try and merge it later today for 7
> 0.

Looks like this one is still missing. Thanks,

Ian

> Thanks,
>
> - Arnaldo
