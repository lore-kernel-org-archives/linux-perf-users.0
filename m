Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA02206948
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914152; cv=none; b=XIzAR11kfjoWVbKyDa/fUXKCCO1umFsxOHzudDmRcCvmMGBW7rrpXDvApg8gqX1BLcQgdB/0t6V7XcKOyga6+wdubISV1QuQ096+28LA8xR5TIIzoec7rDOeY4SyKyRBa16gUQy41IBbL3bRLXrrnJ7E5WxFKo/jKv4vqvlhDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914152; c=relaxed/simple;
	bh=Js4xf9bjePQ7YFFhaBShMODMGHdgaF7gn0ytc8NoTvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM2l+tcCU9LKMfnDSJvmb9+7DkSjWCPJTM85F4hAEUeHIXiFfEgVbFqlCoHm8CjjbwCHFq0dDzMbneKpqHuEy9XedB6XwEX58iIhzVrRLClIqMYqR23Rp65Aaevm3kuuSbjzQ9RX650C6bYLY29jN7qkMNDfl2kpQUmZFVKbNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5i8jk1K; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5i8jk1K"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso297095ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730914150; x=1731518950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teDWCAC+SsPNKfZDGmf1mQnLJlQp1SAmCbKNEmulZa0=;
        b=i5i8jk1KOE3ZFT2oeFwXEueaa+4bEuyvxjTPA6huD7weWGn3ueBRDDCMojW8+6F4uO
         ghF1tMBRcCuowIrI5eaY0Ww3+Z4kpYl6RDiTu/gJCaC/LhIMy+tr3qMBPDuKYWuU2LyI
         JlyhiTPvnBu8e4zbHL5UyagmT5w1mXboxqDUjIOlVqp70Y5mtx/yl1WA1AT50zXw31bd
         5hieoD5Pj7/Ft6vi5YXAjJbdbz8JpSta+Zxy+ZM8RZGUElZAcrBLNFB2Gor4TmK7W+Ap
         TDs8L5ntQTO6tFcDCrPlLrtoXVhkPTWDPWsRgH0vCB2EJTo9ggvVq/Jd+ZOvKiu3g1fl
         j6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730914150; x=1731518950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teDWCAC+SsPNKfZDGmf1mQnLJlQp1SAmCbKNEmulZa0=;
        b=eftnmFwftaigHgvb8s3iDvHFIve6HAJ3pS5oiN/cUOaY4kXCgZcs3vi4thrwWboD45
         5W4ePmbIZihMFRK1TeYex7ASWE2EickcZo3smcVtMGUowpY5XkC2JHBrJe3MVywOhxOZ
         +/7ZGxu82Ch+3FwgEaru1DnN8VTzVHJUn+pl3HKpgborU4q2UCv2hbDfMwE3vmEc+lDw
         EDt/snww+/IedsQxk8xc31jRvt+GqdHEcExgAQE1uJ0RDybXx8TGYaQTxtLZM+Oovx8t
         6pvI0JQ5QqLlKVO4WNxPG7oOM2Rk+lAZdaXFkuNCCnVKlNGM4jj1atLBiCriBfC0RAOW
         cfIg==
X-Forwarded-Encrypted: i=1; AJvYcCU+s/ZWUsrNX822IGjMfO1/mVCQPHuS4X/nu0wmtjmfFWfbmI+lFweke3Vq50AMschSxvy7sbmUxdpfAIg5O2vo@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJflVWDqdvJlCI+wj97cnAyey8N/1+bRt1PZZr4YOsahyATXy
	uMcaewGifTPKdjt5LqehwuSud0bHGw8+kEuBpgYi8NXdATCiWIr9cgz6valOql0YPDxfRsFq2wa
	TJLrcs1AOsQFGWM/2ey08cfPyHZEaGgiI6SHk
X-Gm-Gg: ASbGncvFHsKxxV6ffp/JR5RxEwCLuWrxvhWvS4dljo0CGFN+tjBQP76fU4wlUVRcJWZ
	TWZetZ3Sx5akzgQE/mw4sYG4xtHMcl4pMmQEg8rMuatGF0WzvH9slaFgh79n61Ro=
X-Google-Smtp-Source: AGHT+IH+pqRdAphMkhb+luRB44r6bMNk9ISZ0EBRdYi0HWpiCxWijfTal5pLT+eibz9N193imWzcDdOEn3SXagF4YGA=
X-Received: by 2002:a05:6e02:1c29:b0:3a0:a224:eb2c with SMTP id
 e9e14a558f8ab-3a6e7a6de76mr736005ab.25.1730914150297; Wed, 06 Nov 2024
 09:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022174838.449862-1-irogers@google.com> <20241022174838.449862-2-irogers@google.com>
 <ZxmHOkp1USQCujM-@google.com>
In-Reply-To: <ZxmHOkp1USQCujM-@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Nov 2024 09:28:58 -0800
Message-ID: <CAP-5=fXTiHY6-Tb5kLGxQq7MGmW_qQpM9ZYV3Oaz=hyfw0sxYg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf test: Skip annotate test for sanitizer builds
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:31=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Oct 22, 2024 at 10:48:38AM -0700, Ian Rogers wrote:
> > Symbols vary and the test breaks.
> >
> > Closes: https://lore.kernel.org/lkml/CAP-5=3DfU04PAN4T=3D7KuHA4h+po=3Do=
Ty+6Nbee-Gvx9hCsEf2Lh0w@mail.gmail.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/annotate.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shel=
l/annotate.sh
> > index 1590a37363de..199f547e656d 100755
> > --- a/tools/perf/tests/shell/annotate.sh
> > +++ b/tools/perf/tests/shell/annotate.sh
> > @@ -4,6 +4,12 @@
> >
> >  set -e
> >
> > +if perf check feature -q sanitizer
> > +then
> > +  echo "Skip test with sanitizers due to differing assembly code"
>
> I don't think it's because of different assembly code.
> It should be the return value from ASAN leak detector.
>
> Maybe we can enable it using "ASAN_OPTIONS=3Ddetect_leaks=3D0"?
> Probably with a comment that mentions we don't call
> perf_session__delete() in perf annotate for a performance reason.

So doing things like not deleting things for performance reasons is
okay but should be guarded by an "#ifndef NDEBUG" or worse case
"#ifndef LEAK_SANITIZER", not always be on. The comment about a
performance optimization belongs there. We should be trying to avoid
disabling sanitizers in tests as otherwise we're missing the benefits
of sanitizers. I'll see if doing this can to avoid the test skipping.
It'd be nice if other people tested with sanitizers. I think we still
want the features for if we get other issues in the future.

Thanks,
Ian
