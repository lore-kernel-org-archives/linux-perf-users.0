Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094622E427C;
	Fri, 29 Aug 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473878; cv=none; b=g6clvxl8Qa3BWY+zFI6/daa5dUIKJKdQLLVvUH5CY3kSoJ/V1d1ada4gFFdtnUUdRUYbB6XF/UAJ/eA7hU/e3JLwDWrnQdgIqbbMz0HZVmL0uN25IK1E7ouLh5whh2RKPbmROJYH9rIQ0cxxxq+JXJ+C3zOsqpu9qvkqmQPw088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473878; c=relaxed/simple;
	bh=UZ54+GV7yZKljxZSz1SK6t1YcQXpnNu5bSnMYfqNISk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1StRmVZybbGwyRyBxsE/DgdlWx/aVBtXnUXcjRe8UMSTcuIJjndaHJ79QRC4o5NgzbFVq30++HnC/djW2ytmfpxiSr91c6Rn1LhSfre5oDs5wkrYOss1Jts5J2eLkCA8FVWnlFmeop71fQDuKmASZcHat/d+5IIQbUFTRPN3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 050EA12FC;
	Fri, 29 Aug 2025 06:24:28 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F0D3F738;
	Fri, 29 Aug 2025 06:24:35 -0700 (PDT)
Date: Fri, 29 Aug 2025 14:24:34 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: arm64: Sync ESR_ELx_EC_* macros in
 arm64_exception_types.h with esr.h
Message-ID: <20250829132434.GI745921@e132581.arm.com>
References: <20250822145855.53071-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822145855.53071-2-ysk@kzalloc.com>

On Fri, Aug 22, 2025 at 11:58:56PM +0900, Yunseong Kim wrote:
> Update perf util arm64_exception_types.h to match the exception class
> macros defined in tools/arch/arm64/include/asm/esr.h. This ensures
> consistency between perf tooling and the kernel header definitions for
> ESR_ELx_EC_* values.
> 
> In v2, ESR_ELx_EC_OTHER and ESR_ELx_EC_GCS, which were missing in v1, were
> included.
> 
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>
