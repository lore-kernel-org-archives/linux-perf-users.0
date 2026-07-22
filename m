Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2067440A22
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738289; cv=pass; b=rwfprvjq6fSGKPzFqbceBcXgG5OdOM/RE6rHU8NuFnlY5K+caqzb9SzoKqP0ma93/vZukEniscgmFQpazulNnBNWha9+ga2I3gAyplCXR9GcDlKa/mZqHmZ95PmmY8fUFnItMuUtW6u22/hIm4U96PzK4td4BFF78iK3EG4XArc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738289; c=relaxed/simple;
	bh=7E8CdpEJIq/XuJwlCRNZIjmOf2FHiEa+JzAPz9lWniM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuJWYA+AmGq7m+GuaFFHTF5tMJtcgXqeaBeKphm1tZtHAAIeOx4OvlB4/Bwv4NktqTtkhJppI2BK82rrs+P/g6OSkvYyB+OuePLo8cq2r59TWxoH/5J2mj4l1cZvZo7sGc4mOVqqhfsDdgQX6/ewCZWGRrVuTRhATWUz5yb5S+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRup5L/M; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRup5L/M"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c15a5b265so22101cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 09:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784738287; cv=none;
        d=google.com; s=arc-20260327;
        b=BCgypQJvOhgZl4P3nCv46nLSLkU8q03675nT2g5RaNmtyD9CR1Nqe8qfuT1ZTidZ/M
         JFxBJSI+oEywpV8cbOh9Usg0hau85OrR3mEBeIQgAMSqCE+zdckKuwynm9zQr4KCptkp
         iPODA3cZkvq7hRe+/tNrCyTb8Y84neCrlMnJmRgK46D3xVSQMDAV6JCv3TEZ041y+SME
         WfDNtq8EJdp5+zS3dA2UHioC33plmpor6AryRmlLqSyFfQ61MliKC/FYdI4Iye+Ux9un
         qbSChNxWZpVWd0SIZeEKIY3+i5RScDbqBLw2RQTOFQ16ArnyXcTHwEedfPjh+mybpd7O
         JGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7E8CdpEJIq/XuJwlCRNZIjmOf2FHiEa+JzAPz9lWniM=;
        fh=JQwrbtmTybnezKc1jNrKyEgs5CNcQ+juDvu2FzYubXw=;
        b=brUFCxYup2zQab8ARHsQ0ghPMWPlqh73a7+n3ysuLktl4zEj+rd10xBbi8253KtWRV
         kHCY/PUj+OHXy8VAgxqhzP4B29KpyJdDt0aDViozUEQX3Q3SH5T6ncjOrSnn3dlhW1nr
         1nCmOd9f0N0z14LlgtTR+pwo8cloUaPHEL9bABJVxyPOkzcXai6M3vk1bLRZuQp6CaqH
         9tXIpeSnVnStdHrahc1KKZZqC2Lv4SLQEK49ifKRu9Eb4OlHrl6D2wU4Znp4HG4Z1w5Q
         6PlBgqHnx0zEq7udti1JzvjbxrYUmifRsbsLa0S2g3gNDznpc5SZ0zQ4RiXXqkxy5DKf
         wMXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784738287; x=1785343087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7E8CdpEJIq/XuJwlCRNZIjmOf2FHiEa+JzAPz9lWniM=;
        b=vRup5L/MOSgl/M3Ur7GLWLHZGCQs95ynv4IXwog1QW2xMStyraSu3if2uHneEpYtKG
         zITcBddlXFqmP+VAfOebBHWTAt/mJcmyaRAoBcS0FXA+4PtskMbqlYoxPaX8Gph59P8F
         fUv4OB8YqtRQniL1oUNrR6iA+6GGc5e0aNJ1tMLfR2U000QgobxfsE4fubLbmtmTyMqB
         9UP1PZQrtmTleSlNRxZxDXrWrZrn8bMiTmx9GxU2gryOTl+2WjxiHiOs1rg/yAIgPfeG
         MjazOV4b0WoXFKavUvLGRmVO0SCQM4Ng0cc8SaijtqoM1lULyJR302TH4k5hGn+lZqFo
         11FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738287; x=1785343087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7E8CdpEJIq/XuJwlCRNZIjmOf2FHiEa+JzAPz9lWniM=;
        b=QZdcuGPbdG9OGP5CgRoq9DmGt2GsjH3UPhX7G47JY/LjRA5zqm01dO4wu1ZAfTOJAz
         R66ivVF5y5e3d/NmmoVJ7R7e0UyzxqYp7xaET5WW5i5sGmyXF/UKfCWdEk7mrq2+193O
         Rm6lu1HV4whgR1uG1ix0gJQ2jEgtoWc/q2UYSFHiekJH6gUBS09Ic80Uf5vDrzmZCiwu
         65TEBI0eFaq9logWLZF9dode/EDlynVl02hfMbmFJllZV6yaLx22vFzbUwfbhJgoNMWe
         QEqTn5VSYQfZ3y1g30cuUkGJLjS/LdLvuoLqA1411ixcMwd/18hyxhJLPDkhfr2sl+gn
         J2Vw==
