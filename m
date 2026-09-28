Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF137F00B
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628942; cv=pass; b=M+aRaSwOsVtDpk5npecHFrW+aLcfdzj9st4JbTVguu3DOljGHaovorKVHJK5D9ykD7vCnP/3Eba9cO7dgWJ1xJCud8RSaaVtpV9ZkOjUHIX3AgIdE2MqzxpOTD/2cgVOpkR6Jq0S+WyFqCJ9dHd+Y2W8yxVnh2QOrpUejkl8434=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628942; c=relaxed/simple;
	bh=3n31R1q5bjvZ0KOlhCAA2oNAtOjib+ZsHvh84olKglA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLKDLDnmRL0P1eYHKDeaqiXroGySGz9vdM64kfk77hjlMOP34YhtzAna3vDwK7uDPJ8aT14fNiS7R9pEBt0gaGTzBgR5hNePRyy25ThpS4AQSKCf3rrtCEhYV9CEFDc4uG419tRt+NGqArE4xzAOs+EKGtbcFNcZz0AvCMOrR3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+jDxopu; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+jDxopu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so3395ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 13:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790628940; cv=none;
        d=google.com; s=arc-20260327;
        b=ievvrZSTaxXr+CE2xiD9MuataHouqjtxAPJwCwPXeYV+7o36vUTmSgu0ZpeX0GDbzz
         FkX0Vrdy1KkwiSOYgrhQEF14Z06pz038mwhFgf1SKr1e9guGByKwJBmrl0pQOXbU3jXG
         6QMirxKkiAV9fOBONcZ0iAKmbNB2XyNK0b/Eiq0Ry0jRGpm7nZUlNqFygFO8xYCXoSbd
         h6Z94tS0+I+kJUIniJa5KQZCy7dpNERI2mNWci1PRPe9DeB19KfcDQxF1gIX2G4iwy0L
         0sbIIukoodP/4HxnL0MUDHICwLYmfuJyy+XundodW08BGCLSWD8NlzavM/MOid7YaE6i
         6PVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Di/osfCPEWXpW4kbTcMFoaZ0V7qUOUR3BDk+OqgiJk=;
        fh=J06G/uCYqV4IIjBtyeOZwAdYbzCH4XnG4DGcXVO41W8=;
        b=dxMjMPmuEJm2yqGV0M+sJrNzyF+Pu8qBIzxhMNDJPXC5GJCj6jOsMArR8zSkMeO3a7
         hmhbm1Z5NMJbVm6fx4URdOVPHrRRBOZcaDl3ZyXZrpBe+q1D5XjU89Xs0I0p8OmSgfGE
         AcDYebXXu4QX84cl6f73JOjx1dLj4RlydkZv0hDfk7bB/a+6UNSc1anQL7+DYR98TN5x
         ZZfncJRxWFH5dYh1iDjYCS1pyXGCXyR2wy0Z6Ll0F4XTr0lFvJGhAu4iJHsw2KcQI7+H
         8PaU0WtJJkRtimHZgpCicC5CU+A/nuISww+GKlpCOnaCFIa9L/qwS/d9yXBBPQuPjY8k
         fYPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790628940; x=1791233740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Di/osfCPEWXpW4kbTcMFoaZ0V7qUOUR3BDk+OqgiJk=;
        b=K+jDxopuUMpcfCOGOiDCwKufpWzIA5nP+pAZ19qHNFHbnqCUTD5h+5xd32xAPklMwj
         UEOhCI8T/dJt//XoLFILJP6OMAnD50pMpaWzDNHjESGPEtZQN9UKq+fg/dXjqtMylH4h
         srOJSbyJnRZWHq36eLZhWfqiZJd991Adco2KEw3j0YbQPdtIv0fKuWHTFCGIK5AHhxd5
         UMB+gBxC2NG5XvM/OvDRdjoUpMf7RRZczBUbRcAn/FAMAvllGrleKEzT86p1+MEFYuui
         9Wpdo8vIcHdm7EH0JrIEV8TLHDtpwMaYkHpA4Zj2Lu1prhAVQFWWnCZXiGaO8mo1dwIi
         d7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790628940; x=1791233740;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Di/osfCPEWXpW4kbTcMFoaZ0V7qUOUR3BDk+OqgiJk=;
        b=PlBv5MUv111HFoKu04PkT2M+3CwZ+1r7n2ymSgLxbCrt2gZU5mYGJcXat+8cAZmq3e
         GF0GY6/GrkvcRbavrzt0/TnSDXetpsn8RNxgrBgSPUm+VZ0LHpyJCHK0rSGmrgmuJxml
         5LMXWv5EFiBDOhxU82xBiOIuTAw1HU9+FFrsn8MvvLeSNrmKV5KA05Ef6we17Dm9gIQl
         1+WSTAOXygu6XzgLpJL6Zn1A8oz/PNefOolpcsKYPPAn32QFDP0p/xOZ8QM0HVjp2Y0U
         TPaH8wnUUe0wEFxweaMIKTLq6YFLnLj4/71hD4GHxUeFHOCJQ8P59jSwwjm3VYknX8UJ
         zHaA==
