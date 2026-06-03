Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931C3DB339;
	Wed,  3 Jun 2026 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510622; cv=none; b=ano3vI4SnRm8EC14NMhPWLslKQzqiB+7CtdSbIo3mXLHVeHgkoSMpiKGrdELtmXnd4yPjUJX2+7PZqMRJOXK+3ztnK4UrpTwayxaGfkrtnKdUj5gV2BXLFPbK6ZrsNBBy/RnSqaNhJoqhjeUUpruy6fXlaMObMGhtfZIJ4OqNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510622; c=relaxed/simple;
	bh=7g7eSXNFd6x4zcH4Pn9AImxVzHQhVePOAWugkZSlJjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIOuQadGFcemzgMVDPeQGffC//56F+Irm21NKV8GIbfLvcWPcS9DT6OlKZmnI0/9XoCYr0P4oOiGrjNn9QXVR2b2ynbOFqP1VSyw7877J8Q/tfiIbUPRvfdvJoC6cYOm4+hEzJ3pe+aVbdeZea4rpRma3c0yt8T+1mGEv/2R0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ef7nMb0E; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ef7nMb0E"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C4114759;
	Wed,  3 Jun 2026 11:16:53 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE8393F86F;
	Wed,  3 Jun 2026 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780510618; bh=7g7eSXNFd6x4zcH4Pn9AImxVzHQhVePOAWugkZSlJjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ef7nMb0E/12bcYNdfNrimAlNTgIO5Hh/D+hGfpd1wQMciIW+L6sdey7AHanePjgGA
	 LeGZso7Nz8eTNiupxyEMegCmZCPZvK2H/wQHJ7OtDm71XoWfD96dpOVpdBNdGT9itY
	 AfIOaAuJc2W6AUR1LCrMFLxWSstgTsUdUJcgEWRw=
Date: Wed, 3 Jun 2026 19:16:55 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 08/18] perf test cs-etm: Replace memcpy test with raw
 dump stress test
Message-ID: <20260603181655.GK101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-8-85b5ce6f55c6@linaro.org>
 <20260603143622.GX101133@e132581.arm.com>
 <882922c0-042a-4108-bc2f-cec443d0db9f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882922c0-042a-4108-bc2f-cec443d0db9f@linaro.org>

On Wed, Jun 03, 2026 at 05:11:30PM +0100, James Clark wrote:

[...]

> > I am not sure how we can map 2MiB trace data to 50MiB+ raw dump.  This
> 
> Why not? Decoding it is roughly equal to decompressing it, and with that
> amount of trace the small differences in compressibility average out and you
> do get the same amount every time. I think if we got less than half the
> amount expected then it would be worth investigating.

TBH, I don't know how to calculate decompressing size. Seems to me this
is a heuristics value.

Maybe Mike could help to confirm if this works or not.

[...]

> That would work, but that wouldn't be as thorough. The first thing it prints
> is " CoreSight .* Trace data: size .* bytes". If it stops working half way
> through or prints nothing then the test will still pass.
> 
> The reason I wanted to add a stress test is because all of the other tests
> have been reduced to just a few kb of trace so we have nothing that opens a
> file with a more reasonable amount of data.
> 
> I suppose with your suggestion we'd still check the exit code, but that's
> about it.

Is it possible to locate the end of raw dump with a specific parttern? like:

  Idx:36061; ID:1a;       I_IGNORE : Ignore.
  Idx:36062; ID:1a;       I_IGNORE : Ignore.
  Idx:36063; ID:1a;       I_IGNORE : Ignore.
  Idx:36064; ID:1a;       I_IGNORE : Ignore.
  Idx:36065; ID:1a;       I_IGNORE : Ignore.
  Idx:36066; ID:1a;       I_IGNORE : Ignore.
  Idx:36067; ID:1a;       I_IGNORE : Ignore.
  Idx:36068; ID:1a;       I_IGNORE : Ignore.
  Idx:36069; ID:1a;       I_IGNORE : Ignore.
  Idx:36070; ID:1a;       I_IGNORE : Ignore.
  Idx:36071; ID:1a;       I_IGNORE : Ignore.
  Idx:36072; ID:1a;       I_IGNORE : Ignore.
  Idx:36073; ID:1a;       I_IGNORE : Ignore.
  Idx:36074; ID:1a;       I_IGNORE : Ignore.
  Idx:36075; ID:1a;       I_IGNORE : Ignore.
  Idx:36076; ID:1a;       I_IGNORE : Ignore.
  Idx:36077; ID:1a;       I_IGNORE : Ignore.
  Idx:36078; ID:1a;       I_IGNORE : Ignore.
  Idx:36079; ID:1a;       I_IGNORE : Ignore.
  Idx:36080; ID:1a;       I_IGNORE : Ignore.
  Idx:36081; ID:1a;       I_IGNORE : Ignore.
  Idx:36082; ID:1a;       I_IGNORE : Ignore.
  Idx:36083; ID:1a;       I_IGNORE : Ignore.
  Idx:36084; ID:1a;       I_IGNORE : Ignore.
  Idx:36085; ID:1a;       I_IGNORE : Ignore.
  Idx:36086; ID:1a;       I_IGNORE : Ignore.
  Idx:36087; ID:1a;       I_IGNORE : Ignore.
  Idx:36088; ID:1a;       I_IGNORE : Ignore.
  Idx:36089; ID:1a;       I_IGNORE : Ignore.
  Idx:36090; ID:1a;       I_IGNORE : Ignore.
  Idx:36091; ID:1a;       I_IGNORE : Ignore.
  Idx:36092; ID:1a;       I_IGNORE : Ignore.
  Idx:36093; ID:1a;       I_IGNORE : Ignore.
  Idx:36094; ID:1a;       I_IGNORE : Ignore.
  Idx:36095; ID:1a;       I_IGNORE : Ignore.

Thanks,
Leo
