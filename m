Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D984D7948
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574072; cv=pass; b=R3ipKFwPspzzYlO0otu2+TCmEo9C6obkAtibAs/ssZ/Mm5bTyuQ8q0n17fF3JdH14CgBpTnrLY4SchoLjh82boMiWIs1aXw+SwJmZO5hoVy0VQ9Te3BXJUCYT+dxmvKM73Rop/6xpHf8W12+IHf81bwrkyarh/RA2vSmMMVt9As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574072; c=relaxed/simple;
	bh=7TPfKC0S+AyjVWxEL3kMuQSa0P4aYfLH4X9y6XPnkiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgmIwAK2JwhB3Pc1NuzhKjFa93EoadpLhtqg82FAcANUcSv+zLOnfZvtBivCH8bqJYYPll5oHKk/Ck8cKQPC/mbHV4naGVBorqtcVKRObIKafE+hSXnDYhYwQUgCvHX62g1CoTHA0XYJRReddL1ElmA4RJRXGqQE7mn8E+SKfBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTaUl6Fy; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTaUl6Fy"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so306671cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 08:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789574069; cv=none;
        d=google.com; s=arc-20260327;
        b=AQx7pxqP1GGvpQFMTlC6TJwkEb8qdIDo0Z/XSiRBqZQZGw320ErAU80h8f9yhdCowU
         NQBJHXHt5yBYD5KCPqPZflUehmdzZ6Me2GSykOopBaoqux2rkAXHNNkqlmS3mBwp9k9l
         Ykc8qbFSTygusmDLiJVulL/SZggfqWvZ8SdE8LmMwnUjnVtRtuYLiVZsN+jeki4RDArM
         MTbmqx/IDdJCGupY0LyaLxTe10Z07poZhHTM/QqERuy0ON8qVSjiN1//55Xf0C9uvQ4m
         AlL0FRJy0QhOUCHYSpB02Gqg2gr8oKM1r0xa5MQJMidVCo1XU6Dp95AFYnIz5j6MeyO5
         5+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LakOb0bCO9P4LHmMzGLPHsI3voGyQnWQGSKhp2smfTU=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=SBJFNyfdl0Zm/hz41eIyq8AHI6Bb9tDEhLtE6Dz7VyWgO+ulWrQFFDGr2TLOB7TpLd
         PFPjWj6dXg08vkMYqwM3+kiJ6T/CPvfaSZo7SRovrBXxTtGB4jI351pcocFISKtKWSX0
         j5VIFHoraWl+z9LoOI1dKq1K9V1WqWANfaK8ickZajPXvWRCo/QRcYnjyN7NHR+Dbc6c
         yOHYt1BQ/1jdJg4pecjtj2tTo7LVS35XqOL9wlV3VjeJ4DshLMX6vEOi1RQQHCug0H65
         abb8fp9gJlL4qnlllhGo/ApYH2JxX0bYb69ZFrEdcaf769ZkMZhJJJvJ879zpC/Dbvsk
         QsTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789574069; x=1790178869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LakOb0bCO9P4LHmMzGLPHsI3voGyQnWQGSKhp2smfTU=;
        b=wTaUl6FyJXyhDdlQuQlb5P+pazC7XMAClZLjWUdG2nFMbQS0zYAcGhZIhyvsBtAZwD
         6/Ywu4LyFPFgR766o06uihZ7LMMdvconwXcIh4CmPBYdgiHCWwq9XnC2Aqw7paeKUC1h
         0NlxlCeqF6Wrxi9OIIVJsvz0tDbGvm04WoxIOPSd1vvCY4JTZRTn/ejQY2FpsGpbm3hz
         fIx1ogFocGBhIBmWO3oKWoxyinZeYEJO02w1yv8fGYx9QlG9TOwUm8U7sgWHuS+45vXB
         MWpMpcswXcca1xgmBiNapM7FRtLvtsXjlgDw4Y80XKQtiQDYFBw8lpHBQjSTI454Y0GD
         uIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789574069; x=1790178869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LakOb0bCO9P4LHmMzGLPHsI3voGyQnWQGSKhp2smfTU=;
        b=hqCwb7wfgB/s8R6sAVXpve0VeKiPxrNhmATDikiIGUe0aHH+Yo1UU9KbBVF03YQiWP
         OKUvPSQ9sbXsXTaVUnoVkJSVbRDU7qkplc9Cdxi1BoJDt68pYdirMZH45pD0f6QKxH8T
         TWSki6EYrrDncOkoRQC9TnirvzPMm6/xktEiQ204R+Pb9vXJO1hSGuJTOWiDkxPUPWdF
         bHj8RevEUa4Tkw1eJFujDe3TmfmqX1lgGQA74I5eu9byDW5Qp4O5R7ByyBB7IoBQC57T
         vhzYCkT70YN8sl+8JXEPD1hnsx+T+8xMi36hhdbGlrRLg7zjaisuuHm/p9rSM5GkjpbS
         jHjA==
