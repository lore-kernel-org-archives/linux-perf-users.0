Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661932D0C3;
	Tue, 13 Jan 2026 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340910; cv=none; b=WMn+tFDRgRHsnQQKh9+qE+fw/245K/Ew6LnzFAzgSIwzFzXJ/yp81LxViRL/Z+N1PpUrtMdcvRsi6eGwclj5vorIrJGi2x9fldimzTs5GZrW6epk6L2qZSGhBI4eQsPNwtW8L2xH5c5DzizOsrFp6NyaqnZuqRqBSWr9Qn29ZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340910; c=relaxed/simple;
	bh=R3vMDzRWcjyQfPD6fEUTaEQSNjZG8eV5vJxrn6NH0SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrf8rGqr80gPHeY0I/OjG75ztTEyFfzgbKPD+0A2O1yuRcgXoJNChwsBcgOOCZLAN1cS6iniQA++3xVOtJlflnRjalmu0EXo6tMHgSZoVBdSoF0WnStrHYyNz+wpBzLtKhVTpSTy90OA/ecQCl1rWeq9ddGFaPpIRfOD+KnIu7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLmSYpxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLmSYpxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8918CC116C6;
	Tue, 13 Jan 2026 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768340910;
	bh=R3vMDzRWcjyQfPD6fEUTaEQSNjZG8eV5vJxrn6NH0SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLmSYpxc3x3nVmGkUcXeFrOBcERMePy3uj5HlwOrup775gqWcvlhLqfyL68v8TQwO
	 GK1+kQtCS3rBWjnRU6N7019PT/7yH2bi4z0VRJpk095PZnbM7kWB+r5HarthtLEB0I
	 jnnCe7wbsYp4YS0Eo9zh9Frv/FgavW9HbJJnLvnmtXMubIfnkRiE5d+ouoHjS1CxiL
	 dxilhDTBxLajL0CK+Isvni4++b0OTsw4uVbTsIlerSjEoPjB6K/Rq3FqQsN27E7sS/
	 J/BFjOEPwfjt9evcH0KV1qE6xOt/5wKUSeGFM3IjvIRfSiyGouKPvsuwn6cXGa3rYA
	 4P9NyWvWnhMGA==
Date: Tue, 13 Jan 2026 18:48:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Blake Jones <blakejones@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Chun-Tse Shao <ctshao@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>, Yunseong Kim <ysk@kzalloc.com>,
	Leo Yan <leo.yan@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf: Switch printf("...%s", strerror(errno)) to
 printf("...%m")
Message-ID: <aWa9qmZL9BrY2UlJ@x1>
References: <20251119233621.2343909-1-irogers@google.com>
 <aWGqdmr7BQPzhq-k@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWGqdmr7BQPzhq-k@google.com>

On Fri, Jan 09, 2026 at 05:25:10PM -0800, Namhyung Kim wrote:
> On Wed, Nov 19, 2025 at 03:36:21PM -0800, Ian Rogers wrote:
> > strerror has thread safety issues, strerror_r requires stack allocated
> > buffers. Code in perf has already been using the "%m" formatting flag
> > that is a widely support glibc extension to print the current errno's
> > description. Expand the usage of this formatting flag and remove usage
> > of strerror/strerror_r.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
