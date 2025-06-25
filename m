Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE0126B0BC;
	Wed, 25 Jun 2025 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871926; cv=none; b=XbCOeXIdc4WJ5VEIVM5kOFGYVt3k22m5cFZZVao7t6U5U/1315K3VaOw4SCAZMHP40rQVfq/arq/Y4+1/JECT4KESK0bmd1v0sBZekohbU+Fw3Jno4RDWWP7ERcnbzKu8xjaO2OK5FQ/1WMXDhiX7cE3DqinqV/lq69XYKllnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871926; c=relaxed/simple;
	bh=sLNlcgekr3Gr0Y4S6wbHT2/s7+Yfa1/Cty6HAgQ28HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XclsR3m6seGlwHs3axskrx5vEFwhrlXU+a+sJzymVSTHMK5sx5wVdr/7Bg3G8s8Apsey0pd83LUvxGAQYCajVrchwDpVg5yRS9IUkYk2y4u0tqQCqzLiGu4KySJqJSJRGKT++u4p116c9iRadtt6HSbcnRIVYb6dz2Oglm0P87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93CF8106F;
	Wed, 25 Jun 2025 10:18:25 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C33C3F58B;
	Wed, 25 Jun 2025 10:18:43 -0700 (PDT)
Date: Wed, 25 Jun 2025 18:18:41 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/aux: Properly launch pending disable flow
Message-ID: <20250625171841.GP794930@e132581.arm.com>
References: <20250522150510.2942814-1-leo.yan@arm.com>
 <d87ddbbb-862d-4cf7-b2c4-a5eb0d072a33@linaro.org>
 <20250624133217.GO794930@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624133217.GO794930@e132581.arm.com>

On Tue, Jun 24, 2025 at 02:32:17PM +0100, Leo Yan wrote:
> On Tue, Jun 24, 2025 at 02:11:38PM +0100, James Clark wrote:
> 
> [...]
> 
> > > @@ -441,7 +441,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
> > >   		 * store that will be enabled on successful return
> > >   		 */
> > >   		if (!handle->size) { /* A, matches D */
> > > -			event->pending_disable = smp_processor_id();
> > > +			perf_event_disable_inatomic(handle->event);
> > >   			perf_output_wakeup(handle);
> > >   			WRITE_ONCE(rb->aux_nest, 0);
> > >   			goto err_put;
> > > @@ -526,7 +526,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
> > >   	if (wakeup) {
> > >   		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
> > > -			handle->event->pending_disable = smp_processor_id();
> > > +			perf_event_disable_inatomic(handle->event);
> > >   		perf_output_wakeup(handle);
> > >   	}
> > 
> > The types are now a bit misleading and pending_wakeup and pending_disable
> > could be bool types. The other pending_*s do use their types properly
> > though.

Changing the type from unsigned int to bool is a refactoring and not
part of the actual fix. Therefore, I left it out in patch v2.

Thanks,
Leo
