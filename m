Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA373BCD2F
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504291; cv=pass; b=J5qEj7avkOE7O78jOBNsVxsY1+jzmIuOYBYdru4SGSjQTGv+3dOWKPFnqYP0t9ks7ulYu6CHLkZ2ltj15Wq5f8SP7yuLjuSu+IGrwZvrifMipmsXPgt7YDVpzTqz9+KVfurOPL1KPQoWEGp5bvRYv0Q0VOoE96OJW3kJHK76kAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504291; c=relaxed/simple;
	bh=VWSkvrM/F5SNSEPVG6vo0Sb/tbQKJ6iyjD/Yl9tv4RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqym0aUn/7QMMCrZomphIKqzR1nOOLl16FIunkAmHni0p/fpLHiRqkrv4f0dpQy2C3MfSnRHLdW77fUVQVxwHZnBkDsaHiVkJ95A/J65/FtoOt93vIAHqm2LNZFQSWxXIaEMHFKgZLp1wkuc4EzGoNMtZWzF10kmXHYUrEzNxLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwfWtak1; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwfWtak1"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so8451cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789504288; cv=none;
        d=google.com; s=arc-20260327;
        b=X95jioWrTI/j59yIR5GGiOMJR279XTn3oooJ5s1tpuXXtUR/aOlgXW3RP3qBDfvYtb
         EOwm0pOr+0ODuGduye7wNhsuyHJ61K1DhVMsiLd1IdjnwhLM7PtDB4Gcb7mNA33D0xQq
         igQ0O2MxYxP7mZtU83t6qJINOBON5RqZ7xMcoMSHq8FxtoMmGou4UKqHmBGRbfnexzzh
         7zlKhIpaTZdRbaZCYOCN2dGLXPkSiOP94OGdL7xtYNOI30a2orwE0LcEeJQ1VwVX5jjL
         fQkRPrIMjZ7nA9FQ0yE/FlrW8nlrWwmUeBgljLn8cxHn0GKW6IR0zOV3fC5J6/Ds6koU
         uQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G4qQtA38WyUCrnABIjsSOxjkbhli0tBAUE05eGg44IQ=;
        fh=X1zzQ5p765cRZtBsEkNs2nYmL1PXqQO2FGrauKBkvY0=;
        b=LhGke2SxIl9OtvSkkOHdGl9Q/+xLxrrE+woaa2L1XQ2WLRQxW217g0TmWJ8uk+WTfL
         Ms0oyFzoZpJ/DDBXcfm7IB7jD7q4nGY66wT1IGUIfHpqYkLRFX7usoPySEQw0UF938vG
         lWaVc4RGSQnheKUzij6cH7ZQ+0KJgn2sXkkgQUL//oQiVUaatN9L8/JHLSKXbgsdVrkP
         +1oZ5Q1ig2tvJOGRS2gRjxv/WGqWvv2WG8hooF2RLo8MQWW9Xhz3wR3xF8IMlMI5JjCc
         lma+QLjCJc4cxrnATCdGcmglE5cUGAf+8NTWoOteBKnquoPIBHVfzqqAYJCuFqU7MFMZ
         zlsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789504288; x=1790109088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4qQtA38WyUCrnABIjsSOxjkbhli0tBAUE05eGg44IQ=;
        b=MwfWtak1OsRhpnTq4kBAL5onp4RzA8AoMdxxj7TZhFppYGzlnihZi8cLpqaD/6OG7l
         EFFOv51p0STYVbuv3dSMCB59tMsk9ZOHYmqdchquFp+2meGYZ+O06h8NpYnPqVBgN6pK
         TA1BoF2KgjGDXeGtH9VV0WG4PMrC9gEYRyJvbREn2vj1VyxyO+xA/C1XFI9Gk5JmKmbm
         QPreCJxtxEAR2OVvaWNMOfmCPW3eA8qzd+628p0IQoQ2GGR4XczMgHBj9omXtJ8maSqJ
         leORDL4LVjDK0wZKl1GWWIvVZxivJV1X4aFSodMoa3j5VcduF/zyIERQcY/2vIW3tcj7
         HgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789504288; x=1790109088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4qQtA38WyUCrnABIjsSOxjkbhli0tBAUE05eGg44IQ=;
        b=DTERz9xWIScy4U9QaQxyV3Xto5KvyW8q1/Gs9Npm0fWZAqMVHVOBNUaFbOMc7SYT7X
         6TAB/YEzw6jWoobJ7b1sO74XgU4goY8oJQts+vu/d+of+k+/z2iPopl7ySncbmxbfHp6
         y8NLrL/w9kBxJlyLMM7179z24GR724ZTWoHgG2+H+PB7jqEwc6n6WJOP9puFJtsuBD0Z
         UcYmaOyC9l5g7H8vi7oLe6wmv0qcz2UtrI5IoikASyYbXaFB6AGAmn2w51laiikX40d5
         +pks8hnnQj163mwmbOVSyWw0LHnxRNi7dfaqIk4TDIqIhkvEGM1tQu/QQe4VP4yDR20D
         57wg==
