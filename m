Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945569964
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440064; cv=none; b=aIRldNFeTR+TfeFqpJDNZSYPxFROhBaWsnYfvaksrRrdX59ugqe10sDaZidYpwFceacIYmKXPxSd//uU3Uyf/pfNp+NIOwtAmi4lsZXbDvfIsXWOK0Om9MV8YpKl4D4/qABFDep3pA0Hr6NiSsJt1Z+E+jxiMNUtxoSKdtzFQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440064; c=relaxed/simple;
	bh=WUj3TOrb7wNaL3YIYKVvcwZJ0pt2GN4R/s1lR821U5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llN621BMcA7eBhO/Vk40tQkAHuIM/gC/HV3Q/N+RmIclU5u0HdH6wU9nvzOhW012Y8Fd6sEv8wDiWeDP/m9Xu3pOt4kiaWfZ4mYY3fwZFuwcRCZ4zvxrseK4Z3C8PHe5dWJ/CKgBHQSv6qKi3BhnfGaT6Mdp28JtKRick/ZfwH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4b121uk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4b121uk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dbcf58b05cso343375ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 06:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708440062; x=1709044862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxUnZN7wzz4G3U+ISbDvRkzFI5qAcvgTM2/3f2JuZsM=;
        b=h4b121ukG1+Zxo4rJ6IzaRTpvvn6vfKOVJ0wvAA8Z9eQq7G9geEOr7WuWE19fhk2Yz
         ucWjDmgFh57Jbz03kGJy032v2GCyG9NaUrA7pU3O07TvkKZ8z16BOF2G3IT6PGs//8Ql
         1P5V86Aopfg7C4lgFr1p0mW4URtMigdm9TrfTNBIrYKK/BBqT4n9bJ94fUx46wGVDttt
         M1zwuQlvTDdQQ9gBu5uv02Qgc4Vu5ykkaU+v5PHLRVKTT+nY+p73/4IS8UJ7c2LAIP76
         VsIsLuiff16jwfFzgO26S6C+m3Actv6SnTgvnIAx76mcP5zrs8mjuvH0GyGxWe+zKlCG
         Su6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708440062; x=1709044862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxUnZN7wzz4G3U+ISbDvRkzFI5qAcvgTM2/3f2JuZsM=;
        b=AIHCGWs9XUFH/OwUY2K3xgEdqBxtA07E1KjADYsq5fYhGZfiZATpCGxdn21bPmGeIK
         DnidHSlxNr2Y2Ht3zRLUc1Hgx0P/uWwTjmtoo26BEdtEoaZu6RGqwF1cbfB7i394/DfR
         ZdW8xVT3UEr7UP1lx3Y81IjChpJ6X6UZNYOkdiSL4OZfTsjHr9miHrC+AcVM1FV4gz1L
         T01MDOXsyghlv5S+IkQVF0he8ilMN9YQLAW1ZclGj8OfhOqA9bLBRAEhHqj0IE6kG0Qj
         NOcUmIEQWT+JDwEr/GQYK1EKbHdZaxPxnPqLbmGp2Soh9E51v7nHvEymEKUDpZ15cHcg
         na1g==
X-Gm-Message-State: AOJu0Yy0oMxA9VNezRtWtlGgYO5ouW0SSEn230MRo/Dk2PkkL34SDdDX
	kP49HXmSSMnigurBy/n8/Q+PXsV9DzBqZ5eNUqdk94F8FlKXZhFGF/hb6JYafB/ibGbtYHrXYkG
	rrTy0nbp0IcTEjUWzcagULeneTzkGGPSBREq8
X-Google-Smtp-Source: AGHT+IHVWMEOqPChh4NFX2oA0/OjsgB53nb9tw2DTtjwkOvKQQ9QW1pCHH7Ax1tNOgXkvxd7pk0/11YGjmYoUMhGeRQ=
X-Received: by 2002:a17:903:c4:b0:1db:9e59:cd7 with SMTP id
 x4-20020a17090300c400b001db9e590cd7mr531796plc.29.1708440061992; Tue, 20 Feb
 2024 06:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com> <20240220042957.2022391-3-ChaitanyaS.Prakash@arm.com>
