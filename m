Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340119D8BC;
	Fri, 14 Jun 2024 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372757; cv=none; b=Q2dwjSH92yf0rHr00CoTZfaYoYRw9hYwGyar8nn+ZQwO9R0H8bF1W37xS62s/C4/+bUTkoPF3bH8eX7IossBmqrvrg3bH3pE9RCVCf+27VDQenxRXQ6R8acwzOfJbChcR5ML596KTN3Rc09T++Qa46kyVn0kzalN9640meLVVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372757; c=relaxed/simple;
	bh=IBVsTEiEyzc09sH/gkUbqOlc4VPqgEHilR9gVoWShJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmylMW/B0kq64+BA4yoIr6JKalCN+h4H8JWKlo9OKbUcKAO/mHzY+gbTqaXcrJZ45OrYrTiw5u3YCIt1o1nAh06G+qR8TiDovZQ9XI5ePabRVZ18W6+sGFbH//4y/ecpnbYxuYvuYU2Zh7tGy9xxlkECysYlNVNcXvCwbvPxvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2esuMnd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2esuMnd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060E5C4AF49;
	Fri, 14 Jun 2024 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718372757;
	bh=IBVsTEiEyzc09sH/gkUbqOlc4VPqgEHilR9gVoWShJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2esuMnd+lcp7iDk5YQYjsbIH1DYlXlKxOv22P6aSQdsUqX20+y0+MmytQBNZx4F8
	 /3CRmV1VGwuky3vnjm6Law8qhEWaoMTkH7hnO8s3O0drAN2PE2BgBlCpIgQXUhMoZV
	 rMIGc16PaDUZFU5LIhhVfWxwTpk3NgkqkfDCh7PwxIQOxrcGog1gRtAX/N9wvVgccu
	 +bKGGEFfa7NEwWIAInsGFE+bynp50GZABbN2Vc/zoeEO121z5H4u50cC6lfgHNXoGW
	 I6ZnEaGQfZnM0s3nz+nYJbGLA15Wq2wwNhygzCkaxeYcx9Hlp19OF3t3pwzTHC73G0
	 F4vs2pRyHtvDg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH v1] perf test pmu: Warn don't fail for legacy mixed case event names
Date: Fri, 14 Jun 2024 06:45:55 -0700
Message-ID: <171837273662.3047924.9908088462562475817.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240612124027.2712643-1-irogers@google.com>
References: <20240612124027.2712643-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 12 Jun 2024 05:40:27 -0700, Ian Rogers wrote:

> PowerPC has mixed case events matching legacy hardware cache
> events. Warn but don't fail in this case. Event parsing will still
> work in this case by matching the legacy case.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
