Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9369B337BAA
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587434; cv=pass; b=BlyxySjT2GdDuvmyR2HEKBWtcfUIo3Rb6MWKlZbcmqDCItVwVicf5emO4pg/7Dcwe0BIibBPb4k8HEL1kHOYYG+en5ZUyafc2qynQBV32f+Uwdm1lflkRsfrQthmkpZ5qHj62DFGczr5vP+2lFbNGqP0BL7Rxxm+eGW28975f0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587434; c=relaxed/simple;
	bh=aqn+gN2OxI69735lSHDX86lDwmZbS9vqddn2YqjxpN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8YrnhTiV12KMMIzlsqR0ZCNBKn+A8bpX6np/ZukITUALMBUUe11CxwWaU7mAtBDheIAAxKMoeC4S1o9RWyNOoJNtECFNacFEpWPjPvTJTv2je5ZK7BJ9g5ZZp6xj/NfQyMT8unIVw6h8WsHFl1F8S0fMvXu1jTyDpIbR6Pli1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FtyZqgom; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtyZqgom"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d06cfa93so47105ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 00:03:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769587432; cv=none;
        d=google.com; s=arc-20240605;
        b=Z0xNiUXOf0QcuALpG5idkW5SAK5JnzW3+GVP8OaVdUWaZmTr2bsYvz/5yV1X6Iywig
         X8lPnSlGhh8T6Pt1jKpc1QxF5E5j2YjA9mf93YOPCbymBhlVptY3BqXf7z0hUZ8QAlyS
         GHzNjCzXPl3AU0GWZ56itYKP/89pFFG54U9EnHvBNif4+KKzeq5jn27tTPUFsZQhzuwx
         sogyZhTT4eqnzEm58yL55onJqFIYD5OMnPUMbRZvY4STR5QGOuf7SYvh7QNJfJ/Ql+1L
         NfIxobaRZDOHRxY8c7FI8Y6cRPYP8s2jA/YZhkB6U6WzMuEO4CwNq5E+mC8BVbPAMs9q
         z9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kwxqyPY7kwvh1qYq0RNe4lMNJMkXau1MJhNry6YmLss=;
        fh=mj9Ro3oXRwjUCmjMpSLWijUeOT1DNK3zM0nNGZE9R4A=;
        b=H0HIy7Qg1yAsu2CSeLsNWcN8fmKfxD5BWIQF/sC9dz9hO6tkUntcSIfBc6UAL8e68l
         10Or89loUZwSddt9/xy7pEnBl1yeN7/0HHXLpPOpfRdNNsxEXk5lfcGqx1dE+LIUduQC
         szabFBPZGRWQ4M5/sJMXY+ev6RLhu04oH2u3bwolgEG5qIC0nTMpoLNLJmoV/aqU7qA/
         X8L7wYRsWb4XRzWD6Sizf+1lKV6lfWogRB/dCf4Ev34PLmdQTeNM8u2VMf/L7VsfgurL
         +1a8GyRuMuTtfhjLVanAE8KOdwTXeg8SYm8nOeOE1IUYkVqqUAuDWIcSk0+oUz2USbc8
         NyeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769587432; x=1770192232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwxqyPY7kwvh1qYq0RNe4lMNJMkXau1MJhNry6YmLss=;
        b=FtyZqgomLOQzIcb530lwU0srOzkzzwPj8YVFumXkpsz4njhIpgUKE5+iU8QFkxvRVw
         NkvChfDP3jNBvViTnBKQWeVUy6tJLjKeYNLcwW4TiyxloUNc2hDjiufymK3/e3xQXDeI
         NfY+xUR5LwyrRvkSp5tQhD8OzuJow+lmILEvawhFOK3FleILFv/exV7lxNRCGAFoT/uy
         3Fbskhwr9wZ2S4kD9BX/Z5jKwMZ4mLxfykn+JFfi+1SsorFi9VEUZATXMeTDYpshwtgK
         B5eiGbeYXAQgvvKMpJHGv5TaEqvDzjhlhnp5FdnU+ujvUDwsTr+w9IF6TSSnQCvZsEpP
         CWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769587432; x=1770192232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwxqyPY7kwvh1qYq0RNe4lMNJMkXau1MJhNry6YmLss=;
        b=CiJL7RSgDf5yE3197LaNQe/8IkpbQG8ghGD4wglt20L93SZ+oR/FILqRSsO63+yGec
         lApUjlKylFUoHwKd6xc5Dam8bCn47C9ylVl44bujfBCHjqicbq6o7Ag9rdkbDgpcE99M
         rb++qLIwDWr7DkKIR6LlR7sPVVE7m376+bR3k50GdZ4H7PnExg5daxu28YUGnKm8HEWg
         1lDC6gVrIRgtfJ8+0KWVCX2+PHZx60Og7vZsbHRBx0K6+Z5eOQhM93rYKT7Thl8TWtPw
         cTpgo6s3GIwW9o91t5AB/FalnXKIQDRrJNvBnM0CGw8YbXqTEzqkYrfVn6ZkjqqnEtD9
         Qi/w==
