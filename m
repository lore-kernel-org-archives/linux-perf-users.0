Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F725771
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446915; cv=pass; b=mCRGahMHdKvwBswD+8+LGDs26vfWFEGFP76q29c/LPJJqJdI/5QCe1LKqVmt7mfp6OnHJbnjKQLDpOug7h3KmRq/Hlzte6LDPlo1dckm89AfMxzXHdNPJXNdPmtrT8xo9ubAEDg03lzACvUgpNjWNSsTm2PY0peW5Vnw9vbAdng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446915; c=relaxed/simple;
	bh=fEMdqrR87qvh19uuLTo6iRMM7fYGSlRgae5OTjZk1J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrbYrlepBihtu0ZRyEYhdPo57j3VW2SYK76aNoESzGcwEq9ISjgwEpc3ggDh+AKbnAGZdvvtWfR6FlnaGCvBGizWO1rei4sjIzIeDvdyrbSzCkVhViwA/KzI6vcGcaT5I6UzCoFwFP9uLUKVeGon+DsXxqenKxFFvDfjQ+SC5Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnMV1z5F; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnMV1z5F"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a35ae38bdfso160505ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 09:01:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769446914; cv=none;
        d=google.com; s=arc-20240605;
        b=XM2LRF6isgTe951wLNuxaiTc2ydLsYVDVMZhyU6oP3fqrU63BQDTmO2oJhSyXlyUIS
         +v3gWedHSzTKrkiL4xgD3p3EOWPuF0N9kd8EPegCeZbvdaqZMU1OdWFqZ9cZS7b84J7R
         60Mv5RCKhVUDDxtBzM5FnOg1UbkhEKcXsIZKBB+nUZtO7+XWy6s0hwCkOCHxf7c0UQgl
         PAIIcGIre/xPe+pHzmyQwixjiAFz5IJmCs4iDM6QDjNhCl4T0CjT/62cyMHywlZ+eaMo
         Ed81bQdp6h3Vfk4vSlSM/vSim3L8/ukBuSidjkdfxhzxn5yaH3EwOx7CtA+u2inM6fBb
         fR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZordIwPzkQDLZvR5baDaNuLBEyybU6EqCMS5GRysUY=;
        fh=P4j55f5ZC1aV7gmipoH0u3W5Wygj09kzZEtWTaMD/fc=;
        b=GFBJYOlTauWL3CJrmLw8l6AehZa2XTH8EO6Z5whdvcf0TKDUZ+SO77SJbHX4zTwQWZ
         7jXVUgX/J5gwKnhjDVymUVbJOR5Ht6k1FEazmQ1d7i19YogzGqh/oDU8HFg6h9Qq6Uu2
         w6AyNF+xxFvgrmEJaxmzOCrUlTcY4qhXoPnZqJ+j2+q3Qa4m8u/OajMohHU8WdaJ/nbR
         KPC6FdW84wTlVB4eW7FAQwspMvbZWbcO3paephS/5FTQUT/iFulT94GyVP0SUfNHi70y
         9yFAfd7+p6kFp/q7QTEzVgXQ0443QZCS99ypenTyQ0JzybGbu2spbLg8ykgqmA/4+CLX
         viUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769446914; x=1770051714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZordIwPzkQDLZvR5baDaNuLBEyybU6EqCMS5GRysUY=;
        b=EnMV1z5FB1Yd+RsPYDccYQJzKnea8CzU5CwB1HS+lO92uCRCHxAExupYddviQrL7x7
         VNAmETC55C6cJutSuJVyBtyg+WSf9sWcz2TAsRQFGUwUwhKpvF5DD68SXZsciWwiCIWE
         Z6h8QpHQIvovTuVaJmrG9J6BtH3TqoX4j/zBdGZiB6oAeg1ZuoQY9FbCFXnDw+BPMRDX
         zR/AxvHXHR1rYMjpT9HYyTkr9PTl3E9vOX3+Z1OTRNIBbdyQqCoWUGyrODiPSeboUzUv
         wZoqKQn7eBVWrrHl8+EJaRYUCP7NNNhs6GDHj3vWPE/jYz8Wt8wLURACkRbc1cpYZbKm
         ZOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446914; x=1770051714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZordIwPzkQDLZvR5baDaNuLBEyybU6EqCMS5GRysUY=;
        b=weFbPMPfm67SUhsiwseaF2An/LtpIeuv1qeIw/E43+5BYWmSxoxjxcnkRvn7ak7wmN
         0hOR0Sre3TWPDY7q1CChHmLAfynuJTBLRFMorWmMADnWwXvgvW0eFmH+N6iLnNCvkDKd
         WWaUFViKPphzjugtevwSV7Axpy0XDeCqqMAgsBrKyLot31Ejt2S7xe1uiv9hFJg1qOHa
         bnR3kp3BFZvSm52bK7ZUu917SPK5DnZdbakhGHAvcf3ECRS+f8rRz0QlpCqk9lgj8rkV
         m9c16aUlrdWVwBnpH0iKfi19Wqt9ZGJCw3lD0ljkTfZTGG0a8MKM+2UnOCP3G57pOqjQ
         94jQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/ARZFZse/X91mshMgfPbGj+QU298GO5aWVfmPL5E7KZfmwXMEDEyMOhwmx8zfXp3cn7CzDx+reIHR7eVtgm+p@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+TdSCP4lqGaVjasCUXn1Ay7dJ15m4xA/1CLRCvv34j7lcXP1
	fnNG7I0YonuQoLxJIypXq/YAkxgBI5+qD7gvcze+lTdfDTJqAdavyhRU93LcO2tPexWxjEw+ArO
	rAYT6M1Cn/y5xMUa0bpO4RdfIRieets8dxD1JteO13LrIaLLLs+gJE0ihqb8=
