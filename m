Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895837F8A1
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241316; cv=pass; b=fq536MSjLsjI6yb37tF71U2AHKdhV39QKBILNiNDUGRrFfhoGvMH/XWT3RGfkuE3PUHZjPClfErSKGYdcWQiZhaeMeN8pEmj+/sgFsR6SpSDh5pMQ2KenfiBnv4b/qod4X2SB3b6UgVtnMWJiuIaMHwJr4RIC570aom+ZRtCIug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241316; c=relaxed/simple;
	bh=Aa5KRI7xImF7/q4fgv11ykaKQrocJfxJ9H2yRB45Ub0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAHdoVa7hRJ9m/BfnYt89GvhxAYmhVJIyVqwXIJmfbUK+LnmO9IGT0zmlxOV+TSe9DYCLB4ldJyfInX4wL+5IkNSK2h2B6j60oF7/qc5EZKxgZzsdIKJbi63GLr+lrz7v6ntNEmBXpn8dnML0iKFgszUxHFQ3jG4Nz0/oxS5WGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Y5WE1tB; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Y5WE1tB"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-121adc0f1e5so448c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 10:08:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768241314; cv=none;
        d=google.com; s=arc-20240605;
        b=DogvtjUwZlY6EM75jrNRgPv2uNRC0kjEkzj7ymZY3ml+SemYO4mAw/T0j2UAxx2rze
         Agn78ejvmjtxhhpcwJ4GXboBxloGYTm0fwZ7aGpTjlMO8bZ1BQmM9K6Kl9KQD3osoj+V
         zgePb2tlN5u4VAJJRjNsgMp/Zu7nUMgOTxzbX9PWry9/WWbOgjOHya01DDDEseRdoyR3
         a8r2zoipGTw4sr9bHz6F8qu08Y/4xipcjCi4zjscIv/mEwsxsUBDLVQPQrfdfvWrHUQ9
         F3qg+ga4kFW3QQh7z43AiYOS/Hc0cSHW7rnHbjBqlkYMFnuwC46ilFO3C0zRDlZBHYEC
         jg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aa5KRI7xImF7/q4fgv11ykaKQrocJfxJ9H2yRB45Ub0=;
        fh=jeUDjhOH0GV+OMnX9oGjheMm4fN3+lN4oOnQkhrx5W4=;
        b=PnWSbOxR8Rfa4UF+ytDk+I8xjIz7RB4XGySIJigkZJtfng7V91HFXPb8Xcpn3BRjQB
         rE+c3fvn1WZYoRQsQn4wS2DVLvdQm9a78Ay2ujKNaq3si2uMaBbd7FOpereNhUFGpMzp
         ie+emsHYUJVGDE7YvCwnEjLlgdB6mmHsjfEtZ3gbWh0YopBnX3rKmRSlPFdql0HFGUHL
         0aH/X2NUlu78GElKYPT+/EWTgMmcn/u3hAwkThcxiDbZIEZuG1rE6MtmKRbTZt8yxqnR
         +gvBdcDbgfTogWSZQAi4VxUXU4KUUAYmNbXusBtXsmbaOx/cmLUhj4KgHS37v4Mx8fFV
         tpPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768241314; x=1768846114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa5KRI7xImF7/q4fgv11ykaKQrocJfxJ9H2yRB45Ub0=;
        b=4Y5WE1tBK3cmSHMqdCzQv7QIqWo4UFKPhzHidCoj2vWwPUvOUhG/7L0f+4cz+J12te
         Kx3FXtDzqiwFimaLb3VpRR3Gt8xvubGPsqxa9XGhkpijvJLbXo4UrBw1la1ocWLTENgw
         y//H08ii7U0PTl54S8t88nYnDro1jYSAlVXhLyFfjB5MN06qQm24BIxCvchw8xjkOgoN
         GA9vNuKd/nxRPK+WMIAl+9FgS2z4pYBaaMHQansztoVPU1fnKkEiEZ2D0bTPExT8srld
         Xhz8eDf7KSQZU0/xiYI6tYDySIKM4uzbffNsCvm1FDYVle4PeF0zt3stmmeisYHyyNQL
         SSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241314; x=1768846114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aa5KRI7xImF7/q4fgv11ykaKQrocJfxJ9H2yRB45Ub0=;
        b=WvdePsF4UalLd4I0Kl5mLMOwMqB08n8fY6iwOfHddW1fNjb89vGapxLltToEuKKkVo
         RR2CtgwHxYLj/nxJUKTnED9d5QxkpAF7lO666I/nlb7TCHS524EZ4sn0Lr5TQ698pbqz
         yQHM9nhE5MemyP7L+slOniDKY21/9Wpr75THJhae+JlJdvKC9JgEZQjg8yGUO6Ol3d5m
         iX7gA9lTDxb4ZaKd70tP4mFd4NngPK0XXp2wpxF4yCPPPz+FcNYAjO3RdDNd1usEM2IH
         FNWYaSR+EVQaxhalDm917JiPSuwC8OKnsM5qrOGXOO7uSNDtRP3j3R40frEeeYKoAoVi
         pJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCUiyyz78IvC8qDQvjqJUng2WBpatA5VLBP/H5P+tDMeLrIYYCwbGLqgTKYFgh/n6MEskabplQbEIj0a6kLEtqQa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PTRrGhoWnLKrqmcGHLvkYX1AmXu4j1+Vh65sZTpjCVHK9EGZ
	okFoJu8fseoK8Zhyg4YE8hNWHLwIp2e/0zDMvyOR/tS9z/FUYlnoTXtV3+6omwfJ/yO7HlJCSBG
	DTwSrWwdpedzca3PaddyeRTVEzg5MH21jYk+7ichg
