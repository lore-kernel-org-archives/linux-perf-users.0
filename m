Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD6329363
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900332; cv=pass; b=KuN8Nwfc0CrX3Pqknn1+YrYfhG/KSbSQ3TcQzjRbjihsre9lJjG488eNB/tKyLZ1a2jiAR40jwVA9l1UNKmANJo9n1kaORnHHRZdLSHlSID/mE42EmAc9LBHja1MJCgXu7AWSBHEMcNyBRB4lEaYtNYShYxdtF+uf3xN4Sr6gXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900332; c=relaxed/simple;
	bh=dNGaP/TwvdzbFrecYbYtaqAbrRCIjXvPVK4PP98HrD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzJN0Q12mw057I9T3ATUPPaLjOGeHtGsgCRx8L4q02GpDPS28e4LZ/S+NTZj1Sefg3/gU6GpCAk/ATV0+fjR2fB/uSir/5ywqMzsBjJj/gQ30fjW807gxVt8Bj755/WajQiMGf9sp+SAVfnaTwHi0VpArcCoZGZ7dry3/cht2fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRkwW11d; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRkwW11d"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29f02651fccso12915ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:25:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767900328; cv=none;
        d=google.com; s=arc-20240605;
        b=a4PCNpu3Q/DKpw4/E0a9gK/cSRxgemUmyzJxKpjdBK+db9AIQ0VDljkuhl1nJEKoBI
         R6cJugaJRTHhh5WoTQQTB4la4izSFL2VdQ9tOPDt+9VJnrSuJNelNL/y/W0aqg1S+68M
         IiGzcsHnm7PIFQQK56he2dhHx9ePXD2tQS9klOKHT/SYE3leI48woxVkrw5OfkpWZCoV
         JaOQVeeDaV5+8V3TAE8AI9YKuZi+bwSL44x3D76jfIDdD7xp8o+nMjIoUqIaPh+km6ad
         BLQRVuQVuy4RbEtvzB0cxW2gSNdF/MeCEXyW9Co3I28FQX3L5cu6NGj03eeVBbB6edbD
         4aSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oa4LdsUiKOkTunqpDqb1Q1uL/jgTX5EodOak7TUcXX8=;
        fh=aqAUi6WoedPW1/TI+VAQACRQT1IVpyborl4l4uASnLo=;
        b=A+XIg6zlxw7m3RhSmrkXLSA/19jbqU36qzbeuIfZDbMWFcyVnCa8n4D1ElqwZnw8zP
         7//w+l9mEbOUHLY+N7t9dynL3Nu/gBSR3xeZqqrEt2myKkXVTwRfuBuRzbFQkFMtlT98
         9oC18vEojFW4Lo7p57AJue9ZdFejWSDKbQnZQPwCDbCdQb/QkDzEVhN7gFvTE88cSial
         jZhwPfRqgh/biT8W4TK4UgA4e3ai9cWljqJyYtpoBPRYcPMwYSTUr74jhuYjY3GYGAw0
         qmduHbR4PTevXclxlugRZRvB7JF7m4l527PkleuheLYzx/xomLs6B1CR2dzgsO0qEFS8
         G34Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767900328; x=1768505128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa4LdsUiKOkTunqpDqb1Q1uL/jgTX5EodOak7TUcXX8=;
        b=vRkwW11dyfIS1q465tuLac8HjwAzGSNM99+1Cxdj+LrCUp2SRCXx2e9JYhXnupfYle
         lR7bA+NZBFAfibBTyXYBljhUqWBoYEwJAAlz3R8x+g8TZOcTskWQSzyh7i+mSSq9kuse
         9USYy4SiUSMPb6rb67vWn0wlETVRNedqKAVrPzsVd7J19GKEgrv1KQHcOCsDPeKPlgPh
         +DtthmICRPRHwZaYE6fJp69bb/fe9aGGjFntU9l0ZEY3BTU3VY1EYsbYVikSPX+tpY7O
         1ION3OEaZSJXpwBdVp/D20qd4z3uU0qrZjgH4AA02NFlXwNX/QjxrBaaN2L59jIVdNIq
         wD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767900328; x=1768505128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oa4LdsUiKOkTunqpDqb1Q1uL/jgTX5EodOak7TUcXX8=;
        b=iuiK9ZxcH/kQVceqsmiDOq8KkjiMLXvbD7qqmxoseuOHkl0Bjznp/vSP7ih8tfCz/w
         NT4pOJ1FodT2AbrBIySHNs94RMLRP/DpKEpN4y5KK87NEQA18MX1KiMaWPep6YGlLIS3
         r2++ZKhWX1M6+E/m4cAuVesnTqeqKJgA43k4SNn4gTRV0/4JUxcynOyl/QaldMadgFXj
         7uMxwcSawy76xZ199Lel00LP9aGaXfsTgHFCZZOWXDx+PbdhMvG4ibNaR2TyCmvCdKHX
         kAio8rjoHa3vAcTa6UeVioThc5AwTvKcT81djB+Ll4y18RnYEoJ+rQwVTKQOBk5sW3nC
         DetA==
