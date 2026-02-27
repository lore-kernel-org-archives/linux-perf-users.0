Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6C38756B;
	Fri, 27 Feb 2026 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227970; cv=none; b=sljvNx/EuI2WpnAoBX8xJvL0pg3VmBWZP6C6BRC36hVUMesFJZQSArWcAfudP0M8VBczXlLL6Pf8eCCMwKZDhckNclwqsEhKMXma6WAQk1Mg29ouUlhdQrkQF5ySgRP9uP4n44zfcN1y19+2pXmkPzYDpHnDdxJizKQyg5CYUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227970; c=relaxed/simple;
	bh=m/l9tD6uy2mGqenlwoXvAir0H3SVyEVyB1G9I1unw6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P7DMNCN9z+UJuGUuT61QnMCwHwDlf4ZBwhy2w/WfBLPVYFpYPBG89GvGRczNbEEEz2+cTNXVCxnXfVz3s0Oyjr/+jslIzwjT+jrTlNMknL5cYo5Or/R+VW4K5VJK+nvzthzo6tJBmgmAGW9kkIdxOjkE2FNdfmdNDf6PKnIWCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeRZ8vs7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeRZ8vs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEACEC19425;
	Fri, 27 Feb 2026 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772227970;
	bh=m/l9tD6uy2mGqenlwoXvAir0H3SVyEVyB1G9I1unw6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EeRZ8vs719ah2UmCrtHVe3AVspGkY6yHkww0rkODJRwB0zO98g+Mab/7auefCVEvy
	 gNu6dreS+wWIxD5b/Em+O8VY6L5wleqI6xepqTIF2l0u1MrtoKCCX04WD6HqcnzXrM
	 2f+QnIzNhG8hNWVf1I5d+NtMYU3hqwTypqkf3ekwrr9xiU/byXNQe2ZMReBLAYW6Lu
	 HlL5l1UygD5R8y3xa1qeOErfS7CJXc6LeaTHnzWBWBEa/ngPafElmcRBbrvC7C5QHQ
	 x1fJo5XmcNe9Ugv+xkKJ40RJrHbDOlXpxeTSf4oo6QjDUUo8SFeQZ2ZDFCaUvFT1wM
	 8uUlTKTGrbVXw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Howard Chu <howardchu95@gmail.com>
In-Reply-To: <20260226014955.801293-1-namhyung@kernel.org>
References: <20260226014955.801293-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf trace: Handle task exit in BPF syscall summary
Message-Id: <177222796986.277001.14716036345642721515.b4-ty@kernel.org>
Date: Fri, 27 Feb 2026 13:32:49 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 25 Feb 2026 17:49:55 -0800, Namhyung Kim wrote:
> Some system calls never return because it'd terminate the calling
> thread.  Let's hook the task exit path and update the duration of the
> last syscall.
> 
> Before:
>   $ sudo perf trace -as --bpf-summary -- true |& grep exit
>   (nothing)
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


