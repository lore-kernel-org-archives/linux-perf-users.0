Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D340DFB5;
	Tue, 14 Apr 2026 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199736; cv=none; b=FpbLxrmnYA3aX0lfUHSI+o2g/nDgRClhHp3+3o1miROLrYwYhAeFV+x7tBU7olRkJeFdT1Asy3caa8ulYua1JkRFBjfzsnR5qlSXgNEkJjwiFnRngYAA3+92094nhtdAblda7+9uEGcdESYoblgtPozX/H+ADvHZJk4X/zLxCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199736; c=relaxed/simple;
	bh=VAXZawxsXfTyt201CXFlUzntkIrbrneGqcP3zG29cBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlvbB/q7f9rwp0XmupGzJ+JjH0uMLXjVfobOuW6gegxUiOEkjYAlOGE8IO8OAeXVhSQqIO99UC5IiG0LBnoh19ZTjm6fk85N3qRhbEtUBye/Hu4pubMaIDWm2+j+/PGoF8KDcn3AAe08sYC4/OZUhSg5h/6eLBNbEbSOm6gN/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfruv0qr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfruv0qr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDCFC2BCB4;
	Tue, 14 Apr 2026 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776199736;
	bh=VAXZawxsXfTyt201CXFlUzntkIrbrneGqcP3zG29cBw=;
	h=From:To:Cc:Subject:Date:From;
	b=Dfruv0qrBgBawxtiv9bF8Hm+DMLVPJtfx8oLCzGJGVcP4foExNQwvvLMwAuwpDhNt
	 OHR7ciLeS9ToZCQZVPJHw+rJhJ7wxlARi7qHHOXpUOaTG/cpI0lD3vs1LveQmESzES
	 m2EctU0NaYNNEEDEiNrutUK/flqas+6AUbGVzLiEmrwZb7pJWbp/QdcmWgEessnj9/
	 LxS1pIEW3LcAxcNaMEONfzCeQ4eAqg/D1+DhLDvJN+y5EeIvqgdyXTA1Izx3wJb9RU
	 WaPg30tcvrBUzMTJEcNH5w1/pMaH2rnh39hR4WBFt+/J0a5VQ4R0HaSgehI/wDoLO5
	 PEGSyqbPjD9mg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES 0/4] More perf.data header validation
Date: Tue, 14 Apr 2026 17:48:43 -0300
Message-ID: <20260414204847.293557-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

	This is picking up from what was reported in the previous
series, pre-existing lack of perf.data file validation, processing files
and buffers in header.c in a similar fashion.

	There is more to process in the trace data, but that is a
different can of worms that needs to be dealt with in a similar,
upcoming patch series,

	This is probably 7.2 material, but if feeling this can still
sneak into 7.1, feel free to do it :-)

	Now lets see what Sashiko discovers while I still don't have it
running locally right after Claude, before submitting it publicly, which
will soon happen :-)

- Arnaldo

Arnaldo Carvalho de Melo (4):
  perf header: Add section bounds checking to the fd read path
  perf header: Validate string length before allocating in do_read_string()
  perf header: Sanity check HEADER_EVENT_DESC
  perf header: Validate bitmap size before allocating in do_read_bitmap()

 tools/perf/util/header.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

-- 
2.53.0