X-Forwarded-Encrypted: i=1; AHgh+RpjU/4o6CCKM+onBnD9ee2wCSDt2Oq/oXKEZwd5N/eE4zGqlIVqkNl8nweBxKnLPb4MTklqylO4EK9xAj3xXkl/@vger.kernel.org
X-Gm-Message-State: AOJu0YyefFLjr8fYT+ykkOGR3q+GHaAZrX25XXdgy8Jb9DJFS/sml9OK
	TgbBwapTwxv0krdaPINI7N75kefoRN4bhxSKplmNJaC8Mik+mW6o8YVJ7y9nEeMQzQCXp7lsR7t
	VJ86dxEjUrrX2V/XNrR9LcLiA25LbxgsviUanFMFO
X-Gm-Gg: AR+sD118kbcTqiOsPH/zijYZo+ykW37jQBQ7gokWeGtDcP0CQrSrB6Kuc9UN/zU0tX3
	QRkoBYWlFqs7s49yQEqgC6mKxGBOfS8ZqJqif+mwHEvVgvdO9FC1zhTbElVJUYJbdGKngA1H2WS
	Eg9C4yDFkkeMcOg3yj6IELKRr0PQDsW+Ey7JNlZxFVSHkj0/eyYNaEgapZ1KVTcUj9GxZ3sqipz
	M9rtGzBqGfBmTpPs2wawTBelykZGmzmD1Dj5qVzyIL2bvTsYTdcv13K4aUOHyHkVtXFOnz4APiL
	TlPkINrm9zQouc/Q
X-Received: by 2002:a05:622a:411a:b0:528:3186:5781 with SMTP id
 d75a77b69052e-5283a77f457mr963131cf.6.1784738286732; Wed, 22 Jul 2026
 09:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
 <al2n9pdO_uAH4tTb@google.com>
In-Reply-To: <al2n9pdO_uAH4tTb@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Jul 2026 09:37:54 -0700
X-Gm-Features: AUfX_myd8sRv6sn8GQfNkPzs4JFhPLNHKqGZYdRBoYpfpUEPuhVoVvk35XhP8aw
Message-ID: <CAP-5=fXMxHZLTi+Wz=CddzocqqAi+kvCpv0QCQ046dJr=HSGJg@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] perf hists browser: Increase MAX_OPTIONS to
 prevent stack buffer overflow
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 9:45=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Jul 16, 2026 at 12:23:42AM -0700, Ian Rogers wrote:
> > In evsel__hists_browse(), the 'options' and 'actions' arrays are
> > statically allocated on the stack with a size of MAX_OPTIONS (16).
> > Further down, the function sequentially calls several add_*_opt()
> > functions, which increment nr_options without bounds checking.
> >
> > Depending on the context (e.g., branch mode, scripting, annotations),
> > the sum of added options can theoretically exceed 16 (potentially
> > reaching up to ~19). This could lead to a stack buffer overflow.
> >
> > Increase MAX_OPTIONS to 32 to safely accommodate the maximum possible
> > number of options without risking an overflow.
>
> Applied patch 1 to 6 (except 4) to perf-tools-next, thanks!

Thanks Namhyung. That's the main part of the fix. I'll try to follow
up on the rest (patch 4) asap.

Ian

> Best regards,
> Namhyung
>
