Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF21A9B52
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705600; cv=none; b=elePZaRz/cQeFnoPolbZJfvblawZEaGWdSP0QpSNxjgILH7eDPOlvVFHRQ2My9IyvMZkEuN0lDFHHe7J3ByqtYQzSIcm0A4Aa+Z70paaeY1L4Z57gPvMIpTW5VjhtJkzRtdkLiVSpXlzyqqxgRHBbJXzD8r73CWjIyqBpLmLU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705600; c=relaxed/simple;
	bh=/P/DJBNjnkE1qjkQdZ+TBvKziziGjZZ0noq0dtdTInY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWwgDLAyYRP84D7qkHhCkC1bRGFCS1B4LtMQxFN2V33K1CENtsMyoI5t1rKuEnSyuKSf63t5jbQfbHScoofcRTotb/KR+99JujvCpFrtqrl/IXkwA7vVfQCGqR2UTUbIL5lKBU1b/YQOHsVnpP7ufyAD2cGJSFMRFDHmtuDuYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3QyJY/qX; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3QyJY/qX"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so81245ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749705598; x=1750310398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPdoN3ANegyWeQsOHYYrepeIprAZYiuTk2oe8aUOr7k=;
        b=3QyJY/qXBgE/3JI1FBWFZSMjw0HV6K0Po6G1v/Hgvink9N4Aoy374zYsIxEG4PIXaN
         t+R+iguaZq5hkUXQJxHhrRrXArpJYIDkP4rauhz8oAzOkBwb3StW2ZFEPdGclXa8rK3b
         yrMLJ+pSiR1z/8PNn+XDdEBDIHyAxNkcWDSJIS4kqvPeLuyh0hFjTm+SSX6RynJfSDZ5
         3FiX2qMUjbSbK6B/2X2ZOudeiCz9Ccsvm4k0tXYW/OSA/5lpefkYLNq89MhFfAa2c7BN
         9vbeyuBQope0mpZrmE163PPXi2mgrmMXSnpkorZLOUKB9DCyHUWFb2jD0NBqV8vYiD47
         pCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749705598; x=1750310398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPdoN3ANegyWeQsOHYYrepeIprAZYiuTk2oe8aUOr7k=;
        b=PqlJOnACakreI+ajrUGwBoyrzhPDVMbecf+3UdnJgoAypxcMIs1ZLCg76cjb2TiGm2
         Jjb//OpyI/lJ/ccwdBlpjYHjPmAFtssNPIHCVz1h+/RfXJ48Die5MnLRMQZXZcjeoWdP
         r7tgAe67v0oTcv7ECHJ/BQTXUFNnQ3BVfQ2Ie9pXtK4jNy0MHEKM7PfGz+zySJOciZyA
         jMiqepuir4slEerfPjW5dptzC8rBm8f+aRhkFtIDqRSeiBhGVSvIgNbDkguD55pKv2HF
         QIPdM3qpu2/Q9zLlUOXapUktK0ssq5d7HOKHx0rpMvLWkAompWNOvY40tfzc7EF4aZL/
         0Csg==
X-Forwarded-Encrypted: i=1; AJvYcCVKcydQJC9xuFVFFYPqqRidOiEHB0I3NL6JB8fYMx0+/ksbVFq6d2D6BnmVm27cSUKBm1h5fpSYg5mDxS+PJCcJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcVh91IR/xSvPW8lsAHLu8hfmTdNcZ5uRKu68EyVz5E/n7+i4
	XTW+4LKfA+sFNu/LzQ0f9EnZukcsuoDOvoAWbsrSTjT9hwSHlCB4tdIcj9D4YjJ8pUBV+mltIrk
	qIvzCquNd/8rHzwngWl8VF4vTo5qJfToYRiZ/f1H7
X-Gm-Gg: ASbGnctf0gtprdO+vWDHyBBSYoMv3rk10B69EJPI9wEpPdjXpukWGdXLYZ2LjYQhAr5
	nAMp+FEAZDBtkyS32m+IyYf5GFZAeHTk7njR8nR2l9jVFOYxUzuXKuUWTIcp22I0EaPUL5zV8PE
	qglhSBNgUQG01nR5vgtuLhcPSGEFWDNjF6jMWUJi2QDh0W
X-Google-Smtp-Source: AGHT+IE6oV9iOMyIcpwlHWNYge5b/BoungKrS8bwm6ti65Mcya/37bLaga6JzbosXVWRoP8lK6P3M/Ks+VBczEJ7PTA=
X-Received: by 2002:a05:6e02:1c2e:b0:3dc:a380:3ab2 with SMTP id
 e9e14a558f8ab-3ddfbf0ad0dmr1082915ab.21.1749705597948; Wed, 11 Jun 2025
 22:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com>
 <aEnLBgCTuuZjeakP@google.com> <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
In-Reply-To: <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Jun 2025 22:19:44 -0700
X-Gm-Features: AX0GCFte5AogP3jzRMvEYvmxDFDHCWazF4ReJJeWZMJbQRTGtHjlNclFAxfsZPw
Message-ID: <CAP-5=fW1FhaDcG54OS=_65gxmehjDTR+1XqCPWMX-aw9reJHdA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf: generate events for BPF metadata
To: Blake Jones <blakejones@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
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

On Wed, Jun 11, 2025 at 5:39=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> Hi Namhyung,
>
> On Wed, Jun 11, 2025 at 11:29=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > I tried to process your patches but it failed to build like below:
> > [...]
> > Please run 'make build-test' and send v4.
>
> Very sorry about that. I've fixed the two issues you noticed, as well as
> one additional one where I was using the wrong include path to check for
> the presence of the libbpf-strings feature.
>
> I'm trying to test my fixes using "make build-test", but it's proving a b=
it
> of a challenge. I installed libgtk-4-dev, binutils-dev, and libopencsd-de=
v
> to fix build problems as they came up; I also installed libtraceevent-dev=
,
> but somehow it still wasn't detected by the build process and so I had to
> use NO_LIBTRACEEVENT=3D1.
>
> Even after installing these libraries, I'm still hitting errors when doin=
g
> "make build-test" on a copy of the perf source *without* my changes:
>
>     In file included from util/disasm_bpf.c:18:
>     .../tools/include/tools/dis-asm-compat.h:10:6:
>         error: redeclaration of 'enum disassembler_style'
>        10 | enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
>           |      ^~~~~~~~~~~~~~~~~~
>     In file included from util/disasm_bpf.c:15:
>     /usr/include/dis-asm.h:53:6: note: originally defined here
>        53 | enum disassembler_style
>           |      ^~~~~~~~~~~~~~~~~~
>
> I noticed that tools/perf/BUILD_TEST_FEATURE_DUMP has
> "feature-disassembler-four-args=3D0" and "feature-disassembler-init-style=
d=3D0"
> as of when this failed, which seems to be upstream of the observed failur=
e
> (the version of binutils-dev that I installed seems to have newer-style
> versions of these interfaces).

Fwiw, binutils is GPLv3 and license incompatible with perf which is
largely GPLv2. This patch series deletes the code in perf using it and
migrates the BPF disassembly to using capstone or libLLVM:
https://lore.kernel.org/lkml/20250417230740.86048-1-irogers@google.com/
The series isn't merged into upstream Linux but is in:
https://github.com/googleprodkernel/linux-perf

Thanks,
Ian

> Is there anything written up about how to set up a machine so that
> "make build-test" works reliably?
>
> Thanks.
>
> Blake
