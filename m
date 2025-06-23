Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768242C1592;
	Mon, 23 Jun 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750700732; cv=none; b=tRO9/xVDbxEhHXC7kJx99PmMyW2Csvtac0p0EnoeKNw/6bF9M5F0W3SPgnvT5om0YDVOuwT3/9i4jjevuhKtoBMgdBOFBgdfhg8p+be9A/TqZ2uyBbaTrEcgFL3pRvp4O34+Cf4uJr6m/f1HNUXfD6xAGZGwwMkyS2zTLMh4Fcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750700732; c=relaxed/simple;
	bh=hYv4xKHzWZDN1ntMAQvYZjMbKiXIkvOEWDoc+shcdVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZIQ4aIsEHd3ozTVNzeL76ECIygz4IGolEyudUZo9x1Srsjv+AT7VEy1iO2Kfb4nrGau30cESsoMaUlZ3AOTFrjFS3URjBOtVSWugcPgkSO5JC2JB6SbpXOWAMOifrFBGBRLQsIHNjgC6E/TsRqwu/OKhs2nLjl/PfxkwI27CaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s69Azbip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s69Azbip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF87C4CEEA;
	Mon, 23 Jun 2025 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750700732;
	bh=hYv4xKHzWZDN1ntMAQvYZjMbKiXIkvOEWDoc+shcdVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s69AzbipW2fqfvaiyCWr0xfg/6uYVtksIIIQZVOQmEKUT3KhpPEAWFk98qeOqKb4O
	 xF4hveD5INWbdMRmkrIQdP7aNYUxkLX8S7LWhmw9fDkR2cli+jRR/yv5IhvJo59LPV
	 smnHAZNwLiIcmIGP5z/uSZtK2Li2WepUjjCmp61aJtN7aZI7XuJvZlh7ZsKRnCv3WT
	 Tj4VVEHaWvgUR1dB6v4uUabO8KkE13Cw6DMWHmU6AVfMUP0VM4onwNIDVNa6vXgCOU
	 k9hS1nqetrbRL8m+SUwB3M4TfYkulPIuI6Mwx7qHJTy23F2wfEjy+5Y6g/R/r7wqjC
	 4/IZDye+anksg==
Date: Mon, 23 Jun 2025 14:45:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf test workload noploop: Name the noploop
 process
Message-ID: <aFmSuSyZ1ZNT94Tq@x1>
References: <20250619002034.97007-1-irogers@google.com>
 <aFW4VJtk96JD865U@google.com>
 <CAP-5=fUpnW1DE68pMW0q3vMT+n6d5SeNkwXd45XLaf01-eP47A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUpnW1DE68pMW0q3vMT+n6d5SeNkwXd45XLaf01-eP47A@mail.gmail.com>

On Mon, Jun 23, 2025 at 08:12:47AM -0700, Ian Rogers wrote:
> On Fri, Jun 20, 2025 at 12:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > I'm afraid it'd introduce a build failure on musl.  Please see

> > https://lore.kernel.org/linux-perf-users/20250611092542.F4ooE2FL@linutronix.de/

> > I think <sys/prctl.h> would be enough.
 
> we could do that but in the glibc man page it says:
> https://man7.org/linux/man-pages/man2/prctl.2.html
> ```
> #include <linux/prctl.h>  /* Definition of PR_* constants */
> #include <sys/prctl.h>
> ```

> It'd be nice to think musl was slowly getting fixed. I notice we're

Sebastian reported on the musl libc, its maintainer replied:

https://www.openwall.com/lists/musl/2025/06/12/11

- ARnaldo
