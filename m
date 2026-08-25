Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5283A5E77
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681598; cv=pass; b=nq1oyk2v+TOm1E6bGzJzB2Ol2tWW8XCOD+ZDCiUzP1VEdZCdnwBub7+JZTaXvr61xmy0tRN+zKjrd4nEAXrmmS8rWilikXLiL/c6bTm/c2oVzbDlwapelyF8Lq5/t+aI4TUz2SK+7Owbw47/uy8v7qG4M6f/fmwYSFD+hhTJ/9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681598; c=relaxed/simple;
	bh=V3F/tzkhJaIWUQbhk6yOfqYF/EGHkLQxJZ4G/SXJOO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVO3QmmdwWyFoqsJDQfUGJ6w2kF5tjAhzpPShcy/+OiJRqhGYssdfUskbWJ73LsLJ4Uz6JdABhgOd5gIGBb9IAiCH48W37z2GtJUMwGCDyRPX5YkHPLhAGuTswQsWOQAdflhK0m/44DZ4tDokckdv1qwLdJeuVk1xSuUQeRjyB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFaDfqWe; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFaDfqWe"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b445a84fso14115ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 11:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787681596; cv=none;
        d=google.com; s=arc-20260327;
        b=io/AOHTK3wl+9oelS1qy7upGtDuJqzTXZ90b736P+eLtGThV3H9MSimVAeI7Irit3D
         A1EwfDn5CewJSZY0KPtEk2P4qyd60Cgx5z5QW3PyrZi8UWXKlWXYKjwaIi/usCcKcPo9
         jxjpgCNMcVOjy82w3JMAlXv/cEHnOHmpFhMtXl5bU67Pndp3Yv6nWnX+wzh2/yQ6Yl7i
         zVIV54NUZuBklBBzRcDjNLHFwynyiUWpEnSLqqclVKKLupNLxYCVBuuW5vkICdTa5Pe6
         k2zE5AcE2I8FM/x3CWOA5oUR9a9A8JdDqcJ6QMIXRpTeYAnhwUzF48S30GyNHavsQA92
         Co/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=quHMi1YdSwTleJsBg3it2vqDng9wCpnt1Ne+Y29OH9Y=;
        fh=uyoVbSeQtwR+SWdVUI43U/8PkOIoR0jKAAb7f/F3UTo=;
        b=scfcgOly7fzhXCGRyp3z+KzAVMprkjDUdY0+mtHCcnUree8KrEO0kG4vlkDmwTyS9+
         lfggOOsYxj2bhc/wZZXhq+g3HjGJzIKDZ3aj/iLUCSHeOoOoicgCnSGFXlxYjNo2ddKn
         flpxi2JL7phYHAnfaVizEe2qmODZ1s6jOdbjLOroPIB11/VIcybFcCmRwbQM9kQboi9b
         khJ9oZqKnAFr5LW6aFTUye0g/Kynqbzrk5pOU9jnabdob8nUlao3EQ65Qrq94LtxxotU
         nd+AsA2AbM4XiCRG13iIILQA277NT5UHbHZVKiVPJC2e9lRNCWJ86NAZpJKOOnYHxu0D
         QAVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787681596; x=1788286396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=quHMi1YdSwTleJsBg3it2vqDng9wCpnt1Ne+Y29OH9Y=;
        b=BFaDfqWecRCUHELWaiEHL4/HHEQ82b7ZRwk9qPqAi45QULtsaPAc10OOwiQ37Ff36o
         AEi6v3U+8jwFpaYROQw8cU9mTyDJu1wz4ZdKHFRr7oxGeLufkmE+gAARYMga7EuKsNoU
         xbBfi6kggRd5GiZVnS3ab+o58PX8fTXfhuwgdbsQljXE52+9pvp9pnHRA6lQU7PkMElu
         7W1ShKdasvEeVC0A8n06MATh4ZdS+wUdqtERjWYL8wguA2BRTo0ADKeP7ieVn2aDJjaV
         ceQ6t51hd9M3yGjKEiZPpTO39khtqOG6qRLiXWC6g0SPprwFdGYt6oaCgu2+91VBd1EW
         vK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681596; x=1788286396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=quHMi1YdSwTleJsBg3it2vqDng9wCpnt1Ne+Y29OH9Y=;
        b=WEZFDxjlqmgD0r74L6wRBCRW/CihGaZXCw+HSLXSleqG2jb/70rfXhGq5FaWG7MrsJ
         v7LTIqv/lF2Gf4eFr0OK2PKhThU3L+rSBRN/S4v0hMR8PIiIUhtd7OleLkf6WsKyggvX
         Kyqxcy3kDIT+boW0tCZG+Nl++MKukwZJFe8HcLWZ/4di8VWUQV/CmbC2MLzc7Q59y4vG
         RPD/WCLWmyeLBESM++qXiLVx74cCj9g8eMzzGwFEN1wCNk8WOCGMK+LTHyFkKZSP712Y
         7JFIYtAfoQL/jzQjiXcKSxSAKWB2gT9r+kMw4tOtZGYsvxIWNR/MrvsPiDrGh7jP8+hD
         zgLg==
