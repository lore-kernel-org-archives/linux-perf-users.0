Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB91C13D
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Mar 2024 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711254011; cv=none; b=VH7njAdyGAYyvFhuP+K2iIOms05bxJydTk7a9h+uKf1qAfAugdkBYF/sCGnv5jVLIho7dqY+SMT3++pGLTHGw/A3wiAZ9KE8HUhvLQEi1iP0/P3hU3ukIlE61X1naIAm9i7Qk1go5R5ISjNXm/9cO/RqsbcUeaAb+QJCH/zey2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711254011; c=relaxed/simple;
	bh=95ms0aFUD9O9975yQNDa5gcNkITjTEOulTrT0kmC1ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0df6gInFP3W0DaYXc3U3sy4LW+2P26yikobKqljTMXCANattwBHZiBKzQgn6B+ozGUg7QJ43rjQueWJrkeI0j4AoIrxjpKX+5lRu/tUudbppW/Sck8AuIAet4WyraCs4WM9Tz+KeRyQQmLrqEsDFhVSbshCl+n1oLowNIUJM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EeTEmael; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EeTEmael"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42ee0c326e8so170891cf.0
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Mar 2024 21:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711254008; x=1711858808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11ZNxGSEABtgKanbMQX/CUTIfZEWkcBe4fYAq+k7twQ=;
        b=EeTEmaelXVK6ZNM9cb7bp+7VdBNFBGhEPTo/a/0o8NujOR79zSzfgpXou5+tUEHd0L
         Dk5GcMAnC0Tt9saMuinzJRSzuvcFCIrZPxBlgiKzg7mz5Cobo489dbtWI5VZ8M+GsGCk
         nNByGQ9CYqe5cqarHZGndkuwtefUo5rxkDZZf5bA3nB/UiosxzJ7S9N+cs80IOTtjieO
         KYQ7rWcb2g4pMCBBfT1w6xnQ/ItsdMBkJvWpguniWna0M6O0r1WETvFxNHt1+NVUUrT+
         hwJolA4r5c5sSmUNeP5PShs811ujWjwdehrxspWlW8lHyUSBaNdAN/rziPxMPtEvUQh2
         oEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711254008; x=1711858808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11ZNxGSEABtgKanbMQX/CUTIfZEWkcBe4fYAq+k7twQ=;
        b=MUE7V5WXmRNqJAiiv3eRPBhlmrrUn1BA0i1TZYya9XoH7JXKkS7CfrVt6gFJWTRD9r
         CTX6ATEgsxIyqTf4pIF+FqtQmgYj0Q1X7D86z9MLebd+tfxr+t0/41L4t0dxKD9faDpd
         CANwoMCSEem81p3c4sfupVxwEvWJXr86bYLxuc6He+fVQKMMzGZOoe+6YMsVQlnLwCjU
         +SD7St4K3k0J8kVLaXUCIZcbNNXa0RCtqcerpsmIoMJTPAJyK0d/yco0VO6sMiGre2Q/
         JO2jjeRxLjp/gC19l3Mlu6gQJLOf19fd0KoAVQYPLsbAny8wpzWHhwccio6GTWnRnCQz
         O5/g==
X-Forwarded-Encrypted: i=1; AJvYcCXI2g0REaHTPs9mA96LeINoHCU8paiM0zh4QivErO6+5n+XEILLqJEBBBjTRDrY7aJWNNra9dfSUsookwp3/YabeWVLLmb7ntxltaB9DGIEtQ==
X-Gm-Message-State: AOJu0YzUkbiIi8b5lQPgOhOxrwLqvB7mVvoIu31Y/TfAxG7T2LS9cofq
	zVIgHnxvDRmMHdXjCFykU1/wr/dPxnn8AxHp6jiGchZAn3RI1M3GRkT0am0mdc6Cqxgofz5VGvf
	fOuxVkRQZUhEhZpqh91YFZsMrMzFG9m/CKjLp
X-Google-Smtp-Source: AGHT+IH0LnzQsJ51QAgtlV6rhO7iPkQPlSuXshI9DyzE+30UBUayfKD/oAf2LKrmlDVM4f2QpeJOkJN5d1YcVgBp2fI=
X-Received: by 2002:a05:622a:606:b0:431:2648:ac30 with SMTP id
 z6-20020a05622a060600b004312648ac30mr834239qta.28.1711254008147; Sat, 23 Mar
 2024 21:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209031441.943012-1-weilin.wang@intel.com> <20240209031441.943012-5-weilin.wang@intel.com>
