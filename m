Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1FCA47
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952594; cv=none; b=h1LLJoaREm/UAi0g+b75oTEjthf7buIGPN10f/jaf0JjRyHXlXMNoc37l9v5X4KYlZPoKQWEMU7D/IyTDvZzmctOKzj5LDZVQVh1mxm+6DdAU5cP0nAnKoMqaTxwN+dCrWWis9snO12/g4fXDSKatLmKlTeIlMP5WBDwFMpOvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952594; c=relaxed/simple;
	bh=l5AeG0Hxuv67K1Go/GLyYqU3kNt94rkpGVsR7OP3Qes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bg1h4UqFszUEV6XejPDQ8C46nwB/FhQiObBPoIveuSJXNIuZIwuIfTs3ub/2h6RgE/GVeNY8pIyuW6D8EwlXWuH8HWp/FxvSd+4LBHUtwMvF9xlR2n0ul7vtQMDBaN4/7kBXTV0wvDnjyZ2rsoBLcA6p4M2zRyV4tafPyEIyeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/CzanzS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/CzanzS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dee917abd5so192055ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 09:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710952592; x=1711557392; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4izGi/rNzGfjGaZHpmZ8og5U3NrqJ/cahTTnT/gINSY=;
        b=G/CzanzSfyU220C8sMvYbglJ6zB4W7WrzG2qSdY4wh2oBRnbR3j1CpiguJccRJwgze
         QS1VkA+4/8vYzzufVBZ/bcW/5bxXkZJhP3nWfasP/5Oc06/MXCaKJNB7DqdFU9FHiIyH
         EW5osJ4gl7Y7rQZbJVmjNnVfurE7xgmkwTvKkcK3UD3QOxnJJyabyVZoCSUhGiBPiBEE
         JbbZU0JARStnDeiwD+WA7Bc2BrTqFeskJmsEXi3TYGhNM093BLQd2heo8V9tmSLP2z5J
         jfukkYFzF77ANBwl8rdT38OIWrZWm7tx6h1mIgHl+mhMCTKcRHfACvl1V0PcL3l7Mubr
         Afiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952592; x=1711557392;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4izGi/rNzGfjGaZHpmZ8og5U3NrqJ/cahTTnT/gINSY=;
        b=M0FYw/MQW5zRg3qvLAM59RQB5ZhsDy8XXBrAcwFWPzQ/ppAWFrMPpVAGbhlEl5ozPU
         sPOXibCrA2vak15Fr1WLJjQZAb30WdocCpLIa7InewhAZI8bJNHhB/N+9a77AhAp1uUx
         pGw/IJqzoEjmlvMRmsVarYXtQsYzvNwWS15Rsi6r7UksO4a+lft3pcgymIqYr1ha8Kdw
         HrhLWS+xEZlq5EHvxefKhEPrroxvNSUZ8Oua715IrU9pYAXIdxfnn2iBn1shWn/r6B16
         0f9bjFXdaL6cRP+JFSw9UsloJgUCLSgVLxwpHv5pQr9hEewCuqNWFahZYHf7bFk5p28f
         XBpA==
X-Forwarded-Encrypted: i=1; AJvYcCXWjl9SwdZCgUaL5o47pnuI66FvDB+dlzCOObjLZcoe6xUk5CzZSS1rpujoD3Ywuf27+ECrrk/Fvs7rZfKt8OL+4M11zKnLgMFgWkziYd7g1w==
X-Gm-Message-State: AOJu0YysZ7xnqJ5iAiFPfXsj+Hg1ELz+PyNrUtpQ45I4d4Z8HLDagguU
	7RIwkWVb2LXr3G7g44H1ItcFC88hdopDvq6W4+PjktSELbmU0L3gi/JLwoFInehPZRME/CdnBu7
	zLMiwGCe2lxMbvxXLjFpKeWHEXv8Aj0qUPqFP
X-Google-Smtp-Source: AGHT+IF7jYpEg16J8IICPrk2uxY/KNN1OfAQNS+bv5buJgizk1nYFdnC4gxFboKp3i5ehUdUJUD65mXqfnDdWgLG8xs=
X-Received: by 2002:a17:903:2447:b0:1dd:a473:750e with SMTP id
 l7-20020a170903244700b001dda473750emr240457pls.27.1710952592275; Wed, 20 Mar
 2024 09:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320163244.1287780-1-irogers@google.com>
In-Reply-To: <20240320163244.1287780-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 09:36:19 -0700
Message-ID: <CAP-5=fUVtGgaLgVhoSa3SZdSceifFWs_v1rMnEANj3N=VdpC_A@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Pretend scandirat is missing with msan
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:32=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Memory sanitizer lacks an interceptor for scandirat, reporting all
> memory it allocates as uninitialized. Memory sanitizer has a scandir
> interceptor so use the fallback function in this case. This allows
> perf test to run under memory sanitizer.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Note, as msan needs to instrument memory allocations libraries need to
be compiled with it. I lacked the msan built libraries and so built
with:
```
$ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g
-fno-omit-frame-pointer -fsanitize=3Dmemory
-fsanitize-memory-track-origins" CC=3Dclang CXX=3Dclang++ HOSTCC=3Dclang
NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1 BUILD_BPF_SKEL=3D0 NO_LIBPFM=3D1
```
oh, I disabled libbpf here as the bpf system call also lacks msan intercept=
ors.

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 1fe8df97fe88..74e0b17050b5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -486,7 +486,10 @@ ifdef NO_DWARF
>  endif
>
>  ifeq ($(feature-scandirat), 1)
> -  CFLAGS +=3D -DHAVE_SCANDIRAT_SUPPORT
> +  # Ignore having scandirat with memory sanitizer that lacks an intercep=
tor.
> +  ifeq ($(filter s% -fsanitize=3Dmemory%,$(EXTRA_CFLAGS),),)
> +    CFLAGS +=3D -DHAVE_SCANDIRAT_SUPPORT
> +  endif
>  endif
>
>  ifeq ($(feature-sched_getcpu), 1)
> --
> 2.44.0.291.gc1ea87d7ee-goog
>
