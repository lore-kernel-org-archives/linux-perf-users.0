Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0F337BA3;
	Sun,  1 Mar 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387133; cv=none; b=Jk4A1Qorg4+MSLq75OzVZlzMrp3SWyq6NUAlQyzHbsILDjwG2kF9lcWrkkaJhLmd8xa9/6xMCQKc6SAIbbhVl0I0iXzqNj4LWBlz8gwYOvrgHZZCNqezMsLrKZzLEenYAznRCFIUVLLLpH//eQaTaCY8QuU0fdnYWJt6PHcm/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387133; c=relaxed/simple;
	bh=+afZ4JBwvJFGSh+PEorzjMVsoN5C9ll4aRFOdOCzp3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1SJ/ZUGMTFXgRbRw1Y5eWHXWWf30dlcvfWRCPjw+ie3Q0ZCr4WcygzOGm3b+M1k5Bq+n3ZENGzsWhBowFixAtGueU0yBU3cHQ5ISvjGhetvW9jO0F2ZktpEBZleSzdfCX/Dq34pgaortdT6pni/PmOf9VzRUFzNzDZrd3Ivsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B101477;
	Sun,  1 Mar 2026 09:45:24 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61CA03F73B;
	Sun,  1 Mar 2026 09:45:30 -0800 (PST)
Date: Sun, 1 Mar 2026 17:45:28 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf kvm stat: Fix build error
Message-ID: <20260301174528.GC1098637@e132581.arm.com>
References: <20260206-perf_fix_kvm_stat_error-v1-1-ad40115876be@arm.com>
 <aZ-oYb-FDLVT5MGq@google.com>
 <CAP-5=fVCdQZ584s_24wQc_+03xL2Npj2qDbqGSjE=Ms1-y8raQ@mail.gmail.com>
 <20260226095255.GF4184494@e132581.arm.com>
 <CAP-5=fUAK=vzeZWDXuun+wptSeBwUMhZuVqdh4zwLoXoV32VPA@mail.gmail.com>
 <aaFIgR29wGYvHnVp@google.com>
 <CAP-5=fWGpmk6w+SUv5PnhEXxyYe87ostV4sNZa0tZVPWhh+GjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWGpmk6w+SUv5PnhEXxyYe87ostV4sNZa0tZVPWhh+GjA@mail.gmail.com>

On Fri, Feb 27, 2026 at 09:30:56AM -0800, Ian Rogers wrote:

[...]

> So it is still the wrong fix. The relative include paths is the real
> issue, just add the missing "../". I'm not a fan of changing the
> include order as it has the potential to break things due to the
> subtle way that includes are picked up, tools/include isn't hermetic,
> etc. While it may fix one build failure we are likely creating build
> failures for others - well me, with bazel, for sure.

Thanks for correcting me. I have sent a patch to fix the relative paths.

Leo