X-Forwarded-Encrypted: i=1; AJvYcCU7n6tGfS3bYuRb3rFHp8QeIzxh35FWFCJNmA/ZMJHqciig2N5aUOkxHCj7+IUefh29JSBtC/FXt/KPvFhIdDVI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YFYejMBR0ZF1htnR3WRVxw5hp33FPxxaYAi2ducGdwnpro9a
	CCQWCZAFWGNUW2MQqbEd4hZghrUBzjMcw40+yhcL/TM5/kfrEgCq/XbNfJ6TPuSeOYX0yaN9MqB
	STfv2SJppIpba1YLm0wyENrSY/VaOlSjdiJV3dy1F
X-Gm-Gg: AZuq6aK2MdWOMzzsLVw303+QeOhtsydRqv8HVTLfMr9IvvOzhROR26aNx/4h4Qn/QIB
	TqAGoB7xprMafGqIxOREEpnKzf+FBOiLuxzbuzhc2JaV8lQmcbnA5tfS7nT1IvY+2og0UOz6pBQ
	Pwz2iOYPRXOC+KtkboWlLXqekhLokwepn3OwZFQr6i2Rgo0wOQnDHGjyyJPEbp9Zgo8YLAd0k7R
	OqZt9DrKE5wDWtIq/BANA/nH4OO3U6m2KsHsCEhHIY7ICbLYHXArcdD60PNY10vcJ/JXc2S
X-Received: by 2002:a17:903:3c2d:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-2a870b49cd1mr4464695ad.13.1769587431647; Wed, 28 Jan 2026
 00:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127225909.3296202-1-bwicaksono@nvidia.com>
In-Reply-To: <20260127225909.3296202-1-bwicaksono@nvidia.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Jan 2026 00:03:40 -0800
X-Gm-Features: AZwV_Qh52YOdWkzhjqwDKEE_iLJJ8-fVjQ4au_Elxnl29BT84Z16fQ67obstxk8
Message-ID: <CAP-5=fUxhbR1xs1f9mrkcUXZZNLrVqDG0ebhwW--WtgVRnNxNw@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events arm64: Add Tegra410 Olympus PMU events
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org, 
	mike.leach@linaro.org, leo.yan@linux.dev, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tmakin@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com, skelley@nvidia.com, 
	ywan@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com, mochs@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 3:00=E2=80=AFPM Besar Wicaksono <bwicaksono@nvidia.=