X-Forwarded-Encrypted: i=1; AKwUvByeOyB0nrLYKHdGL37zVs3sqNwEZETkC9vqgGj5svNXW7sWFJHa34oxTf7Pq9QgFZo9S+AnDooUpuA6Sf2emvzc@vger.kernel.org
X-Gm-Message-State: AFq9FYLq+APJNOSTwITK5vhOwU9NLp4XSc1KNukmXXKInUtRItu7Ay0V
	b3ekjP7Sq9O6kEEZu1bp0lE8LfnJS4tQ8r5gu6zJIC/j3XUKb6na0nbBq4BS7Wc5xKKl6sgkZrI
	0wgfTjCgjbXyXuRUmRVT4WV7d8MPLgjM13gJo6g+s
X-Gm-Gg: AYBFou0hagfZEiWTc7hOSCkIM/zHZmJV2Bfrv9tSta2WrsdI97/Zi1aNKCaTl8sfgvM
	wuocmu+ZCdaI+H2cJ7fFUEq1fquFw4T+wHMpuKbl+kb0JQJSYFaiTaCzRrKwR/9wOqNzmTrRdeS
	npFWwdF2E0ttmKhoM9KplHAsddqXEKATT8PANS4GEH8OA+WfN2z0grPwBvmC0rJ7NAsyJcS09zZ
	vkn/nwaXmx02ZOalFMg81iZGDcNfC7ZwOiTRdQrf6jh/5/ZhzoIfuFIVkEvoFclEd/2hE1sIvUW
	l6VkBK9kstVuIHpQmVf2k0FOlcY1/ePi+S6OE1W8I54dpUO16uVvUfufkuhxiPFmm8MEUpYFnuc
	QoNOhOTh3Yw==
X-Received: by 2002:a17:903:2b0d:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2e2c608146fmr841065ad.1.1790628939146; Mon, 28 Sep 2026
 13:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <CA+w=M=R7vMK9-YZufh1ZW7efsVh=vCVkeh2_4rPSAsN=SH8MuQ@mail.gmail.com>
In-Reply-To: <CA+w=M=R7vMK9-YZufh1ZW7efsVh=vCVkeh2_4rPSAsN=SH8MuQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 28 Sep 2026 13:55:26 -0700
X-Gm-Features: AclHuK-dtSVT1mH9aZeJKzJgzy2nTzF4fmex-CfS4tf9B4F3lhykLCmzMg5EDA0
Message-ID: <CAP-5=fUFWGxNSS+TW4iHqeWu+24-R2rq63oBX19VxkTXnqo+4A@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf symbol: Reference counting, flat array
 storage, and LRU shrinking
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:45=E2=80=AFPM Alireza Haghdoost <haghdoost@uber.=
com> wrote:
>
> On Mon, Sep 28, 2026 at 12:52=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >    annotations. Saves 48 bytes per struct symbol (two rb_nodes) and pro=
vides
> >    cache-friendly binary search (bsearch) and callback-based iteration.
>
> Hi Ian,
>
> Thanks for posting this and for Cc'ing me. I built it on edd8a9fe2eca0,
> the same base as the v3 series I sent last week, and compared it with
> v3 in eager mode (today's behavior) and with --lazy-load-symbols.
>
> All runs use perf script --no-inline --max-stack 127
> -F comm,tid,time,ip,sym,dso, with one warm-up and three runs; the
> median is shown below. Peak anon is the maximum RssAnon from
> /proc/PID/status, sampled every 10 ms.
>
> 1) Production: 120 s cgroup profile of a storage service on an 80-CPU
>    host (perf record -a -g -F 99 -G <cgroup>). 54k samples, 11 DSOs,
>    5% of lines [unknown].
>
>                   time     max RSS    peak anon
>    v3 eager      4.5 s    386 MiB     314 MiB
>    v3 lazy       3.7 s    151 MiB      80 MiB
>    this series  95.9 s    309 MiB     275 MiB
>
> 2) A sample fixture from my v3 cover letter, a worst case with 73% of
>    lines [unknown]:
>
>                   time     max RSS
>    v3 eager      3.2 s    334 MiB
>    v3 lazy       1.9 s    106 MiB
>    this series 205.3 s    449 MiB
>
> Most of the time goes to reloading. On the fixture, a profile shows it
> under map__find_symbol() -> dso__load() -> dso__load_sym(). After each
> shrink, the first miss in a shrunk DSO re-parses its whole symtab, and
> addresses that resolve to [unknown] miss every time.
>
> The peak is still set by dso__load(), since the whole symtab is
> materialized before a shrink can run. That is the main blocker for us
> running perf script at scale: we can't bound how much memory it will
> use, so we have to contain it with memory.max, and then the profiling
> job fails with an OOM kill instead of degrading.

