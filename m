Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3461A0700;
	Tue, 29 Oct 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220393; cv=none; b=M33lwPv0juaOZxaWQIhyWkcqIYg8tNJu4UpKgMtQoaBk43ODm+UDWAMzErNqf7OK8P5f10DKwixbjc0qabfnc+5QQegNXgFQEDw9Jb7Usl8QqR0aNfeIT8C7w8/51a52eeqKayHUeqt2pF75+1z+pNz0YEkyib65kj/LLrOqtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220393; c=relaxed/simple;
	bh=osCuWk6N1y7z+6KekyraUdRcI+68ml+YRH1Wrfbxkto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCd1RUXGH2hqZPh69BVPtmtdxaIUDZXJHp8tetsRNOS+GxButJC+9GB/3q13tURrNjHQL2EfrSmRWXxtxf/sDh06GgA0ZepZn99OnnHMytmKK+8KPsOTcePz251VXzlsS+TAV3coA2tVDg58VwXPyOQ5Os4+VASDG7oTexusSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC61113E;
	Tue, 29 Oct 2024 09:46:59 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7FE53F73B;
	Tue, 29 Oct 2024 09:46:29 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:46:28 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Ryan.Roberts@arm.com,
	Kiel.Friedt@arm.com, Julio.Suarez@arm.com,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Use old behavior when opening old SPE files
Message-ID: <20241029164628.GA24446@e132581.arm.com>
References: <20241029143734.291638-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029143734.291638-1-james.clark@linaro.org>

On Tue, Oct 29, 2024 at 02:37:33PM +0000, James Clark wrote:
> 
> Since the linked commit, we stopped interpreting data source if the
> perf.data file doesn't have the new metadata version. This means that
> perf c2c will show no samples in this case.
> 
> Keep the old behavior so old files can be opened, but also still show
> the new warning that updating might improve the decoding.
> 
> Also re-write the warning to be more concise and specific to a user.
> 
> Fixes: ba5e7169e548 ("perf arm-spe: Use metadata to decide the data source feature")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
