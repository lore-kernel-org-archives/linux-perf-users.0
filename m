Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3033E358;
	Wed,  3 Dec 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784716; cv=none; b=iN9IPflcSMLxG8AVu3TWxNIS21auVgAZa0+4Wf4xYRGKFO99nYNqUlJmYemNWoINDmtou2Vezw+QUaOB3BfvVUNQ2mUGOx1JSsc2dEr1cmorg8Ts2HDAmXgR91SN14eQW6y0CeGCXhlQxvMDSj+JZGj66vBJC5hPataj24MSD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784716; c=relaxed/simple;
	bh=qtlGQduNPsz6ODSyzAoClcSOuVArAXAQY3T27m442ps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V8hZpcVJhfVsUKxhC6TyehXVQwiPzV2AZSsrlihaKTD1JViz9Dqz6f3sVaDwm7WUFen9oUPyYElHQjmKNnYKEIPf2qYDS4A8m83BaN2N4NMqc8KhlmAFEye+y8G0TLie5XCaWyLmlzJzMyvNx1r8qRQ4LgWxUTprf+9JyeiCugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq1vjtaI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq1vjtaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368CEC16AAE;
	Wed,  3 Dec 2025 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784715;
	bh=qtlGQduNPsz6ODSyzAoClcSOuVArAXAQY3T27m442ps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eq1vjtaId1hp/npq3Gj2KOgiBOKbjfIw9ae+gF2w701AqMiKIPLDd/1SakV2ItStj
	 67IMOw1iH1ylljfquisnZcQRN9nXc8hioaysGelmX7a1YCnCwJrWxGaPPAe7QGGwBL
	 wSx1JH27mO/JgxFR0r2pCAo8NHHtPE6VLPm+E3ycw8/W/vYqbUNo9D2Ja4NJ/+vJOr
	 snpmbt/yOZ65p4j2k2vS+uAx+uKkEPLY846lFcnSqWtjmP7pbV2jlr6uZizc4iRcFg
	 A+yEE4MeSZhkxvu5dsBTM5rk+BSwavVUVX3DtclG4H8uLw9vIJR6ufTuRHmvxT9/nS
	 zOkPHTKZBMfHQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Eric Biggers <ebiggers@kernel.org>, Pablo Galindo <pablogsal@gmail.com>, 
 Fangrui Song <maskray@sourceware.org>
In-Reply-To: <20251125080748.461014-1-namhyung@kernel.org>
References: <20251125080748.461014-1-namhyung@kernel.org>
Subject: Re: [PATCH v2 1/2] perf jitdump: Add sym/str-tables to build-ID
 generation
Message-Id: <176478471412.3636162.8826107482964301667.b4-ty@kernel.org>
Date: Wed, 03 Dec 2025 09:58:34 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 25 Nov 2025 00:07:46 -0800, Namhyung Kim wrote:
> It was reported that python backtrace with JIT dump was broken after the
> change to built-in SHA-1 implementation.  It seems python generates the
> same JIT code for each function.  They will become separate DSOs but the
> contents are the same.  Only difference is in the symbol name.
> 
> But this caused a problem that every JIT'ed DSOs will have the same
> build-ID which makes perf confused.  And it resulted in no python
> symbols (from JIT) in the output.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


