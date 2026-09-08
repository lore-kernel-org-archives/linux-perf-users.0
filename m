Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DEB514775
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887685; cv=pass; b=Czv0nL1eIbI4+inIr+qmoXyW4cdGS/A1IPi5UCz+gWPHdhyc0sWS4rXI4EkKQCPT9zR2V6n5IPu3X1vkCzd7bnZ3oSqw7IgIu9+uI2GMHNM8m59EP4AAHRdjhzg8x4AlEeGGizWRZl8a0kqVCZkaOXbD5ib3VxJEY8mvFciWrfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887685; c=relaxed/simple;
	bh=XS2DOsAZdUoMv3cfbY4kaZFDPxLymXshnMS4j/7nPkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We/SjoUpEOribaEEfvwaPbAbPtddGrEQJu/DZl0tjLi525lhUnP9YxXE1EckVtk3DUn7natYYunLpTOk4wuDLtcxN+86XmK0eHaxeW83vLXbTuQbj/Gx5PfGtzzB977wdHOZk3UpCM2074X6ETc4OhtGLxLbDgD/SyalIGXKVdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjE/laDd; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjE/laDd"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so663561cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 10:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788887682; cv=none;
        d=google.com; s=arc-20260327;
        b=ReaZIA4tPcc/kKIUIA1iO5uP9cqN/50Li9NNYbG709+UsW1NknLW4ZGDHX8E8EYxuD
         /VM/6nvYsEhWcij8BbpxdHQTVDJBJyjWxYFFnOpYDPqa6wAghibBHFX3sg/cXvnqH5eZ
         oyftqEUTURnYjrPEZhRzsNINZDUahgFwJqCTcfwdjkDGmswuJ5VmMtQAXOHY5qZEP214
         UpgbvWHdpkk++9S+cUPaxE5NtuMLS89E/sqNuaHxAyBewR0WRF4jJUvXyl6QbkgrrQ73
         w5HpzWBaBRt1aQL6aDPRUeQxTR8GDSIh16FxQDHRzmHt+EoxnWNhFSPp1elcoLhD7S3u
         b+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CXI7gwxxGgVVUavBiXahE7l6pKPePlATykxGcqw8prc=;
        fh=RU9VTTfBVOM35XncLFyhhZ8cpP6tzYUUmPeYMcKopFc=;
        b=i6pFbs1ZcARANJPtDexnaa1xge/v7BtprCnPl+IU9zjg7fRX2JCrz9Cys5x6h/585C
         UEizSvwvsHba6K5lfIlU3MoDDDkeYwqVtlaMmyGgZ4Tjd21uR7xjEsHM9Q7ZndsXDqvE
         zG5XWlZOb5s9w7jOm0DUuZqsScQt/f0iwZbwthZ75o1Yzt/5G+nkbgy3wWlLghkG32MZ
         tLO+M1Eu8QAIZPdV4vC9XBy9njPIZkNhHxfqz7EruQiAGGr1ILm1yZpMSYpeTLDbUr5K
         1vf0sEt6i/siUGh/eWeLAIHqs+JNQpsYyYYD5d6/gOJrjYTomsV6EsN4kAQ4G0AXTqCg
         aC2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887682; x=1789492482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CXI7gwxxGgVVUavBiXahE7l6pKPePlATykxGcqw8prc=;
        b=wjE/laDdweUra2t9SxOM/VgEg0OYbN9xpc4amKwWLzkXugnnpH0p26dAoqzr2cSP0x
         k3eOg0xwwStCN7JC5z1ph/6ADmthNSAGunPUnMJqDodpt++0lp08/dvxC0DxmD2ggCkk
         cslwZPowfCGw4Z59cDn/wED71welEUW5UKIqY3yU6E020erqt8Bjry6MdqCYIoSYY3f/
         4F73bPkjRZRuf4DrvDqQRgSGL3ebVTRdow9/HtSPqh+ryGrJFuR35jV0nW2x07chizFU
         RRgB06h4H2TQ0+Jfqlscotd2CPFGduiyaqOmmfnSdbymXE+BsKx7dTZe5o34EvTG3WjD
         PzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887682; x=1789492482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXI7gwxxGgVVUavBiXahE7l6pKPePlATykxGcqw8prc=;
        b=FjFB7B+xiGmpjgL5vm2BD7mtnsbW6S5U85zA6Fa+KssR6EKfNUyAsbOWMFD6tmqjyv
         eudc23Iv6h3NR2yGcNKKGyMnPS7FPQ5C5VofuY4PuOtQk/Ow2Dd9czPmzsBs+zEEVWzN
         TSyqjm0i6GqNsshJ2NJoFxmKfNkNXB1yZE8ngetpXkgfUO5uUTaSMFURN94vq9RGQqmI
         0Zvf5Jth51prYcGe2Soe4ihNL+Kfn1AUPmH6dXqTv4rGlDJxQ6OltxVGqTc3GyaO/3J2
         h5TpVHfceElZSc94VD4iftJX5jBL0NgObttUXp2ArA8evuAfY6uW69Ppw+u1HhGKgFAM
         QsZg==
