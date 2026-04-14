Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4A3EE1C0;
	Tue, 14 Apr 2026 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186721; cv=none; b=RxHIDosyhXwFroi/umeNYX+CTNZkqQYdfEKXmbmW0qtzrkZ2hFvyiunG9N/H8NwFmO79q7ftlVWiTg2LZpyE8d8y5ASTwajyfrbspRN6GvMlgqGbvRG5LY+hjKFmPFCvndhVIHb46iQ+H7fj+5LZGhHm0K3qpQ7w5TkMZ93t470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186721; c=relaxed/simple;
	bh=0zvNfvLi8XutLwvW0b9EPHt8HSMX+y+TgMFwZQvEMgk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pww9jaOQ3jscA4YWDKeuJZzT0hDZSu53aRcNCZAKij/xSPyMFXI+9H0Dz1qWdG2aWZsWHOA6JNfXHFxlisvA9JkllIRjXa72Soim6hcn1cN9NI1Wk3wwLGKOW7BfOcTAvICjSu/hGyWOfNRnfedI8b31bqRWv4+W+ZcEIoqPamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SygpZLQD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SygpZLQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540AAC19425;
	Tue, 14 Apr 2026 17:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186721;
	bh=0zvNfvLi8XutLwvW0b9EPHt8HSMX+y+TgMFwZQvEMgk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SygpZLQDsYS80h2q/T6Kg4Oq4JDn39ts12N0L9fJDiso7KtWQyXTHTBCVDYmyiLG7
	 q6O1Im7kLVA57NhcO4vDZZrCVFkGIRq4zBL/fCwZeeYpysLV70ZGFivD0LbPJHR/dX
	 8cGhY3oZoTw7v0OYgTWG1HoleAcmzJAevM2TiOtBeQk/xK49vEvDlL0p26df45GXmK
	 mPyHmTj+A6mx64F6G54Ce1Awmv9FLHvO2Md3p/pMgY+W+dfD6wFFYdiowd1uQi3p7S
	 g+KtVl2RM8YgT4EgFWEh7euBKEQSZmI7/D1lOfbQpjFwVVKwRqiFZ6vLyaZ1lGyGZS
	 ezBX0ho8xJVcw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, WANG Rui <r@hev.cc>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
In-Reply-To: <20260414005152.10550-1-r@hev.cc>
References: <20260414005152.10550-1-r@hev.cc>
Subject: Re: [PATCH] perf loongarch: Fix build failure with
 CONFIG_LIBDW_DWARF_UNWIND
Message-Id: <177618672129.1519819.17210029301631805375.b4-ty@kernel.org>
Date: Tue, 14 Apr 2026 10:12:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 14 Apr 2026 08:51:52 +0800, WANG Rui wrote:
> Building perf for LoongArch fails when CONFIG_LIBDW_DWARF_UNWIND is
> enabled because unwind-libdw.o is still referenced in
> arch/loongarch/util/Build.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


