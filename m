Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A912C49C;
	Wed,  2 Oct 2024 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906668; cv=none; b=eHNxIHEYV3LW9r8/ceULhKtmsmuNKRhvHxm5qt0jaG7mJzGngp7LEOeWob6UmpvvrEFDt2/+ktpts6ndUA6QN43Rq6HssxquEFgHCdI7voMOoY2hAlU7GTakp31/4XHiXPED6JfnmoOQ4DP+GCdzmlSMwkojyQgG7uAZrwRyVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906668; c=relaxed/simple;
	bh=IrBMGAHT4Z+7mus4x5s9OncHC+8kvCOC2lukYTg9Sgs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3a6y5rQbDu6K/rWqIfvBJma+5fE2KIlHcYZmLR48yjmeGHTM0dtQj99VG8G4yH8aWPY9T0VgVtv46LQa7eIQ/N7xAu0cqbITIUEF1yDeqKzjE5xuy0ZNZA8YmQksTzSMbXQn7jw8XDbWjy5ncY2wsfgLRzsTHR9f7po7hWzSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5KiCbSd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5KiCbSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F20DC4CEC2;
	Wed,  2 Oct 2024 22:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727906667;
	bh=IrBMGAHT4Z+7mus4x5s9OncHC+8kvCOC2lukYTg9Sgs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s5KiCbSdykzw04PK605I5ZfX9Xo2hyzvwY6G7p3zkPvKuEiu3rsKt4HuFhhUDwlkV
	 4bR3bUp2KlzTuMDIJGMdl0LkMWlhXcyZaT+GUc2UCXo69fIP2F6PXPbq9UdT7HAkmf
	 0fUCVD5cA8U2vPJGJsv5s51cH9BURss4iTjYEuackzZaIR/WpKcSqvg2kknmxPUwkw
	 YsaNfe/Ihy3lHEMLvR6QEnX3ZI7loGDtSyc6SeV4+G+ghaD17nI0bC7EYRjiAfgdls
	 aticWeD6/SbJejfWQV5SbW5D010fe8J7iDwQjdbnZTD2a49rX87NlX64yGFdsHptOk
	 YqXl3urrC/QDQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 0/4] 2 leak fixes and lower 2 test fails to skips
Date: Wed,  2 Oct 2024 15:04:09 -0700
Message-ID: <172790659695.3079262.3083849324016759104.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001052327.7052-1-irogers@google.com>
References: <20241001052327.7052-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 22:23:23 -0700, Ian Rogers wrote:

> Fix some memory leaks that show up testing as !root. Lower some test
> failures to skips for the !root case with a skip reason of
> permissions.
> 
> v2: Rebase that also cleans up on the bpf_counter__load error path, as
>     pointed out by Namhyung.
> v1: https://lore.kernel.org/lkml/20240924202916.1560687-1-irogers@google.com/
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
