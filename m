Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793766230;
	b=ZhqFavN3mFj3FsdyUf5CY3qhNJVQHsD5TpUUa51XhpLd14hs/t/FmLSuJkXtBE4HE4QF
	 NXxybAEh16pocsDR3xi8TKdI/S042dhplg2Y+nlLg3sTtDUuLYHFAeh3vpTcpxm2z+y4+
	 Ch/vpdhrSKW9Nqs9kkxFZQC3hrqPYc3FovIXEXKJVwqAZhJ1FuHEXD3Zwz0jR8oWRuE18
	 ZqnLtqs9o/UIAh4+zZakQ08I78U24ACL10wKZbWBYUC/YIR0LR2RJUXmHGHm0hk3gjREj
	 n1RB6rdMZEyVAQKoZdsEtdjfFwP+ob5Y6lgABy8x6uE0Uw2L7t5svB9rQhjXaKJFBZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=YRNZziqNeCRhg2/OKwe5SR/k0fV6elgIBlSt+p0bAm0=;
	b=cv6OUdxLjGHVis1kLuZfGwY6SlHjWNO7oQjtIBdgmaYkW3ipiWl895QpqyPbQhstTBvW
	 yR0iDmRXkZM+4YZXWTMF9fZkPoHM4fs356r8ow5+w9d+L0xzHl5ESml3S5FmcRi7/JE5Y
	 85AQibxOtj0qcs8DPyLd5GCZSbXTpffxsvkQ1bs/MUm+K/3PrwSo1oKzmPdhUq8C9auYa
	 jbpcaENXbRPqCfRLUK97PNU6PhE3CqHacYVOS5TO+UjCDHxz4U0SLW1wk6+GWndKopurD
	 u0G3j3dEMr1o8i8GZKySWLX7A93GuhgvkhsWvsxsl/98W7jCWmz5jOG2KgyTAgr6MVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dUuelx42;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98454606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98454606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dUuelx42
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-535f598d126so104401cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 20:23:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793766228; cv=none;
        d=google.com; s=arc-20260327;
        b=LfhQYjqw2szRI19Mbs2R862Zib2vyrLm713TSGeCtrUVzNjah75JCQ2lWVT6q11nvn
         eIMjPr/rRgAnPzxpdqb0yHvfRAiQjrFKbwufC3O5ckiy+4fXn8udIoaYAaGVW1IfVv8G
         rXmE95KdBZ0fSvTpYKc0jTPECEa8/VNtjvXW65UQla2KFHAU3MA58GSBwXB7hP7b6dBy
         UOyA+X6xbpgLqlScuc6CRWElHUMdI2w3EAKRdZgC6kQ65o4HRpS5lu0GRBbHE6TwfpE2
         7j1GBdBIycRDgf1gBIl6Pbv3IOmY7JNcJ5nOGvQpv+tAovGxLr7tpzz0jLxbrh80W6yU
         sT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YRNZziqNeCRhg2/OKwe5SR/k0fV6elgIBlSt+p0bAm0=;
        fh=SQZn5j/Hr+r+Fg4svM9TTvoxhiJaC0sVknNBrgK1Q/c=;
        b=R3x6r8wmYCs6Z4oLzDna3sPSIlzC8uZPKyHhesRIxydouXGksuKAdkSk1wexOP58Kj
         oFL1rMVoajeOVjI+PqnGErNUE0fC9TVxxEpYGRclPHslXySLuKQuN3T/lHR4eN+BJTau
         HMGpd6m4/BODP1dT0J1Qsd2/5em+hUuwY2P4j/HkAd61PiuzQwM+OGVuf0pNM8qBs5ET
         ysZoQuswRGG3xTMZITKdCFKEtr/rIQU/iJorWLa/OffTK7lHqbmNI7D7kRL3TDsHFUZ7
         i6iQ4KFOE007v4c/IIIDZFAXe2NMmYEIauVVS5j0sIwhd1irAtul+S7fF7YTFv70TnbQ
         oOzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766228; x=1794371028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRNZziqNeCRhg2/OKwe5SR/k0fV6elgIBlSt+p0bAm0=;
        b=dUuelx42O6Af/+XgxjpzJgYR2UUIzxiLhL+tejRdgJeOC3oIeJg+R0zJG1J+dqAjQg
         uIgdx+RSJrcSBTiRpKo2rTXOwI8kBVS0v3RN88qELcY4Z/lOuKf5bgx91JaTFb2jnWGj
         yByX0shW8Qt96gbRQuN+3qe3Ec7cD4Ll5nf3FpTgHzvlqtCqn6f7LddPBJpNA2a7tn6G
         tkS+yGL8DzrRYHQ9WQye/CWDhLh8nuQiq2P8MVhPko60Ul/6HNF1UBR6Lp8d8D4bZfWL
         ZRDD8ju24p0gI9VipwscB5kF6RPOf0ye4C/DThTtGaNvpzmPfjOCzcdHJe+soA3ctoqp
         X5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766228; x=1794371028;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRNZziqNeCRhg2/OKwe5SR/k0fV6elgIBlSt+p0bAm0=;
        b=fDVUv4lvtUJds38JgaWRrSRAdE40c9ljl0Uc7xczOEWTRWhutdYj2l8Aw8G8j3GlIw
         IIQ/z1M1GQD+q6GCtCZ+X55yY1HUXIxBZyttuwDBRU8N5SXzvqnaGzFbuaMmMmpFXOpv
         mEEBEJ8OwzO2ybeRtgkovTOaTscIrPH+dwN3Jo7bFwKl2vH+9lioDoJJHYWTWs2AzywJ
         k5VTUehWchS+mNQA9iH1YgwAQ/0cZrH3iN6/NhRDdWIHEbtMnX56Gb7Sj7zNF6Km/4K8
         RoEHHzCbxwzVF/k23H5hF+IVKnp5JoxzygIYcaXmoyWUkeybozhcQfQ63dfRbb3MPRL9
         6Ccw==
