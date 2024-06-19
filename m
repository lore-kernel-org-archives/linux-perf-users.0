Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425A335A7;
	Wed, 19 Jun 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808675; cv=none; b=HyqwggOo8n+uMTP82bg5ZGT+ewEoceqqk02Qp1OFgeLsoL8EqbTuC+D0ot1jYH1cbfVTSzeZdPSeMvUnUJwsIItIc8ZlTZbosXpMcalBCve6UcFrt+K+ocVYi/B7PhbkSm778DigReTgJoHcdsolV89868VgaGW+ebPD75Xhj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808675; c=relaxed/simple;
	bh=ejFVPxL2Cbfs4eg3yoSzWasTDViAd+04TbnoBet+RR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9Y6QzjBGU4iS19yPc7Ec1M+jbH7v+q+aQKdl+r7CYmwg0sUeeCWU95q6Ly16fwcSjDl0tVwFSvT+nW9SIdzHIwwHtjB0hwjSQR2zaa330YW/2ROWf6+rWE1l69zKIRRa9coBxQEcK3nzu6ybREph4Px8rDid6u6QhWBue/Eb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso3910419a12.0;
        Wed, 19 Jun 2024 07:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718808673; x=1719413473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ajs9iVzkp72InwEDYOdKR9Ht6Xu0dx3o2OGDillctA=;
        b=U5rklNASsY9+2My3UpYB4fGioQQvg8I+E5PbHRQpCWDDWm8npCTGAUwmcJdFwGhg8L
         zcHh6b4oda0T1qY8l+WIJA3vrJ3Il5kkdmrqfBWCuVxaSfZoZNkNHIUQM+Ad/Yf9O3JZ
         HuZUWn0SgdVaDKlAwYd6voAJpGSBMkZ6CIfyFkBsvjAFX6YPe0XLI/ZkMamK5Cxy6NmK
         P+FUiQhqVgKQt3I3cHBhxWkl1qyj8Y0DpKc50FpPo+liTrmyL2v86vdKQ1C0mvEatTit
         tKM/oI3wCqrdsnjSBHm9ocDd0zk3xHeabDHeu25WCT5ceRSlmro8+FDt/cHgO/d2boGg
         M77g==
X-Forwarded-Encrypted: i=1; AJvYcCXlS7RY5S3+PKa4OGkrs1XLKvSKDblsH9gUp9VuiPL2p1UXZjXTD697YCaYn1Pd7aDlly9tPCcSnTFFC+TSVpJZvBuxMa/abrxLZ/93dXRTI+lB6A+PDvvpYJ/H1ol5ZCsH/oJyZtcuHeGrG+fvOg==
X-Gm-Message-State: AOJu0YzFWqsy9u3vDkSLfMKxlz1XXCX9eidp3vN3QfCGsiJ/5c8Ra31E
	HoGtjabVsnbFim20qIESItWW5cAwzO0a54wdzt5Y5So6BBwiHzps3yJzXlcE1RfR1oRWi9Vmumm
	tQ/XPfU/uetjc3fKoFwT8naffS9Y=
X-Google-Smtp-Source: AGHT+IGy+4YxdJeCaNbJh9tTzf2ag/kTCv+ttsFhbIC4FykVzC/6jaIAOOoHpKmJ9sVJSYht/B3kR5+DaclHwBLrv5w=
X-Received: by 2002:a17:90a:1fc7:b0:2c7:c788:d34d with SMTP id
 98e67ed59e1d1-2c7c788d4dcmr1547027a91.38.1718808672525; Wed, 19 Jun 2024
 07:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619092234.1165-1-ravi.bangoria@amd.com>
In-Reply-To: <20240619092234.1165-1-ravi.bangoria@amd.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 19 Jun 2024 07:51:01 -0700
Message-ID: <CAM9d7chpM4k+BRNNf6V0OS1PRX7c9f+QXa0EwKWjPPzAZVYZBw@mail.gmail.com>
Subject: Re: [PATCH] perf doc: Add AMD IBS usage document
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	yangjihong1@huawei.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, sandipan.das@amd.com, 
	ananth.narayan@amd.com, santosh.shukla@amd.com, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Adding Stephane to CC.

On Wed, Jun 19, 2024 at 2:23=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> Add a perf man page document that describes how to exploit AMD IBS with
> Linux perf. Brief intro about IBS and simple one-liner examples will help
> naive users to get started. This is not meant to be an exhaustive IBS
> guide. User should refer latest AMD64 Architecture Programmer's Manual
> for detailed description of IBS.
>
> Usage:
>
>   $ man perf-amd-ibs
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks a lot for adding this documentation!  A nitpick below..