Hi Alireza, and thanks for the feedback! I'll see what can be done
about dso__load in v2.

> For continuous profiling, a degraded profile is still useful. We build
> our view statistically, aggregating many profiles across hosts and
> time, so some frames reported as [unknown] in the DSOs that hit the cap
> only add a little noise, and the cap reports when it was hit. A lost
> profile is worse: the OOM kill removes all its samples and wastes the CPU
> and memory already spent. A bounded, reported degradation, like perf reco=
rd
> --max-size, is the trade-off I'd recommend.

I don't disagree. Fwiw, a C++ memory allocation failure inside my
company's code base is a runtime abort. In perf, many code paths
return -ENOMEM or NULL. I wanted to see how far we could get with a
"shrunk" set of data inside perf as even if we fix memory allocation
around symbols, other code paths can still fail.

> The bound also matters before a profile starts. perf runs next to
> production workloads, so we have to plan its memory up front: pick a
> host with enough headroom and size the job's reservation, without
> pushing those sensitive workloads into memory reclaim. Without a bound
> we can't do that.

I'm still not massively sold on having explicit bounds. It reminds me
of old and often seemingly arbitrary numbers like the number of rows
or columns in a spreadsheet. That said, perf has a similar problem
with exhausting file descriptors. As long as the default is
"unlimited," I'm okay with some attempts to limit size, but we should
implement obvious garbage collection as I hope this series introduces.

> The output of your series matches current eager loading except for a few
> frames, and there I think your series is right. For example, a sample ins=
ide
> nft_do_chain [nf_tables] is printed as dca_sysfs_exit [dca].
> symbols__fixup_end() extends the last symbol of a module to
> roundup(end + 4096, 4096), which overlaps the next module when it starts
>  in the next page. The rb-tree lookup can then return the stretched symbo=
l,
> while your bsearch picks the right one. This comes from bacefe0c7b77b;
> I can send a separate fix that clamps the end to the next symbol's start.

That's surprising as no behavioral change was intended. That then
leads to the question of which symbol is right and whether a latent
bug is being fixed or a new one introduced. Oh what fun :-)

> A few questions:
>
> - Which workloads did you have in mind? I'd expect the shrinking to
>   help most with perf top and long perf report sessions, which I
>   haven't measured. I'm happy to run those on the same hosts if you
>   have a setup you'd like me to use.

So most of my experience with excessive memory usage has come from
perf top, which seems to leak memory and consume all your RAM before
long. That is expected since no DSO is currently unloaded. I'm hoping
the shrinking process can be generic.

> - Would you consider a finer-grained reload? The index in my patch 5/6
>   keeps a 24-byte entry per symbol, so a miss after a shrink could
>   materialize one symbol instead of re-parsing the symtab. The pieces
>   could fit together: your container and refcounting, the index for
>   reload, and a byte cap for the peak. If the maintainers prefer your
>   container first, I'm happy to rebase my v4 onto struct symbols.

Definitely. I was more focused on the reference counting aspect.
Things like the policy around shrinking can be amended as needed, I
just wanted to establish a policy so the patches made sense. I think
lazier loading, shrinking, .. all make sense for things to be faster
and use less RAM.

> - The cover letter says patch 3 saves 48 bytes per symbol (two
>   rb_nodes). At edd8a9fe2eca0, struct symbol has one rb_node, and the
>   name index is already a struct symbol ** array on the DSO. Am I
>   missing a second node?

No, I'll fix this mistake.

Thanks,
Ian

> Thanks,
> Alireza
