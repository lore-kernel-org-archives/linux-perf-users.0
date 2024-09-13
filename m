Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768833BBE0;
	Fri, 13 Sep 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241198; cv=none; b=EgzpIAPv5KXEcs9TwiHhP1m1JP2VSvxPz1tFbmzkoPHN6vZgdu74FI9XavNP52I04EyF3P3hb/Z5tyS97glph0HzasE9eSXV1yz1Uu4pP2eut0so/vUqFAO9vU4+9+plrpY9j0rZ9OIhpZXXYKjj45zzAXyd5/QYyGYB3qS9gFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241198; c=relaxed/simple;
	bh=tk2ldwHgpfFM8WFeOUm1XeMFoaVIE68l0zd8wBIKE6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXyHo4aEPq4M53tR9FFPlPz82jUXaBDfi2Ao7v4H4mK6dkAePwBF38Z/waBI/+TShGlWLmPBhn7TOYRXabi3CqyUMwkX9BeKQbB80mAQmVd/u4iZekxw33+IxDtgDM1z/Y6u2660DXpRbpnZH6bEVSTHFaQzDn8oyYkoMCseJC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LmXqy4sv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LmXqy4sv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tk2ldwHgpfFM8WFeOUm1XeMFoaVIE68l0zd8wBIKE6U=; b=LmXqy4svLHHSrxsUgsuDrap2hi
	/Ca+6BLnqz77xWZL8n/QP2FMDFFuLob7/M4TFUN+BXC1BiCwp51+QlJRhbmmo/jgIiquDfFK8bBPt
	CeSwAaQ6W9um0MIYBUQfmcXEvdQ6R3+VqTeT6+SXfj8yQWUcWXjsAAWffLagfIOeb0qwBcWWjYbdW
	/t6Sw22cFPaFIykR0+LC9F8QA90euyyzTUyeSBzsj0RPOPuTGPqiN6ENh/pm37CY27bB7/gUrqPwf
	mbjQOS/kwVHzRxF27Pzxc6QIQkrjxwGUBkP5BTUjgTXLfyV5Wnb8wwunf0cM32JCMxTNhN1tKjIO/
	i0sDCG9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sp8Bh-00000000g5U-3WsP;
	Fri, 13 Sep 2024 15:26:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12DB43003E1; Fri, 13 Sep 2024 17:26:21 +0200 (CEST)
Date: Fri, 13 Sep 2024 17:26:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Message-ID: <20240913152621.GW4723@noisy.programming.kicks-ass.net>
References: <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
 <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
 <ZVTuK5VRQfY1JOEY@google.com>
 <20231120140334.GW8262@noisy.programming.kicks-ass.net>
 <20240913130834.hq4gj27fcklakkzb@treble>
 <20240913133629.GV4723@noisy.programming.kicks-ass.net>
 <20240913135351.tyjuekjzvb5xtawn@treble>
 <20240913144714.gkksyfk242w3fvh4@treble>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913144714.gkksyfk242w3fvh4@treble>

On Fri, Sep 13, 2024 at 07:47:14AM -0700, Josh Poimboeuf wrote:

> Or if it would instead make sense to combine all the deferred user
> options into a single variable length PERF_RECORD_USER_DEFERRED event
> type?

This, have all those samples refer to the same future user callchain.
