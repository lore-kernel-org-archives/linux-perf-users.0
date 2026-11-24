Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795564573;
	b=IJEIGzPagGvzxtVkoLTgrU1MqSECwvVzAf5r3u4KmIDv/O/1LWR/aAZAWyQ5KxWgI62s
	 jcS/u64oTE3pcM697D3B71UB3Ll92QSa2ZcKrdIFOgdMJy2F8mHhxPdAh2et+L+gyOtca
	 z3hMYMWVLddCVHDTDsXScSsCXBuUUHs2BwToNnkeRp5DvRmD0cv3Nf06irh3Dt5NMj5Qn
	 Xkbb2SCwNqVQfNhPo40Z1W04mEvu0rNYNOJeZR5d1wWyAjGvUXuGhaxjTzm0faA9oNgT5
	 HGXZpmINs7EqsW95mKiKaC/0K7kzmN37DUiIwz0fP6q4QuZMfWYotrNywXhcUr4YSLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=P9obVUdl+GBU+uYDBqJj2c9nK5zYkSjOyVqFSSATZbA=;
	b=A4739/wpmHacNYn5UniPZdDVTdH+mlNYRQNyAP6BFuDDAz0xCWzLZSUE17uHd4Noz2tG
	 RlOHuuzu0D0OHgJSw8KuBaGoOPfLEgupQJvr0GXLGKPS8TKg4Y0SU7frY7nxpbgmvRFGg
	 fYDs1duhFMN77++MUUCf+Louh2Ftqfs2VLE5D2fhVDKpwgyBjEq1bCgpaL8GcWE0Zu5dH
	 U1HygTmUKFTQ9Kn1JkP5NaI4RTHa01pLJ8PSwB5mEFNiQE//Bf2Ueb96SlvG/Gs8pLpBx
	 uSbX0ceDvFPI3qM0lFykgLpBQ0/lahNs8z+l98lu2GYLX8gRPNgWFH41E7E831dL8Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=U34kADgq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF5606A323
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 23:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4BF5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=U34kADgq
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4e246acc2so36969067b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 15:56:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795564567; cv=none;
        d=google.com; s=arc-20260327;
        b=iF6n4AdsowLkgLF26EPJzqXricldqkcfmN5raXnNgaa7xv/i7Bz7vxGT58macHs5yK
         bj9vqUO+kUUq/xQRtNHXNMyKtRCZy4JnUfz1pIFFIHccP0d8S2OTGoVxSEuy+qsgvq4p
         t6BD5xo5+GqMKf4CYjOaWOOIUmqi0rz2m13y5qSLUD/ycW6mMKu8Hr/xvgR7BFcJdo6b
         mQDKczl3DnQR39l/szylBZPayZIrnmFXHLwb8MKUo7hY6U6x1Qy3NcOQqzH4eKhBnE2b
         ksW6AbWx+KoNAKlV+cxlOlLjg1hChK3hl/au/mWrx3oyVsSF5xWTB6dYO3RtKkN5CWJ9
         Cpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P9obVUdl+GBU+uYDBqJj2c9nK5zYkSjOyVqFSSATZbA=;
        fh=0XlrhRw3cuuDOqSO/Wzv3QKwPkKx7sMsafqQabP7Dsg=;
        b=KnPJEFKxPR0vCxlvKHQtU9OS2bc+Cwt9CciUUG0sSkiEY1hjon/uxVM82HEHN09VS7
         Dv7M2QtprOdtRZzrzHY+AqSJTzqEyGFKqB1stHPF8ya4fSpGwBMGoTY1J9CefG/cn+jD
         UR5ih0GG1C16cIPbo0QYnPGKB4y1M84TsFoGcCg/fvgiH7Y2UQAbsV8lensnuqKFVO3f
         QZWFCHUubTQPTl7sjcm4dell4Cd6uED5c0S/tPbgQWRKe+ZvMQRHLex1XKCNfAJ8/PiF
         BKwg7yf/I7lrwsIuFyj9XB6FFWeMAoi0mKeS/fdWzTEe2dxcBZcecq/4482vsjOwh2dc
         133A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1795564567; x=1796169367; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9obVUdl+GBU+uYDBqJj2c9nK5zYkSjOyVqFSSATZbA=;
        b=U34kADgqTwKzgQ0CQztr77XUFFpFC3V7NwoUQyEoNjC7eUPPGXAI8N/0ZGoFs661bt
         3Sr2sSpGLBJC387//QxGBJP6oI+IRNHM+SxqJPwoRIrdi5yEFR8nre/e2y1X2B1dZaWz
         XPXW4yOba8Bvt+VG73A5AJFNkEJEw8YBF5Arc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795564567; x=1796169367;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P9obVUdl+GBU+uYDBqJj2c9nK5zYkSjOyVqFSSATZbA=;
        b=KAF7FvLEcgI1DvduCqVlozwP1zC93J0W8wOH1+UBt3wIrAO9ALd7upvJXtrhVwPM3q
         Dro/I28EK3EzoSormXiYSKyY68i01hx2SBaYEBwJjiqsnbExAgJRm/PqLPYqo+LQEsUf
         5P731S5OfJhS/iUTl3B8WlFw3/M4LunhPadqzor9/K5uVuXAxoOCNexSM84TMAJYN1px
         cVORMOc4I4YYMlUJ9tF/iKRqcuOS3r2ZnPt3yMBwgZuCV4l9esi3m1oLYNZu81IIAc79
         E8wuXahr2frlHBtAFNS1Ou+UZ3n2UA3Jek5OGI5ND2jMY3RwbfbEqXMuBmJas0fqdPJb
         dLAA==
X-Forwarded-Encrypted: i=1; AL+hErHCgUQCNkDtoCe/hODje4Txws4TaEuBe5Y6cIUzFxg/nZ+H8AMeUI/39oIXgzHbkzrG3K6Np/a60ljxIvX2L2dN@vger.kernel.org
X-Gm-Message-State: APuU4Z/DQHJKE+Gnu8GNERoHzZJvxuI1iWXFPZBGCcTKTaEzcLeT+RfT
	5PRUATVSF/zU7GHvYD6bqJAFYPyhoQL85rxlcnAjcTlA07MiwLtcjB0lsMtRdJbC6n2FDiM5ZaN
	D5NVP1EFiIrHUblZLGTZN/V7G35RaVWXD+AW49MO8Yg==
X-Gm-Gg: AZFdTZelv2f39iJqMCaiuzrPGyT1c3rbejLlNOmZFk/M1xjOBWET+Xot6GvUvsNLp2u
	xG3z/YDDPNfUO2HQTKwOqzO1jtSP2wECztorDbZXP0fIyS6KsSof5eBebXhllZJZeuww3KJxGhw
	YavA3N5eU1U7VyGHZK1ksGHj/PP/IHlo82ZSYzAJ0JTTuKIVi0//R2+G31sPRZJL6cFZc4j5pfS
	5GTliggCvbI6VP4EM4tKu71Ky7IE9XG3PVMaIAk+wqGynNJwjxKAmDYf3D8uAUiwe00LzNxzI/6
	UBRfnDMw3oTCRRfX5DTjdFLxZo7uzUtJ4AL25Z/SU3W5rMHwXp9Qbwe0h7lOOd6N8CwBQQRjk3o
	G/Gr5nezOmEk1nO6CV2EOHEDPMybPRjSLUqJ4aJtCewkeRijFq8f83NRTV18ssZI2gl+Prqc=
X-Received: by 2002:a05:690c:3610:b0:8b3:2250:aed1 with SMTP id
 00721157ae682-8b52045fff4mr69121787b3.26.1795564566176; Tue, 24 Nov 2026
 15:56:06 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124223109.820609-1-irogers@google.com> <20261124223109.820609-12-irogers@google.com>
In-Reply-To: <20261124223109.820609-12-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Tue, 24 Nov 2026 15:55:48 -0800
X-Gm-Features: Aa3M54p0wKfFj2VYe_421BdDrEqHx34EbkPAmcEFEeQK_CnTJxGvYmUYMfbbS4A
Message-ID: <CA+w=M=SDh_XybPCxkLdJxS7GRVrx_dgjqouoHSi3kLew=NUM6Q@mail.gmail.com>
Subject: Re: [PATCH v10 11/12] perf session: Add dso__session() and
 session-scoped allocation wrappers
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 02:31:08PM -0800, Ian Rogers wrote:
[...]
> +static bool perf_session__try_shrink(struct perf_session *session)
> +{
> + size_t freed;
> +
> + if (!session || perf_session__in_shrink)
> + return false;
> +
> + perf_session__in_shrink = true;
> + freed = perf_session__shrink(session);

Nothing calls these wrappers yet. Which allocations do you plan to
route through them? In v2, __symbols__insert_sorted() called
perf_session__realloc() while holding the symbols lock, and shrinking
then freed the array being reallocated. Knowing the call sites would
make it easier to check the locking. When callers are added, could a
caller hold dsos->lock or a symbols lock when the allocation fails?

Thanks,
Alireza
