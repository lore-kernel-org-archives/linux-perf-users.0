Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637BB47A860;
	Mon, 28 Sep 2026 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584454; cv=none; b=nZx9M3MmJZaXaqh3TxKCC6NYAEQg6RdjDtvBCcmYB/f+ZBf87bgSWb3jn6j9J4M32Ts1z/gYVS79OnYYFQclev86G2u0kz21GrCtcLMsnaKQsLBmzZzZKETz5eyav4MJuo7QwdLMrUOk6aBvUwaj3xwG6o0suOqJB5bEpdHYCHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584454; c=relaxed/simple;
	bh=sjy+jOogKa1C0RGxmYJGrorGsiGN1pV70X0DLsrysPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eibn7DgVqyj3+yNKhohT3FvzpXl3p4nTdnm2OWwlJjJ61WwR81460bqmAFrZGxuT2o6rSUlBerQQSQyDlYCiblK6kISDqxGKwvm/KTfoXFwM12NicJSY2LqqifPrkHKCAEdp5NAZ2UHqR37QkBVsJ2uuC95r+S+/BLoBbh3ddio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YRM4nm5f; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YRM4nm5f"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3990D1570;
	Mon, 28 Sep 2026 01:34:09 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 506053F86F;
	Mon, 28 Sep 2026 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790584452; bh=sjy+jOogKa1C0RGxmYJGrorGsiGN1pV70X0DLsrysPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRM4nm5fEynHDgWuBm3y1ICeroMFVhyCUHft4T4Qp0Kt4JMgIC+qaIvC01LZcQa3X
	 6nujvNBv/arIA6xAFxZtfT0GPi6eh+EfrG31NYgy27zzHFDXnybuSv77FVsSuvxQ6X
	 g5tZlyWTbdGjOgwB67jNes5KDT49OKr8rYhYDS4A=
Date: Mon, 28 Sep 2026 09:34:10 +0100
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>, Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 1/3] perf/core: Export perf_event_itrace_started()
Message-ID: <20260928083410.GB14479@e132581.arm.com>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
 <20260901-perf_suppress_itrace_start_records-v1-1-c4fbc6860859@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-perf_suppress_itrace_start_records-v1-1-c4fbc6860859@arm.com>

On Tue, Sep 01, 2026 at 05:36:15PM +0100, Leo Yan wrote:
> Since Arm SPE and CoreSight drivers can be built as modules, export
> perf_event_itrace_started() so that it can be used by these modules.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Gentle ping!

> ---
>  kernel/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a311042afab6b65814a84c67b87ba929b..8afe89179a62127eebae0f38f29cde045ba56251 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10560,6 +10560,7 @@ void perf_event_itrace_started(struct perf_event *event)
>  {
>  	WRITE_ONCE(event->attach_state, event->attach_state | PERF_ATTACH_ITRACE);
>  }
> +EXPORT_SYMBOL_GPL(perf_event_itrace_started);
>  
>  static void perf_log_itrace_start(struct perf_event *event)
>  {
> 
> -- 
> 2.34.1
> 
