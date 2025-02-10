Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855A25B690
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211337; cv=none; b=c11id3sPWmhldJif57Mcdvnpx8X4ibAhgbBDV9FBUHi5yauh1qGouIzkUv30Qth56tFJW+bcqvlgPveSDXb3GEcmwk6wO4fznO+dlZX5sMxmnjLUGeuSNCCZ2xp9PSYqddXKmFJne6exwINFwokCnNL8CjjxC2fzgsiPAGscVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211337; c=relaxed/simple;
	bh=F/96u3NNUqcuJXiA7GkTj1P26oKp/ehSs1cHwi+YUpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CabbzZcVQRWgZJL/uREiGeoXGDXnXdmtlJnCmBeEbX3NhqiQ4ZaieLM+zkx+6Et7XC0joNO8xviO5shZylQbIibsGGITjv4QErDTQzxf/giADvTgNBkoTHQXRmpaXIhI7rBcVCIgr8FZKz60gEmY2Vt6HurV16+dXAvngXGiwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmeR/8ER; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmeR/8ER"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so4455ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Feb 2025 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739211334; x=1739816134; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/96u3NNUqcuJXiA7GkTj1P26oKp/ehSs1cHwi+YUpQ=;
        b=pmeR/8ER749MZTx+mv1b12fDjHywZeCu2UIoaitmxneNn+0E6ynhJ0E/tQrOtUQhB9
         sQ9K4ETKqIudKku4px98vqLA08D6yi+IfsYVjVpoWLh4pzaeMrbOkks7IAiaaTOGopOm
         O1e3Yh+wYuFT0n6xsc55THEExY2ug9TJwpxpGBO/Xu/OSv5Ma5Wi6pj/qGZxioRToXgv
         VuNPlwQcL7Pzph3sRTu0HqSq+mUIVj8IdmHEjHV88xqkQXEuLQyPqTEmlAyWapMtK2Aq
         dZcIxShTl0J+no9PyUXfCT5KWlvkz+16PGC6N3G/rlJPWDuUc2mNSO+uuX5wdAP7TrPC
         EAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211334; x=1739816134;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/96u3NNUqcuJXiA7GkTj1P26oKp/ehSs1cHwi+YUpQ=;
        b=ogxuPDHilAY+XN0AsGkalypPN5oh1AbqJKDYDZS1WqeZ+WwPbMQviukt7RTwwrweUH
         6oYCBUmBq8sYMLVbKA+ILIC2WjI/Qe2umiN74Va84XSENekpeRb2qkw5URhV8xhWiPkL
         8tNMRSB84o2nIM8C3rBDg86eWoed2G892j2PlCdOgvvmTmboAtjaO+79E1RQ/00711Qg
         qS7MlbHuZ1UgAeXel3gUlo8qwPzFFNAqN5TtWsTYnIt+ozaG+nU+v1vpPNKP3BD9LoTt
         XahLqhsQgNUqsm7vJeMkwiTNiJxnXLKt+nYzxOxhP46651J0/3xsVH+S5yg8rCarRnDq
         4Rhg==
X-Forwarded-Encrypted: i=1; AJvYcCVEMuxi7cStj7oGIPPZ/1ISoRGc01/saMjFm/ZwzbYKVGN1MjrYqpW7zb/FCJgu2IN7z3QsMWlw8ecW4zerIFh7@vger.kernel.org
X-Gm-Message-State: AOJu0YyeyOIbEQWQLKGHvXiK7/gek7110KM+hL1zR81JEreH3R+49GqT
	G9AhOqAyRX2dhteD5uJYR/H/poEvS566OaZ+PkGrneqQUIOqofBl5vJt+Iu1Hv8oDMeV8h/RhxE
	OuFYT3Wd0DQrL/T8A1qyTFUGLZYwKxOdMjROo
X-Gm-Gg: ASbGncuniGQd8MlNuzSM42G6r5wT6vp1FLfoJnOkPCZQudcd1DhWjWtXdzWrexJRmqR
	OQeNksrJDdfDO3n9wGk72COqbkJYG/2zF2HdgNwn9q4ZJMlmvW1zBEvXdt338DsllIqWnb3sIFm
	EeVsz7LnXB1GxPM3dp5ikaK60A
X-Google-Smtp-Source: AGHT+IFqTvA0kT0d8/s2/LY0/DyAghSw5k4WybfSH3hPb2dd+fkXBPi3nvvKEIQesGbSUsmWCmzVLcTwx/r2AwSYTGI=
X-Received: by 2002:a05:6e02:12ea:b0:3a7:dcc1:9936 with SMTP id
 e9e14a558f8ab-3d14f0f576amr7064045ab.23.1739211333209; Mon, 10 Feb 2025
 10:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113194345.1537821-1-irogers@google.com>
In-Reply-To: <20250113194345.1537821-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 10:15:22 -0800
X-Gm-Features: AWEUYZn7d4ZEktR9aWJ_xgpCMfHw12KnOcZgrjIapk5zbV_Lb74ntXY_p46rN_Y
Message-ID: <CAP-5=fVoQRhd-8jyXfjc2dCuwt7_o1sU208aADT1FriwCNa9qw@mail.gmail.com>
Subject: Re: [PATCH v1] perf sample: Make user_regs and intr_regs optional
To: Tavian Barnes <tavianator@tavianator.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Charlie Jenkins <charlie@rivosinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Michael Petlan <mpetlan@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 11:43=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> The struct dump_regs contains 512 bytes of cache_regs, meaning the two
> values in perf_sample contribute 1088 bytes of its total 1384 bytes
> size. Initializing this much memory has a cost reported by Tavian
> Barnes <tavianator@tavianator.com> as about 2.5% when running `perf
> script --itrace=3Di0`:
> https://lore.kernel.org/lkml/d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.173=
6618095.git.tavianator@tavianator.com/
>
> Adrian Hunter <adrian.hunter@intel.com> replied that the zero
> initialization was necessary and couldn't simply be removed.
>
> This patch aims to strike a middle ground of still zeroing the
> perf_sample, but removing 79% of its size by make user_regs and
> intr_regs optional pointers to zalloc-ed memory. To support the
> allocation accessors are created for user_regs and intr_regs. To
> support correct cleanup perf_sample__init and perf_sample__exit
> functions are created and added throughout the code base.

Ping. Given the memory savings and performance wins it would be nice
to see this land. Andi Kleen commented on doing a reimplementation,
which is fine but out-of-scope of what I'm doing here.

Thanks,
Ian
