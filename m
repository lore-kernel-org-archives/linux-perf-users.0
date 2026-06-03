Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5038F3E6DF5;
	Wed,  3 Jun 2026 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506695; cv=none; b=JYpCLuy6nhkVT8gKmsSW+H38MY1DiCi9TgvnLaHp7k1aO9JpAls8kqEZcP94lzr1idK4Ue+IMuusti05FVMoaSDV+if+wj3tkJWEFa0HElzQPOFWZOQwUEdDxAaOaKH1E0uJAfpMXdauosdyyF1ZLXDQcD3zUH55y1FmkD66N9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506695; c=relaxed/simple;
	bh=+yb5rkUKMjMfxiwW6lHFJ5FCCgUjN6cCouV3yLYRbRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU6JVRjggKeHMtA5QKECA3RXzgKZE+Xj8H4CYo/3BG6ai7jo4lLNVzFDzBQaqrEkXYGq/1XojHNXSnzFGKBootCyMKLacSaWw9nBK380roUhQIrKq6F750zAZEJATI6j+6SpYPPNDya2SRE7HCdBVk8Clt1+FBzxNWBMn5RApVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DG08E6Fj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DG08E6Fj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF421307A;
	Wed,  3 Jun 2026 10:11:28 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35CE73F632;
	Wed,  3 Jun 2026 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780506693; bh=+yb5rkUKMjMfxiwW6lHFJ5FCCgUjN6cCouV3yLYRbRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DG08E6Fj8GvCOSVDAoErqocNXxHig4S/G4LyqjfkwNsWi08tsMa8+IfK34IBW6ViH
	 4e7miqlbQsuiDMY7BxAkkVcRE8rbBXtw/Bfp+qolFTVwxAEc/vEX03/7cLlhzE78H5
	 xWrJhxqjOFKxtcHvPuYK4dc4M8C5fZ3jGHO2Zng4=
Date: Wed, 3 Jun 2026 18:11:30 +0100
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
Subject: Re: [PATCH v2 11/18] perf test cs-etm: Remove duplicate branch tests
Message-ID: <20260603171130.GB101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-11-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-11-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:53PM +0100, James Clark wrote:
> We already test branch output in perf script mode, but then retest it in
> Perf report mode. This is more of a test of Perf itself than Coresight
> because Perf uses the same samples to generate both outputs. Also we're
> already testing instruction output in Perf report mode.
> 
> Remove this test for a speedup. On the systemwide test also remove the
> Perf report test because systemwide mode records a lot more data so
> running multiple tests on it has a big runtime impact.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
