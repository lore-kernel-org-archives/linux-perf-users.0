Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A03F54D1
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300772; cv=pass; b=cayU/HgQMPallhjmKmDfFsL5LEE2hGInBB0D3fxP7lpG+HWMwpExVX6POHe7OjgXRhOcUQ2/J7vRuLO5gt5PLE+qi1saob34GafOvTmfIO6u/eMmvJ152XooN+bwfpEwgQwWYhhc7kUVAF/hhncmCpUOev0ZwFXuOnYcgXB1kWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300772; c=relaxed/simple;
	bh=GTqBzAKfgVAROBwpR4zZIy6e4HLBOZqguTBU7Hhgafw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXyDcRzRAdlgnD9LZ9n1GygZPGPBzXLN9/AtCySxtu/Rdfa6z+UwdjpS0+K9Jf1gbAaFd94b7MPJ+5/bxMZlXVB0WRZEvJNCtcf0vWA1cqbyJgqapMwC5NfPxExxt4AuyD2Sld2rV18qkF9Mt+yYBxqd8GTmdopH8qxJS14CZNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9FULw4z; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9FULw4z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso6475ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 11:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779300771; cv=none;
        d=google.com; s=arc-20240605;
        b=DzlezUFQS39pg58mhOtoYI6+YOxBKMME9Po9xIsgiNFgQ7K+UKHMnKTlrvUw0ze3dx
         ZTF6GXi4JnhLfWLDGNmMDiLdEofHKWFlqVjJn0DN/h4Eirzmjeqfqrg4EeIfgXaQ5Tlh
         nG2amEaoMIwVKi8oeSg1MCr5MkEL0tfzHAOEAa3BOkoBn/iIQlqJdsMs1Jsjgh8Wr6r6
         /HMGuscOK/Q2hChgymaRpENHQov2Z9HaPHrWoOEvlFfoWkd86UEvSx4UsV3KKHY5Qv41
         6tUsXato+Qr5jPjHncqcwgncTe4n8HVEkgi//9gb7rNrWsE/8z4zMz7FFmgi6PCtyOBZ
         TJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcN77jj+lpLzN3ZkjW0mDTaYGrQWWZpdh/lphErstAI=;
        fh=IZHUywhNPtkXTShIBoh9+zmo8mfB89yBNDw0XBEXmns=;
        b=jfOS/59aiAUD2B3khL00v9+LLBVMJn/mimQagZONsoqTZgLrMMHTDY9AzQs/mKwIhq
         /OLI1WkOshgREsf1afcRgqZkdVXY7H/TpU3aSNYE16ov+NXyFbUkZr3eFjFovTxjJhoH
         CkwXq74H5zfzVVcZWcUNmqBm8gsNDCXbqtTrZ1NdutR3/Pqp4ztTc0LHKuK/4y/jkQC0
         jh4YzuEx8tLoCjZV1sSS3JjDKXgAc28RDMFqqXgi4F38ixNyLyl1fdttFG7Kdbar42lT
         0d+2TW+QCxYwnsfkOxP+O/SjpsKPM4Sxvf3XDI0JNi0aGOPT3BjCjOIM9+xfml/sZEry
         po6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779300771; x=1779905571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcN77jj+lpLzN3ZkjW0mDTaYGrQWWZpdh/lphErstAI=;
        b=D9FULw4zpxQbNAYTYhjLnxW1+EBFBBQQBErMw2FCVzqAJlpCHIqFmXrAcMIHt+TMD4
         zck8iKIKTXnZFx3fFTrg192PSHfygtjTqwrNKVJoT92Ekn9aiejtguIqYxaqpsTwfGvK
         cYu4Op0IbKvNW/unYxCZaTkhLXP3z5oAommO5xVAu6aGWaVL9AxTvELUO4gVMoI7/QSL
         WpxGnA7xj8+jQwj+VBZ1xfjqgkkFtkKoFOShUmLlLcBoAJx+ZPcGJCerH0cAQianEWuF
         8kgzELSOptd9uP0aMqQEzJVQS1MkmxSgKWKE5ZpOdxffku1+O4SphfXeULqosAa4GNIm
         5Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300771; x=1779905571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcN77jj+lpLzN3ZkjW0mDTaYGrQWWZpdh/lphErstAI=;
        b=buwjGlxLj5Zk3A+Dv7spAz/CDdDnJhHUoWxZ+XkMCTXPEKtTlddgqglyuVf5j1yhYc
         o8XodaJBk1TWa4nha8bbJG3OsthuBYWQNi6ZSDPNxFQEHUUOQE6t4GC+MQumW2YEjHVy
         UUhyUioUpiOY3i6edmnuqETHaf2RWw5Po40S/627e99LksCDs8IFTiwRXXJ9jEttLhX4
         JW/Lbp8pYv7bB5FlJqMmvwyfl6agXj6Er0HbIzr5zC1cQHPbSK9HWYK2iXn1rK1dLsWg
         tnw5qUiiVIm96a/z1doiiOBcmLS8xJCvM0DZ2X5uMDxKO/rwHT4REb7hihLqjFKjaY+o
         onHw==
