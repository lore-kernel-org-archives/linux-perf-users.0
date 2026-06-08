Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F627FB37
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956138; cv=pass; b=NCKiUkm/V7f8v+Z++2p+bdk9rEDnYIAGKt7hr2g868N4E9LaSEpKkwlex2YITq6UCAO+SqiL0LUD94oRRrzUPusO+ODBduX2xosDUC8V+tv5jx8DHLTCB8IdfI8USp8+qhZ/HLoVlKGAoxBSDYOVSkjfHy+W5y4y5I6YYdT1lhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956138; c=relaxed/simple;
	bh=FSHAMXGTxOhLxgSJV8fxt3X9FfKOyoivgQj/CrmhElI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2W8PleON4km8BoudJvrX7Q81gV0VRzP1pjvGNcledNIOsn5RWvfpU6i8PFwfOKno5X9MuZe+tNrGqn1eN+B8HbdEgD2tF08uI5wrbcmYk6YPq5HzPz51pvAR78HGuB+hnXgkejnZkpCZ3k1YS73S2CjXodll7ptG2oz/eaLnuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjRNyEMj; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjRNyEMj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf2d865383so371255ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 15:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780956137; cv=none;
        d=google.com; s=arc-20240605;
        b=heUnxrfK1dEhmGfp2PHcbHRJB/iI8qvoubKFv9lOlA/jWs/+sUW2Q1Nwrlvl60pvT0
         9b84O/HR0X03go116ngqhXMmKRqDmlpdpAjZ3EnTLynhAo2fVfcewc4W+mtqflp3DuwN
         RxsofyfGkKueeW4XW3vOaic40Bgy//4hMVBx86Uf3YrYekI/i822Ud+iLfx4C4GVOGPf
         cjM2hiVKFqSKQeF2s5R1MT9puCYBSMOeuaFZCerPH2X9iuzbtGzXydHYs461xLL0hcWj
         T+xQ4pMNtKVvadth14UmUlGclXvQAmZBlSewn8+egJup/IebTORTfhuazLUiU5O8Zja6
         JWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p9wRe0Egvr2xl8CUrwPfdhhQKwWxh9jd4iOFzZzAYQQ=;
        fh=QI0UsHrijHV8yGTet8W6eMvVI+rP8119IWaQ2hGOni0=;
        b=KMm8fTzA4B0PpwsmOo1kPLUoxn7Jk/m0ARkuV1uQAZJi8Kc5xJ/JpMKgjUwlTsfP37
         ydCXph4gb6TlH6p7d0yFd0H2kONkZaD9H7Cttho17gfTzQd6fHdt4reV9AG7E962tyjh
         083x4wzMXZUn32MWq0t7FLAA0NtbIHKa2M0E1ORXz9Br3JmDnff4reiZY64MpZ/Sx++3
         a2lIkIylaJDMT+GOls1sK3WaKmvpPif9CQyHsqhUPnDf+RABW2VAA2dh7zmrOpBDDdWf
         CcbmhNLDg5DgPwSpJ7Kb/fz7x9oMHJAtttycexJQiSmzYY5DFdE7mOVTQaJu6GsPxJAY
         kleA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780956137; x=1781560937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9wRe0Egvr2xl8CUrwPfdhhQKwWxh9jd4iOFzZzAYQQ=;
        b=tjRNyEMj978I3wwQ8VMc0qcKaJo6/Z39JIgaoL4V7pRW6vYRVRaJpfGC9mLU8GyiRb
         F8Ge5O9LIvYxMO01hf3w/8gDhkMuQGDwrWqTELBTRY7l6f7iWWVuTWmWyNE1EGtC51Uw
         Xbq2fuWISanibV0F6+mZ8tJw5MJXpa9EcgHO+DEtwOHphfZIfOoNgPCvahyFgMp2g7xx
         9NTAcXSQHOYn2fKF0gNZsrYb8QhMGuEUCOakzxxSwX9OWdovC/4NE1hChTyrhPfC31A9
         l8X1+EAvApXOgJpSr46KDcB/XnwYc41+4zYfQMSFe2IQIDzYaZp9mQZfdtY0WGwyBDgV
         KTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956137; x=1781560937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p9wRe0Egvr2xl8CUrwPfdhhQKwWxh9jd4iOFzZzAYQQ=;
        b=sNf/yqfc4nkJc8kXBdKGAElAqgfiAIFbeZ4+wtCVSlANFNX+BjlGGLxMeVUH16P5sE
         T1W8qePqi+12xAGC8+mPb/xG15PHv95KQ6rKKamW2lrr2aFyOOwBMw55xnTIrMrskdJw
         06NpZ2uuWUU7Qqqv6ZiWiQ/NJdAZJUWz0GiPyZALB7VXOa9JkpHNXKKre42vXb8uzb/O
         BjMcEsQfe+QU0eXgHYF+HTbYRW21tU+YZ1CmdBpJK681mcCU8zVUEqZcCkOOpiU0ODTa
         UEx7wgYq6jzNHkK3Q15xQP09EjTyAbtUX+IW4IxnfmdCe6lrnwKNkvBqJTcJGQw9kSuW
         4k+g==