X-Forwarded-Encrypted: i=1; AJvYcCXuGrg4o8xE+618T6flaj9pe+4g5MACifKRZPEeiJMd6mItBqwU4SEUGRB3gbCku2G+dE++RKiMukC/CgeMf4xr@vger.kernel.org
X-Gm-Message-State: AOJu0YyMpKZDOVx81F7j/dWUim8mj11znHxhY+J4qbTVjSfst7xzySZ4
	/9at+/ECVC5JW8YUmZeXmnPpuUHiO6G2ON6uUSNTyXUmws8zjyqYPqg8BM+fEv4ip/L/jCX/GVj
	L5qZDQXdPftzVdSuFzRQ8q7lZTnwHyj8zAo0I1mog
X-Gm-Gg: AY/fxX72pSCzAN2N3SoV36aaW6h7y2Ky9J595T5chV9LxyU8NxdnLJBcJPgef0ghehv
	SLV9UnLdXmVQd628B8BRnP7ZuQ6QPlQZk5tUBuKnbGSR7qkmVv2zLMxWPE/LNJK0hI54GW9/bpY
	gA9/EQnNaosR1C9LzaHkM6ldm7n/FFXTs90QVUwWt6A/koiBh3FEMpTy4LE63P7XToqZbhdg3ZY
	/AH8qXpm09igGszg7VDfOFpto3sV30k2MA/xExo2Al0Idvt99F7z1OsUeJj8FiofrT9gXydmBGc
	qPtIWUFBYujwsyl/zeqZoEUEXQ==
X-Received: by 2002:a17:903:3d0b:b0:2a1:35df:250f with SMTP id
 d9443c01a7336-2a409b53c61mr433075ad.15.1767900328196; Thu, 08 Jan 2026
 11:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209173610.2033973-1-irogers@google.com> <aThgIB2VQdAtEXKm@gmail.com>
In-Reply-To: <aThgIB2VQdAtEXKm@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Jan 2026 11:25:17 -0800
X-Gm-Features: AQt7F2rUFGsANbDKTWL3Oew_3JYCmSpI6CDFBThwnIOZz6lFUJRv6_wAwXsj54E
Message-ID: <CAP-5=fVf=Db9+9gxmfoRPDZvp_jz3bwG9FqLwAnKVHjaHbe4MQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat display: Make %f precision consistent
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 9:45=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
> * Ian Rogers <irogers@google.com> wrote:
>
> > Commit bc22de9bcdb2 ("perf stat: Display time in precision based on
> > std deviation") added multirun workload elapsed time. There was an
> > effort to make the precision in the output most useful for the user,
> > however, when gathering over runs it means the formatting varies. This
> > change just makes the output format fixed.
> >
> > Before:
> > ```
> > $ while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed=
; done
> >           0.101140 +- 0.000149 seconds time elapsed  ( +-  0.15% )
> >          0.1011396 +- 0.0000218 seconds time elapsed  ( +-  0.02% )
> >           0.101331 +- 0.000124 seconds time elapsed  ( +-  0.12% )
> > ^C
> > $ while :; do perf stat --null --repeat 3 sleep 1 2>&1 | grep elapsed; =
done
> >           1.001317 +- 0.000146 seconds time elapsed  ( +-  0.01% )
> >           1.001377 +- 0.000172 seconds time elapsed  ( +-  0.02% )
> >            1.00253 +- 0.00131 seconds time elapsed  ( +-  0.13% )
> > ```
> >
> > After:
> > ```
> > $ while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed=
; done
> >        0.101406408 +- 0.000064778 seconds time elapsed  ( +-  0.06% )
> >        0.101367315 +- 0.000027253 seconds time elapsed  ( +-  0.03% )
> >        0.101434164 +- 0.000084750 seconds time elapsed  ( +-  0.08% )
> > ^C
> > $ while :; do perf stat --null --repeat 3 sleep 1 2>&1 | grep elapsed; =
done
> >        1.001525467 +- 0.000051703 seconds time elapsed  ( +-  0.01% )
> >        1.001375093 +- 0.000116200 seconds time elapsed  ( +-  0.01% )
> >        1.001141025 +- 0.000046361 seconds time elapsed  ( +-  0.00% )
>
> Perfect, thank you!
>
> Tested-by: Ingo Molnar <mingo@kernel.org>

Ping.

Thanks,
Ian

>         Ingo
>
