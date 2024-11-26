Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF11DD0D4;
	Tue, 26 Nov 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639292; cv=none; b=dcPSb/vg/PAa01XHN+WnE/BQvRi50HaTM0zv0vcRaNDGo9XOwOTzj1gBe3sWkC2wiMkHjL58kywSQXkQ47aNm2Rd7Ag6tS6kXS2YcjM3RTWfMEVWv5rD7x1IUTF+U3qxPQk0fHCTPN9s+9nm93NsoHvUWUFE7E3smJCF+ZEs2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639292; c=relaxed/simple;
	bh=oKW7VgwpjCE+pqhHdDGaMLxz+CglQ45JWptkt0Up+RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B36Sa/eh8eJiVDFkZWmBBjBu3dHXSrjbXKkQrNj5D0ivnlSHLsplFbU18goSNwIFrB4rnM0UBn8hNEJdsRbB9x7JTbGccWP3k1hGwWwyZL/X3xGgxCYmQ6mXgJ+ITlQ7M3ZoC97oWR11L74BCYxqZ2INMkwOG+B2S5qOgqh3osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCSso/Uz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCSso/Uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2B8C4CECF;
	Tue, 26 Nov 2024 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732639291;
	bh=oKW7VgwpjCE+pqhHdDGaMLxz+CglQ45JWptkt0Up+RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCSso/UzJsnV9+MCDkXJwXjo0iQXxCTWTdU6YhVEVuD6b7R8P/yeXHwWJx6sS/jOR
	 +M8MzvDUJqrj3ahEhSeYnuaLRgURJ0HAQO79PMKA9irK2IHvbseA6FMpLh2a4m758z
	 wHNzcn33D6hpxw3kzTOhxEQ3niAUqrIsyA427MtokJKbGZVN+zrT4589L+U6N9v82Y
	 FsnRAvf6cwuDatKgGowEjB83aEAfRS68g2rlmiIcqczD88/aaXG9GvDhOVY8KxWc64
	 wNqGUNSLe09UYyMg0zzEqNvc/tHgXdGx5S5Xvuu5TEBX9D7CQm2zwMNl/k2lZOmFi/
	 FTVeNe2bRXROw==
Date: Tue, 26 Nov 2024 13:41:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf trace: Add tests for BTF general augmentation
Message-ID: <Z0X6OTPsWOHgmvMr@x1>
References: <20241123005512.342079-1-howardchu95@gmail.com>
 <20241123005512.342079-2-howardchu95@gmail.com>
 <CAH0uvojmPp4-0xb6sObr8Tcw=ujysLMBeebpwON0Ygy=LH63Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvojmPp4-0xb6sObr8Tcw=ujysLMBeebpwON0Ygy=LH63Zg@mail.gmail.com>

On Fri, Nov 22, 2024 at 04:58:00PM -0800, Howard Chu wrote:
> For the first patch, there is:
> 
> 
> Suggested-by: Ian Rogers <irogers@google.com>

b4 somehow didn't like parts of this process:

⬢ [acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20241123005512.342079-1-howardchu95@gmail.com
Grabbing thread from lore.kernel.org/all/20241123005512.342079-1-howardchu95@gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 4 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v1 1/2] perf trace: Add tests for BTF general augmentation
    + Link: https://lore.kernel.org/r/20241123005512.342079-2-howardchu95@gmail.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v1 2/2] perf docs: Add documentation for --force-btf option
    + Link: https://lore.kernel.org/r/20241123005512.342079-3-howardchu95@gmail.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✓ Signed: DKIM/gmail.com
---
Total patches: 2
---
NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Suggested-by: Ian Rogers <irogers@google.com>
     Msg From: Howard Chu <howardchu95@gmail.com>
NOTE: Rerun with -S to apply them anyway
---
Cover: ./20241122_howardchu95_perf_trace_add_tests_for_btf_general_augmentation.cover
 Link: https://lore.kernel.org/r/20241123005512.342079-1-howardchu95@gmail.com
 Base: applies clean to current tree
       git checkout -b 20241122_howardchu95_gmail_com HEAD
       git am ./20241122_howardchu95_perf_trace_add_tests_for_btf_general_augmentation.mbx
⬢ [acme@toolbox perf-tools-next]$