X-Gm-Gg: AY/fxX4gYirvKcDAjD2qxEojj17aDDqThjwrMUgsHgMH+ofYkujT3k1PX9GIU3ePpyq
	LaJEShiNMPiAnrNihP9f3UYltz9AfIWduwTEziHSbQqyutGN7vV+5JDtZ1M25a/36mF9aq+S2Us
	gJSCr6GGLHoLSmYxMDOP94YhgwS0a251shmAdGHg8qsIGgSy+HahaHhyW604rPejTVw+r55bxTm
	HUGK2f40ozMnwvPAZVmUjic1zCHFS856SN+3zXWmPGMB2U96uQoPX2tMwnxN3L1N4SQ9fXmLqn+
	uoXT0bVBoO1eXCnLi7M8mSZcWw==
X-Received: by 2002:a05:7022:118:b0:119:e56b:c1d6 with SMTP id
 a92af1059eb24-1232bf146f1mr697c88.1.1768241313462; Mon, 12 Jan 2026 10:08:33
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104011738.475680-1-irogers@google.com> <871pju4vwt.fsf@linux.intel.com>
In-Reply-To: <871pju4vwt.fsf@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Jan 2026 10:08:20 -0800
X-Gm-Features: AZwV_Qj9qmvfHgGRle0OWUo5SA5UYZGB1vYo9M3IRgzHV9hAd6Qxt_6fJnfx_hc
Message-ID: <CAP-5=fW0QQj08_S+nn5+kos1mzMbeNg9EBeKPKm03Gfqj80v+A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add procfs based memory and network tool events
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 8:51=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> Ian Rogers <irogers@google.com> writes:
>
> > Add events for memory use and network activity based on data readily
> > available in /prod/pid/statm, /proc/pid/smaps_rollup and
> > /proc/pid/net/dev. For example the network usage of chrome processes
> > on a system may be gathered with:
> > ```
> > $ perf stat -e
> > net_rx_bytes,net_rx_compressed,net_rx_drop,net_rx_errors,net_rx_fifo,ne=
t_rx_frame,net_rx_multicast,net_rx_packets,net_tx_bytes,net_tx_carrier,net_=
tx_colls,net_tx_compressed,net_tx_drop,net_tx_errors,net_tx_fifo,net_tx_pac=
kets
> > -p $(pidof -d, chrome) -I 1000
>
> But AFAIK that's for the complete network name space, not just the
> process, thus highly misleading in perf context because the scope
> is incompatible.

Yeah, we can point this out in the event descriptions or just not have
the events and try to do some per process BPF type thing. Given we
don't have the BPF thing it is still tempting to have these counters
as-is for the system-wide case.

Thanks,
Ian