X-Forwarded-Encrypted: i=1; AFNElJ9KfA3t7FBKpspfhbrUrE9MVlrj2nE4Q2XT1bIYs8Cw8oabIFi9TbmnS1FnV1ypDrcanXqTY4lh+MWklvEu+uuG@vger.kernel.org
X-Gm-Message-State: AOJu0Yybzm9pdRpAye6bSsFx201wteAZ9azESBJT7oLy83HIwkRxw1Z0
	UROj9QMX8H00DMkJXRsA2VC1RIWAWc5ppUTCo9jX5HDXu+sGqvXov1hMOA56a1bQsJM4cwET4tw
	/DN2hr5kSDhuDMEl4EtMEppB3GVzdgD4wGWSYSM23
X-Gm-Gg: Acq92OEIIoPx9nuUUjEzqawW27a+9+mIRZROApoq7TdTq2KYjwNEKGV0H3tFBieBC7s
	vrg6jZb6PiLesugaDneK9W3T+jbKWFOXC9qWzqPo6UqOFc2l2ik6O+nSStwM9aC+g4puPU3lJEW
	AyzaALryoLmpakbBsStn+6OJc1IvdHMQ/6E2OwvnSYuCylizCh59dcebQW+JQR745tBbgBZVIUl
	TVP92ZRYad8OtealYEmS7omnAzx6GyAVg5ddhQ3gWnu8e3Jfa04U9g8Mllz4z7v++p/BhtwdAEa
	koDaAMRsu3hWtg/Li+B2iFMQuMR/EIPUwCMob6MAbWXDqy7G
X-Received: by 2002:a17:903:1a6f:b0:2b0:b0c9:96e2 with SMTP id
 d9443c01a7336-2c1ec0deac6mr6254285ad.21.1780956136544; Mon, 08 Jun 2026
 15:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-1-acme@kernel.org> <20260608201753.1979464-10-acme@kernel.org>
In-Reply-To: <20260608201753.1979464-10-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 15:02:05 -0700
X-Gm-Features: AVVi8CcMhO0e8HbB5h72jYxPI-NBYBJV9UREBe9cGqd7aoPOOK0_aMnVUVc3tIk
Message-ID: <CAP-5=fXD0okTnXJ-D2tEy4VswY_EEa=Aq=Vp9Za3anvvcxa2Ag@mail.gmail.com>
Subject: Re: [PATCH 09/11] perf hists: Fix snprintf() in hists__scnprintf_title()
 UID filter path
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> hists__scnprintf_title() accumulates formatted output into a buffer
> using scnprintf() for all filter clauses except the UID filter, which
> uses snprintf().  If the buffer fills up and snprintf() returns more
> than the remaining space, printed exceeds size and the next 'size -
> printed' underflows, causing later scnprintf() calls to write past
> the buffer.
>
> Switch the UID filter clause to scnprintf() to match the rest of the
> function.
>
> Fixes: 25c312dbf88ca402 ("perf hists: Move hists__scnprintf_title() away =
from the TUI code")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/hist.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 811d68fa6770c5b7..df978c996b6c2262 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2963,9 +2963,10 @@ int __hists__scnprintf_title(struct hists *hists, =
char *bf, size_t size, bool sh
>                            ev_name, sample_freq_str, enable_ref ? ref : "=
 ", nr_events);
>
>
> -       if (hists->uid_filter_str)
> -               printed +=3D snprintf(bf + printed, size - printed,
> -                                   ", UID: %s", hists->uid_filter_str);
> +       if (hists->uid_filter_str) {
> +               printed +=3D scnprintf(bf + printed, size - printed,
> +                                    ", UID: %s", hists->uid_filter_str);
> +       }
>         if (thread) {
>                 if (hists__has(hists, thread)) {
>                         printed +=3D scnprintf(bf + printed, size - print=
ed,
> --
> 2.54.0
>
