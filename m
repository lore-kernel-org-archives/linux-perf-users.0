Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1761B30EF9E;
	Wed,  3 Dec 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784713; cv=none; b=aWVasphZ0IenZP1+SLgXUFqa7loSxxoohm/Px/weKlVp63A6Xne2Ygfds7Icf8ko2zkh8usT78BaILnDKiHYROM57gbNTzfj18O4rCUbehgBnNR96HRVTvsOvVEeBkxfGQin5na/YL5RtuFt6QfvX+PjrXPrHEP5yS8nctfmgCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784713; c=relaxed/simple;
	bh=bezLuy51eiisq8gEhnNy1MJHk5kNet4WUpsmCRQd66o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pzJ63UWEPN+cF0BQaosDQwfRKvg+KTzU+h3gmkVZiPprQUR6lwM8Kf4txJEW2jC9ncLISv7pU24/Tv04L/t0xiNhKcayP6HHRR+ZFFi0b0EnnmBc3E+jHZnt8zUkj/JlqJf3rvanZMSrmMI4lrlqEu5xP+c8og+JwN7reIC8pKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOqxHHIp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOqxHHIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957D6C4CEF5;
	Wed,  3 Dec 2025 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784712;
	bh=bezLuy51eiisq8gEhnNy1MJHk5kNet4WUpsmCRQd66o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GOqxHHIpgwKD0tVV5rzgozs6L+XwA/psmsCwUbYRsvd+HQtNz0gHVHOgN41JmnOcC
	 J8oNp53yzZCl9C4e72Fil8KAnPsZ5T5Cntprfn2Zslnusf3CqSrqgWckgShZHyM187
	 ojW8ORWHcd+dTRrpztfxgL5ORR8O5nyDcqraGRDObjVLCxjXgEUPxKbZPGUlhTt9xt
	 QcqO1++V1CVM5JkRL72+4/8v49KBTvKZyKG0NEdFyEuOL6cL+T9W/o6i1P2iXYQzwR
	 2wrPChgG0uAiUdQLI4ljzVgHRZi0IywHXz/vHDIC6Z4RqNMqWe0k6j0D1UA/Uj6CpC
	 lQKt8ht0/S+Gw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20251202230131.998662-1-namhyung@kernel.org>
References: <20251202230131.998662-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Remove a trailing newline in the event
 terms
Message-Id: <176478471149.3636162.6194887138369595213.b4-ty@kernel.org>
Date: Wed, 03 Dec 2025 09:58:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 02 Dec 2025 15:01:31 -0800, Namhyung Kim wrote:
> So that it can show the correct encoding info in the JSON output.
> 
>   $ perf list -j hw
>   [
>   {
>           "Unit": "cpu",
>           "Topic": "legacy hardware",
>           "EventName": "branch-instructions",
>           "EventType": "Kernel PMU event",
>           "BriefDescription": "Retired branch instructions [This event is an alias of branches]",
>           "Encoding": "cpu/event=0xc4/"
>   },
>   ...
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