> ---
>  tools/perf/Documentation/perf-amd-ibs.txt | 126 ++++++++++++++++++++++
>  tools/perf/Documentation/perf.txt         |   3 +-
>  2 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/Documentation/perf-amd-ibs.txt
>
> diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Docum=
entation/perf-amd-ibs.txt
> new file mode 100644
> index 000000000000..d3dfa71e320c
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-amd-ibs.txt
> @@ -0,0 +1,126 @@
> +perf-amd-ibs(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +perf-amd-ibs - Support for AMD Instruction-Based Sampling with perf tool
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'perf record' -e ibs_op//
> +'perf record' -e ibs_fetch//
> +
> +DESCRIPTION
> +-----------
> +
> +Instruction-Based Sampling (IBS) provides precise Instruction Pointer (I=
P)
> +profiling support on AMD platforms. IBS has two independent components: =
IBS
> +Op and IBS Fetch. IBS Op sampling provides information about instruction
> +execution (micro-op execution to be precise) with details like d-cache
> +hit/miss, d-TLB hit/miss, cache miss latency, load/store data source, br=
anch
> +behavior etc. IBS Fetch sampling provides information about instruction =
fetch
> +with details like i-cache hit/miss, i-TLB hit/miss, fetch latency etc. I=
BS is
> +per-smt-thread i.e. each SMT hardware thread contains standalone IBS uni=
ts.
> +
> +Both, IBS Op and IBS Fetch, are exposed as PMUs by Linux and can be expl=
oited
> +using Linux perf utility. Following files will be created at boot time i=
f IBS
> +is supported by the hardware and kernel.
> +
> +  /sys/bus/event_source/devices/ibs_op/
> +  /sys/bus/event_source/devices/ibs_fetch/
> +
> +IBS Op PMU supports two events: cycles and micro ops. IBS Fetch PMU supp=
orts
> +one event: fetch ops.
> +
> +IBS VS. REGULAR CORE PMU
> +------------------------
> +
> +IBS gives samples with precise IP, i.e. the IP recorded with IBS sample =
has
> +no skid. Whereas the IP recorded by regular core PMU will have some skid
> +(sample was generated at IP X but perf would record it at IP X+n). Hence=
,
> +regular core PMU might not help for profiling with instruction level
> +precision. Further, IBS provides additional information about the sample=
 in
> +question. On the other hand, regular core PMU has it's own advantages li=
ke
> +plethora of events, counting mode (less interference), up to 6 parallel
> +counters, event grouping support, filtering capabilities etc.
> +
> +EXAMPLES
> +--------
> +
> +IBS Op PMU
> +~~~~~~~~~~
> +
> +System-wide profile, cycles event, sampling period: 100000
> +
> +       $ sudo perf record -e ibs_op// -c 100000 -a
> +
> +Per-cpu profile (cpu10), cycles event, sampling period: 100000
> +
> +       $ sudo perf record -e ibs_op// -c 100000 -C 10
> +
> +Per-cpu profile (cpu10), cycles event, sampling freq: 1000
> +
> +       $ sudo perf record -e ibs_op// -F 1000 -C 10
> +
> +System-wide profile, uOps event, sampling period: 100000
> +
> +       $ sudo perf record -e ibs_op/cnt_ctl=3D1/ -c 100000 -a
> +
> +Same command, but also capture IBS register raw dump along with perf sam=
ple:
> +
> +       $ sudo perf record -e ibs_op/cnt_ctl=3D1/ -c 100000 -a --raw-samp=
les
> +
> +System-wide profile, uOps event, sampling period: 100000, L3MissOnly (Ze=
n4 onward)
> +
> +       $ sudo perf record -e ibs_op/cnt_ctl=3D1,l3missonly=3D1/ -c 10000=
0 -a
> +
> +Per process(upstream v6.2 onward), uOps event, sampling period: 100000
> +
> +       $ sudo perf record -e ibs_op/cnt_ctl=3D1/ -c 100000 -p 1234
> +
> +Per process(upstream v6.2 onward), uOps event, sampling period: 100000
> +
> +       $ sudo perf record -e ibs_op/cnt_ctl=3D1/ -c 100000 -- ls
> +
> +To analyse recorded profile in aggregate mode
> +
> +       $ sudo perf report
> +       /* Select a line and press 'a' to drill down at instruction level=
. */
> +
> +To go over each sample
> +
> +       $ sudo perf script
> +
> +Raw dump of IBS registers when profiled with --raw-samples
> +
> +       $ sudo perf report -D
> +       /* Look for PERF_RECORD_SAMPLE */
> +
> +IBS applied in a real world usecase
> +
> +~90% regression was observed in tbench with specific scheduler hint whic=
h
> +was counter intuitive. IBS profile of good and bad run captured using pe=
rf
> +helped in identifying exact cause of the problem:
> +
> +       https://lore.kernel.org/r/20220921063638.2489-1-kprateek.nayak@am=
d.com
> +
> +IBS Fetch PMU
> +~~~~~~~~~~~~~
> +
> +Similar commands can be used with Fetch PMU as well.
> +
> +System-wide profile, fetch ops event, sampling period: 100000
> +
> +       $ sudo perf record -e ibs_fetch// -c 100000 -a
> +
> +System-wide profile, fetch ops event, sampling period: 100000, Random en=
able

Can you please add a brief description of what 'random enable' means?

Thanks,
Namhyung


> +
> +       $ sudo perf record -e ibs_fetch/rand_en=3D1/ -c 100000 -a
> +
> +etc.
> +
> +SEE ALSO
> +--------
> +
> +linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1=
]
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation=
/perf.txt
> index 09f516f3fdfb..cbcc2e4d557e 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -82,7 +82,8 @@ linkperf:perf-stat[1], linkperf:perf-top[1],
>  linkperf:perf-record[1], linkperf:perf-report[1],
>  linkperf:perf-list[1]
>
> -linkperf:perf-annotate[1],linkperf:perf-archive[1],linkperf:perf-arm-spe=
[1],
> +linkperf:perf-amd-ibs[1], linkperf:perf-annotate[1],
> +linkperf:perf-archive[1], linkperf:perf-arm-spe[1],
>  linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
>  linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
>  linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
> --
> 2.45.2
>
