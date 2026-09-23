Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE7D3A75B6
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190593; cv=pass; b=gVQdOURvAjnJmUMusPz7WvM6ai6WBXX4+VlQsc1cYpestrq7k2JtCsTr938Wm0/najxK4H6UyQjUaTBfL9uIlZ9tqVPIkASVvtAMPWcSyAapdxKi/fFPEV2vtA9lseJCl5ScHxx+hxyfTL79vCujPG6pYoaUq1KXR/KXiHZUyTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190593; c=relaxed/simple;
	bh=5LZM8d3innRBAzNLNsGi5lkZyJzPm9PE6/1I2v46ll8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDyAaQA++aYdHd7Ouvx5BGL/WzSIx5NdLeFY7uORjKCA16AKGGa+4Q6CkLt8Ppv0EjKihPOrtXWTukcXvYBQu3TdH7aqv3c1AXNsqmap9lQ49YL51K6Sdtz3ZL4YGbE/UadzAhS0Pq2KjMgVPdqWjQn6rLEIHMZ9XhhHChdtXkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCROIQWJ; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCROIQWJ"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-143490b97f7so2769c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 12:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790190591; cv=none;
        d=google.com; s=arc-20260327;
        b=WUKIbNUitdJkJjRIG/1U7FiFNzPU7xYsjtDg/5JQOZMwwZnvAP26OjiO8FhElodeYP
         Fs3PUxAxdcd5oW3njcdPmhX1xI8ZebY//frNgWVG+baAB7w1Y7jNlsdtDAhu5s7e2EtH
         RPaHOI0nHLh/yYqorWQjJN0bmLaRhxgsmnQ2SrtXVKOPNE2EINomiDRljyEplMFOkGG/
         W6FWGfMAsuR/mwSFkqK6mI8kFXl7vA4f23texAPg/iwhk/c0Kn4uJzj1utXtW/KPfSAk
         1vLZWfR4w5sbgpKRnn6DCKqbBEBcraCXpBHdY4Sptq90rnde5GDgel4UPSjpLpOQrcAW
         1Esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W0FYu+dVDEzIdn773qfkDF08ZIKjJFXLHOFX+/IEE1M=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=aPqANjz5hMhUJw5pfRP8ty1L/AYOna4H0Lyz26NqzN5jCqD9BcgHltroBOx/xRWUfi
         3TncYB/31thHwoN2DfIF4JSn7kLecKyV414LrjxZBJiQXDAs+n4H5KbpKXiwbB5VoLiv
         e0m323rvtsNGrdIvqUXHqzivoNXiGhFh0PB7d7HiAIZiUSna8Q7L+xZ4WyPGI56hV9SR
         B7XYkiis77b1bIRFvXuqFgWXBe8ArNkRG8+ic3980A2kIWRllGfhggVl5cRHWB/pGC99
         einkKoUb2kfVgM7DTqQdUG3dkCH3wiPegg/qjp7q6yjQxWWpntz+A+rYoyi4Br39uXPr
         Ux9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790190591; x=1790795391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W0FYu+dVDEzIdn773qfkDF08ZIKjJFXLHOFX+/IEE1M=;
        b=KCROIQWJ2JkcoawX4BJ3xMrlYnu4dg539IksSy21/y49HKB2qBm7uqMGVHVCi+AJ8o
         9i+w2irUlFvd6TycSn8riMxAjWP2XgjXplc7XlC7MKmB6Q+1Fklaa7n7sxa/UwbKDeF4
         X+Gpnp3+zbKavzPs5fxzFixF6BwC8qENphkI39WWhrTorjsL3pVqgmkuVc2s8midrkvU
         T65Xl08aGHmnsVrpSKwrJp5zHFhMev4GkuBc+/ww0888ZC3AWQzQGVmjJnXb+BQI7WIk
         qfk08+gMAWKsj49saIYrjbYsJgjIEE/5QtW1QxX+7AruLRWMu7sARASsJ5FdgyKWpASK
         DSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190591; x=1790795391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0FYu+dVDEzIdn773qfkDF08ZIKjJFXLHOFX+/IEE1M=;
        b=CqRosWyc+kYRTQf2M8os558GBiFzmMc7TqSQ68Z91AF4iNxZX8htb8BlG0WTmRZMEs
         Kq7bwZ27KaPfJQjuKZ8iEKruNkxr1IfmkADUx6EDZFCqECrrgmQWDWdNZtiU4TQSyBrg
         vtq1ASBc/QmG1plCL/msa5UdQrr9vA2UtiOvIzEl7u4kBG+frfniny10q2f1Yqh3qJPA
         AdBxX6m+uB+nBi3PIveMXs0v+LKdGgXD+GgLp+Jj2TLHu2yi1CFzsxhbFLHm24BAXvoF
         wlf/4KMQlC3YF5i9gx5Rz/3SuYF2CBMZd/ctG7Xxk6K43SJ6/w24GFWhqJwoa8C/FNh5
         TjQg==
X-Gm-Message-State: AFuF++kKoe9YLpZMal6i4DdrXaNXnh3VaGIczgueMnmRUcHnpChB+eun
	OkOcJPVuX5XbyVKWbrIVXFeGc/3eghMGT72WIi8Kp47LWw9J+EkNE2BnITk9WnxlrKlPSML/G3W
	pzwe9wpnrga7v8SWy8ujIT4GA075KD4HqkkshwOfx9Yb8HS/OSDY7r4H5+O4=
