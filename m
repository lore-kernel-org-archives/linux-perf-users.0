Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770844A3C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734481127; cv=none; b=d9NXQGQeWL4z6SgsD3bqYSTD36SeKfQkMuCEtLRKHH8VPEU5FQpfJ5Gyg/l+PAnBdY0XYBO1ss35V2lxhMNHms7PCDjz0qhvvQoS1zy2J9Umwj5p1WQ+RyY+jdLw4FrJvFLTVNztt8y63KkCArpU4vS4YKD4CSkhPImF51X38gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734481127; c=relaxed/simple;
	bh=aFZ3b52JFb0q4nXNXvDY9Ei0yCsHdyqrjfn+jOX5Yqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkMS1EDWh6x1TkGT7iP8WekWx6XGbRXSYjRXdpQbkpT1RPrCDyWmGVZh31UugNNK0OYQZc4xKIKAQQ5RbC5KYV5HSbTbarcHBTjbBEz3DlTCgfieI0oVk8WYmx1G8yisD5JuPsSQIYE+FRV4pH0VyrwSI0/CxjKKu/eJg9UG8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1ZOHD87; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1ZOHD87"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so60215ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734481124; x=1735085924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VgS75oUAz4sbyrMvBGeF09Mw4wz7d5kDQKFYPnPV2Q=;
        b=Y1ZOHD87NEw2U2JagUmZ017FsUmP2W0LAJhxcI/6GIDoM2Ymvnt1eEMOuqqL2aMfkt
         QQXsyPeP9K1JhS8+uXb3pMzjUrWndXpV7MbNI0IljLKLGo1+lX9lVcq7Y2mxEbzodCK+
         JYRmh9YTwX9oKYFeNLOwN1ns/+E/cPehwnCknejGGBwNcwa5jroABRX0lRyfmkkBGJ8A
         rA6PImsfA9ZdU1McqBFkBQu1zJSk201u3dItmf8QqcYBgI7opANz11Eu4rQUk4Q/ipHO
         Lv8SAbS06Mfc5iNRzS0vR5bBSgs959GgZkJSpRUsaN/b+NVZAF+PiAsI/KDnsXl+/RhT
         z2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734481124; x=1735085924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VgS75oUAz4sbyrMvBGeF09Mw4wz7d5kDQKFYPnPV2Q=;
        b=U4ErKmJpAdtyBRoz2OSPfwUhEULDkuf7PFZ2m74U7ZG/dEvUz/2wX30j8fogz1bEgY
         642s4ASaIh99ux6w9difFuLoZsmqI8LNxmRFpgB4ujss/VsDIUap0CeH5N2JxUJVHuSX
         TV6/lrYR2okdZz9v8KIHatDbqq7hEDDt+an3z1nq/tLY1IxqpPKUemQX8B+2/besutmW
         7zYJY8OkStHZF8bAETmVq0MlnHeJKeb55n1FIvlNLMRxg91LqrDZo9GU2ueXut5Yvbny
         chAPloAXJQCh0D9mrox3uzZiGybulzT07Ue94NF+w7XtSsQ+A8/rEU/UbMFyIvYhlhg7
         ZupQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqdjCoEfh6Pfp0dkpKyYW68Ci9NQBktm3+WOwpmQhqL6gg0QuLxRjWWHH2g/tgLeJPrO302mwy2645HIB15KPu@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6rVGf7PJi9d/1etfbNJLLoZOKHRJUMwAkq9d98HrgLxOzozc
	JOkthWFKSJN+n7wlipMvyLmLgyLhn4QHAIUIUEBa1EzQTnR1XHo4ci7S+NqvrXfr8QJV05AcgTi
	1svGKOq1EkmSHdSfyIz127jS8T8SDK2tikJL2
X-Gm-Gg: ASbGncszKMqBvIHag/tHCtHhRfu+8Cj63Gv7hHJzmmPEVu7+ala/oy/CD692wcxZ3mH
	qZC/TbtKbKGjzRZE2XZY0e5AYzlOnJpZMSyaqeeA=
X-Google-Smtp-Source: AGHT+IFeicWsO3v+Iottx16JJQKcUQ0sqHuKfIXsWy0nEqaNcbAiUwHCGOeSwyFewGDSDRzXDE9GUe83Y7kVhJlr7Ts=
X-Received: by 2002:a92:ca49:0:b0:3a7:dcc1:9936 with SMTP id
 e9e14a558f8ab-3be37d49881mr326395ab.23.1734481124308; Tue, 17 Dec 2024
 16:18:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