X-Forwarded-Encrypted: i=1; AHgh+RoAa9x+rinyLqzz6SU1so02+wB6trcM3VAuv979SUErnxn0tsQwK0lw54RbZcyEbXdtewlaB2I7v/5NrP/46/5Q@vger.kernel.org
X-Gm-Message-State: AFuF++kCaexdlVH4OZTAj+gwvnBLBm6ubR7/UCYh/OjUQRx2aZu8m2XY
	Q+IxuNceFsNHL8RCondjxo9t6HvVO3fDn6v/c+poZ1veMy7nkaf8jxS0e3JPyh2sJF3rNcZaU0x
	OOh2PuxmqEsDLJGm437Zs1VaNprD3W2f/HszG1Mqw
X-Gm-Gg: AR+sD10KQCstPjzVeEURpqNW21tSgLEJmOTUyBwtcThVZNiK4UBELsYzYPqL5SlD8KZ
	do77BpuBh4qUmnuNy6dz4YWheSewhlCFxyzq0UzSLx6StXqFYAl5rFkjHzlJcuhn2C5eAPjNsxq
	Uqi5qbuEwkWbZDc0D5a1l98SJF+LaBOAfri+XUUyGvkm2nSa7O8ojvR0QXq7fgGlTjhargV2J4Z
	LzZkGrgjWlXoPN5Qll+H+8GPPokuKQEm9TjEAzPbBX5U6hnitZ/7nWALxqRscdQ5CmMEPJmXbj1
	JkaRrDOcDChL9SxLOZwTt+SAzadkyz0euDsMg3pv2I4RKyx+cFxgyvJSAduJeCTe65tJf5BNW/w
	=
X-Received: by 2002:a17:903:440c:b0:2cf:9ec1:ea6e with SMTP id
 d9443c01a7336-2d6e077122amr8872805ad.8.1787681595646; Tue, 25 Aug 2026
 11:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825062345.115073-1-adrian.hunter@intel.com>
