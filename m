Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB491509A6;
	Mon,  1 Jul 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829637; cv=none; b=LLZrMJ4Du1yzvyOs5bVm0t+tS7iNdNB6PtTp9w8npE8fRBL9yoYn2rK+AEFxFhv7QK89eEPAISGLjsvh6hDP/BH2WM5q/65A6W8Y6l5Fv4W2049Pzl5zOhOf+dV1k2E0shF/zhB/YoQnvdwX+GF1kCjc94g8UCHTB7C9nl8Qiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829637; c=relaxed/simple;
	bh=Ae+LjInKCHKU5PQp8DqXlIeZPpw3xgmBwQ9T3U7uWpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL7bRvHbuIY454YK9GdRZ+1kLwWGW62/ct4gkWmy5OpItjwRAoXtez05sbHX3unPmCYaY+Tz5DpGRTkfjkUXOgfkOmiaqagxxPzmfhvcK9S1syRngtNvyG1arwheP+TTp2Sg0GeM7Cb/OM4Y8lkIEfxmsdPHKhA5ylnI2HT1aDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qkH4nFpE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkH4nFpE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9c+PJ9qplCm9e71aGNj46Xv63qyZzWb3k6nVOLS8TaI=; b=qkH4nFpE/dI8n+JWCA7Fo5j8FJ
	jRvlopf2P+DW8DDyAXEeSzskDa9j9Qg8SY9qtBVV9GF7xrUE2lFUNHClTST6qXRFV1XUupHU40uKC
	T5b7fqy5JpIUiDz6yALapXj82qHS+1TUBgcFd9+ZTJbQ9pGYxRdXmBobO6b0SMi4nJZJlsVI46KKM
	R9IgSdvaTtkaOCbYPgWJWaSYj6PS9RmK+tDlyvLDQR4+FneoIDA2+7lLaBQrBlIusp/Jjke05T+Nl
	cP7vt7lx6N1s9lASCOk9v9W+lVpeMMty2ES0+JV5dLbeEFyfU040ecc1agZKovqblwSgR6ygbZ3UY
	jsd/UG7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOEFD-00000009dXr-1eTt;
	Mon, 01 Jul 2024 10:26:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60C70300694; Mon,  1 Jul 2024 12:26:44 +0200 (CEST)
Date: Mon, 1 Jul 2024 12:26:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V8 01/12] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <20240701102644.GA20127@noisy.programming.kicks-ass.net>
References: <20240628065111.59718-1-adrian.hunter@intel.com>
 <20240628065111.59718-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628065111.59718-2-adrian.hunter@intel.com>

On Fri, Jun 28, 2024 at 09:51:00AM +0300, Adrian Hunter wrote:

> Add aux_paused to struct perf_event for AUX area events to keep track of
> the "paused" state. aux_paused is initialized to aux_start_paused.
	
> @@ -798,6 +810,9 @@ struct perf_event {
>  	/* for aux_output events */
>  	struct perf_event		*aux_event;
>  
> +	/* for AUX area events */
> +	unsigned int			aux_paused;
> +
>  	void (*destroy)(struct perf_event *);
>  	struct rcu_head			rcu_head;
>  

Should this not be part of struct hw_perf_event for whatever hw event
implements this AUX stuff?

In fact, I would expect PERF_HES_PAUSED or something to go in
perf_event::hw::state.
