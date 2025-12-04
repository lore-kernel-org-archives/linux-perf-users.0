Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C734A76D;
	Thu,  4 Dec 2025 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875448; cv=none; b=LbMmP2QqPePwuEQiDraKlABmPD0UFFjn/7UjPrTLjB0yLug3rwIDha7xsFGmGVw/Xka9MWRg5XTyO5xMbGQX4fpHrnabtJxSmD17cE4+C52zDwsNwrH4u2/zkU4I8y6sZ9Aw+4nnUsB9ZaCYoaX2jgZfjfYCECP71dgB2QPWE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875448; c=relaxed/simple;
	bh=l9albtKlrbPXYXfvm1nM3AEv047dr6B05Hk78HKz8KI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ME3Dq0c3bI8ScCvaBKlbHtTXtzfyCcwgwBE1BLCTAqb4USSTgAww5PY7Gb5Jgq6J2URnSKr9X34x5aPsy+k3kN3ItHEYW1uY56PugmGpCno1etNZu0p/3Q8ePmP+TWGYMBl9fJVJ4Uc8akdKoEXFKvDZcQhvVXvLd0UKeEDqA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1khR1+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1khR1+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DF3C4CEFB;
	Thu,  4 Dec 2025 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764875448;
	bh=l9albtKlrbPXYXfvm1nM3AEv047dr6B05Hk78HKz8KI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=r1khR1+QN7XtB0my/V7u0lhSQxwSTbNPL4RwxL0TQwAeqAo5ZvOOD6gF5MQ1YL5xB
	 BBRWHjHr1j19Wa5hrpRR5fcZjc/0N8Qy1yLIWRvS69NXdBW2cKumLnhjgd6SccMMxY
	 8b+o65Sbs9bvss2XF+k5mcF9MmpXY/WwYpHM/T5kntHHh7oAU9W3KBq6Pu6TfNsJUf
	 wai7LfvR7Lxg68iO2IDk4roUGAUzPxPQblqGXcqn1UQwmFw+n5CvXN6jNoGH8V1jDp
	 +G5mPGu2DtLOVDy5rtsJz88Kql2f0j/yno5C5bG0YQmfBdw8PSLwfbDwdStr7mHrAX
	 d0q2Y1G1z2XEg==
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 Edward Baker <edward.baker@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Caleb Biggers <caleb.biggers@intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
References: <20251202165340.555375-1-irogers@google.com>
Subject: Re: [PATCH v1 0/9] Updated Intel events and metric unit fixes
Message-Id: <176487544691.182574.9871026072928323021.b4-ty@kernel.org>
Date: Thu, 04 Dec 2025 11:10:46 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 02 Dec 2025 08:53:31 -0800, Ian Rogers wrote:
> Update the Intel events using the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> pulling in 8 updates to event data and a metric unit fix.
> 
> Ian Rogers (9):
>   perf vendor events intel: Update alderlake events from 1.34 to 1.35
>   perf vendor events intel: Update arrowlake events from 1.13 to 1.14
>   perf vendor events intel: Update cascadelakex metric units
>   perf vendor events intel: Update graniterapids events from 1.15 to
>     1.16
>   perf vendor events intel: Update icelakex events from 1.28 to 1.30
>   perf vendor events intel: Update lunarlake events from 1.18 to 1.19
>   perf vendor events intel: Update meteorlake events from 1.17 to 1.18
>   perf vendor events intel: Update pantherlake events from 1.00 to 1.02
>   perf vendor events intel: Update sierraforest events from 1.12 to 1.13
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


