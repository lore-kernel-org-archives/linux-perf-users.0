Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C39296D0F
	for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070634; cv=none; b=faCu0kAiUVL5BiBNYbNfNIlJoXs/bhbjKpjSIMD9XDTd8w7ISU1EOTi30ursY0/L39m+98eCLw4h4ZgMy5LVi9WDbuWf2hGfIQLdjI+7fk/wZjR8yovroMTN7DZofQDBgIi4308vbcOt7URLXWAnSLpYW05T5QpY/6ksCzCPzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070634; c=relaxed/simple;
	bh=fmY87/1sKSBJYEJaxkHq2LMm11Jc+VfeJwKi7MDyja8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCeAG+lf0UAGW+ZNRg5BCQmniQ77Dq5akGOg85fVqBz+5/5erNbGv/JAxHxj2UMgivjQbe6A5jmRNp0V95g3bqNKwpeUFZ9Y7CNeDZB8S3wT/IB1L4kdZdFk1OocTTLnQtXQ9AXbWO/GObLEe4F1iKI74uOvmRJeG8U+CVq2IM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=337BNEfQ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="337BNEfQ"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d96836c1c2so22245ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747070632; x=1747675432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZorMDSdxCLNoei7VK6kPI/fQjzAXqqiD5NEjjIAeuZ0=;
        b=337BNEfQa6NytiM+RY9GKgwT/X85yJu80OCVv2z41Cua25OQz4O0/CPUGBdoLFVUKn
         Mv2ODAAMFSFoJMYEsrLenj64cYHXlyx7I+a4Hv1VZegRLzZ3Iut3/1OIrQEgIxtvtzK9
         8KNaEJsPw+LnUqAvD31ZCpRyktDaaib7jbEzUj0KRwaykZ/dF9LFrjQ7teVGG+tIdyNj
         cvMA0I7Fk6clPTlv0knWqMYSqTlojHrzEUsqts0we+lEVTokPZSWY2iAde1R0R9vclZB
         1Hky9bLluXgbH8pzmk5EXGUnkvfAKUO8nSM2LnUhyroaru48RsxQaQw3sn5Eo1FW0p7K
         dNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747070632; x=1747675432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZorMDSdxCLNoei7VK6kPI/fQjzAXqqiD5NEjjIAeuZ0=;
        b=A9hxDNFK3EhuTxrFmlTh3QENr9Hxw+IejXbylxPsT95GvhaA4iuKqpM/pvwJA97l93
         wNVbI02Ilk6rKBYK0o5dd+ddqbfkll7HGIPJaAgZrGY9T84vLG4k9pO1/53zsJhs2VnV
         bWiV//bbVVWp6ZugU8rSG1gdHiYxj3i0+rOtogXsa5btRSDxdJCCD+c1Cs1ubJfi0Ixa
         0yqZbFV74P0yOFvXRYbZ4D4Y40S/VPWLpIePEWabqgpX86vIWMy+UDiNracEpL5+n5sh
         NsTzTq2AvAk6fRDmcHUtZyp/BWPnMxL7Gyijf4JIS9OvAZljkqJRrbMkRgVQnYFkT7Hd
         GFxw==
X-Forwarded-Encrypted: i=1; AJvYcCUNlO5dPnAaSyV0opGXzNqt1DpzdAtk2AvJ0t28oAMQ+OO2GJYfpvoSSyBCgzFy6d4WjhLHrugzMJ1F6y7CPTAB@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4s01EK8PaTv09MDQwLh+WfkGVoqAd7Anrqa9FsUQXEY4v2jU
	rDyC8Bq4OdJ0fw/xi+FqEw8kL1i+JEckQ02XnXycgPvn4dFkekoGMiCC1od6vIzSRIAQkRzcM2/
	dC/kfMCDFJIUuLNPJ9wpXhlP+7axPDHG/mAIB
