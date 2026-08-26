Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983E840B6E2;
	Wed, 26 Aug 2026 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756677; cv=none; b=Ft90aVk2Hz8b+NZPw1sjqWba3RBYEz3CZfoZEio9to48uoXVTpVpCvIGSjm6GH0RAtyI+1ouh+ckXgfnAji+bNLGT3kHKcIJQyc+Igk97V3fYMewdHfQDraNqeM45cnWYYTo1aV291ISHszGgGUxl584nSWeS0NM9KtZtlbXjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756677; c=relaxed/simple;
	bh=ha5EeUmGMqyJtGR7X0QqNJp4AGSkOzNoD2LxtIdRtm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geHS3/Vr7PvyI0CMaY4fJpc+zwbKjjoHrxheQ6NdJsYvHr4G5mAZPzBzBBM+tO3W/dKnDaHGYdx4rxl1PJFj1cunR8OFhhR+WmPP1UMdfqOWAAJphgYMAtAK4kN+9lxJhYUBp/QD1YjUHPznCTe9SfTP66EYAQVsz9sM85LFICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AOheFklP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AOheFklP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 194C41BCA;
	Wed, 26 Aug 2026 08:04:31 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A65B3F85F;
	Wed, 26 Aug 2026 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787756674; bh=ha5EeUmGMqyJtGR7X0QqNJp4AGSkOzNoD2LxtIdRtm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOheFklPW1RRHXqLak0pKDeFEKk3sN2QVpc2v4bwwwVU7SmboWzeMOG2Fdf/NtNQa
	 RLNA+k5tQA7yim3bQmz1qSwsCye6bBfpQJhoWjTEFUwq78ILEz5O0Msi+EoN6MfTr6
	 iXmbHQ1R9cm+NBBXFPvy/0xrfL6Npby4+S3/6lX0=
Date: Wed, 26 Aug 2026 16:04:32 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/14] perf cs-etm: Warn for invalid timestamp option
Message-ID: <20260826150432.GJ8904@e132581.arm.com>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-2-00c4fd0701b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-2-00c4fd0701b4@linaro.org>

On Fri, Aug 21, 2026 at 10:49:00AM +0100, James Clark wrote:
> Instead of silently returning an error, print a useful warning.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
