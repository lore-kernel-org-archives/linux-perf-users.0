Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243F1E485;
	Wed, 11 Jun 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648288; cv=none; b=HsOJA+VX8t33Nw3rsRS+HSv6iowbf6Lfmgc3RXZCn1tTSlAunI7L5s/ufkXRzKAACAaotn3l2AlJdOgL3M8azBenRBJRTzgWCGJNV1hPEM9vroBQxvor5rOzfsnvoCN2tjL7yWkMhXnKSDDgEmFofnq4wOhm0D0Q+6nZtFkj0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648288; c=relaxed/simple;
	bh=/Mu3IF1mwNpjWEGSrFHV3iRplU4CScRZLwfbRhdBq5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJu1srspnOpFZD4jDkLNuYr0mOqcxviFpF7dNmqWS6qZfxLl6Xm1yT4HemcV20C49POaRQsSYcxqD8qGxNtnL5v+FhtbQqjj3EE9lyZsBS6gAa4JrD7ZImw3/ztR2OBYujWh7xXW9J3+eJw2bPII3MnYPhotNycBIl0a6R2hTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6pgfNdo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6pgfNdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1C8C4CEEE;
	Wed, 11 Jun 2025 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648288;
	bh=/Mu3IF1mwNpjWEGSrFHV3iRplU4CScRZLwfbRhdBq5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6pgfNdoz6lk4cttWYLFj211eoFSx1f2RgDPeasAwXocF9UQiw6CZbAXV4iGWTOCe
	 qkRm0mNRLWTk9h4IRH2ojHMrcH747HWnf7IPHsxS6WMvLggfzcPxBjB2LRlZRQlfEF
	 5IaSll4FXZ1nI7F7PwHVXqk/ZO3VC/DQLyMqrlT2Jf+45EwY2px1IdKRKh5AY8Cgbl
	 0UEBukK+RJDb2Yw79wWQ7lyh7LZ72Vhb+d4OBdXwwkADBGLkpBI568TPmdBQfrxi/s
	 spWOsK1OqzA+ZYrAd6jyuqRdkumZq4k/yLw4tF33zvXpThFqFL7oErS1rg0qRsjpRP
	 p0e/AcwTFCDnA==
Date: Wed, 11 Jun 2025 10:24:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/prctl.h with the
 kernel sources to pick FUTEX knob
Message-ID: <aEmDnb4oBXkGGtIh@x1>
References: <aEiYOtKkrVDT03hZ@x1>
 <20250611084326.X-sUHsGX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611084326.X-sUHsGX@linutronix.de>

On Wed, Jun 11, 2025 at 10:43:26AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-06-10 17:40:26 [-0300], Arnaldo Carvalho de Melo wrote:
> > tldr; Just FYI, I'm carrying this on the perf tools tree.
> 
> Thank you.
> 
> >   $ tools/perf/trace/beauty/prctl_option.sh > before
> >   $ cp include/uapi/linux/prctl.h tools/perf/trace/beauty/include/uapi/linux/prctl.h
> >   $ tools/perf/trace/beauty/prctl_option.sh > after
> 
> Ah. I missed that copy of prctl.h
> 
> …
> > This addresses this perf build warning:
> > 
> >   Warning: Kernel ABI header differences:
> >     diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
> 
> But I did cover this one.

I fixed up the warning message being addressed, the attempt was at
having what used in perf just in
tools/perf/trace/beauty/include/uapi/linux/prctl.h, i.e. just for
scrapping, not for building things with it.

But then:

commit c142850fbc956058ff2f2987d3d11eb2c628f710
Author: John Hubbard <jhubbard@nvidia.com>
Date:   Mon Jun 17 19:24:21 2024 -0700

    selftests/mm: kvm, mdwe fixes to avoid requiring "make headers"

this adds another copy there.

I think we should then remove the
tools/perf/trace/beauty/include/uapi/linux/prctl.h one and make
tools/perf/check_headers.sh to go back to check
tools/include/uapi/linux/prctl.h.

But then, as mentioned in tools/include/uapi/README, its better for
people updating the kernel original files not to update the copy, as it
may break tools/ code if it, for instance, starts including some other
header, etc.

tools people should notice the warning from tools/perf/check_headers.sh
(that now probably should be moved to tools/ as these copies are not
used just by perf...) and check how to update it.

- Arnaldo