In-Reply-To: <20240209031441.943012-5-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 23 Mar 2024 21:19:57 -0700
Message-ID: <CAP-5=fVUJayXeKwtCnSjoUrw0HMJJa00RYrMhm-stjUwxDyefQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 04/15] find_bit: add _find_last_and_bit() to
 support finding the most significant set bit
To: weilin.wang@intel.com
Cc: Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 7:14=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> This function is required for more efficient PMU counter assignment.
>
> When we use bitmap to log available PMU counters and counters that suppor=
t a
> given event, we want to find a most significant set bit so that we could
> starting assigning counters with larger index first. This is helpful
> because counters with smaller indexes usually are more generic and
> support more events.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/include/linux/find.h | 18 ++++++++++++++++++
>  tools/lib/find_bit.c       | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/tools/include/linux/find.h b/tools/include/linux/find.h
> index 38c0a542b0e2..fce336ec2b96 100644
> --- a/tools/include/linux/find.h
> +++ b/tools/include/linux/find.h
> @@ -18,6 +18,8 @@ extern unsigned long _find_first_bit(const unsigned lon=
g *addr, unsigned long si
>  extern unsigned long _find_first_and_bit(const unsigned long *addr1,
>                                          const unsigned long *addr2, unsi=
gned long size);
>  extern unsigned long _find_first_zero_bit(const unsigned long *addr, uns=
igned long size);
> +extern unsigned long _find_last_and_bit(const unsigned long *addr1,
> +                                        const unsigned long *addr2, unsi=
gned long size);
>
>  #ifndef find_next_bit
>  /**
> @@ -174,4 +176,20 @@ unsigned long find_first_zero_bit(const unsigned lon=
g *addr, unsigned long size)
>  }
>  #endif
>
> +#ifndef find_last_and_bit
> +static inline
> +unsigned long find_last_and_bit(const unsigned long *addr1,
> +                               const unsigned long *addr2,
> +                               unsigned long size)
> +{
> +       if (small_const_nbits(size)) {
> +               unsigned long val =3D *addr1 & *addr2 & GENMASK(size - 1,=
 0);
> +
> +               return val ? __fls(val) : size;
> +       }
> +
> +       return _find_last_and_bit(addr1, addr2, size);
> +}
> +#endif
> +
>  #endif /*__LINUX_FIND_H_ */
> diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
> index 6a3dc167d30e..e475a7368e36 100644
> --- a/tools/lib/find_bit.c
> +++ b/tools/lib/find_bit.c
> @@ -67,6 +67,27 @@ out:                                                  =
                       \
>         sz;                                                              =
       \
>  })
>
> +/*
> + * Common helper for find_bit() function family
> + * @FETCH: The expression that fetches and pre-processes each word of bi=
tmap(s)
> + * @MUNGE: The expression that post-processes a word containing found bi=
t (may be empty)
> + * @size: The bitmap size in bits
> + */
> +#define FIND_LAST_BIT(FETCH, MUNGE, size)                               =
       \
> +({                                                                      =
       \
> +       unsigned long idx, val, sz =3D (size);                           =
         \
> +                                                                        =
       \
> +       for (idx =3D ((size - 1) / BITS_PER_LONG); idx >=3D 0; idx--) {  =
                   \
> +               val =3D (FETCH);                                         =
         \
> +               if (val) {                                               =
       \
> +                       sz =3D min(idx * BITS_PER_LONG + __fls(MUNGE(val)=
), sz);  \
> +                       break;                                           =
       \
> +               }                                                        =
       \
> +       }                                                                =
       \
> +                                                                        =
       \
> +       sz;                                                              =
       \
> +})
> +
>  #ifndef find_first_bit
>  /*
>   * Find the first set bit in a memory region.
> @@ -121,3 +142,15 @@ unsigned long _find_next_zero_bit(const unsigned lon=
g *addr, unsigned long nbits
>         return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
>  }
>  #endif
> +
> +#ifndef find_last_and_bit
> +/*
> + * Find the last set bit in two memory regions.
> + */
> +unsigned long _find_last_and_bit(const unsigned long *addr1,
> +                                 const unsigned long *addr2,
> +                                 unsigned long size)
> +{
> +       return FIND_LAST_BIT(addr1[idx] & addr2[idx], /* nop */, size);

The "/* nop */" argument is weird but existing style.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +}
> +#endif
> \ No newline at end of file
> --
> 2.42.0
>