X-Gm-Gg: AZuq6aIyKimHLyPkJz5+NLZEZAQY1mq8FBINuW5jGSajvgp/vsJyc2vP52PFWcHQlAI
	UjQpS6V6d77TEOiw35w506+AIOiOChmOUxsQoaqKQEtXsaI4nsokgQktV3fOBpuWfMa3dfLCnwh
	YDVKnIs4MSEhcnvKr+SoDn+mTw1tFZi1S/FUlHVGdxCLEIIavYpk1AsLSu6Q36sx5yuOMRN0Zuq
	1A4ayWBP3VXz/97gkyFbElGjflu2WNzCt6iQjBYCNibqNCO8oDsGE6TBJKCayTJkdPOXPq4NDDI
	hImm7vzrDNsGZAtrKPKRk7FYI3qFZpw8WYED
X-Received: by 2002:a17:902:ef09:b0:2a0:89b0:71d7 with SMTP id
 d9443c01a7336-2a844e77f45mr2176075ad.13.1769446913375; Mon, 26 Jan 2026
 09:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
In-Reply-To: <20260126123514.3238425-1-wangyushan12@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Jan 2026 09:01:41 -0800
X-Gm-Features: AZwV_Qg2tWe8uippZ5ldvtEYGALSf4Ro55wkqzh5HcjULP3PISqa2vUjOU2M7k4
Message-ID: <CAP-5=fWkBjJy2i=e+zn1Ou5g3J8rapGKi8O7ryQ-ic2vXFEOoQ@mail.gmail.com>
Subject: Re: [RFT PATCH 0/7] perf tool: Support iostat for multiple platforms
To: Yushan Wang <wangyushan12@huawei.com>
Cc: mike.leach@linaro.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, peterz@infradead.org, 
	john.g.garry@oracle.com, Jonathan.Cameron@huawei.com, shiju.jose@huawei.com, 
	will@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, 
	liuyonglong@huawei.com, prime.zeng@hisilicon.com, fanghao11@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 4:35=E2=80=AFAM Yushan Wang <wangyushan12@huawei.co=
