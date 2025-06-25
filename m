Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643461FE47B;
	Wed, 25 Jun 2025 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883080; cv=none; b=VF/G9In62Hmf8zEChRxX8JS1kMEGp6KC//ZYKoYLC29GzWpxNPm6ORUqndSoayfOngRhbM4RgkSXhYBHfm6LfoCMtiJHhT6zT3ubcZnSyNxEgS+8tZ+qwapSl3+FPclZmQPcP6dWjD2CNZMnqNbc/rmczIAUOR69wDgZOEErkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883080; c=relaxed/simple;
	bh=6vn+kLxbQhu5UtYwr42P74lvX4VcfqteslgQ0wu8pu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1RSBg5RDE2SldaRZJ1a7JOO27Em5htU14LnmnfPABt+0HXqnf0hK1sPun5ZX9J+md9+TCetdBu/EUzhI4mBkVtksu/8rdP/4mvKSS8nDqcf3hB+F5GM6KrOEp4x+h2srXxd9eWWH/zQDd4D8KiopnJN+La/ZPVn96EXyfO29jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmihI4nf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmihI4nf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5F4C4CEEA;
	Wed, 25 Jun 2025 20:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750883079;
	bh=6vn+kLxbQhu5UtYwr42P74lvX4VcfqteslgQ0wu8pu0=;
	h=From:To:Cc:Subject:Date:From;
	b=YmihI4nfxJF1lM5rLydHVopSgzisZDkMDPFBaM/CJWoB5+knCt6G6r9LIhqpJFLvv
	 E0BRLrbz4klBnRbm2MV8fBQKTzYHDefHN09BuSbxfOUfKu0/3JnrKd4rTZcesc8GRj
	 0W/1a/13K7WHVowr9sxWuhNhxi/E34nH7u0PShRqR68uZx47VHjVi3Emq3XQ9bTGqV
	 0+Zp5hwEFyLeydiSkkn6mlofyjdqvYTOU9umoF6gWDNX/OnwPB7KAMybYM0fgiG50w
	 ISuJNGQGD1JVCqWiJs56oI6ljAkZGGs4UkdnKWQm2CYxvqecTixFEP8irsGRnfLV5S
	 wsw91urZSvfgA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>
Subject: [PATCH v3 0/4] perf: Remove libcrypto dependency
Date: Wed, 25 Jun 2025 13:23:07 -0700
Message-ID: <20250625202311.23244-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a reworked version of
https://lore.kernel.org/all/20250521225307.743726-1-yuzhuo@google.com/.
I've changed it to add a new minimal SHA-1 implementation, instead of
trying to pull in the kernel's SHA-1 implementation which is not really
designed to be extracted into userspace programs.  I also added a test.

Changed in v3:
   - Rebased onto perf-tools-next
   - Removed unnecessary parentheses in array indices in sha1.c
   - Updated my email address.  I've started consistently using my
     kernel.org email address.

Eric Biggers (2):
  perf build: enable -fno-strict-aliasing
  perf util: add a basic SHA-1 implementation

Yuzhuo Jing (2):
  perf genelf: Remove libcrypto dependency and use built-in sha1()
  tools: Remove libcrypto dependency

 tools/build/Makefile.feature            |  2 -
 tools/build/feature/Makefile            |  4 -
 tools/build/feature/test-all.c          |  5 --
 tools/build/feature/test-libcrypto.c    | 25 -------
 tools/perf/Documentation/perf-check.txt |  1 -
 tools/perf/Makefile.config              | 17 +----
 tools/perf/Makefile.perf                |  3 -
 tools/perf/builtin-check.c              |  1 -
 tools/perf/tests/make                   |  4 +-
 tools/perf/tests/util.c                 | 45 +++++++++++-
 tools/perf/util/Build                   |  1 +
 tools/perf/util/genelf.c                | 85 +---------------------
 tools/perf/util/sha1.c                  | 97 +++++++++++++++++++++++++
 tools/perf/util/sha1.h                  |  6 ++
 14 files changed, 156 insertions(+), 140 deletions(-)
 delete mode 100644 tools/build/feature/test-libcrypto.c
 create mode 100644 tools/perf/util/sha1.c
 create mode 100644 tools/perf/util/sha1.h


base-commit: 9c9f4a27eb1096beb650f312a1ce996a9960b56c
-- 
2.50.0

