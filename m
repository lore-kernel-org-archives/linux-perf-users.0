Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158135;
	b=gSDg96UMGIx+kbHCwQGojkPDbifvn/gWeBnFRf9PDrp0w1WONfY+gjocO6iFPrr/QhjJ
	 bg1o9vw/n7XHl02SVpKlQyVsOnn+H6lxbVEo8aX3S0MK7CaXJlCWMr9M+F9E95OW6ULU9
	 K2W62KuimHx9KQooDjZCJPEVTzFhGC3e16bvKxk/BK9botMd5UMVbC6VwDh7R6C7iZjOH
	 sCGUpMMyvvZZDFR3K2u0tYt5oFFqMW2K+xJrApHFl7qrVwCTRsiLkwWwnQpXJBIsZuUed
	 UsdO1NzGBx4RI1AyfLI0whLMMHd8uuTZnttf5sj4BvM+s1Tor1PS69QH0aN7QPfug0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158135;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PERjcEyNGpzxGtD7rWbB8uj49L9am7nQuAcshipXyEU=;
	b=yLIxYbXka9uhaU/UmYkq7fY1Zp6SbwpECyFHQPblVzAaO4vsKT5eVaS3FK6/92QEHHHK
	 /QyQxJRexUUlITVuG/eQW9fI8f/gOgHuya7T04R683ORnLNNSzYq0FK+glwyKY29JGcdv
	 FL9zJ7H1Ih5cCoX77hHOrRoUcyXU8B0ZUpcJXbjDABggvpBkE9o8OyKypmJ3JdwNxUehA
	 L9ebRjha68HdXPy2QeQbUvY8/WHRAQkge7QfkdhIOW/Iy9s+fQJHViUJGPTrUyUNYNPqt
	 AWZVSOa7DlhAq32Hsm1e0fPiICCBOpC0bcnlY2NqSRlOkY0SJ/FV4Q2AiBJ25VP0jxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cj5uwk4x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F1606A325;
	Fri, 20 Nov 2026 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cj5uwk4x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9360E1F000CF;
	Fri, 20 Nov 2026 07:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795158134;
	bh=PERjcEyNGpzxGtD7rWbB8uj49L9am7nQuAcshipXyEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cj5uwk4xUxIflkjLa4ehcOmmydNohN74gt/+Opl8ZHJRkITfesztBzjJDSBqZC4R0
	 /LqrWXekQiUINvxwVhuDwvMU/Race16R/cbpA5jOdjAyUvbTmYhUtaCcnCZMF89Y0C
	 GaB+ykfseX4xCsdiiAVPi8IKawGIsnLFhuaHSPsWkPF5/Pv2TIHWHTKWVTA3itJ3Ir
	 rZ1VnMsJLkFxo9W6fP2TpqwOMk8/R07GZEwoldsTz+Il3kZ4WlPaTkTBq4kftlKbA9
	 mKo2wFSqAq7rsYf7V8dbtJwTsS6TXi0h1f37KKbhwKbmxJTUc6LbILR+RrU5Mne+yC
	 BbQmnVnbSP8Ug==
Message-ID: <sashiko-outbox-224590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf bpf_counter: Say why the perf_event_attr map can't
 be used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Zhengyang" <hang.zhengyang1010@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261120-bperf-attr-map-err-v1-1-b12b6b550273@gmail.com>
References: <20261120-bperf-attr-map-err-v1-1-b12b6b550273@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:02:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf bpf_counter: -Werror=3Dsign-compare in bperf_pin_hint() on
  32-bit glibc
- [Low] perf bpf_counter: missing errno.h include for errno in
  bperf_lock_attr_map()
--

commit ef2748ac810907c5c84a28e7a31cf730bd68ad09
Author: Hang Zhengyang <hang.zhengyang1010@gmail.com>

perf bpf_counter: Say why the perf_event_attr map can't be used

