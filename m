Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990161ADC7E
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Jan 2026 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812616; cv=pass; b=mDr21zlCHCXRyMQGsXunXts1p6UfCcsQ6KqKRQgNRaGIcQEsXPVvEfKNbxEuUgVmdofD2Tnev0QK/VOomqZPoZVcWWSFef4tVixsKnwuZ362/4ZHbaPArCO2xfD+V2ENBT9TFs1rvL9pAO5AdVkqx/QdGf/YHwRdZSsKhXxCm3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812616; c=relaxed/simple;
	bh=MdJgSkWEsc80S7P7Jv0cTZKwKh87nmjLU0pHsvl9IQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2EoyiyE4SicequGvLg1B7szzBNKLmlMrrNQ7fQkeVlnVshi5qOpyBmspT8ddAapl3X0FWV5aUUE0Ql4v699UyrUjtVg0Z5Ip2GZY0BvIzyo4vO1jNuMCPLc8KgYUmRtNhhFLM+qMYBe33ctQy420tUtoCS7QyRtiFNHCTclkm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BvRWqJ7t; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvRWqJ7t"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a1462573caso103685ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jan 2026 11:03:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767812614; cv=none;
        d=google.com; s=arc-20240605;
        b=gps1o4123hqKYnLOQPfw2q9iBCDrg23W8GSTYCHGE38IpccqSL+FfFluytp6QOFJtP
         Pilsp8QF2boRat8643m/7t9jBOadlaNdZo4Ds4VeXj8ZXo9g0Sxkwc4wPndrpYS9Lh4g
         xbA4tlroZhWWaavk7Nx7iqdAU7yFXEzJutOy8LsyTPhek/GnTm6wa31AYm7PnJD8ITIK
         mOq66FZbKKq0lbXqn3FQtAOCHrGjajUHxDUDQmlGrmHQnWUHUWKiY98IBQsoaGlaFJvn
         up686oTyKTAPPkJSH9ZsJ21KGeeBYIbp8+uznTDBPy8V74s1Nj7sLvrPuluxWU20ouD9
         jrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qeAd5FWj01OqV8k46UTAeYmspgB8Eb08sTlYpQT0qus=;
        fh=tkejBTSinT+7fiqdcij8bQ9JYPgVmZyqxpPnvB7hSig=;
        b=FlwWPbG6Az1d/YXePUIkNnWvxqn4Dg3jDOFaeRujZsLtZvmqGzOBHqRQMcK32pUgGT
         vloMPuDCprtJXku6hahaackCx2j2Lf8q8i17bAfyhN/23Al1FDGSfSc7dYHzULnMwJK6
         dCjqosGCGxH0fDbAMzT/lrZrunAhm/Cri1E+OnYG/NJY07necA0Clmfl3WNAeWmqGcUu
         RF6E2cYUbNheqOGVpqWMWzW8ghMWc4qq0bmCOtqT0VRpq+oGWcJQKSNbF6QYIPBtv/oe
         1Ls1amE+oJD8SahquNIPc5C0cbkBhFT81uUOzF1p6Z3YWV8xfiaWAYDpwdUzlfKpqUns
         dEIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767812614; x=1768417414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeAd5FWj01OqV8k46UTAeYmspgB8Eb08sTlYpQT0qus=;
        b=BvRWqJ7tS+rMrrVKi8gtBZwN9lD5o/bh+PHtcO3ugMwVHBUfseZKdjThxS5+ku29eK
         2CsA2UJnhpJ/sdFpITrKwlDI9pZc6Uyfa4MoAw/M750HpbGft3wkvZTShbsHMda3EM0a
         Re+2edgqJc6q4DrIfVGi5swgerOec++eE0peXvk6anN6cgGauVAHE6Aoav0xz0YwY4Hk
         XcDuceE3KHRP60hCkKpnTienqg4nY2aJiaFz76l6chdszjlf2btacdFIxqYCON18YUMf
         bLRSTg37+82GypoID9NywNsjgLXMclaeaMZ8DzPVqgNe5yCVTIrbhDCaYTeNNsZ1en7d
         Obgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767812614; x=1768417414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeAd5FWj01OqV8k46UTAeYmspgB8Eb08sTlYpQT0qus=;
        b=XUMejnC/1AzldDYel1mIEfRTCph03+X0naChSYZG+MZCE/ynTqjPXuWGHMAMp5X29e
         ByhJCbYeWbTM60q4jXLzurBSp3hrfXTZlWVDAmx8cxSfWtpjFx4FTTAYOo0mLIl/H8gd
         ShDxTN52qIwjJWFwSLZeyEnqRz60yjKsIdu5GX7oBDZxzvN/R9X8Rb2lCZ+hw2RWoXm6
         kL1X7xKyQI/x4UFE6x9IO17dJ2Q3AuMSwKrezMaqK6F+L885Vhc56HDzhiwV9BCHzRHu
         RnNCCIXqtls9uTPIJorJJhqiNdNgHcS0ls4DdiSIVLYPyPEuz71NJRAJxj0UY2bIq6do
         p7Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUf2+h9+hkuCeWuFrpPXLU3XwFJYt8TMnrdLsTzs7KF+DXNXzoi4rZNyzZW3+mDw5/WfNGSl7FSdP2ju8s4b/zL@vger.kernel.org
