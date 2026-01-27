Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5B33D50B
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530295; cv=pass; b=TeiBtaU4V+WTW1cdVPGuCi7zH23mfQy4nDg2/2wrhqnQL4OQ/WS1fXKyygNf8cX4icgBphPkqwLaIse/r+34dz69XMpP0wa7abjJhREH+NwYURapx1IWrDzSlugUKILiNRxeVAvEo4aYa5hNKcearc59Yzc/T5SX5/zYT/tM9hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530295; c=relaxed/simple;
	bh=GvJu3aOsTnHupmWRfgd6HU0cCVtOB8EiB56nq3pcWkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0RUVvMDMvHNCM6c7NVVbdt0dOfHStIixtILGxyjfhvAUMGXdbonL9s5YGdc76zqwpTbSfXyVk7bQtsrDoiTXQrjs/Vapl3zTHmz4sSF/P8ANHJcznYQ/nM/HMk4tDEVTUeLIFvaXkJuGECnFlY3MF2Dq+lSOSxXGOalDMH+G/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dnQ9xOdy; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnQ9xOdy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a1462573caso77785ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 08:11:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769530293; cv=none;
        d=google.com; s=arc-20240605;
        b=Vsef6wqsL7Dqv3OCftUvF/Ke/ebhWgf0acjxbDGdrjS5jC6TC+6a0URvBhDfmPop6O
         PDeF1krpoP0GMdubAE5YaD51mJUCWpfF5JjEA83vP1XuBDizO+ur3TAnXecOTLmWk5ya
         3Mp6tPOinOwOYEgv19ndsYWjRDpddtU63qHuo7tgs0d3nLr2GkHMc/9XTxeauBs92Y0k
         MWRqYeU410YUN11meLTLdJD5Ly7nwxpjsamhOTLDYpKPjpkL6pAfZ9mkHc2UXU2hC9OQ
         NsyF3aAcoilmmRMZhEdB4DeFY+MtwEiKKxXHrOz8Mt7yiSfk2P1lXgSzUl93u5YncnsM
         elDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/mleTy9B4/UIaLOH3Gao4Wnx4rcDBQf6oq8eOX91jQ=;
        fh=LGN01x6Lp4Zl13OQRCZIwUGcARu2zpTyuyFLmob2598=;
        b=H2lB5YnaBx2UfNbTv3v42FcnJLJSlBd0aSjerSv4aa2EBdFC3gGi7ZKVzO9lfmxYAp
         an5GJbmsdQXPgbHi71XcoADh4tWHzvz5KElA534KBVrHuy/6uy8FgkVWvY8xWJNJEc9q
         rPAK8k5epl4mEY1wH2YFPhn0t4T+AtXCQeprlvLJfeFfqC6uZZ/LRoymB8jqqMtCYf53
         4F0fW6ulN7dOvkSHqfA9VLK2gMR6g3efv7HghqbKSvQN+eHrHxuiVqHa3/fGNLJQoAt/
         GtGtL77YR0Fc/l+V0d2P9QnigDcNHJboXie7+7kx+JL8DZ7SHt+R0ZfMO9dHRjlIw2Yh
         hsdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769530293; x=1770135093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/mleTy9B4/UIaLOH3Gao4Wnx4rcDBQf6oq8eOX91jQ=;
        b=dnQ9xOdy6kz7Tx6/F2Ysphbh2ZF6677NnZsP3FsQXKTM8fcW8Dc5JH3ZNNbCfann9Z
         JswA3q2b34b44lKDbFFrks/VYTvcHTwz8f4OgMn6tGVKA3+CCrMQUZIg3M+8cez2jwXd
         B7e3+I05suHaRGpWjAr6jGoGd12I+sGhqI+l/q71litXrIBU0SEB9l2lydQYd644ys3Y
         2nmBa9/bJ4UgSz5S5S7qBvNxupqfLzUZ8Ifb85USCZnEIIzwwAzXbYlFUwBnK4dKTCwT
         3LjBdZVcqzX3wGBtDEqH8UQMQ8j+y0UA6dQV3GL64KNlje7k5DJ3lsfp00mvTU9abgCk
         oqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769530293; x=1770135093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/mleTy9B4/UIaLOH3Gao4Wnx4rcDBQf6oq8eOX91jQ=;
        b=E09VpfJPAOnUoRLqMd+pxDRxsstyOjuoQy4gEU917ec/DuNRg9wIQurcMBQ0G9Gr9I
         MnWMg+P7eZ2Y6z4ex19wvx+TX7Q+GhkoVKVNtEPSBtJLJwDDTQ36psUlC2Vs8RwbYSOh
         1C0b6abRoDoLTyJynYRiJEdHVKDljv41KR8mErPI5V+fuNE/oLjYfc5Cut/odIt13fWM
         n3dQ9PMuRqkzi1jwx87dseHHItUwA897UCbfWs2lVeenDNxl3C9iMh55KTvoCmxIONUv
         kbHHQyYdiRFMjGTS86XdQlMVDmy0DwCQhlYaII5A9fc7MaRqmzwwytQZh7YcnsHIn2JE
         MAow==