X-Gm-Gg: AYBFou3Pr4e0shOATDbhUP1uNm9Qr0yNzNM45W+4Njsj6galUgCF/zun1Rb5tuY3Vfw
	RG7nYQSgcY5uISLydwx2Y+kc/qNnXLHKBVKASR97Rtr+jkfcNzDW9UWi8iFe6o2LtCD2dW9GGyp
	1iwKK4eqhcEZMmlTG+8m2J6UKZxgDRdajzf7j/VT73C9N8KQ8tvpx7RjJgxxfASW+46m6d1KVCS
	ApolPQ32935cmW0pfgAiT/sPAeob1FTHsNlLENpWPVVeubo35MAiNlrJa/Be4Btm9yIlCgeV20H
	I7tbGeLFlthgvCAYMP4EH6B4j7cktfo5ORTJFmEVRK7eBDt+woMAlbIseUqX0PEZUkIVe/1Yobi
	7Nv22Yk9t4P6mnfN6+QnP
X-Received: by 2002:a05:701b:42c8:20b0:141:5392:d9c2 with SMTP id
 a92af1059eb24-1450301047fmr155852c88.8.1790190529723; Wed, 23 Sep 2026
 12:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-27-irogers@google.com> <20260923183554.0FA3D1F00898@smtp.kernel.org>
In-Reply-To: <20260923183554.0FA3D1F00898@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 12:08:38 -0700
X-Gm-Features: AclHuK8qhCEYQ9mG1gZ1SW8-VAFZWaY6mM26YdNCosFzZd3023TzFpnigkApBYQ
Message-ID: <CAP-5=fVZ1Czc+C-_2CYWqMo=TRJ+w9BR_s8=JTqwiztDLCo8aw@mail.gmail.com>
Subject: Re: [PATCH v3 26/49] perf python: Port sctop to perf module
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:35=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf python: sctop silently drops legacy syscalls:sys_enter ev=
ents
> --
>
> commit d8ecc80e7d73cc2057e5019382b002550902b4ce
> Author: Ian Rogers <irogers@google.com>
>
> perf python: Port sctop to perf module
>
> This commit ports the sctop.py script to a standalone script in
> tools/perf/python/ using an SCTopAnalyzer class structure. It adds suppor=
t for
> both offline analysis and live monitoring, resolves architecture-aware sy=
scall
> names, and replaces unsafe signal mutation and subshell spawning with
> threading locks and ANSI escape sequences.
>
> > diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
> > new file mode 100755
> > index 0000000000000..fb709206993a1
> > --- /dev/null
> > +++ b/tools/perf/python/sctop.py
> [ ... ]
> > +    def process_event(self, sample: perf.sample_event) -> None:
> > +        """Collect syscall events."""
> > +        if not self.offline and sample.sample_pid =3D=3D self.own_pid:
> > +            return
> > +
> > +        name =3D str(sample.evsel)
> > +        # raw_syscalls:sys_enter exposes the syscall number as 'id', w=
hereas
> > +        # per-syscall syscalls:sys_enter_* tracepoints expose '__sysca=
ll_nr' (or 'nr')
> > +        # and may have an unrelated syscall argument named 'id'.
> > +        if name.startswith("evsel(raw_syscalls:sys_enter"):
> > +            syscall_id =3D getattr(sample, "id", -1)
> > +        elif name.startswith("evsel(syscalls:sys_enter"):
> > +            syscall_id =3D getattr(sample, "__syscall_nr", -1)
> > +            if not (0 <=3D (syscall_id & ~0x40000000) <=3D 0xffff):
> > +                syscall_id =3D getattr(sample, "nr", -1)
>
> [Severity: Medium]
> Will this silently drop legacy syscalls:sys_enter events?
>
> When processing an event named evsel(syscalls:sys_enter), it matches this
> elif block intended for per-syscall tracepoints like
> syscalls:sys_enter_openat. This path expects the syscall number in
> __syscall_nr or nr.
>
> However, the legacy syscalls:sys_enter tracepoint (used by older kernels
> like RHEL6) stores its syscall number precisely in the id field. Since th=
is
> block avoids fetching id, syscall_id will evaluate to -1, causing the
> script to silently drop the event and report empty totals.
>
> Could the prefix match be updated to distinguish the legacy tracepoint fr=
om
> the per-syscall variants, so we don't drop events from older perf.data
> files?

So syscalls:sys_enter was renamed to raw_syscalls:sys_enter in Linux
2.6.35 (commit 308fd7dd9151), and sctop in live mode records
raw_syscalls:sys_enter. It seems unlikely that supporting pre-Linux
2.6.35 is a real concern.

That said, distinguishing per-syscall syscalls:sys_enter_* (with the
trailing underscore) from bare syscalls:sys_enter is straightforward =E2=80=
=94
checking name.startswith("evsel(syscalls:sys_enter_") first and
falling back to sample.id for raw_syscalls:sys_enter /
syscalls:sys_enter handles pre-2.6.35 perf.data files as well. I can
fold that into v4 if needed, or send it as a small follow-up patch.

Thanks,
Ian

> > +        else:
> > +            syscall_id =3D -1
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.30=
32038-1-irogers@google.com?part=3D26
