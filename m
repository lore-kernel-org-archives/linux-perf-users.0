Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74428643C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772087800; cv=pass; b=nWTzW9lkE/orId+PB/40nO6ypXTSDPWo9Xc2OfHCbbfQm9Apgzw0ugdpRctXiIjo/DAjJ2sbL68aTPpAUgFSVWBm0K1y0OupREJ+fN50depm7+44f+aS3DYk5Xt6OgSOZWw8OG7ITebyF4HiN2C4SUx0C2mvq4Wr5V4bXUxtqHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772087800; c=relaxed/simple;
	bh=yt5IIGsEWrfvUvn/rqHDDVc6/F1dJ8dUZ1tyqFuOBSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8DAd8kAXDJgjo2GNT8gX4yk1t/nkBiD1LQ/akfc59WVOaiyYUwhAkrWJg/0Ub03d5ZlFgKtO5g7Yn9+QFGt38xq3+IUsLLqrpbkUQKqo8IEpQCw/XMBdBQdioXm5TBJByVQWP3d5TK17iYGlL8jPlk76qpTb9Z2s0VTRci9q0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyGrmHI9; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyGrmHI9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a964077671so64705ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 22:36:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772087799; cv=none;
        d=google.com; s=arc-20240605;
        b=WjgJOaGVLZSHU+EaBTfUYRh17qtodTWpZs5F3W5cdO8t69kcyqDfstGvwqMY+9rcNu
         OPeOkxYLFn4YeGIvLq49R3/5lNIyvEhTMqms5FBVLlA/sLdO49slHY+Xm1WNNUs/sl58
         XzSmkwkG10EMtOhJc3xI/S6jpqcDMWbRFTI+bL7MIMf8yuCcEFBofJtppRxFRQ6FJeJH
         N3Kd4PNXtIUB1ybERyxpFL5oG8kNhFY9PK3s1vA6IqtO6ZZf4nHeDYmS/lrs0Jzp4GCP
         7ZvLZ2zkMTnx0dVl6yjnVYpPWKAfVEP9MnlkqicTiOx93Mpu4nnBETnszCJvsxdV0F3B
         zZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+x1O6ZpoXMSX/kmIcAH91E2am3q9attAKrhaQ1uWm4I=;
        fh=qgzjUWFzLPKdAAPeLQ6dkp9Dg48k9DwCn0Sgl7VJmBY=;
        b=fSTa5fjLIozTWcNwcmgKfCoQPKpiWkklNqj6F3xpaeSXdMgIPURzg48o7c9pB9SYLw
         KvA5kXc9U6hCnIcDhbq+ZEceIHuc4LOFBPU6M7WLBQrRaT3Heo15jlHTenqyPcT+4N8S
         bkYVFwy9WKJXGUkZJ+EtRB0rmIpCMxyufadLEKys1Td+n4E0ovUDbJhTe7KJBS44wkpE
         dQ2QX0Ps2LwRqRuGKlQcqepfIEYbwPw+Prp6KeSxcm42FSKdT1DZHuVWFBhbLVId0195
         CLEtvmn4GjQwsj+7mHXraysG4Sq8P4hZaJLe8H9jKfgD/Ljv9DQNWScv8d3NvkZ+Hem1
         A2NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772087799; x=1772692599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x1O6ZpoXMSX/kmIcAH91E2am3q9attAKrhaQ1uWm4I=;
        b=OyGrmHI9ezn2MxBtrszoBDjy2YLrZJXnp7qf4ZAainN4kKLu7eiEIsmSvBPLkEHZLV
         AFi7fQW891dPj71B1pl0ocVnwFytEg7Xm81DHvdZXpsKilufhQDPjUCK1Uyr8BDjqstS
         eO0mYaOkP14up2vcNAtdIKjLQLkwW8pPt01xLS2glDsbmURcvBeojo51gNNpbcuTRsGd
         WgWX0IHsGcd0dWLm0fli9Kcovz+yug+Olw/pO32s0XB3e2Ff5JxX5V07qN0g65jNmnSx
         5PVDpYpnNBxZW4LulFJQnqdcNoyG3mwPxffVCwmRJVy9RQz52HwBOfkj5a4JHgpXjQV8
         QX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772087799; x=1772692599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+x1O6ZpoXMSX/kmIcAH91E2am3q9attAKrhaQ1uWm4I=;
        b=v20GBsZ3HrfIm0K6jrkFGM6YxHkQI3Vhvrh6QPpbUXfRdKhoK77PztaxYUze4JzMXj
         BgG2iQHbzCM+tBGM8kESMqjcUU1311Jp9koOkKZ7nh+LZAOO3HiiuQErxTmphFNTB10x
         nN2JuCaa0w1e1J6pOeOMLvEcdhybi2csLtlzWnlolkAEYU3/irioIYkgxdSUrUTPToAm
         iwjqLv4kdJg5YT6ACVvu3/Ly5mkvflpjisS1eDwzT8I+ayTeYQW9KoNlDtDVTP7hXkLo
         FYsc2kh+NxaWITWpx7wtxci526GEtLDcAHlMmRXLeizEJiWk5S8u4mB6a+tgq9/PEgwl
         FzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUydT0iartr1qwDILsQapt6FIJtU2Bn0A/Bbq8XIp8EIyMI3geae3AsspMUEPZK1kU6YvmgL7FqaJOkj2sP8oL4@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDzi8g3Izqpz6DjCTXcEZ907IcWWgR4NCMOuZgQwtvOH+WprD
	IZyafChROVV5aUU/bFwfCecXfkKT0v1o5dy9N/lG717GULBqcnk0e00xgW0yhYVnty3r72pGPmI
	YVrJMFAmRBZkCrExvh9hwQNSA3CdYYWXhw1TDhkVJ
