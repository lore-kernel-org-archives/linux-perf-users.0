Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BE3A59;
	Thu, 27 Feb 2025 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644586; cv=none; b=p1VWKgN1KqbwYUIhv/tmOgMkjLfdTgQwzHlOrmnInv91DA50uvVH2+AsA8Ifuf2qAdwK0PXqgmp2Mv7B0ZFcvigSfeFzZxxgb0WjGCT0NcsdgwX8C5/1WYNExbFcwN8O0yPKIrgIplkgaKHI4O2lb+gZFeBew1IuDmvkP1oKEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644586; c=relaxed/simple;
	bh=nK80OQN95rpSbI/Cb1bmSAA0fXKECfAsrcb2cug/j+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIPakZ6/Ni6cGAG+0F1+/ygoZp2ghtY7MyZpcLKr7sziaymSH5C2EOTp6rpwXXaY4bCsOpZhw7X3juxv1Y+fF5LQuOfhlVI+KU9oe8r1O6oWwUWxfAkEGtVqRsf316bdLwO/QmNTWzO+mO4/iofMpLDdl79ljH5+wn4IZ0wsNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 659E72C1C;
	Thu, 27 Feb 2025 00:23:14 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 594FF3F6A8;
	Thu, 27 Feb 2025 00:22:58 -0800 (PST)
Date: Thu, 27 Feb 2025 08:22:51 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Report error if set frequency
Message-ID: <20250227082251.GD1821331@e132581.arm.com>
References: <20250205183009.224182-1-leo.yan@arm.com>
 <20250217082008.GA8144@e132581.arm.com>
 <Z8AOpLW6RSUU09Ns@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8AOpLW6RSUU09Ns@google.com>

Hi Namhyung,

On Wed, Feb 26, 2025 at 11:05:08PM -0800, Namhyung Kim wrote:

[...]

> > > After:
> > >
> > >   perf record -F 100 -e arm_spe_0// -- sleep 1
> > >   Arm SPE: Frequency is not supported. Check manual 'man perf-record' on how to set period.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> >
> > Gentle ping.
> 
> Sorry for the late reply.
> 
> Isn't it just -c <period> to set period for Arm SPE?  If so, it'd be
> better to say that explicitly.

Yes, '-c' works for Arm SPE.  Will change for this.

Thanks,
Leo
