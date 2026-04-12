Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F672618
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021101; cv=none; b=aTzA9xM9qzt6HBVavQpZD93aC1m+z37j8peVuwJwPadh36xEVjloGiQ8wkXwL2TN8s+of1C7S85TB9tnx3N6KPuuYeQYAP9q/P5H5Y/r2d1/rFykcigLIZ+eLpF4GcA5WdSRgRygrVfnZCVUjL+Y5kB8n8l/P6WqyhZG4/J2pyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021101; c=relaxed/simple;
	bh=gGbgSScs/6yv2loBTaqcJB4wn8HJrACyqH6/wGBf4zs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WRzGxptdePvPQkjQfqmIr6cvYQb9pl4yB2K1eCrxK/ILV/qDAlTtYQiiZQ6Q24jmGg71EJJSbDLwKlRO09tMKgGrSLPVHY0eJMqhmRyisqMyZ9NHEBZ7NRuOqQgD6/hfJ5dtG7bLsV4D+wEW7TKGC5ElrN791xpoEItsLod4UXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TapbgaO3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TapbgaO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E8EC19424;
	Sun, 12 Apr 2026 19:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776021100;
	bh=gGbgSScs/6yv2loBTaqcJB4wn8HJrACyqH6/wGBf4zs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TapbgaO3aoJbvTDU1En7fURsF9LQBe0h7ueajoMOXDRR2HUncnR91tr6nm8yzE5JY
	 +didJhAwaIXjYrFlnhbxTNKBAN96mMelVPIzO2ZEUTwi7Hv+/1yAcOv0YLcgDEQCbm
	 W+C1gaBgciMdhnmfDKgHKL5D00G7fqS8NBXxu0+3kkxqUdLfw0+eLDROne8UO8pSdF
	 7mKt3wgpKKR+GwvPO3hgbQP/JpOxNRJa3Cw3KG994Sfx/4gTf+ShHSptJDoz3qCkvd
	 hlkpKGShB/7Dgx0OWzAH6UvUw8dnfvi9iHlxDY0Sp7GklnM8m0Wm0moQ/nRWvnveyK
	 cuJLRrfIBRAQw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260410-perf_support_arm_spev1-3-v6-0-3c6f2dfe2cd3@arm.com>
References: <20260410-perf_support_arm_spev1-3-v6-0-3c6f2dfe2cd3@arm.com>
Subject: Re: [PATCH v6 0/4] perf arm_spe: Extend SIMD operations
Message-Id: <177602110030.3380326.16901438429651843791.b4-ty@kernel.org>
Date: Sun, 12 Apr 2026 12:11:40 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 10 Apr 2026 08:36:57 +0100, Leo Yan wrote:
> This series extends SIMD flag for Arm SPE and updated the document.
> 
> This version is rebased onto the latest perf-tools-next branch.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


