Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A64D09E0
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499369; cv=pass; b=QZtgizTdVwDVIr/DbbjULBbKlNA/XiftYmlA9sUy6oBa5sqfju79oSTPXWQknPzypOwDPYeobxiKhbtdLYb676ddVW+hDXn91ckLJBcUbX2trWmScCOOrXLYLSsnWeXOPFXA3YmRFTuqtm7CCVtclnaVI2to7Lk2vjO8xy5V6Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499369; c=relaxed/simple;
	bh=jpIpcLcM/osmLoQCFZCbJu3MqhGUPApffNClPFrK1qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5EnjEIdBcg0943uBV7IqbzRjFEiScMR5xj9wHWh8LsHXzvKik1bplgxPWTAbBNGsX6LVGLmPz5uKxZ91orBB2IPJTByC9xBRQSEAqiu4jMjmO0ytwo5SeNLXAE8M6R/QgQ3soCsmNAjG8jU67+SI029hpRleMLvuEZqUP1pzYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuATZTLE; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuATZTLE"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd84862f2bso20175ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 12:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789499366; cv=none;
        d=google.com; s=arc-20260327;
        b=OOfvQJf4IY4ANmTf1/sZ9R0htqBAKQetx7S9HBGY8+BOIy24mZ90rDwzfMwMGX4BeW
         OPEyu1rEJn1PGAt3A3YWmqoGzLtf5+xaTI5EdjMKb05RH1gLeiyUucsFsGzOnQUB43BO
         XJ7n+lBg2KjOYxyj40rGPeUz9kAuet7HsOw/Ti1PggiX89TZIdfNfkfpU8GU8UbTlb1k
         P2jJI7Qk8Z//LPgcl1Zxx6ikXmS9aaWmO8OE9NxgdN3KNQNmopXXOGiWH6NCQzIcNwtJ
         gLTMFabBFMzrzdz5HfkruWZJ1leVOV2xyb7smY997dZcT/NmSCOpb/cmhoMDwB8eYEKa
         0C4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jpIpcLcM/osmLoQCFZCbJu3MqhGUPApffNClPFrK1qo=;
        fh=ussjqFn+ph2xEiKqpsgsZbIlQ320i2nAXnTpgUvR2aU=;
        b=kW5tFfREDbbc7igY7D3v//OWm27MG28Ph/VgcXKq0Y0QLJ2R0mWO5sdrzuE0aRTecT
         pavjEAEA8FNgbVR9fS5k2h3Mu3mzQ65Jo3u++lGg6shFUVLF64tukOM3iVFygEIq0XP2
         CXCSlrMpC2axf7DsqE808WxjaxKZgvh0dVPiFir+6HqscrvpK9QevCQCo2CujZMhjtwd
         g9tavjDlSmaGzeOSpewevu5bzGFGNqvbesuK3uzZk2ttvwN2S57UmJEHKI/OUbiFzFHp
         qwM27LIfruxXbNtHwgw5Wde6R8zD54dPCdmboJFGHWoSFZXdiRb0OalMXBP0iIpGEYIn
         7QqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789499366; x=1790104166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jpIpcLcM/osmLoQCFZCbJu3MqhGUPApffNClPFrK1qo=;
        b=MuATZTLEgZnlGiYbsFkCb1tJGpmdlpOZUUyymTfBA0TNFDDc2YWa+L9NflthO42h/s
         d6H94TSF/ZZzQK1fbpzyxSssQye4IvcEbgTyKCi3K3iAReJwudYvWE5IqnqI0BPiGt/t
         1xtMfBm6sQUbC2ol7vsTzrLOCgLIWrz+tdOAERVyjVKnOHyJolZ0cdr2K6DAn4lFSiu3
         axaKn3RyMw+WGqcyk/O63oH0X6QwJC0qidCB4ovjVOSRPxq/rkI1xAfgpxCm0gHDqtqx
         NdYo7rygJt+SHx3PA6giNL0XusUILetYCpXoOTmt+g6wSE+M8mYIf9smA6bmKu/b+7CU
         qwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499366; x=1790104166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jpIpcLcM/osmLoQCFZCbJu3MqhGUPApffNClPFrK1qo=;
        b=iopoYUnydJ0TutcnXGv9W/RzdWoc3Sv0mo++7k/+DYtWgaOAQ2JaAuoU02ckPdsmCX
         GXrZ89s80/pEmA4BfJOVshCdprF83+Q0gvXafCoTSeTu42gm8Sr4ZaSHm000Bq+eNHaN
         IFF78W2vr2UHRLjqCa3KMkGFk2C5ACFcOzHcz6YGdbT1heTIbz9Pq52sOfriEYlCeeW0
         wAJdvJ8VTIgDThgY5Cj7154GA91+wZGg1ZT2C11LwCREa/B18DT4Dwwej0AEkaaQFFw6
         7C6yxwTwNKvi6S+2BCkE7p9lrPOYYGGJXqVBCOawbsjOSqfxIlSoq5gABOOzW2ep0Q6J
         rpDg==
