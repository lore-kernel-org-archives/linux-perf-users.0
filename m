Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A362FD1C2
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774096668; cv=pass; b=htYB76hpbTb3dyWL/MOS+qg5CVjucvz6h33mSvXcgpvd+46NBU3Nu6lYIZq2Ogxiz111EhRm1s6tCLvxV4bH2LRnM7GB7cppTZzDQoq176rn7QUXAjbMjAEyAY2x+kkK3QAK/M/ne/FfwoPSToNhqI6d+FWpggO2Pe6kkkSWxYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774096668; c=relaxed/simple;
	bh=ldYXzSM0a4a6oZo8VSiYbhjlglQ/I/gBNkLRtQjLpAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxe0f+Y2CzqPApvPhWz57QJgoOyhA9ZbdqGGcmhkn4H0Qm7eME3R8mjIeoFc5qY/vjVSDdk83cUf0p032b5CAwH4PXDfEeAosb6am575GmJ3wIz5shh9786k0w1oJRalOuaVIQPWNHZxG17X2u340o9gEViGP+82HP1me32Z7cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6qWHIEc; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6qWHIEc"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a2ee65171so14243327b3.2
        for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 05:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774096666; cv=none;
        d=google.com; s=arc-20240605;
        b=aSVM1POx1uithpe21onyrW2NkLZdVOLlUGa2b3aZArWeLeU9qu3m+eu8qWZpIjvdr6
         irJGo137OAl3ToXGhXwc2ptAVwAOqkI/aRltrRhsA3idAZABQ8ChcIl8P1KyB3+2vkQZ
         SE//CqhZyAHpHv9W+uxeBDfPZYSA44C6yX8ZHhvyW+sMrO4oMxVa0s6xMMgN1PLV7qAj
         jKw8TSNEIDjz2NeEa+J2mxMgrMrkFDPRmQqExxuVsJ3BD9E02ZdrfJiRJKq+yGU+flCh
         45JxwLeNszVQhjVxeSTFLo9G6VsJlpMoPIJKmkexLzBCehVYWGQa/ixPtdRCfiU+nsUJ
         fEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dpFgoUOdRN5iYXgRsH3KmveUpjhuVCY3dYwmKgUMeiU=;
        fh=pl+QBqsETahEm1JO6FfcfmrVIFLvMc4eoq5ketU52TQ=;
        b=Xfrg7/NiQgdGORGj6uF6Fk2uHfUISqBNTX9DcxRAsT9L9VAFw6TQpN2Er5iYJ+v9gA
         okKDCSZ6sJSW6/GuSZ9Eg9G0PBar3QhpEOyDr0ey5dV0iHni+wdp++1o/jT+1mEnoQ0I
         Koe0mtq0MrF0hXqADM8lSdZsjAn/XmTS8yJTbLQGw4Q7hPUzeLo0unE4EF4LBfJ7NoPv
         3mL3wXyp5R9DJFwR7+z32pnernBrblJa0CAGqxKhwz5G954z52+pItDOoL7ywFabCGgH
         Nr0FAf+OYvXq8JIhvhE5PgKmhVCXvpwxNu4lQabDmNTG0/J/qe84T3ykZHsA0lxANDPp
         nLiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774096666; x=1774701466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpFgoUOdRN5iYXgRsH3KmveUpjhuVCY3dYwmKgUMeiU=;
        b=P6qWHIEcB2q+BwKJTwQiy0R7Lrn0RPBuQPUfAfAbadxtRU+8LGn/B/ZLrMtwAc4Pki
         nnGiv9oRPepfCcxusE7aOWprFyDon/94dMJvG4rYiAG8+WBmUK+Bi1dw1N2B4k1bYxxq
         oZS4llV4730IsuHZZrVrS0ueCL49Ywv3XRRGYHQOSQ2DdNHXAkj5uN0HuUmYfk4s6O95
         lED8tss/lPyVR4jjFfBU8bpcy0QF18RqqBJ/nUi5ua5c7IEWDnIWE/fDUIxgcEHaFmt4
         vdu23Ivwd2XmS0HDQdJrPxhxJR5R3kq5Yw7tBmQ7xw4MPqx32eL0ge5CwvQ6mkIbgjEJ
         PMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774096666; x=1774701466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dpFgoUOdRN5iYXgRsH3KmveUpjhuVCY3dYwmKgUMeiU=;
        b=Bn5dsxv+otTdztAn0XvyUQM7A+Bn1SR8AQAbnw9sr0Me6+9zBCvW6isYAQc506MhbA
         bXACpidarrdyxFwFf6ezYnqWHyjgDKlZ2EP1ZEEqehyNKf5h4wHdxKvjw22aDx2vPXhy
         166ZZ0iEzZuyyk2BHHaNPunbA6unXKewVIzn+YCvh6dIjfgq6G70M32qXRYDVNI6tkMH
         nNr2Qi8O63lp1ZQaTHGlzeQe5kI/r912M+iRc0maCtMjCtXXt6vHq2fWz5wQjRjMz5U6
         lPfakrANzu9TBCd3FTng8qltDvSgPPpQ0ZpBzlVwrlXkeE0eFtK5xEJG7AD1C1sWX0mj
         rHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPPaacrna2eZNqTwOMDnmeGaRNH0WnJ30hJtm5Zu0XnG6hiaZ2lEdHT8Iu99/vIhT/z/iWlHQ5rVXVKysOj85e@vger.kernel.org