In-Reply-To: <20260825062345.115073-1-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Aug 2026 11:13:02 -0700
X-Gm-Features: AcwNN1VpI5goenQQxdoSNyy6K0yLSlvWlG-p5tUvfr5yQQoCrgzMpJZZtfHk7ak
Message-ID: <CAP-5=fW-gsoX_Fb1RyhwwL_72dtPcnrYTrEaWHhL_DDvXxjadg@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Do not use debug file as the binary type
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	tlipcon@google.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 11:23=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> dso__load() sets the binary type of a DSO to the type of the first symbol
> source found. For a DSO with a separate debug file linked via
> .gnu-debuglink, that is DSO_BINARY_TYPE__DEBUGLINK, which makes
> dso__get_filename() return the name of the debug file instead of the file
> that was actually executed.
>
> Consumers that need to read instruction bytes, such as Intel PT decoding
> in 'perf script', then read from the debug file and produce wrong
> instructions.
>
> Prefer DSO_BINARY_TYPE__BUILD_ID_CACHE, and otherwise
> DSO_BINARY_TYPE__SYSTEM_PATH_DSO, over debug-only types, which restores
> the behaviour of using a file that contains the executed instructions.
>
> This is a workaround. Properly separating the binary file used for
> instructions from the file used for debug symbols is left for later.
>
> Example:
>
>  Create a shared object with a separate .gnu_debuglink debug file. Note
>  that 'objcopy --only-keep-debug' leaves .text as NOBITS, so instructions
>  read from the debug file are zeros:
>
>   # cat > foo.c << EOF
>   unsigned long foo_work(unsigned long n)
>   {
>         unsigned long s =3D 0;
>
>         for (unsigned long i =3D 0; i < n; i++)
>                 s =3D s * 31 + i;
>         return s;
>   }
>   EOF
>   # cat > main.c << EOF
>   #include <stdio.h>
>   unsigned long foo_work(unsigned long n);
>   int main(void)
>   {
>         printf("%lu\n", foo_work(1000));
>         return 0;
>   }
>   EOF
>   # gcc -g -O2 -shared -fPIC -o libfoo.so foo.c
>   # gcc -g -O2 -o main main.c -L. -lfoo -Wl,-rpath,'$ORIGIN'
>   # objcopy --only-keep-debug libfoo.so libfoo.so.debug
>   # objcopy --strip-debug libfoo.so
>   # objcopy --add-gnu-debuglink=3Dlibfoo.so.debug libfoo.so
>   # perf record -e intel_pt//u ./main
>
>  Note that branch samples must be requested, because it is the resolving
>  of the branch target symbol that causes dso__load() to be called, and
>  hence the binary type to be set, before the decoder walks the code.
>  With '--itrace=3De' alone, nothing loads symbols for libfoo.so, the bina=
ry
>  type is left as DSO_BINARY_TYPE__NOT_FOUND, the correct file is read
>  anyway, and no errors are reported either way.
>
>  Before:
>
>   # perf.before script --itrace=3Dbe 2>&1 | grep "instruction trace error=
"
>    instruction trace error type 1 time 2350.467489498 cpu 9 pid 75634 tid=
 75634 ip 0x77d48480718f code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467489832 cpu 9 pid 75634 tid=
 75634 ip 0x77d484807341 code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467496412 cpu 9 pid 75634 tid=
 75634 ip 0x5b4de37a8074 code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467593393 cpu 9 pid 75634 tid=
 75634 ip 0x77d4848070d0 code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467593954 cpu 9 pid 75634 tid=
 75634 ip 0x77d4848075a8 code 6: Trace doesn't match instruction
>    instruction trace error type 1 time 2350.467595728 cpu 9 pid 75634 tid=
 75634 ip 0x77d4848324de code 6: Trace doesn't match instruction
>   6 instruction trace errors
>
>  After:
>
>   # perf script --itrace=3Dbe 2>&1 | grep "instruction trace error"
>   #
>
> Fixes: 5363c306787c8 ("perf symbol: Set binary_type of dso when loading")
> Reported-by: Todd Lipcon <tlipcon@google.com>
> Closes: https://lore.kernel.org/all/CAGH6UiG=3DRJLqBU3kLu9XJciPyPO1HZkbAP=
ERguVUMRuWQgqf=3DA@mail.gmail.com/
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Just a heads up of  a different using the ELF rather than the debug
problem in addr2line caught in:
https://lore.kernel.org/linux-perf-users/20260824062841.1529489-2-irogers@g=
oogle.com/
As you mention, there's probably a wider clean up needed. I dislike
that we currently have dso__name and dso__long_name where the long
name is generally the path to the binary. There should probably be a
helper to get the DSO debuginfo for split cases.

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index cd379ced19e5..1f714b47bbf4 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1947,7 +1947,16 @@ int dso__load(struct dso *dso, struct map *map)
>                 if (next_slot) {
>                         ss_pos++;
>
> -                       if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE_=
_NOT_FOUND)
> +                       /*
> +                        * The binary type is used to find the file conta=
ining
> +                        * the executed instructions, so prefer the types=
 that
> +                        * refer to the actual object over debug-only fil=
es such
> +                        * as DSO_BINARY_TYPE__DEBUGLINK.
> +                        */
> +                       if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE_=
_NOT_FOUND ||
> +                           symtab_type =3D=3D DSO_BINARY_TYPE__BUILD_ID_=
CACHE ||
> +                           (symtab_type =3D=3D DSO_BINARY_TYPE__SYSTEM_P=
ATH_DSO &&
> +                            dso__binary_type(dso) !=3D DSO_BINARY_TYPE__=
BUILD_ID_CACHE))
>                                 dso__set_binary_type(dso, symtab_type);
>
>                         if (syms_ss && runtime_ss)
> --
> 2.53.0
>
