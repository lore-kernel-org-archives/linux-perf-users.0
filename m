Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094C2F7ABE
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955339; cv=none; b=s4TU3Auev6JDpRe7xTzeCcmbE/pmzOASpvZSSaXLBQ7uSg79rYHBiw87nq225rOFnSdkxHTjAwJFqKEzspWbHY7zVQ5mGjU+O2E9h8BLgS+akRgm08FKraZLs2kGwtHtad9EJ2wvvJTGUiwqSQuRgGWZL/JP6MSaxCwLORiahsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955339; c=relaxed/simple;
	bh=52ZsU3ePKB1InIkoNAekenbzhEaVnJwRmjYnor4JiCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3nC+bmeH47n4lrZ38rMeuwupiwv/G91nUPtczb++NOIvnHvvYkaR70AGAWpy6NyjMjc5xJVK6sQdNE9dgxEFj3Lofqurz1NbXj4svW8y69NL22lqGe+ir+RHDcj+g1nnsmRuC6RJWXMCTt+aG6VS2AYgnWctyA4A+YAaWRMo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54bc2d1feb2so1082396e0c.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 03:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955336; x=1761560136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUbvofgciVuMluMzU4YVVNTC6kjSTZJr5htCPGRw6ic=;
        b=ur8NPTD2qNLDMeN2Oj7myoVCGJl9CXyYNmYgaF9EUrAVx+0OS5gv9h82sMJJ2f4k6o
         7dQD0rhBtFzxxPk4rKtwM2vHWiJyjfxCjPZ4Bm2v7pjS/Ertncuma46PaJnVer14WYab
         ZWVkrEil3GIX/Uf0hGeswkefegG2c0FW1MhDqUdP+DGMy1J0mzrmxQUjWQfWB0Ufxk1u
         cRUdFu+hF+haf8bbtNiLtnkTvVP/9a1BeKToiJbRk1Nv9AwrilfwauIuqKbDHPbXm7L9
         xg5Zw+ORAgw5PlOFhVp8qfu6cBUgglC4CDHLiLBXlMM1ROmOl6VfUPmv+QqM2SQ6V9Vl
         OHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUozqUNJjXMD8lfX/mtaG1emURbwgbdO3A6+1lByxWhiZ2Y3ecw0ZRIGgf2v00tD9UNs7LegCrugpWI+V1OJG3M@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmpt9iZi6FuwVV6G8FY4OH8o5KDslCz6w9P+89h1OQi7RTfh+E
	XynjZTL1RXXqYuLVTLcMO5WjjsX7Ys072IR8YWFnbf1T3PsuK7j96uQ9ILxYtqoX
X-Gm-Gg: ASbGncvvBDnFE9OzMnvJi97VtAvSqBet043cLIhH0rpJpXvrDddoDRT6TEsO/M6GsO5
	665peC0ffPjI/zkxG24+ra5e7hi+iw37WiXsIx/jTof11WDWSEZLSf8TzA6Sxrxbyz9oJWyZPuC
	5NjfBPIkTMA0QoxrmC69KfY/FPsLnxLbmXJKyUfSOKp3QG2jPkHrk7dckwwHZKYg7LOeeUPibbq
	KsGyO2zuioYN8q+O1CF7i5Bu9ILfhDNr3jZ/fZvfY20sVs6zjxVEWpRgx4o7xauatRnIKRKt+kB
	SNa+L8CcG49Ff/xGEyRgn01xWYaShiYTGZtU5f3SXEN7L78k4hupjn8QkrMse1KLbYQwPbWWr7q
	LNdj/7YpmJpYwJvrx5KJzgbemTO+awxngTMbmzJFAq8FrRxetMKf7vAEj0dUZvUShTQ1lEoKa0n
	C068P+vFKFYFDD/PD1qpqiv/AkbbWP9bBYex2WXdui++W+pU3u