X-Gm-Message-State: AFuF++lIm7ZjzW5WDadMfidJpW4Dj9IhT1jpoiQ+WGlBoCwTD7SlDF4V
	MMwhiXnhsd61p1H83yD0SNaQ4UwJKwtdCCmwNp2bZJdwV5cWjLBbDG7vlvjZrPwmSoVO8pAx8T+
	v5oOyNUEL17NquVm4/LLY2CMkkuUV28n2jdnnKvBVFzcdmQaeq9msd/rvdB1NTw==
X-Gm-Gg: AYBFou22hB+n//aeqwR5+XvEK1VPWwAQgmKqHU3wyFBjLFFBAhtnwbrS6IqtsuxmAbE
	isA9K2VTKABvLo7BMf3+iUgoycHfa+ZpjLczkYPilKbrGIgGwrOtOM7VW2yAYoStMzEjwwraOg+
	849hnQIjBuhEI1uXb/GuiZoobtuUu6Ir/6UE0JMiM9PYHe0eE/TFtdYJAfDXWACHZLuPxYv78pN
	/xJozfy02NxMJiHmBLyoFM2vyOuaTz+5v8dDHDKhn/03xrj82/Dw+uZBrXaM+34NSePB0w3p379
	CZl3W9LvFkxupXYW0fHBBhmHh2qyCSu81rarb2ETu0sjNi6IJt79Dd4poVSsJk6NwN+OwsMBzp+
	JBNUnq4t0
X-Received: by 2002:ac8:7f09:0:b0:531:282:6560 with SMTP id
 d75a77b69052e-5327e6f2a86mr15289401cf.15.1789574067947; Wed, 16 Sep 2026
 08:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916061218.3061216-1-irogers@google.com> <20260916061218.3061216-4-irogers@google.com>
 <20260916062233.192271F000FF@smtp.kernel.org>
In-Reply-To: <20260916062233.192271F000FF@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Sep 2026 08:54:16 -0700
X-Gm-Features: AcwNN1V-7vNOQhejVrikEYGwQUihp15qdbep1GsDRqgE0RceZn_9nikCmJynvoE
Message-ID: <CAP-5=fWNMrnB9KNjCGOc0A+kwvWWsxYc092x=q6CLK+-g3nwFw@mail.gmail.com>
Subject: Re: [PATCH 3/9] perf libbfd: Include the headers that are used
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:22=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] perf libbfd: build failure on musl due to missing <stdarg.h>
> --
>
> commit b4b64b7fbd73cf480fc5aaa2ad17802e8f46fbcc
> Author: Ian Rogers <irogers@google.com>
>
> perf libbfd: Include the headers that are used
>
> This patch explicitly includes several POSIX headers directly into libbfd=
.c
> instead of relying on indirect inclusions. It also reorders the includes =
to
> group system headers before perf's own headers.
>
> > diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> > index 131bfedf48cdf..1b23a261a9ced 100644
> > --- a/tools/perf/util/libbfd.c
> > +++ b/tools/perf/util/libbfd.c
> > @@ -1,5 +1,19 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include "libbfd.h"
> > +
> > +#include <errno.h>
> > +#include <inttypes.h>
> > +#include <limits.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +
> > +#include <fcntl.h>
> > +#include <pthread.h>
> > +
> > +#include <tools/dis-asm-compat.h>
>
> [Severity: Low]
> Does this inclusion order break the build on musl libc?
>
> Because <tools/dis-asm-compat.h> uses va_start and va_end in an inline
> function, it strictly requires <stdarg.h>. Previously, this requirement
> was satisfied implicitly because it was included later in the file, after
> other headers provided the necessary declarations.
>
> Moving <tools/dis-asm-compat.h> higher up in the file exposes this missin=
g
> dependency, which will cause va_start and va_end to be undeclared in stri=
ct
> environments like musl.
>
> [ ... ]

I don't plan to fix this as the issue is minor and relates to an
include, not the code itself. The series has no other Sashiko
feedback.
https://sashiko.dev/#/patchset/20260916061218.3061216-1-irogers%40google.co=
m

Thanks,
Ian

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.30=
61216-1-irogers@google.com?part=3D3
