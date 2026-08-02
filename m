Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162123C516;
	Sun,  2 Aug 2026 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680430; cv=none; b=pBYyKqTLlwbnWj08Hqh7jOXj695cff27kQLeDkDwEwl+vLoD0ew2p/8KvxBg+ilnsxZrz94DcnTMhHP1SJqZB751N2pgbRXusQ2sqa83Q5yoKatGJ9cXiclGUi0spqxYNPiNHuJS+SQhV4o0BN095YjhCYvRiaob0nbP7A5c1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680430; c=relaxed/simple;
	bh=NHcepYOic0lCuTbpqaOaoyLy80mn/eSmlLg5chwuc0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbRZ/du0KaTI56wUOVhM/mRlkmOwIkIXcuQZprh4qDRHO6XOD/ZJBfbVfXvAPDJQAdcWE0qdFQ4Xrt+2JRR82XVWKRjzUZcKx2ds1+3qNXcbuMs8EIUXLkQZ4oqaVPKet+yHGCbTw8dKyOqZQk6PVhqRvm9hQe2iMrutb0LYjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myLHAGsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myLHAGsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8521F000E9;
	Sun,  2 Aug 2026 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680429;
	bh=v5x4mestDr/J4Kdz2/XaBATk3+SvretAT+F80q/VaNA=;
	h=From:To:Cc:Subject:Date;
	b=myLHAGsxmwBmmtx+JdwG6rRUKJ/YsCbyUk6skq28kiG3m9GYJGYGAvaJDbO3FAw0O
	 9PSrOKpKHZHjp0cSHXUEDLx4LaR98MPu88v+2QYSmpZ+PZYNnyosQY/bz+TXN98W7m
	 I9T3/FHWrO2V6jIzgxDNLJO1evZyfTgiLF6MEq8S5h8eh9G5yYEVOOWG+eh06N0+AO
	 sSxQJuR8siwigk/VrOOEhzjt1RMMc/jKCqDDc3ddIKvRo0qL6UmcjB986FlfJoWvuj
	 CNg4gehtPsc164h47Iq8yNi3IOVd43C6PVu8TK9MxZQMj0FteqRPlR6gaINyV1MW8G
	 ckRNGd4IbSLWQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES 0/5] perf DSO hardening series
Date: Sun,  2 Aug 2026 11:20:17 -0300
Message-ID: <20260802142022.154219-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	Please consider merging,

- Arnaldo

Arnaldo Carvalho de Melo (5):
  perf dso: Guard against errno==0 when dso__get_filename() returns NULL
  perf dso: Guard close() against invalid fd in dso__decompress_kmodule_path()
  perf dso: Use stored fd error instead of stale errno in file_read()
  perf dso: Guard against cache underflow on short reads in dso_cache__memcpy()
  perf dso: Replace assert with runtime check in dso__read_symbol()

 tools/perf/util/dso.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

-- 
2.55.0

