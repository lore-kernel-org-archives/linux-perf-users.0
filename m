Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504830;
	b=TCPIxX2nZyqeyvs4FfdbikcIqNemS26fv4TuLZ83v87HoeBsk++nZumCVFt8r/eVN00u
	 86RYudY0ROcbziMgV0IdOMNDOWYNqr8fA0zo9VqrcqWNP1pPF7RY3Lbi/CMQ5Rw3k9nIR
	 ltA3Vwji7dMv86sDoVoPjaJqSd/2WWcelAYdZPVkw3u9P8lx1P29qnPnh8mNNtyjxVxKm
	 sj8KSXf/5rzhGZ+0Lw7euiQkGL0NTOTpgjjP4H3bnYo0h2fI0OtlEVoD5t7JDXCYO+WEa
	 mR0Pqc7Mk4dpZTypZOf/paHgNH8VjgUerbTpfuYKiQ1zxfty2qWYMuEvOkpY+3BkNIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VpM6GPeESPabKUQaWW8tFYuJ38izk0ir4GCg0/h/pgc=;
	b=00fFI7IwC9NBtCI3+sLOTxAxlDMC1eGmmo27gplvksRlT67rhsoo+SZht/a4ZTmVH35N
	 fAsLY2mqAtQzGjo+wYpnVjf9EdfvnC8jPRTrfW7lIck0f/ToADWnnMFHJnjKMyfAziSKK
	 YX5dq8qyebfwlQmorA7FTjxs4KmmN0hKbYdUdqFMhOSAspqTdYr2ahffyhvxc68wD7dIi
	 qESxMbC8wwo8pN//GLqtkNCd6z1RICyk1vmqZ/sw46hnlu+rQhdbzxzpKH3Xi+9CAA8Zb
	 JuctjXM19gslz7rvxqs0fdRvBccHQUx4gBPzfhpGbdhkJVFEdC/8NrSX5MwrxGpWUbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LKDla3by;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D5606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 672D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LKDla3by
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4649b35bso2727079f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504829; x=1793109629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VpM6GPeESPabKUQaWW8tFYuJ38izk0ir4GCg0/h/pgc=;
        b=LKDla3bytktNKx7t/S0CsVXEcGRfiT23agGshml/dBHtcUEyel5nymtuYofrCUjG3u
         kyAbkBpt5V2uSnY1eHFzCmCvWQJSP4f88Ol2YRbQHhsYnYtt4l9gAaxutoIdsgO1ftDO
         fVdCV7bjd57wLC1Idht1kI9ittocf4p9N14Ra0ktBbjaeOesfTuX6agmZLTog/0+PiVI
         OxwQAscrVg2zIpVt9aJZt/dzu29nbBtSXjaR2PlUM0qI34pzWo8mGFcW7DbXwMbmoy+t
         2QqUvG7oYnlOQjTs+yM3XXzKSvo3/R2eHGxy3hgBE9/AZmTdidn7bsx6EiA/VS1g1HIR
         988g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504829; x=1793109629;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpM6GPeESPabKUQaWW8tFYuJ38izk0ir4GCg0/h/pgc=;
        b=AdnCdP+PwzG9/F3Sg4Ez4cZw7bsmzARbzXsiQfm3AlTuQyPA4mMq1qtIGsxjZOjXs6
         UHtzAQFixYnd/eEhQ2+I5r3zS37sQxfXA4ubdDrvmGA4Mlwq44ND7hR74vrMED1q4VZG
         xkpTfWIcqqRRpM7SEV4wd18qXHmY6XZ4htD19k0Y797TinNK+XvzJfCj1w/KC5Q/ZEt+
         rWuc7K96JCbYWGU5pcGgxhhqIXYKLJwYUXY8s+1V3DA3sjGXeTNElPNhJVKVJC8YGzzE
         oIJS/ZOmVLtJ2nLel+N1Zl9j/9q4WjEX47dWAkNiMlJr8R6b2uzB9NWHygBhwue0EaFq
         soHA==
X-Forwarded-Encrypted: i=1; AKwUvBxf00MXfs1VSal1wcJxWHM4pMi9nu2SguGwaWnU6mp2iaqrkG3Au3QcyTUhtHZCR1HuysHmMS8YRZJXrDvXWlbB@vger.kernel.org
X-Gm-Message-State: AFq9FYKXmDZG0ShX1av1w5Y7pu3EgRk0VIMMmnT86eLx+Uucq8AhpU8O
	aGWs6GEMrzBjKf+8lUu7FYovTWUCbKKUGyTbX+/5/pbaRw5HdvYfsk4kO6Xletw0
