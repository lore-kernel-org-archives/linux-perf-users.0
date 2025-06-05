Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D351C27;
	Thu,  5 Jun 2025 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123690; cv=none; b=QxwQr4Ch7xCv/x2jj/k6zf+TuUSf14cAXcJpUVA8GYnBZ8/I4es8qSbItKTpMCinF8ByQSq03+7ihE9dGU0sr0PCxQF8MU+zyQ8AS4HV+0EHCCJLdWQECIH7jsuKOpXDeS4n08oZKvtonabvtwkSF19Hw1K1RTht4uKt4QBoq5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123690; c=relaxed/simple;
	bh=uHzqZ3QMQhENYf26t0CiOFuZnENeME9sEmNlEqkO/j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9UPkoYi4pQX1ng5fmTs7kBJhfyTv5UUC/f5AC2DwE7xMUagOeu52sFQ2nJqSwnYaSo40yeCntkcuMj+Vq1G5LE18Zlnx9lNVlOIPknRFsv0urqP1If9hFNSgTbcx/JIA+Y66lAMd0OF7MDGCnIhFbvIIrUwNfXyAJ+myeuGV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WsdBQaOi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WsdBQaOi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kSJ4tw+MiCUZQ1V285weaGn5JqCdxG7ND3MU0ijxgCY=; b=WsdBQaOiWaNT854s6GmASIdeW5
	Rm8z09us2i/uHbTn4+0bH2hY4iG1Mxj4ASZmcuaDDCer25yYI66hzncPJW9acke2BWeW88KvEBSh0
	jTZhlZQQDFJpDiP2k5oeZVPxip4y7l9vMNLy4H2zeIhVIXOYlxvg8SbpPM67wSYS3LihIOa3Sb0h/
	28dC4D0a0G++GTdeJQUaIs8VjRuXSqGXuwO9H00GpppabXY6/7vXwpu6S8x/FCoLFS1modlFEov7i
	UtY0BIsBojh4tt18VaV3hHAjMAt++08BTqXcV7bvQ8BkWHkF+rQUxMdzyOTJGfBsisSzJ84RhYI+v
	/Kl0rPgg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN8yF-00000004BwM-0Piu;
	Thu, 05 Jun 2025 11:41:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A1CA3005AF; Thu,  5 Jun 2025 13:41:18 +0200 (CEST)
Date: Thu, 5 Jun 2025 13:41:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250605114118.GC35970@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <20250604101821.GC8020@e132581.arm.com>
 <20250604141640.GL38114@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604141640.GL38114@noisy.programming.kicks-ass.net>

On Wed, Jun 04, 2025 at 04:16:40PM +0200, Peter Zijlstra wrote:

Alexander, I just noticed:

> @@ -2183,8 +2184,7 @@ static void perf_put_aux_event(struct perf_event *event)
>  		 * state so that we don't try to schedule it again. Note
>  		 * that perf_event_enable() will clear the ERROR status.
>  		 */
> -		event_sched_out(iter, ctx);
> -		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);

That this is scheduling out the sibling, and marking the group leader
ERROR; surely this is a mistake?

> +		__event_disable(event, ctx, PERF_EVENT_STATE_ERROR);
>  	}
>  }