In-Reply-To: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Dec 2024 16:18:32 -0800
Message-ID: <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
Subject: Re: [PATCH v2] tools: perf: tests: Fix code reading for riscv
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:52=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> After binutils commit e43d876 which was first included in binutils 2.41,
> riscv no longer supports dumping in the middle of instructions. Increase
> the objdump window by 2-bytes to ensure that any instruction that sits
> on the boundary of the specified stop-address is not cut in half.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
> A binutils patch has been sent as well to fix this in objdump [1].
>
> Link:
> https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]
> ---
> Changes in v2:
> - Do objdump version detection at runtime (Ian)
> - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj_readi=
ng-v1-0-b75962660a9b@rivosinc.com
> ---
>  tools/perf/tests/code-reading.c | 84 +++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-read=
ing.c
> index 27c82cfb7e7de42284bf5af9cf7594a3a963052e..7e24d10a543ac18ac2be70b82=
9d088874e0edfd5 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> +#include <linux/kconfig.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <inttypes.h>
> @@ -176,6 +177,66 @@ static int read_objdump_output(FILE *f, void *buf, s=
ize_t *len, u64 start_addr)
>         return err;
>  }
>
> +/*
> + * Only gets GNU objdump version. Returns 0 for llvm-objdump.
> + */
> +static int objdump_version(void)
> +{
> +       size_t line_len;
> +       char cmd[PATH_MAX * 2];
> +       char *line =3D NULL;
> +       const char *fmt;
> +       FILE *f;
> +       int ret;
> +
> +       int version_tmp, version_num =3D 0;
> +       char *version =3D 0, *token;
> +
> +       fmt =3D "%s --version";
> +       ret =3D snprintf(cmd, sizeof(cmd), fmt, test_objdump_path);
> +       if (ret <=3D 0 || (size_t)ret >=3D sizeof(cmd))
> +               return -1;
> +       /* Ignore objdump errors */
> +       strcat(cmd, " 2>/dev/null");
> +       f =3D popen(cmd, "r");
> +       if (!f) {
> +               pr_debug("popen failed\n");
> +               return -1;
> +       }
> +       /* Get first line of objdump --version output */
> +       ret =3D getline(&line, &line_len, f);
> +       pclose(f);
> +       if (ret < 0) {
> +               pr_debug("getline failed\n");
> +               return -1;
> +       }
> +
> +       token =3D strsep(&line, " ");
> +       if (token !=3D NULL && !strcmp(token, "GNU")) {
> +               // version is last part of first line of objdump --versio=
n output.
> +               while ((token =3D strsep(&line, " ")))
> +                       version =3D token;
> +
> +               // Convert version into a format we can compare with
> +               token =3D strsep(&version, ".");
> +               version_num =3D atoi(token);
> +               if (version_num)
> +                       version_num *=3D 10000;
> +
> +               token =3D strsep(&version, ".");
> +               version_tmp =3D atoi(token);
> +               if (token)
> +                       version_num +=3D version_tmp * 100;
> +
> +               token =3D strsep(&version, ".");
> +               version_tmp =3D atoi(token);
> +               if (token)
> +                       version_num +=3D version_tmp;
> +       }
> +
> +       return version_num;
> +}
> +
>  static int read_via_objdump(const char *filename, u64 addr, void *buf,
>                             size_t len)
>  {
> @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filename, u6=
4 addr, void *buf,
>         const char *fmt;
>         FILE *f;
>         int ret;
> +       u64 stop_address =3D addr + len;
> +
> +       if (IS_ENABLED(__riscv)) {

Not sure if there is a consistency issue here. Elsewhere we're just
using ifdef, such as:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n69

Thanks,
Ian

> +               int version =3D objdump_version();
> +
> +               /* Default to this workaround if version parsing fails */
> +               if (version < 0 || version > 24100) {
> +                       /*
> +                        * Starting at riscv objdump version 2.41, dumpin=
g in
> +                        * the middle of an instruction is not supported.=
 riscv
> +                        * instructions are aligned along 2-byte interval=
s and
> +                        * can be either 2-bytes or 4-bytes. This makes i=
t
> +                        * possible that the stop-address lands in the mi=
ddle of
> +                        * a 4-byte instruction. Increase the stop_addres=
s by
> +                        * two to ensure an instruction is not cut in hal=
f, but
> +                        * leave the len as-is so only the expected numbe=
r of
> +                        * bytes are collected.
> +                        */
> +                       stop_address +=3D 2;
> +               }
> +       }
>
>         fmt =3D "%s -z -d --start-address=3D0x%"PRIx64" --stop-address=3D=
0x%"PRIx64" %s";
> -       ret =3D snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, =
addr + len,
> +       ret =3D snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, =
stop_address,
>                        filename);
>         if (ret <=3D 0 || (size_t)ret >=3D sizeof(cmd))
>                 return -1;
>
> ---
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> change-id: 20241213-perf_fix_riscv_obj_reading-cabf02be3c85
> --
> - Charlie
>
