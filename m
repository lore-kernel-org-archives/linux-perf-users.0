Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231171E1C19;
	Wed, 30 Oct 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730280823; cv=none; b=RNdDoW95B5CC73qRvgSJhKczS2+sPajz+Zyo7wA3BRmW0rqdapUUGhoc9dpgj9rXTXnSh5vZjB/WXmtSw9JcTXegwM/7ZlFyy0Pu633nacXqglW04ampEcDfotFmc7yeUP6+vqIYu7u+aqb2YF+FL/8OR5r+dDhqFsHaJs5bpNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730280823; c=relaxed/simple;
	bh=X9Z8TnpUwAp2K9oCjBLoKrGjgPkgSh+lKyRDaK/eJBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqjBS6xCrP+NLTW7HRZ2xOJ1m4q+TzWlPM+XPytZB4e+wl50B8PkuZvg/faQ1OLwoFaEzk+rYhXB7jOyOCuluf0tuwlwwyi2pT5pUTs1lvahp0o6XrsdK+9Xdj6VUsSRoaEgMSnHIXuZBLnHaB9EVXHTByzYqGw4fwY7ZSWJnHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB80113E;
	Wed, 30 Oct 2024 02:34:10 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E47823F66E;
	Wed, 30 Oct 2024 02:33:39 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:33:38 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Graham Woodward <graham.woodward@arm.com>, acme@kernel.org,
	mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
	james.clark@linaro.org, mike.leach@linaro.org, leo.yan@linux.dev,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v1 0/4] perf arm-spe: Allow synthesizing of branch
Message-ID: <20241030093338.GC24446@e132581.arm.com>
References: <20241025143009.25419-1-graham.woodward@arm.com>
 <Zx--dTqaZPjeWA2I@google.com>
 <20241029170346.GB24446@e132581.arm.com>
 <ZyFrOo7K1qmjtaV5@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyFrOo7K1qmjtaV5@google.com>

Hi Namhyung,

On Tue, Oct 29, 2024 at 04:09:46PM -0700, Namhyung Kim wrote:

[...]

> > Please kindly suggest what is right thing to do.
> 
> Sorry, my bad.  It works ok.  I'll add it to tmp.perf-tools-next branch
> and run some tests.

Thanks for confirmation!

Leo
