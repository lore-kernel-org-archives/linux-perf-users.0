Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DB47253C
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002961; cv=pass; b=V3WlvLx5vwdagVYLD8VFxHIzMTermR4P2WxXHxjmWES992oC2984DADrwQr8ysdUxNlvrjEDwB6sUt3fIV4Oy+7NS3Ii3CucRYuNP1C0c69167hTyF07kz+sQJ4QDFIaFfcIw0umLiJnxNTE/TnQkli2wAkNlvXz0y6GWNMYfbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002961; c=relaxed/simple;
	bh=/1j3R/6prqhrUw7KK6wq8wheLco/Y6eiB1msX1LtE8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTwqYpHKN6vEzcqumfklbwYnopZHu7npfKTD0/f9QiUL8tbTbl5xXmsT6H6E7L2pv2WGWCeQa4OT6V9sz9BE9Blz9H6HY53knmv+sFRlzxUvuV1SM9e7OXEHe2+bWGtv5jQ0/vw8D3OoiS9qCxMfABXxa/KdHhGBevHkgB9gsPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nk5x9JN+; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nk5x9JN+"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c10ed63c0so33511cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002958; cv=none;
        d=google.com; s=arc-20260327;
        b=bpmTlXZWadMdJlHCZuKWzCdkrZGv6P3f8vPYKcn/OaTszlLDDlLHymqK75raTcWaOo
         qMwjTPh1ot2EJYemOnFN2qJdpS3jJsQ8IqK1BFdkEeyfpx+ATobWFult6rOwzIhQnqMd
         a3WW9uJHzmGNvyuF6Mk412l13Ljhjgc6g/B0/fjbI2K3MfzGykMNL7dEe3/tuGlwRMud
         8DSc5uJ1Yn5fBZtCX1IXCzgks+jVFedCvNMWhOvDl0GLpPE1FOQKDqBVD8KcIGYN4/C+
         RloQHq+lzWhzG4lUS4+8t59XMjSH3OnE9e9QtU70J17NBX0Az6mu2Y8WQwYUCcUFmVtW
         /Jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dFNz0cjuXRqq55nAmw7Qz0vaDX5TDAKY5xKqM3KXkSA=;
        fh=wX01Z4Mlk8yzNKEtSnOYpl9pIJJwQnpcBfYci73X0OA=;
        b=CWny/vu/1a/m++e0JnGArnasZJHCrjSRbNJOMBI/mVdU1CRXpeiTGMwpc00ahnwQtM
         NL/qA7MkMXRD3QzJgWpQcKjAz2X+Qp4NlNn+rUvaAY8PdeAV7xNeZfo7Gh7P54Jb31fY
         xZ+k7ClfSBSGNlvTTJCCTcTl/cOIcairPLRhWCwfWQK4C0eg6uWJ355Fy3MkwbCahtND
         MdG86usVPz9SFdKRsPXH7pkAqAtOX6r4VBuYOod5gppLkQv+qxTDZozKaGLbWZyMqd0O
         eWLdNhJZvs7ZOPIQ6X1NlPk/kORiuAMBtb0uHxa/pkwXnfvOqHA2GU3UyI+7rIxqYEoN
         XL3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787002958; x=1787607758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dFNz0cjuXRqq55nAmw7Qz0vaDX5TDAKY5xKqM3KXkSA=;
        b=nk5x9JN+59TE2lPMCUMCDRyXDdw7izIPxiy56C+87a4L7Qu+BnOvKGiwYxN+xKpBAL
         6zRJPHVWloTkVcC/mTv4e6YuMNNJpDOpCZFFSzlk61hVl8CcSNEutwXDryl86isSuvlN
         e4hknevVeLVoVp9YKZNU51vPNjtSzC1amcNyDyaue5uGhwFQsuo9Pzl4ZPnnZy1b4iuP
         niY7SK6vQcybvaPbbchKp8ZeLmdUgObxJEyPuiGnUyj+g+aw0ZmClLyQu0UfPysAg04Q
         NAvQqXQSTZ6ADIg/sbzRFGkLWnEU8LyxQpUDQ9aBsV0qBnvQ06ax7CXuVrdj6Y135BRN
         1Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002958; x=1787607758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dFNz0cjuXRqq55nAmw7Qz0vaDX5TDAKY5xKqM3KXkSA=;
        b=DYrXcKgfRGLjINN3sG/ZhT+eW9OiwJ7ET0ZfqaKmEagjkp2EWUonil1RDv62MmWsPQ
         5vUFN9rjmgCo1C9WicqEjkv5HvcknTAHs50cpTVy14eclVvxtLh/vLXKBPO/hOT5jFgH
         jouvSo9DrekA+ZBpKlrgU60aHlIUulRjnEaYxs9q/8ZNXSeTVspo9aWOj4akzXk+8pAr
         QGTIeVilgzYn0HlfMTDKD5jb6JHS7EpuXuTu3YEkJ+eIBPOpRF9LWUASuTa5fk6CFihA
         HgOEp9Kn93nGmMD5wfzKMH8gwhxDUIdktBIZY+t3vq/Sw9CL3yTX+6CMtBKK6dKorpKY
         0d7w==
