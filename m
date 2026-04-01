Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B48324B32
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022904; cv=pass; b=bQ42WNixURVBgQbfYqdCH7dqTSXTejhfrk9QtGoD39xIY3yF9voGCDvAMlA7pXJFrsNuIA2FGejHNx+bPKNIZtFZ3bDbKjNraY0Wy7Cq9QTlqkNGgWyCDP6cVNZp5dwNC+/MDRdArFjzzb5Rsr5cRAEwdyr3TVBsETmQ07puuuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022904; c=relaxed/simple;
	bh=xjgSQ8FjrJ9gSlm7en/5l5tvK8kY4K60SnqI/ZDLLGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML1fxhTECNc/p+sy6LMXoXL6JbF/I8g0KHDCIVfJEaklhvnfXYTSNPobLXTKkFrZHlzfZxaWiVB2jnqz9dHi80TTBlg4/EgEbBHBhA63WAJM28Fe0fBPCaYBJm6kh0Ogl5LWV/zc9PMFX3KMSMedtG1IpxUmLoMK7Gbjh/0Mc3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvs5PM+E; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvs5PM+E"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b0c12be0ecso191365ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775022902; cv=none;
        d=google.com; s=arc-20240605;
        b=OANijHoIawhdV4iLCvtkIJg29/p5gTy5GaPAkkvYfl8Hg+OmgAJzocl6RkRVgZRtzI
         q3dF+JfRzvXE60EkP8xqcrY0KDBEw8tX4ZIDz/McaS6wqzbihOR0uLrz0pAJag4wFzMv
         8Y0upB/HJfkiRNwhr2OFvPxdGehhM9J14Bzkwh3WnjgzSGR2ajiLqkMHPXEb0D5Kg9V8
         HLVgaS7BakA0uUuHr3y+43NUHRxxeaoWF8RVCT6QCKVKXh2ADRj2N6kLFC6b6b9WYRhP
         GDTHXZ6uRREZFyPt1qu5MF/oHePsxrMBeCXBtG7oHgDuV/Z4IdPvnM8HyA4vE13vEiPJ
         yGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFJeknk7oquaDYRgTb2TQB2qELghhRymCjpNHO/blFk=;
        fh=0WE9h+5y7jsiiMYdsnHyd+rdyKK0GD0gwivnwgMQ1zY=;
        b=glkW2H4hfDfsKV7jmVkEmMuu/hN+evkOo8f9h8FxcVhqThlA6mY+Nme0RCL9gf2M+B
         EPgz+X+TmQqAKFPByh9Xp4G5iRNcdVc0r9B9SuVhQu24GFm0tsiWGd+mSyqIMJ3rNtGa
         f9NyRsgMgaGHKmAvbT3MNqfFRLZt+5unaAK9rpATlax6StJxAKfeFmoGTfB5ghBA5oH/
         j3npPgKg3pze1/y4nbRtzu5yAi6nU9Ise3vHYCn+hojI8KZKnW0GyWHUFJwZumQP9v+c
         3SDB5lqv3bp65rAbdnOqDmX0CzSkZoZE3GGP2hVBk5a+jIBtH41z+EVomxpnE2kZmSMo
         YCiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022902; x=1775627702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFJeknk7oquaDYRgTb2TQB2qELghhRymCjpNHO/blFk=;
        b=bvs5PM+EnbvPYJNNfSybQT3JA4wNVo7HM/9BBrMlqZEY1G6lT3BGBzzT/Vo5zDS0pv
         m0YsGkTEcv+4it6VK3Jk1HfnORsuGDxJuzhhwQtJ0iCjJ2sBTPIx9FPE/npLCyUnKqu7
         zWydjdJefDoSGw35vfn2VbCB/pJ8/66p5FrRpZTSWrZygbeipnOkXPIJkVTi//ReJH7C
         19zNsEk4dBhl7nOAD/zvCrAHqDs0+k/Y/TTZgemJmo8wqPYhxRZ/ZbSEqJAJ50in6r4s
         uSIT+2XO3ddDOPTkqtUDOiDO2xGEaCk+ednh/wbBdGp5DvnIA9EZHuHi+q8Exthgdl7P
         PzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022902; x=1775627702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFJeknk7oquaDYRgTb2TQB2qELghhRymCjpNHO/blFk=;
        b=k3PzdKzl/sXT9dDbgg+VCRoLOR01h16O6p7mUnjGlkRLpyOXruwiIwNNNPiMdIrLUQ
         qPFjIvvv3lePMiypVUvFs7KTandUmdyLCekM+YITxKYMwu4X0x0VQGoUIVuw93m3SSzQ
         xtksIfUfTfF9gZMycHzXQYLUaHkK9yu6d9055DwTLGwpnsM0LvPXXCx1c8tEZ2j3w1Ke
         iOcZRNiKQ39Fe58wHrFGmoV6NHUlg/veHDOcOta6FOM9vVwCbeTnMJX6AcbAKtyUpTRu
         SORd/CTIRPXkRTz7GFcS50kEfQPNA2gyCmmLnY7ucnNlex+JfkTNnmfmqhKB+UmB8iOl
         lIBA==
