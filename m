Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AA4D0A1A
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499943; cv=pass; b=lgIG7niTYa29gvqG/UEJoGePHyVYX8h5QcGGDsoZC/jz6mswA7eLMjtiOlA/4EUSgNkirzw+EKpqY8qpQTGcMyUcWRvv311hmAemPfLkMuiyZ8puYJJgIqbummNEQW6pMZOLWKXBAumHdtIFUrMVR0ZZC2nv3yAiKLGiXbNZCpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499943; c=relaxed/simple;
	bh=OIMXW2p+LoIfBZQlwGRdiXbHxWCzFXupB1E88y6g8no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTo3nqwQ5E35XmQ5InB9RR8G5omMsPZ2/j2kiNZf5zQGLYvJkYr7spT7SRU7Yy+HzRTUbRwoL8SZ6DdU0u1pNiE6i/FLkchFTvXHOL0Bo2DGDQXw7WRndFrrkTkhU4lCvqjxG+EOUVVOB/vXdu/cxGmTOZCnUDIAGqbZsjsXTqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ob1c7Fio; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ob1c7Fio"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd84862f2bso23045ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 12:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789499941; cv=none;
        d=google.com; s=arc-20260327;
        b=d+Pe63oHfthRCyjLZEsmrw5m3M/quI/mLOHVFNwEvyf9cnF7Q5pc+wd7J49+nbWxH5
         U6NlC5dtyxHQcHfXxqjOFKZ7dEoZDyfxGLV5uUznbs3Gvb64pMyPV01P0wJKjDAwyYNa
         VBl6LrtdsDYaO0EhqHve8zLYbwTKoH8+gU3RvuMNr9gkFu4amW8Y5RuZFNGYwN7KrbZZ
         mBU2trlfwJ8w4RRvrtgL4s/Q7HM19ZmGFe40XKbs9jN47JqLjdfPEQkvnXUFKLMluFiB
         wszP3UJV+dAr7hNJnMW07SoH/1qTfLptp8cmm3PFBLL/y0tYu1Dqd8YboD6TFJgYcbSi
         1tZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMRbSG5pSyQsgrHghUA9Em6/+/sgJSdN99MR2yP4Gxw=;
        fh=5+mnIvC6D0AbavkvGR3DbrDF/gzJKNgyp5yXZ8HHzQo=;
        b=K8OdUzyYqk0KzS0/4LqXijZFTP/1n4nNKXjS8/cZRF5fkFGy1cRRAiPCDO+jaBtrrl
         jvWPcclZb4JNEanhlC8YrcHkRM8gEFYeY9i5N6HGR6jrQe6scTBh+xGpjYkALoU7GIx7
         UWb0au4+olfo3YkPhrTHivUhkfIsw7dS2YFYnxfKJ/u2ywkyd8ijV1GgDzIpM3+C3Fb8
         j9kAOJnsyc9WtLAfAnqBr1V5DqT5BJm21QfGRJ5anuFAh/iVfBwaWm/UBHXnVz/gfL+3
         TtGOAhGRsMXd9UeUYNn5acy+Yh7ZKT7LBx4Ab2wz3wE6LLAtMyNKtGeUnr7EYMf01Q3p
         Ay9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789499941; x=1790104741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VMRbSG5pSyQsgrHghUA9Em6/+/sgJSdN99MR2yP4Gxw=;
        b=ob1c7FiorVkzJfBxjkEPlw9WmJAHlXjyx6ePlJZ7MWkEZHGqzhL/x8PZdEK5JKf8Xv
         nHTjIZWSjr2pNw+J/FLKATkJq3J7fo6swIWk7Sg9rE0V93XHPlq5CWn9jrT5nbDCuWAw
         n6lzqwJdL6bWPoXXWy2jIkcUIwaagvOyPewPkzk09wNSY0OtBs4WP7lAK/txJB5G4bIt
         V+iaLCgLf8lp1Dgwl2tNncKHtBlX2DxCCkDC7I5HzBGlw6NkJtil860oX/45cJ6nFLaZ
         0X2q+UnzNDsRTj8WTRzSTDr9SQ4rJWnAsHqUdNCceP3P71wUxCm39BHQUmeMKIMGaU96
         20hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499941; x=1790104741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMRbSG5pSyQsgrHghUA9Em6/+/sgJSdN99MR2yP4Gxw=;
        b=lGexdD4g5HJy/Z6zf0+Fz235l36nsZ6AzjastqqQLyUDgUwLnzstHK2wtT+7E/TmaF
         HMhwINDBxibRI2Jm3tSgAApV2rKxyfqhAobcGXR6HqphE0uinlPMPCwJSFni/MwOZTGZ
         ohsqiaFMGupJdgTtRya1Gtvk0+z7DzrcFa1r33C4t502R4l1HnNJ0ZbKW26Wrx2YjceG
         qPsepWdOoENYQOMAtd6rP24+Vstgn7eXvorI6E8emelKaam/9irLlaYjzRX2rUxaG6E1
         PoZz2gBuvzNqktQTNr0guPIjb/jpJgNxNZ2fkZRGEZnD4JZMGlzd7nWackTLR+JELmyB
         VlwQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7rxMri7fk932WvsbraR/V/llENjWEbm1osR2o0zqbw3pqA+gr830/vjuv/EEIlYlOa4Kk9r6RJCT9pqA9gAzo@vger.kernel.org