X-Forwarded-Encrypted: i=1; AFNElJ+WMsWNP99wdGV6CO+5suX4aZ6d22tLPTLp0TnrpVWitNmIiObZsZhgjEpeMN7e9EdkG9kK/miXFMr2ixi+l1lV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaps7z4QfwRpNKwLvXMpB//8ZeemAKfVYnjQJeI7RgbpRlVya3
	jhPF9gAWELmwf7h4K3qYXVhu+Lgr9IQVmILTZ+C4/duEtBm0hsrsGOo08TGYxl18hHaSQAQlDYP
	ITCaDE9VJZ6jcNq33+Xkowyp/OkNnnEViNxQNLNIS
X-Gm-Gg: Acq92OFnNTFlRESF59Ci6Nt4fhZOBJp8moF4s3N0ZE7+BlGgtRdz5I8Eu+n+NEjafQu
	K1gv9rVO9eDHEyuL8TB64/Vm88bjZrt9uxdG7wG1MbKccUOAg0P6qFBIm6iOssXetRo4u7IQLNV
	bYPpeZIjD3hsgARJpz2ritWRsgySdQz+F8skmNiNG7EmG4hchTuJqi+QK8wQDLwC8phh3YFI0Ru
	bEiYTogFE71TU8+NvvLjJKbXh+aum5oHhYZvrBQHV9E39+pGcnCOWd+q/jrbX6vyZbos9/eovkE
	keAxUSZaLnJZhvsnlX18+pzF+C7HZLdsOCUTL3/a5ril2NPz
X-Received: by 2002:a17:903:3c63:b0:2b0:7a9b:82f3 with SMTP id
 d9443c01a7336-2be9f0f065fmr399355ad.8.1779300770571; Wed, 20 May 2026
 11:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512194710.162215-1-mjeanson@efficios.com>
 <CAP-5=fXMtbO=7JMg2YvhQNbqOEFH_ze=8EifYM7bDfR945=KHA@mail.gmail.com>
 <e6d88ec4-c6fa-473c-ae70-071bb6f040c1@efficios.com> <CAP-5=fVnNyScv=fWy++iucCWWe8G7jcEn=AiDbLEV6PaeBooHQ@mail.gmail.com>
 <CAP-5=fX5QpRcVhnZCd230FQWsJ8KHbCrv6y_47vcrBK0fhWWxA@mail.gmail.com> <33978160-74a3-42ee-a4a2-1b0ad968a46e@efficios.com>
In-Reply-To: <33978160-74a3-42ee-a4a2-1b0ad968a46e@efficios.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 11:12:37 -0700
X-Gm-Features: AVHnY4KwWx4MoDhxfZ2HdYg8MlT-R0eEapSq3lNmxyTdR2YuhU1rc5M8nqLa8Ys
Message-ID: <CAP-5=fUxAGG1Cs9yHqy7qjJNa4KP6E_Q0cCdLfmYwcPnHKLdyA@mail.gmail.com>
Subject: Re: [PATCH] perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer
To: Michael Jeanson <mjeanson@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 10:58=E2=80=AFAM Michael Jeanson <mjeanson@efficios=
.com> wrote:
>
> On 2026-05-20 12:13, Ian Rogers wrote:
> > On Wed, May 13, 2026 at 9:06=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> >> On Wed, May 13, 2026 at 7:14=E2=80=AFAM Michael Jeanson <mjeanson@effi=
cios.com> wrote:
> >>> On 2026-05-12 17:54, Ian Rogers wrote:
> >>>> This is cool, I'm surprised at how non-invasive the change is. I'd
> >>>> done a similar thing but keeping both babeltrace 1 and 2. I'll post =
my
> >>>> WIP in reply just as a heads up, but I have to do much more heavy
> >>>> engineering.
> >>>
> >>> I think I can rework this to try babeltrace2-ctf-writer first and fal=
l
> >>> back on libbabeltrace1. The change is non-invasive because
> >>> bt2-ctf-writer is basically just a compat API for the ctf-writer of b=
t1
> >>> but it doesn't expose any of the new features of bt2.
> >>>
> >>> Your WIP patch that uses the proper libbabeltrace2 API is definitely =
the
> >>> way to go for the long term. In the meantime would you like a v2 of t=
his
> >>> patch?
> >>
> >> We have a problem with the perf tool in that it carries too much
> >> baggage due to its library dependencies, so I'd prefer we stick with
> >> v2 support and your cleaner/simpler patch. I'm also hugely
> >> appreciative of the work you've put in! I'm too busy to review my own
> >> work right now, and cleaning this up ASAP offers an advantage.
> > ...
> >>
> >> * We support libbfd although libbfd is GPLv3 and license incompatible
> >> with perf, which is mainly GPLv2. We carry around libunwind support
> >> but that project appears unmaintained. We have LLVM support but the
> >> LLVM dependency is huge in terms of size and dependencies it brings
> >> in, so people avoid building with it, etc.
> >
> > What's the plan here? I'd prefer to carry the v1 patch, ie let's lose
> > libbabeltrace (version 1) as a dependency.
>
> I think I misunderstood you, I thought you wanted to keep the bt1
> support as a fallback. I'm fine with either version of the patch being
> merged.
>
> I can send an updated version of the v1 patch addressing your review
> comments.

Arnaldo, Namhyung, do you mind losing libbabeltrace v1 support? As the
commit message states:

  The 1.x branch of Babeltrace has been superseded by 2.x in 2020 and has
  been unmaintained since 2022, efforts have started to remove it from
  popular distributions.

My choice would be to go with the v1 patch with the few fixes I'd mentioned=
.

Thanks,
Ian

> Cheers,
>
> Michael
