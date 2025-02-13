Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2628A2D6;
	Thu, 13 Feb 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467290; cv=none; b=esSNodppBn9OSt5nAhUS8njAYZJzZd1K3jYlYJV9W69NvDvaJ2vT7mzQAySFFcp4UnLjaV3p3wCxlHM1bhb6/9oz8x9UpQBBs5yBQZjcHxn56XGv9ooqQL2svOxQuAVBzKyNx82IdVlR6JC0qrjvd4sIdKXPrYjo5rZ++y2jv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467290; c=relaxed/simple;
	bh=lmMDrQZ2CzXIwj4HSiF99RcebG+5dulrP1XGevUYcSo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=buIuj8RLsR/BIMX8QfYQgA8nAmCN4+MNnCKZ3MfcGAtei5F/LxksK/eLEDOPKas1V7eUssw9jRJoObenz/wc8NpqnFB+bQUi5D1tZuedKqIDeGOK9Id5PvPKC9uhrWDM5bhn8GmQ9MOI8/fTIhlRTwDuZWq8uKswW79FKlbU/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNjY+Rr8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNjY+Rr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78DAC4CED1;
	Thu, 13 Feb 2025 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739467290;
	bh=lmMDrQZ2CzXIwj4HSiF99RcebG+5dulrP1XGevUYcSo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CNjY+Rr8+jYbTQzSbezmVyAhqXgSHvtW9DV01Uly9y1p8h+8FyXQKIGlQBaFNHqtC
	 oPyDZVRBoBdJK3Fv4Os35T7LO1ZY7UyqfDwI+qDYD0yxjZkknMCct4CtTDwNMUlgqp
	 73aTRmf45GRtVBx3QXnByK/iS+tDaBc+AhAcXogLy3yMcrfVBb1vquJzh1k8+/M8K5
	 atSb0RhJfeTQ11dA6ikw5am+hh65u44mhpqJjHQzoduYuaWrnlHOvrHU2PBLoRcrRQ
	 euIUMqyuzC4pzn5LdXrRd26pt2+KGwzyXkaMyeiZIedu4ZUxC202BFBEGQ6v4Ul9FU
	 4mXo15iKpNJUA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250212163859.1489916-1-james.clark@linaro.org>
References: <20250212163859.1489916-1-james.clark@linaro.org>
Subject: Re: [PATCH] perf tests: Fix Tool PMU test segfault
Message-Id: <173946728980.1291083.13326359079343509161.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 09:21:29 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Feb 2025 16:38:56 +0000, James Clark wrote:
> tool_pmu__event_to_str() now handles skipped events by returning NULL,
> so it's wrong to re-check for a skip on the resulting string. Calling
> tool_pmu__skip_event() with a NULL string results in a segfault so
> remove the unnecessary skip to fix it:
> 
>   $ perf test -vv "parsing with PMU name"
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


