Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8822126C
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097505; cv=none; b=iaNRMPyc9uD9ZAQRgxo4WUnDHdlDtaaNYxqW13eMDOgKXD2WJcaMdvlTCS4P8WwicxsXN7j3hN09amq4pWPIqvV3pCRaQ3jXp4/cRqLCMMQWYI28mpn5QOb/8ym5yZd5LAiEduvmfDZosF5+6gM98SVQlWoUZPG9or9dvGOQnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097505; c=relaxed/simple;
	bh=01CE7K4ho1r55YJJxScMbaBt5qLzuHA3R4MFUcguS6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfOHGd/b61zlyG8ttEmeXCavqooDcpA+at50zTK+B1GXW6yI7+EJvSQQkzsXPP76h5AtjlVIHU1yZLotNhaMSAibsSiQ7HSWszJoCiIn8ty0YFFL9N/dzjGws96JqDw7ao66d2kJaXpt9wurOd0chzLzOngpLRUN752ZK0ti8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9zOKqmu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9zOKqmu"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so27855ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097503; x=1752702303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01CE7K4ho1r55YJJxScMbaBt5qLzuHA3R4MFUcguS6Q=;
        b=e9zOKqmuxujH8ZRJY2hFqqVGnoQ9ruCzy5vQHAz94w+CuInpJWCxyROAdSoKvdSxWO
         KnDilMxnnLYYzsz4ipYSSwg4Cf9klV3bL2H46lZNz4hid2WCLYgbs5YcFX5rBwh+MmaT
         6RBWhF9a89n6dWRg+ZUeWvGVvrhXjGXLjyvuKjTaawbPOVxTe32iacljTBic+LuyvN55
         lrFdO7UCvCKDYxRDp3uYss1XHfvwKYWU45yke42LkWfQsnsrY4uPqI25FA8u+lR/1ISz
         mjAi+W/eaKUmEbQImxdXf8ZudJ1BoAvL+h8yOZcw0D4mzpMZudnpxkRn8NX+Ok0RuYwB
         hU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097503; x=1752702303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01CE7K4ho1r55YJJxScMbaBt5qLzuHA3R4MFUcguS6Q=;
        b=dBoRkEZ95I6AVxTgAVzWCtAd27tzV2xwzxqhq1NW47TaULCDTwXSNuZs95LW8A2rSs
         39yY/U9uOeACSHmbnc5vcU/PhguMVrhcOPLteZnFCtQDHUiACV/1B6wK7Bbo2rGL5dz4
         A7xcUCMLYmGd04RYKkV0Uab5GRSwjb4lp9ikEFPCLnPRMFBA33ni7tG5SbvV3NguK8rv
         WmWpUOkJAdGaMTjEITJjABx5pY57vtF8Getk7KPr293Kn+nhKI9vetVeWwvuyacjIwUV
         DVyY2QR6q+ljleSOMjqinT9G4IqFSH3IUiq6cQ5paZRqcZry4S52w+ehYUKgqvbWq63s
         iqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT92PldHbfLadsLH+tdeTKjR4xiqjIW/BqBf3qgAjDvS8PlATIy0GOW6ZgILUZe6HLjMyKsWKstlazeav+uw4z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1eDQn0V291iu9x5Ey5DttNJXl2CcZxKnluN0DgjZy42bcT8az
	RPZS0iXFzzoLQWrfarQJt+VROIDRU0imy7lWazzCIfIy9B6aHE3D0MSk545uazsaGTcO9fv3NzE
	RA94yC1yudoFv7ZIiRVfqR/Lj/SrGKk0Wc30/8jdw
X-Gm-Gg: ASbGncvLrUzO0sf7U4QW31J3PdiUxHEHrzlxGxtrF5CaXLdQJd5/HUnUSofq/cthhaB
	TvJRLnf5N7Jx52uAKvkhBqZCz5sckmYnc9RHe1mdJtARr/ILdeKiRb9Y/IFfR+6EXdqE4mJT500
	luIGCJyHAHbGrcxi8YIH69/l2absXqjuA6AodaBnNNZhzmZlqeKyMZfpDjcwG/Y/9qGzrXn5OOr
	g==
X-Google-Smtp-Source: AGHT+IGDvj8bx1fUmHxUSGQwiRfqgJ6KJHVT7FwiSP+jXeC2yBdD2wVOmYrSlzEzt+sNBRZD1B3BeFp1DsOQ9W/wMMU=
X-Received: by 2002:a05:6e02:190c:b0:3dc:866b:e8b5 with SMTP id
 e9e14a558f8ab-3e24511ba21mr1237475ab.16.1752097502734; Wed, 09 Jul 2025
 14:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605233934.1881839-1-blakejones@google.com>
 <20250605233934.1881839-5-blakejones@google.com> <CAP-5=fVX_Qohsf=f=-fR8mYsTq4zitURit2=4BYyD5HPJHOT7Q@mail.gmail.com>
 <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com>
In-Reply-To: <CAP_z_Cjuh9HJvcnsARaX-QUwDMbRPMDr9AtxbBxYUR_BTSzwCg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Jul 2025 14:44:51 -0700
X-Gm-Features: Ac12FXxX2i29FTlYpzGRKLDLjekPcUXfK3HNPeuDfy_kcrXMjcag4_NirKBxz6g
Message-ID: <CAP-5=fWuU8Xhzvjx8FgQpOJCJXewOw9S3Vdm+aXYgw64bsq0UA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf: add test for PERF_RECORD_BPF_METADATA collection
To: Blake Jones <blakejones@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
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

On Wed, Jul 9, 2025 at 2:08=E2=80=AFPM Blake Jones <blakejones@google.com> =
wrote:
>
> On Wed, Jul 9, 2025 at 2:02=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> > > +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> > > @@ -0,0 +1,76 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > The 2nd line in a shell test script is taken to be the name of the test=
, so
> > ```
> > $ perf test list 108
> > 108: SPDX-License-Identifier: GPL-2.0
> > ```
> >
> > > +#
> > > +# BPF metadata collection test.
> >
> > This should be on line 2 instead.
>
> Oof, that sure wasn't on my radar. Should I do a followup patch, or is
> it not worth bothering?

The patch has been in perf-tools-next for a few weeks:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3Dedf2cadf01e8f2620af25b337d15ebc584911b46
so modifying it is probably not a good idea (it'd need a forced push
and break people downstream). If you could send a follow up, that'd be
great just so that we have >1 person in the
author/reviewer/signed-off-by tag!

Thanks,
Ian
