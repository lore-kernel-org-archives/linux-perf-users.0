Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3BF3D65
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Dec 2023 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOtc8Fhm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d0b2752dc6so22058805ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 17 Dec 2023 19:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702869670; x=1703474470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/28ZywOSlKqND0ISQ30FtfDUmHzZ70IYRw917OerE4Y=;
        b=XOtc8Fhm4De1DgTiSgWHi+r5+sshGzK88qw4QCvhEPSv7FllmPDFsHeojOT4XhTE48
         5FZnqKho3rs0IXBqJC/LbFyOdlToPQI0u66AAEBou9aFzZz5FT4g34WAMBscGc+N8hLV
         mq+Yr9RNMPIT0fiDElz5mYeXEMhNbq6hVyUYqjVIULDl9CyJa35wKjyKKkhdGMmd1gK2
         lpECMtsl7JX9tmxBdCbpHF4fpJrQNG4S13ElvFpIbyHzZ7zq6K0w530TM+g04C9ZmjaP
         hdnHYnCoITDWoVqX0elphMl0WIGGu78VXcQQc5pNmcO6xW3oB8zZ6h6S8l/iKkZ90Hye
         CprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702869670; x=1703474470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/28ZywOSlKqND0ISQ30FtfDUmHzZ70IYRw917OerE4Y=;
        b=rmkgNBL6piLZH057l/i1MYsCinEAKTFf380s05UWYkHCRvTOHph1ryg+tjEoQ5ZYtv
         9dtO+C8JmX7CP1faIsI4VRL90X6oVhHZKt08Z7y/H+N/gQoiS7qSqW+69lH88D8Rn26s
         71Xt3ZxqhqcM3LrJPDVzmklNjThKfC/0yG4yESVxAUKvHRLAbhCAo3rza4+a/Z3LUn9c
         pgvochBfmO6ONRH5MtpB5xqMvDW5b+WlRxofoOYBn3NNB8SlnjSNkXmn8qn38b+F+WVq
         XTYXxiIo0engP8cG70uyVUmC1lon4cSa4rgVgkZFkV6lnb0IN0YMawmxoYiFWsVMUTa1
         WQFg==
X-Gm-Message-State: AOJu0YypkImvTLVMvQf1VIw6B8Bll9G/5q54vdQOnUut6UWpBc5e1VG2
	9agZGr6vGspPYZO2Tm0RLglDhQ==
X-Google-Smtp-Source: AGHT+IE6WuTouKMbF3OqzInBMY1Lm2M8cHnbneJCmvjO3UMKMqwZz+4cmkefrF2e2E/oBfz5awi4hA==
X-Received: by 2002:a17:902:f544:b0:1d3:7643:b963 with SMTP id h4-20020a170902f54400b001d37643b963mr7484196plf.38.1702869670127;
        Sun, 17 Dec 2023 19:21:10 -0800 (PST)
Received: from leoy-huanghe.lan (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902edca00b001cf96a0e4e6sm950994plk.242.2023.12.17.19.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 19:21:09 -0800 (PST)
Date: Mon, 18 Dec 2023 11:21:01 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, acme@kernel.org,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	jolsa@kernel.org, adrian.hunter@intel.com, john.g.garry@oracle.com,
	will@kernel.org, james.clark@arm.com, mike.leach@linaro.org,
	yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	tmricht@linux.ibm.com, ravi.bangoria@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 3/5] perf mem: Clean up perf_mem_events__name()
Message-ID: <20231218032101.GA18177@leoy-huanghe.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-4-kan.liang@linux.intel.com>
 <20231209054809.GB2116834@leoy-yangtze.lan>
 <3b67c2de-741d-4d5e-8c8f-87b8b9e08825@linux.intel.com>
 <20231213133336.GA3895246@leoy-yangtze.lan>
 <CAP-5=fVGoQbaUmDqr8CmoRT3Wx=Pp7TtmWuwvXrvEeGw5eannA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVGoQbaUmDqr8CmoRT3Wx=Pp7TtmWuwvXrvEeGw5eannA@mail.gmail.com>

Hi Ian,

On Wed, Dec 13, 2023 at 09:33:24AM -0800, Ian Rogers wrote:

Sorry for late response due to I took a leave at end of last week.

[...]

> > > The purpose of this cleanup patch set is to remove the unnecessary
> > > __weak functions, and try to make the code more generic.
> >
> > I understand weak functions are not very good practice.  The point is
> > weak functions are used for some archs have implemented a feature but
> > other archs have not.
> >
> > I can think a potential case to use a central place to maintain the
> > code for all archs - when we want to support cross analysis.  But this
> > patch series is for supporting cross analysis, to be honest, I still
> > don't see benefit for this series, though I know you might try to
> > support hybrid modes.
> 
> So thanks to Kan for doing this series and trying to clean the code
> up. My complaint about the code is that it was overly hard wired.
> Heck, we have event strings to parse that hard code PMU and event
> names. In fixing hybrid my complaint was that we were adding yet more
> complexity and as a lot of this was resting on printf format strings
> it was hard to check that these were being used correctly. The
> direction of this patch series I agree with.

