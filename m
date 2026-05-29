Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA83C379C;
	Fri, 29 May 2026 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052104; cv=none; b=TtZDsHzBk7sF3kOHLJ/yS/+JGMtPa8xz8a79VzXN7B54dLUbcSjcJSkmgg4avQFp7OS5vgKHtV/Pn3Eo1U7lTWhRvsvhlUlBEY/Pr481GMwkoxwgcnrCBOP0KS5aidBxL2mZq5dTd5EGrU4lhy80CrwyFNJZVvnK8A2fOFThZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052104; c=relaxed/simple;
	bh=y5ApBytfew8oZAg1MEiLYo+0rk802UsIfm+enxE+nnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeYSiERvGw2KEAcnOQ6/pKHw6qXt7ttfImtDiSyrCxjOv2tOsZC508YRQvwZid/TOi0EYVCbFUKzri1PhNSgXbtWd8CRgUz6bkfOtVAvHkBtZQun5pcW3hatU6+rz606jpP4I76lJTiVgsygQOzwx5+0ZCx31CWhvJDGjbQ80Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P1rG19k4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P1rG19k4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7sMFgoGdUyJPnf9unThrjqp1lyC4A/sd0bt0sbfVaaw=; b=P1rG19k4hfJFnuv8C1d/0dGROl
	U+JVfWec4HjJRTf8b9hECdBx1ZXyEWr2/9PkHpTmCsDuaIq+S3e7iOatODLwnWr+qwhO6d1la0reK
	mqggqT2R+jMvAbkkRUxj/q+9ayT21lNcoJM6ltxCIMAMaOeByR3iPr5Ik4J21YzDOWHWKpH1Wn3ch
	YBSsKRRAt+cd3yRXo4vK9RIy1jvRdrQQbmG5/pt2C3Iley0MmWfpPcU2tv9gDVOCiDHxE1wX2wca+
	diQGFKwUbhfUYbrfebuyMQ3yRMqyzSsujgayl/5/WsFx8cF9RJtoHgWjNOVgzzamoLH1rSmIGL5AW
	ndJnOLQg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSurY-000000016EE-3R4m;
	Fri, 29 May 2026 10:54:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D3C0730036F; Fri, 29 May 2026 12:54:47 +0200 (CEST)
Date: Fri, 29 May 2026 12:54:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH V2 5/7] perf/x86/intel/uncore: Move die_to_cpu() to
 uncore.c
Message-ID: <20260529105447.GF3493090@noisy.programming.kicks-ass.net>
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-5-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151154.130505-5-zide.chen@intel.com>

On Wed, May 27, 2026 at 08:11:52AM -0700, Zide Chen wrote:
> Move die_to_cpu() into uncore.c so it can be reused by the MSR
> initialization path, preparing for the introduction of an MSR global
> initialization callback.
> 
> Move the cpus_read_{lock,unlock}() out of the API, in order to make
> it possible to be called when the lock is being held.
> 
> Add the uncore_ prefix for consistency with other uncore APIs.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> 
> V2:
> - Move cpus_read_{lock,unlock}() out of uncore_die_to_cpu() and rely
>   on callers to manage the lock. (Sashiko)
> - Remove "No functional change intended" from the changelog.
> ---

V2 stuff goes under the '---' line. Otherwise I get to manually delete
it.
