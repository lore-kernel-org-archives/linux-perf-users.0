Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CF930C172;
	Wed,  3 Jun 2026 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509743; cv=none; b=ERHH2dV7Xqd8RdKmO41COYRcB9mkvT4He3sRUh6a3ekBAGRrVvw0IrmS2jauyDhbwUj1MS4hNy7JRVwOEOxjsG1zEwlDdXHZ15OkLr2pKWj59s420L0XeoEifhbyxPyhGXvE7tC+5wQBr/uRFwpGk2fFjJN0gmEwQxcJC/wjgpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509743; c=relaxed/simple;
	bh=lmhwszwTnU3Q3JHM+/XBGySA8Gc25qMt27N90Fz+jZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYNty1bYP/iatbscuy20i/jgzlDHjKjtzC9UvDvismFUMoBD/GamFSZ9gKoXlsf2qY+r+cA6LovFl+1nfV3LzPtQznqUuOtrrafDYehexYmoJiZdUPPg8tgF8WVbBcAUBFGlHdTreNw7j31eQzu8MJhHdv5PaG3ZpdJpz3hQmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nIehGqJo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nIehGqJo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E467E4A8E;
	Wed,  3 Jun 2026 11:02:16 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BCD63F632;
	Wed,  3 Jun 2026 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780509741; bh=lmhwszwTnU3Q3JHM+/XBGySA8Gc25qMt27N90Fz+jZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIehGqJodgz03W9TnsjsPRHLSYvg3NOImaCDqR/tvUprKFiPv9nIpG6Z9T/mzw39N
	 UzrF/IODbBO5E1J1YCbQOs5mav0YFXHp7w1eTc4gndsW8oA4M2dqydlY7YyObbWffs
	 bAaqVNN4jPIDBTBGqlJeH86rlcEqHYg0I+4iHb2A=
Date: Wed, 3 Jun 2026 19:02:19 +0100
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
Subject: Re: [PATCH v2 18/18] perf test cs-etm: Move existing tests to
 coresight folder
Message-ID: <20260603180219.GJ101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-18-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-18-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:27:00PM +0100, James Clark wrote:
> There is a subfolder for Coresight tests so might as well keep them all
> in here.

Now we only have two shell test for CoreSight (I might add one for
callchain test), seems to me it is more meaningful to move Arm specific
tests into a central place (like tools/perf/tests/shell/arm/) for
easier maintainence.

Anyway, this patch is fine as well:

Reviewed-by: Leo Yan <leo.yan@arm.com>
