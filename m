Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245017A2E2;
	Thu,  8 May 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725783; cv=none; b=EUs++h5LtOAiv+bktAOOjgabin9ULYUVDJOIMveooziwWZfPcBzzYoMsG0qC2DfZC51B6lvaP3/COp4xtF/NAmei6SXGiWxJwSasyTLQQlHIteVMYfv0xj5Le4sPFty4blDuYqwHpdMh3XAzdNJ370PXyVdaPXZPCLLGgqDlRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725783; c=relaxed/simple;
	bh=TPPBajYbOXnOMisTyRCTIUrrPRw+IpWCpUea4dcpNjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsM9W9Eqw6F61OxfY6ctL2uloXnTvcApU7quYG1cjp6l3WgfhLu4ygq+Mh6B9iLqtaTp0JyCgCbSGGo3pM8vfqPdKPVfB075BxO5mhNrcPiR6iRzh7aPA1Domz0TN6/ROWIL9ZiM8I1K3tnhpxNLXoptlPuU849p9Xq9p38TilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2xXc226; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2xXc226"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C16DC4CEE7;
	Thu,  8 May 2025 17:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746725781;
	bh=TPPBajYbOXnOMisTyRCTIUrrPRw+IpWCpUea4dcpNjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2xXc226hoFNPYxhcrZGHkSF04Px1BB78TYpablQIBdgOmsRkYaE0c7ynezY++woN
	 hZKFVTayWcmihj8CcTQwzyMbcTKm3RqdjBpHtpi4Os4d3HXG/KoC8s1dRUGBrGagJ+
	 JoRzLDVCFvqrdb9Y7AED+SsfiBEuDpotlT2II1TCCNGUBaBAVF3vhzbvm2R9sc/UeI
	 FlZtluSbLpJUQmt4anuzUWQqIN7WF8Nm+kJ7TG0O/xa8mJ6UAhUitt6xTxynq68ucp
	 Zm13Vya+oi6OqFLAiqdvIze9VB9aJv5dS3SIUbb8yWxCiBI/Rjq5M6rgyI1znIUZEp
	 cybBmj6c/jOVA==
Date: Thu, 8 May 2025 10:36:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Fix some more memory leaks
Message-ID: <aBzrkz0__S_eupgB@google.com>
References: <20250401202715.3493567-1-irogers@google.com>
 <aBzFGKKubskQDLrs@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBzFGKKubskQDLrs@x1>

On Thu, May 08, 2025 at 11:52:08AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 01, 2025 at 01:27:15PM -0700, Ian Rogers wrote:
> > The files.max is the maximum valid fd in the files array and so
> > freeing the values needs to be inclusive of the max value.
> > 
> > Add missing thread__put of the found parent thread in
> > thread__e_machine.
> 
> Split it into:
> 
> ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -2
> 7900938850645ed4 (HEAD -> perf-tools-next) perf trace: Add missing thread__put() in thread__e_machine()
> 8830091383b03498 perf trace: Free the files.max entry in files->table
> ⬢ [acme@toolbx perf-tools-next]$ 
> 
> So that git --oneline is more descriptive, etc.
> 
> Thanks, applied to perf-tools-next,

PTAL this one as well.

https://lore.kernel.org/r/20250403054213.7021-1-namhyung@kernel.org

Thanks,
Namhyung

