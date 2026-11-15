Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794739658;
	b=GheBBGawcG3qDsqt3wOAT7XaB1RQCclCt+chq1bIojJa6nWuPpvj2Yde3GjbLbndh8MO
	 OR16q48RKmLBwiTvvyusgvM2K8vbK0+MASZfsXoIgT9uGT3oMzZLFYF8XEELdOPOxm9mz
	 wVRDyuMKE8dHNxYvIVusfDg/WBGrUr1Haqvao6ZLArFpGwQePLKsRMH6GLOf/9jQ6XJUx
	 UUW0YWgLqFTLYudvLR2VW0kURSrr+akWbwlgTx1NhKp2pzkNtt8yLHWMtbGJ6peXjF+Df
	 2/bAmti9nnVFHvSgm//IYlkHgiY3rlUyXW0ea+Uhog9LzW0Gx5VoKObxMwVwX9vYDIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7hNKkJJ70oe8gF6M+CzP6oDsWzOHjvQZU/Y9Gmdl08c=;
	b=wTqmrOBXqBMKkzfrw4PqVZvwfoGuxCJc2iKLHEna3yg2/9vQiHrN0rCTO12pRJsuxL9P
	 r1VFwFiY1W3AOp2eK127tSSuWY+gIUdigo9TMHbowatfX4G8e70b/WedX3zSK12SQn0fO
	 d3iBbbU6UhpPesuX2X7fCSc5K1wH4l8Ugw4zFET17HtvhKe4pSxIM03kNDjHElG/+6tqc
	 9o3QDiD3gIHFXZXanUQNv9TCb9XX9UKpMLpuWucu/zFNIJu7u+Fbwk7IHEbDWOBGIEjqi
	 UfJ9IKizjHIwIp7kEcvpBcbWbLCH2Y4lEfp/qvHJ7h8l8z68lssAO12XmJn7nIITNDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0yaroapg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFC606A31F
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 10:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6DFC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0yaroapg
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so4013481a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 02:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794739656; cv=none;
        d=google.com; s=arc-20260327;
        b=GH29FqWpbQu94Di/c0WLAfLU0nu/aYyMcJF221Ys0zgZZEXYDjvhqIGQKfFIyc2h5n
         iP04p0hZCjngIiCprd78PfMJOz8eVHbhV8oDq7cVzKSNGKpjqZgphjDCqLtHzjWhPUze
         dapogilT+eL8XuUtpHsCRNnhKS+wqcvqXAZJ8ljx2YE5Mp+3vR5dErym7RdlgWaklOZT
         q1KzgTeOYGxqA3RkrLTHmrJqvL7YUfi+HeH7Tg3n177aaBrdYrLcP4nr0De5jFVILUTV
         B0e0gan4KI+HCgPkyDjTULfmcVCQ+sa+H7YVtQfJkv2ECxJaKEBQWxPpSDlp87nX4jjI
         AFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7hNKkJJ70oe8gF6M+CzP6oDsWzOHjvQZU/Y9Gmdl08c=;
        fh=3qIjbtISuz36xzmn6D0kDcNg+x8XhBq1Gz7I/OeW3lU=;
        b=G9rPa2AAplyzZQ52bzhLuXvMOt5Nx7vmzfe0UfuxCr94X0rxa2PsTIRYfuMdcjI/Vo
         oucurpqiIiZRyjQ2mF58GY8RSVfOkgVoCoMAPHsJNpuYIYDmbkiLxoAzAJUV36lXhQPN
         wy3gdgQJrzm2eLpsW82xfG2U0kQYQ45LHOrhjEeP/khA+aIePQlO1TApl9uCSuw7TBvZ
         UhlzYFmT2/+Po91MfR9yOjU/4JRnuIYG/QdNVTlDkd7LWL2tDRPiPtC4Vzg+0flPd4kH
         BLlHboiX53/NrgoeUW04hfZkWiPpG0qRTX1ZqbPnq97ePuvswQ+8kBp3NV08hnohRPAh
         HhPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794739656; x=1795344456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7hNKkJJ70oe8gF6M+CzP6oDsWzOHjvQZU/Y9Gmdl08c=;
        b=0yaroapgliwOF0oOHtWneHn+AdMq1iwYFupBALuhtU3xq7N0C0+ZXMXQBOyAD3GGj3
         ADZtTTRBEDnocmSTov3Wwyi37rGwqCr+HLlstUHOgnypSOW+E+KmursMGa63W6Tnkeb0
         2HJa350marYhNYgiyC9Mhal5zMx0fYTLVN9pK5TFrnev2h3xNhv6Kq+AKp1FWzQW/iu3
         waXFyfO6tsZdUYlhT01bX8S3mtvCYQubF6Z2TTIJiS+atpCFkVXvqr1oc41709tBLZ4F
         jY+ntJosrKvGTfIAPqlra6oMeZ6Tr1ifs4X6fhNMK39u2/RNTfI/rAysCKqQrMoUqKDA
         Y6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794739656; x=1795344456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7hNKkJJ70oe8gF6M+CzP6oDsWzOHjvQZU/Y9Gmdl08c=;
        b=x7N5V+G65k5mE815JKCjzxfFV+gleXdjK7Lpzv9Ps44wbkPXcOBXz43J9zP3oB4DH+
         wX/EVHAH/JuUyaCEqeLjiRTKCli7kegQJXwuL8V3wcKCOX5TTHNcrre0DiVVNqP+XB1i
         5jEjhAu8i2BwsY2c4A7lM12fsvjTE652/QVG8Er+flbz0TAmdYW+gUpOiJo9jVIJugMi
         SNvk4N9DnjXhIFUkzBj8gMypV+/JPEL6Df2HqPkuZfX1+4TG9oq5Th2acQdhLWNjbJbX
         XJkliCR0Y55UoIYXzY9waxoNmcS8LZGJqBEQItkrrW3WeG9mjmEdf/yrH2FtY0WWA3XD
         4BMg==
