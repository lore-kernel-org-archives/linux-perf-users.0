Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB78374E7A;
	Thu, 16 Jul 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221124; cv=none; b=ulJSkNbVD/NWrPVXRAI7O9pVSh0SIbJYkzlbxBUw7MJ5jYue7E4E1FyoOC68JvmhWK/Z2UNFSOKpupNiYpcu5UkSXgnYTPczZ79dKu1s4EJFOB7RIFNLEerYekidY1GaJBTamz1yGpAlUZHkZ/2ipZOVWlRp9WJJPB1nvkjxoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221124; c=relaxed/simple;
	bh=kUFEErooklfrj5WCI+ddrCDSVOhar41XFdo+Z6uvEWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UNWxNQXrC6pxu2OptnMfXn0W5Y41gDf7e+Y98krxEOJad62AGK7zLbesyKzG2g0zAbGyS3UGu8N2ocIRmyjhZSL4IPr5tTRhjwvJ/2uuGibzaDqQpCd99Kbo+bL3CjA5/xyd5d+3UYVov+drQ4BCzFnWdiLhiL+vK8tMfbdqGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTFRHZu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTFRHZu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B381F00A3F;
	Thu, 16 Jul 2026 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221119;
	bh=8+fBqEcsBW93aFpCpkoUk6ixW5HPknNaWbiY4bS7ymc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jTFRHZu47Gja/kovoaVqXSc1DeVnPIBvFpwhprSZGykh7ADonkex0Q5dIwoXJiosN
	 aDOkgeIm/pUuaOfRyBcSCAHl5hL2dPIITzsfCCc2v77eOwkU+P38rOFjcW9OjATvij
	 /xPTnWMLjfDQdjUUJWF1uijqW6GHd/XwUiLfNV5WB5scGQr0fWObufPBfNv7qvooey
	 3yqz2kLf+RSUXypufdQVwPV5attbE+JLchShUFuwXCDD+gLyZvBV2Uv6AwwPBPBTXT
	 vk4oP/LdgRhp48FlMORINqamnutj9mMLzPOKQZRaUiXlgkO6ixTrepnweQWM6VKZL3
	 6Pxnwz1A7rAhg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org, Sashiko Review <sashiko-bot@kernel.org>
In-Reply-To: <20260711003235.1963043-1-namhyung@kernel.org>
References: <20260711003235.1963043-1-namhyung@kernel.org>
Subject: Re: [PATCH v2] tools/lib/api: Fix potential double-free from
 fdarray__grow()
Message-Id: <178422111883.3439510.3296621632848374839.b4-ty@kernel.org>
Date: Thu, 16 Jul 2026 09:58:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 10 Jul 2026 17:32:35 -0700, Namhyung Kim wrote:
> If the realloc for fda->entries succeeds but the realloc for fda->priv
> fails, the error path frees the newly allocated entries.
> 
> However, fda->entries is neither updated to point to the new entries block
> nor cleared to NULL. If realloc moved the allocation to a new block, the
> old fda->entries pointer is now freed memory.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


