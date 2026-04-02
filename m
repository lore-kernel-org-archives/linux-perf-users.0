Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774872701CB;
	Thu,  2 Apr 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167049; cv=none; b=CNksukoBvpmkWbnk6N/yExXah8WX+tLeqfTbZCYYcCrZaQskJbGurkNR6+8n6XpDQlyscB9rTh3n8+L+N1K3ZsWVPzq7e7kPBUlK5SNTpromhph0302Fl7chIZfBvHFIPxXba8AeyFUxfswiKQpx74NVtvcLPeg0wMnpIOi3XSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167049; c=relaxed/simple;
	bh=r+xBHOUDBxlY7g5PpaIIkKLS916+7NzJ+7QStRVSk4U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ppZVBbwNix2C0xU5Bcq9viWu7pfzWe9bi5F1ywmXFx20xtPYox6EJg0SvS2FI6ijcAPsgTclloFJaKCSyuDVTmmurq01HOFSIL+jda28bIQ388cXktoB6jXkjxTazECuR2Vhw7KosaSFduCgCgJs/scrhUrIMrQt0KMOlaR0MEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY5v28u2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY5v28u2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADFBC116C6;
	Thu,  2 Apr 2026 21:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775167049;
	bh=r+xBHOUDBxlY7g5PpaIIkKLS916+7NzJ+7QStRVSk4U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NY5v28u2glcFci9mKUsxAjfSlxVs3DJtDgDbzeNV+HPd4SYOLUXLFTHSzccnbv7ZF
	 +zHSfzK6RRMiXI0g2xwF5SUO1qMYZOhGQLAopOAIZQQHHH2NW1riyMUlmsoJsxMwmT
	 Bydk2eIuALGMcVfljOBOhexo735hxkHGJjOkHxMApSbJRPQUwVfRDcrt7dWIuyNOVP
	 KWbUAysXhCWG5RgeNiy4jePq7dbRRNj1zt4aDwaYNl56rUbnlWDJYAWL8+vJmnkymr
	 u0DfjKIsBEpwRweoks8xXU3Ka06hDsFzg4hIWr00iA0LDpZhkrhibrn1DqkAzNrCYF
	 kES7/PDIdkOOw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Breno Leitao <leitao@debian.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>, 
 Dmitry Ilvokhin <d@ilvokhin.com>
In-Reply-To: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
Message-Id: <177516704851.1014987.13131043642915045885.b4-ty@kernel.org>
Date: Thu, 02 Apr 2026 14:57:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 25 Mar 2026 03:24:30 -0700, Breno Leitao wrote:
> Perf stat is crashing on arm64 hosts with the following issue:
> 
> 	# make -C tools/perf DEBUG=1
> 	# perf stat sleep 1
> 	perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core.fd)' failed.
> 	[1]    1220794 IOT instruction (core dumped)  ./perf stat
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


