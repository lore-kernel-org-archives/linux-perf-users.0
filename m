Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6C3D71
	for <linux-perf-users@vger.kernel.org>; Sun, 21 Jul 2024 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721540916; cv=none; b=IDCi1/eCGMhW8YmPkCZjwifWZcVH8BGikM4rsOqHDDJEET3gIpuML+6KnYos4UhNHaUxYqxwfvkqW4VlyuSSVndWFfGKsL5Kl9Z79XvT8veyRITWm6kcfAQ5vVwqmqAIXKqwoOHAOQaGRji1VXmQwgdcc/svKvk9y6EaaVXspt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721540916; c=relaxed/simple;
	bh=wFdalM1IV+V68ePkH5l6xm7jvBSylfup4GHRCi1eW9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJr6FG5DI1OET8dFdrgXfEbL5ay3183p4KIpY8r/GcDEJrCsMKV5bwFq64pTTpnde6qJedUO1M/lFNFlGQfQxJqSeFMNjlzPPC9fxnbePA9ws+R6GjC0UjaLgMGbMpVkFHQaYa/fAjq+3GeOnSQ8PhVyFePabTNEw55CqtQ/hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJdgjeQI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJdgjeQI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc4aff530dso457625ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 20 Jul 2024 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721540915; x=1722145715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySJd/cG6sK7OqUfBjvLXtPhb91jMqVNe4qRHLmppl3Q=;
        b=TJdgjeQInae6T7UAcGXNISrfLcEPioUKbpo+Q48teDCT9Of51Olja26leAdGrhDOMf
         eqB7StsHn3Wjae7SAfhbbtiTKcfusnwYGvU0KAYGL2YvdoADfzkMKqgezMObHFVcp8R3
         YtDGwlojyANYciJRG39YmcRY45JQR29C4Fbo4OfPJ5iMjCTw/sKp0BVAmT+W7oV7N4ce
         9Hm6mOA/fPl3ZEgY68iP8iQ2DK0qaTTRyygj1LXSpNRN5Xd68iPonXHfpD4ijYIJJi2K
         tCac0ZB8lGnZK/NkOp4WUipGHbWp07WbHW7zb6SOWQoz5OxZFzENkOCpylDIEUQhhMy3
         Q6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721540915; x=1722145715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySJd/cG6sK7OqUfBjvLXtPhb91jMqVNe4qRHLmppl3Q=;
        b=Q9BxxingENWhCtQvR0KpU5xvkPlPlza3LCAwmvDgdPyRIT88poFgD2sveXQ+6hD4R/
         apJbgflmQ+Lbeolh8GuQbNHlrWocAX5kZJURMFfB7PYZbVPk/69A4BD7HoVYw33rAisH
         KDr4aAQDR0+PA+/4Y8AvAVG32WxK47M9uP+ZhwOq+RIBhC1H6xR7RVLt4T273ICPTAeG
         UzDWfBtc4rkbVNJS2j8m80X3gk3mFUphS9C6RJOKptBP/SpMWkjisBIB9B2NRg5dqMhK
         pWhvSNIIZcMUk8Y9uxkADPCU41CX3nY/jOKb5UhzOebiuv5RvHAM0tCEuJBXWew8vAY6
         6GdQ==
X-Gm-Message-State: AOJu0YyIkZLtV4aqHcdCvu1fZWJHZsbu3jHlCodKIB3gHwRnxaBp1Stb
	W1WL+69F7Vu2FJnO6RspQ7BF9nB/dJngmJ6Q+ExPRkUEbiBy/Ipag6W1+xw4strlcWHTuU28J8Q
	2JiFZH5GL+M53rL6LrM2GvEqiY3nomT3i1jbPyueNW9mPBYMVtEbE
X-Google-Smtp-Source: AGHT+IGNtuEbJ/Qh87DVHX7+xA9C/9m9iAmTyUcWDjvKFcLn+fuyIBeSoS1W49RZ/LAMvDRKtoKrgGk+ueopEO2Fk6U=
X-Received: by 2002:a17:902:b70e:b0:1fb:2924:5c7e with SMTP id
 d9443c01a7336-1fd7ff4647fmr1383885ad.11.1721540914235; Sat, 20 Jul 2024
 22:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721031944.62913-1-cachen@purestorage.com>
In-Reply-To: <20240721031944.62913-1-cachen@purestorage.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 20 Jul 2024 22:48:22 -0700
Message-ID: <CAP-5=fUjbsv93DKDxaNXzfe3b9H_0MQyjauNxsxM1XTN7T8QAw@mail.gmail.com>
Subject: Re: [PATCHv3] perf tool: fix dereferencing NULL al->maps
To: Casey Chen <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 8:20=E2=80=AFPM Casey Chen <cachen@purestorage.com>=
 wrote:
>
> With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> thread__find_map() could return with al->maps being NULL.
>
> The path below could add a callchain_cursor_node with NULL ms.maps.
>
> add_callchain_ip()
>   thread__find_symbol(.., &al)
>     thread__find_map(.., &al)   // al->maps becomes NULL
>   ms.maps =3D maps__get(al.maps)
>   callchain_cursor_append(..., &ms, ...)
>     node->ms.maps =3D maps__get(ms->maps)
>
> Then the path below would dereference NULL maps and get segfault.
>
> fill_callchain_info()
>   maps__machine(node->ms.maps);
>
> Fix it by checking if maps is NULL in maps__machine().

The intent with the accessors is that maps is like a "this" pointer.
In C++ a this pointer of NULL would be undefined behavior. As such I'd
prefer if we could add the NULL test in the caller.

Thanks,
Ian

> ---
>  tools/perf/util/maps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 432399cbe5dd..d243cb794a99 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -169,7 +169,7 @@ static void maps__set_maps_by_name_sorted(struct maps=
 *maps, bool value)
>
>  struct machine *maps__machine(const struct maps *maps)
>  {
> -       return RC_CHK_ACCESS(maps)->machine;
> +       return maps ? RC_CHK_ACCESS(maps)->machine : NULL;
>  }
>
>  unsigned int maps__nr_maps(const struct maps *maps)
> --
> 2.45.2
>
>