X-Forwarded-Encrypted: i=1; AJvYcCVnnFpP7NmjJD1l1UD3g0u9e8AiKAyL3tWz+LxIwxSQBbKNKf0vYKSMa48Bp4aP8AZl4pm33v+uKippoBSz6uZR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5rmZsNOb2RKMmJQHK67NYXuNLAiBEHPqwxcg/SUzSCAnOxLj
	QP6XfBk/NaRvC5tP4DdDRmJpKKsSSopEzigyhxJ13dnWevexAEaUMQg0Jdmn61ef5o2Rck1ZdQD
	X3+wwyDFMRsZye0zzTUuauJxuZxev6X4tWqhikuOM
X-Gm-Gg: AZuq6aKfrN09ZdATvQrqII4eCxGhqIwEJ440vhjaAdqKAcKWWABV6CzXEWjW7/f9sZS
	M2/9rK9I6l5LEyMUPR9QA+7tk2TQ4nfutyo8h/w66hZ8wXkV/n5z6Ht8hwaykFaIfNqpFpuEdr9
	2UxVUllT0T82Jdu9fnF1aP0mODGGyn/UGler0XYAvkPmn7D2iPYuzbarrkOpbeTcZpuhUkSbgkl
	56XI0MDm/3/h33jZanoOjEQ3jDbpbbzjv+MCCxtIFMn+fmk6I9yGtcbwpzLvQPuAaithW6FUfml
	KHczAAqseI50yB60PkHvBvYT
X-Received: by 2002:a17:902:cecb:b0:2a1:3cdc:7720 with SMTP id
 d9443c01a7336-2a870b9a583mr2100165ad.21.1769530292678; Tue, 27 Jan 2026
 08:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127070259.2720468-1-dapeng1.mi@linux.intel.com>
 <20260127070259.2720468-2-dapeng1.mi@linux.intel.com> <a97ff1d6-7712-4315-95ff-4079ffc752f7@linux.intel.com>
In-Reply-To: <a97ff1d6-7712-4315-95ff-4079ffc752f7@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Jan 2026 08:11:21 -0800
X-Gm-Features: AZwV_QjW0pwOnDUxPFtiXQXGGTFi90qXyv8gN_Wjk26BamAh3tH23kY_UBLKyTk
Message-ID: <CAP-5=fXW2KiHy+wT16nRgQK4xboTzcTH3pMEe3=En7dwUNGJPQ@mail.gmail.com>
Subject: Re: [Patch v2 1/3] perf arch: Update arch headers to use relative
 UAPI paths
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 4:38=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 1/27/2026 3:02 PM, Dapeng Mi wrote:
> > The architectural specific headers perf_regs.h currently rely on the
> > host architecture's 'asm/perf_regs.h'. This can lead to compilation
> > inconsistencies or failures when including and building perf for a
> > target architecture that differs from the host's architecture.
> >
> > Explicitly point to the UAPI headers within the tools source tree using
> > relative paths. This ensures that perf is always built against the
> > intended architecture.
> >
> > No functional changes are intended.
> >
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > ---
> >  tools/perf/arch/arm/include/perf_regs.h       | 2 +-
> >  tools/perf/arch/arm64/include/perf_regs.h     | 2 +-
> >  tools/perf/arch/csky/include/perf_regs.h      | 1 +
> >  tools/perf/arch/loongarch/include/perf_regs.h | 2 +-
> >  tools/perf/arch/mips/include/perf_regs.h      | 2 +-
> >  tools/perf/arch/powerpc/include/perf_regs.h   | 2 +-
> >  tools/perf/arch/riscv/include/perf_regs.h     | 2 +-
> >  tools/perf/arch/s390/include/perf_regs.h      | 2 +-
> >  tools/perf/arch/x86/include/perf_regs.h       | 2 +-
> >  9 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/include/perf_regs.h b/tools/perf/arch/=
arm/include/perf_regs.h
> > index 75ce1c370114..20c54766e3a0 100644
> > --- a/tools/perf/arch/arm/include/perf_regs.h
> > +++ b/tools/perf/arch/arm/include/perf_regs.h
> > @@ -4,7 +4,7 @@
> >
> >  #include <stdlib.h>
> >  #include <linux/types.h>
> > -#include <asm/perf_regs.h>
> > +#include "../../../../arch/arm/include/uapi/asm/perf_regs.h"
> >
> >  void perf_regs_load(u64 *regs);
> >
> > diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arc=
h/arm64/include/perf_regs.h
> > index 58639ee9f7ea..372f2565a9dd 100644
> > --- a/tools/perf/arch/arm64/include/perf_regs.h
> > +++ b/tools/perf/arch/arm64/include/perf_regs.h
> > @@ -5,7 +5,7 @@
> >  #include <stdlib.h>
> >  #include <linux/types.h>
> >  #define perf_event_arm_regs perf_event_arm64_regs
> > -#include <asm/perf_regs.h>
> > +#include "../../../../arch/arm64/include/uapi/asm/perf_regs.h"
> >  #undef perf_event_arm_regs
> >
> >  void perf_regs_load(u64 *regs);
> > diff --git a/tools/perf/arch/csky/include/perf_regs.h b/tools/perf/arch=
/csky/include/perf_regs.h
> > index 076c7746c8a2..9520e6aa319e 100644
> > --- a/tools/perf/arch/csky/include/perf_regs.h
> > +++ b/tools/perf/arch/csky/include/perf_regs.h
> > @@ -7,6 +7,7 @@
> >  #include <stdlib.h>
> >  #include <linux/types.h>
> >  #include <asm/perf_regs.h>
>
> Oops, the above line was not removed. Would remove it in next version.

