Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424171;
	b=McNWqZRj2gDrQsTgAkcUHQbQ8onSTdP+o61rL7nDlwvzq2ezosGFVr1dcGY4n1YVXs58
	 qeeAJWcjLbgN6xKV7kaITXKEWQqoWk+LHbwVp8sGFOkjNbEszurntY/WKuwyZy5A9WeGS
	 rq2lkhOaJ7fiWMA5H2R+UcGqTC3NNBGREjwOFOMCq12NnAP69iagKv69O8xd6QstNdx9+
	 fIT4k90l01EqE1rfn/gWH1xuoBOU92eDaSRtIVJnIFXhVBe9vfYwVlzIxw583j5U9pplh
	 Qk1E0wTSz034r7Ct/lUvKeQb2lKPtLSlmnBHLc2P4optAq9+VL49bzUm50hX71qOs9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424171;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=toNVohFME4CPzz3aQG8YWlAvJejHByTzrBnth7OtCCs=;
	b=rGAfzSG6X4PWuIQvqdHX/2QOI802D2w2p7mSILIojyKgUhqxkEuh5NMu0Oiy/fJa0gxz
	 sBoq6W7HnAEPkdAT7D7SkeowQLraOOIApQRsIYQqUmYwpNaVKVBYMIqU0EhGOaXp5uYkp
	 uZBULnC6owFUm+6K9ceRs2tDZyzfZLKlraFnm6BWjQhv6z92i8nKtlfu84JA89tMwvSy+
	 WTpmz4njzLtDscJJREmrhOiL5pl3pB2dbGw2jmdeTMxBfy2oy4XcsXZr16EgFRW8Kx4us
	 YnYuV9o3CQhHcdVvkQROyHVgkGK9uJgdR2aFpoMIP2HZZ7eYBnJWke9OA7OQrp3tkhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXjXfzY2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69206606A327;
	Wed, 11 Nov 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXjXfzY2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541AA1F00A05;
	Wed, 11 Nov 2026 19:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424171;
	bh=toNVohFME4CPzz3aQG8YWlAvJejHByTzrBnth7OtCCs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JXjXfzY28+cZcBXXiqBMUy+JhA9OwYvVTHDkaMOeSbc+w3UYbpgb+Pm4juBCNjHw5
	 GEa4B6YWUi9y3KlrJpVJzxOcrDBEbk41lmwA5bNCbTrke8DcsfDM9rw5nNfJyJquYP
	 tDV10VKz3u76oJ2Nx1C/SwzRUwO29nURwCcL7Gu/Llv0GJwd0uBpEbnmJl/mIzdEMn
	 2Mkv6x8Zlq6Q2BVjplfpbwLkSMlAjKgnLyXOJG2CjxDypJZPdBXZk0HNL6k30Rvr49
	 46QOs23TVV0hV6wID4ga9TTpUmawLn86Fwqp3oVgo8RgIRMwN7lw7VzJZTU3pwgJe/
	 bs2BPPnSbn1Yg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
Subject: Re: (subset) [PATCH v4 0/4] perf tools: LLVM dwarf and flaky test
 fixes
Message-Id: <179442417019.676192.135153254035516738.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:09:30 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 09 Nov 2026 13:48:07 +0000, James Clark wrote:
> Running the tests on an LLVM build results in some dwarf issues that
> need fixing. And there is an easy fix for some flakiness caused when
> tests are run in parallel.
> 
> Assisted by Claude Opus 5.5
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


