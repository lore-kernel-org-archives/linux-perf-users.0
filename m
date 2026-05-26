Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8E3A8741
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766110; cv=pass; b=ltlatwJwypsZxDEJl6iZPaCNut6TyyZbzS5fmiONYPYgY7Sja5e1MBG2oFToab5GIMGD9hIKVmEE3u/gPtUbbBOZFzN7FHRP5TQx4IPmfc1hveNNUV+WW6gJryre7Y/onSpD3ENF8NdsCsw77X7X4CJZIa3Z1xTVzQL5lIxBbQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766110; c=relaxed/simple;
	bh=rRu/0iaWsJif1xb7hh/aBKf9EfrFCNCKKgFYn26sXOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLCxs/HGO5/ed8q02L2E2n7c2Ko5hOoNyazB3cLxEY88WtQzavFY4eEHHWR/Z2eYY0xc72goYZZcQ/E2oZTL87g/d/dqh1493bX69n9kSfTz9zyp9MWRQmHuKEFamAN2Leox7XFrHoEZXJgF9N/8cWQjhdsTs6r5GsFgqpWsGw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JiagGTc3; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiagGTc3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so265ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 20:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779766108; cv=none;
        d=google.com; s=arc-20240605;
        b=NiFQoEnJDhcHQsh8k/Pyuinoo2Lm3yvdsV6kbsttw0ibrmlhHgZbP1PXXOX7F7B+xw
         N6u+ytKk9ByN3LCAt5Z6H53lOEm1ri2zJvEQj4ZT9MICarGP925P5gFf/i6kKCkJ/szf
         l6rntlxitEhDAmH8mZ3foMOqSbr/VQK2ICkf7fM5jdBlAc3qNowYu06tU/D8tN/HGUfb
         48hfdjxTsN2DA+rJu5XV1Gr/+FinfpW/mXc7rZgub8Vf00uA5FklDea8zzSYqWWDPswd
         TmC82fekxtBzJPaD8Vh1eJvs7ssCkGLmPe56yyM7aWhiyrQbc8k04LqOLOD/BWcKc2pT
         LSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bCIgfrQN2ixgyY5Hi0sknw40cEjtfKKbdudOPWJQGso=;
        fh=NZfqYDOHp6UYNrQSGcKGSnJxQPCyFk06T2ou+cv7ucM=;
        b=GAA6j8nXHpUPJ7L4fo53InaXY+1AVqQ2QTRmVTwJFXSOtcaa5emLYs9b9dq3/Jb8tZ
         XXvt/baEpBhpR9Qz0BPS/uJ6YC3qvRkeCcLLb6GqgA6WKkviSH93JqjWKFCdH3VTGYgx
         y98b0IbguR3YfaIv8OuTSKw9HZ5Zi6bMrfTTgUN3mpWmOKGSLfnziKCEldQ0c30agGW/
         IMdaseSu1iPfdLPt41I1raRlyrBag20r2CoSboK0O0s57EHYZjJmdiZYc7+gxtOJt4Qp
         o3uBwOyn717473zjMPlgdNq7RwAy/fZTZ9xy3e5zQGc1p2PkWkY0NML34eFMmdkRI71C
         XEOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779766108; x=1780370908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCIgfrQN2ixgyY5Hi0sknw40cEjtfKKbdudOPWJQGso=;
        b=JiagGTc3kC9tnZAYFPQ2vtgoOPrJwgyD344QFPgdxjjF5paLo0i/EZMYNX1v73ofa0
         mers4t41ytnpTL6OrrCBJj4odJaYQH4Ek9CuIHeQ1La97l3Ptruh5IyUuMlgKI/hz/C8
         gJ2kUa4P/JiDWSWhxvclcTX/Qw/hx9S5vN7g61l4cpD7YG70uqOGiylLKmJoqLJsOH/l
         FOuXDNJEqyqtfqz4qZGxGq4y9vAbe9ygU7e0ni1BY84Q2+kBI+H0tLOSO9ap8H8AhU+h
         cbUgVPUwKTMLSAJojqRmxClvWBjvQR1/MZ/6V7iiVNcU67OBqWEfEq31QHrVSG9Uji2l
         qMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779766108; x=1780370908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bCIgfrQN2ixgyY5Hi0sknw40cEjtfKKbdudOPWJQGso=;
        b=OOyO7du+2Xs/ZMrBVuJemWhildaPx8vZLDTRSomanCsYk5fr6eGK+Ad5uPS6VFRB4q
         Wyr9TKxK9Nz3ve5DscO3o+urRVL1k5gGVuUiDloOrzsL3+LbiAJoA67WYYp5m9/yPNcp
         IWeTxwc3UNjSdWieRR7tOfeKzLuAjAJXqmAB7wXUxLFwbRABV89Zan/5hTFzzxyH/I7+
         LFsDYlvWgOOoMjWkYoQ7RiEkXdG63ryTTzrKHNYKzVplgSDEZKbi0UZPGr6DRXWPBh1U
         cnSMybRwyzEqoFGSINCKfut3aKsdZrfKba8gYEEXVW9d7I38qy9VDaQpK2i+rJcIsQkA
         GHNw==
