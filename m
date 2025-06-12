Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633285258
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688763; cv=none; b=MqMFv8TL1dfX5ZTN+DnMAJFhZ9ujGHsFeKYzGFspDVgj9GMiNLNQaQqrUv/7x/dtR2YWeGVyo2H2fv1tfYbxEhDrsI5VVuJyIJpjiNtvOcYvzUSv33NPYRxbY97IPzCHmB6T3SMljn6APeUFxafYu59HgTqOyJvfj+hDrss5jUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688763; c=relaxed/simple;
	bh=1/YtnVp2w5cLp0fXiP/AkynA4GjML3bPzu3yfR14Y34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8auiEHtwx0R3fN24F0kuy15Rp4uwLtSoYCmpW4FvvnBsDvAx7KaQbtMlWU4xauw5tlSvDmGgrp5flIKCIXAitXUln2l2VAx8+Iu7Ny3nQfb77RYBx2lblZp2GyE5kSwOA8JodMZTxlApFckBa5JSDahtSJFD2C6Dn+hmRE1wFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnG9Eito; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnG9Eito"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e7949d9753so119598137.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 17:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749688760; x=1750293560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MijS6fKI8avgozeUh7V7g+wjXCdFSSFspwam+Jh7L04=;
        b=AnG9EitoIjCACvlxjPoy7H/3x22cSvo+/Tu4hMhTJCOPYGAhirEnle10JkT/BHEXJc
         9ZL4vufBbE4zVP5ThJIyg8pjEbVa9roiLzwael+phWD3wMQIgctGYLnUX04kdwxZB6rh
         8KtpXjqtN/hw1YSaz0tVIZh5EzGAuRd59bBTw8HGsRUxwNcqLEygtA076T988oiUfMvj
         8JI6U15UazpbG9/kjDpIQbf8zdh56Zo4i9i0XbWZOpU/rF5ZFyPPyAjOYai6Wgi09U/H
         rG8w7ejZ24qM+pi3gw8OmYttKZiM+DUpNfJyWdw/lfKA9wW0gyAttKPqi91bEZY1lfO4
         WQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749688760; x=1750293560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MijS6fKI8avgozeUh7V7g+wjXCdFSSFspwam+Jh7L04=;
        b=cjpPbpOeE/7dBOMyVu0OmhVRJtdFDrqTCXBZMtAun+YEkPB4ZfxR8F17/gImTJyyVL
         Ya4Hljyvaf5S4dMG8/5tTLDmUHzy8O6grfupPyjlY8Kc84VNLHEt5zwx0ASD4i2rbIr+
         6csdLvkzumi8d/ClZPokzclYd42bzQtPe03d6RBFZqIbItAiYQviEMYeuv/2FXN7btFP
         jZxPjKSChga4cuAFtch7HqM9nedmtUVwaDfsd8B2nYgt2ZUop3V3ecajTlmm6KWWKHZ2
         zBs/mJlOtM88XBXTEtn5aW7K9khjIxz2lDxyLtgDEzZvZ83YAxhGvaa1NyGci16B3mFd
         WuMg==
X-Forwarded-Encrypted: i=1; AJvYcCXpi6VFFPNkIE0yCsiVt7CNkdITrSuONYjKx7TtVVGuf4ReTTvSYF+Bm1Ff2w53F59akvUZh1T4RxHjjjtnx/xR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/UKxduqBahhNBMDESNc2lIIjEbWrhpCXu1FAjoZ2Ul67gNAx
	Dplw7gmWEVv/OKvZB4Yg1TXDkdjFG9WE2lHTFN9cXK9MSfZYU3kNRiIBD5l0sC1CqjlbH+Zmujy
	xgXLrsCLKGuXY3rv+1J8/omQ8dIWBSRmNluAwp0cq
X-Gm-Gg: ASbGncv9hE9TIs8bNAaIDkmaZ95+lB+yqu6PWuOna5wM8AfJ3uO1MH9+DoIQxtYLk4f
	UUpKvibD6EyMyeav2QtavLc1WHKrXt7V9pb9OHCu/NagpA6HlSTZB6KDeOl7mtupkwHI59UZwkw
	vFO0ISZUA4vbmIqjDs4/eBCMykMSxVzrvin5OOZj9ZWic=
X-Google-Smtp-Source: AGHT+IGJyR0TkHrxu2ca510smf27CLRnlR33XS+KipMFozqKN/NJ2jtkGZyOWX8gVxAfHrBxFp4dlDR5VA1QBQu8htA=
X-Received: by 2002:a05:6102:510e:b0:4e5:acea:2dec with SMTP id
 ada2fe7eead31-4e7ccb90176mr2182302137.7.1749688760064; Wed, 11 Jun 2025
 17:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com> <aEnLBgCTuuZjeakP@google.com>
In-Reply-To: <aEnLBgCTuuZjeakP@google.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 11 Jun 2025 17:39:09 -0700
X-Gm-Features: AX0GCFtvh8DDYNH81d0g8swylgEtR-w4SutaqGqiWCk_py3r2whgK08XDdIBGYk
Message-ID: <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf: generate events for BPF metadata
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Wed, Jun 11, 2025 at 11:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> I tried to process your patches but it failed to build like below:
> [...]
> Please run 'make build-test' and send v4.

Very sorry about that. I've fixed the two issues you noticed, as well as
one additional one where I was using the wrong include path to check for
the presence of the libbpf-strings feature.

I'm trying to test my fixes using "make build-test", but it's proving a bit
of a challenge. I installed libgtk-4-dev, binutils-dev, and libopencsd-dev
to fix build problems as they came up; I also installed libtraceevent-dev,
but somehow it still wasn't detected by the build process and so I had to
use NO_LIBTRACEEVENT=3D1.

Even after installing these libraries, I'm still hitting errors when doing
"make build-test" on a copy of the perf source *without* my changes:

    In file included from util/disasm_bpf.c:18:
    .../tools/include/tools/dis-asm-compat.h:10:6:
        error: redeclaration of 'enum disassembler_style'
       10 | enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
          |      ^~~~~~~~~~~~~~~~~~
    In file included from util/disasm_bpf.c:15:
    /usr/include/dis-asm.h:53:6: note: originally defined here
       53 | enum disassembler_style
          |      ^~~~~~~~~~~~~~~~~~

I noticed that tools/perf/BUILD_TEST_FEATURE_DUMP has
"feature-disassembler-four-args=3D0" and "feature-disassembler-init-styled=
=3D0"
as of when this failed, which seems to be upstream of the observed failure
(the version of binutils-dev that I installed seems to have newer-style
versions of these interfaces).

Is there anything written up about how to set up a machine so that
"make build-test" works reliably?

Thanks.

Blake