I agreed as well ;)

> Imo we should avoid weak definitions. Weak definitions are outside of
> the C specification and have introduced bugs into the code base -
> specifically a weak const array was having its size propagated into
> code but then the linker later replaced that weak array. An
> architecture #ifdef is better than a weak definition as the behavior
> is defined and things blow up early rather than suffering from subtle
> corruptions.

Thanks a lot for sharing.

> The Linux kernel device driver is abstracting what the hardware is
> doing and since the more recent changes the PMU abstraction in the
> perf tool is trying to match that. If we need to interface with PMUs
> differently on each architecture then something is wrong. It happens
> that things are wrong and we need to work with that. For example, on
> intel there are topdown events that introduce ordering issues. We have
> default initialization functions for different PMUs. The perf_pmu
> struct is created in perf_pmu__lookup and that always calls an
> perf_pmu__arch_init where the name of the PMU is already set. In the
> weak perf_pmu__arch_init we tweak the perf_pmu struct so that it will
> behave correctly elsewhere in the code. These changes are paralleling
> that. That said, the Intel perf_pmu__arch_init does strcmps against
> "intel_pt" and "intel_bts", does it really need to be arch specific
> given it is already PMU specific?

To be clear, I don't object refactoring, I am just wandering if have
better approach.

Your above question is a good point. I admit the implementation in
arch's perf_pmu__arch_init() is not a good practice, IIUC, you are
seeking an general approach for dynamically probing PMU (and the
associated events).

What I can think about is using the static linked PMU descriptor +
init callback function, which is widely used in Linux kernel for
machine's initialization (refer to [1]).

Likewise, we can define a descriptor for every PMU and link the
descriptor into a data section, e.g.:

  static const struct perf_pmu __intel_pt_pmu
  __section(".pmu.info.init") = {
        .name = "intel_pt",
        .auxtrace = true,
        .selectable = true,
        .perf_event_attr_init_default = intel_pt_pmu_default_config,
        .mem_events = NULL,
        ...
  }

As a result, perf_pmu__lookup() just iterates the descriptor array
stored in the data section ".pmu.info.init".  To support more complex
case, we even can add a callback pointer in the structure perf_pmu to
invoke PMU specific initialization.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/include/asm/mach/arch.h#n78

> A situation we see in testing is
> people trying to run user space ISA emulators like qemu, say ARM on
> x86, should the PMU set up for intel_pt and intel_bts be broken in
> this environment?

This is a good case, also is a complex case.

> I think that as the names are very specific I'd
> prefer if the code were outside of the tools/perf/arch directory.

I am not sure if understand your meaning.

Anyway, let me extend a bit with this patch series. For instance,
perf_pmu__mem_events_name() function as a central place generates memory
event naming for different archs (and even with different attributes).
This leads to architecture specific things are maintained in perf core
layer.

Rather than adding a data pointer '.mem_events' in to struct perf_pmu,
I'd like to add a new callback (say .mem_event_init()) into struct
perf_pmu, this function can return back the memory event string.

In the end, we can de-couple the perf core layer with arch specific
codes - and if we really want to support cross runtime case (e.g. Arm
binary on x86 machine), we can connect with linked descriptor as
mentioned above.

> There are cases with PMU names like "cpu" where we're probably going
> to need ifdefs or runtime is_intel() calls.
> 
> Anyway, my point is that I think we should be moving away from arch
> specific stuff, as this patch series tries, and that way we have the
> best chance of changes benefitting users regardless of hardware.

To be clear, I agree it's great if we can build in all archs into single
perf binary for support cross runtime.

On the other hand, I don't think it's a good idea to totally remove arch
folders.

> It may be that to make all of this work properly we need to modify PMUs,
> but that all seems good, such as adding the extended type support for
> legacy events on ARM PMUs so that legacy events can work without a
> fixed CPU. We haven't got core PMUs working properly, see the recent
> perf top hybrid problem. There are obviously issues with uncore as,
> for example, most memory controllers are replicated PMUs but some
> kernel perf drivers select a memory controller via a config value. We
> either need to change the drivers for some kind of uniformity or do
> some kind of abstracting in the perf tool. I think we'll probably need
> to do it in the tool and when doing that we really shouldn't be doing
> it in an arch specific or weak function way.

Thanks for bringing up.  Now I understand a bit your concerns.

Leo
