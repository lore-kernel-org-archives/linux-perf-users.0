Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C3339875
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890926; cv=pass; b=LU8fxhb3qha+z/eMHLdnZ83J9t5eUIHPlhovioqGpSr+4uOm9qqSKyfDtGcMF/oQo4rSeSOpzQQxlVxZ6GIIlZ9JCFLI9GFqZE8GX7N98jAus4GZPI9IX82Ie7XYAAxZ4EKqbjzyMNk6ggaB6I8B94xuCw3t6HeXDfVO07xu71w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890926; c=relaxed/simple;
	bh=z6uNhq7h7RLEB1t0y5S59Hj6nrmwj5oAdNgHqjEJ8MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnIuebXaRCW/EyStNZY/XuxDBlklujN3flAs82SS2Qg80P3p32Y7ePHANfHF6r2CCOCJBBvizUmXm2QW8K8IUXM8WufwrFGZsvzKsEOOtwSRPHuTFRuffhHsacEuNV4MItzGvusnlUQK4y13EubYpE+5/YZhWhEzfm5qhXlTpA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKFvowfJ; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKFvowfJ"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so641931cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 11:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788890923; cv=none;
        d=google.com; s=arc-20260327;
        b=rPtf4Men422oY+czLysSMOdfgrkA147+kZAz6tP8o4jquc9H9fkCbWXzHPzXAkv0e4
         r1fGi6wBJjfhJm6qqugHWsuTIz+8H33lK9LOM7SbzH6/fjT3m+b+xiElMCyNvLi0YFX3
         yf8n61kdFYQkPPEw8Y9cs+k7ityCbVX3K8xdHPuETJNng934EUDAFRHAUIWOfGx80MPj
         Q8hFfTgWdq6BKUOLcqeXWVSHnBEWcvmS725s4nc5N1O2zBMV9vhyqYtUbBVtDjm2bnYG
         4sHOGGDzwq/GoJls7ZGkLywJF6ErKBIGkGvEumlBT28bEBFts3GfUNBwr+AcA4qT25E/
         r1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v56+UIFhP0Dq/iJfc/yfofNPasIIeHeXBkQoDrcfwzc=;
        fh=ZNFhsSTNZhfKFp132CgGG/yuQ69duipGGOuBl830/0E=;
        b=gRVTVpzeyfqMiRhX+m0aDzV9n+bdm9DDAHxMCnDQXUvUt9wFL6R7ACwX3z7vgucqvd
         1TMfy4DZmtegi4NIUP2eD8YdE2iZVxE2Toye+FBJv3JUuhMyDZYwnU+ADBQaodyXSbWb
         zbYnR+ZtHxq5rE8PxeLxTiqH00vHbZchd2cU/5B0x39CI3FzI4g+0E2dQri+NewSv+B+
         IuhH5r9VbORFrneBdwzX/yrKqoQj77KXi9dMfgxXtzByaNBkG2VO4tb+aJnjfGPKnoWu
         uNuHOkXFe0krVGwncN5MBdEedbF9fRxc/okaBjVOhx39dswpOevEqFChnEy2EQof7Txu
         xJww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788890923; x=1789495723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v56+UIFhP0Dq/iJfc/yfofNPasIIeHeXBkQoDrcfwzc=;
        b=pKFvowfJI5Z2nIebOzRed5HMP3JBplWDvc4Gt1KFM4zag77Y+HqbOe1UuVr2tQtrVo
         zy9IRYBOyhx6XRQuXKZAwS2kUQ0huh75TKFMznvuYhP6++2OYh3SJJnx0Rxx6FZu/T4D
         QK1shXGJcgag7LLwdskDvU7sa+7q34Ydx9YWjC6v25zxuWLzQHgRxmmOE7/OKoudS+a9
         T1vp+fN2SdEWSb3CxWSgm6fOrYRqScPWQgbzLl5a6VfYrWeimGM2PTt5h0wAKD3NauX6
         TACijNOjbha6sb7Hl6Bh2TVTPZdD1CJ7hNasBbCoMGV8xssQ2wL28iY3jIpTJeSFxJJD
         1PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890923; x=1789495723;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v56+UIFhP0Dq/iJfc/yfofNPasIIeHeXBkQoDrcfwzc=;
        b=mY5STZP6H/fu2r8RQfyIuUXEmXXepG6CTa9jMc3KU9bvv+NsLWe3C/bwiz9UbgQrYn
         F1IZhljQKaOcjiA0qxulmDO8Xkzpa3HGlYUh8EMDt9ZwbI13eUpHbBUlwx91vsoBEbuW
         4XcxDugrA1MX7jIN6bcxmg/p0mr/8yRROh2GtOFOyudfl9aIy+jelRm+r27wOqLkmCY0
         r7+hWv6NLFv5HulpxQo3n6L5/Qsi6ct3lzhWYdL6zcRcqSHFkINwLte5B6tvTSJIP9Zy
         7lnklBTiNFy7r7rLJr/pOI+zwk/8g7CKRvOM7ceivnzEUH6FmW6/uj5GV/YdVSAnDsUC
         KuCw==
X-Forwarded-Encrypted: i=1; AKwUvBzqsk5Rp78Y2C3UwmKls4+lCpCtLDiW03ROpCWrcpyiyWZ5aySuj5/CrguufeKdLx1XsDEiqnB2ioDzUVgLVHSQ@vger.kernel.org
X-Gm-Message-State: AFuF++krJD1KlSpbZ0FYV4vPXFCutDj7VgH2aUgacNNqUIbt3qEhRZHt
	PsMEm1pFbd4nS1colaCHprxsst22lb4U6GFZQHzTjezmRJ/GaTq73yIHsinjJHC4UhJd4vdpOMT
	Xs28+lUyFnIIdK7bpNq50EkXstjI61WTgcLKOWUr1
