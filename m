Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552B4A92FC
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367201; cv=none; b=fyK0qz00A7wiRZ86mpWCkBRv3LpT8A4Xepf0q4Z9PympQTU1gbHE/dM8ELGShyxFXBs8IgzQlLPi7bc0mWTKggxbC8oWDFZXNHm84yj/gu91CUcLexVKA3zsuUaFHlzujcVDy9bdrE6U9/XKSCfpD1aGn+IN6lx0Ktq31d2/KVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367201; c=relaxed/simple;
	bh=pk9nXMMqhR255P+kNDtl9aRPg/N7S1FPnFBz8qsMcgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkyNqKHc0VteBziAbTpEa7fJrINnyimrQ0hI3zHAu+Np7+rHJPKjR2W6RUWK2IyyZX4FRD846s+PZyB6F45wBDIsiPKG+6Gt6tqFakE4E1PK0oLpMI6HY+/8J42k40IatuANIIeXZ68+f84doypilHutJ7ZiugMxZrsFsgC3Rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MKF2kXB7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MKF2kXB7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A8B165C;
	Wed,  2 Sep 2026 09:39:54 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2FCA3F882;
	Wed,  2 Sep 2026 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788367198; bh=pk9nXMMqhR255P+kNDtl9aRPg/N7S1FPnFBz8qsMcgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKF2kXB7qppnoZ3UdGd2XyxN5NHdL8geuGn3V0qKQOpSJ8uouluJDVUXI2xvcbr4M
	 wU8SA4y1q/YLmyPBSOE0EVrb2T+gjAjR0nkg2feG6fKDPANTLGIRDfS+OFty0Zrz2E
	 LIj807hSk9tmBT5Fbo1ZhH4TWCISi1KLC4qP6Db4=
Date: Wed, 2 Sep 2026 17:39:55 +0100
From: Leo Yan <leo.yan@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Suppress redundant ITRACE start
 records
Message-ID: <20260902163955.GW8904@e132581.arm.com>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
 <20260901-perf_suppress_itrace_start_records-v1-2-c4fbc6860859@arm.com>
 <20260901164705.042781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901164705.042781F000E9@smtp.kernel.org>

On Tue, Sep 01, 2026 at 04:47:04PM +0000, sashiko-bot@kernel.org wrote:

[...]

> > @@ -890,6 +890,8 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
> >  		return;
> >  	}
> >  
> > +	perf_event_itrace_started(event);
> > +
> 
> [Severity: Medium]
> Does this correctly suppress redundant records for inherited events?
> 
> The core event scheduling path in perf_log_itrace_start() internally resolves
> to event->parent before checking for the PERF_ATTACH_ITRACE flag. 
> 
> Since perf_event_itrace_started() only mutates the local child event's
> attach_state, the parent event's flag remains permanently unset. 
> 
> Won't this cause the perf core to continue emitting redundant ITRACE_START
> records on every subsequent schedule-in for inherited events, negating the
> intended fix?

This would be an issue in the event core layer and should be addressed
separately. I will send a separate patch to fix it.
