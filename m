Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88737B03F
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897789; cv=pass; b=m8aVDf3w74+tsvqnpHRQA+lqKhZLEbJCYRAAAAzJ64YNGbDB3oAN03ir2dMukyrqFg6ebBUpswIvhlV7MN2UOF5AQ/8V1kTcjqfzdqZOYKCoelEe81egOom0x8d72TUYY9IWt4HNm82dQZORrsG1kXAwsGihFW+SnHY7A/arQD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897789; c=relaxed/simple;
	bh=G1iK43tAGPY/WNEHC2F7eKPkjmLkwzRrU6dbl+k3z2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoGxc87+r7XnZDJoImf2I31aH51lM07eDobvPzGh3H4ouQd8ql8/5PVyWzGKmG+6ZtNt8Zutqdsab9P+Ta6q0IHswS2kvIkX5WNNNKcOQEj0r9cyM2kP25JIBiF++xsGkoJePZSfH74adqjGoWZrXFVPKL0bCKZf8GH5pn4tUiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BDZZSj0Q; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDZZSj0Q"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c15a5b265so143051cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Aug 2026 19:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785897787; cv=none;
        d=google.com; s=arc-20260327;
        b=InJuAn1xjqzyAfuTfStqMZ7P4FrTRRBZW5BL26f9WFgx10CEhrQpHKPFwoCmHTVqp+
         wLuxVHtw/8gLpn/KIRJNyHdMum9sQ03Xi9ljgsG35ldfyDevPzQs+eDiMGuHyRh8GTLV
         so4hk7MQO96vWPcfS0N9Y7Cz2bzZ8flRpf6M2u7GNTLMBOYJXAhVAjo8xMvBG/KdlM4t
         kA0XFS7vRmrK5IFnfs1zHNiGs1kq0yFcNUhlsim6T27+dZz1bJoprMmfNmd42LkM78GS
         Mn8Ka20Hf74UFMHVCJITaZ0VItKXPQJy/KBdoi4j5b1JI/zO08XkE2y/58D8IQN3f4mB
         Ku4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eGnLHHP8GMfbyVaDnVnu3YRy6V2G9G9BKKtv/BFIEOc=;
        fh=RzJstmZq3X9XB2KnmrNaVWygwHBhcWlMEvfzxGYRfT4=;
        b=gplm1inVC3QigAFaYw8O9BP77x6SA2rqOg+BD20ujoRJlyeUr1IIyMVhXv1N2Fly/1
         XRGdLn8pjZ1u7D2r6goj2ePGM9yZINzH3OGphIeZmDkZ5jl+S0sea0as8kbWvy6b3EbU
         GoxaFioa5GW4UuxGMqfSGB4SrTSStcDiyHkTrzRVr7QX7fJgmwGdlw1ETOzmXc8CfVaq
         tE2PQc+pGY/BwYVBP8VXOH3rmuXAsly6l3KC7QUYd1DDRlWlTpoGvVjeieO15V8Ky5p3
         ZK1r5e6DX7ufL23Tu1tZguxKDAR8RZjBz8e+1EYN+fG8qFuWl+RLKiwts4ZTZAnillE6
         g2lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785897787; x=1786502587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eGnLHHP8GMfbyVaDnVnu3YRy6V2G9G9BKKtv/BFIEOc=;
        b=BDZZSj0QvW+vWJVij2Fm94irwGdKqtQJOgIK5rctLE1NVjcwsFnhWwDPs0ccEyi+dh
         m//YSVg20CEnTRPfGL+naWFizPwJ1JUBc3pGQXtB3FYdO8X01jiAjuE8BD5lKqT4SI6I
         XzgxNjlvVryTcstNtwCiiCU1uB+55AQNFk3U0h5/s2Pwae/Km6bnHeN7DKIjKHYFee6P
         BfZZiJaMvZ/65eYUfdmlgxvgck/FgscDkpfxQ9vmoLgJ9UB39LpZD0A4p1pVn6JW9FNG
         FsYLHpNgf/vQoQhYbSLrV9pEZrHB+qjBny5cTY0SAKVXyhonmZJd4vjrQmeLL0wyTeHU
         9tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785897787; x=1786502587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGnLHHP8GMfbyVaDnVnu3YRy6V2G9G9BKKtv/BFIEOc=;
        b=KoeBoHxsvyiCtwBSItV0lehvmavf/NwILhTfPc5pnmMBWipyO60IO/dhQLHgRoxopz
         +CKKtsszUfrUxd9rGPfvrWzygQoNqfEcGQV7WkIuCDPY80sm24O6OS/iBDpbKobaFEKt
         xT1nRTUxzKHiHUIw6jcvR21lqSfJBLAlDL8kkUnUzXYxjpxrgUjEYthAGgETHO75Lfzk
         5A9MoC2xfAHOa/0AgP8/UzkSvvJJ3KDuD1UHXv754Ox1Sxap+V4NeTLKgvSASClgG7lW
         oAHUkbWFCgpDnYK666ORa4s15nuP62lKTVEshLnBy+qGQxLZ6NnfHHan5PfC1PKfJ9zD
         vhDw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5NeFEt0Pc/U99YRzw6YNi2nhOWVVBkFqc+WA5eMqxKUvqNmMHGvIKYqtqxWKYjtWkQ5EwTgyKzzJLTyo54dSM@vger.kernel.org
