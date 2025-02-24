Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844F3C14;
	Mon, 24 Feb 2025 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740375560; cv=none; b=K4YmDP2RQvKSbYetqFSGrry23vL1fYGLjhvu3oTs2IZCPlQOFDrBOfN8ob7UjSOIEwV/8v3fXx40CxMsFs2NExgDIF+UQi4YPRiV9NQWXRDHk1/N8Lk/1kw9y93tNrYMEkdRXP/CpAdOuNbkmcMZ4PbreP0MaggexVouWbnncg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740375560; c=relaxed/simple;
	bh=lsEqhH8mxyhaI5Sew2HQlt9W7pPuqdaBFznUvRl25v8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H0rY0dWnyCyk2fiV3Z8rp19gbMeWAIQyAL+FoTMf30i1HP79XyaRd9ZXTMpQrigeBXnC/V5TgnvxmYNPJ5Pi/sEcF94hl2xkvzvuzJtMhQqTqR258WZ4yVbr4pl3UKF5TEJjBi8BAp9MWdmPp3+sqTYhBNtObNo/qoK6AtsyVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnR/6dcr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnR/6dcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A7EC4CED6;
	Mon, 24 Feb 2025 05:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740375558;
	bh=lsEqhH8mxyhaI5Sew2HQlt9W7pPuqdaBFznUvRl25v8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ZnR/6dcrCEqdKgm0q8wUOfmUiT0C53fWssmoVmEpOaakyqS32LbHYW6eAYIijy0WZ
	 9YyMVzlKc98KJkNuJuLIR01qFmRqfiWubuf2RHokwU/grzSR3fSbJwQrmoUOJGn04U
	 0zKGNirnl7PhwIO8LWhA1aBQCIq0WNzUHeCLI6uD22dKTcrpSVOWbwX/U1vMSzotqQ
	 c+1BxAaZryrFoDDPlOOxoq1FNdK2bPutUNQED5yLbAOEjgBBrvgi5YKVf50mFtt9NV
	 Qczs6NzIIp51OYOzzOcR30oB3wmMG0dF4LZezs8Z4k4Su7TDUoVQxi2veITrmVUPqL
	 Fkxq7BYsRQOSA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250109175401.161340-1-irogers@google.com>
References: <20250109175401.161340-1-irogers@google.com>
Subject: Re: [PATCH v1] perf parse-events: Tidy name token matching
Message-Id: <174037555823.3632219.13469110004935932661.b4-ty@kernel.org>
Date: Sun, 23 Feb 2025 21:39:18 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 09 Jan 2025 09:54:01 -0800, Ian Rogers wrote:
> Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PMUs
> before parsing") names (generally event names) excluded hyphen (minus)
> symbols as the formation of legacy names with hyphens was handled in
> the yacc code. That commit allowed hyphens supposedly making
> name_minus unnecessary. However, changing name_minus to name has
> issues in the term config tokens as then name ends up having priority
> over numbers and name allows matching numbers since commit
> 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with digits
> "). It is also permissable for a name to match with a colon (':') in
> it when its in a config term list. To address this rename name_minus
> to term_name, make the pattern match name's except for the colon, add
> number matching into the config term region with a higher priority
> than name matching. This addresses an inconsistency and allows greater
> matching for names inside of term lists, for example, they may start
> with a number.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


