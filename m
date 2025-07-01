Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7396202995
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Jul 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358031; cv=none; b=NUvxG3PAh1rq2ST0xERHIG4VkBSGtm2zNRLUP68nCxoN+51y1l2yyvb6/aMMgkZAZAvoZOCguYF39ms7rwoXsaWyGPuKYX3g1LbGD5XnwvS/mmfoGrRHTBACAlRsPzbNHsGNpiVKWTEU41LY6VlLLYEkxs1Py/6wXMBn7jLejt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358031; c=relaxed/simple;
	bh=Fke66dmuU8k6BOfXq13CTF9vQPYqh7z5wFz988DVESk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aD3YVCAEsKNqIw3XffaYLEkJmnJgLLEGTY8YLWHwsi/qize8m8PsGJkJTMpHAg1pwdDJE8PQ4uJoqUq3GC0ULYzNP88eGcDCPqsQmX8zzUObl6Wzi38Wnk8guePHmWW7ro0ycQBgrLKznpz59481vMZen0pvwjYbHJcVQZrNNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC73B1595;
	Tue,  1 Jul 2025 01:20:12 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE4D13F58B;
	Tue,  1 Jul 2025 01:20:27 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:20:25 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	German Gomez <german.gomez@arm.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 11/13] perf arm_spe: Refactor
 arm_spe__get_metadata_by_cpu()
Message-ID: <20250701082025.GU794930@e132581.arm.com>
References: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-0-2e1afab313b9@arm.com>
 <20250630-arm_spe_support_hitm_overhead_v1_public-v2-11-2e1afab313b9@arm.com>
 <CAP-5=fUPfKB5Va_+sO25yf5Y-SjQTR6WsauqcmxirVzgjRNVAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUPfKB5Va_+sO25yf5Y-SjQTR6WsauqcmxirVzgjRNVAg@mail.gmail.com>

On Mon, Jun 30, 2025 at 09:53:18AM -0700, Ian Rogers wrote:

[...]

> > +       /* CPU ID is -1 for per-thread mode */
> > +       if (cpu < 0) {
> > +               /*
> > +                * On the heterogeneous system, due to CPU ID is -1,
> > +                * cannot confirm the meta data.
> > +                */
> > +               if (!spe->is_homogeneous)
> > +                       return NULL;
> > +
> > +               /* In homogeneous system, simply use CPU0's metadata */
> 
> Could this be derived from the spe's pmu_type? Something like
> perf_pmus__find_by_type(spe->pmu_type)->cpus ?

Good point, I will give a try. Thanks for suggestion!

Leo
