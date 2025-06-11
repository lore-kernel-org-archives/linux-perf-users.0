Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94923C39A;
	Wed, 11 Jun 2025 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678251; cv=none; b=sND0xnl5gQuNeGppKyFOye6XVFcDdQrdJtwzSfLHKZBoBEMAT4Rf+JDMLDXqREmABdj4/aIXEh4uAVekv+tUTxUkmDj2P2Ms+guFyyBjL8r9TS5MFXixAEMP0TlZoZaDy/5WcH8GjTErdcUR3IJQpBF0VGEY8R27iPpyZ/vrFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678251; c=relaxed/simple;
	bh=AYVPRvkZXEtsP2eg8lry3PUoQLuajb1C244F88lG6vs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hVHk1+YcVqOh21zSQwuVNznU5R8VugAGoYHFgnaSANlhciEJiDeHGayCKs3jQZNUdZdwUUjPAvo5Dda68Em/xKkCf6K0S/kRx57RIOMIsWy8oo9Srzgaqd+TKhlTPKXoUd0LhQAIajXJ3l16JFlWGflLswkmY0eQIHwv+DESIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzaiC/AU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzaiC/AU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8146C4CEE3;
	Wed, 11 Jun 2025 21:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678249;
	bh=AYVPRvkZXEtsP2eg8lry3PUoQLuajb1C244F88lG6vs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=qzaiC/AU6Kj+IN92xcLWt5vatOKsi2kAhiceKwRorTuaJ269A2w4BYNwz/FLbFCz/
	 3Cjs7C1gOSwZIAom4hHkwPy1uWUE4mkmFNj/lXXUGgtuSUWsBZSJWfxeGN8VYC6G8O
	 Jq5636qQiySVxV2pCYeYenAcEF1yglDVyyA+7cWXpzYLQ5FjnKcwuxOPS3YfWvzyIu
	 emVpWmK7+ckn42VubGIGj7SZKYS7n3zeagxdL8umkmdciRe6QDIusWUzF2SzTy/2Xn
	 MLvI3a8nArHy24zRnBsM8mLMwEEtD/JrRUFsiSvEjxFZPQ0T8MJZsvjVfZpDSpIhyx
	 mZQvaZM7uqS2w==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Howard Chu <howardchu95@gmail.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250529192206.971199-1-irogers@google.com>
References: <20250529192206.971199-1-irogers@google.com>
Subject: Re: [PATCH v1] perf thread: Ensure comm_lock held for comm_list
Message-Id: <174967824864.435639.16301685333442078712.b4-ty@kernel.org>
Date: Wed, 11 Jun 2025 14:44:08 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 29 May 2025 12:22:06 -0700, Ian Rogers wrote:
> Add thread safety annotations for comm_list and add locking for two
> instances where the list is accessed without the lock held (in
> contradiction to ____thread__set_comm()).
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


