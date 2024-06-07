Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D0194AC2;
	Fri,  7 Jun 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782694; cv=none; b=R7TC6FZ8ta+KH76kZYLoVI7Tdq16BrFAzYaJ819tP7tfT/BBCoh9E6iSpeXONSrllA/4nn+VPGoBm51/YjJj1GhWJ+qEMCO4VILOvQbVUkBZeBCBpGjsAMW3iN1r59KGuVfeLp230OLbyb2W9jKCZNbhq7/CEjEVMVthavmUEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782694; c=relaxed/simple;
	bh=btHr0E7LRUyyqVH7nKpRWOr3pJcNhO/WtVhLfR29c68=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J794kso95mVL2fUxO/ci0HZYqBdqCG/mxxTuQfolCvpDxAE9KJwmO/jb12c3cP81ycf+OLQ1CHHiHdUUG2GQomiasbW7fLLYv8Dpdme1hAjZQmqJRkTSj0hSf7Ywf9L3TPjOihaijSY7Ps6W9ioHpdl1ThMYpM9y6Nb9ryl1lb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTbHwiOy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTbHwiOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110AEC2BBFC;
	Fri,  7 Jun 2024 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782693;
	bh=btHr0E7LRUyyqVH7nKpRWOr3pJcNhO/WtVhLfR29c68=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KTbHwiOyGDSvjife9AoXlAGVKEldi5Jm1li1LGGwC9xcrnb7nVGu9qvGXbioWWhSm
	 27UYPls0CDhKSO3kkIDce3sToKy1uCc05noAy1mQ6jmTnA0IRMxQ1wMzZ3IMYp6zgH
	 msUyZkfhgBEfVQ77pbD8OMLD8t9MTfvP/DdNKp51kiNKfPJ+Av1iaEtjzIyjSGMbMI
	 gcCI6D7zwkr/Ca/6o43Lt8P6DW3xKr7D+ujSmvlFR9IL8M8cdl7Ng0aRx70yI+Yvlq
	 w++j6UJ0bl2ajEobq+PdEQHMKzcUnGYTspF/gkk/U9Eu2MsW1YrDA8thJ7LgJlaX7p
	 IqgV+O8333Vzg==
From: Namhyung Kim <namhyung@kernel.org>
To: "Steinar H . Gunderson" <sesse@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v1 0/3] Fix and improve __maps__fixup_overlap_and_insert
Date: Fri,  7 Jun 2024 10:51:31 -0700
Message-ID: <171778267657.3080367.600495538744784216.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240521165109.708593-1-irogers@google.com>
References: <20240521165109.708593-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 09:51:06 -0700, Ian Rogers wrote:

> Fix latent unlikely bugs in __maps__fixup_overlap_and_insert.
> 
> Improve __maps__fixup_overlap_and_insert's performance 21x in the case
> of overlapping mmaps. sesse@google.com reported slowness opening
> perf.data files from chromium where the files contained a large number
> of overlapping mappings. Improve this case primarily by avoiding
> unnecessary sorting.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
