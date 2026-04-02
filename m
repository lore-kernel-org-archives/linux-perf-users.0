Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE138836B;
	Thu,  2 Apr 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167049; cv=none; b=LVKlrYhYchduFFuCmSInyCQgtMLrNm7x0yuCjw855LgSb4FIh34GnaLWI5niWSh4XXllPBmOHCRTZwfnU1Bxg9QKO1SwLFbMBz7B6Vf1Hpr+N7vnlW2iX7vELr1eaRHDBDF0MjRaXOrwP8PP/KnngIB2Hg6g0eZfgB2I1Pr4KGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167049; c=relaxed/simple;
	bh=mEffc8JsTkzzn0sWBkhbuoVB8nlK/E9LxAD/PwLXmxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VcYRFKQBhx7zj4rmTjiRYn1CsPFAxnCmnuYdQNqgMRs98AFfRXDUGQBKonXAAsCjnvH6gJKmz9KI2QUmttHVGkHUz+Yr0R4uMPkoIRFK8uiYB0QeMyskCTHZYpFn5Xiuu6nTmlli4sLIN5qHjeRTIbbHBEB+TpJX4KcImJPOG3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9uZ+b3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9uZ+b3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48069C2BCAF;
	Thu,  2 Apr 2026 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775167049;
	bh=mEffc8JsTkzzn0sWBkhbuoVB8nlK/E9LxAD/PwLXmxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N9uZ+b3RumjJprURvjqnTKXatFycRuCH1MMpI3UmYfXmqpexUxvvZuxqUHEjbwfxZ
	 HjgkwyFXCrnAfhV6TJIZGkkeGiIO2blITW0wLJmP2nhCwHag/mHai91ITVv4jxBFru
	 q5LtVS+L7amwku0r9AKKr81/zBPQMtMPusuy3jznhUv3ZZjn6crAUWBaIm2A19zUQs
	 Mi5isumOSJ62cQHCj3gpdbRFebYcoKu+giJBwj+mzs+c0wlDpmfb/KheOvymVUYSf+
	 ACJ+NNV98m7J2cDMizFxDY/hDiu5PKn9bmYTMtGyDtfc0hEbEbgUoaIAs9JX9Ke5/4
	 s/x1vFaY4FaGQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20260401230509.1013742-1-namhyung@kernel.org>
References: <20260401230509.1013742-1-namhyung@kernel.org>
Subject: Re: [PATCH v2] perf trace: Skip unnecessary synthesis for
 summary-only mode
Message-Id: <177516704924.1014987.14899514895926479531.b4-ty@kernel.org>
Date: Thu, 02 Apr 2026 14:57:29 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 01 Apr 2026 16:05:09 -0700, Namhyung Kim wrote:
> It needs to synthesize task info for the comm name.  The mmap
> information is only needed for callchain symbolization which is not used
> by the summary mode.  Also total or cgroup summary mode don't require
> the task info.  Let's skip the processing if possible.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


