Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9F4A3E;
	Fri, 10 Apr 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804409; cv=none; b=AIJ3EM0gd57G4qaH1ExnHyIGqs4RGcfhf0S3fwPsZk28NX9OHOpYzRNJbBMLcWYNDb4Lm2a0HR05VeTLdim9nrtT/xTB8m1pYROm6Uv7236evB5vbVYWFJ6wYTHgI6yjN1nNwsN03bkBDdf6FlQf596tPxWyHWJ28JdtNjr+tS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804409; c=relaxed/simple;
	bh=/5iuw3YRKqGstxJfyY4GNmGG5kxGM03Z5Gu7Tg3aZQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbQ3cU8N71krg8dBFnYK6ED82q6uDwqwJlPf7DyD7CSn3TrN9r+RREtfUCDHjdwvqVJFHN0hWJdXSRECqBeYZv3dGmlcOAmjh7senlaYfiRWnmBFw8rpW7geUc2yI8f2gMqgDaHlE0ZVi2Mp0CjPfHxGQhGzf+aJtvjvRR2BJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgZffKWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgZffKWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46067C19421;
	Fri, 10 Apr 2026 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775804408;
	bh=/5iuw3YRKqGstxJfyY4GNmGG5kxGM03Z5Gu7Tg3aZQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgZffKWjDucivecAhpxQH6q4k19yLRbCCFayivX6Lgi9TtTRyN0qbI42mWImI3RLi
	 fMRYFzPbKgVk8yPjwkjKTBXseWGKQIbMssjKk429QNJ+qoV9Mb4KoGSp4iEfLw31tt
	 TFxI4DuJ/fVgg3Iujbdk504VdQzoptxQncL3eWMMVJokHTT5ltWx+baoRThMEJznET
	 OAXwq42kaV6YQ5D8aBmMC4BSw4wIVyOlMTIBCHN22PpZSjq8AYA6w//BSLC5xMpKF6
	 rA5Jrg33Q9VeMWNU0qljxvPBAw+tQtz5GV+K3rVOQiu+yfG4wnwpFCu1NGBg8yFnxk
	 ux7nOgan1T9+w==
Date: Fri, 10 Apr 2026 00:00:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 00/16] perf arm64: Support data type profiling
Message-ID: <adif9rnXtvUm7W8T@google.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <adSkpI9AoTNgISU5@z2>
 <5fa89ec2-122e-4937-bec6-fe5dbe3ae07f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fa89ec2-122e-4937-bec6-fe5dbe3ae07f@huaweicloud.com>

On Wed, Apr 08, 2026 at 07:35:22PM +0800, Tengda Wu wrote:
> Hi Namhyung,
> 
> Thank you for the feedback.
> I have received your comments and will get back to this as soon as I can.
 
Thanks, I've reviewed the instruction tracking part.

Basically my concern is that you should invalidate unknown or unhandled
cases so that it should strictly maintain the correct states of
registers and stack slots.  Otherwise it would contain many incorrect
results.

Also, please take a look at sashiko reviews which spotted many things.

https://sashiko.dev/#/patchset/20260403094800.1418825-1-wutengda%40huaweicloud.com

Thanks,
Namhyung