X-Forwarded-Encrypted: i=1; AJvYcCWu5fF6ouDSjvS+8uHrmjfB9WkNvWDnuQHJoWSofg9M+LgXgSj9O2UGt18oPN0WNogfkpNW/ykFlGRIebha28JI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1uliDqVKUd1ZoguBmU97aTYM18TtO/GWYaaqVt7m9qgTONRBo
	XcrQ84va26pDvkl4OeSwSB8GF8L/qpkowgihz5XkpBWtr01Cn8E99lJnSBUuvnPp2C4jFOXDksq
	GHm2kiluA7U5KQhrmUUKY60fbUff+32RhEiQJRhxr
X-Gm-Gg: ATEYQzzekAqOYCyHZPg10ywp063Nym8w2ggxIiU830qVy0VPcR5J5fhBFIKegtrIxaZ
	yLgwo2RG9yQ2gQ46h/Exwp51DQSJyYY0H7rMNZ/AEG+Xp+KdvRt4MU4g2DWAmzxW2GmYiuJy25E
	L8sy7kFNEU4x4Lyz+5gLbrShoH3lLnhiPqAdlckB6z3gpQ0Y3ITig/qAhBv0MJe5ypxeWV0Cu2K
	bajISK1GW2LkSLHuILM4gDly55LYGPHx04G5A2jDJvXg09KdmVRRLGLYyIf0apg6L6A6XIPyXrB
	ikuzj+w/
X-Received: by 2002:a17:903:186:b0:2b0:5683:1cf with SMTP id
 d9443c01a7336-2b26b258b35mr1412625ad.13.1775022901037; Tue, 31 Mar 2026
 22:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306191908.2065682-1-irogers@google.com> <CAP-5=fUWOKFwHZKYUv3ntxaPb1aFEEmSdo4npfe9oG3EPn7qBA@mail.gmail.com>
 <acWwYcn3QAznaw4x@google.com> <CAP-5=fUoNq-LSBBjGGKYbvpDrbn2d-X7JHmAURfqxkTh_qrc1w@mail.gmail.com>
In-Reply-To: <CAP-5=fUoNq-LSBBjGGKYbvpDrbn2d-X7JHmAURfqxkTh_qrc1w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 22:54:49 -0700
X-Gm-Features: AQROBzCtPQ3KXAItwolAbTcUqADbi_gOMJ_VU0BtOV1zyV6zK-IupMi2qVxIIxI
Message-ID: <CAP-5=fVsGJ-rPMCwh=dn-SCXJVMP+FUH8HEX_pG43nzfsRqYvw@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Add -funsigned-char to default CFLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 4:18=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Mar 26, 2026 at 3:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Fri, Mar 20, 2026 at 04:00:56PM -0700, Ian Rogers wrote:
> > > On Fri, Mar 6, 2026 at 11:19=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") made
> > > > chars unsigned by default in the Linux kernel. To avoid similar kin=
ds
> > > > of bugs and warnings, make unsigned chars the default for the perf =
tool.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Do you know what the actual bug was?
>
> I don't, my motivation was to try to avoid sashiko warnings about
> issues that occur with signed chars.

Ping.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Namhyung
> >
> > >
> > > > ---
> > > >  tools/perf/Makefile.config | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.confi=
g
> > > > index a8dc72cfe48e..3820bdf73f43 100644
> > > > --- a/tools/perf/Makefile.config
> > > > +++ b/tools/perf/Makefile.config
> > > > @@ -349,6 +349,7 @@ CORE_CFLAGS +=3D -fno-omit-frame-pointer
> > > >  CORE_CFLAGS +=3D -Wall
> > > >  CORE_CFLAGS +=3D -Wextra
> > > >  CORE_CFLAGS +=3D -std=3Dgnu11
> > > > +CORE_CFLAGS +=3D -funsigned-char
> > > >
> > > >  CXXFLAGS +=3D -std=3Dgnu++17 -fno-exceptions -fno-rtti
> > > >  CXXFLAGS +=3D -Wall
> > > > --
> > > > 2.53.0.473.g4a7958ca14-goog
> > > >