m> wrote:
>
> Currently, platform-specific iostat code for PMUs is implemented as a
> common iostat callback interface and invoked based on what is being
> built. This approach limits support for iostat across different types of
> PMUs.
>
> Support of HiSilicon PCIe PMU iostat was raised at [1], which uses the
> similar approach.
>
> To extend support of iostat across platforms, change common iostat
> interface to framework to allow perf to probe PMU capabilities during
> runtime and route iostat request to the correct PMU-specific functions.
> Then HiSilicon PCIe PMU iostat is supported with the new framework.
>
> Request For Test:
> Refactors has been made to x86 iostat to adapt the iostat framework, the
> probe function that checks if there's any PMU's name contains 'x86-iio'
> may not work properly, tests of that would be appreciated.
>
> [1] https://lore.kernel.org/all/4688a613-c94a-49b0-9d0f-09173c64082d@arm.=
com/
>
> Shiju Jose (2):
>   perf-iostat: Extend iostat interface to support different iostat PMUs
>   perf-iostat: Make x86 iostat compatible with new iostat framework
>
> Yicong Yang (1):
>   perf-iostat: Enable iostat mode for HiSilicon PCIe PMU
>
> Yushan Wang (4):
>   perf stat: Check color's length instead of the pointer
>   perf stat: Save unnecessary print_metric() call
>   perf-x86: iostat: Change iostat_prefix() to static
>   perf-iostat: Support wilder wildcard-match for pmus

Hi,

Thanks for the changes! Given the iostat code is display code, it'd be
great if we could avoid the arch directory usage. For example, I may
record data on a machine with a HiSilicon PCIe PMU but then want to
look at the data on an x86 laptop, as the code is under arch/arm64 it
won't get built. Given the PMU name is unique, is it possible to put
this code into tools/perf/util and determine whether to use it or not
by seeing if the PMU is present by its name? I know that means
refactoring the x86 code that hasn't done this.

A thought that is away from the iostat code and may simplify the code
base is that we could introduce system PMU, rather than CPU, dependent
metrics. Perhaps the iostat code could be replaced by a particular
metric group like Default or TopdownL1, so `perf iostat` becomes
something of a synonym for `perf stat -M iostat`. An example of what
this may look like is (unmerged):
https://lore.kernel.org/lkml/20260108191105.695131-34-irogers@google.com/
where I introduce a memory bandwidth saturation metric dependent on
uncore PMUs (either cbox or cha) on Intel. There is a metric
"have_event" function that can be used to make a metric conditional.
If you `perf stat record` a metric today and then look at the
perf.data with `perf script --fields metric` (IIRC) then every metric
that has the recorded events within it will be computed, although the
code needs better testing, etc. I suspect the biggest downside to this
approach is in how the output looks, but perhaps that can be tweaked.
For example, the `ilist.py` command:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/python/ilist.py?h=3Dperf-tools-next
supports regular metrics.

That said, I'm not against the changes, the arch directory usage, not
using json metrics, etc. and this change is doing clean up, following
existing patterns, etc. Sometimes the codebase has evolved but certain
commands haven't kept up. I think `perf iostat` is a command like
that.

Thanks,
Ian

>  tools/perf/arch/arm64/util/Build         |   1 +
>  tools/perf/arch/arm64/util/hisi-iostat.c | 479 +++++++++++++++++++++++
>  tools/perf/arch/x86/util/iostat.c        | 105 +++--
>  tools/perf/builtin-script.c              |   2 +-
>  tools/perf/util/iostat.c                 |  79 ++--
>  tools/perf/util/iostat.h                 |  21 +-
>  tools/perf/util/pmus.c                   |  12 +-
>  tools/perf/util/pmus.h                   |   3 +
>  tools/perf/util/stat-display.c           |   4 +-
>  tools/perf/util/stat-shadow.c            |   4 +-
>  10 files changed, 638 insertions(+), 72 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/hisi-iostat.c
>
> --
> 2.33.0
>
