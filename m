Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D5B3988F2
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567125; cv=pass; b=mTxpj0GD56E1VN49ggYnzmN5xnrZ3A8jhD7jSvgAfPCtgIbnnzhsTHxRcPtRfQrWuwjYYXH7W4rNKEjdFfdMU3KsBY4LXRS5ntBftyHWN/MWaSSODm8p8bwUuORLbFSPKzs/uWEf8JkVFHrQdYGrxh9L+/u3UgEdUelTsoOWXPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567125; c=relaxed/simple;
	bh=GAUZamoYstGEaUmPAxzfjuK0q0ORmux1ALerdzR8PMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HygT98Ltumg6wesTGdPv7aIrgPKSIdyCj/e3g/UdShynZ0dmozqkho4SZVv05mdfTJZoU7NDRpA3ru8uWN72ftKcVdKFYsltB+mi7NNbdDJo3mGofzbSP+14gDJenY+XEGSb2hyMaArKUTJQXDy1imwrLlLM5WMeIWENqu2Uztg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GPWbKv+j; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPWbKv+j"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b0b260d309so16435ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 16:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774567123; cv=none;
        d=google.com; s=arc-20240605;
        b=kG0Hnk3nzINQShpgvps3OrTCa1RjFe1Dd9JtVJ53nz98gAJN+DujOgtpJOMj7Q1zTe
         4QUSSzBnP4S18+5jkUTvamjdFwfcIDiOCNoi9XKos0M8j6IEFN4BSG8gBozEuxsdJ7JU
         N8YNfba0sqlpeKcJPuAIKKyll4Hux7we4gIffRqxwtfFPCmar1chk+HZMl9Cc8XkXO9Y
         nyyExBJwuVx29d0YPldbdwmuWri1oHtRsB1wJhT/8X0soUSlLM+Lli1u72AC9lomvsDL
         7M4oilDrb+mBJDN7EaSV2CruMO5/MbDva7Qm/3mH9Nbs6TEfW1edREBe9IMFe9B13oJ0
         LPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ec3PBtBgiO938JeRREBi6OOYGpbVXXbf/ajeBJC6pJ8=;
        fh=8IAiy6UZvc6lBFNimgWItUkrK5DTsfwt7XZtqEglyXk=;
        b=UKV/AAnnq1vzZeCKraYt/617b2FlEmNOkSpHGF5+rEHEAtFpiAko/qV+CIILM/QyWu
         Q0M7kZhUaFLYw93nbjdlPkHuvfmy8mW75vHzRq2rhl6Ka1myPLmU54u5uBPwVMf0sIZu
         bTi4by7BWJRHDNjKLvF3GhBIl3swdcDTNEk5tzYPl6JJsNyIgHyGAN50ErzOfhl5fgfE
         x/vA5F59pQHo4YtlaAD2Aofxp+cAgLwBuxVPq8BHdHNF6B6IO09107l76wVJ8HZi7XcY
         /kGpT2xvmuWj5pgyIKWoFHYSgbXF4GymsPwvULcnGpu5K0IUpJCboOfBI/V1KAr5TNAB
         8zmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774567123; x=1775171923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec3PBtBgiO938JeRREBi6OOYGpbVXXbf/ajeBJC6pJ8=;
        b=GPWbKv+jwKjKJ6myTZf5vq+OSMbATUoP/U4x8Htrp5BWUZfv7WYj3F6Uv8xe3HpCuX
         J1tIgshYbjyMMS3SfQRfzZpo+iG+xPQsn/DLmoMO2uKZ7QvwUipc4oXBg7kb72zDjgus
         LRt9ACUJoo0c/EwbkFmfibuEX4sWRScBpCxGjzCUYXoQb+OCvqfFclIARZR8083MYiPa
         /eIPTtl90lRN/0PcHzTXCEcB9+/a24WR8FBaprnnrRqoNaQUqNJSYx0zc6177uSa6tIP
         ee0hJG8+Q0v0ydfXDjoAzTdfXTd9yrsHl3YUi3qEa8xFBdiNdXoZNt93RyFNDx8iiSMZ
         Ap7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774567123; x=1775171923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ec3PBtBgiO938JeRREBi6OOYGpbVXXbf/ajeBJC6pJ8=;
        b=APn5SW1CXOoyhvtLxKZklQ54LO6qQ4EFtZw+bdc62g/xY3/MUsW1L9U6Qog0VdIpoY
         LKvdP9vnDL8z+GjLvW+eY/IucQX9jlpDZTFPq5jk6oOFjFB483R45E6xCMYV4V0GCBvl
         inc4YrsXMKQ1Y3Zqr9l5wN5ab4tgZ4HGhujVATT96qs5tDNkY++jX1bTxJ17BS8PAJVg
         L/BBTRILxGYBFUbdnda4BBD52d67DS5HRU0fn2owbitVo6bckUsNRYeJIT86FE6O+eMC
         q1hKZDserjmrOGzZrKw4LtwpteIpMC01poMJA5EPiVQV7Sd5Hl9/HmdW6Z31T6ozfMBl
         m3qw==