X-Forwarded-Encrypted: i=1; AL+hErEA+3IS0ZqV+6TJRc+kBQf/g0GRy5c3rVhGXa4gypwLh0nkedWEgtLsbrL3vlch348sdBeRSXICigkSnAWkilv3@vger.kernel.org
X-Gm-Message-State: APuU4Z9h/1x8UJXv1qw5DgX5h8vInRDpffk/F4doev40Bg3Ob73cDDfr
	XMLe+vZXga5gt+HR7RemWoCMn8CjMvzctwZPN4+fnflJF3d58HFe86ALP4x33pSuh4q7hPz6Lir
	unZ8r+S0dAaLJhvrb1+Ib3amI4njLXdApGwNbiHMxxg==
X-Gm-Gg: AYBFou3tuAnLLnS9ITsors7XxuqnSFR9TDH5ImAjIqS8PAWUwnnKn6LdR6DpcwO+wvi
	eBHkW2Y6J4XSo+Ygbf354RxJhjQxy2Entc0Y66P2eykePM8aAiv/hrwAXSGeyeCG4QevqrLQeOg
	xs0xnLU5+YKyi6Czpr9pv+X91JmK070ftcv8W5AXHBfbufSdgS9Me8vMsf/NVqQI/4rGeeK23hb
	oqPAystVO7/Ric5UauEPpLsYhsXMVWLug7+9rXp2yqYKG8w9/5ZRVFYZkDUOEGnveI5h9rK/1uB
	dSJJ1yJo/jS4EnpVwrrr8P0eGB4zXehGg8iYJZvjQBdNEbBBDT8mLQAUwV6UKWIKAE/oM30iqKW
	rGZQwRZjocGCeG1SJv7N+b3hoBJzSG+4E057VGd1K9sqqg49g9LQfpeEaGYqbEOOR15bGXiHw/9
	FA/d5rK+iw/LAicm3jAKBJ0e4=
X-Received: by 2002:a05:6402:13d6:b0:6b5:74dd:37ee with SMTP id
 4fb4d7f45d1cf-6b7c0d2d212mr5900328a12.44.1794739656036; Sun, 15 Nov 2026
 02:47:36 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
 <CA+=Fv5RBKVAdGgq=BGPmLXpczcB3qvQcSw8aat7nB2ePXcG4yg@mail.gmail.com> <avQKb-vBxTvMn1yF@z2>
In-Reply-To: <avQKb-vBxTvMn1yF@z2>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 15 Nov 2026 11:47:24 +0100
X-Gm-Features: AclHuK9Mu_cJKLZOoV0Y-yZCRrVtpzl_e4de-VMWVu7r7OWJeMEUlQrpyeZtftw
Message-ID: <CA+=Fv5SA6so5VjPzjj1tCNKxwOk=5ejj0YhEG483u_-RY+7NoQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] perf alpha: Decode ProfileMe samples
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Matt Turner <mattst88@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 11, 2026 at 7:25=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Tue, Nov 10, 2026 at 08:31:02PM +0100, Magnus Lindholm wrote:
> > Hi all,
> >
> > On Wed, Nov 4, 2026 at 7:53=E2=80=AFPM Matt Turner <mattst88@gmail.com>=
 wrote:
