Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7955B4FDA7A;
	Tue, 29 Sep 2026 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675368; cv=none; b=tUWo7UcxKjLkOwT2q2NUtGiTBT0AFj0K4fUSF5mn4lJX3tomrZpi2MO5QXxaEusvkQY7qccjTPKAzRPEgOU5C6tVVIZgI9+o4oaxRGUIdEXfs8EImNTrwFHjacZl++ohf2WhCLR5eXHx6WLMG1R3+crc/G3OiUj9Eo2RmylT5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675368; c=relaxed/simple;
	bh=B9AAocrpolX4MxYBlzxMX1TENfUxNfjQH6oUrO3W3l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7I6CYeTyjKbdpWhGILkiTW7joFLvXbmAlPRTEX2xKCdWTXztBAJGM9bVzdXLVq/xLxTI2o5Q8CEH8mw7/IWlTM7vQzr8sG2FKZqCgN4eR8r4uNDoLriayx8yuYZ1OXAUMDsWd5rQGM6hEuGf/Ciyie+e043UJFDlW2sCu0avoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qC2KTCuZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qC2KTCuZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E63A1516;
	Tue, 29 Sep 2026 02:49:22 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C0AB3F85F;
	Tue, 29 Sep 2026 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790675365; bh=B9AAocrpolX4MxYBlzxMX1TENfUxNfjQH6oUrO3W3l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qC2KTCuZf1CyxLBk3z1uaYKc2/4FlbYgOLxClpx43M4zdwowQSacqxR/KYheG79UL
	 oeo9BoxlKy4bqg9qJZXTF7z4xAFsYcgGhgkBTPS9RZ96bh+yoFlF80aIjoNApnjkf+
	 mUd/yI9YIBnotXjhq1Vj2M7shHyZd5qNTtG5lNfw=
Date: Tue, 29 Sep 2026 10:49:23 +0100
From: Leo Yan <leo.yan@arm.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, john.g.garry@oracle.com, will@kernel.org,
	mike.leach@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	guoren@kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf tsc: Declare TSC support from the build
 system
Message-ID: <20260929094923.GH14479@e132581.arm.com>
References: <20260929034133.2153-1-cp0613@linux.alibaba.com>
 <20260929034133.2153-3-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929034133.2153-3-cp0613@linux.alibaba.com>

On Tue, Sep 29, 2026 at 11:41:33AM +0800, Chen Pei wrote:

> x86 and arm64 keep the same behaviour, riscv starts running the subtest
> where the previous patch defines rdtsc().
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

For arm64:

Tested-by: Leo Yan <leo.yan@arm.com>