X-Gm-Message-State: AOJu0YwxN0WPkuRdeyMZPjWUuPFVsV8VfyEQCcYK1KIxHjNshYKN7o4W
	8d+Q6AaIGFleNxD29dwKNtyms5cwUNAV9FCHvdxZtCS5rD5Fi7picCZ/QHKSgNWuEudaa+XZHdy
	PQ/i8jS5szCtHi0erc8Q+KBsWkKwvDO4=
X-Gm-Gg: ATEYQzxZvZEPOGXNf0nsuD4rKRoSOROFx4Y7ax6MVBek1yFRLyRTzvCjLxWswGb/PSQ
	C93IR/SwFvMCiDXSsQjfMet2QPHCwFgOyMsuXdM0f/nq50HZC8O3m9Ld0BNp6PzHFr+XC8VauNo
	fOtxR8z/hX3JR2txbz4ym7Rjk/ck3yLpDP9egs4UZYc9KpPT8Em1QA4lGqt3K4dJekTPTX5kw4/
	sS0S3shSFwZRlnqNrv6BrEm9AH4KIRzMJwxtDT16ID1pngPWsFH8uGCQK0UHpFDcoD8h+INPV6h
	9ufksis=
X-Received: by 2002:a05:690c:c50f:b0:79a:67a0:adf1 with SMTP id
 00721157ae682-79a90c0fe7amr63690597b3.45.1774096666368; Sat, 21 Mar 2026
 05:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com>
