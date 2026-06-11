Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F463ECBC6;
	Thu, 11 Jun 2026 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181497; cv=none; b=Pn9BPBxHoiPcLsigBdPaAt0UqLMs8VYZHS8W+/SWP9upJbIZEiLhv1z/mfHCLGUt+0hXL105yOPCm1/8ruQp6vLUhCyYwou+LPLRUpzVJQueqsd9lsAvy22CCNbnutDD+nviHpwZ0dyZhxYZISvwhFkOxYskkiLB7SKnBp0R8uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181497; c=relaxed/simple;
	bh=RBnEipoZhctix4Fta132YdK796dx54AsVdRueTnmUzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9Hp8pm85iRK3Ao6r2qvN3laPKduFchCoOoZEL+9bzf+gVRa9P42u+yI1HszW/otW1DwMaKrx6pix3VzRk282l11m6vmprJS/RvPw9fi1Okol5bwFySpBoB3k8T8PhLHrwCRmFNhJcOmYMeqrKVdQHqnHNHNSrmULqPVGoQG4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E6GiOXFr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E6GiOXFr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D030497;
	Thu, 11 Jun 2026 05:38:09 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0AB73FD88;
	Thu, 11 Jun 2026 05:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781181494; bh=RBnEipoZhctix4Fta132YdK796dx54AsVdRueTnmUzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6GiOXFrpESIzxK2GPbLtpgPWgZJQSsfZt60GVqI6vOOC4uYyTgWnJ8AQWObOVYbB
	 RdJYKt7Nyo3PT8nT5q1x1vgdl50sH22Ntt8Jxt2dU1dKBBE50tmn0S/0BZmnXhuj5y
	 XmUIdm8Ht6LnNW4ae7eeZMjzCXDf51aJNsZ4OrYM=
Date: Thu, 11 Jun 2026 13:38:11 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Compile named_threads workload with -O0
Message-ID: <20260611123811.GW101133@e132581.arm.com>
References: <20260611-james-cs-unformatted-per-thread-fix-followup-v1-1-3c855d93dba8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-james-cs-unformatted-per-thread-fix-followup-v1-1-3c855d93dba8@linaro.org>

On Thu, Jun 11, 2026 at 12:13:46PM +0100, James Clark wrote:
> The work loop relies on the compiler not optimizing it away, although
> named_threads_work is not static for that reason, the compiler could
> still do it.
> 
> Fix it by compiling without optimization. Also add -fno-inline for
> consistency and in case anyone wants to look at callstacks.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