X-Forwarded-Encrypted: i=1; AHgh+Rpn+/z99qdWftIZlzczuRbZbBU1YUoQ8r/vGoPxFJj4oyUa3Hv+Pr0vwIkOHfSmlTxQ0dwrR1aSF2sROtmudA5n@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTqBNyBnFkFtXzUih5V4l/YKk2ARAxKzdTUiQGxnGNh10MK+u
	KFGmASL01Tm0xpFg0dY6Y9D4fDyzoN2BRh0HIcYGY65CieOOJfOUmcG2HuGtYKbMqp8zlOJG/V9
	gpvhmOJ+NhPwabr1hpR9p0HTDbJR6fw84yYDWzqTO
X-Gm-Gg: AR+sD10GMa6U4RT6aSX23T6yc7f4tNKVsATgPzRSw4ROl6Qr9jl1dnI0E1mx5ipQMSs
	wpZ7WoPecvGlHxi8hAYSPoSpvQqePspu5OEafl0xVPU7xsVgoqp86kpJsqCAzggnIOfX7lhNPA7
	Dm06a+qyK/gVgdkwDOqqYHefBzhTHwscV3GjSIbL6xommMkCXIp7MvSPxXCdW+XlpfLs4XC9oQX
	Tujbwr/a4j28ycD3geQBw1+oSZ+vvlaEutrU2qeW27RwU9OKAI1l3DpZ8fQlUuBps5O9FkVpkrr
	d1Objq4q7gLl7QxsMFb8tQMkUdQ2TZn3W1aC8cJec1p2rXYvRngNOdXSR4JnLGl6piIoZu96/ti
	amcmoalnUkmo=
X-Received: by 2002:a05:622a:1ccc:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-52dc09dbb5amr6142051cf.10.1787002957656; Mon, 17 Aug 2026
 14:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811050046.4019578-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260811050046.4019578-1-zhanxusheng@xiaomi.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:42:26 -0700
X-Gm-Features: AcwNN1WjGM8u2P3YPNssjz0TRCPBvjc7J3d8sj3X-QFYUXc7yspuNCw907W9WQU
Message-ID: <CAP-5=fV0sqh1cVc1kxSPNV0mBS7V0oTLQDvybE3MZCnpQ7N0RQ@mail.gmail.com>
Subject: Re: [PATCH] perf symbols: Don't apply the symfs layout to synthesised paths
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Changbin Du <changbin.du@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:00=E2=80=AFPM Zhan Xusheng <zhanxusheng1024@gmai=
l.com> wrote:
>
> The flat symfs layout was implemented inside __symbol__join_symfs() alone=
,
> which went from
>
>         return path__join(bf, size, symbol_conf.symfs, path);
>
> to taking perf_basename(path) first.  No caller was changed, so all of th=
em
> got it.  Most pass dso__long_name(), which is what the option is about, b=
ut
> some pass a path perf built itself:
>
>   dso.c        "/usr/lib/debug"             -> "debug"
>   dso.c        "/usr/lib/debug/.build-id/"  -> ""
>   build-id.c   "/usr/lib/debug/.build-id/"  -> ""
>   disasm.c     <file under buildid_dir>     -> last component
>
> perf_basename() yields "" for a path ending in '/'.  So with --symfs
> DIR,flat the FEDORA, UBUNTU and MIXEDUP_UBUNTU debuginfo lookups land in
> <symfs>/debug/, the two build-id ones in <symfs> itself, and disasm.c
> flattens a path under perf's own build-id cache.
>
> Use path__join() at those sites, which is what the helper did for them
> before.  A hierarchy layout is unaffected, being that same call.  The
> OPENEMBEDDED site passes "", where perf_basename() is already a no-op;
> it is converted for uniformity.  Every remaining __symbol__join_symfs()
> caller passes a path from the profiled system.
>
> Fixes: f182573e06ab ("perf tools: Add layout support for --symfs option")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Thanks Zhan! Would it be possible to provide a before and after the
patch so we can better appreciate the issue you are fixing?