X-Forwarded-Encrypted: i=1; AKwUvByivFP4u1siAuYlmprqORNYD/7jP3jUFGI3qOLKBbs/0BREcvEoEVvM6BzkKozrYzTvIZHdNA8bCOxsgDRPIT+W@vger.kernel.org
X-Gm-Message-State: AFuF++n/UjO521lQy8R21vggGy7kT9F1XnyoUweIC8Fv8DmpeG0uOegO
	N7Y+DjMr4kY1/uSoBG7PFJK/5kbcbWlXaAaQMcRE8POK26BTv0EE8aBqMrpSVVabno9pi3VjPUJ
	hYOz/nkzdbxCWiNw6jxhklNDe5IlvEfjU7IvOT+SF
X-Gm-Gg: AYBFou2ZqWliabJcQP2RVLTpQeJlA1LwRCBV8hHXIU6pJ6d7JGNbWfgGMcOWQM5Wlt5
	IsdpqDvOWvBcbf1Lejhy8c+D6zf2FacDpsZX1ylk0Kmqnr0o8XJcWKVa5yWVLaIUXF8IWzno+5D
	JVTBmjuUbZRUPUmakzRzhaVe0nCg35+JnNy0PvrZf0xB1BgPa58z2Vw2qvMqzncGROjstk5Ojga
	EgQrZsMlcjwafHeFJrmvsOFGCl3vF+e3MT8M7eBx9/Y2oYnJ9jIXbE79HevWvXXoLzHYf1f9w9N
	pFSmAl1wl2khzpHD6Qg7owDgWZZK0MMYzypLV8iTu5Ci5JKE2aXiFFTtq0LOZNHksqh68o+Avzb
	CmHcpQSQR4A==
X-Received: by 2002:a17:903:2312:b0:2dd:280b:cdfc with SMTP id
 d9443c01a7336-2dd89dbf5b6mr911345ad.17.1789499365825; Tue, 15 Sep 2026
 12:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914124145.1257-1-cp0613@linux.alibaba.com>
 <20260914125814.C92251F000FF@smtp.kernel.org> <20260915015420.818-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260915015420.818-1-cp0613@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 12:09:13 -0700
X-Gm-Features: AcwNN1VEnCQGYjVI_5aMVzakyKX12QfH25O8aH1TDijDh6nLV8Gvbs5KkQU6zmM
Message-ID: <CAP-5=fWE7gjkpZdnHh_QAiVBKTF=1tsUE+ezDxW8SaCsaS-s5w@mail.gmail.com>
Subject: Re: [PATCH] perf riscv: Add perf_regs_load and enable the dwarf
 unwind test
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	guoren@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 6:54=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> Both items checked. Neither needs a v2 of this patch.
>
> > Does this file need to explicitly include <stdlib.h>? Since musl libc
> > enforces strict POSIX header inclusions, missing the declaration for
> > malloc could lead to a build failure regression on musl libc systems.
>
> It is not missing. "perf_regs.h" three lines above resolves to
> arch/riscv/include/perf_regs.h, which has #include <stdlib.h> and is
> also where PERF_REGS_MAX comes from, so this file cannot be built
> without it. arm64 relies on the same transitive include. Checked with
> riscv64 gcc 15.3, where an implicit declaration is a hard error:
> including only that header is enough to call malloc() and calloc().

Hi Pei,

Thanks for the patch! Please don't rely on transitive includes as a
change in the other header file will break code here. Since this code
only builds for RISC-V, we're likely to miss the problem if the other
header changes. Other than this,

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


> > Can perf_sample__user_regs() return NULL here?
>
> It can, but that is not introduced here and cannot be fixed from this
> file. arch/x86, arch/arm, arch/arm64 and arch/powerpc all dereference
> it the same way, and tests/dwarf-unwind.c:118 does
> zfree(&sample.user_regs->regs) unconditionally, so an early return here
> would still crash in the caller. A fix has to cover the whole "Test
> dwarf unwind" path, or the contract of perf_sample__user_regs() itself.
> Either is a separate series, which I can send if wanted.
>
> Best regards,
> Pei