X-Forwarded-Encrypted: i=1; AKwUvByW8Yxzdy3Jr70GlSK8yL+IJunRVB2UC3ZC4qtfH1iJRNagln6OJMs1nCk95MI6IIaLxyQxNk5DTouX4nXwJ/yU@vger.kernel.org
X-Gm-Message-State: AFuF++mIJnGksJsYQfJcNKwLexj/vmLB7zbASi0a8Z8x95h8+aqKWxwP
	+kUAsmtTQcJntBgWV36Jw4tsHlXVunZRnoTqtEcjHzj8QnRNbgt/UNvG6VaVnNYBuVFxaH7x5a0
	XV/Kue+KtV38co5XTZt9J+u6ZdMjhXM944VIgw8Zl
X-Gm-Gg: AYBFou2L808LdzD7iBihqc7buEOr/nsAxkZLKQQ1/bSveTGLXZVfHmocLH2Y57aUr+e
	gRsT9F3wKmtEoZkZhtiF92iK1AIWjG7aD4QVE30DC734hFhyAwhBrST7AUwaZAUy9nzbu5muwsx
	tmPNpxtoBtFTX7aPQgB8DEMJHFpZWTS+9+ZqaeY2+AAmNQeBRWHICuWJ/Y4JxN//AeYdYgpWkXd
	CZXWMzLKPQF6uICvYRzV/b0E+uLjgtaYNGXYgGqTJE1Bm3ox/hYKn9podBY5Qhu+3Dq5DXGTpAB
	d6xuj2g1KQIVeqvKan5atNFxeqi7hyWtNN2a3UMVXwwVvYBm3twPXItofIYGKXOu4mxCujOC7Pq
	hjXFl7MgU
X-Received: by 2002:a05:622a:248a:b0:530:4381:e745 with SMTP id
 d75a77b69052e-53065e09975mr57662611cf.10.1788887680279; Tue, 08 Sep 2026
 10:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152053.192830-1-adrian.hunter@intel.com>
