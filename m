Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F61EB5F1;
	Sat,  8 Mar 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458259; cv=none; b=jBiXF730OTP200pK9COMfZCU/FZGebnVcGglIPMbj327E9CiGJm2bdLLpaIwMlGQCD1SonA7KUHviEjoyifzx2r9r77LEhXLSOpu6LLP0z69l0ev7/ZdTKSqHVvFRzKGaHgnXIpZVk6a2IulBC9VXJVlPZbbmKgFdwGTAAQl2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458259; c=relaxed/simple;
	bh=YeVMnWvPDD28iR+tdkp7yKIOlpYf8r1lwmNLuUyj9pU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pfQHiK/k1rSddPoqihXPa3B6naUiePiT7kTuJdzDi2OQysNRmef47jpc8keMT+qavkMHjGIXkq3wL5PAxfVV96/Jtf10eY2+GxeCtA4EGvC77wcxjz2ghH76p4wQS5OnsbT+axOP6rPpiCrWD1lvfdP2wDxDkERvQABYrY8aYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+TdYrq5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+TdYrq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C96C4CEE7;
	Sat,  8 Mar 2025 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741458256;
	bh=YeVMnWvPDD28iR+tdkp7yKIOlpYf8r1lwmNLuUyj9pU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=d+TdYrq56Y3TT7bKaJwcqC62fFnbaNZc8AgZk/Pv9Z4QFh8jAS2LNgbzaJviH0EJ+
	 MIB0WB/zXnvr/s/1VT2qucdWnws2UMwrHds7PVUKGhgGzO+CW/iocxhL8wsrv73Ut5
	 fhlNMsTH6TIpNn3X2TIzrBumwStNgXZR6A//nOWdqy23k4vVNK8+H7aeo06gro8qDA
	 jlM/119q8SPIWUDDYnzMe/zv4guk5L8VIIb2FeFrvMWtEu5D5OqJqyNU01FdJCX1lR
	 4cVARj8z6ReRPqHCCiLcL0S8w3vqEl1rznLMcd88GkULAFns5Y0vloZdFB/qNwWEu5
	 KkwtTbyrgWDtw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250226230109.314580-1-irogers@google.com>
References: <20250226230109.314580-1-irogers@google.com>
Subject: Re: [PATCH v1] perf tests: Fix data symbol test with LTO builds
Message-Id: <174145825623.807676.12586050400195682696.b4-ty@kernel.org>
Date: Sat, 08 Mar 2025 10:24:16 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 26 Feb 2025 15:01:09 -0800, Ian Rogers wrote:
> With LTO builds, although regular builds could also see this as
> all the code is in one file, the datasym workload can realize the
> buf1.reserved data is never accessed. The compiler moves the
> variable to bss and only keeps the data1 and data2 parts as
> separate variables. This causes the symbol check to fail in the
> test. Make the variable volatile to disable the more aggressive
> optimization. Rename the variable to make which buf1 in perf is
> being referred to.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