Thanks,
Ian

> ---
>  tools/perf/util/build-id.c |  2 +-
>  tools/perf/util/disasm.c   |  4 +++-
>  tools/perf/util/dso.c      | 11 ++++++-----
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index eb95ab90f974..0c89fe75a650 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -599,7 +599,7 @@ static char *build_id_cache__find_debug(const char *s=
build_id,
>                 dirname =3D dirbuf;
>         }
>
> -       len =3D __symbol__join_symfs(debugfile, PATH_MAX, dirname);
> +       len =3D path__join(debugfile, PATH_MAX, symbol_conf.symfs, dirnam=
e);
>         snprintf(debugfile + len, PATH_MAX - len, "%.2s/%s.debug", sbuild=
_id,
>                  sbuild_id + 2);
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 0a1a7e9cf3ef..decf9348d735 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -31,6 +31,7 @@
>  #include "map.h"
>  #include "maps.h"
>  #include "namespaces.h"
> +#include "path.h"
>  #include "srcline.h"
>  #include "symbol.h"
>  #include "thread.h"
> @@ -1173,7 +1174,8 @@ static int dso__disassemble_filename(struct dso *ds=
o, char *filename, size_t fil
>
>         build_id_filename =3D dso__build_id_filename(dso, NULL, 0, false)=
;
>         if (build_id_filename) {
> -               __symbol__join_symfs(filename, filename_size, build_id_fi=
lename);
> +               path__join(filename, filename_size, symbol_conf.symfs,
> +                          build_id_filename);
>                 free(build_id_filename);
>         } else {
>                 if (dso__has_build_id(dso))
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 2309196d8df3..314c9a0edf28 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -167,12 +167,12 @@ int dso__read_binary_type_filename(const struct dso=
 *dso,
>                 break;
>
>         case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
> -               len =3D __symbol__join_symfs(filename, size, "/usr/lib/de=
bug");
> +               len =3D path__join(filename, size, symbol_conf.symfs, "/u=
sr/lib/debug");
>                 snprintf(filename + len, size - len, "%s.debug", dso__lon=
g_name(dso));
>                 break;
>
>         case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
> -               len =3D __symbol__join_symfs(filename, size, "/usr/lib/de=
bug");
> +               len =3D path__join(filename, size, symbol_conf.symfs, "/u=
sr/lib/debug");
>                 snprintf(filename + len, size - len, "%s", dso__long_name=
(dso));
>                 break;
>
> @@ -187,7 +187,7 @@ int dso__read_binary_type_filename(const struct dso *=
dso,
>                         ret =3D -1;
>                         break;
>                 }
> -               len =3D __symbol__join_symfs(filename, size, "/usr/lib/de=
bug");
> +               len =3D path__join(filename, size, symbol_conf.symfs, "/u=
sr/lib/debug");
>                 snprintf(filename + len, size - len, "%s", dso__long_name=
(dso) + 4);
>                 break;
>
> @@ -200,7 +200,7 @@ int dso__read_binary_type_filename(const struct dso *=
dso,
>                 while (last_slash !=3D dso__long_name(dso) && *last_slash=
 !=3D '/')
>                         last_slash--;
>
> -               len =3D __symbol__join_symfs(filename, size, "");
> +               len =3D path__join(filename, size, symbol_conf.symfs, "")=
;
>                 dir_size =3D last_slash - dso__long_name(dso) + 2;
>                 if (dir_size > (size - len)) {
>                         ret =3D -1;
> @@ -219,7 +219,8 @@ int dso__read_binary_type_filename(const struct dso *=
dso,
>                 }
>
>                 build_id__snprintf(dso__bid(dso), build_id_hex, sizeof(bu=
ild_id_hex));
> -               len =3D __symbol__join_symfs(filename, size, "/usr/lib/de=
bug/.build-id/");
> +               len =3D path__join(filename, size, symbol_conf.symfs,
> +                                "/usr/lib/debug/.build-id/");
>                 snprintf(filename + len, size - len, "%.2s/%s.debug",
>                          build_id_hex, build_id_hex + 2);
>                 break;
> --
> 2.43.0
>