X-Forwarded-Encrypted: i=1; AJvYcCWLM+zUABQisaUl8McE9cYE849N7J4pTmWeI1sgJFZubu96mzbuC9R75nWJ0EVpVv4ZFexMQZ9qFIbi1+fUuw5b@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7jsp/cngIK6yHSuliOykHXgUUOL8Lhm093RL2o9bZ/RGvhX6
	fRrecsFiTb/Qt83W23c6Td4tXZTG+UYJL/gr3+QGgE5TW/5JUtGMCNHXJkAZrmiaI9ZF9HU5RV4
	Fo1qZTu7ilK78u9YXRE6J7oRUgc6mN8iNNETBJhc0
X-Gm-Gg: ATEYQzxxIiJFmOdkWcBjl07aSHiOToDJ6cMHqkLQw/yOk3CUd4aASayi1Snt6n1huNn
	PzLR4VxPL/meMY0bH4Df4yx71W3gz6xRN19Z6FQBNqrQ6kcDVqaSsOTXK+SxzsfkOFst5i8E5b8
	7MS4MPIIHcVefHlktUqm7E/vkWfIRZlSYoB6CegKklCFN9Pjgikp1muInlpG5wRIbozyyYA6FAf
	MUIfcnZewYdgvfGaeBcbj8+AuP3AL8Up9b92FwFs2G3Y/3bVmvh0zlPEXS8NXLS726c249bxrrq
	Zib5B79f/LdnH9pdXg==
X-Received: by 2002:a17:902:d54e:b0:2b0:5fb4:c1a3 with SMTP id
 d9443c01a7336-2b0cd35059bmr745255ad.15.1774567122606; Thu, 26 Mar 2026
 16:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306191908.2065682-1-irogers@google.com> <CAP-5=fUWOKFwHZKYUv3ntxaPb1aFEEmSdo4npfe9oG3EPn7qBA@mail.gmail.com>
 <acWwYcn3QAznaw4x@google.com>
In-Reply-To: <acWwYcn3QAznaw4x@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Mar 2026 16:18:30 -0700
X-Gm-Features: AQROBzBS0jozkNAYig-Go78qDmjFHztRfngLwGOEH-xG_Y8loADsg8GQQbwki8s
Message-ID: <CAP-5=fUoNq-LSBBjGGKYbvpDrbn2d-X7JHmAURfqxkTh_qrc1w@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Add -funsigned-char to default CFLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Mar 20, 2026 at 04:00:56PM -0700, Ian Rogers wrote:
> > On Fri, Mar 6, 2026 at 11:19=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") made
> > > chars unsigned by default in the Linux kernel. To avoid similar kinds
> > > of bugs and warnings, make unsigned chars the default for the perf to=
ol.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you know what the actual bug was?

I don't, my motivation was to try to avoid sashiko warnings about
issues that occur with signed chars.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > > ---
> > >  tools/perf/Makefile.config | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index a8dc72cfe48e..3820bdf73f43 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -349,6 +349,7 @@ CORE_CFLAGS +=3D -fno-omit-frame-pointer
> > >  CORE_CFLAGS +=3D -Wall
> > >  CORE_CFLAGS +=3D -Wextra
> > >  CORE_CFLAGS +=3D -std=3Dgnu11
> > > +CORE_CFLAGS +=3D -funsigned-char
> > >
> > >  CXXFLAGS +=3D -std=3Dgnu++17 -fno-exceptions -fno-rtti
> > >  CXXFLAGS +=3D -Wall
> > > --
> > > 2.53.0.473.g4a7958ca14-goog
> > >
