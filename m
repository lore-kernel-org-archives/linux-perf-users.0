Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A068060D
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Jun 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432945; cv=none; b=qzzufRhgsBabeNO5r4xO49rYDIr8i/4vPMZmQXRrH+AF4HOK1eOsAdOzxbrA3GVYli5ljSjDB6ATNUw1z+4iTbaxL7zoSdNRh+/Ncx+8MNcHdrE4wEo44YXopUUr+FyLhn+thdIpULjZ9jaI45MBsBx3DjGE2uFh4E6IiWDw0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432945; c=relaxed/simple;
	bh=rCO/0WLOENkK+IPJAT6qBe/hoq8l0TjQG4SW4fVkGBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYPQJB+9zJwfBOIyfjXvrUy3S41mWvQj/VM9YLDgMug0MYHwVnbjXhB3mW9/KJExi8lSfEWevq71at26zsGU9KbYZcDo73wMF1eJZGO60E2VZ7wJK6pro7X+nW0f28Z9CyRswjwLVnucejL/mPbq4wodkgFzbjIDrVvfHX+y2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2iwhxlym; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2iwhxlym"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43fe3289fc5so1851cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jun 2024 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717432943; x=1718037743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiMgs6ofu68NCD36BOAr5OSNcCuY8Lq+ii+XETURtvY=;
        b=2iwhxlymhThuwG5HiEYjbPCRjQOMvcDkif7e5TSjD7a17ln4cRj6jYolYJpTUPH2u3
         4hpfDCCpncIZgq+VJvmZvObDmwhr2HKsPnjnAtK2fNt8wQptPbexR6+UiZ2ZDZMqWsbH
         3PVikn30mIop9zprsI7CA6BH59jLve0+rN5Nd4lT7U8nm64yr65TcSYe9t4nls0ZoNFW
         E9s42vargoN/dpjpMxiMNIlSMFkfW3b3wt4wHxDqv96+flb0EzxQz6llQYMfAXEWmkS/
         6/SsEzp37oHKh0u8YgQwaVs0slphin96VjrzQZTo2DyetoIImCh+vZpblwOAqwBlzIPz
         Zy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432943; x=1718037743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiMgs6ofu68NCD36BOAr5OSNcCuY8Lq+ii+XETURtvY=;
        b=qVOc68tDoa1rQomJlaquXLKsr7sCnh2EcpSY8k7OUdjT7LnI63eakJR3O0UBEdvu92
         yWHcgx2FQL2yJbQWauKBktX1xN8jKumImuyxKOrMgM9VjeKaC/UmhhDKBJcLbQd2Mvft
         YaGS2Z0LKDEJAeBUViQYZbRw35PbNSMFZi8mV9nAnkcTnoXbGhviooaUZbGCSNxBiuEx
         mC4Cwn7OZQlm9XHkTFEocjykyBzyuQgHh5aMMk3iGRmFbd1x8e3CwDl4dPvBt3Gg01RR
         Zi+AUOlZvoaHssmSl6A8VDwiiJMsCufTSiTtjXyr/zmt0bsXWo3HIH95jgWqp8FrXUUS
         aBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2yN881ORnwRhVUy1wNgGIkAzOnMj3TG99Ip85j/zheg1XtPgyZBBp8YmOb8HE71hkslwfkFnz+rwVEfuhvJrPkQnfEpJxRl8OS5CiwtccnQ==
X-Gm-Message-State: AOJu0Yy9OECdE31Vg9Ef6+NexVcX12w4y8AGG97cCAYfqiFRRVDVJmtt
	6vRHcbqQgpCnv9uGagwgseIiRYHWr5COpTmHoRJlrVXj+qOC11HEVbHVa3AlOgRUpjdK2V1l57j
	SqrLT36VMsJF43CAUsJfaUIL2ALNcL63KEIyi
X-Google-Smtp-Source: AGHT+IH6QLcAlf5vaH+UWsvJQZ3C5XzA8iLHk/IQp/niw6y6V1UZ6rx7vSOE8qRJ8e53gphDMK4TwxshkC6hAh95HlA=
X-Received: by 2002:a05:622a:5509:b0:43a:db0c:ed9c with SMTP id
 d75a77b69052e-43fff375484mr5104801cf.15.1717432942271; Mon, 03 Jun 2024
 09:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com>
In-Reply-To: <20240603092812.46616-1-yangyicong@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 09:42:10 -0700
Message-ID: <CAP-5=fXw0=dHORC-kObYFiAco64PGP4_uFr__f9YmVctWtGSfA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Perf avoid opening events on offline CPUs
To: Yicong Yang <yangyicong@huawei.com>
Cc: will@kernel.org, mark.rutland@arm.com, acme@kernel.org, 
	namhyung@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, james.clark@arm.com, dongli.zhang@oracle.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:33=E2=80=AFAM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> If user doesn't specify the CPUs, perf will try to open events on CPUs
> of the PMU which is initialized from the PMU's "cpumask" or "cpus" sysfs
> attributes if provided. But we doesn't check whether the CPUs provided
> by the PMU are all online. So we may open events on offline CPUs if PMU
> driver provide offline CPUs and then we'll be rejected by the kernel:
>
> [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online

Generally Linux won't let you take CPU0 off line, I'm not able to
follow this step on x86 Linux. Fwiw, I routinely run perf with the
core hyperthread siblings offline.

Thanks,
Ian

> [root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --time=
out 100
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for e=
vent (cpu-clock).
> /bin/dmesg | grep -i perf may provide additional information.
>
> This patchset tries to avoid this case by:
> - Double check the PMU's cpumask in the perf tool and only include online=
 CPUs
> - Trying to make the PMU drivers only export online CPUs in its "cpus" or=
 "cpumask"
>   attributes
>
> Previously discussion can be found at [1]. Will suggested to do it in use=
rspace.
> I think it makes sense to do a double check in the perf tool in case the =
driver
> doesn't do this. So PATCH 1/3 is added in this version.
>
> [1] https://lore.kernel.org/linux-arm-kernel/20240410095833.63934-1-yangy=
icong@huawei.com/
>
> Yicong Yang (3):
>   perf pmu: Limit PMU cpumask to online CPUs
>   perf: arm_pmu: Only show online CPUs in device's "cpus" attribute
>   perf: arm_spe: Only show online CPUs in device's "cpumask" attribute
>
>  drivers/perf/arm_pmu.c     | 24 +++++++++++++++++++++++-
>  drivers/perf/arm_spe_pmu.c | 22 +++++++++++++++++++++-
>  tools/perf/util/pmu.c      | 13 +++++++++++--
>  3 files changed, 55 insertions(+), 4 deletions(-)
>
> --
> 2.24.0
>