X-Gm-Gg: ASbGncvsgOATbqwX9LZF1iFEH1x+1Kb9tDxYief95Oiycm+TpSCJKJqLxiz+L0hD4oh
	DexJQ1ktsb1kHH7eatXta012SFqQm8A1ScFScCD3LlLal0L13niIINbAaxPoyFHmqd6ctkJU+up
	s40P8Bum0b8ivOtlwOup6WgcOkBlIh33sgr+EjIQxrpbo55gEp7KRgnDQTtqJgew==
X-Google-Smtp-Source: AGHT+IEwkaoOmT0XT7gKUnkQ+2ormt40tJAccvez9SS9gKpe63m0op5hTvSJFmWSWh3spwSfwGyikLVKS3Pd/hKUiUI=
X-Received: by 2002:a05:6e02:1562:b0:3d9:2b3e:835b with SMTP id
 e9e14a558f8ab-3da8430d4e4mr5478165ab.25.1747070631555; Mon, 12 May 2025
 10:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512055748.479786-1-gautam@linux.ibm.com> <20250512055748.479786-5-gautam@linux.ibm.com>
In-Reply-To: <20250512055748.479786-5-gautam@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 May 2025 10:23:39 -0700
X-Gm-Features: AX0GCFtegycvYjK-gRwyRE3BGvqRYdmDJ-ze8hRyFhYRHprKCpMHIf371Xl0jNw
Message-ID: <CAP-5=fWb-=hCYmpg7U5N9C94EucQGTOS7YwR2-fo4ptOexzxyg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf python: Add counting.py as example for
 counting perf events
To: Gautam Menghani <gautam@linux.ibm.com>, namhyung@kernel.org, acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 10:58=E2=80=AFPM Gautam Menghani <gautam@linux.ibm.=
com> wrote:
>
> Add counting.py - a python version of counting.c to demonstrate
> measuring and reading of counts for given perf events.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> 1. Use existing iteration support instead of next
> 2. Read the counters on all cpus
> 3. Use existing helper functions
>
>  tools/perf/python/counting.py | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100755 tools/perf/python/counting.py
>
> diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.p=
y
> new file mode 100755
> index 000000000000..e535e3ae8bdf
> --- /dev/null
> +++ b/tools/perf/python/counting.py
> @@ -0,0 +1,34 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# -*- python -*-
> +# -*- coding: utf-8 -*-
> +
> +import perf
> +
> +def main():
> +        cpus =3D perf.cpu_map()
> +        thread_map =3D perf.thread_map(-1)
> +        evlist =3D perf.parse_events("cpu-clock,task-clock", cpus, threa=
d_map)

Thanks Gautam! I think this is really good. Perhaps the events could
be a command line option, but I can see why you want to keep this
similar to counting.c.

> +
> +        for ev in evlist:
> +            ev.read_format =3D perf.FORMAT_TOTAL_TIME_ENABLED | perf.FOR=
MAT_TOTAL_TIME_RUNNING
> +
> +        evlist.open()
> +        evlist.enable()
> +
> +        count =3D 100000
> +        while count > 0:
> +            count -=3D 1
> +
> +        evlist.disable()
> +
> +        for evsel in evlist:
> +            for cpu in cpus:
> +                for thread in range(len(thread_map)):

I kind of wish, for the reason of being intention revealing, this could jus=
t be:

for thread in thread_map:

I can see the problem though, the counts lack the thread_map and the
thread_map is needed to turn a thread back into an index. Perhaps when
the python counts is created we hold onto the evsel so that this is
possible. I also suspect that in the code:

for cpu in cpus:

The CPU number is being used rather than its index, which is a similar
story/problem.

Arnaldo, could you give some input on what to do wrt indices, threads
and CPUs at the API level? Perhaps we need a refactor and objects for
perf CPU and perf thread, similar to the use of struct perf_cpu in the
C code. The original API all pre-dates that change. The issue is that
changing the API could break existing scripts and we can only fix
those that ship with perf.

Thanks,
Ian

> +                    counts =3D evsel.read(cpu, thread)
> +                    print(f"For {evsel} val: {counts.val} enable: {count=
s.ena} run: {counts.run}")
> +
> +        evlist.close()
> +
> +if __name__ =3D=3D '__main__':
> +    main()
> --
> 2.49.0
>
