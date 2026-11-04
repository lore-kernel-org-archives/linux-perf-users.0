Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812009;
	b=qhmDBkbUuuuGF0qP/NgsaSgmCGxLFlTD/m991Mo5E2t3ictg000fweZ8LVZcba6G7eDe
	 qggApXGETjurFm14nzUfXUNCVit5AE6LaotGCKzkSk9/eufo2glXiNWHg4dpz3/kT+8SZ
	 keQtwBtLu5nxiGHO0ONXYnNeBJMGJiDjvnzL+ErRaRfesEIuP2ZTJ1is4YPrAQmCssChh
	 NP7k47MHOxRSWOF1K+XdlI4sf4TOF3EJMi/3IAPzwZiY3soMMVLheN6j4hTCw7n5HRCXa
	 vD/UY2mfIMknvGTkgdcT0Up1uMY7fI2pjdY/aJ7yZXiUPup8NhoQFtIIEqHRhVICfyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812009;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oSNa+6EgMP31eq9znADgKJ9V9b1c1bhoiuJTbui30b0=;
	b=v4HVUg4kXX5aKuLdH0ZrhFuiqFs8+jW3FQ+XUmWm/7nww9NDyU0KfTWOXCWuSkKEy11o
	 8z8Au4YoShb3V/ZiQbuf1F8hrA7jRHOixC2ZAK7uuKWzRQ41IHANj9zKKjgEl0TvadHZ5
	 k4nsmN74IOfDtP5I6ay/a3yYqofKNarRd2WjGCesGhc17OGRDqmWBRI+6wi1dF9syzMNC
	 LQmFbwnUYWpwX2Rx6PL0xLhm+RgfSIemFaM+EFnjzil+5IG1ZZnvtC83FzgnytNNRpEiG
	 9HMODYfdZc6wpoM6yinNKZOqhdsaB1gvpLKihRRsZy4RcDkDdxg/YVxbyCE0GIKyLZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UXLMpGxG;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E0D606A31B;
	Wed,  4 Nov 2026 17:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8E0D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UXLMpGxG
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A8D1BB0;
	Wed,  4 Nov 2026 09:06:45 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84183F673;
	Wed,  4 Nov 2026 09:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793812008; bh=yN67DXvGqeKiP0SGfMP0gC2ilJy21fo6QeXH2VYEQSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXLMpGxGPfCa4+tnAZly5xo5JM25E6VmWkrcDUdYxndl1rxLajmnRhWQ19/vCQLLn
	 BxRNBcE6kowKQ0QDixK/5DG8VBD0Ew+SpLBhY0rG5wvluh8cgcN6vp5Fb+n14poJii
	 sCz4Yx/bYJ4GW3B5Jgq5QLna1ZPa8BuWuFr/Iyvo=
Date: Wed, 4 Nov 2026 17:06:45 +0000
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
Subject: Re: [PATCH v3 08/18] perf cs-etm: Use instruction length in
 disassembly script
Message-ID: <20261104170645.GM9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-8-dbcb0c281b9b@linaro.org>
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
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-8-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:22PM +0000, James Clark wrote:
> The disassembly script adds four bytes to each branch sample's IP to
> include the final instruction in the range. For an exception sample
> whose IP identifies a faulting or interrupted instruction, this
> incorrectly includes an instruction that did not execute.
> 
> Use the decoder-supplied insn_len to calculate the exclusive end
> address. This preserves zero-length exception entries, includes executed
> syscall instructions and also uses the decoded size for Thumb
> instructions.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
