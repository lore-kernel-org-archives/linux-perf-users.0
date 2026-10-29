Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272285;
	b=GR7lefGM0kpSU/7GceEZQs9hDFubdFqFHA9Rs8JTMkdhc6sPoEUXLKfZTDCggaMS8Y6G
	 H/D4XRi7ubScOHMBgEFcx3nAQwLvmYXeu+RIs8w1U8bFwatwpPNouDdQhROaeXSaI5zxv
	 FfUuRj6cBQHjp/opik3DNeoJkHq3sEzw8Z80qUmcejX0x9NE0ryyqMQnTGvo8TZIKpoPK
	 EvTjBRgM55Kn+BUCwYbBXEd/DHWQJAp3aeiSH/Zqof5ji+GykLXEj0+Sppiv0fUo2vX7S
	 tDiTt0uJenlx+HYQ+s9ZGr+S0C62+GtO0X67mu/2EdNUqrTzQcWCW9YOg6xahro40Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wbNbHS3fVN10sKz1Pjm8wIX3knN0UZxQlqfNrwnS6hA=;
	b=LlM1zf/RKk8I7SyM5Q4hVtTrZZ+NKbpTw+cWQmy5LuvurvYqPh/FHGt9b4LXLxCJvRCW
	 sHl8Ib9VwSj6TqV/nCowndCpIhrQY8yvTkOM6y0UJ58XPDtaegfXBhCPdwmzyFco3SImN
	 u9fF0iun/iLDzkX+uEbSBtm25nYOMQYSvuSpb6NO2MQ5ua8w24hN93oBM0wMrur2T4X9h
	 i7oKsvVv7Tg4J/Dw50bKksACWPswd7VxOp2T7jSl4L4TKy/LFIU0l73vSmIvEYPswoeVf
	 iricaIr56ufva3G/EEiXecNaeH2etT1ziLjxkF2bLSh+DfzTJMLrap6MX1K/UTOyTnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qi5TWaMG;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECC606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 11:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45ECC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qi5TWaMG
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1581966f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272283; x=1793877083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wbNbHS3fVN10sKz1Pjm8wIX3knN0UZxQlqfNrwnS6hA=;
        b=qi5TWaMGVY6R0ZkZLVBDdIn/wXn+x4MPL4FXB1Zi9r/mb+k42NX+v/MyUXyV2AL+LL
         vTdhz0knacaXk2OhUzhOyuwDrbdpSA1MNSewfI9cdOYaiKDv3jJh6DStHjcvNDKN+yWu
         H9EF3doHqgFO7dKVUsXblVVTtNSAhcyXSTgartY2OrPIAFXgQFCdAt2uJ3D4ljEDu9Xf
         1lzcxTfW5x3MR4tqBG5fo2ocPpdt57UHgcXqsWTfiaFjZ86HL7Nu8qcwWgRcrOQrjT+j
         vwMBsbQ1Pn6bUjU/9LYnVmmWPlLdG5DF3NkpzjW7Bw62+HxpVkNfEBs0d4yPYZEHgGS4
         vkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272283; x=1793877083;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbNbHS3fVN10sKz1Pjm8wIX3knN0UZxQlqfNrwnS6hA=;
        b=g/dX6sjOmISBtwaDwV6fW52cjNe79tB+7XtWgIlF1uFnMLlP0/aY7CuFVsPka3slFC
         wxFmlQp494orZ82RVtyzzpU4Oi3V4gV5bFlUdD7/o4O/y1nzzPDwgOQpvmbSBNLZmp+5
         HSqyspev2d8A6DzUpDyQmQaWzHafQJDTieNhUDRyfYJRXxNbpoKfCR7BPGo2D+P3aOW/
         f4VFRncSttB9VbuLomz5UaHWl18vj4wdv+3mItpvlB28Ut/WoEOK0UrZOdeBviOeIsf5
         MzQDCGw4qUKufqVj6DCPgt7TJSPlSrjTiuN7at8gQTrgomdI+RJPPGEBLYoJL6dUbgT5
         yCgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcoSn+if0y/MtnLEGQEe/Q0oOr53I7FTNBQcTO9tNHdz77sjxKUnI0ZavhCsHZFb4sdTCH3wu9od5zdkMOsQQb@vger.kernel.org
X-Gm-Message-State: AFq9FYK3qVbhSP0gv00gvyRG8TvD0teukAzFEdojK5ScZUl1Dkm9OYlm
	zDwLyBxs1HAN2nu0f123fpl5yWZbS6St3swFDG5k71sbgo0gr3Ma4pgY
