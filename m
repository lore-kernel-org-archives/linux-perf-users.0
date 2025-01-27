Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230B2AD1C;
	Mon, 27 Jan 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996254; cv=none; b=NkiiCev921UPe+S7INuxv1NPtUCSK+Z9GdcUBIi67fTuezCAdPLVIiRRTYwtWnoqf7U2UIeeEmA/ur0gtEnSDqMW0CNEwlXtA2UldhEWUSZcDGMNExENTUrKNcrn+W3aXA1K8uCTl038v11164XGBl9M7HzZpsUNW3eKTEPDMTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996254; c=relaxed/simple;
	bh=WyA7/k1T+AAys5VZgCOynvfdN8GR+aetott7huGy1UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4nmy9rdjL+Y7k6rIbncbEPX5WnQlJReMpaxjyJITZdPq2A5lhiMBj5ubBWw/m7BCyzyyMz4mQ/pkVnTDwDRbXpIQktJWkJnr6QOy2mFlFJF50ERFVBCn85yOjJ2Ztm6HMjiH4oJaufbfKeEXV42U3r7NTEDTLJ0SvWEcmZE4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eFhAHv3j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eFhAHv3j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5RmZoBqc6Tnyr+QUhonHQTSXnL7FTTnfyHYzpm0pv4c=; b=eFhAHv3jrwQN+MvH01mWkI9j8C
	MKbvAcFcaMucd+fouLNnz+8vhuCjG4VrUNVjYsj6wScl/I7ojf9/nWEMh3xDqbRIZ7A2RswCsv/oP
	coT5bi1RWGJnfynEtWh8PntKEWscfagdaTOCwKGx92F5GtGW2DvwN3VlLeH8OgzOzcQ9jUZJlSrdW
	6fnIkbjQHPPX0RA9SsuP3+mRGKLlo2gA5KQaujp/HXYcol9HNGFZ5HpDLI5pG8ks7UgPbnXZNMggQ
	RTxph4Fq0c7cS11gwodt/pQVeTbLJPbBS5+3R+EU9eQos05RhUkU/0nWmRENojR5bqsUTmU2MndD2
	xLxr0m7w==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcSDX-00000009f1g-1RxP;
	Mon, 27 Jan 2025 16:44:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF74530035F; Mon, 27 Jan 2025 17:44:06 +0100 (CET)
Date: Mon, 27 Jan 2025 17:44:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 03/20] perf/x86/intel: Parse CPUID archPerfmonExt leaves
 for non-hybrid CPUs
Message-ID: <20250127164406.GN16742@noisy.programming.kicks-ass.net>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-4-dapeng1.mi@linux.intel.com>
 <Z5KRT-F7MbTs6g6y@tassilo>
 <85588439-ec0e-4824-8193-f0737880ecb9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85588439-ec0e-4824-8193-f0737880ecb9@linux.intel.com>

On Mon, Jan 27, 2025 at 10:19:34AM -0500, Liang, Kan wrote:
> 
> 
> On 2025-01-23 1:58 p.m., Andi Kleen wrote:
> >> +	/*
> >> +	 * The archPerfmonExt (0x23) includes an enhanced enumeration of
> >> +	 * PMU architectural features with a per-core view. For non-hybrid,
> >> +	 * each core has the same PMU capabilities. It's good enough to
> >> +	 * update the x86_pmu from the booting CPU. For hybrid, the x86_pmu
> >> +	 * is used to keep the common capabilities. Still keep the values
> >> +	 * from the leaf 0xa. The core specific update will be done later
> >> +	 * when a new type is online.
> >> +	 */
> >> +	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
> >> +		update_pmu_cap(NULL);
> > 
> > It seems ugly to have these different code paths. Couldn't non hybrid
> > use x86_pmu in the same way? I assume it would be a larger patch.
> 
> The current non-hybrid is initialized in the intel_pmu_init(). But some
> of the initialization code for the hybrid is in the
> intel_pmu_cpu_starting(). Yes, it's better to move it together. It
> should be a larger patch. Since it's impacted other features, a separate
> patch set should be required.

IIRC the problem was that there were SKUs with the same FMS that were
both hybrid and non-hybrid and we wouldn't know until we brought up the
CPUs.

Thomas rewrote the topology bits since, so maybe we can do beter these
days.