X-Forwarded-Encrypted: i=1; AFNElJ84C00jg++ceZoxXbZkeNAoIxljEv3ipw/skjTrIcywWxLEDO8ESt7dSXebEjYBd0QmmY85NfFaOj1zJnKktlDq@vger.kernel.org
X-Gm-Message-State: AOJu0YwahLbTZgdvucwWj1gG2eIZ7ofF7TBC5sRZajag1lJGTTFBzAnf
	zY921B5gcov+utJrvptirJyDO157kQvREXc14rnDpfjG9XK0TRRFqa+oJTWWkM9QqOZQ//WyZOl
	v2rZJ0F/jrdIRWbY1TpRQVSwUmawxOtlyhJHkOJy8
X-Gm-Gg: Acq92OFbabEKgPEkMfE8mpDGBf3QRws7hzCboISjE73cxOa6Kozba9OqcXxaHENluhc
	jQy+YaCkyXqdf2dO2GWJ6MdQPTxLSWgHcZUqFBpiq7ZybSZdRdx/7uXumQOlJr4zgI9i0uJZBEz
	/3EfkhhyNil9wx25S8+wGMlp8t+6WUz1dCTm4nZYcFz/+ccGJzPTB4MEbM120b346FsGYXxa4QR
	Ayr80Ep2750RUuXWGsVEUxpncyUj4zhiBLOGlrJ9C6t/yLxC3z2xEKR013ndIdTBajeTEJKMiFq
	0ne8jE8ggy0fsXzCXIg=
X-Received: by 2002:a17:903:41c2:b0:2bd:6dad:3df8 with SMTP id
 d9443c01a7336-2bebf442ccbmr4086065ad.22.1779766107809; Mon, 25 May 2026
 20:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522220435.2378363-7-irogers@google.com> <20260522221338.039751F000E9@smtp.kernel.org>
 <ahTraRGMGowOJ4II@google.com>
In-Reply-To: <ahTraRGMGowOJ4II@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 20:28:16 -0700
X-Gm-Features: AVHnY4KuArnCnt7mY6XU0OGJU2WK8KdEGLopxP7iwwk64vnlxEPfo1VFnUdES1k
Message-ID: <CAP-5=fUFKEdLQEjfW7aiwpO0fEeumcJ-djDuibsd4sr5NLW9Ug@mail.gmail.com>
Subject: Re: [PATCH v9 06/23] perf python: Add missed explicit dependencies
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 5:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, May 22, 2026 at 10:13:37PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Including `<Python.h>` after standard system headers violate=
s the Python C-API contract and can lead to macro redefinition warnings, bu=
ild failures, or ABI mismatches.
> > --
> >
> > commit 37ded89f453597ef269f0bcb73c5907738b8e5d9
> > Author: Ian Rogers <irogers@google.com>
> >
> > perf python: Add missed explicit dependencies
> >
> > This commit fixes a missing include of pmus.h that was discovered
> > while cleaning up the evsel and evlist header files. It also sorts
> > the include directives alphabetically.
> >
> > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > index cc1019d29a5d0..dd937d714e991 100644
> > > --- a/tools/perf/util/python.c
> > > +++ b/tools/perf/util/python.c
> > > @@ -1,30 +1,35 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > > -#include <Python.h>
> > > -#include <structmember.h>
> > >  #include <inttypes.h>
> > > -#include <poll.h>
> > > +
> > >  #include <linux/err.h>
> > > +#include <poll.h>
> > > +
> > > +#include <Python.h>
> >
> > [Severity: Medium]
> > Could moving Python.h here cause build warnings or ABI mismatches?
> >
> > The Python C API requires that Python.h must be included before any
> > standard system headers. Python.h defines preprocessor macros that
> > alter the behavior of standard headers. Because this alphabetizes the
> > list, standard headers like inttypes.h and poll.h are now included
> > before Python.h.
>
> I think it's worth following the suggestion.  I'm not sure if it's
> possible to add an exception for the python headers to clang format.

I believe we can set Python.h as having the highest priority and
always including it first. I want to make sure the Sashiko is advice
is accurate first :-)

Thanks,
Ian

> Thanks,
> Namhyung
>
