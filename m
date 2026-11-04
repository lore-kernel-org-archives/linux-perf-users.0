Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810220;
	b=HkLsDAdi561eKHWI1mMIdD76mf7XxVSk4NplVsS+9MEQPftEj0aF2zl+s9TjN+rDO5Fo
	 JxuO2I9W4IH4kD2wle4d9nLDHqXpn8pJx309HwmxnPqqzoMm82B/rfMQA24hYfbXRYzyT
	 hYXyssAZYL4mzBCb3tL1XMrBR60mH8VQfU4iQVFTSYLNKgbpro5zxbGKSknVpnW0hNVD0
	 DiL5dzrqXIFYl2XvmzCoFNtoSxaJhajevWsKzjQUjaH7TVIWjAihfzUu9hIpGq7LHIYVn
	 XrzfI7ONY6yZvjLGrHXFtq82x/v/Pb0F9m6NMRH/j4YyS7U9gkZzULK9ulcIuPVKgIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810220;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=r6w6jR99bB94qAc68qR7iE7VIhnx4AziUbUQ0fbongs=;
	b=X2FbpJOT0NfThrlAzb17uK4JiP5ph13G3HfOCIYs2dkTKFYBJ3e9yUQPqes1Qam3gtJR
	 VEZ+ybSMez/+e+gx7op2S6Bc7u3zvV1De4k9FUhSL2OfF53GzRybjLUmjH4gsTOKiBJ8f
	 f53T+IlGbPFJoVAVCMrwtSO9lcrr70G6ZAi0eGygD/+qqGupCCExWqCTBlYwpXt0FLkyJ
	 I6TL+t8IGtDg2pzPl24aGPA4mPgji2mHdm2gkBMv9AZRyUkK3byo71ShVn56ozIgGZ+rW
	 d5bfPbhmLdAgfnTavj0XILC4uEZ/3F9zbLfQmouSjxqnNHknlUn9ECv9Zmx+/yw9kmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hu04Qx2P;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EAA606A326;
	Wed,  4 Nov 2026 16:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42EAA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hu04Qx2P
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79F6A169C;
	Wed,  4 Nov 2026 08:36:56 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25CEC3F632;
	Wed,  4 Nov 2026 08:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793810219; bh=VvHXa2PKN/PXsjHg761V8vVCnlwth46l0sbGcvt/N9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu04Qx2PtBWMFTy6e0QSl/q4rHhJYgWmAcqqx4YB+BkD26yFTgCa6wz1MabgdLErS
	 y/K0GBMMcE/iG9/bglXlhZ1TyoXSxJzGMQFJvutQFbhwI7+wuCYK4FKLpb+og8meRX
	 Xi58ZxsS0WFud0JY03LcT8OWOOJDupHT0yuu82rI=
Date: Wed, 4 Nov 2026 16:36:57 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3 05/18] perf test: cs-etm: Increase window size in
 disassembly test
Message-ID: <20261104163657.GJ9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-5-dbcb0c281b9b@linaro.org>
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
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-5-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:19PM +0000, James Clark wrote:
> When we increase the default timestamp interval in a later commit, less
> trace will be recorded. At the moment the amount of trace overflows the
> 64K buffer, so the exit snapshot trace is what happened at the end of
> the process rather than the beginning. With the new default interval,
> the entire execution will be contained in one buffer and the first few
> samples are always various instruction and data faults. These go to the
> kernel so don't result in ranges that can be disassembled.
> 
> Increase the window to 6 samples to ensure something with a branch can
> be disassembled even with the fault samples.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

I don't mind to set even a bigger sample number (like 50). I did test
and 50 samples just add 0.5s run time.

Either is fine:

Reviewed-by: Leo Yan <leo.yan@arm.com>