X-Google-Smtp-Source: AGHT+IGZJ9+SVypq90qVU9crp3Z3YRu7WfRDWzh2wcnRcgxCEkyP7Tmt5qiFwNzBueIa4g7DfDs3qg==
X-Received: by 2002:a05:6122:17a1:b0:54a:a782:47c5 with SMTP id 71dfb90a1353d-5564ef717e3mr3650528e0c.15.1760955336182;
        Mon, 20 Oct 2025 03:15:36 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-556620d8cfbsm2153886e0c.20.2025.10.20.03.15.33
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 03:15:34 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-932bf9df69dso813233241.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 03:15:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnr50g4MoMlWt2D1NpAcZYzM7A/OFmFotVAqJyNE/ru46u+jYjZPaPehPAmDVpZCGsYZJt0wXB/p+0AaM2J0hG@vger.kernel.org
X-Received: by 2002:a05:6102:370e:b0:4e7:db33:5725 with SMTP id
 ada2fe7eead31-5d7dd569c1fmr3248923137.3.1760955333656; Mon, 20 Oct 2025
 03:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760617634.git.geert+renesas@glider.be> <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>
 <20251017122904.GC281971@e132581.arm.com> <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>
 <aPRR1APPW8vro4HB@google.com> <20251020093136.GD281971@e132581.arm.com>
In-Reply-To: <20251020093136.GD281971@e132581.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2025 12:15:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXEBX2CK8iE-Mc0dPR5gV5dBM6QU9LsEWnWgO-d=o6xVg@mail.gmail.com>
X-Gm-Features: AS18NWDl2bzoRNKUcQqaz9nernt5F1E8AQVWG3E40L5verOaYk7mqgLhzKsWB4g
Message-ID: <CAMuHMdXEBX2CK8iE-Mc0dPR5gV5dBM6QU9LsEWnWgO-d=o6xVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf build: Add Debian/Ubuntu python-is-python3
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Leo,

On Mon, 20 Oct 2025 at 11:31, Leo Yan <leo.yan@arm.com> wrote:
> On Sun, Oct 19, 2025 at 11:49:56AM +0900, Namhyung Kim wrote:
> > > Aha, I found it.  After uninstalling python3-dev, I got into the same
> > > state as yesterday:
> > >
> > >     $ make tools/perf
> > >     [...]
> > >     Makefile.config:875: No python interpreter was found: disables
> > > Python support - please install python-devel/python-dev
> > >     Makefile.config:918: *** ERROR: No python interpreter needed for
> > > jevents generation. Install python or build with NO_JEVENTS=1..  Stop.
> > >
> > > So these error messages sound like python is missing. And "python"
> > > is indeed missing, but "python3" is available.
> > > Hence I installed python-is-python3, but that turned out not to be
> > > sufficient.
> > > Hence I also installed python-dev-is-python3, and that fixed the issue,
> > > as python-dev-is-python3 depends on python3-dev, so the latter was
> > > installed, too.
> > >
> > > After removing python-is-python3 and python-dev-is-python3, everything
> > > keeps on working.  But if you never installed python3-dev manually,
> > > and run "sudo apt autoremove", python3-dev is uninstalled, reintroducing
> > > the issue.
> > >
> > > So just recomming to install python-dev-is-python3 in the error
> > > message should be sufficient?
> > >
> > > What do you think?
>
> Can we explicitly suggest that developers install python3-devel or
> python3-dev instead?  Two reasons:
>
> - python-dev-is-python3 is specific to Ubuntu/Debian; some distros do
>   not provide this package and even advocate against using unversioned
>   "/usr/bin/python" shebangs [1].
>
> - As Namhyung mentioned, perf has removed Python 2 support (at least
>   this is claimed), it is straightforward to install only the Python3
>   packages.

Suggesting python3-dev sounds good to me.
None of the two checks:

    ifndef PYTHON
      $(call disable-python,No python interpreter was found: disables
Python support - please install python-devel/python-dev)

    ifndef PYTHON
      $(error ERROR: No python interpreter found for jevents
generation. Install python or build with NO_JEVENTS=1.)

seem to be about the python interpreter anyway, but about the python
development environment.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