This commit reports specific errors and a bpffs mount hint when
creating, pinning, opening, checking, or locking the bperf
perf_event_attr map fails.

Link: https://lore.kernel.org/all/YFneUHDiAt8Rg0cc@kernel.org/

> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index 9362e45e17ceb..9a463eb9d51d9 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -3,11 +3,13 @@
>  /* Copyright (c) 2019 Facebook */
> =20
>  #include <assert.h>
> +#include <libgen.h>
>  #include <limits.h>
>  #include <unistd.h>
>  #include <sys/file.h>
>  #include <sys/resource.h>
>  #include <sys/time.h>
> +#include <sys/vfs.h>
>  #include <linux/err.h>
>  #include <linux/list.h>
>  #include <linux/zalloc.h>
> @@ -32,6 +34,10 @@
>  #include "bpf_skel/bperf_leader.skel.h"
>  #include "bpf_skel/bperf_follower.skel.h"
> =20
> +#ifndef BPF_FS_MAGIC
> +#define BPF_FS_MAGIC 0xcafe4a11
> +#endif
> +
>  struct bpf_counter {
>  	void *skel;
>  	struct list_head list;
> @@ -376,6 +382,24 @@ static bool bperf_attr_map_compatible(int attr_map_f=
d)
>  		(map_info.value_size =3D=3D sizeof(struct perf_event_attr_map_entry));
>  }
> =20
> +/* bpf_obj_pin() only works on bpffs: say so if that is why it failed. */
> +static void bperf_pin_hint(struct target *target, const char *path)
> +{
> +	char buf[PATH_MAX];
> +	struct statfs st;
> +	const char *dir;
> +
> +	scnprintf(buf, sizeof(buf), "%s", path);
> +	dir =3D dirname(buf);
> +	if (statfs(dir, &st) || st.f_type =3D=3D BPF_FS_MAGIC)
> +		return;

[Severity: Medium]
Does comparing st.f_type against BPF_FS_MAGIC without a cast fail to
build with -Werror=3Dsign-compare on 32-bit glibc?

0xcafe4a11 exceeds INT_MAX, so BPF_FS_MAGIC has type unsigned int, while
struct statfs f_type (__fsword_t) is a 32-bit signed integer on 32-bit
glibc targets.  Casting st.f_type to unsigned long, as is_bpffs() in
tools/bpf/bpftool/common.c does, avoids the warning.

> +	if (target->attr_map)
> +		pr_err("--bpf-attr-map: %s is not on bpffs\n", dir);
> +	else
> +		pr_err("bpffs is not mounted at %s, try 'mount -t bpf bpf %s' or use -=
-bpf-attr-map\n",
> +		       dir, dir);
> +}
> +
>  static int bperf_lock_attr_map(struct target *target)
>  {
>  	char path[PATH_MAX];
> @@ -393,30 +417,41 @@ static int bperf_lock_attr_map(struct target *targe=
t)
>  					sizeof(struct perf_event_attr),
>  					sizeof(struct perf_event_attr_map_entry),
>  					ATTR_MAP_SIZE, NULL);
> -		if (map_fd < 0)
> +		if (map_fd < 0) {
> +			pr_err("Failed to create perf_event_attr map: %m\n");
>  			return -1;
> +		}
> =20
>  		err =3D bpf_obj_pin(map_fd, path);
>  		if (err) {
>  			/* someone pinned the map in parallel? */
>  			close(map_fd);
>  			map_fd =3D bpf_obj_get(path);
> -			if (map_fd < 0)
> +			if (map_fd < 0) {
> +				/* report the pin error, not the bpf_obj_get() one */
> +				errno =3D -err;

[Severity: Low]
This isn't a bug right now because the generated BPF skeleton headers
pull it in transitively, but tools/perf/util/bpf_counter.c should
explicitly include <errno.h> at the top of the file for errno.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-bperf-attr=
-map-err-v1-1-b12b6b550273@gmail.com?part=3D1
