Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8819241C8C;
	Fri,  6 Feb 2026 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412784; cv=none; b=AQvzyvkuSoDuFFV27vBAzSB7sTk0EleU2g2MrosNEY/9+Cz8uBUkmnY64moUCvFmxmM0H6yj1s4wsTx1hSQeI7G6KCea35MfpFr2uGyu44XSzDql5h6NoJD/uFlcW7QNk/0/MLqQge+I8XGRSWnZ7KG6h8r7ELHTp6fIVHH5cR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412784; c=relaxed/simple;
	bh=6NErU5KnnQRBqVCeVZLXZDnFZC/kLUPumlGUUXnaG3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=butjIBIWM5dvYSUZ6WVCGLQ4IjAOTLjLSkXWAsvhjBESuZ6u7YQScC92Mya8vFPRTEx7jT5r0K5xb1toLPjL78Ukk2zZOh438I00eLhvYxi4EXv0Dl+7OMpDRoJ/FoX7gFjtckVMSfVlxe4F7enpAnQAV+Ir473soX9GrKgz+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTC/anuX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTC/anuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C6CC116C6;
	Fri,  6 Feb 2026 21:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770412784;
	bh=6NErU5KnnQRBqVCeVZLXZDnFZC/kLUPumlGUUXnaG3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTC/anuXzaUKk1ctFNICm8RHA64RgL2m2Wd3XwYztEcrlm+ypXnh4VOgxtizqNlz6
	 udrMo2edlwVyqe5ZYDkIgE8YKzQJyB0hD+z4ASWmzy+8xBF8rnKK8nO0gd9Msvr217
	 MWVQnrbwm4t9EJlAsULEcEzMaFtQAhjqPdAU7zuJwVGiPZ6Nsguby8rw8O0ZHOcCZ3
	 P4M7Zn7GIrG6SAJp9cQ5gvguAjaU/ekr7s1Af1b75+Je76tkVvrpV0O301jJhc7dcL
	 4/SWzEAF1zUi9WvCzWfds0XgrU2ml2Z2G13eyHYNYFgpEE5rZ62lu9r7Wd+dBMJNo3
	 Y23jIACI7evrQ==
Date: Fri, 6 Feb 2026 18:19:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>
Subject: Re: [PATCH] perf annotate: Fix register usage in data type profiling
Message-ID: <aYZa7Z32z_WlQrsh@x1>
References: <20260206012743.2617945-1-namhyung@kernel.org>
 <CAP-5=fXn2jaPPBHfFLvZy-O2OXZbjOFHatDGdVm4b5q3C8jmnA@mail.gmail.com>
 <qncykxscahgsit26ctsja4jox4353uburbfoehfcuneycbgnvg@jvgs3twjn2rq>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qncykxscahgsit26ctsja4jox4353uburbfoehfcuneycbgnvg@jvgs3twjn2rq>

On Fri, Feb 06, 2026 at 10:08:55AM +0100, Dmitry Dolgov wrote:
> > On Thu, Feb 05, 2026 at 09:00:43PM -0800, Ian Rogers wrote:
> > It'd be nice to have a test on this to avoid a regression. Dmitrii's patch:
> > https://lore.kernel.org/linux-perf-users/20260127083030.5909-1-9erthalion6@gmail.com/
> > does that for a Rust struct Buf, but it'd be nice to do something similar for C.
 
> Agree, and I was planning to extend the tests in the patch above with a
> C workload as well.

Hey, did you test the patch? Having a Tested-by you in addition to the
Reported-by would be nice.

- Arnaldo