In-Reply-To: <20260321024446.692008-1-irogers@google.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sat, 21 Mar 2026 20:37:33 +0800
X-Gm-Features: AaiRm53HFbDIUrKe-Rb86baRpuN3IFWOmDLCJEUpczYt3PQeQaZg_ARK_0C0sVY
Message-ID: <CABFUUZHL=kzBKZTkrCADyxkMp3BHXMhMKAuBFqYvNpqST4v3fg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Ian Rogers <irogers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 10:45=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> The hashmap implementation contained strict aliasing violations.
> Specifically, the hashmap_cast_ptr(p) macro was casting pointers (such
> as void **) to long *, and these were subsequently dereferenced in
> functions like hashmap_insert(), hashmap_find(), and hashmap_delete().
>
> C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> through an lvalue of an incompatible type. Dereferencing a long * to
> write to a void * object is a violation, even if they share the same
> size, as they are not compatible types. This can lead to undefined
> behavior, especially with aggressive compiler optimizations.
>
> Fix this by:
> 1. Updating hashmap_insert(), hashmap_find(), and hashmap_delete() to
>    take void * for their output parameters (old_key, old_value, and
>    value).
> 2. Modifying the implementation to use memcpy() and memset() for
>    accessing these output parameters. Accessing an object as an array of
>    characters (as done by memcpy) is a permitted exception to the
>    strict aliasing rules.
> 3. Updating the hashmap_cast_ptr(p) macro to return void *, ensuring
>    compatibility with the new function signatures while preserving the
>    static assertion that ensures the pointed-to type matches the size of
>    a long.
>
> Input parameters (key and value) remain as long, as they involve value
> conversion rather than incompatible pointer dereferencing, which is safe
> under strict aliasing rules.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/bpf/hashmap.c | 21 +++++++++++----------
>  tools/lib/bpf/hashmap.h |  8 ++++----
>  2 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
> index 140ee4055676..ef50d262a126 100644
> --- a/tools/lib/bpf/hashmap.c
> +++ b/tools/lib/bpf/hashmap.c
> @@ -8,6 +8,7 @@
>  #include <stdint.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> +#include <string.h>
>  #include <errno.h>
>  #include <linux/err.h>
>  #include "hashmap.h"
> @@ -153,24 +154,24 @@ static bool hashmap_find_entry(const struct hashmap=
 *map,
>
>  int hashmap_insert(struct hashmap *map, long key, long value,
>                    enum hashmap_insert_strategy strategy,
> -                  long *old_key, long *old_value)
> +                  void *old_key, void *old_value)
Maybe we should be more cautious about changing the API definition.
It weakens the interface for no clear benefit.
>  {
>         struct hashmap_entry *entry;
>         size_t h;
>         int err;
>
>         if (old_key)
> -               *old_key =3D 0;
> +               memset(old_key, 0, sizeof(long));
>         if (old_value)
> -               *old_value =3D 0;
> +               memset(old_value, 0, sizeof(long));
Using memset() here and memcpy() below make sense for addressing
the strict alias issue, but I don't think that requires changing the API.
>
>         h =3D hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
>         if (strategy !=3D HASHMAP_APPEND &&
>             hashmap_find_entry(map, key, h, NULL, &entry)) {
>                 if (old_key)
> -                       *old_key =3D entry->key;
> +                       memcpy(old_key, &entry->key, sizeof(long));
>                 if (old_value)
> -                       *old_value =3D entry->value;
> +                       memcpy(old_value, &entry->value, sizeof(long));
>
>                 if (strategy =3D=3D HASHMAP_SET || strategy =3D=3D HASHMA=
P_UPDATE) {
>                         entry->key =3D key;
> @@ -203,7 +204,7 @@ int hashmap_insert(struct hashmap *map, long key, lon=
g value,
>         return 0;
>  }
>
> -bool hashmap_find(const struct hashmap *map, long key, long *value)
> +bool hashmap_find(const struct hashmap *map, long key, void *value)
>  {
>         struct hashmap_entry *entry;
>         size_t h;
> @@ -213,12 +214,12 @@ bool hashmap_find(const struct hashmap *map, long k=
ey, long *value)
>                 return false;
>
>         if (value)
> -               *value =3D entry->value;
> +               memcpy(value, &entry->value, sizeof(long));
>         return true;
>  }
>
>  bool hashmap_delete(struct hashmap *map, long key,
> -                   long *old_key, long *old_value)
> +                   void *old_key, void *old_value)
>  {
>         struct hashmap_entry **pprev, *entry;
>         size_t h;
> @@ -228,9 +229,9 @@ bool hashmap_delete(struct hashmap *map, long key,
>                 return false;
>
>         if (old_key)
> -               *old_key =3D entry->key;
> +               memcpy(old_key, &entry->key, sizeof(long));
>         if (old_value)
> -               *old_value =3D entry->value;
> +               memcpy(old_value, &entry->value, sizeof(long));
>
>         hashmap_del_entry(pprev, entry);
>         free(entry);
> diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> index 0c4f155e8eb7..a888bf8c05de 100644
> --- a/tools/lib/bpf/hashmap.h
> +++ b/tools/lib/bpf/hashmap.h
> @@ -116,7 +116,7 @@ enum hashmap_insert_strategy {
>         _Static_assert((__builtin_constant_p((p)) ? (p) =3D=3D NULL : 0) =
||                 \
>                                 sizeof(*(p)) =3D=3D sizeof(long),        =
                   \
>                        #p " pointee should be a long-sized integer or a p=
ointer");      \
> -       (long *)(p);                                                     =
               \
> +       (void *)(p);                                                     =
               \
>  })
>
>  /*
> @@ -128,7 +128,7 @@ enum hashmap_insert_strategy {
>   */
>  int hashmap_insert(struct hashmap *map, long key, long value,
>                    enum hashmap_insert_strategy strategy,
> -                  long *old_key, long *old_value);
> +                  void *old_key, void *old_value);
>
>  #define hashmap__insert(map, key, value, strategy, old_key, old_value) \
>         hashmap_insert((map), (long)(key), (long)(value), (strategy),  \
> @@ -147,14 +147,14 @@ int hashmap_insert(struct hashmap *map, long key, l=
ong value,
>  #define hashmap__append(map, key, value) \
>         hashmap__insert((map), (key), (value), HASHMAP_APPEND, NULL, NULL=
)
>
> -bool hashmap_delete(struct hashmap *map, long key, long *old_key, long *=
old_value);
> +bool hashmap_delete(struct hashmap *map, long key, void *old_key, void *=
old_value);
>
>  #define hashmap__delete(map, key, old_key, old_value)                 \
>         hashmap_delete((map), (long)(key),                             \
>                        hashmap_cast_ptr(old_key),                      \
>                        hashmap_cast_ptr(old_value))
>
> -bool hashmap_find(const struct hashmap *map, long key, long *value);
> +bool hashmap_find(const struct hashmap *map, long key, void *value);
>
>  #define hashmap__find(map, key, value) \
>         hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
> --
> 2.53.0.959.g497ff81fa9-goog
>
>
