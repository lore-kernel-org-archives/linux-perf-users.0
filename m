Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736AA3BB69E;
	Wed, 10 Jun 2026 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090490; cv=none; b=ALalpEhk0KK0AcyQEmTqyF2qMf61EKgSEegP9JIvUQl/SGhSLvaEMLHPr91IpJ3lJk6/xSapTQMI/VD5WzDqt1ZDUzJDebmXE/Rtw9jqt4B0erSwQEbUJyAwc4qQtSSNzIvc8keKXDKapriuaObOG8G2pg5ZA4/IM0Ly6g3OF14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090490; c=relaxed/simple;
	bh=6MsxeteDPbtik8PYKBawEcDK6wu3CIVQHuSAtECeFyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKIRvnA8FPfKurkJ9H9HpKAGRC+4rfz4pOlqrsooQy0qgr+qi0zURmm+R5xfmSmYbCTBImCZwm5oyHnzKi9AiO0tc2Qdj4WdMwtnRmzzbWo66zNLjBIA6yr6aV2RTaUvl1F+d0UadTGMvXWoXF6KtWn4/QucKviweqt2J2zx+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GctDVpE+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GctDVpE+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X4poEcIheZVRD5chMXLjnbsvP0EtLtC1NrjeKsWCfGI=; b=GctDVpE+P/hSEfZjhEi/QOIQn4
	Mbp3nN7rhkAmZN29hx2gGLqy0D55S9OXByuhD1fPsGwt21AzrvQugVNJxxYcZM292UbZqK1y69g2i
	476ypjyBIOp6wEHc6Yq2TEsNSfZk8ybjPCZws3frVsqMo5kSSh0FUHJQ0ZN5jCIyRXfmtK3RsdiPf
	bqeny9xb8hNFYcqzgvrbmPmUz4P9NHhjDc2JUrpOwpVUQYDGCMeEE49g2UMtzveNSfH73DSDQVlra
	x22bUm37p0Cbn384h6OJH03xyxond3jIy2GwW1888ah4QqL6JWGQ1GeBKGFKiQaqWVFvJNhVEvNNj
	DeyG0B8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXGzk-00000003nnq-2tSt;
	Wed, 10 Jun 2026 11:21:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F41A430036F; Wed, 10 Jun 2026 13:21:14 +0200 (CEST)
Date: Wed, 10 Jun 2026 13:21:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [Patch v2 7/9] perf/x86/intel: Drop fixed-counter PEBS
 constraints for baseline PEBS
Message-ID: <20260610112114.GD187714@noisy.programming.kicks-ass.net>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-8-dapeng1.mi@linux.intel.com>
 <20260610082051.GF49951@noisy.programming.kicks-ass.net>
 <b3485f13-039d-44d9-af02-5cea084ca304@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3485f13-039d-44d9-af02-5cea084ca304@linux.intel.com>

On Wed, Jun 10, 2026 at 04:50:45PM +0800, Mi, Dapeng wrote:
> 
> On 6/10/2026 4:20 PM, Peter Zijlstra wrote:
> > On Tue, Jun 09, 2026 at 01:02:20PM +0800, Dapeng Mi wrote:
> >> On SPR guests where pebs_baseline is not advertised, running:
> >>
> >> $ ./perf record -e cpu/event=0x00,umask=0x01,i\
> >> 	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1
> >>
> >> can trigger:
> >>
> >> unchecked MSR access error: WRMSR to 0x3f1 ... in\
> >> 	 intel_pmu_pebs_enable_all()
> >>
> >> Root cause:
> >> SPR-specific PEBS constraints allow fixed-counter scheduling,
> >> for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
> >> pebs_baseline, KVM does not support PEBS sampling on fixed counters,
> >> so enabling such events reaches an invalid MSR programming path.
> >>
> >> Fix:
> >> Drop fixed-counter entries from the PEBS constraint table. Without
> >> pebs_baseline, those fixed-counter PEBS events now resolve to empty
> >> constraints and are not scheduled/enabled, avoiding the warning and the
> >> broken guest PEBS path.
> >>
> >> This is safe because, in pebs_baseline-capable cases, PEBS constraint
> >> lookup already falls back to non-PEBS constraints when needed, and
> >> fixed-counter constraints are effectively shared there.
> > I am confused, this works outside of KVM? (It appears to work fine on my
> > spr).. so removing this to fix some guest only issue seems wrong.
> 
> The reason that it works on bare metal is currently the constraint lookup
> would fallback into non-PEBS constraints if there is no matched entry in
> the PEBS constraints as long as the PEBS supports sampling on all counters
> including fixed counters (what the flag "PMU_FL_PEBS_ALL" indicates), like
> the below code shows.
> 
> ```

Why the markdown nonsense? You're not an LLM, right? And you all know
I'm reading this in mutt. Its just visual noise.

Anyway, please clarify the Changelog.
