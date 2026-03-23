Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8062550AF;
	Mon, 23 Mar 2026 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279283; cv=none; b=Ndn8zeEULm8bfVRq5O4jswzKEGrKxcG7oukMON/a1VF1iHKfm7gm7j6jwTkjZP6MDDg7AzpyEYjDw+NOpO+2VIXvCpW1f/p1gFrK2fuUZwwQmSddBmWMnVgcOMPcCjGJNwzj5noFsx8hDp47H17qFmIC0B/QPhrU/AMi2cLMuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279283; c=relaxed/simple;
	bh=M8xbWTYUY/sP27bj4DKT4WVwrQMr/bpCfXwmvPf5T5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STzUx0qQFELqIPQga7kz3qDz1nkb/aQVVtanbaFmkLZ3wr+8k8uD70Ngac+UvbuA3rxmF6jWBgFiWAqNoNm8X7DuNj/ykq5S2vdIiBsyxAoLj6ix+TrXBqA/vpT1BMQxdpcTJ4uQUPW22quFGnycn4cjtDUhnZa/1E+mc1bgAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D7B14BF;
	Mon, 23 Mar 2026 08:21:15 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB45B3F694;
	Mon, 23 Mar 2026 08:21:20 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:21:18 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
Message-ID: <20260323152118.GB43072@e132581.arm.com>
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
 <20260205173918.GB3529712@e132581.arm.com>
 <20260205175250.GC3529712@e132581.arm.com>
 <CAP-5=fUY8dYzwKu-g3-HER4ji9ZeGmPQo9DeORW0w9ocW1qnMw@mail.gmail.com>
 <abFBoVrlGl9cIg1h@gmail.com>
 <20260311115011.GJ4153946@e132581.arm.com>
 <acFMfBS-85NWuDu-@x1>
 <acFP5timJfI5qWEJ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acFP5timJfI5qWEJ@x1>

Hi Arnaldo,

On Mon, Mar 23, 2026 at 11:36:22AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > I managed to reproduce using Leo's method:
> 
> But then I applied Breno's patch and got the same SEGV as below.

Are you sure ?

When my replied previously, I tried Breno and confirmed the Segmentation
fault can be dismissed.  Do you want me to test again?

Thanks,
Leo