X-Gm-Gg: AYBFou2u4BdjrnbZLkZI17uXKE2pGpDmUsQCdfN9eCnifzHPquaHVh1UtoTViUsbfWY
	4LBPZCL7vSyqlg/v0TjnW73kJNjUyIyaD2iOjJwU+VMif13s1DVm3Fuo1GtiDTxj7UoQJA+/Y9f
	54DANQZtANLpY0V8nWwD8sdSy3zVG4uYJa/eKK6AHO/toNFnI5a88P0NdgjuZ8WAqf7OWVN8hOw
	i3E0FJPgQ3EYSYXfHGjWfD3zeBy6eKyOKM7TqLc56bFwigBEU3jVgVPdAK//c4bRqwEO7A1ub0q
	pEquMCYsYY9fKP/MGzeA6ddATahpEB50y1vL+Twi+vUX6d6pO4eg+O1Nbh3JHv7DSNCiSqglX4N
	/gzHcZMfVmmwOU/9qgiAVrnV3/a0yb0JVVMohk4pjM4HuZUjqSrp2w6uOGLViyFIFzbzAY+VdP2
	6XyAJ4/oOGTR04frzqxFt6+vxT+EVX1Zn6ZbM5RwywJkmb3sdecpGaVXyLD97iI9pw5kyqJlVx/
	z+yi4kk8MqRil+IQawOfiQ3zy5uIKcIUa+Y/ifUAXtwrQ==
X-Received: by 2002:a5d:588d:0:b0:48e:fdd:41d9 with SMTP id ffacd0b85a97d-48e0fdd445amr17267515f8f.31.1792504828441;
        Tue, 20 Oct 2026 07:00:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8244e1sm6134450f8f.44.2026.10.20.07.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:00:27 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:00:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, Stefan Kerkmann <s.kerkmann@pengutronix.de>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Christophe Leroy <chleroy@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Eric Biggers <ebiggers@google.com>, Al Viro
 <viro@zeniv.linux.org.uk>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option
 for ARMv5
Message-ID: <20261020150025.17a0339b@pumpkin>
In-Reply-To: <20261019201257.3805356-1-irogers@google.com>
References: <20261019201257.3805356-1-irogers@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 13:12:56 -0700
Ian Rogers <irogers@google.com> wrote:

> Commit a339671db64b ("vdso: Switch get/put_unaligned() from packed struct
> to memcpy()") switched __get_unaligned_t() and __put_unaligned_t() from
> using a __packed struct to __builtin_memcpy() to avoid strict aliasing
> undefined behavior.

Looking at it the vdso only uses it in the getrandom code for copy+zero.
Even then it only actually uses when misaligned transfers are supported
and the buffer itself is u8[] - so no strict aliasing issues.
So that code could very easily do something else and then the horrid defines
in vdso/unaligned.h could probably go away.

Then the kernel could go back to using packed structs (or something else
since that itself is possibly dubious).

David

> 
> On ARMv5 with GCC, __builtin_memcpy() may not be inlined and instead emit
> a much slower out-of-line memcpy() call. Add CONFIG_VDSO_UNALIGNED_PACKED,
> enabled on ARMv5 (CPU_32v5), to use the __packed struct implementation on
> ARMv5 while keeping __builtin_memcpy() elsewhere.
> 
> Fixes: a339671db64b ("vdso: Switch get/put_unaligned() from packed struct to memcpy()")
> Reported-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
> Closes: https://lore.kernel.org/lkml/47f8c30b-e326-4ff0-a2bc-5683209a9e2d@pengutronix.de/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/vdso/unaligned.h | 16 ++++++++++++++++
>  lib/vdso/Kconfig         |  8 ++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
> index 9076483c9fbb..726fd15efc82 100644
> --- a/include/vdso/unaligned.h
> +++ b/include/vdso/unaligned.h
> @@ -4,6 +4,20 @@
>  
>  #include <linux/compiler_types.h>
>  
> +#ifdef CONFIG_VDSO_UNALIGNED_PACKED
> +
> +#define __get_unaligned_t(type, ptr) ({							\
> +	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
> +	__get_pptr->x;									\
> +})
> +
> +#define __put_unaligned_t(type, val, ptr) do {						\
> +	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
> +	__put_pptr->x = (val);								\
> +} while (0)
> +
> +#else /* !CONFIG_VDSO_UNALIGNED_PACKED */
> +
>  /**
>   * __get_unaligned_t - read an unaligned value from memory.
>   * @type:	the type to load from the pointer.
> @@ -41,4 +55,6 @@
>  			 sizeof(__put_unaligned_val));			\
>  } while (0)
>  
> +#endif /* CONFIG_VDSO_UNALIGNED_PACKED */
> +
>  #endif /* __VDSO_UNALIGNED_H */
> diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
> index 597f5f0f9681..709eb193999f 100644
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -23,3 +23,11 @@ config VDSO_GETRANDOM
>  	select VDSO_DATASTORE
>  	help
>  	  Selected by architectures that support vDSO getrandom().
> +
> +config VDSO_UNALIGNED_PACKED
> +	bool
> +	default CPU_32v5
> +	help
> +	  Use packed structs rather than memcpy() in include/vdso/unaligned.h
> +	  for unaligned memory accesses. Enabled on ARMv5 where GCC may emit
> +	  out-of-line memcpy() calls instead of inlining byte accesses.

