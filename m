Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACFC2E175F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708841; cv=none; b=VjZnnwEPB5W971oZJ7riEGUJYeLj1xpPq0cM4pBMI2qEjdd3okRVeABtEKRJNwn7wto1PHzcMDssOMg32y0bQvSYri60oQ00KfhAWs8NVvooFfrLv58Wp1t1/dIfLkWuXPG/olgjhUWxZTmnTxtokFqnLCBy5KLouYyf6kYx5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708841; c=relaxed/simple;
	bh=c6TDeJ5pznbi+OKEzKeTr8gPj+OR9iMkZKJkYHsTiKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNb5kM1rkf7jZ2Re1E99sySSqmSBBWEOJaKFvr10ix2kHY5BLuUA6ea8K4Uy/I4pIF21V2YMf3ewadQU5Dy2JfUbMjEudJdEigqTFLsDYelxLg80cQYaK2I/WAYsfv7wsxe0No/7Jj2YwUA4XlTnkAeZOqgia1vvVSNMRO5WjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1eRPBxg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1eRPBxg"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297e13bf404so44795ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 12:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764708839; x=1765313639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFJ3llaqLOdXTjUGe238qsVHaVXjKpkzkLy6+k9Y0lU=;
        b=U1eRPBxg+wCNxvWsFPzRNFZ6uBVqQeptivlScmCQbe/y5jNKBjRbxjxtsNVtzvhbZb
         KJQtD6FpzadVXQKIjcBQ8WV7DMES39AZl8o1XsCPOI0YMUHCVXNa9oJJoQjt6obqShHc
         sPBmDBy68n2fbAKD20/qzXJar6BOJWcNItNrUcJ/uHt/zi3qAnZAxRXHsOjzudg6OBNW
         IyUUkmWgR66och5h1te+b28Aiwz6apEwnh8fG+AqjWDclOjhbe//tNqu8EZ2YCidVnaZ
         /2w3C9xiS+wAWTEQqfvWLMY6oOf5vTvXMxmxkJKB/d1l2m77Ha7wQ9FvajAKBm/rjBkd
         FudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764708839; x=1765313639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MFJ3llaqLOdXTjUGe238qsVHaVXjKpkzkLy6+k9Y0lU=;
        b=nfGNzA51QUK8YSR5HbpTa4c0A0TWi0MM70E/2avySIJb+t3BCHqtd5dK582Z5+d03m
         MFI4G2tP4vb/UQ1DeLxTXXaw/WlpmH5J8sxsQ+cacKoYD7sx4bXVvVwgsW100Li+jGaO
         f3i1AVveP9QJUzZjniLMcuI6AbPTqRdBDpvfkM7JT1NEJ6wxsJeDcvF3z38PMR3YqwlA
         MkVKoieotU2SZPjgQBhTl1JrVWgoAa63S3B90cpo5pzp9OiP0WpgwS/aZpTlQLWi0jv1
         D7lBIfqYIjfH6dPW//GT1+cQ7XdVPUeesjqAdb+5aFQnKTcfq+fKNkzPBrCQWgPxykB+
         +eyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDP7YkUcCV3SRfn9Pexkof15yqnVSgPJvnrqZkrkE+OChs6n/TSiR6cr5WSDOJbwZhZb94Fquq9DnH5a2ln1R0@vger.kernel.org
X-Gm-Message-State: AOJu0YypysWkFvepD58LHdzChGfTSUg4ZS5qsR3VxDvo9T8p+Glc0t7j
	U2IAfDsXLIY/BQVKlKEo2YiEKXglb9rG46fRvQlScVcXygUOxbZGQ2Ie9dXP5c8BrgYX6+Zlr1f
	Y4uwREmMQLxdw0s0nQtkWpXJdobP/+VmSKCE3M95G
X-Gm-Gg: ASbGncvNSPwWOvj+5lNA31joscA7dVaY+ng3Cu4WWekAG/VPJjoGEoQWM0YNclL8uzQ
	pk99huiqUY2xUsqehMBhV4Cp9OfxGqfgKRffEcudvE69b0TZN6m5Fau512jKj3DUqAo5/Xv+w8A
	1PUG0FXhFD9UNztKJxd5GT5R0pwFrFH9/G2NLCaj2wzRzlE+nEbRGj4Ygq+1v7KPNo9vb25kvPV
	fUpDfHXM2ahoC7Ua7U3vapVzqrZjJmTlxYPRlAj7s6WAnJFDWr3wnajX51fK87NL68QOIpqfCsO
	FdoEmBLW4ZFzRVHKx5P67fSBqzIaUqDv4VE=
X-Google-Smtp-Source: AGHT+IH5zw/sRQ9rkrk6wonqa0JYjQmQkz97JAFlrciiFNZv6uX9kpNac70WEkzw8pOMMNkHK6jT66pqgKCPz5AxLAo=
X-Received: by 2002:a17:902:f549:b0:298:144f:b759 with SMTP id
 d9443c01a7336-29d67f34e7dmr835ad.9.1764708839198; Tue, 02 Dec 2025 12:53:59
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202081645.931527-1-namhyung@kernel.org> <20251202081645.931527-5-namhyung@kernel.org>
In-Reply-To: <20251202081645.931527-5-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 12:53:48 -0800
X-Gm-Features: AWmQ_bkUu7NtWXwTUE6kXdpyqnTJej7n2-m0Q_tfeOBat9BD5aO6HJeJ2cD1o4E
Message-ID: <CAP-5=fXWwQjdAQHNxVoz1=AF83g75Yd=L32owxCfyiXKL+mVeA@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf tools: Use machine->root_dir to find /proc/kallsyms
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 12:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> This is for test functions to find the kallsyms correctly.  It can find
> the machine from the kernel maps and use its root_dir.  This is helpful
> to setup fake /proc directory for testing.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/symbol.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index b533fbf17a8b19a3..e90ecfd286043aa4 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2002,6 +2002,7 @@ static char *dso__find_kallsyms(struct dso *dso, st=
ruct map *map)
>         char sbuild_id[SBUILD_ID_SIZE];
>         bool is_host =3D false;
>         char path[PATH_MAX];
> +       struct kmap *kmap =3D map__kmap(map);

Reviewed-by: Ian Rogers <irogers@google.com>

nit: perhaps just use map__kmaps here to avoid testing two values below.

Thanks,
Ian

>
>         if (!dso__has_build_id(dso)) {
>                 /*
> @@ -2038,8 +2039,13 @@ static char *dso__find_kallsyms(struct dso *dso, s=
truct map *map)
>                 return strdup(path);
>
>         /* Use current /proc/kallsyms if possible */
> -       if (is_host) {
>  proc_kallsyms:
> +       if (kmap && kmap->kmaps) {
> +               struct machine *machine =3D maps__machine(kmap->kmaps);
> +
> +               scnprintf(path, sizeof(path), "%s/proc/kallsyms", machine=
->root_dir);
> +               return strdup(path);
> +       } else if (is_host) {
>                 return strdup("/proc/kallsyms");
>         }
>
> --
> 2.52.0.158.g65b55ccf14-goog
>
