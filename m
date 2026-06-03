Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F046AF25;
	Wed,  3 Jun 2026 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507552; cv=none; b=bwxdfXcAAMMtf39czUzmRR+VPbKAATYo5+gl1QNjYZ6K66/XwvjtKF+Mer/1oiPEShJK9pnOLkHvGqskbEoHEGwoZhqzXA6ueaDTa99ohHAPnsYccOG2YYk81dMLGPeFMzWK/1QktnVwMa/oailQj673qZIdMo4UkmaiDa6vaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507552; c=relaxed/simple;
	bh=anTGzF7oayhyPYjHbKMStu7+tfPS/JRi4bkgcvtFiuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXHk4myuMJ0OfLa1lDNqFI9u4vTqa6+G3goUmjk6DkdfA9HxYerNytBW8j9ayOMb73Zy4X5VtQJ8KtZwJDFEOBjWS81c0ssIc3i10DBZISIJvtSM9kuH9h3xrLTd5xMcSRh9W9EgnGYQWsAFmvaByXeeZsJxu6HdyVvD6AvYGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nYdvIbaE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nYdvIbaE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6A63293;
	Wed,  3 Jun 2026 10:25:44 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC05F3F632;
	Wed,  3 Jun 2026 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780507549; bh=anTGzF7oayhyPYjHbKMStu7+tfPS/JRi4bkgcvtFiuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYdvIbaEMbtjEBgdXMLLbPUUI8eNNoGwHqqIPCbbmrtwa+n3aJ5qrixyuIzRhS3cL
	 8MMQAhtYUgL4jyHjo75mNekJ4Jg97/DrXylpOCkfsXh7V1IJ/T3jbcNVwbFYO6W4uZ
	 NfoJGnvahILLHII29c/L84rWDiiehr1WLGQP115M=
Date: Wed, 3 Jun 2026 18:25:46 +0100
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
Subject: Re: [PATCH v2 14/18] perf test cs-etm: Remove unused Coresight
 workloads
Message-ID: <20260603172546.GE101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-14-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-14-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:56PM +0100, James Clark wrote:

[...]

> -When you run perf test, it will do a lot of self tests. Some of those
> -tests will cover CoreSight (only if enabled and on ARM64). You
> -generally would run perf test from the tools/perf directory in the
> -kernel tree. Some tests will check some internal perf support like:
> -
> -   Check Arm CoreSight trace data recording and synthesized samples
> -   Check Arm SPE trace data recording and synthesized samples

Should we keep the chunk for but suggest a perf command as

  perf test "CoreSight" ?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b539be153f6a..7efb893edcbb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2751,7 +2751,6 @@ F:	tools/perf/arch/arm/util/cs-etm.h
>  F:	tools/perf/arch/arm/util/pmu.c
>  F:	tools/perf/tests/shell/*coresight*
>  F:	tools/perf/tests/shell/coresight/*
> -F:	tools/perf/tests/shell/lib/*coresight*

Need to delete tools/perf/tests/shell/coresight/* ?

Thanks,
Leo
