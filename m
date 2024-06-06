Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681436F068
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657506; cv=none; b=rjBq0gSn9BrFG/65/CRTQWfSMtgQcnK8QMabZmJbSrkEPnDIpr0q/IrCVBR4jvJreajbL3DT6wykfsumBpDN7TqUtHS/bQlG3bHVg9ejjfrZ4T45ULRAbrfIFPgRsN1Ya5fSIBLdhpanV9CRaObmmo5CIgQu8NCCOijH88cy7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657506; c=relaxed/simple;
	bh=lLbPi6PEtx7mcrA74H59gkeJ2Vj+bCUKyXS/pK0obXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPZfdn6WNYiWJiFTBRT6TDO7w+FTwjQUjdpP91bav6Um9rB7ItwwKylPhdFWGlPOP0qrnujIXTzNHoWc4PYePbiewnEo3lL0Gy/7/Nw41EfcCiaGzNUTwXpEHjDMKqceVtBAqpS2EB+UwJHcRhi914uw0g0leuRr+5g972tKxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SE8UQjt; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SE8UQjt"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3748a185da1so74225ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jun 2024 00:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717657504; x=1718262304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbGdl+80JsgZCzp3psor20iOdoziZwxzCaIswtJY5jk=;
        b=0SE8UQjtcdLXSac2dOqqHjopUll3AWsouvM6ijlWsMd4HZ3w2D83gxwQx5afQX7+xp
         8ON5PpNqLhxzPrI0zedeFsZSsQY79tJ3xdaqdo4LyK0HuhQrkfS45XgwgUGtAIHqEQUG
         2wR3yKZnpOIUADP9ZZQ0TelqR11Eeg0Y5xhnsd7ICTZPimbzwJwZmZlBl/I6Q9AxCIdq
         vOsMXgrttOXqHdDamnINgP/tWjLJ1fZx5ba6JFHs7wDePy3xQ21yus4BB14rXKTPVD8S
         SMVFxcgkdYin1r+dAzSN+lduTgviUPhau2SYaFrIYQZ59AYQtnwH8DBXekLWgP6wlszg
         hOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717657504; x=1718262304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbGdl+80JsgZCzp3psor20iOdoziZwxzCaIswtJY5jk=;
        b=VNW6grV4opiT1Z8R08aJ4YUyET3kdhvfuBbJ8dE3c5aE0mr8DFgCVpFu7HrEN1ZxZe
         zCI8TGPFHlVvoEP1Chtp5tzAtsZ/ytnWuiClXNI65QsIRoCkJemLCCxto+JmZZpvHM/h
         YpWgc0wsBpvuf5g3kZbWsD4kLt1OqPIB64g7AgZW1eiQL+051SUSWLvrd+KqcjH2oPD7
         7XRDq9F9CAJ5oXbKzxITnNZSGr/r/PY3jkVBfU/7iSSe4/WY6GY4iRkFw1DdfAPOuhQU
         MSb3SMWuCslErj1eLLlya7LgDMOs3nYUDApYLs+4QOlf19C+Yx8YN+DnxtyjbW22K6MZ
         Fhww==
X-Forwarded-Encrypted: i=1; AJvYcCVfMOBnES+r9SG6Hjbau8c05MaD7cJy62E/rV3MvnwuGX2H+jWGHkVm/VodglU9eHYGkW/T5vvDfbfbv0XGp8q0Ei9HZUBWux67HeX2ZmlEMw==
X-Gm-Message-State: AOJu0YwSjrpg5Q1I3bNpbN7IrpRoqjUPxVRe+8Qs5BU4a7bxgpgRilLj
	DH6XfN/jvwmdN34uhNyVA8NIIPqrQNUjzTIIUVBxEkchAeB8piNgJ4/ikSxPrVOsdzIISF5SrRB
	Vdn7K2j/DPxTmsP13lsy+xJU3d70ctjfrI4/Q
X-Google-Smtp-Source: AGHT+IHq+uj/5GSwZtHD9DsLDpdeqv/Osc7fiQ3uXZR8SK9wgzoiJMMqTITEcXpxCbgTKoPzuvi+2CNpKDTqVM1bDDw=
X-Received: by 2002:a92:50b:0:b0:374:930f:e49b with SMTP id
 e9e14a558f8ab-374ba8c21f1mr2074375ab.24.1717657504452; Thu, 06 Jun 2024
 00:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com> <CAP-5=fXw0=dHORC-kObYFiAco64PGP4_uFr__f9YmVctWtGSfA@mail.gmail.com>
 <3f43ecf1-ae3c-3418-9798-9f1aa0dcc3d2@huawei.com>
In-Reply-To: <3f43ecf1-ae3c-3418-9798-9f1aa0dcc3d2@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Jun 2024 00:04:51 -0700
Message-ID: <CAP-5=fXw60RL=FBP4znRCCwvjmajcf2QpY_70Uf1J-ozutWVng@mail.gmail.com>
Subject: Re: [PATCH 0/3] Perf avoid opening events on offline CPUs
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, will@kernel.org, mark.rutland@arm.com, 
	acme@kernel.org, namhyung@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, james.clark@arm.com, dongli.zhang@oracle.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 1:04=E2=80=AFAM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> On 2024/6/4 0:42, Ian Rogers wrote:
> > On Mon, Jun 3, 2024 at 2:33=E2=80=AFAM Yicong Yang <yangyicong@huawei.c=
om> wrote:
> >>
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> If user doesn't specify the CPUs, perf will try to open events on CPUs
> >> of the PMU which is initialized from the PMU's "cpumask" or "cpus" sys=
fs
> >> attributes if provided. But we doesn't check whether the CPUs provided
> >> by the PMU are all online. So we may open events on offline CPUs if PM=
U
> >> driver provide offline CPUs and then we'll be rejected by the kernel:
> >>
> >> [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
> >
> > Generally Linux won't let you take CPU0 off line, I'm not able to
> > follow this step on x86 Linux. Fwiw, I routinely run perf with the
> > core hyperthread siblings offline.
> >
>
> It doesn't matter if it's the CPU0 offline or other CPUs. There's no rest=
riction
> for CPU0 can go offline or not on arm64 and I just use this for example.
>
> I cannot reproduce it on x86. I think it may because we're initializing t=
he
> pmu->cpus in different routines in pmu_cpumask(). There's no "cpus"
> for x86's core pmu on my x86 machine:
> root@ubuntu204:~# ls /sys/bus/event_source/devices/cpu/
> allow_tsx_force_abort  caps  events  format  freeze_on_smi  perf_event_mu=
x_interval_ms  power  rdpmc  subsystem  type  uevent
>
> So pmu_cpumask() will infer it as an core pmu and initialize the cpus
> with online CPUs [1]. For arm64 there lies a "cpus" sysfs attributes
> so pmu->cpus are initialized from the "cpus" without checking each
> CPUs is online or not. That's what proposed in Patch 1/3.
>
> There's a "cpus" sysfs for x86's hybrid machine, reading from the code [2=
].
> And it seems always reflect the online CPUs supported by that PMU.

Thanks Yicong, looking on a hybrid machine and taking cpu1 offline I
see the PMU's "cpus" not containing the offline CPU. I think this
supports that the PMU driver should be fixed for ARM, but we'll also
need a workaround in the perf tool for older kernels.

Thanks,
Ian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n779
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree//arch/x86/events/intel/core.c#n5736
>
> Thanks.
