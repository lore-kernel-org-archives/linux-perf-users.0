Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087417B4E6
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765842; cv=none; b=hKuFhaeIW7AbmFGPXoSpxfRH5HDOWcYCmy5S6A6gVvKV0AjIVaFCBhow7O6GXsop3Ps7F3s/o0JvRhnPjWezzwSfbuEo/4oh1XYGMuadcn8B/L78nETjLW3QK2dqsqlXufGgRWTagjdekaGWwmU9Q4UBkt6hHcA9JGYuRh0z93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765842; c=relaxed/simple;
	bh=z6IKR3JAhKYZVwCJuBfAEGi31YQCyS3o5wJrNYaVLZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hupD1RZkezmAE6UZgE3uwuTdWAU3jhL3y1aXSjNsu+dqTTRCm7mEvi16YO1mygKVTiLejbcVpvflNmXSKH+ZVPig38dgwXY7EieSiZUcuIADMlgHJ9d90GpQYzrNnTAv+lUcseKwcY6aVaCJd5VBCe1l3mFl+3eR7+F5JMo4t0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmb7HOSC; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmb7HOSC"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a3a4c9d11so174845ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712765836; x=1713370636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S59M5ErJ4ghJIk0WuQtKw5Oah+bXQHt5R+GLddM1KKg=;
        b=dmb7HOSCx0aOaxYV/MYcS7ebcCA2nJ6wfPnfA29+V0tO7yUB6hGVEUq/lQJJf4fH8F
         7NhnoEhDs/HZjML4Xx/G3qDa9C+PhO8OnkgtKnrHiatAgWTGtnL2KK/Q3lJ4JeFigltA
         rnUDPjHIFmxJ+9qY7qdxerxPGlfCG3SUGTdEhQ/sgy//elfQQFQPkzU/MhjbqiC888xQ
         hzvQFEG2B7/3l7CwdSYkacIRHYLszG0F2FPGWXA1j76JWMsjozffKf8jMvIiuUOMovyr
         DlNC8DA6YSddrBGBVn+V6rQgsMppY/YSEKMHcfn2Qn6Eu29etcm+sxbRgoFLjU/6Istf
         Uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712765836; x=1713370636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S59M5ErJ4ghJIk0WuQtKw5Oah+bXQHt5R+GLddM1KKg=;
        b=Y9JNe2ui1+QlxwvJJ0GZ8pfWaFuAjXRIkH8+Z3bzXmLEbRyKZ1ENZmnblrXyXw7UiF
         ATJVEmg2pX/p1hgJG/XcFyHuZfpFDz+eYKj+VHLS6ETUJZRAzR6wqTagE/Ea9BJ9tqfQ
         xK7jAxFjF8ZiejXUkn2kp47di8Mk5RfhMS3Yq2sUcL1Kt42kuIFRiRE+5pfai2Y/NsnE
         01UVRGNUyySQBgGrjm2vn8n+XgHxL0o6XRYqhiPf4i741YvAWEog0YZ9w59mgQUPYx5D
         SRRlX/JN715MoRckdFDgS/l5Iv1IBcjAsljsjmm8JL9zFC8qrVPVuBOQbPcW9Og0BM69
         l0Sw==
X-Gm-Message-State: AOJu0YzArhae1W38UcZjxuTaKnBR7Er2S1po6gkLkg7Ai/QmefH7Q7pU
	XdAAdCXBpmtVz7zP7lXXYwv1HDVikxL7bjLhyZH4G8zaFRiYa7J578mnrsibiKEhSzFNe1j+Ddc
	3BFNBx58fo2bPejP1kcIQSXx/NeP0zj+Utyut
X-Google-Smtp-Source: AGHT+IFSvH09coKrJ0WxqpOywmBxAI87YC290XDstCLKVDm1m1WDtulWPdOHHiub4CKMpx0EF/LCtFf+rgqg4r4N370=
X-Received: by 2002:a05:6e02:ee3:b0:36a:3d5f:e269 with SMTP id
 j3-20020a056e020ee300b0036a3d5fe269mr131406ilk.13.1712765835647; Wed, 10 Apr
 2024 09:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410103458.813656-1-james.clark@arm.com>
In-Reply-To: <20240410103458.813656-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Apr 2024 09:17:04 -0700
Message-ID: <CAP-5=fVgf3cOgbV1KGGLd5gykxT+BzuX1=XUsp+2BNUahGn6QQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf test: "object code reading" test fixes
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Spoorthy S <spoorts2@in.ibm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 3:35=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> A few fixes around the object code reading test. The first patch
> appears to be unrelated, but in this case the data symbol test is
> broken on Arm N1 by the second commit.
>
> Changes since V1:
>   * Put data symbol test fix first so that bisecting still works on N1
>   * Instead of skipping "test data symbol" on N1, add some noise into
>     the loop.
>   * Add a commit to replace the only usage of lscpu in the tests with
>     uname
>
> James Clark (4):
>   perf tests: Make "test data symbol" more robust on Neoverse N1
>   perf tests: Apply attributes to all events in object code reading test
>   perf map: Remove kernel map before updating start and end addresses
>   perf tests: Remove dependency on lscpu

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/tests/code-reading.c                 | 10 +++++-----
>  tools/perf/tests/shell/test_arm_callgraph_fp.sh |  4 +++-
>  tools/perf/tests/workloads/datasym.c            | 16 ++++++++++++++++
>  tools/perf/util/machine.c                       |  2 +-
>  4 files changed, 25 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>
