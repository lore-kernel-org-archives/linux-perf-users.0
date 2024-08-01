Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2F130A47;
	Thu,  1 Aug 2024 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524664; cv=none; b=p+vZNOshqSaXRwnH/e/G4wP4N53GD4ZBysBfYWxuvbQxm6CebW/zhangyBpz5ex6tg/BLX67rbm4BUmkU58LKI54/6SE4HO14xhYXXjFkFPTe1yISCGHrhnuClpiRb0hmT0h4eCHEJRrAuFgGb+++f9cajBBBqS1cv0yY3UBzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524664; c=relaxed/simple;
	bh=idaUKjDIW8k70S37xTI/0x+89jpaHRMoZi7bkaOXyaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJNP6d5O0Mw/Zc9XQ8ScUKc1j1odstWJ6eMszaBVrRhCdnufRRY0dSLtDAPe6uVrURlZqd0IqEsNcRQFBhcahFQ5WzFDnVpiGmOY8Vv1ZM/iEU4XkgKsVTdYQHe7LuEw0U0Rkag3ZSec8Nzp7P9aLf7B4r6KGwCNYTAWce32SGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDsiMfoo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDsiMfoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7569C32786;
	Thu,  1 Aug 2024 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524664;
	bh=idaUKjDIW8k70S37xTI/0x+89jpaHRMoZi7bkaOXyaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDsiMfoo3T2mn5rDBG4xk7HTigkkxXhCQ3NUE/ixjZQi3HBEgF2tpiYobWjt0+/yG
	 xrFkudGHXZ+kyfFtPHkMtkzUzO4o2o+J5QGF89/o+Jz9LSjy1wbJJDYFxUsUP2IrxL
	 ZP523lBrcRntFwplToJrd7cMEWEHIgZdZCVE84UxWOnEieqOOhAy68KNuL5AuBToNf
	 CeaRJkN6uUL/8wYDJbBT91agj2KWICsVJvh1LxsiMA6GOrME4pxwQAGlXpBqLlUX3+
	 RE4fhn2aYgSBp6bixl7U6WIf/z3EzFA7Oonu/WihG7vp8CeHubRzCGKMm9hSw7gHJ2
	 jjgG3cKN/aiOQ==
Date: Thu, 1 Aug 2024 12:04:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/6] perf auxtrace: Iterate all AUX events when finish
 reading
Message-ID: <Zquj9TJM8QQKkpYL@x1>
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-5-leo.yan@arm.com>
 <9f08c5cb-fb4b-4994-9128-0484aa6c06d7@intel.com>
 <9f301b09-e040-456c-9bd3-6d5e96ebc8f4@arm.com>
 <1cb6fdfc-0405-4bfb-acd4-ed3b24744c8b@intel.com>
 <951fc660-58a2-4b8a-a763-5a1e4d807c75@arm.com>
 <CAP-5=fWfU40-QO_TuUMd2KQprvxPOH2pnpKCUxJf1yoUsw-9mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWfU40-QO_TuUMd2KQprvxPOH2pnpKCUxJf1yoUsw-9mQ@mail.gmail.com>

On Wed, Jul 31, 2024 at 06:38:59PM -0700, Ian Rogers wrote:
> Just a heads up. Arnaldo added this to tmp.perf-tools-next and it
> caused the intel-pt tests to start failing:

My plan right now is just to remove that cset that Ian bisected since it
is not on perf-tools-next, just on the scratch branch
tmp.perf-tools-next.

Trying to do that now as it will help us with bisection in the future.

- Arnaldo

> ```
> $ perf test 118 -v
> 118: Miscellaneous Intel PT testing:
> --- start ---
> test child forked, pid 148999
> --- Test system-wide sideband ---
> Checking for CPU-wide recording on CPU 0
> OK
> Checking for CPU-wide recording on CPU 1
> OK
> Linux
> Failed to enable event (idx=0): -22
> Failed to record MMAP events on CPU 1 when tracing CPU 0
> ...
> ```
> It's likely Adrian's comments already address this but you may also
> want to double check this test is passing with v2.
> 
> Thanks,
> Ian
