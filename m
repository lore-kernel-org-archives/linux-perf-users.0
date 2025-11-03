Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C593009DE;
	Mon,  3 Nov 2025 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192421; cv=none; b=AhBAt1UCKXDaRvz9gw5QTBWz+EcLGFK8lLk2+U1qf92pqMkIAtp2WISZJEZkQhMMsBCyU+bBC8898pclZG6YJtSb423UUz9sNYl1fEzx6CTtNMKkiUeHqWODFjtNjXnMoIAa/y3SAe+TIGB3RQuZEuVzJKzBq4FgOZ2Z6Wy9al8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192421; c=relaxed/simple;
	bh=C0Wy77ZQeNPURbzGWbHjlOh7OKN8jKdBSiPiOLx3F0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FMgvxWnxrGVMvtm9H5tH09Oa/qT7u0Fj4qNktKOtwd2n5hdCM9rnpbJCRDnEdol0skoVp5GNkNIVcngoJcTDVUTD2Swd7J9tdUEJMMNmHovPvjuCOtDSK2gnKLY/XsnYgHtQHX0UWIRK1jR+v9rhMCwdN8iXWk++4XWLmvTvjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d63zYxs9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d63zYxs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B34C4CEE7;
	Mon,  3 Nov 2025 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192421;
	bh=C0Wy77ZQeNPURbzGWbHjlOh7OKN8jKdBSiPiOLx3F0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d63zYxs9/9/7wkvKTUw7CRKnIGZW91ieE03GbUOY0X7XigLsrvU90vHRD/1o3TSNn
	 Le66Oi0RN8rf7oVYecYU4ysUo6t+E3ymiHf4Ch2Em6r+ciH7TOkYxjgXZtCE4V56om
	 qRbsim9KfRiCyd3ULvfJixlqgcvs4gffKy/EI8RLtBT5G+GUrCsZsKl95D7FDT5A3+
	 NPuhf3/ed3UrDvhmGUpROkdYv5rNJ8Nd/x7G0eL5bjjjRbgsl/2wNH7fIFK/P3+kYR
	 /fed0VZcFFfrX8eLRgNokRprVgnuxAMwGEKDVoVG0qTgg2dN/w08c564MpwMgNjymv
	 qeOt1nV4xDPvA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Howard Chu <howardchu95@gmail.com>
In-Reply-To: <20250519232539.831842-1-namhyung@kernel.org>
References: <20250519232539.831842-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
Message-Id: <176219241991.1981113.12013271209381654543.b4-ty@kernel.org>
Date: Mon, 03 Nov 2025 09:53:39 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 19 May 2025 16:25:39 -0700, Namhyung Kim wrote:
> The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c has
> max entries of 512.  Usually syscall numbers are smaller than this but
> x86 has x32 ABI where syscalls start from 512.
> 
> That makes trace__init_syscalls_bpf_prog_array_maps() fail in the middle
> of the loop when it accesses those keys.  As the loop iteration is not
> ordered by syscall numbers anymore, the failure can affect non-x32
> syscalls.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


