Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B582F531F;
	Mon, 10 Nov 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765398; cv=none; b=HwsZSfGeejAHJcQCs4F4y7x6JU4mOAgmebXEWH90zxGn4RvAEnGMYFqrot1DQK7K4MnOb1pYbEqipeHmtIzOSegp4lcLGLTy27J5KkdTWRtEJCdCs2RZiZVjqF+g56y139Ah4L9GOM7PZuYnIdH6sQmOkSg432lXWHalSjuukXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765398; c=relaxed/simple;
	bh=iP0pmJD7p/Bep5voU0Il6HrQY7P1kccQ8mI1YFlWCbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAbtZ8UBal/U6lpAvYON9eFSXESeIKz2hDLK8hmxgYdWST+UcAeOJDHaT7ggX+mMS0Lg062lhN7aszw3iBuLM5x79h7ILpLyQqZHU1+qJkU+zkCKFuX4au5XjrkKkNo+4h4w68v34V4nmY1161Rdz165qRJeJVyxw9A4FzDhxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HDn9GlST; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HDn9GlST"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FSR+Ot9br0PyGeycL2DqffDKXnlSzEU/stDQCwoZvls=; b=HDn9GlSTe6h+2jOlorwx9A8J3/
	/FXOnqdyIpVUIbUz0h3T1CD8a2I5WH2JrGdHxPGP8S+/+HZ8/4S7NLFL9uPhWb3NfuboHWSJp3VPp
	C+1gfWO3gh0NYeMV5hbmIQwdvn4lQ7v1UcKhg70dtsl+NlxVc+7ATldLSaIGI2WaB2DIZEFGo8iPV
	mie4AbxYz5/76NDN2CHTD7wiUQHtAkzRwAHCIcDSgu6YXDJfyRjwvdQymCzcDZFUfXYTalvFB7b9f
	KnL3xz4rb5ER2oAhiHdP+vdbiAedKUeFb+KbHqc3tIdsYFjCN9V0cn++2TOL66KuSsJKCcnH0GTAG
	ROssKh4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vINns-0000000BBEO-0DQV;
	Mon, 10 Nov 2025 09:03:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 852EC30029E; Mon, 10 Nov 2025 10:03:11 +0100 (CET)
Date: Mon, 10 Nov 2025 10:03:11 +0100
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
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
Message-ID: <20251110090311.GW3245006@noisy.programming.kicks-ass.net>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
 <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
 <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>
 <20251107130552.GB4067720@noisy.programming.kicks-ass.net>
 <a0416429-23d4-4f4f-af73-bcd87b4e773c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0416429-23d4-4f4f-af73-bcd87b4e773c@linux.intel.com>

On Mon, Nov 10, 2025 at 08:23:55AM +0800, Mi, Dapeng wrote:

> > @@ -5536,6 +5540,14 @@ static void intel_pmu_check_dyn_constr(s
> >  				continue;
> >  			mask = hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
> >  			break;
> > +		case DYN_CONSTR_PEBS:
> > +			if (x86_pmu.arch_pebs)
> > +				mask = hybrid(pmu, arch_pebs_cap).counters;
> > +			break;
> > +		case DYN_CONSTR_PDIST:
> > +			if (x86_pmu.arch_pebs)
> > +				mask = hybrid(pmu, arch_pebs_cap).pdists;
> > +			break;
> >  		default:
> >  			pr_warn("Unsupported dynamic constraint type %d\n", i);
> >  		}
> 
> Yes, exactly. Thanks.

Excellent. Could you please double check and try the bits I have in
queue/perf/core ? I don't think I've got v6 hardware at hand.