In-Reply-To: <20260908152053.192830-1-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Sep 2026 10:14:29 -0700
X-Gm-Features: AcwNN1XltQf19Ey6oq449cA6CXMDbtRn39Dr-pAV5hAwRRGJUgEcpH4Z84Ojdh0
Message-ID: <CAP-5=fUY9H-26_CAE6yLXr9ci6F4Wia3BsFJjeDqbPo1qcO7Eg@mail.gmail.com>
Subject: Re: [PATCH] perf test: waiting.sh: Replace timestamp polling with sleep
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 8:21=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> The waiting helpers implement timeouts using:
>
>   date +%s%1N
>
> This relies on GNU coreutils date truncating %N to the specified width,
> so %1N yields tenths of a second.
>
> Rust coreutils (uutils) interprets the width differently and does not
> truncate the nanoseconds field.  Consequently "date +%1N" returns all
> nine nanosecond digits, causing the elapsed-time calculation to be done
> in nanoseconds while timeout values remain in tenths of a second.
>
> As a result, timeout comparisons succeed immediately and the waiting
> helpers time out on their first iteration.  This causes
> test_intel_pt.sh to fail on systems using uutils "date".
>
> Avoid implementation-specific date formatting entirely.  Instead, wait
> for 100 ms on each iteration and count the timeout down.  Besides fixing
> the portability issue, this removes the busy-waiting behaviour in
> wait_for_perf_to_start(), which could otherwise consume CPU while
> waiting for perf record to start.
>
> Since the timeout is now based on repeated sleeps, it is only
> approximate.  Update the comments accordingly.  Also make is_running()
> wait for exactly the documented number of tenths by changing its timeout
> test from -gt to the new logic, and quote tm_out in the modified code.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/waiting.sh | 34 +++++++++++++--------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/waiting.sh b/tools/perf/tests/she=
ll/lib/waiting.sh
> index 3a152892e077..43f4322dbe9e 100644
> --- a/tools/perf/tests/shell/lib/waiting.sh
> +++ b/tools/perf/tests/shell/lib/waiting.sh
> @@ -1,77 +1,75 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>
> -tenths=3Ddate\ +%s%1N
> -
>  # Wait for PID $1 to have $2 number of threads started
> -# Time out after $3 tenths of a second or 5 seconds if $3 is ""
> +# Time out after approx. $3 tenths of a second or 5 seconds if $3 is ""
>  wait_for_threads()
>  {
>         tm_out=3D$3 ; [ -n "${tm_out}" ] || tm_out=3D50
> -       start_time=3D$($tenths)
>         while [ -e "/proc/$1/task" ] ; do
>                 th_cnt=3D$(find "/proc/$1/task" -mindepth 1 -maxdepth 1 -=
printf x | wc -c)
>                 if [ "${th_cnt}" -ge "$2" ] ; then
>                         return 0
>                 fi
> -               # Wait at most tm_out tenths of a second
> -               if [ $(($($tenths) - start_time)) -ge $tm_out ] ; then
> +               if [ "${tm_out}" -le 0 ] ; then
>                         echo "PID $1 does not have $2 threads"
>                         return 1
>                 fi
> +               sleep 0.1
> +               tm_out=3D$((tm_out - 1))
>         done
>         return 1
>  }
>
>  # Wait for perf record -vvv 2>$2 with PID $1 to start by looking at file=
 $2
>  # It depends on capturing perf record debug message "perf record has sta=
rted"
> -# Time out after $3 tenths of a second or 5 seconds if $3 is ""
> +# Time out after approx. $3 tenths of a second or 5 seconds if $3 is ""
>  wait_for_perf_to_start()
>  {
>         tm_out=3D$3 ; [ -n "${tm_out}" ] || tm_out=3D50
>         echo "Waiting for \"perf record has started\" message"
> -       start_time=3D$($tenths)
>         while [ -e "/proc/$1" ] ; do
>                 if grep -q "perf record has started" "$2" ; then
>                         echo OK
>                         break
>                 fi
> -               # Wait at most tm_out tenths of a second
> -               if [ $(($($tenths) - start_time)) -ge $tm_out ] ; then
> +               if [ "${tm_out}" -le 0 ] ; then
>                         echo "perf recording did not start"
>                         return 1
>                 fi
> +               sleep 0.1
> +               tm_out=3D$((tm_out - 1))
>         done
>         return 0
>  }
>
>  # Wait for process PID %1 to exit
> -# Time out after $2 tenths of a second or 5 seconds if $2 is ""
> +# Time out after approx. $2 tenths of a second or 5 seconds if $2 is ""
>  wait_for_process_to_exit()
>  {
>         tm_out=3D$2 ; [ -n "${tm_out}" ] || tm_out=3D50
> -       start_time=3D$($tenths)
>         while [ -e "/proc/$1" ] ; do
> -               # Wait at most tm_out tenths of a second
> -               if [ $(($($tenths) - start_time)) -ge $tm_out ] ; then
> +               if [ "${tm_out}" -le 0 ] ; then
>                         echo "PID $1 did not exit as expected"
>                         return 1
>                 fi
> +               sleep 0.1
> +               tm_out=3D$((tm_out - 1))
>         done
>         return 0
>  }
>
> -# Check if PID $1 is still running after $2 tenths of a second
> +# Check if PID $1 is still running after approx. $2 tenths of a second
>  # or 0.3 seconds if $2 is ""
>  is_running()
>  {
>         tm_out=3D$2 ; [ -n "${tm_out}" ] || tm_out=3D3
> -       start_time=3D$($tenths)
>         while [ -e "/proc/$1" ] ; do
> -               # Check for at least tm_out tenths of a second
> -               if [ $(($($tenths) - start_time)) -gt $tm_out ] ; then
> +               if [ "${tm_out}" -le 0 ] ; then
>                         return 0
>                 fi
> +               sleep 0.1
> +               tm_out=3D$((tm_out - 1))
>         done
>         echo "PID $1 exited prematurely"
>         return 1
> --
> 2.53.0
>