Aside from this:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > +#include "../../../../arch/csky/include/uapi/asm/perf_regs.h"
> >
> >  #define PERF_REGS_MASK       ((1ULL << PERF_REG_CSKY_MAX) - 1)
> >  #define PERF_REGS_MAX        PERF_REG_CSKY_MAX
> > diff --git a/tools/perf/arch/loongarch/include/perf_regs.h b/tools/perf=
/arch/loongarch/include/perf_regs.h
> > index 45c799fa5330..b86078a55e90 100644
> > --- a/tools/perf/arch/loongarch/include/perf_regs.h
> > +++ b/tools/perf/arch/loongarch/include/perf_regs.h
> > @@ -4,7 +4,7 @@
> >
> >  #include <stdlib.h>
> >  #include <linux/types.h>
> > -#include <asm/perf_regs.h>
> > +#include "../../../../arch/loongarch/include/uapi/asm/perf_regs.h"
> >
> >  #define PERF_REGS_MAX PERF_REG_LOONGARCH_MAX
> >
> > diff --git a/tools/perf/arch/mips/include/perf_regs.h b/tools/perf/arch=
/mips/include/perf_regs.h
> > index 7082e91e0ed1..66655f0c4fea 100644
> > --- a/tools/perf/arch/mips/include/perf_regs.h
> > +++ b/tools/perf/arch/mips/include/perf_regs.h
> > @@ -4,7 +4,7 @@
> >
> >  #include <stdlib.h>
> >  #include <linux/types.h>
> > -#include <asm/perf_regs.h>
> > +#include "../../../../arch/mips/include/uapi/asm/perf_regs.h"
> >
> >  #define PERF_REGS_MAX PERF_REG_MIPS_MAX
> >
> > diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/a=
rch/powerpc/include/perf_regs.h
> > index 1c66f6ba6773..22b492a3dd58 100644
> > --- a/tools/perf/arch/powerpc/include/perf_regs.h
> > +++ b/tools/perf/arch/powerpc/include/perf_regs.h
> > @@ -4,7 +4,7 @@
> >
> >  #include <stdlib.h>
> >  #include <linux/types.h>
> > -#include <asm/perf_regs.h>
> > +#include "../../../../arch/powerpc/include/uapi/asm/perf_regs.h"
> >
> >  void perf_regs_load(u64 *regs);
> >
> > diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arc=
h/riscv/include/perf_regs.h
> > index d482edb413e5..89d5bbb8d2b8 100644
> > --- a/tools/perf/arch/riscv/include/perf_regs.h
> > +++ b/tools/perf/arch/riscv/include/perf_regs.h
> > @@ -6,7 +6,7 @@
> >
> >  #include <stdlib.h>
> >  #include <linux/types.h>
> > -#include <asm/perf_regs.h>
> > +#include "../../../../arch/riscv/include/uapi/asm/perf_regs.h"
> >
> >  #define PERF_REGS_MASK       ((1ULL << PERF_REG_RISCV_MAX) - 1)
> >  #define PERF_REGS_MAX        PERF_REG_RISCV_MAX
> > diff --git a/tools/perf/arch/s390/include/perf_regs.h b/tools/perf/arch=
/s390/include/perf_regs.h
> > index 130dfad2b96a..9c95589965fe 100644
> > --- a/tools/perf/arch/s390/include/perf_regs.h
> > +++ b/tools/perf/arch/s390/include/perf_regs.h
> > @@ -3,7 +3,7 @@
> >
> >  #include <stdlib.h>
> >  #include <linux/types.h>
> > -#include <asm/perf_regs.h>
> > +#include "../../../../arch/s390/include/uapi/asm/perf_regs.h"
> >
> >  void perf_regs_load(u64 *regs);
> >
> > diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/=
x86/include/perf_regs.h
> > index f209ce2c1dd9..5495e5ca7cdc 100644
> > --- a/tools/perf/arch/x86/include/perf_regs.h
> > +++ b/tools/perf/arch/x86/include/perf_regs.h
> > @@ -4,7 +4,7 @@
> >
> >  #include <stdlib.h>
> >  #include <linux/types.h>
> > -#include <asm/perf_regs.h>
> > +#include "../../../../arch/x86/include/uapi/asm/perf_regs.h"
> >
> >  void perf_regs_load(u64 *regs);
> >