X-Gm-Gg: ATEYQzwfQyqVi/XpMf4VXrnTIqJO3ALkPsaYwcgLk0Zq1lqtOczcRWYpXnRXNvLklkS
	fj6jNcyHY4o0jYQDO0WpbIljcCV+EuuYqGH0fVLx+UKcRY9elYDixsBL5tuexBxrgL4z3zlfHvA
	S1Xa8+mJKyV3cNHFBiZil665QSPXiKXkj1LcMmSXX6Bq9bKBnp5TYmjUUkK4AuAh/Yroyg6AgdR
	J7zwEoDBTxlVZHHW7Kz6xbLhFufHeKhf+l0x+e7x2cR8C45mQAsAtPnmDyuE8B95cS3mHLxoaj+
	lHxJsmUM
X-Received: by 2002:a17:902:d591:b0:2a7:6c4e:5924 with SMTP id
 d9443c01a7336-2adf771234emr1671865ad.12.1772087798246; Wed, 25 Feb 2026
 22:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-perf_fix_kvm_stat_error-v1-1-ad40115876be@arm.com> <aZ-oYb-FDLVT5MGq@google.com>
In-Reply-To: <aZ-oYb-FDLVT5MGq@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Feb 2026 22:36:26 -0800
X-Gm-Features: AaiRm53BIUOQJwW49ggxSdOSGRY3N8Io5TeDCIeKAsDG4OotV6tMybLboEgFU4s
Message-ID: <CAP-5=fVCdQZ584s_24wQc_+03xL2Npj2qDbqGSjE=Ms1-y8raQ@mail.gmail.com>
Subject: Re: [PATCH] perf kvm stat: Fix build error
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 5:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Fri, Feb 06, 2026 at 11:00:20AM +0000, Leo Yan wrote:
> > Since commit ceea279f9376 ("perf kvm stat: Remove use of the arch
> > directory"), a native build on Arm64 machine reports:
> >
> >   util/kvm-stat-arch/kvm-stat-x86.c:7:10: fatal error: asm/svm.h: No su=
ch file or directory
> >     7 | #include <asm/svm.h>
> >       |          ^~~~~~~~~~~
> >   compilation terminated.
> >
> > The build fails to find x86's asm headers when building for Arm64.  Fix
> > this by including asm headers with relative path instead.
> >
> > Fixes: ceea279f9376 ("perf kvm stat: Remove use of the arch directory")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
>
> Probably not from this patch, but this change seems to introduce this
> error on my i386.
>
>   In file included from util/kvm-stat-arch/kvm-stat-x86.c:4:
>   /linux/tools/include/../../arch/x86/include/uapi/asm/svm.h:137:32: erro=
r: conversion from 'long long unsigned int' to 'long unsigned int' changes =
value from '18446744073709551615' to '4294967295' [-Werror=3Doverflow]
>     137 | #define SVM_EXIT_ERR           -1ull
>         |                                ^
>   util/kvm-stat-arch/kvm-stat-x86.c:13:1: note: in expansion of macro 'de=
fine_exit_reasons_table'
>      13 | define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>   /linux/tools/include/../../arch/x86/include/uapi/asm/svm.h:249:11: note=
: in expansion of macro 'SVM_EXIT_ERR'
>     249 |         { SVM_EXIT_ERR,         "invalid_guest_state" }
>         |           ^~~~~~~~~~~~
>   util/kvm-stat-arch/kvm-stat-x86.c:13:45: note: in expansion of macro 'S=
VM_EXIT_REASONS'
>      13 | define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
>         |                                             ^~~~~~~~~~~~~~~~

Hmm.. it looks like something has gone screwy with the include paths.
The header you've gotten is:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/arch/x86/include/uapi/asm/svm.h#n137
rather than:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/arch/x86/include/uapi/asm/svm.h#n137
where the value differs between -1ull and -1.

In Leo's change he has the include path as:
  #include "../../arch/x86/include/uapi/asm/svm.h"

but I think that is off by one and should be:
  #include "../../../arch/x86/include/uapi/asm/svm.h"

Making the include path this should prioritize finding the tool's
version of the file over using the include paths. Could you try adding
the missing "../" to the paths, I wasn't able to reproduce locally
building with -m32.

Longer term maybe a macro like UINT64_C should be used to avoid these
kinds of long long vs long problems.

Thanks,
Ian


> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/util/kvm-stat-arch/kvm-stat-x86.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/=
util/kvm-stat-arch/kvm-stat-x86.c
> > index 1cf541385a4bdee4930b67a054906ccade7301fd..43275d25b6cbccc477ba45a=
901d69c67422847ae 100644
> > --- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
> > +++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
> > @@ -4,9 +4,9 @@
> >  #include "../kvm-stat.h"
> >  #include "../evsel.h"
> >  #include "../env.h"
> > -#include <asm/svm.h>
> > -#include <asm/vmx.h>
> > -#include <asm/kvm.h>
> > +#include "../../arch/x86/include/uapi/asm/svm.h"
> > +#include "../../arch/x86/include/uapi/asm/vmx.h"
> > +#include "../../arch/x86/include/uapi/asm/kvm.h"
> >  #include <subcmd/parse-options.h>
> >
> >  define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
> >
> > ---
> > base-commit: 84cb36da81413c2dff805150b9f4db1524460269
> > change-id: 20260206-perf_fix_kvm_stat_error-a795a1dd67a2
> >
> > Best regards,
> > --
> > Leo Yan <leo.yan@arm.com>
> >