X-Gm-Message-State: AOJu0YykAsNn5niOIV2FinP7XC+on/qI0tfUizsiI3d6KJOE/zY2t2xP
	cDKerDQLOxAZ7lw96fRBl1waagPRpbV3nqCPB5Hpiaa1kun2Txi9RJYHyEazPn/kqDaOrb3rGrP
	6ByoZKMZpaJLxs7CfxTcSB9NRXu6lpiXw+rnEzywQ
X-Gm-Gg: AY/fxX4fHJok/bsQV+e1jKu27FPd+XFqj2kvnay+rAc5UWrkCEgzQe5jReuwtOG2wJv
	H5xWFLBHLw0AKk28pE2ZRDE72X0lcM8GMxjvQDCGhXhnoFG/4NhHt2iuollXYfDCFkwYUtga0Ll
	cTx1/+cd/CNyKXzZxSyiJy7C0WJMQYld57fIJhDhC8nAcM7FZuNmFGIJ3k0Gbd2rZy8qhj+qzbK
	uX0PB+pH82v3Y9RLGSeKERjFq+gO2ZKQ1rEa1KH1sg0C1QKvnw09z6Mo8K39+fcMobyU4PhZtSt
	QYLebqYW0YrTTR2QfWuvrZmC
X-Received: by 2002:a17:903:11c5:b0:290:dd42:eb5f with SMTP id
 d9443c01a7336-2a3edbc4be8mr3201985ad.12.1767812613449; Wed, 07 Jan 2026
 11:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104011738.475680-1-irogers@google.com> <aV4UZCCc2QOhdeSE@google.com>
In-Reply-To: <aV4UZCCc2QOhdeSE@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 7 Jan 2026 11:03:22 -0800
X-Gm-Features: AQt7F2pGhXEF0FJnAkQvXSuDbL_bVejkghuW-ZH_bvSrQxL2jA5XQk7nOPllw-g
Message-ID: <CAP-5=fV9J9PVBw3qCvNZkeNMCzJGPy4WgMDw-6ppCMgSOH1XpQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add procfs based memory and network tool events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 12:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Sat, Jan 03, 2026 at 05:17:36PM -0800, Ian Rogers wrote:
> > Add events for memory use and network activity based on data readily
> > available in /prod/pid/statm, /proc/pid/smaps_rollup and
> > /proc/pid/net/dev. For example the network usage of chrome processes
> > on a system may be gathered with:
> > ```
> > $ perf stat -e net_rx_bytes,net_rx_compressed,net_rx_drop,net_rx_errors=
,net_rx_fifo,net_rx_frame,net_rx_multicast,net_rx_packets,net_tx_bytes,net_=
tx_carrier,net_tx_colls,net_tx_compressed,net_tx_drop,net_tx_errors,net_tx_=
fifo,net_tx_packets -p $(pidof -d, chrome) -I 1000
> >      1.001023475                  0      net_rx_bytes
> >      1.001023475                  0      net_rx_compressed
> >      1.001023475         42,647,328      net_rx_drop
> >      1.001023475        463,069,152      net_rx_errors
> >      1.001023475                  0      net_rx_fifo
> >      1.001023475                  0      net_rx_frame
> >      1.001023475                  0      net_rx_multicast
> >      1.001023475    423,195,831,744      net_rx_packets
> >      1.001023475                  0      net_tx_bytes
> >      1.001023475                  0      net_tx_carrier
> >      1.001023475                  0      net_tx_colls
> >      1.001023475                  0      net_tx_compressed
> >      1.001023475                  0      net_tx_drop
> >      1.001023475                  0      net_tx_errors
> >      1.001023475                  0      net_tx_fifo
> >      1.001023475                  0      net_tx_packets
> > ```
>
> Interesting.

Thanks.

> >
> > As the events are in the tool_pmu they can be used in metrics. The
> > json descriptions they are exposed in `perf list` and the events can
> > be seen in the python ilist application.
> >
> > Note, if a process terminates then the count reading returns an error
> > and this can expose what appear to be latent bugs in the aggregation
> > and display code.
>
> How do you handle system-wide mode and sampling (perf record)?

So tool events don't support `perf record` and fail at opening due to
the invalid PMU type and config. This is the same as if you did `perf
record -e duration_time` with a perf today, which looks like:
```
$ perf record -e duration_time -a sleep 1
Error:
Failure to open event 'duration_time' on PMU 'tool' which will be removed.
No fallback found for 'duration_time' for error 0
Error:
Failure to open any events for recording.
```

For system-wide the behavior is hopefully intuitive in that the memory
and network counts are for the whole system rather than the given
processes. For the memory events the proc directory is scanned and all
processes counts aggregated. For network data /proc/net/dev is read
rather than /proc/pid/net/dev. There is more detail in the individual
commit messages on this.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Ian Rogers (2):
> >   perf tool_pmu: Add memory events
> >   perf tool_pmu: Add network events
> >
> >  tools/perf/builtin-stat.c                     |  10 +-
> >  .../pmu-events/arch/common/common/tool.json   | 266 ++++++++-
> >  tools/perf/pmu-events/empty-pmu-events.c      | 312 +++++++----
> >  tools/perf/util/tool_pmu.c                    | 514 +++++++++++++++++-
> >  tools/perf/util/tool_pmu.h                    |  44 ++
> >  5 files changed, 1026 insertions(+), 120 deletions(-)
> >
> > --
> > 2.52.0.351.gbe84eed79e-goog
> >
