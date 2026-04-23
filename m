Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DA330B3A;
	Thu, 23 Apr 2026 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961365; cv=none; b=XR2QqMi2Zm7U0rrOmFM3NaGZfkuRFAUdZeq7p0cPrbZ0lVkhPE7XdG5Y2t7hvwj9Blayid5OCxOaBVw96zHNxgUO9xawlawgZzbli6shUPVbRT06E+gpGsU6H8PZavbHQSSeC7G3TYorRixBP0vHnBSILmcx1tyeTsKZde8zPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961365; c=relaxed/simple;
	bh=53purbNXiSR9f5t/XzFJ8wD6JU7u+GetML0eb3xYm8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4QKbddJwAnmFT+jt6A0G1ZJCGymGf9p1VNE/Ig+zgwjFHEB67eeuRpRXnCIFQ7/qzLOc0bvCtoZeFbu2Qve7YKVrwfAOloJUNs/Kt3JqDqeKJFCZ1hi+WzAs2bJ1wggr9QGCHQoQEM8WZ36eyqTkvQhKKisLiAEWvwxAlDEZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W0YbrEff; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W0YbrEff"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=88tU3+d4rRfAF9LySGXslgxP5/67kTf+1hPGYX48KgU=; b=W0YbrEffsPcmEmiH51x2c8qRqX
	E0IeKyl10oX6z9x2d7x23ZWhwl48GIsjMJ1EdzfR6LM/vfTfU27vt1Hn3BHiKMRc1jN+MaFkpbSbA
	6jtVRxsho0wqZcVjTlHSR+LqyB8kZDRWEfxrzZoUe7ixRbuqcJGjUZRFZabvEUh3WiBctN+zQOVzb
	7kwiuvgk/NSiK1MzjA/XP2UNyC29m7a0vNnHAPAAMEhcYgf4MG7aCehzAk8i7gIM9ADu0toQZqWrU
	IsBvHohvg+kkwkjrPdjbZ5di3yT5wnW9Lr123WzDoQJmJnuzy3nGFMCnI2/1kJR5xk4WjPoIlka7w
	Kxcg40dQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFwp4-0000000DQAg-33yC;
	Thu, 23 Apr 2026 16:22:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D71653008E2; Thu, 23 Apr 2026 18:22:37 +0200 (CEST)
Date: Thu, 23 Apr 2026 18:22:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Stephane Eranian <eranian@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v2 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
Message-ID: <20260423162237.GB641209@noisy.programming.kicks-ass.net>
References: <20260423150340.463896-1-seanjc@google.com>
 <20260423150340.463896-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423150340.463896-2-seanjc@google.com>

On Thu, Apr 23, 2026 at 08:03:37AM -0700, Sean Christopherson wrote:
> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
> *never* insert an entry for PEBS_ENABLED if the CPU properly isolates PEBS
> events, in which case disabling counters via PERF_GLOBAL_CTRL is sufficient
> to prevent unwanted PEBS events in the guest (or host).  Because perf loads
> PEBS_ENABLE with the unfiltered cpu_hw_events.pebs_enabled, i.e. with both
> host and guest masks, there is no need to load different values for the
> guest versus host, perf+KVM can and should simply control which counters
> are enabled/disabled via PERF_GLOBAL_CTRL.
> 
> Avoiding touching PEBS_ENABLED fixes a theorized bug where PEBS_ENABLED can
> end up with "stuck" bits if a PEBS event is throttled better generating the
> list and actually entering the guest (Intel CPUs can't arbtitrarily block
> NMIs). 

Supposedly writing 0 to GLOBAL_CTRL *should* serialize vs PMI on most
chips IIRC. That is something perf itself relies on. Once we've cleared
GLOBAL_CTRL we do not expect any PMIs.
