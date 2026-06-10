Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD635E931
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121993; cv=none; b=KNjDFBR1Dy0VooUp7HjOusYCPth0yA6bpTU3ngHANO2LgHlLBDlIWVhpSnv4BqYFYxh2TGkZEenzIUfxFpsg3i9eJ2a24LoxSLoEjyMdMbglAuqWuOd0ZX9DMSIPKJEYgL9xMzdrS1g1plJe2Bh3Op4xQEk9SNhnckHnWrVrAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121993; c=relaxed/simple;
	bh=HH+KdHR1kgQrxLYd0DgXNNwp/Jh3+ZCh7F7Yyrc98d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVSmFGXRttgO0mFMuXQ8SvXHl1IdNJbdC2mPnhhdPVWlkB3XwDe2hziBT4gJGl353q/ptgh+cKgpVhCLAqnGvlXgMLeruREh9bBvtKotj9PiNdn/s+79zqaIdBs71nArniNA2KccMRit1n8KQO/b3tHZKvUmEMiGDbMW+zaf/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHDmgsSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHDmgsSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478291F00893;
	Wed, 10 Jun 2026 20:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121987;
	bh=rCaUEECqrgHzs+l+C2U3sMRyDVHTVG4HuRBcFAotcnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RHDmgsSOwly/2yH/0h6ucWMbtmVDE3hlA2WdgHnUUfP9nObgl/QU6+Nh5Y7KG/qgO
	 lJXFWRCEc6INDgb4b2j1RY5ezoW+HyXcDUF2Y4+gFc8WirYMQZgGCeswYcHvLBg347
	 YIJNwHmCgbSftZhQ6hHyXgFfzWIVYnX/F3LKZ1F5ApL28E1XG1kj09ROXphb8oXd/h
	 9+0h1ch+u0lrVLwXyMe94Vx4G/NSIw2DWC7Rl4YTlRgkcpLv7mvc/X4vlC+4Q8QQB2
	 K9KQjBEnqGViPa4qXl5Sr4J+GPsGxAQa97fgMqI9hSKOQB5BJqoSoeDuWjcHaevDtM
	 MR3aV5PS9NkjA==
Date: Wed, 10 Jun 2026 17:06:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Tanushree Shah <tshah@linux.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] perf data convert json: Fix addr_location leak on
 time-filtered samples
Message-ID: <ainDvxug5fvibbbR@x1>
References: <20260606121528.406919-2-tshah@linux.ibm.com>
 <CAP-5=fUOUtbfXXtGdSYrg1SfuTryNqFPknKWDc=4MxK==m6+VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUOUtbfXXtGdSYrg1SfuTryNqFPknKWDc=4MxK==m6+VQ@mail.gmail.com>

On Sat, Jun 06, 2026 at 08:47:37AM -0700, Ian Rogers wrote:
> On Sat, Jun 6, 2026 at 5:20 AM Tanushree Shah <tshah@linux.ibm.com> wrote:
> >
> > When samples are skipped due to time filtering in process_sample_event(),
> > the early return path bypasses addr_location__exit(), causing memory leaks
> > of thread, map, and maps references acquired by machine__resolve().
> >
> > These references must be released through addr_location__exit() before
> > returning.
> >
> > Fixes: 8e746e95c3e4 ("perf data: Allow filtering conversion by time range")
> > Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