X-Forwarded-Encrypted: i=1; AKwUvBzETO2W3HU6tm98OZDrHMmnS+MLhgbAKKBs55M7vH6Dz3NsS8c7hSF6w3FFNyE7f0GNhGYfEbKmJxvSaPgQET9f@vger.kernel.org
X-Gm-Message-State: AFuF++m/gX3/acbuLruqTQxV48dsSstl0BTFiHZueaN18CFTozHn+QOR
	ZLTC9iJUmzIeJDZK4IVydFJ2rplfbMemEQshGpVho7IvMFq6k2AGbApsPLZGDomJNdnDFeRv0gU
	FJA3KEd6PxgfeHHMJdHKeNp+7uAefXEvlGX3kHrr5
X-Gm-Gg: AYBFou0wEqt7lDPrHr/Y6NAY1Ed/ZeBWSF82KsEIJpYfuTqcsfwb4WPs5zfHjGlgFSq
	zuqAL9KxMCVsQN5mLHN1QYH1YrAUXLBw2fADJPMrdrUX8gmHF63jPgWwxW4pOTpAtfHuh+SqzGu
	NWTCCVSS0yZgFtxHzwoiGluS+p6oRLdDFCF6mLxXd1h/vJG4FRXzwmz8bpSv9hWKrtW+T5/EZMy
	Jb0QMCBHp42swdFXiKeXCU04stWtr1xHjeKVttsxN8W+krzANmJd7LtQ9YwXSHa+5pg7VMIgvfX
	xhCGBEVLV/yIk/uYoTbdxzNBS5h6uUmNn2gp05eTWaW7RCaCIkzT3PrkGnsO9k/C+PJE38AkYaP
	wNX/RgXScKnMd8nnvYjJt
X-Received: by 2002:a05:622a:410e:b0:530:d9fc:253d with SMTP id
 d75a77b69052e-5325083c187mr3760411cf.6.1789504287753; Tue, 15 Sep 2026
 13:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819094621.844115-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260819094621.844115-1-zhanxusheng@xiaomi.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 13:31:16 -0700
X-Gm-Features: AcwNN1WFgS8br-gqCljlqnmsNAXf4O51y-fEe9NYb3rK422UoVElclllWgWd0cg
Message-ID: <CAP-5=fVXYFvWOEiH5R+Gc29nfKBGA6y6ULsT68Gudw7ErMVFsg@mail.gmail.com>
Subject: Re: [PATCH v2] perf symbols: Don't apply the symfs layout to
 synthesised paths
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Changbin Du <changbin.du@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, zhanxusheng@xiaomi.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 2:46=E2=80=AFAM Zhan Xusheng <zhanxusheng1024@gmail=
.com> wrote:
>
> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
>
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
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
> perf_basename() yields "" for a path ending in '/'.
>
> Tracing the lookups against an empty symfs,
>
>   perf record -o pd.data -- sleep 0.3
>   strace -f -e trace=3Dopenat,newfstatat \
>       perf report -i pd.data --symfs <symfs>,flat --stdio
>
> 15 paths get tried.  Four of them differ, in every case only in the
> prefix, which the patch restores:
>
>   FEDORA, UBUNTU, MIXEDUP_UBUNTU
>     <symfs>/debug/  ->  <symfs>//usr/lib/debug/
>   BUILDID_DEBUGINFO
>     <symfs>/        ->  <symfs>//usr/lib/debug/.build-id/
>
> The tail is dso__long_name() for the first three and the build-id file fo=
r
> the fourth, the same either way, so the build-id file was being looked fo=
r
> in the symfs root and the distro debuginfo under <symfs>/debug/.  Those
> prefixes follow neither layout: perf's own prefix is flattened while
> dso__long_name() is still appended whole.

Hi Zhan,

I'm having a hard time understanding the commit message and what this
patch changes. Thanks for providing the before and after in v1. In
those before and after examples, the 'before' case seems to better
match what the user is requesting on the command line, so I think I'm
misunderstanding something. Could you help clarify the details.

Thanks,
Ian

> Among the 11 paths that do not change are the basename lookups the option
> is for, <symfs>/sleep and <symfs>/vmlinux.  The same trace with
> ,hierarchy is identical between the two builds.
>
> Use path__join() at those sites, which is what the helper did for them
> before.  A hierarchy layout is unaffected, being that same call.  The
> OPENEMBEDDED site passes "", where perf_basename() is already a no-op;
> it is converted for uniformity.  Every remaining __symbol__join_symfs()
> caller passes a path from the profiled system.
>
> Fixes: f182573e06ab ("perf tools: Add layout support for --symfs option")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v1->v2:
> - Added the traced before/after to the changelog, as asked by Ian Rogers.
>   No code change.
>
> v1: https://lore.kernel.org/r/20260811050046.4019578-1-zhanxusheng@xiaomi=
.com
>
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
