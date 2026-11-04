Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791074;
	b=nJDtXcZkubZfv8Wg1Fk5tf06y9YGomQMkfTx08cxHIAI6hcnZ4gPv7XvmOl3/1OxT2YM
	 N+U91KARO8Ef228YiCWvrRO+ZnzYY/mt5M7BydkEr3Kd4FosEY6dTlfVDMEyYPiNsqti7
	 6U4rfEgYanjhj3qZSxt90y3k8Vj4GyTrjtJXBv+ftN1r6IhwIuel7y4+Ohjw+q2SecyVB
	 gGNugJs/rVVMy8Fs5lk49kIlR/eeGgnUbO/tf0AG00PuWCeeUIC0ZT/jDLoIVeRLw3lP+
	 FwIO+lwYdGpXtxv3xCdxBIvyDuFk74Ih3XxLMYgkq/IybG8PqUizUc6QrS+V/drUdQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791074;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ix8TZrFaBbGuHrOZakLEuepEiOHkVUc/85hypMpkT3k=;
	b=J0IoMMEbgXKXyqtH3yOphOO4K643+uIujpwcrygg0o91BvRIRRjYzhEzi3oeu3kv/jY0
	 cGjcoseXC8XxwOBpT+VKxSPhB2dHyjeAf0QBTAaoF7QrmKHT4HwC/rG+lNmmyHxfQ212E
	 d8nyj6tCHD9x20RY2Zutrik//ieDXUcw8H9GsJe26StzMDEkGh8ywJAQChoj3AiE92oDZ
	 j1o3iX5PuN8jpFo6x8KEiLTTQDLJPuzqL5b19//TmvQa+PBAoEwEYXsr2rZQPryEL3208
	 kpnzhiXtBDkuLPqyPYePcMKtSL/lkx2tbxJOw4F9i0itPqJbdpWpuucPYM735zViakQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lel6ZhDH;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F40606A329;
	Wed,  4 Nov 2026 11:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63F40606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lel6ZhDH
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 727F91576;
	Wed,  4 Nov 2026 03:17:50 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3161A3F632;
	Wed,  4 Nov 2026 03:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793791073; bh=k/jMEl7IPy/tOwlyg74kB9jKOFkyTUfyKnzcMbMvioE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lel6ZhDHuRSpBb2BxpKQ5ssd7BHOiWR9P+mNbUOhujqc11yXW7CFfDOf3ibfgqV2/
	 qESpNrFQOFybRAZ6FicFmeE1ez2pteVoA8EuMlK2uTmKCKiQG4iHUpIv10IxGUs1aS
	 kkNzfxHkUWbQvPY0sptrVqGDYwp1XnSmwu0aEeK8=
Date: Wed, 4 Nov 2026 11:17:51 +0000
From: Leo Yan <leo.yan@arm.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf kvm: Fix arm64 VM-exit duration accounting
Message-ID: <20261104111751.GG9176@e132581.arm.com>
References: <20261031120123.2312-1-lirongqing@baidu.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031120123.2312-1-lirongqing@baidu.com>

On Sat, Oct 31, 2026 at 08:01:23PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Use kvm_exit as the start event and the following kvm_entry as the
> end event for arm64 VM-exit statistics. Keep decoding ret and esr_ec
> from the exit sample.
> 
> Before this change, arm64 measured guest runtime as VM-exit time.
> 
> Fixes: 1218838d68f5 ("perf kvm: Add kvm-stat for arm64")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Thanks for the fix!

Reviewed-by: Leo Yan <leo.yan@arm.com>

Since arm64 requires the exit reason, we cannot directly use the common
exit_event_begin()/exit_event_end() callbacks as other archs do.
