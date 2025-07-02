Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913E2F50A6;
	Wed,  2 Jul 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474584; cv=none; b=QX2Gajsl5JgTUKy3KhNM1KmT4iHdyu/2e7QZoWabWHDhh8NyHGdLEa0QZkR2qKj85yoK8ErvB57vEFX7ntbmCNfHB1/yRPNEimGK+u5IU2LOsz9EKW5t3U2bpIwd9b221nbRE93UTnF5kST/5r041QvIDfLUTBTe810M1gYX9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474584; c=relaxed/simple;
	bh=QOK4S1y8u/OP9KpwZrS+GIfmGsNkhE/z4p0JZ0pbPIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lbHISrtWxyOX+f7l/94CULKLQsnJ7H242Hn/jwlTbExoYbsTxdyA82gljuf6a+E/P5NA33Pr8MNgapo1Dp6Ad0vJW/MgcLIIrqOEHIhy6YUkJddKOPJOCvYNNiNV0ok89INm97FfFKgPa97v+ys1CCEE3Z90UA3Zuc56ZZ16JFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxY74zH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxY74zH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9102DC4CEED;
	Wed,  2 Jul 2025 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751474583;
	bh=QOK4S1y8u/OP9KpwZrS+GIfmGsNkhE/z4p0JZ0pbPIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QxY74zH+g9G0ICneyDgC2EIPvGw3+CUwRjf4QQfL6ivzo5anV+HxgniCel7HiPvDf
	 6duzlQYgAaShtCqsT5T7Yg6a5gAqtBKuxwnT/bR3k8CSy9nV5eVfubSzA3MH4fAUjL
	 wdm3YCZOKaHM7xgIicq6t0Ulb1skaRGLK339wWq78+xTmTIQst2Ii7SMyf9cp1xIn3
	 vIAG2qTt3jpJ40JLShlATynjvLqXItdrTFxRhPHgzCr6Z2E+X4bYxuSl4FMrRIj339
	 ZH+218mGmpShQqSlSifHD6YMmVWHK2Qzx02Glaver8sXrfI/REM/VbHzVCb7acvOwK
	 ooTl1zKNqxdYw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20250701201027.1171561-1-namhyung@kernel.org>
References: <20250701201027.1171561-1-namhyung@kernel.org>
Subject: Re: [PATCH v2 1/3] perf test: Check test suite description
 properly
Message-Id: <175147458355.1845320.12859746771182676324.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 09:43:03 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 01 Jul 2025 13:10:25 -0700, Namhyung Kim wrote:
> Currently perf test checks the given string with descriptions for both
> test suites and cases (subtests).  But sometimes it's confusing since
> the subtests don't contain the important keyword.
> 
> I think it's better to check the suite level and run the whole suite
> together if it matches description in the suite.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


