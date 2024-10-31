Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E713AA5F;
	Thu, 31 Oct 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394730; cv=none; b=LqGwfe1XAZ/2y+r+pF1WWmpbaI2wYbUiK782xKpF5FVF7lHCbeObQQfyvm2DyqDxsue4GegD2B2yvcnUjrv/UkDRvL36XzfG6rtjpFtCS5UWwR5l7wtP3OWIy0QU0MZ+XQo0nSGHV8F0FTHjGWsQ3KYcTPPxF9aoRjdgMUTqOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394730; c=relaxed/simple;
	bh=6XG12ERMkjluHM55pynix1a/P08nWWDLaHkkO2E/a4Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E3cqFrRlK9nOXYYb88HXWZa5arouqVr7upzLhQIVMQpXgsO6D9+qo2jDhXdTJNa3MtsGPfSNIsz1K0AAKQ422qi8EMSYurQqIEUJkTXMQouK6Gs3lan6hEmXGPnrVA8WL+za89pbbuN8P+4J03ojFE9t/HxeqfXr8DBnEP1stW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYXzwXFt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYXzwXFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CBCC4CEC3;
	Thu, 31 Oct 2024 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730394729;
	bh=6XG12ERMkjluHM55pynix1a/P08nWWDLaHkkO2E/a4Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JYXzwXFtMAOhWtK47qQ6/k29acp0Q5tPe1uZlyNHUyJvg04rZ6wM058RzdNRXJrJ4
	 3LP+Peu2t6aSi7s8XbWPB7SyewWIZPJg4DjR4z10XAUdXq86QxfmkIoMJ+5Ktb8/ux
	 eFTwgaXOKW8XgsEGpyHcpvqenGtfxUH4unRcoureAK4APt+Y4hapxxp1gbR+xE+zSs
	 4/Pw40PFj7gmDVq08pUCpJIVFbznmovIJfe80XO4dYF99h7SA4Ox14UEtjmAiUA1BK
	 mPVm+wcoETa9z4PexMALOlZLTDUMa1LHSFjNJUZkmQjXWzmfeGTyJwggXAfyb8mA1I
	 4HDkRh594kHaQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
Cc: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20241024190353.46737-1-bjorn@kernel.org>
References: <20241024190353.46737-1-bjorn@kernel.org>
Subject: Re: [PATCH] perf, riscv: Wire up perf trace support for RISC-V
Message-Id: <173039472904.1704862.15241557863386801558.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 10:12:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 24 Oct 2024 12:03:51 -0700, Björn Töpel wrote:

> RISC-V does not currently support perf trace, since the system call
> table is not generated.
> 
> Perform the copy/paste exercise, wiring up RISC-V system call table
> generation.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

