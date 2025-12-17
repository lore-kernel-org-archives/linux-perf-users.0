Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB632ABC0;
	Wed, 17 Dec 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975074; cv=none; b=uxrnyrmtiSlgnC/fJZs43v/bDl+3GW/UKJQp6XwNRDD5+GDCCszinveyJIgPmF7MVB8lKwxuOvGAocLtbo650jsJJ8VCGxFA4lQLKLztKxnQmj/fT+h9UZAsIVa4EKSVRJuBnZVQfH/mAmIq2cC9RSELTMLZb6XXKMoyU2qZAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975074; c=relaxed/simple;
	bh=ou9Z3js+881lhZms28WvEv8+3fWb8COxwAvUIb3Y6eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxTPA8vVZ9Qt0lOAQMa/oSFI3HcRPCheMQqgFyRPvIqdJAPmizsYNgxuSYI37+dkhBZpxpYMtXNxvcabRWm8+p0ABY998MwcH2F3wUIOAe1+X5v3KUaYFtlnolaPNDdccNLEbS3IEra0258VvnjDm/LP7JDrg2ksZeqRNtAeVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri6sLOgi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri6sLOgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D25C4CEF5;
	Wed, 17 Dec 2025 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765975074;
	bh=ou9Z3js+881lhZms28WvEv8+3fWb8COxwAvUIb3Y6eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri6sLOgi0lf6bdQJUQ9mb0GNweroxafzDgTvHhiP8mDGpthvdOmdNvfKznW9rHSuW
	 teml1rwHmdrlGMlvqblAUWZcrIMmnX7JThc5qt6+DR45zjn4XvVYZXn1tYKy0GwvAF
	 hE51gotS8Hyb9WtRzbEs913j7hYsJniUVNeruXHvZV6c7OjnSv785cmdFJF9P9c87r
	 Adfit8xMRn0Gofd85WWk/OoXLwhjs/JSiknv3mFIvjjPPy9Kf2tV2xBvryzI9azGen
	 +gk3LFzJLvfEd8pxJhkuqGYTwWsoBE0hqJ4wvm/E5YFSGWDHkopHwjmzQZ85DmXCez
	 DWWfRiHwyxf0g==
Date: Wed, 17 Dec 2025 09:37:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/4] perf record: Split --data-mmap option
Message-ID: <aUKkH82uDY3c0dkB@x1>
References: <20251210023327.1669863-1-namhyung@kernel.org>
 <CAP-5=fXsrKvKAtAW3b-OzAdzg00hW-py-9eMvCxoY3Vs4p+7iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXsrKvKAtAW3b-OzAdzg00hW-py-9eMvCxoY3Vs4p+7iw@mail.gmail.com>

On Wed, Dec 10, 2025 at 02:05:23PM -0800, Ian Rogers wrote:
> On Tue, Dec 9, 2025 at 6:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Currently -d/--data option controls both PERF_SAMPLE_ADDR bit and
> > perf_event_attr.mmap_data flag.  Separate them using new --data-mmap
> > option to support recording only one of them.
> >
> > For data-type profiling, data MMAP is unnecessary but it wastes a lot
> > of space in the ring buffer and data file.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Tested the series and applied to perf-tools-next (6.20),

Thanks,

- Arnaldo
