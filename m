Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862623B6C13
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038507; cv=pass; b=aSOTfikOiue6UhGsfFb32TjsEiQnUx+nsIcOLRH1CGH5QeQIrCIzSZLeAqpFhuxTKvJpF5WTmDOHl3z6BBNr0w4O9GEV/qJx5O2eEiVbN/UU6YAz881JBJInTtwy6RiueIJ/azktSPkMXI7eA5+f908MP5QyBdUXh+Y4jFSM3AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038507; c=relaxed/simple;
	bh=aPJ6l4K5VDLP8O6wMFzmNPEZXhlE2m0bYZNICDB9cRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtFQzN4okmb9MSGZQdbRbepYrtFh1GXvrv6XqqNHXMysZTy2fM9z+bkrFJTnAciR5Yif49mogPxZQQoJsIeFpcevY5+bT7LmTH2tAheSygzX9vUj3Onma60oF499uVnqMbtDe2BoBZq2RDSvpQKwHZNq+oKUAkwp7zCMGE6s3Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FB/NMBt4; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FB/NMBt4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso685ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 10:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779038502; cv=none;
        d=google.com; s=arc-20240605;
        b=Xh64clXyrkeU6VFcrDCt/42Ikgg7j5dp2uxGhYXf/8oSZLxKKt4y97AQhZaWDVJH4k
         vd2BrZXNjhGdhcrTl6g0ftut6TzqgfxEctqw+T9bDv97eqzsNE5PyLQC6HCPZt9HHOCG
         8SS4866nFrg3OKx9TyflBRoli1oG/imOp7vf9kkZOOdudGS8609diNCQ+iNfRmuzTgmi
         vLkc5O5diAMXch196Zxhayu6pw5IknPi25pzaEAhCLFoUmBG0DBa8/7LGW1vZ/23x5sz
         MOr235WrYWdtFkh7+NL77SWYijrzhBPcnmomltzRWMaXcVFYJ3m/fXL7peSzSp1jxcV/
         vVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aPJ6l4K5VDLP8O6wMFzmNPEZXhlE2m0bYZNICDB9cRg=;
        fh=BAOOSYhhIFo0TZtd2jqvud0KgY+sSw4+RctYQXQjEyE=;
        b=RMxOzcZE8qaclMrFNmEWIBFIMQ40OLCVyjXLaVYv+kwV0u2q2ODWnteRcv+eJdRCdU
         owq4N2XoWlxwavg905h6C2Q3KUWU++aYagOat1bbImIM341qNu9TbGtKg54jIO0j+gfh
         lL4Ewun7hsZJ8hYnjWn3qMIlSgMfr443JNYDXEsoYUYMrnDgKlDvlt9zibd/fhMr0tQb
         Is0fyxBqlLhEQkBWzP+qO2G1UnLHQpbbhoLjZrLIZn1V3lUCA25yYTsUTACo4RSbBGJX
         nr7DYtiXT+yCeKNSYTpSIfzCfb9g4Brm+hP1vTb1zgEWRrzb+nwLBgtCMlmeCpaRAoky
         qsFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779038502; x=1779643302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPJ6l4K5VDLP8O6wMFzmNPEZXhlE2m0bYZNICDB9cRg=;
        b=FB/NMBt4XcThAE/FeQ2s/y+TYiStDP9IDghTNeutCLrDbmRaa6M46/GS7mEtYfgORj
         B4kjiT/ApXOF3trjl7pHGuFkg9uDh4KP9qId8B1T4D6Vv5CaXY2SIQminHuzNO5QAvjq
         AHZgGi409EKogfhObEjtIMFqqfKBBQlFChwSL4lsWhl4VBIIgfiMU8wsLC5/evkdLJ9c
         DbbrxaS8nC4/tRwzPDG4wKzvCMxy1JOy9ymt/HkkbScU7SsFMrPKnEmxq6Rkn3Cqa+Gy
         8qihVdww9mynsG9XY509qTZqRucm0MpMLQZuteIEdGG3y8AwoRg2WdeUty7WlL3u+h6T
         zseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038502; x=1779643302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPJ6l4K5VDLP8O6wMFzmNPEZXhlE2m0bYZNICDB9cRg=;
        b=Dq/ye3BuMoU1AoQFRTd6ajpP++YiVrlBd9izHNbvs762nnRXnjJkOVP6/AQMLddY8z
         yJD98+z9wdHFiwj0mfDe7Mq2P70AKA23g8z6l+NxrajdvqV/kC44cbyC1CIgwSke9IJq
         NEwJe3PEbz+ppisMLW3CV4Rpp6mmrYM0gMdvpqaHkX5Q0AdCRjfVgD6hz+9WcpG3yENM
         3V2vTxlKdRiriOj3gWvlz46qRgo6ZQdfktuXMjEYp0++fUSVvWRLs5HXJpzbt5cMxNmL
         +IKtl0OPU3cChHtBS38Bx96ai6Pq2PR81sXLvLCj4iy1kZdMUmj5Ugsg2wPhw6p6+bPc
         CuiA==
