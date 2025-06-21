Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3783A95C;
	Sat, 21 Jun 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528882; cv=none; b=TAFzWVVVf/OUo6xurH3P0ntBSPZG60S2E8ywIXrHbExuNkh8aDX72sX2MBTVkMO86lrw4TArAwX6CBRp36UNZvYUMR/JauKSB/unz3CX+Po+vi6OiCvOqi+hIWw3LJBlW3bbRDdECIiLmWfHmvYH34h4ELW1vajd3hXYZ/1RuiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528882; c=relaxed/simple;
	bh=K6wWKdxfoJmEUGL2+UeCRmUF89MpBtsNEIYpPp04RJE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O+9+mI48qV1u9wf85Wuq54HnFe4owGxIgaY7UKhNGaU6ne70L6VqJt3T7QTvLgzUzcYOJaEnWjZMdqC9+raiCKUPPtg3STwcU2ARFyNnG2QOQEkOMjl76Y4NqtVwdLsP7uuiPic6GBI0FtZNlNABFoeNkHfgewY17nkze2FjVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDgrMuar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDgrMuar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11EBC4CEE7;
	Sat, 21 Jun 2025 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528882;
	bh=K6wWKdxfoJmEUGL2+UeCRmUF89MpBtsNEIYpPp04RJE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=dDgrMuarT08zkHVw5uEu2aCVPP/5D6ZuIW3ehj8zblXuVQkbuTFAMNBsdEzPM6jqe
	 COmJhPIaPqSGXfdNAeJ+R1CWpRfCuIzNT5hl0VZqn8sVvDGr4dzp5TAQk+ATDTQCTw
	 phLWTyM83Qxaqnt2uSOqOOwsIxJOQVmMinUmtJ8iAW+d84E8bHYXuhmCC+/i3lmT5u
	 zPpok0jnjD920q+PbntDJiQA7UHwYQHOr6uJP8tNJkoK0ZqPGhQ0sqRU76N6FgHX5k
	 et+wJNU8h5aJf9Zy12wOqQjPy2oRMzGrbGTEgdyGp1ImLaHIKCgmniNpKoQjSseSid
	 R0FwZ96TojOGA==
From: Namhyung Kim <namhyung@kernel.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Kotaro, Tokai" <fj0635gf@aa.jp.fujitsu.com>
In-Reply-To: <20250618063618.1244363-1-fj0635gf@aa.jp.fujitsu.com>
References: <20250618063618.1244363-1-fj0635gf@aa.jp.fujitsu.com>
Subject: Re: [PATCH] perf vendor events arm64: Update FUJITSU-MONAKA pmu
 event
Message-Id: <175052888168.2250071.12313515494828594139.b4-ty@kernel.org>
Date: Sat, 21 Jun 2025 11:01:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 18 Jun 2025 15:35:42 +0900, Kotaro, Tokai wrote:
> Update pmu events for FUJITSU-MONAKA.
> And, also updated common-and-microarch.json.
> 
> FUJITSU-MONAKA PMU Events Specification v1.1 and Errata v1.0 URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Arm Architecture Reference Version L.b URL:
> https://developer.arm.com/documentation/ddi0487/lb/?lang=en
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


