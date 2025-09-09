Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89FB212B31;
	Tue,  9 Sep 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411260; cv=none; b=nLxg6zxBq4BYeqPtoGP3T9q+1NcvSqoE2c16auRgdtC9YSB/XRxIcpQOMxonqd34n+TWZmWwXSVD/CS4plmfQp1liuCSqw1rOReJ9qDLILl77KV8AL1BIs8JquJxcYqOvQ+9gVC3YKUL3sx7bs4VR9DUV+LHXZzSFExw7to4uyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411260; c=relaxed/simple;
	bh=n5jD2YEOC0tyEUuEqlgeeRLJHCbUAVtEZY48uyByGQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1XarGil8DHn662dMGiIANyizIoM0JzwTU2D5Hy+pzP1A3PXZmBtrrHxOAJYF7yCEuBBGwuPGqqU9Uhlf7kCwFU/8PqQhxyimlHO2KEJoc6RSdBFP6/SZC61nVVgVVBlJ1jjt2Y1Ovs8FpgIyxc6mDZDpdpVEAQqf3idcm/QVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A30A113E;
	Tue,  9 Sep 2025 02:47:28 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F7013F63F;
	Tue,  9 Sep 2025 02:47:36 -0700 (PDT)
Date: Tue, 9 Sep 2025 10:47:34 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	George Wort <George.Wort@arm.com>,
	Graham Woodward <Graham.Woodward@arm.com>,
	Ben Gainey <Ben.Gainey@arm.com>,
	Michael Williams <Michael.Williams@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf arm-spe: Downsample all sample types equally
Message-ID: <20250909094734.GA12516@e132581.arm.com>
References: <20250908-james-perf-spe-period-v1-0-7ccd805af461@linaro.org>
 <20250908-james-perf-spe-period-v1-2-7ccd805af461@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-james-perf-spe-period-v1-2-7ccd805af461@linaro.org>

On Mon, Sep 08, 2025 at 01:10:19PM +0100, James Clark wrote:
> The various sample types that are generated are based on the same SPE
> sample, just placed into different sample type bins. The same sample can
> be in multiple bins if it has flags set that cause it to be.
> 
> Currently we're only applying the --itrace interval downsampling to the
> instruction bin, which means that the sample would appear in one bin but
> not another if it was skipped due to downsampling. I don't thing anyone
> would want or expect this, so make this behave consistently by applying
> the downsampling before generating any sample.
> 
> You might argue that the "instructions" interval type doesn't make sense
> to apply to "memory" sample types because it would be skipping every n
> memory samples, rather than every n instructions. But the downsampling
> was already not an instruction interval even for the instruction
> samples. SPE has a hardware based sampling interval, and the instruction
> interval was just a convenient way to specify further downsampling. This
> is hinted at in the warning message shown for intervals greater than 1.
> 
> This makes SPE diverge from trace technologies like Intel PT and Arm
> Coresight. In those cases instruction samples can be reduced but all
> branches are still emitted. This makes sense there, because branches
> form a complete execution history, and asking to skip branches every n
> instructions doesn't really make sense. But for SPE, as mentioned above,
> downsampling the instruction samples already wasn't consistent with
> trace technologies so we ended up with some middle ground that had no
> benefit. Now it's possible to reduce the volume of samples in all groups
> and samples won't be missing from one group but present in another.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

The reason for unifying period for all samples is reasonable to me:

Reviewed-by: Leo Yan <leo.yan@arm.com>
