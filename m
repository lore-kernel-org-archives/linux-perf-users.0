Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A9343D516;
	Tue, 28 Apr 2026 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381252; cv=none; b=kWxJ9lmS9jgmqKABywgbpDSbQasuJ52zqbiM/BBiZWzj1Gls/d3Xrs4uvIroYiv1wQwlbieJ/E1XTwfcYyhQRlQiVQ9EFdD6muAFQ9do/oV8NgRAve7LPu3fWOjc8WMxQ9TuaChwSQ6VYeK+Q4VtynGYQ/UcX3yBwwEBL512IG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381252; c=relaxed/simple;
	bh=beUtoMSjIn24HHCl9ebziabKwWJtkRSjB56IeFlyWlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/zX9kepqpKEqeu2vm4quUj+XsUMYXzyyiR6gi1V+EnCmHceDZ1kD9Bh2phi/DZElQ30MXvRdtZ0k2QOdPWa6q6G2ch6PGjydYNt+a2F7X1kllxSCTxBFapxn1f/YtGcYlfkGmjhsFK5YvNOlC0FuW1PnKMe62jr9xs1Vg/GYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BKdVUAPL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKdVUAPL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r7x/PQY4tm+V2+l26lrNFzUCWKEhkjpuNKLS3ISPOH8=; b=BKdVUAPLgrqMAUnhb7IOHPqHck
	ZF97pz/keuL/22vXOASxyJxvNn44vmZTPvaSVskfv5GUcuM00Zy1TJHhfrB3XwP+eQ/5qp8fcUJRL
	38dYq1Rou6bwRCwJAzRTfOJ0yEn+nZYsDTnZ8pQ/t0PDBfRS2/iuZwlg2lkqM18gC4X75srxvHCBa
	inps0Yuexzytxq0v/pJ+D2Zz2KsiiAI09Nwz22CRBflcPkiAUsvQqpJgUy4YxVpk5B1MONlM+lE+R
	mvq4eXuwYYLHtumwxXVmydemyok9bNj/TpOj0BBQNK7hHOetgfYEcqzEizezHsFbP8fFlXnQkNL9H
	Jdqhz4ug==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHi3M-00000003q21-3T18;
	Tue, 28 Apr 2026 13:00:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B0C5301261; Tue, 28 Apr 2026 15:00:40 +0200 (CEST)
Date: Tue, 28 Apr 2026 15:00:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
Subject: Re: [Patch v3 4/4] perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C
 tracking
Message-ID: <20260428130040.GZ3102624@noisy.programming.kicks-ass.net>
References: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
 <20260427085513.3728672-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427085513.3728672-5-dapeng1.mi@linux.intel.com>

On Mon, Apr 27, 2026 at 04:55:13PM +0800, Dapeng Mi wrote:
> Both Auto Counter Reload (ACR) and Architectural PEBS use the PERF_CFG_C
> MSRs to configure event behavior. Currently, the driver maintains two
> independent variables acr_cfg_c and cfg_c_val to cache the values intended
> for these MSRs.
> 
> Using separate variables to track a single hardware register state is
> error-prone and can lead to configuration conflicts. Consolidate the
> tracking into a single cfg_c_val variable to ensure a unified and
> consistent view of the PERF_CFG_C MSR state.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

So the earlier patches deserve to be in perf/urgent, but this one
doesn't actually fix anything and goes in perf/core ?
