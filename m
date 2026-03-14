Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624415665C;
	Sat, 14 Mar 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510377; cv=none; b=VesSJhfNiNBoiQ9Go4bu7Xk/jvT4fU9LTwl5Az8mLjEf2p3xl/USTxgLOMemjRpuNkywvGz5x3C03AsUI8EXtyoiUVer3JbQy+nhI+BB4qn6R0YDe4iTWuE10w6wbUOGZP7AdbZ5CnAiYUEnmqLZg+Exh6XiPDh8D1tnQWADt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510377; c=relaxed/simple;
	bh=Wvy0WVugzX39KgdfSlxMCmrTo+Dhqg54jte4KaJngi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBDesClz1yPpUFSBRktx04GTq/uWkRqlb/O9f8cObjn5dWNdErjXYLBrGM8iw3AIJZTGR5rHoYdv9rglbxkZ+Dc0w2N/uQiKmqYIY9/xnsNmvSc1MxrLTw9x/R1cORbwfp9cG5UEPHMNR6vQHwDgOMnVMAKtrY3PYl/145wOSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9feZ+Pp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9feZ+Pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D0C116C6;
	Sat, 14 Mar 2026 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773510376;
	bh=Wvy0WVugzX39KgdfSlxMCmrTo+Dhqg54jte4KaJngi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9feZ+Pphjcc6p4aNZCMaZIXb5XCCt1WTZstPYGf3ltiHoiNXfEThVbttFsNJOgGp
	 BsEevfxPYTYV50HM049ilnsYrcxTh/KB03i4nabNaBYd/7ZkKipqgz36M0zM7XWCMR
	 NqYo9InO/63OjDIpsOxQvetX9nFrHLNJEkz0kEIcSNxoMuUfUdDCq3THN8lGjDQeoC
	 eFedgafnVTtkv/4jNKhEBqdcv07xXc8uNzIRX1Vg6t/KJgCg9+cXcU36UEAACq2BUg
	 raEianSL0bh0n1nej6CwWVAFJt8VgL8e9IBx6Q1+U6CibtVDZe0smnxHPhsY5dQlK/
	 /Pdn8oS5HhPng==
Date: Sat, 14 Mar 2026 10:46:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf branch: Avoid incrementing NULL
Message-ID: <abWe5vfxerwLltfy@z2>
References: <20260312223131.2184095-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312223131.2184095-1-irogers@google.com>

On Thu, Mar 12, 2026 at 03:31:31PM -0700, Ian Rogers wrote:
> If the entry is NULL the value is meaningless so early return NULL to
> avoid an increment of NULL. This was happening in calls from
> has_stitched_lbr when running the "perf record LBR tests". The return
> value isn't used in that case, so returning NULL as no effect.
> 
> Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

