Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D61345EBE;
	Wed, 12 Aug 2026 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495938; cv=none; b=M2B3wWXfRD7ylpOYMvxpTi7C3UShI32S9uWjAf53KLTWeiB48xD+W0DtmJ82AS+2ROT2usUXjUpzGO/dOfQkcXkg1fj6hfK2iaznA9lEm5TTGopbsz7GUvR/uPXMyL4yfJMna946L690PIs+82dR5NOws+Ved4XCep4LFVYKx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495938; c=relaxed/simple;
	bh=sewWrXD0s65HA6FtYR+XxkWQWxkApJ2XCKG3xfRIp3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lF0vPmNWzGmaNHJXx2fJ6stlzag03eQ7rMMNM2SkE91IZjgoEe3fKnKlyNNrdDafASAB76ZwGOdoB7dU79GHxOVquK8YShxjWunrE5itRhCRT3rBFOyFOYb/kTTZ1sG7nHr/BzBd+gmvmTxp4kUBwfVU8f4jb/s9ugW0tpljwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxw0pSO8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxw0pSO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594E41F000E9;
	Wed, 12 Aug 2026 00:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786495936;
	bh=BH7aXxG4zDbh5bPicAaIF0trSoRWQ+VP8+pOtXb2Y2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Qxw0pSO8fEZaAmLHmxhYY6cNDvTYWg6b2IjBCEZt7q2Z1XbMgiQcQ2m2ZSu5D803Z
	 nbRCAbOMZyd0izwAtRq/3n/UeDvM8yRq+eiK22CAuV4CnAJvt7rb0fz9zx/ZOSJEit
	 IS3YgLh2uQ6qSNEXVcBkez6hw8/I82erkSL+kYsIi1IoV8w3WBRl3VqTuSCe0eTCuQ
	 bboJYXTUuhkuU4F+tFV8TNggH4XfJ2jWoncvz5mYBnqhAI5E/qz6NFivyqUAilM8Hi
	 lcDdPHFI+pI7xkVRX+DSqVkfulZNEpuGUhJu9ZxJhf3PZEL+6nnsvhL0wYQfxMz59Y
	 R+/BTSftyWKRQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
 dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
References: <20260624051535.3584977-1-irogers@google.com>
 <20260809071455.1221514-1-irogers@google.com>
Subject: Re: [PATCH v3 00/15] perf python: Fix python extension bugs from
 v19 review
Message-Id: <178649593632.2880647.4424444661810354972.b4-ty@kernel.org>
Date: Tue, 11 Aug 2026 17:52:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 09 Aug 2026 00:14:39 -0700, Ian Rogers wrote:
> Phase 1 of splitting the v19 review patches into smaller fixes.
> These patches address issues identified in the python extension during
> the review of the v19 script porting series, as well as fixing several
> pre-existing bugs and leaks.
> 
> v3:
> - Addressed review feedback from Namhyung Kim and Sashiko AI:
>   - Dropped "perf data: Fix directory file descriptor leak in perf_data__switch"
>     to avoid Use-After-Free during directory mode file rotation.
>   - Added list == NULL check in pyrf_counts_values_set_values to safely
>     handle attribute deletion (del obj.values).
>   - Preserved errno before calling intlist__delete(skiplist) in cmd_test
>     error path to prevent clobbering the return error code.
>   - Added CHECK_INITIALIZED to pyrf_pmu__repr to prevent NULL pointer
>     dereferences on uninitialized PMU objects.
>   - Fixed duplicate patch title from v2.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


