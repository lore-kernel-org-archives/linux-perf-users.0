Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BD2236EE
	for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262913; cv=none; b=h2fGCsyvQqPgpf7lpDRYhao0zQMP/QNgRptbGcux+zsmTzo0Ztx0zn1D7vAX5ps4HVw+eLpzrnje2hQA8AqBodDaqBK1cJQOde8zmJQNdZhmBWdgVcxx9TYRQ6M+INh0iu36qB9BxP24/7dSZoLw0jyWeaAtlbLcaRIvrTXFWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262913; c=relaxed/simple;
	bh=fw4ASR0dC84nfQEf3FUe/wm41N26f7aWrG3iJtseeR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eveXQBrfXX5he78flGz7jICgGoUT1+Yrlsm7azQ3nFuQn5m0ByOihI1kHvA7L2ZPSGmO8bdLjhdkBJIJQXTe1JM/vwC61j1+57iwMbit4ILAMgN9HU+HuNGzKk6IV11a0eY9DkySGA3ItN/TxVhzyiUQgDdIku1y5mcvosmg/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JT9NQioB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JT9NQioB"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30adbe9b568so267538a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747262911; x=1747867711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UgYJ+Uk5kzzZuLLJjG5/CvuJkRdqBhrdQNgIB/qPRsA=;
        b=JT9NQioBd/xWwaOrtayCcz3BLySw6ZeAsts9BDUOwtyBSpKcCgveom/0LKwo4KlSsy
         GRGnmRxx8OrnRUxaYDsBB6kiEqvngGZsyt3WkmFlQx25bTavzKSdQ+z8gponfkQ4E1JI
         sk9ZG6zi3cJZ/atzqw9KA0ISIpduqFSaUYrECKLLuleJx8hSitSzJX/fTihtk0grgvlm
         sPhx0PaWhghKeZarEQp6bdgzYghc2uZHnBHHC3u80M7kkNu+8LLBhqpx1vDbBELR18eE
         GjO9H2v/R8L271+ghupAqx6ddC3pVt30NcOuJblzZQv0Bc3I9SSaRIXoKJ2PPmVELYlz
         QVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747262911; x=1747867711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgYJ+Uk5kzzZuLLJjG5/CvuJkRdqBhrdQNgIB/qPRsA=;
        b=PZ+cY5/YYi/AKXjKH3QxG2w9NzIBQ0JlqOvfoZ2fiC2h4XQmJMjl1mLjK6E/ELSR8q
         R6a+pFJ5vV2eSFakis4xF4pz11YoQTrqicXbzlnLfrVv71yeBOR8VV1/6wJjOn8cniXI
         nMrp/RoPMsESFxpoll84QARk0rbmrzd5qP+MgEBQbd/6LMa7gjZltsQ6eSiP/4DMQHFt
         qkTbdZIQtLvxdd8i56iF14fX/UcTrBzVWbSAlXzVh/GvJ9TZwp/T3cqeoZSdQTNbPY+d
         ggKGVlLPS7DeXYZojO2A38XThXQ8VTCyWEG6vpfH6qxXjLzQcjScj5nQNl8lX3UEBUsA
         QO4w==
X-Forwarded-Encrypted: i=1; AJvYcCXWPgV+M2yIarcQlmmMCTC8ONq3DBNhRiUrVwsmpuibikfiElSDIyYF1l2M8ZjqSGn471k4Ti5G3XKalLUeaZgS@vger.kernel.org
X-Gm-Message-State: AOJu0YzM63USQpgRUP4YXFH3xPXgtgTu8qB2zZoVSwvLYOrqdqMCUKag
	f4OC3TBcrwti765t58uOuyO9/glUQ5fGS0V0W2Fhs+DdoKbhA1/uLX2WpkSf5Hyx8oeb9SbO1FL
	n/g==
X-Google-Smtp-Source: AGHT+IG10+Iq5L5Cda3ijuQh+2a54en45CtzZHeDe6mY71MnV/tUAELSpjY7VbeAe1Lg4OZmV0PYigFgkQQ=
X-Received: from pjbsh11.prod.google.com ([2002:a17:90b:524b:b0:2fa:1803:2f9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b43:b0:2f6:d266:f462
 with SMTP id 98e67ed59e1d1-30e2e68a300mr7400689a91.35.1747262911047; Wed, 14
 May 2025 15:48:31 -0700 (PDT)
Date: Wed, 14 May 2025 15:48:29 -0700
In-Reply-To: <20250324173121.1275209-2-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-2-mizhang@google.com>
Message-ID: <aCUdvaM4xkLzRF8J@google.com>
Subject: Re: [PATCH v4 01/38] perf: Support get/put mediated PMU interfaces
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> +/*
> + * Currently invoked at VM creation to
> + * - Check whether there are existing !exclude_guest events of PMU with
> + *   PERF_PMU_CAP_MEDIATED_VPMU
> + * - Set nr_mediated_pmu_vms to prevent !exclude_guest event creation on
> + *   PMUs with PERF_PMU_CAP_MEDIATED_VPMU
> + *
> + * No impact for the PMU without PERF_PMU_CAP_MEDIATED_VPMU. The perf
> + * still owns all the PMU resources.
> + */
> +int perf_get_mediated_pmu(void)
> +{
> +	guard(mutex)(&perf_mediated_pmu_mutex);
> +	if (atomic_inc_not_zero(&nr_mediated_pmu_vms))
> +		return 0;
> +
> +	if (atomic_read(&nr_include_guest_events))
> +		return -EBUSY;
> +
> +	atomic_inc(&nr_mediated_pmu_vms);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(perf_get_mediated_pmu);

IMO, all of the mediated PMU logic should be guarded with a Kconfig.  I strongly
suspect KVM x86 will be the only user for the foreseeable, e.g. arm64 is trending
toward a partioned PMU approach, and subjecting other architectures to the (minor)
overhead associated with e.g. nr_mediated_pmu_vms seems pointless.  The other
nicety is that it helps encapsulate the mediated PMU code, which for those of us
that haven't been living and breathing this for the last few months, is immensely
helpful.

> +void perf_put_mediated_pmu(void)

To avoid confusion with perf_put_guest_context() in future patches, I think it
makes sense to go with something like perf_{create,release}_mediated_pmu().  I
actually like the get/put terminology in isolation, but they look weird side-by-side.