X-Gm-Message-State: AFuF++n0MaUlZqM9s+MSwg559YiaL8wzAi9r3F2mbZKxfbXa+sMLqYTC
	BUhZHhx91DIISOWXry8Xb3gpmrUKs5RuqsvxSxZIZUBGqQRtOYDnlA+tf6MJuhxSsKXDIFqyROC
	+e6KQrL+Xf4ACPaBxHCdruRjHNTINR6v8lddBgosE
X-Gm-Gg: AYBFou0eya4qWzmCivDuIQ7nfOBb39XnyBEDgQJNytIwC2agwQl3ObKx7Gyu7dzjbjs
	HOtCHg2s4fKTBsiKiO4R5Att/LZ/FAN+1wg2arzLurmFqoB258RMC9wGIAmU2or7xezCGNDxV1K
	ahZwvgusUS7t1MqFpYlhlxdVMqYeI44Wrvz0p3W7XNd7YDq7lYNakESAXFNOgjPNTe2Tfue7elB
	gOMzGCzhmhrjzixt7qwSIwAwb73u1fWBTYAAMpfoRR6q4bPyzlFFuvcPsc9nXAzlYfHbYu7ZXvj
	ss5sgz3EtyxqmQe5vBoyhVeZN1p2ucWnaJzVqCfbiMG6c6JQSS/aBzcrkqapObHk4VpKC/3k1nF
	XbMI5mugo1w==
X-Received: by 2002:a17:903:1248:b0:2d5:db38:8010 with SMTP id
 d9443c01a7336-2dd89dbf2ddmr1048755ad.15.1789499940135; Tue, 15 Sep 2026
 12:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-perf-cgroup-refleak-v1-1-eac12ba28be6@google.com>
In-Reply-To: <20260914-perf-cgroup-refleak-v1-1-eac12ba28be6@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 12:18:47 -0700
X-Gm-Features: AcwNN1XanfpCtnrHGIBtSqSu9U-FJkIK93jfG98UT8RBju0HE6_E_2re-cRIeik
Message-ID: <CAP-5=fUSYh++yo1eQBVMv=2j4pRtQA_bhh9c=V98TTe_GHsyjw@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix refcount leak on perf_cgroup_ensure_storage error
To: Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 3:37=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> If perf_cgroup_ensure_storage() fails, perf_cgroup_connect() has already
> acquired a reference on the cgroup_subsys_state.
> Drop that reference before returning.
>
> This probably doesn't matter in practice - it only makes a difference if
> a kmalloc allocation fails, with allocation size depending on the cgroup
> nesting depth.
>
> Fixes: c2283c9368d4 ("perf/cgroup: Grow per perf_cpu_context heap storage=
")
> Signed-off-by: Jann Horn <jannh@google.com>

I see that on the non-error path the css becomes a cgroup via
container_of that is handed to the event and css_put is in
__free_event/perf_detach_cgroup. Making the error path also css_put
makes sense.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> I've tested manually that forcing the failure path without this patch
> causes the refcount to go up and stay up, while after applying the
> patch, the refcount drops back to its original value.
> ---
>  kernel/events/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 33210aff3ee6..557c950eae06 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1143,8 +1143,10 @@ static inline int perf_cgroup_connect(int fd, stru=
ct perf_event *event,
>                 return PTR_ERR(css);
>
>         ret =3D perf_cgroup_ensure_storage(event, css);
> -       if (ret)
> +       if (ret) {
> +               css_put(css);
>                 return ret;
> +       }
>
>         cgrp =3D container_of(css, struct perf_cgroup, css);
>         event->cgrp =3D cgrp;
>
> ---
> base-commit: 08df884136f1c1197bab2a27814404fd329d9aac
> change-id: 20260912-perf-cgroup-refleak-b9b7e5417683
>
> Best regards,
> --
> Jann Horn <jannh@google.com>
>
