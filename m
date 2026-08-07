Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38337D124;
	Fri,  7 Aug 2026 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146753; cv=none; b=gQv9UCm2wr8NRkTqP0vkHG4A7bWl3TNPtIxOqpHQPpKBdPGNsRPgvlzisAa8b5lgvD+j1sDdtz6Y08zYRLbl9FyCm0P5SGJtWrcfNOrBCDdx9OpdKbOHMwcJEbJ4WB+Rlw/c+hh2Q/dWrsuIseH+51SKWkbwLD6vyrlktAcXHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146753; c=relaxed/simple;
	bh=BACUp5cKJMJiJ4t6LfxN/joowvFtdBwXajdTJDrhCoQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fw8ois1Fmex2Rnam2spROs1Pw6BMgkLVWutPWbEQJhlHKyhMpQ0UZOyyceZltIRU/G7IKla9zjJVjKciGu8e9YRd4nI4T6oBCZyMA+ciIe/h1MAjLubHAWlRjClanafVOGbfiOlPlWJmuCmMcBQZ0j9+iBBra7UkPij9BLE5e/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqVGPuOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqVGPuOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C023C1F000E9;
	Fri,  7 Aug 2026 23:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146752;
	bh=7JkE0O05GB0ddBCHcD5F6drGpXlxDg/gfMZLUZr6wao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jqVGPuOtxbB8jqstbTsITMW60jNt9BQw6++aOsoeKeh/mApD9wnwQYCoz3uwT5LXP
	 fx8fOQ/xMwyu8gA1UwgxsO0SxnCygwfjXtn1AJ+tAbxf1b1NPstvFb+T4tztU8CljC
	 qislF+2Wv1uMIwGOH6RpbJRbRaNEtQ6FX5B9+GXGgCnurgw0LVyyAUZaSMRnMx991H
	 iPWLv4poKaaudtdIuw/drymp4dwnDMC9W0boxYs3dZnEbqfuFnjaiExdgLUmkjtuzB
	 KfyApHt1dyBlrnTxWQ1VJM2R4ggfFykf5BsC7Cr+vigh075ip4PnX6IcYgcouatOhy
	 CU4BPROSSdHwQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, 
 chjohnst@mail.com, sean@ashe.io, steve@abita.co, rishil1999@outlook.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260806153926.300499-1-atomlin@atomlin.com>
References: <20260806153926.300499-1-atomlin@atomlin.com>
Subject: Re: [PATCH v9 0/4] perf sched latency: Refine outputs, unit
 scaling, and histogram support
Message-Id: <178614675174.2923192.12057881964440578941.b4-ty@kernel.org>
Date: Fri, 07 Aug 2026 16:52:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 06 Aug 2026 11:39:22 -0400, Aaron Tomlin wrote:
> This patch series improves 'perf sched latency' by suppressing misleading
> empty table output, extending pipe mode stream processing, introducing
> dynamic unit auto-scaling for latency and runtime statistics, and adding
> latency histogram visualisation alongside time-span filtering.
> 
> Patch 1 addresses an issue where 'perf sched latency' fell through and
> returned success (0) when perf_session__has_traces() failed due to missing
> tracepoint events in a perf.data file. This caused empty header tables and
> zeroed summary statistics to be rendered. In addition,
> thread__get_runtime() in map_switch_event() is guarded against potential
> NULL pointer dereferences under memory allocation failures.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