com> wrote:
>
> Add JSON files for NVIDIA Tegra410 Olympus core PMU events.
> Also updated the common-and-microarch.json.
>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  .../arch/arm64/common-and-microarch.json      |  90 +++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>  .../arch/arm64/nvidia/t410/branch.json        |  45 ++
>  .../arch/arm64/nvidia/t410/brbe.json          |   6 +
>  .../arch/arm64/nvidia/t410/bus.json           |  48 ++
>  .../arch/arm64/nvidia/t410/exception.json     |  62 ++
>  .../arch/arm64/nvidia/t410/fp_operation.json  |  78 ++
>  .../arch/arm64/nvidia/t410/general.json       |  15 +
>  .../arch/arm64/nvidia/t410/l1d_cache.json     | 122 +++
>  .../arch/arm64/nvidia/t410/l1i_cache.json     | 114 +++
>  .../arch/arm64/nvidia/t410/l2d_cache.json     | 134 ++++
>  .../arch/arm64/nvidia/t410/ll_cache.json      | 107 +++
>  .../arch/arm64/nvidia/t410/memory.json        |  46 ++
>  .../arch/arm64/nvidia/t410/metrics.json       | 722 ++++++++++++++++++
>  .../arch/arm64/nvidia/t410/misc.json          | 646 ++++++++++++++++
>  .../arch/arm64/nvidia/t410/retired.json       |  94 +++
>  .../arch/arm64/nvidia/t410/spe.json           |  42 +
>  .../arm64/nvidia/t410/spec_operation.json     | 230 ++++++
>  .../arch/arm64/nvidia/t410/stall.json         | 145 ++++
>  .../arch/arm64/nvidia/t410/tlb.json           | 158 ++++
>  20 files changed, 2905 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.j=
son
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/brbe.jso=
n
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/exceptio=
n.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/fp_opera=
tion.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/general.=
json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l1d_cach=
e.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l1i_cach=
e.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l2d_cach=
e.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/ll_cache=
.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/memory.j=
son
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.=
json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.jso=
n
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/retired.=
json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/spe.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/spec_ope=
ration.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/stall.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/tlb.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b=
/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> index 468cb085d879..6af15776ff17 100644
> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
> @@ -179,6 +179,11 @@
>          "EventName": "BUS_CYCLES",
>          "BriefDescription": "Bus cycle"
>      },
> +    {
> +        "EventCode": "0x001E",
> +        "EventName": "CHAIN",
> +        "BriefDescription": "Chain a pair of event counters."
> +    },

Cool stuff :-)

For wider counters AMD does something similar, but should this be an
implementation detail rather than an exposed event? How does it
operate as an event?

[snip]
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pm=
u-events/arch/arm64/mapfile.csv
> index bb3fa8a33496..7f0eaa702048 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -46,3 +46,4 @@
>  0x00000000500f0000,v1,ampere/emag,core
>  0x00000000c00fac30,v1,ampere/ampereone,core
>  0x00000000c00fac40,v1,ampere/ampereonex,core
> +0x000000004e0f0100,v1,nvidia/t410,core
> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json b/t=
ools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
> new file mode 100644
> index 000000000000..532bc59dc573
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
> @@ -0,0 +1,45 @@
> +[
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED",
> +        "PublicDescription": "The Event counts Branches which are specul=
atively executed and mis-predicted."

nit: The capitalization on Event and Branches, as well as other words,
is a little unusual.

[snip]
> diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json b/=
tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
> new file mode 100644
> index 000000000000..18c2fd58ee9e
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
> @@ -0,0 +1,722 @@
> +[
> +    {
> +        "MetricName": "backend_bound",
> +        "MetricExpr": "100 * (STALL_SLOT_BACKEND / CPU_SLOT)",
> +        "BriefDescription": "This metric is the percentage of total slot=
s that were stalled due to resource constraints in the backend of the proce=
ssor.",
> +        "ScaleUnit": "1percent of slots",
> +        "MetricGroup": "TopdownL1"

Note, on x86 we place TopdownL1 in the Default metric group so it is
shown by `perf stat` when it isn't given events or metrics to compute.
Perhaps you want to do something similar?
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json?h=3Dtmp.perf=
-tools-next#n116

Thanks,
Ian