X-Gm-Message-State: AOJu0YwovEBddsYxrvQWStp3jWak8aC79kPW0EmjxJ5qS5hVTT47q3eq
	wNND5igYuiww0qcI6Se4BAnu5tmUFmFIozEFZMr0O4JA0aQ3cAkApRClryEwdqpYzAfjVw54xQ2
	4PZv4B7mXNcvFHd8KX5b9k+u8rhKRCB53JNBtqabG
X-Gm-Gg: AR+sD13BSBG9u1GmH2TBcd6wObUA45+hSEOCOcKHLpVyVeQqKP0AIWutFH8azVaa3LK
	GAI+9VrxVYod9zk09kyvc8Drcmp4CQZwZ/1WRUiTZNNPmMXi3CyaNZ0AQ7rcHotV1vzhMAhFZKZ
	GXdsbEhLB83JMiWMvA2hs/M8AxLFXtx0JTbiuuE8Y8c9Q3bVb5kkIxwL3BYbwbOV++IiUAnAT9Y
	MKmAQ89UHGIHchvUiHgcVK0KGSCxJ1On/WtsyJcLmPcshfAZB2+DzxhXmFacsY9TBuIbdwJovPd
	e6kWMeMvdMWi41jt4xtYh7eYeqVNlFACF4c8fvHnxm14/w==
X-Received: by 2002:a05:622a:a6db:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52ce96e2177mr7135541cf.13.1785897786316; Tue, 04 Aug 2026
 19:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802142712.154726-1-acme@kernel.org>
In-Reply-To: <20260802142712.154726-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Aug 2026 19:42:55 -0700
X-Gm-Features: AUfX_mzc_vq0Rba0UihtREpRI0b4KmjZnh2i8oAffoLq2pBYu8iLpdXGKPNUji0
Message-ID: <CAP-5=fVttW=NQV8q4hgNx_LQBuF8mCQV3+fZ3MG5bQA5K24Nrw@mail.gmail.com>
Subject: Re: [PATCHES 0/4] perf bpf hardening
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 7:27=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Hi,
>
>         Please consider merging,
>
> - Arnaldo

Reviewed-by: Ian Rogers <irogers@google.com>

The sashiko issues are all pre-existing:
https://sashiko.dev/#/patchset/20260802142712.154726-1-acme%40kernel.org
These changes represent forward progress.

Thanks,
Ian

> Arnaldo Carvalho de Melo (4):
>   perf libbfd: Validate BPF prog info arrays before pointer cast
>   perf header: Use write lock when translating BPF prog info pointers
>   perf bpf: Add PROG_TAGS to required arrays in __bpf_event__print_bpf_pr=
og_info()
>   perf libbfd: Fix memory leaks and NULL fclose in BPF disassembly
>
>  tools/perf/util/bpf-event.c |  3 ++-
>  tools/perf/util/header.c    |  5 +++--
>  tools/perf/util/libbfd.c    | 23 +++++++++++++++++++----
>  3 files changed, 24 insertions(+), 7 deletions(-)
>
> --
> 2.55.0
>