In-Reply-To: <20240220042957.2022391-3-ChaitanyaS.Prakash@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Feb 2024 06:40:47 -0800
Message-ID: <CAP-5=fUFmeoTjLuZTgcaV23iGQU1AdddG+7Rw=d6buMU007+1Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf tools: Only treat files as map files when they
 have the extension .map
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:30=E2=80=AFPM Chaitanya S Prakash
<ChaitanyaS.Prakash@arm.com> wrote:
>
> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>
> Perf currently treats any file beginning with "/tmp/perf-" as a map
> file, even when map files always have the extension ".map". This causes
> the test "perf probe of function from different CU" to fail because it
> generates a binary with a filename in that format. When the test passes
> it as an argument to be opened as an elf file, it's parsed as a map file
> and results in garbage symbol names. Fix this by only considering files
> ending in ".map" as map files.
>
> The above failure is masked if Perf is built with dwarf support. But
> with NO_DWARF=3D1, try_to_find_probe_trace_events() is skipped over in
> convert_to_probe_trace_events() falling into
> find_probe_trace_events_from_map() which results in the bad map file
> parse data being consumed and the inability to create the probe event.
>
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> ---
>  tools/perf/builtin-script.c | 15 +--------------
>  tools/perf/util/string.c    | 18 ++++++++++++++++++
>  tools/perf/util/string2.h   |  1 +
>  tools/perf/util/symbol.c    |  5 ++++-
>  4 files changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b1f57401ff23..c1c38a3df37a 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -48,6 +48,7 @@
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <signal.h>
> +#include <string2.h>
>  #include <sys/param.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -3240,20 +3241,6 @@ static struct script_desc *script_desc__findnew(co=
nst char *name)
>         return s;
>  }
>
> -static const char *ends_with(const char *str, const char *suffix)
> -{
> -       size_t suffix_len =3D strlen(suffix);
> -       const char *p =3D str;
> -
> -       if (strlen(str) > suffix_len) {
> -               p =3D str + strlen(str) - suffix_len;
> -               if (!strncmp(p, suffix, suffix_len))
> -                       return p;
> -       }
> -
> -       return NULL;
> -}
> -
>  static int read_script_info(struct script_desc *desc, const char *filena=
me)
>  {
>         char line[BUFSIZ], *p;
> diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
> index 116a642ad99d..94c7af70e636 100644
> --- a/tools/perf/util/string.c
> +++ b/tools/perf/util/string.c
> @@ -349,3 +349,21 @@ char *strreplace_chars(char needle, const char *hays=
tack, const char *replace)
>
>         return new_s;
>  }
> +
> +/*
> + * Returns a pointer to the first character of the suffix in str if the =
string
> + * ends with suffix, otherwise returns NULL.
> + */
> +const char *ends_with(const char *str, const char *suffix)
> +{
> +       size_t suffix_len =3D strlen(suffix);
> +       const char *p =3D str;
> +
> +       if (strlen(str) > suffix_len) {
> +               p =3D str + strlen(str) - suffix_len;

nit: I know this is just moving code but it seems unnecessary here to
call "strlen(str)" twice rather than just hold the result in a local
variable. A reasonable compiler should optimize this away, but it'd be
better to have the local imo.

> +               if (!strncmp(p, suffix, suffix_len))
> +                       return p;
> +       }
> +
> +       return NULL;
> +}
> diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
> index 52cb8ba057c7..0b9d1579a701 100644
> --- a/tools/perf/util/string2.h
> +++ b/tools/perf/util/string2.h
> @@ -40,5 +40,6 @@ char *strdup_esc(const char *str);
>
>  unsigned int hex(char c);
>  char *strreplace_chars(char needle, const char *haystack, const char *re=
place);
> +const char *ends_with(const char *str, const char *suffix);

nit: string2.h is an extension of linux's string.h. The tools copy of
that is missing functions in the kernel version:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/include/linux/string.h?h=3Dperf-tools-next
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/include/linux/string.h?h=3Dperf-tools-next#n398
specifically str_has_prefix.

The naming ends_with makes sense but there is also strstarts and
str_has_prefix, perhaps str_has_suffix would be the most consistent
and intention revealing name?

Also, we have strtailcmp which behaves like a reverse strcmp that
doesn't compare the lengths of the strings. It seems all uses of
strtailcmp are just for a "str_has_suffix". It would make sense to me
to remove that function and switch to a common str_has_suffix function
which I think is a more intention revealing way of naming what the
code is doing.

Thanks,
Ian

>
>  #endif /* PERF_STRING_H */
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index be212ba157dc..b87be3f1175a 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -4,6 +4,7 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> +#include <string2.h>
>  #include <linux/capability.h>
>  #include <linux/kernel.h>
>  #include <linux/mman.h>
> @@ -1760,7 +1761,9 @@ int dso__load(struct dso *dso, struct map *map)
>         const char *map_path =3D dso->long_name;
>
>         mutex_lock(&dso->lock);
> -       perfmap =3D strncmp(dso->name, "/tmp/perf-", 10) =3D=3D 0;
> +       perfmap =3D strncmp(dso->name, "/tmp/perf-", 10) =3D=3D 0 &&
> +                 ends_with(dso->name, ".map") !=3D NULL;
> +
>         if (perfmap) {
>                 if (dso->nsinfo && (dso__find_perf_map(newmapname,
>                     sizeof(newmapname), &dso->nsinfo) =3D=3D 0)) {
> --
> 2.34.1
>
>
