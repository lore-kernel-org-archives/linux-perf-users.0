Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E6212B06
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376904; cv=none; b=KEcjcl3omGa++cDZ1xqiBWNqo7LsDdPCixFc5X7MCjW2ONjh/UMT5x2zFjcK3IbAvsAP35ESxSUlnSxuK3EoEKtsFoXWekTImlXRNB+rZRIXEy5zvTvlCmEicsDnI+66snEiejfpGLQDA09nRShKKzjQxYIvWmVCsuucSJa2N40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376904; c=relaxed/simple;
	bh=MDqrHIfZj6e7W+JxWMoVUShv7t5v0ULvbo+g0V4L/8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uayIUcMd7ej76JRkDEsxucX1KW74vIRlGV8lKiDcnR0HQ5h+zdSodgg9HySqxo9dpDS5ZkrmzBsxG7uj3orG31bqc3uRKUtGZsZJNceC24D6g6uTtM9GuPoMEw92wwGrAYno5BzkZAhorVYnhOPZjr5HgYEriosQSYcSNegbBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDpDGyPn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDpDGyPn"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so172555ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739376900; x=1739981700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wwnDpSs6k4nd6H907qUqxRrSXuSL7kW89rp9oZHglM=;
        b=xDpDGyPnLGU/0evWCuiehK2YnX7FdmgLUvwoPTxhUM7CtsdEIEKcC2AY9a6vEcyGgI
         Y2CyWYQmZusUT9acLqGjU9rARMgDqMJZzDCTRYlYf/XeX6nOTECL0/w8dp0d/BF5YKzs
         kScPSRiqp33ccdbtZRro+ZBRCC8Secesx49wCMLGwxzJapEME9iWf1b81Mdal/ZNQ+kd
         ofa8h1UVSUn6n6g9H35dpsf/Rq6ICX5lsiG6EZUL9gS3ZPEfZNmmu58IuQDhrIJhcDmX
         EV14ZkJ2v6CFeaBwA1icBL8IKHGkAc2u/n+ZXswjr6PQ20oT3G0pUz+gjTUELRfgDV45
         S7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739376900; x=1739981700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wwnDpSs6k4nd6H907qUqxRrSXuSL7kW89rp9oZHglM=;
        b=MoVdegyDDtb9IXne4LCmKihr0BYe5PkvdMBBBhDOn80gbltK6vSdu2oOtf4LYZaY1a
         HjP6bZ9fGmRGhPsIW0WO8QLO9k/XIwcokj863E3pFdHpqrIu0O3R/6HLFF/X2EFDCs3X
         wWmICSHkUSxiesF1KC3DFAOLSEuDM9ia1FAN52IpWq7gFhM7lKKzpxrh6wRPmW1HHrsF
         lxPGMCpGNyE3ZgXSsIDoN7wAH1iCQlqWlFEIP8wUtSWH2p+EefZpUJYEWgv0O2d++EpF
         E12m/Te5vUo/kmu5DsKE6gyJ82gx8Xf/ydm2Tj+uiTqI7i48VEOYm7pPgxqK9dgM97Uf
         6mCw==
X-Forwarded-Encrypted: i=1; AJvYcCX9PWTrjGCwNMBwAwKKFbIqclwYkbhJdEEx4WnJSSC1gkZQZHJKmp0WSjMUBo1u5FOO2uR0GTpGPS84/1QKSFPk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4mODLmIsJEeNhj8R3d1id8Cbe0eTZ+wAsFDlz+0qWzZ1nWWL
	7xgEacAb6arVxCMjjcdt3llvYHj1urx4o6oF/Gx9eefVZxrqU3tuU5UsRyZzKE671t8aVG33D5Z
	lPOGOSx0VQUGU97TdyYTL8za0Zxtda45PIxGO
X-Gm-Gg: ASbGncuZTxm2+JLGS1xlgWI/hFqn0oN3HJboiM6nloSN7F+hv9O4Z7Kphsp894qcW1B
	j7jNyO9VAQHaRmc2fRa6lBEESZwtUZH7SsvTN3nlDi1FMnYjJNuyn6aouMeiuGE6NjPhEA6wc1K
	vwAzTl/fBinjs8EXfeVIWzBgVp
X-Google-Smtp-Source: AGHT+IFViHLwQLmi2S4fRUAHfeLMmKJzllXKVBj5UiLdy2wf7Yhu89RSuIkkeynjo+yeyKpP8rOlVPse9pvCr3q/7BU=
X-Received: by 2002:a92:cd8c:0:b0:3d0:bd4:e46e with SMTP id
 e9e14a558f8ab-3d17cdf7875mr3578465ab.22.1739376900297; Wed, 12 Feb 2025
 08:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205121555.180606-1-leo.yan@arm.com> <CAP-5=fUH6X2F5S5eH+iU+-hT0vNvMKPTqbGt=E9W06sG=MzxEg@mail.gmail.com>
 <20250212085439.GA235556@e132581.arm.com>
In-Reply-To: <20250212085439.GA235556@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 08:14:48 -0800
X-Gm-Features: AWEUYZmSFu5F2ImV4w6AzGF-ggSlE124u-8a9PvKBUylFvr5MdJbF2XYRhCN5Y4
Message-ID: <CAP-5=fX6veqJYbTRfOiOqtpg8Dq+m3nZJRd4zEBCZeNiwB5Xpw@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] perf script: Refactor branch flags for Arm SPE
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Graham Woodward <graham.woodward@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:54=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Ian,
>
> On Tue, Feb 11, 2025 at 02:34:46PM -0800, Ian Rogers wrote:
> > On Wed, Feb 5, 2025 at 4:16=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
> > >
> > > This patch series refactors branch flags for support Arm SPE.  The pa=
tch
> > > set is divided into two parts, the first part is for refactoring comm=
on
> > > code and the second part is for enabling Arm SPE.
>
> [...]
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Built and tested (on x86). A little strange patch 5 adds a new bit not
> > at the end, but "Sample parsing" test wasn't broken so looks like it
> > is good. I was surprised the use of value in the union:
> > ```
> > struct branch_flags {
> > union {
> > u64 value;
> > struct {
> > u64 mispred:1;
> > u64 predicted:1;
> > ...
> > ```
> > didn't get broken. Perhaps there's an opportunity for additional tests.
>
> If the branch stack's flag sticks to a hardware format, then the patch 5
> is concerned.  My understanding is the branch flag is a synthesized
> value (see intel_pt_lbr_flags() for x86).  So it is fine for rearrange
> the bit layout.
>
> The "Sample parsing" test is for big/little endian test, it does not
> test for specific bit ordering, this is why the test passes.
>
> If you think it is safer to move the new added bit at the tail of the
> bit definitions (just before the 'reserved' field), I can send a new
> version for this.  Please let me know your preference.

I think it is fine as is. I was worried that because the bit fields
are checked here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/sample-parsing.c?h=3Dperf-tools-next#n35
```
/*
 * Hardcode the expected values for branch_entry flags.
 * These are based on the input value (213) specified
 * in branch_stack variable.
 */
#define BS_EXPECTED_BE 0xa000d00000000000
#define BS_EXPECTED_LE 0x1aa00000000
```
that the adjustment would break it. But I ran the test and it passed :-)

Thanks,
Ian

> Thanks for review and test!
>
> Leo