X-Forwarded-Encrypted: i=1; AKwUvBwvM+heS7KMdEv6GTbg1JjpkMu66jJkKmr0QckSNBcb0VVKqGVyrGfzn5CrLtT+3zNEW9MyA39hi9wBoPCEa87F@vger.kernel.org
X-Gm-Message-State: APuU4Z8gekjFfYMMaf3JVKX0m/obiPrBgdpsduIxTMboGS9fUbKW8c9d
	T4X+QbumSe5iPUNInAN4fItHkX0ikFzS55JQp6YqnXYWKG0jO1h+PkOVVKF0DSdStwWELSUkQUH
	GxY03R0MR0fKCX6tWhjr1VFegrEXJxq87tX3MBEhz
X-Gm-Gg: AYBFou1lgZyOD8BCiCpJfMMaWoj8vt6qEMnKXpF3u8mfZrf7qRggfRzSrnIUBTOVnyv
	+eF3VnLLvhZDa8WL9E8R+uAPHm1i8ZM0+831+NZSUl4N6wwWmY2zostzNIj9SMMwLdqEd/wSJYd
	nRlK7FjYrx2D+ecnv6tK+idtxwj4YdqOHxnUrKuvMW/W8e/FtnQIkevm8OonkJWmSxYxeEQBlsP
	eat1wFGMpgUhtSbe/JnV7e6n/y/qRrJT/KNbja8Z37dxgDw7sQ+O9afeUYADjcKMozYpudGwrBv
	J83VtBhcaopCRajR1GG/fJ6bq5a86jSERdSPSoOgn3J71swWjFRb7h3/0L2gZKXIF7fEGJ3xGXo
	LXDA7sd54dDJW+Hm3nW0OxbDhH+cAYG6BH2Fwmw==
X-Received: by 2002:a05:622a:1b20:b0:545:7949:80a5 with SMTP id
 d75a77b69052e-54b829d9c94mr3580391cf.12.1793766223068; Tue, 03 Nov 2026
 20:23:43 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025215508.1237480-1-irogers@google.com>
In-Reply-To: <20261025215508.1237480-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Nov 2026 20:23:28 -0800
X-Gm-Features: AclHuK-09ccaNUB_xQI1MlbkOynuoqVxYzBV14tH6-b6vEZf1TaXgfzq7UrUzCk
Message-ID: <CAP-5=fVsz3rX=T7_DAmdgDEK=LWGfSLr_7ZHJ8Z4-hehT035xQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf/core: Include attr.defer_output in is_sb_event()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 2:55=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Events configured with attr.defer_output =3D 1 receive deferred callchain
> sideband records (PERF_RECORD_CALLCHAIN_DEFERRED) via perf_iterate_sb().
> Include attr->defer_output in is_sb_event() so that such events are
> attached to the sideband event list even when no other sideband flags
> (such as mmap or comm) are enabled on the event.
>
> Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. +Steve and Masami

Thanks,
Ian

> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c4217c996f5a..b43883a42566 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5347,7 +5347,7 @@ static bool is_sb_event(struct perf_event *event)
>             attr->comm || attr->comm_exec ||
>             attr->task || attr->ksymbol ||
>             attr->context_switch || attr->text_poke ||
> -           attr->bpf_event)
> +           attr->bpf_event || attr->defer_output)
>                 return true;
>
>         return false;
> --
> 2.56.0.307.g5fe7bd680c-goog
>