X-Forwarded-Encrypted: i=1; AFNElJ/pc+IApVGs/gpN92C4JIpWNbRAJheSpXuujfhBe+wkYP+iyGBzSaQbwdzgRKWZ123dTtcAwq3cB5IAxW9pYY8t@vger.kernel.org
X-Gm-Message-State: AOJu0YwENW1q6oTH+BvfH5fKG2RJeYUVGZ/wHLEhJ12TYNp2gvye+QEM
	/uUYRxE+eKWpmQGYpvStLg0S9GTfqHPg/pEx/AVE4j5zN89aDRvttAQaFpofvMSy1BglkvUtjpa
	U/i+p4gu6/+Fo5yKeiwi6100zmTaUB/NZvPQ6fi7x
X-Gm-Gg: Acq92OEHpI0bwSuxxUyW+LdqyEZ8qN0pd/8tJf3ywct1awZUeVWiklQ4kO7CMicqFyL
	53ye98avTQwUkcoYmcdO1zdbzRSSJ6ISHsCGLUF3x1dO0RHPGLukH+2GOYQ2FgDaTYapiB8NTJP
	ClVo0rhrgt4P+LlHjwtSCZSvvbtCvfBO470NToIstfJXWpDnsweeEy0opAdg9NSHyMy6xjgqrIa
	SXhAuL6oHpG79zW5RH350xM+jxcL2SF10z9POM/Tt6duyzkBqLdh5A8ZN4zgiQMCv2USdDxvqqs
	0vHVKEnJpely+TNKPOo=
X-Received: by 2002:a17:902:ef52:b0:2bd:6dad:7ccb with SMTP id
 d9443c01a7336-2bdb32bb6damr1621875ad.23.1779038501863; Sun, 17 May 2026
 10:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515180806.246914-1-sigmatwojastara@gmail.com>
 <20260515181547.99D82C2BCB0@smtp.kernel.org> <CAP-5=fUV6W=TBXbCHARMJwm1Pjb4uJCO82EZ3fjU7jsiR51t0w@mail.gmail.com>
In-Reply-To: <CAP-5=fUV6W=TBXbCHARMJwm1Pjb4uJCO82EZ3fjU7jsiR51t0w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 17 May 2026 10:21:29 -0700
X-Gm-Features: AVHnY4KdT5rjjwznCh38hIDbeBmXMvzC1f47yJU-7v-Yd1spQDbtuPjNa7IT6DU
Message-ID: <CAP-5=fXt50fNw3=CCJ97VHGAb-8gzjEz1fPfnVK4kLQbWXSJvw@mail.gmail.com>
Subject: Re: [PATCH] treewide: replace /usr/bin/python3 shebangs with env python3
To: sashiko-reviews@lists.linux.dev
Cc: Oli R <sigmatwojastara@gmail.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:40=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, May 15, 2026 at 11:35=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Commit message states it replaces `#!/usr/bin/python3` sheba=
ngs and causes no functional changes, but actually changes `#!/usr/bin/pyth=
on` to `#!/usr/bin/env python3` in `tools/perf/tests/shell/lib/perf_json_ou=
tput_lint.py`.
> > --
> >
> > commit 7d3e9689ede53be80434b3ba8cd07c27777d11ad
> > Author: Oli R <sigmatwojastara@gmail.com>
> >
> > treewide: replace /usr/bin/python3 shebangs with env python3
> >
> > This commit replaces hardcoded /usr/bin/python3 interpreter paths with
> > /usr/bin/env python3 to improve portability.
> >
> > > treewide: replace /usr/bin/python3 shebangs with env python3
> > [ ... ]
> > > No functional changes intended.
> >
> > Is this description accurate?
> >
> > [ ... ]
> >
> > > diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/to=
ols/perf/tests/shell/lib/perf_json_output_lint.py
> > > index dafbde56cc76f..dccafd507bb79 100644
> > > --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > > +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > > @@ -1,4 +1,4 @@
> > > -#!/usr/bin/python
> > > +#!/usr/bin/env python3
> >
> > Could this affect functionality on systems where python defaults to Pyt=
hon 2
> > or is managed differently?
>
> The change looks good to me, but I wonder it should be split into
> separate patches for the different subsystems. We do not care about
> Python 2, so I think some review prompt improvements are necessary.
>
> Thanks!
> Ian

For the review prompts I sent out:
https://github.com/masoncl/review-prompts/pull/62
https://lore.kernel.org/linux-perf-users/CAP-5=3DfW5Wozj=3DF2dnXoLTWmUjudNW=
Lyjjg95CuP3Jk9bLcYwww@mail.gmail.com/

In case you are interested, I'm trying to clean up perf's python code
in this series (v1 sent Oct. 2025):
https://lore.kernel.org/linux-perf-users/20260428071903.1886173-1-irogers@g=
oogle.com/
Testing and reviewing is always appreciated!

Thanks,
Ian

> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515180806.=
246914-1-sigmatwojastara@gmail.com?part=3D1
> >
