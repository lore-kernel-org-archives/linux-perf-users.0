Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423411F957;
	Mon,  2 Sep 2024 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241583; cv=none; b=Eiw4GS9gAbtGQY0j2bgt810bfGxPtz/yOLHiT391zWzOQ1KjMAjT0g3f0We80umnuOf7uAdVWTnyORYhqkQ6AjP+A9yMHlHrBXC0Ou+qGXWIxCocRjLnEoi5tWloZRVJUm/zm0YvYyRN3H1ZfdjIKO1SnuzQY0WtAXRR0K7uy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241583; c=relaxed/simple;
	bh=5TIMmVwf/PXHNn43q33d7bP3iTu1S6Dyy5ds7Ki1SuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WguKFRmZn5lxR9IM91j/bD2A0TpETp/7pdm0B1P9OXVj8L0iS2Wz1gTdxMwGE5fOrqozU+1LPcrXnlpHJjG1LYERvrC0i+HB21BhxIbLqL++EmWhPPFam+EZUdqUmNRGXdUSMTc3IlazwKPVkJcnUvmNg5PGG3SOWIaYcCpQVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6rwT7mi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6rwT7mi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F49C4CEC3;
	Mon,  2 Sep 2024 01:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725241582;
	bh=5TIMmVwf/PXHNn43q33d7bP3iTu1S6Dyy5ds7Ki1SuY=;
	h=From:To:Cc:Subject:Date:From;
	b=l6rwT7miUNBWfhhPo7wd8Muat+s3k3egG0JBRbi8ZkRsVY9IPvrz3FpDbIlKQed/K
	 VZJL6tnQRUP0cB1mXpRuCmYaIU0Tq6hdzi9Y8Uzc8sP2Hksuj8eDxz78NQzS1e1sTY
	 IV38IrjuB5Wo0SFf+3aaiK7IB2ux7OqpTJgP2z05gmPgn74JrgSpWC3M9Nd8uLRZPZ
	 JAsbI7MtchDuykAMlZ6FcXrYhuFgWGhXmaCldPvqZjUT5hbkCafvx7BnObElfPBpGE
	 NOqguDkBJJGafXWkokhZI0Ui49pBdJIXQPd8UkhzjlHkt/sW5SSLd4PK4OR1oPv1L9
	 gj92bE4Jj90iA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [RFC/PATCH 0/4] perf tools: Do not set attr.exclude_guest by default (v1)
Date: Sun,  1 Sep 2024 18:46:17 -0700
Message-ID: <20240902014621.2002343-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found perf tools set exclude_guest bit inconsistently.  It used to
set the bit but now the default event for perf record doesn't.  So I'm
wondering why we want the bit in the first place.

Actually it's not good for PMUs don't support any exclusion like AMD
IBS because it disables new features after the exclude_guest due to
the missing feature detection logic.

AFAIK it doesn't matter for the most cases but perf kvm.  If users
need to set the bit, they can still use :H modifier.  Please let me
know if it's ok for you.

Thanks,
Namhyung


Namhyung Kim (4):
  perf tools: Don't set attr.exclude_guest by default
  perf tools: Simplify evsel__add_modifier()
  perf stat: Add --exclude-guest option
  perf tools: Do not set exclude_guest for precise_ip

 tools/perf/Documentation/perf-stat.txt     |  7 +++++
 tools/perf/builtin-kvm.c                   |  1 +
 tools/perf/builtin-stat.c                  |  2 ++
 tools/perf/tests/attr/test-record-dummy-C0 |  2 +-
 tools/perf/tests/parse-events.c            | 30 ++++++++++------------
 tools/perf/util/evsel.c                    |  5 +---
 tools/perf/util/parse-events.c             |  6 +----
 tools/perf/util/util.c                     | 10 ++++++--
 tools/perf/util/util.h                     |  3 +++
 9 files changed, 37 insertions(+), 29 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog

