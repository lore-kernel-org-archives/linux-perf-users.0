Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0251AF0B4
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233303; cv=none; b=TKDhmIh60GjNrdyzAjCMacZcOunXBY0xPIoXFDPPtorZNPVuiOaUYFgdaHWz+rBaVp31/39deaijQUwo+n3OggaaSeI5ztz94nVt0bx4A7dQaAAYig2OpvvewpG5PYohutIqi5tBlkTl5AyJa7OHhUaXTCzuhUc6KjtGTF7txgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233303; c=relaxed/simple;
	bh=2iXPJWP1z9o/7gPaz4x1Vr+Hj0p7KnhZyY2cxs4UCsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWlcj0/JuBhiIHeRpWQzAlFyJLqO+nNmZevjowkWW73VVupczwUuL5cIqODNbEGwTQs4mOYzbIuyTxTApXUliRmB8icERzV95MW7ALnL/UrExoElCKLIwC6eGR1eUnTO7RD1H7+Bn3SgNbkaie9b5hu6RdTGsyXHTCBEqfgS1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vW0OR4Wa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vW0OR4Wa"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240aad70f2so76555ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742233301; x=1742838101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lATWno+kXyCA9gXnRwZCNyfTyGMjQkkcrd7sBrYiKLI=;
        b=vW0OR4WatDseN5WLlNtePnXOb50TBD2PMs85uEiD1+9aXoUuBM0SkCePQQrACHt1Gy
         NRGrUAhGtwVRDbsZOWYHpZpZpg6U6vU7U+BSW07BFGjlCrfG58vi6NHR2C4Lwte2eCe5
         c1FVYxZy0N2BmSrzzOVI2pEPoF+0aX8lh21IFf3hmAn94BqVffskvyXdqZ2rN8JLtn23
         kdL+WPCN7FIIOc6as/q7/J+5MJt7U77ckzLlerj0N9MnxPAnImveFYs6TKQSolSfi87o
         musXaB9kNE6TaqvW/5y0onRqigVmw0MW+wtXgq9lZ8fl9Pwu+RjlzMx3nDphIKsZWFcg
         QKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233301; x=1742838101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lATWno+kXyCA9gXnRwZCNyfTyGMjQkkcrd7sBrYiKLI=;
        b=J1uxPHtP1RImhUXZQMqiGUonu6mJEC4VN9K0kK4YJe9eA3hM/AfJlPLUn0bezioYRX
         6/VA/UcxF/q6NTQcHx1D/xl24IOdG2P0Gd86iiBlXPs9A8LS4naxjq+/B9aLN2haJFzS
         hXB6S+8764pMW8ktXOk5J3rTUzv+XY5g56MpfEj8QtKXWai/sDX9302qfZt+sBXfckom
         1gWCQkvU5RK0brlfw8btKgpReY5qdfVKYiQZXfh8nX2oOJ8Zy/8jJGw+D2TqioJtYqna
         /M/gAyGswIT83C+bpgvetxzZPgvBGQ8ODY9S2Q3X55xP36Kbh5IIYUokyBd1ORHRGDNM
         P3ag==
X-Forwarded-Encrypted: i=1; AJvYcCW6ah3v4p/d5t5qpmY/ey8GsvhYkEPC+fa/CVbCnB8ySm3wCBak+7l2ujvQGUKuptpPqEFtIWLbLWDSzs1K955v@vger.kernel.org
X-Gm-Message-State: AOJu0YxLyzu3mVD6CEyKYINZciSxwA62f54fYETeBQlTSUls7Ckt/NYp
	tmhUrhORER4mLxyJIivEB7SiG3gG4MYa/8kUT0z0H2w7sGQiK53BymVKggpovucQbS6bwxPZCAk
	LXHX4jEHZTwOk9ZjBmCX8HkFm3mgQlLTCR7/i
X-Gm-Gg: ASbGncv4/iQ8FcSNJm3nmyfpA3dqe4WKeA7Ds6f/5XeDnKDR/dwxtaZfaJUnt0Me5Fr
	JGW/54lP/6CbrNTlyoxshioO3antsdwrKIlRQMzWCPQ9S5bRa2NkXYA3AW3A5W+FDku+/YtOa55
	Ensv84dQCGaub54FCN0YqTiOwWGOwOkFReM1DVZj5e5O9Yn6LqHxOcJs0=
X-Google-Smtp-Source: AGHT+IEIYL1jMu8c/jZPzJq8IxeFMMI6ydO9iAjEFwdH+QT2RkBXanYn5Iiy1WmvDd0rwttzDUNtIxDCZsUPBlHf5ow=
X-Received: by 2002:a17:902:d54d:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-2262e5a2abfmr16435ad.10.1742233300634; Mon, 17 Mar 2025
 10:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312203141.285263-1-acme@kernel.org>
In-Reply-To: <20250312203141.285263-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 10:41:28 -0700
X-Gm-Features: AQ5f1Jrzf0iH9xyr2lt31DxMP4FCuxmnry8MXMkcFEW3VWFnxM4d5NLukHGmsTU
Message-ID: <CAP-5=fVp48KUB5sawBp-6t5DyzGqDfxtXReSSTQ-LDXFKMAvzQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] perf python binding fixes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:31=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi Namhyung,
>
>         So this simplifies it greatly, it almost ends up as a one-liner,
> but there is an improvement as well to mark the event as consumed to
> then parse its sample, because the copy of the whole event was done all
> along.
>
>         This is brittle, as the header size can be bigger, than the
> space we use and in that case we fail to parse the event by bounds
> checking it.
>
>         Supporting larger event payloads can be done on top of this,
> possibly by deferring consuming the event in the ring buffer by parsing
> it all instead of having pre-allocated space, measurements need to be
> made to see whats best. I'd say leave this for when it proves necessary.
>
>         With this series I managed to run it for a long time without
> crashes and 'top' says it doesn't seem to be leaking anything, as its
> memory usage stays the same for as long as I looked.
>
>         Please consider applying to perf-tools-next,
>
> Best regards
>
> P.S.: In other news, the syscalltbl series from Ian built on all my
> containers, I'm now trying to go over it patch by patch.
>
> Arnaldo Carvalho de Melo (6):
>   perf python: Fixup description of sample.id event member
>   perf python: Remove some unused macros (_PyUnicode_FromString(arg), etc=
)
>   perf python tracepoint.py: Change the COMM using setproctitle if availa=
ble
>   perf python: Decrement the refcount of just created event on failure
>   perf python: Don't keep a raw_data pointer to consumed ring buffer spac=
e
>   perf python: Check if there is space to copy all the event

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