X-Gm-Gg: AYBFou2Ilg2WR8MlcPiEg7n0rVzzqe5m5g49/3Tuim2sdNwwhSlq0NIEv/GhhGxKoP3
	0pQwNbZmqlADMnbXtwBL3LM74AjykQLmzYDvhtbea8iPq4wo7bBmQknlR+DEgU1THDn+8umXkYG
	vx9z5/wICpax/7i2xec48Ug45TDi7y3cjzFOI17u5uB6WdPAAowziHRJaFeC1EMfdZNbbySMdQ8
	1HhyRUPepPvFj8WGdZjqEMdejdV8Bx+2Sip4UWf2omkALnicp08daCBhGr1rz42vINIcCCsw++4
	XDV3HHOQfFmRK1CWZtHXuQsnHiVInSt9EPr282OXFLYf9IpOyEcCRQWOMwACKdADLqIsAA08DYg
	=
X-Received: by 2002:a05:622a:4185:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-530a4871371mr675561cf.4.1788890922686; Tue, 08 Sep 2026
 11:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908130122.633500-1-wutengda@huaweicloud.com> <20260908130122.633500-8-wutengda@huaweicloud.com>
In-Reply-To: <20260908130122.633500-8-wutengda@huaweicloud.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Sep 2026 11:08:31 -0700
X-Gm-Features: AcwNN1VTV6_LLWyJv25dfFMSu7d8R8mTo5r822djiUuUpu_caviCx94Qd19XsIY
Message-ID: <CAP-5=fUAtw6-waqmF4RJFGZ__J=DSzbNLNsOfWekj378_PnrdQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/26] perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org, xueshuai@linux.alibaba.com, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev, 
	Li Huafei <lihuafei1@huawei.com>, Kim Phillips <kim.phillips@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Bill Wendling <morbo@google.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Zecheng Li <zli94@ncsu.edu>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:01=E2=80=AFAM Tengda Wu <wutengda@huaweicloud.com>=
 wrote:
>
> The current arm64 DWARF register lookup relies on 'aarch64_regstr_tbl',
> a static string table. While this works for kprobe-tracer where register
> names start with '%', it is insufficient for parsing register numbers
> directly from raw instructions (e.g., extracting '6' from 'x6' or 'w6')
> during annotation.
>
> Since get_dwarf_regnum() is currently used only by 'perf annotate' and
> does not affect kprobe-tracer, replace the limited table-based lookup
> with a programmatic implementation in __get_dwarf_regnum_arm64(). This
> allows resolving arm64 register names (x0-x30, w0-w30, sp, etc.) directly
> into their corresponding DWARF register numbers.
>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../util/dwarf-regs-arch/dwarf-regs-arm64.c   | 22 +++++++++++++++++++
>  tools/perf/util/dwarf-regs.c                  |  2 +-
>  tools/perf/util/include/dwarf-regs.h          |  1 +
>  3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/p=
erf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> index 593ca7d4fccc..720c863d1869 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> +#include <ctype.h>
> +#include <stdlib.h>
> +#include <string.h>
>  #include <dwarf-regs.h>
>  #include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
>
> @@ -10,3 +13,22 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_=
regnum)
>
>         return perf_regnum;
>  }
> +
> +int __get_dwarf_regnum_arm64(const char *name)
> +{
> +       int reg;
> +
> +       if (!strcmp(name, "sp"))
> +               return 31;
> +
> +       if (*name !=3D 'x' && *name !=3D 'w')
> +               return -ENOENT;
> +
> +       name++;
> +       if (!isdigit(*name))
> +               return -ENOENT;
> +
> +       reg =3D strtol(name, NULL, 10);

Nit: perhaps this can be a little faster and ensure correct string terminat=
ion?
```
if (!isdigit(name[0])) {
    return -ENOENT;
} else if (isdigit(name[1]) && name[2] =3D=3D '\0') {
     reg =3D (name[1] - ' 0') * 10 + name[2] - '0';
} else if (name[1] =3D=3D '\0) {
   reg =3D name[1] - '0';
} else {
   return -ENOENT;
}
```
Everything else looks good to me.

Thanks,
Ian

> +
> +       reg =3D strtol(name, NULL, 10);
> +
> +       return reg >=3D 0 && reg <=3D 30 ? reg : -ENOENT;
> +}
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index 797f455eba0d..bacf5c13c3bc 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -114,7 +114,7 @@ int get_dwarf_regnum(const char *name, unsigned int m=
achine, unsigned int flags)
>                 reg =3D _get_dwarf_regnum(arm_regstr_tbl, name);
>                 break;
>         case EM_AARCH64:
> -               reg =3D _get_dwarf_regnum(aarch64_regstr_tbl, name);
> +               reg =3D __get_dwarf_regnum_arm64(name);
>                 break;
>         case EM_CSKY:
>                 reg =3D __get_csky_regnum(name, flags);
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inclu=
de/dwarf-regs.h
> index 46a764cf322f..a25f038bbff2 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -105,6 +105,7 @@ int __get_dwarf_regnum_x86_64(const char *name);
>  int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum);
>  int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum);
>
> +int __get_dwarf_regnum_arm64(const char *name);
>  int __get_dwarf_regnum_for_perf_regnum_arm(int perf_regnum);
>  int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
>
> --
> 2.34.1
>