X-Gm-Gg: AYBFou2OHHt/NWfu64f6lc1jnS2TGSTUAzbDC2cmmw8IDnU9YW7F4Qm9UuiKBssaY8h
	c4OhfehHoFtIpEdl8gkzH+kyNH1y99DxsZ2Ssejf4OimYPRkpg3T+iRdDkEQI+lQ6MsR6vXU8Ev
	WpYQtkKTrbJvyq6g968Q54gx4W+LZmSlvqfOWVCuMWMJs3a13FC/EIfH0cNyo8nURDax9T7ga5j
	1kA2M+EQu5JgDW45XQ7BBIvkLQfVlHYaDgN03VwaIfCS2Ygh/SAOiE3e2qgPlfPQRwUdXN7abki
	8LiFBi2+1V8o9nmMEP9nH8VcLCZbc7PPgrCByBTLRDq22x8vt0+JHtRlgnxGMoVMi2Nfvg1Yfvu
	GM8Dt2lkmUpjdzMdTPZIlWEuh53NUYDN6CBezg9mDW40ESJwisbT+Z0kjkIjb0OgokxH/J+KTaI
	GLX+LHsvKhj7hqbrv4BxsXSKyUPTUrPe1coAE0b6WKF46HGUeTXwAqdnLD+/BQG+ui9kiZFKQV0
	x6HGPiLjtnVX8OrD6fSMuJL1iUzygWgYuZumfMCrTQ5VrBU5Ul5dXhLHXhJCVeWfpDClkuzB/OX
	BPoNc2JvBcUQSrFUeGfHAfVG6Otuh+iPAduXnz0kwiBjYnW4Iy2du8hWtj9tzFrtADLc3csSLGr
	Po8bY1ctVzZo=
X-Received: by 2002:a05:6000:420b:b0:48e:3cec:b852 with SMTP id ffacd0b85a97d-48e5d2f997dmr12994142f8f.40.1793272283591;
        Thu, 29 Oct 2026 04:11:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm35069456f8f.18.2026.10.29.04.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:11:23 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:11:22 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Julian Vetter <julian@outer-limits.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] include/linux/unaligned.h: remove deprecated
 __get_unaligned_cpuX() helpers
Message-ID: <20261029111122.25d6fc3c@pumpkin>
In-Reply-To: <20261029091736.28742-2-julian@outer-limits.org>
References: <20261029091736.28742-1-julian@outer-limits.org>
	<20261029091736.28742-2-julian@outer-limits.org>
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

On Thu, 29 Oct 2026 10:17:35 +0100
Julian Vetter <julian@outer-limits.org> wrote:

> The __get_unaligned_cpu16/32/64() and __put_unaligned_cpu16/32/64()
> helpers are deprecated and all users have been converted to the more
> generic get_unaligned() and put_unaligned().

Ugg...

get_unaligned() relies on you having a pointer that is misaligned for its
type.
IIUC that is UB and the compiler can (at least sometimes) remember the
alignment use memory accesses that fault.

In reality it is get_unaligned() that should be deprecated, leaving only
the 16/32/64 le/be/cpu functions that operate on a 'u8 *' parameter for
accessing generic buffers.
Every thing else should be using packed structures.

David

> So, remove
> linux/unaligned/packed_struct.h, and drop its inclusion from
> linux/unaligned.h.
> 
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
>  include/linux/unaligned.h               |  1 -
>  include/linux/unaligned/packed_struct.h | 46 -------------------------
>  2 files changed, 47 deletions(-)
>  delete mode 100644 include/linux/unaligned/packed_struct.h
> 
> diff --git a/include/linux/unaligned.h b/include/linux/unaligned.h
> index 4a9651017e3c..18c4b0c00e2a 100644
> --- a/include/linux/unaligned.h
> +++ b/include/linux/unaligned.h
> @@ -6,7 +6,6 @@
>   * This is the most generic implementation of unaligned accesses
>   * and should work almost anywhere.
>   */
> -#include <linux/unaligned/packed_struct.h>
>  #include <asm/byteorder.h>
>  #include <vdso/unaligned.h>
>  
> diff --git a/include/linux/unaligned/packed_struct.h b/include/linux/unaligned/packed_struct.h
> deleted file mode 100644
> index f4c8eaf4d012..000000000000
> --- a/include/linux/unaligned/packed_struct.h
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -#ifndef _LINUX_UNALIGNED_PACKED_STRUCT_H
> -#define _LINUX_UNALIGNED_PACKED_STRUCT_H
> -
> -#include <linux/types.h>
> -
> -struct __una_u16 { u16 x; } __packed;
> -struct __una_u32 { u32 x; } __packed;
> -struct __una_u64 { u64 x; } __packed;
> -
> -static inline u16 __get_unaligned_cpu16(const void *p)
> -{
> -	const struct __una_u16 *ptr = (const struct __una_u16 *)p;
> -	return ptr->x;
> -}
> -
> -static inline u32 __get_unaligned_cpu32(const void *p)
> -{
> -	const struct __una_u32 *ptr = (const struct __una_u32 *)p;
> -	return ptr->x;
> -}
> -
> -static inline u64 __get_unaligned_cpu64(const void *p)
> -{
> -	const struct __una_u64 *ptr = (const struct __una_u64 *)p;
> -	return ptr->x;
> -}
> -
> -static inline void __put_unaligned_cpu16(u16 val, void *p)
> -{
> -	struct __una_u16 *ptr = (struct __una_u16 *)p;
> -	ptr->x = val;
> -}
> -
> -static inline void __put_unaligned_cpu32(u32 val, void *p)
> -{
> -	struct __una_u32 *ptr = (struct __una_u32 *)p;
> -	ptr->x = val;
> -}
> -
> -static inline void __put_unaligned_cpu64(u64 val, void *p)
> -{
> -	struct __una_u64 *ptr = (struct __una_u64 *)p;
> -	ptr->x = val;
> -}
> -
> -#endif /* _LINUX_UNALIGNED_PACKED_STRUCT_H */

