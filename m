Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42065384CED;
	Thu, 27 Aug 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850581; cv=none; b=djXirXBim9m7CcBr24Vr9OB13CP9iEri7szs25PbiSMDh2abKBLHf6pKfPxc3+Ufg9K0KvamWScKtfP7n2bfldMfv4VzUQrkaQH1MFDGydtnXWac89JwoU9c+7nti61pbjj3OTjLXvK5+JXiKeql1m8G7iMYQMenld9vT2PzKhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850581; c=relaxed/simple;
	bh=4kAGRHdSHxPiOWMZBYv/OUtAGNumoXB3lShsZOeAwc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpUZAhRYsf4T21oQmhSm48FfVKhEiVYnDEbEvrtvjODAO5cenmTD3aFSuSL371nZIBNVin0lTYzXGDeeloCPz/nVT2iUlzuxM82TrEMtDcYd6Dnina0Z7MHqIJUpxLhuJ08g9tfA9a0aE1aF6/FrRGH2tG4ZS4Ee4w9h2eeLkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DC3H611y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DC3H611y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91CB71688;
	Thu, 27 Aug 2026 10:09:34 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0218B3F7D8;
	Thu, 27 Aug 2026 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787850578; bh=4kAGRHdSHxPiOWMZBYv/OUtAGNumoXB3lShsZOeAwc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC3H611yKNX0DjpwTHyf6vov6Eaz9SY/BvqGSCrwuCCoiadU6Yp0sdnhOagkBEtAK
	 F3dmVu4Pg6tl9q6ZXOddebq6i4osd41kTf5gsNCkQ5m7Q2wjZT2Fy63vN2tQDYttv0
	 MAQJhGJBtk95Oa0x/fN7g/rKIGZ+xXDLUnbNEyy8=
Date: Thu, 27 Aug 2026 18:09:36 +0100
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
Subject: Re: [PATCH v2 09/14] perf cs-etm: Queue partial AUX records
Message-ID: <20260827170936.GO8904@e132581.arm.com>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-9-00c4fd0701b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-9-00c4fd0701b4@linaro.org>

On Fri, Aug 21, 2026 at 10:49:07AM +0100, James Clark wrote:
> In snapshot mode AUX records may straddle the boundary of multiple trace
> buffers. Currently we only queue AUX records whose range is contained
> wholly within a single buffer.
> 
> Fix it by queuing any partial AUX range that overlaps any buffer.

This issue has already existed before this series, so need a fix tag?

> Signed-off-by: James Clark <james.clark@linaro.org>

Otherwise:

Reviewed-by: Leo Yan <leo.yan@arm.com>
