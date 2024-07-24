Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE6148FFA;
	Wed, 24 Jul 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721824877; cv=none; b=cs0mW3NLmdCURfRBKLT7nAWgvBJv2LwUkkyta7X9e+R0QTlTQHSV+gPrEtAPasAL59T9H44zfH2E8h3N0Drz7KYLt4FF4v6XR+4SlpJ2gdmtzhx3CvkaxXdMV+AgB8t/EbwVuqHRzyHoQvxLm5HC6nY1A7NJeoiX+j/8DBGTHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721824877; c=relaxed/simple;
	bh=cmp1m11YrpsGcqUKzGuag7Huw9vz0AgogJWIrQ6MnpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIQ/chUv5PhUJ1Mx04Dyxi/TecMBbTrSdNwn9DmDGqXG1Vgkx8+cb/zzNa5mD9NGIkx4FeI66yRxW3/XDcaAVi1PbC3B8PVgVL7hJ9r0GpXxfmyu2szQfYZco8iZRnfaN/OvLoo4W0/MBLMpoKWiulWsW51F8f8fNrN6FEbC9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fhVhrl9/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fhVhrl9/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6J6/mCNap2U38NHjqHLrKE4y+Xj/p/3fvwoIUdiyQks=; b=fhVhrl9/nejY93MygJ055QBCdi
	ZIF736PfMqnvAuyabZN57XAf5Fqvlg8FjHxqkWjva739sISm6WP26aPl5jt/8Fwnu8B+bNS5Lim0Q
	RW8dni0aAHR33LU+zIaPhYrDz6HTOnFmqMo7quJV4+PWX1wDMkkmDuzNph1X8CB8MWTrJnF7FJsWv
	g5qWfIP+38/h4biPzaZjbQYa08Iz6ByEI4MjE436qg2kOFazACkY+c54oTCoOLVp7l2IEyONppfpc
	EGFG9MtYCsGnBv/0QAilWyTbziJpctvWxeNiYATTgx6rqGwgHl7yhRWKeLrfgsHnS6bYZxRNPGfNT
	8MlXJr6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWbIo-00000007pAr-2cMJ;
	Wed, 24 Jul 2024 12:41:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 36AAD3003EA; Wed, 24 Jul 2024 14:41:05 +0200 (CEST)
Date: Wed, 24 Jul 2024 14:41:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] drm/i915/pmu: Lazy unregister
Message-ID: <20240724124105.GB13387@noisy.programming.kicks-ass.net>
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
 <20240722210648.80892-7-lucas.demarchi@intel.com>
 <be3871bd-fc25-482e-b4d4-91afc4d5b5a5@ursulin.net>
 <xsuzfv4rzb4c25sibt5gjskn7xyfwf33wgwaw4nkz5jlnvl2ke@ekur5xvhec3z>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xsuzfv4rzb4c25sibt5gjskn7xyfwf33wgwaw4nkz5jlnvl2ke@ekur5xvhec3z>

On Tue, Jul 23, 2024 at 10:30:08AM -0500, Lucas De Marchi wrote:
> On Tue, Jul 23, 2024 at 09:03:25AM GMT, Tvrtko Ursulin wrote:
> > 
> > On 22/07/2024 22:06, Lucas De Marchi wrote:
> > > Instead of calling perf_pmu_unregister() when unbinding, defer that to
> > > the destruction of i915 object. Since perf itself holds a reference in
> > > the event, this only happens when all events are gone, which guarantees
> > > i915 is not unregistering the pmu with live events.
> > > 
> > > Previously, running the following sequence would crash the system after
> > > ~2 tries:
> > > 
> > > 	1) bind device to i915
> > > 	2) wait events to show up on sysfs
> > > 	3) start perf  stat -I 1000 -e i915/rcs0-busy/
> > > 	4) unbind driver
> > > 	5) kill perf
> > > 
> > > Most of the time this crashes in perf_pmu_disable() while accessing the
> > > percpu pmu_disable_count. This happens because perf_pmu_unregister()
> > > destroys it with free_percpu(pmu->pmu_disable_count).
> > > 
> > > With a lazy unbind, the pmu is only unregistered after (5) as opposed to
> > > after (4). The downside is that if a new bind operation is attempted for
> > > the same device/driver without killing the perf process, i915 will fail
> > > to register the pmu (but still load successfully). This seems better
> > > than completely crashing the system.
> > 
> > So effectively allows unbind to succeed without fully unbinding the
> > driver from the device? That sounds like a significant drawback and if
> > so, I wonder if a more complicated solution wouldn't be better after
> > all. Or is there precedence for allowing userspace keeping their paws on
> > unbound devices in this way?
> 
> keeping the resources alive but "unplunged" while the hardware
> disappeared is a common thing to do... it's the whole point of the
> drmm-managed resource for example. If you bind the driver and then
> unbind it while userspace is holding a ref, next time you try to bind it
> will come up with a different card number. A similar thing that could be
> done is to adjust the name of the event - currently we add the mangled
> pci slot.
> 
> That said, I agree a better approach would be to allow
> perf_pmu_unregister() to do its job even when there are open events. On
> top of that (or as a way to help achieve that), make perf core replace
> the callbacks with stubs when pmu is unregistered - that would even kill
> the need for i915's checks on pmu->closed (and fix the lack thereof in
> other drivers).
> 
> It can be a can of worms though and may be pushed back by perf core
> maintainers, so it'd be good have their feedback.

I don't think I understand the problem. I also don't understand drivers
much -- so that might be the problem.

So the problem appears to be that the device just disappears without
warning? How can a GPU go away like that?

Since you have a notion of this device, can't you do this stubbing you
talk about? That is, if your internal device reference becomes NULL, let
the PMU methods preserve the state like no-ops.

And then when the last event goes away, tear down the whole thing.

Again, I'm not sure I'm following.