> > >
> > > The Alpha kernel series "alpha/perf: add ProfileMe sampling" adds
> > > ProfileMe sampling to the Alpha cpu PMU. Each ProfileMe sample carrie=
s
> > > the profiled instruction's PMPC and its I_STAT and PCTR_CTL status as
> > > PERF_SAMPLE_RAW data, which says whether the instruction retired,
> > > whether it trapped and why, whether it was a mispredicted branch,
> > > stalled before map, or was killed on a wrong path, and what PCTR1
> > > counted while it was in flight:
> > >
> > >   https://lore.kernel.org/r/20261104-alpha-profileme-v6-0-63362e9290a=
3@gmail.com
> > >
> > > This series is the perf tool side. Patch 1 decodes the raw data in pe=
rf
> > > report -D and perf script -D, as is done for AMD IBS. It copies the n=
ew
> > > uapi header from the kernel series into tools/arch, so it should wait
> > > until that header is merged. Patch 2 adds a script that sums the stat=
us
> > > by symbol or by instruction, in the style of DCPI. Patch 3 gives perf
> > > mem a ProfileMe event, as the kernel series reports the DTB hits and
> > > misses of loads and stores in the data source.
> > >
> > > To try it, with the kernel series applied:
> > >
> > >   perf record -R -e cpu/instructions,profileme/ -- ./workload
> > >   tools/perf/python/alpha-profileme.py --pc
> > >
> > > I tested this on an AlphaServer ES47 (EV7). Sampling a loop whose
> > > branch tests random data reports that branch mispredicted in 21% of i=
ts
> > > samples, and 0% with sorted data. As a normal user, perf mem record o=
n
> > > a loop that loads one word from each page reports the load's DTB hits
> > > and misses.
> > >
> > > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > > ---
> > > Changes in v4:
> > > - Patches 1 and 2: ignore TRP, and MIS and the trap type with it, for
> > >   an instruction killed before it was mapped, as the kernel series
> > >   does. Thanks to Ian Rogers.
> > > - Patch 2: record cpu/instructions,profileme/ in the example, as a
> > >   precise event now samples only retired instructions, which leaves
> > >   the killed% and invalid% columns at 0. Thanks to Ian Rogers.
> > > - New patch 3: add a perf mem event for Alpha, cpu/cycles,profileme/.
> > >   Suggested by Ian Rogers.
> > > - Link to v3: https://patch.msgid.link/20261102-perf-alpha-profileme-=
v3-0-4bf6e1dda733@gmail.com
> > >
> > > Changes in v3:
> > > - Patch 1: silence -Wpacked around the uapi header, which breaks the
> > >   build where __u64 is 4-byte aligned, such as sh4.
> > > - Patch 2: only read raw data from cpu PMU events, as a tracepoint's
> > >   payload can pass for ProfileMe status. Thanks to Magnus Lindholm.
> > > - Patch 2: print a table for each thing PCTR1 can count, so that mixi=
ng
> > >   events no longer averages unrelated values. Thanks to Magnus Lindho=
lm.
> > > - Link to v2: https://patch.msgid.link/20261030-perf-alpha-profileme-=
v2-0-9ce2f0b0e622@gmail.com
> > >
> > > Changes in v2:
> > > - Patch 1: copy the raw data out of the sample and convert it from
> > >   little endian, so that it decodes on strict-alignment and big-endia=
n
> > >   hosts.
> > > - Patches 1 and 2: follow the new 28-byte struct alpha_profileme_samp=
le
> > >   from kernel v2.
> > > - Link to v1: https://patch.msgid.link/20261028-perf-alpha-profileme-=
v1-0-f46c1938d001@gmail.com
> > >
> > > ---
> > > Matt Turner (3):
> > >       perf alpha: Decode ProfileMe raw samples
> > >       perf python: Add alpha-profileme.py
> > >       perf alpha: Add perf mem support
> > >
> > >  tools/arch/alpha/include/uapi/asm/perf_event.h |  31 +++++
> > >  tools/perf/Documentation/perf-mem.txt          |   3 +
> > >  tools/perf/arch/alpha/Build                    |   2 +-
> > >  tools/perf/arch/alpha/util/Build               |   2 +
> > >  tools/perf/arch/alpha/util/mem-events.c        |  17 +++
> > >  tools/perf/arch/alpha/util/mem-events.h        |   7 +
> > >  tools/perf/arch/alpha/util/pmu.c               |  11 ++
> > >  tools/perf/check-headers.sh                    |   1 +
> > >  tools/perf/python/alpha-profileme.py           | 178 +++++++++++++++=
++++++++++
> > >  tools/perf/util/Build                          |   1 +
> > >  tools/perf/util/alpha-sample-raw.c             | 156 +++++++++++++++=
+++++++
> > >  tools/perf/util/sample-raw.c                   |   2 +
> > >  tools/perf/util/sample-raw.h                   |   2 +
> > >  13 files changed, 412 insertions(+), 1 deletion(-)
> > > ---
> > > base-commit: 4626d370ae89b8af4d46a45372b269f926ec662d
> > > change-id: 20261028-perf-alpha-profileme-8010299be323
> > >
> > > Best regards,
> > > --
> > > Matt Turner <mattst88@gmail.com>
> > >
> >
> > My plan is to take this series through the Alpha tree alongside the
> > kernel ProfileMe support. Does that work for the perf maintainers?
> > An Acked-by would be appreciated.
>
> Should be ok as it hardly touches the common code.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Ian, does it look ok to you?
>

Thanks for the ack. Taking this through the Alpha tree will keep
the tools support together with the kernel changes it depends on.
I'll add your Acked-by when applying the series to my for-next,
pending any further comments from Ian.

Thanks,
Magnus

> Thanks,
> Namhyung
>
