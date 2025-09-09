Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441632BF47
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Sep 2025 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423097; cv=none; b=K5nWHjmNWLHE2dU1HPPOBxn/Tw3LceL3UXa+fO9WcEo5+UCe+ndql4HrLWh/MfXyUqst6S4B0AsnRhRJuSrDsOxYxveDjRK9Rh6XIZTIfiQMaLGHl29Xoycx7OiL8Y8w/8c9gPBZHkvoT1gfEWQrIb/i1Y/Iy42VyIZ5XXjYMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423097; c=relaxed/simple;
	bh=wuEDhAn7VE4XCDJgxxXZUeG3h59v9HM1l7I/5wkYj2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ky/kymyoD784zFXE65dq2IFzfQhxVSuQRHIiEoQFcx8DDQysNf1p+0/wYTzi5u20PCNLTPFeQL0X0gjeNjD3m8kOXS17kJcmw8LJwi7UQT8KIr9k9DSm2dD1kFHnec+hix5zZNUkdH1McS46laMDVRs7r/V3DZtd2/oSVBJ9Ols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=us3y1m1H; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="us3y1m1H"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b2d018f92so673715ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Sep 2025 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757423096; x=1758027896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FegmOUf8bYexzRzeJYKOCwFad+h+PFSGJuRgZi24g9o=;
        b=us3y1m1H5gNeKGbjB3usftbiEidaWlIoFHSMULr97z2j0QcsQO0YAO/F1nddFXdsnY
         2NACCT6TApoXWi6cJZ6V1cHOTscSKP/zsFOgS6dZyVjsQkjQe3tnLB0BJoKkEedwIWW8
         5IX1UlK8tfE+1OHw8us2/LhTfB7bkooMkKDA9NTVnFka4hXrGQ9T7+Sw6dhU0KynNacJ
         VkIThxUtKW6QaJGl15h22kL7TMFCsZUR/7g0v3kBHgv6RvjCDfwRPchqdnsbhFpp6yy1
         ajtEFRPFDZVq0bpHYMnWg55FZs8+2iPrLWCm7nujpfesO+D2BeBxwTjtxEr38x/ybdD6
         da2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423096; x=1758027896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FegmOUf8bYexzRzeJYKOCwFad+h+PFSGJuRgZi24g9o=;
        b=ETdZJJgI4LKVV2e1xhdkzf5H9x331QQ7FKlrWBfpBitqQ9TIcKjqPpo9oUwv/Yws5A
         toiG3F3FABi5uItLluZ7x2ihhoeU8FDCCoBjBeHgE7ZD54HTsIbQem5m/0t80bhp9mBJ
         dDKMzu1FJR8DYCMblDzhlWFiUCnUDjWzocdvXXxNvNXHuxfoXOig7kdvqSbgdbZgO0wL
         nqXDW3M9DR7JBpqxeqT6DFicSWCDZfnXE1/RJL1U2iFieV+oFZkEdJuqRtnMhiZl+F+J
         KVGfYO/8D3qy5mjGvhEJXPCOubP8+YPHJtKeu9SsEYgPpQjhmnyPOXvB578HhWtZ2raG
         xbEA==
X-Forwarded-Encrypted: i=1; AJvYcCXS/Fffw6GA7iHOz0FgOjgtlKSKPBXqUHpIaS3nU7fnCiQoYjmh+LwuLyNKA6YWaaNRUJrjROSNcEtCRNDEVnea@vger.kernel.org
X-Gm-Message-State: AOJu0YwoAzCIbvM0VeuWnLErp6RfuSZHVHVW68la7yfoc8eu6qy0krSR
	dRIrVpO7jm3Efn/E5WdIMf1MEZAkJp4k28YlQDkHCj0uONe+1i3/OMMVJsfrcXPHv/4g6bA/RhK
	XQZ5EcFxSAJgSxuj5DTk9019J5/vlZPrLtfeEny6O
X-Gm-Gg: ASbGncvj1EKAdXvA0Q3rh7SPWrx800kVHxNdkLtpeBdaUcccDPhZ++4h157JkbIa5H1
	kKREQZGkhQ/+DPsncevhi82RjOpVabR4dkMK4L7FaAPxKXicwVkV1mTdJK65wLS3M4aF6SfDU8o
	wm7nwmPrLCuByfgaK9rbzJ2vls1hWCDmB0NOLK/kTA3wFJQlDtaP0dNnGegZx6oJRlUrls1sZEm
	8mZAnyYgRxKHtPmlq8q4XyKIA==
X-Google-Smtp-Source: AGHT+IGxkBlp/AxP5ezcb05alMwdQQBJpkLO6kD0GQc8Jn7qJD8riHbmJuzzdb3s0/Uf/T4BuVR0E8LEVn45d8u0sWM=
X-Received: by 2002:a17:902:ee55:b0:240:4464:d486 with SMTP id
 d9443c01a7336-251753ddba7mr9427785ad.13.1757423095381; Tue, 09 Sep 2025
 06:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMACaOmneDrG8_pQ@gentoo.org>
In-Reply-To: <aMACaOmneDrG8_pQ@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Sep 2025 06:04:42 -0700
X-Gm-Features: Ac12FXzybYii8a916p3tX2nAHNuT8iSupwAVo96d7tCCsAUhIZreC8qrC8yg8m4
Message-ID: <CAP-5=fVA_Cduf9NvFAJezcNcg0JDNGa5q7m_mRBWNAYGEUo8bw@mail.gmail.com>
Subject: Re: Problem with perf report --gtk
To: Guilherme Amadio <amadio@gentoo.org>
Cc: acme@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 3:33=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org>=
 wrote:
>
> Hi Arnaldo, Namhyung,
>
> Since sometime we have a bug in Gentoo's bugzilla about perf report --gtk=
 not
> working=C2=B9: https://bugs.gentoo.org/937869
>
> I know this feature is not used very much, but I thought I'd report in
> any case. The problem is easily reproducible as shown below:
>
>
> $ perf record -a -g -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.818 MB perf.data (6648 samples) ]
> $ LD_DEBUG=3Dsymbols perf report --gtk 2>&1 | grep '(fatal)'
>     288067:     /usr/libexec/perf-core/libperf-gtk.so: error: symbol look=
up error: undefined symbol: hashmap_find (fatal)
> $ perf report --gtk
> GTK browser requested but could not find libperf-gtk.so
>
> I tried this with perf 6.16, but this bug seems to have been there since
> at least 6.12.
>
> Please let me know if it's better to file problems at https://bugzilla.ke=
rnel.org/.

Thanks for letting us know Guilherme! I suspect I broke things when
trying to fix python things. The code linking libperf-gtk.so is:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n809
The hashmap symbols are part of the perf-util library:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/Build?h=3Dperf-tools-next#n197
So maybe there needs to be a libbpf -lbpf for your case? Alternatively
we may need to reorder the libraries here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Makefile.perf?h=3Dperf-tools-next#n464
like:
PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPERF_UTIL=
)
becomes:
PERFLIBS +=3D $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UTIL) $(LIBPERF_UI=
)

Thanks,
Ian
