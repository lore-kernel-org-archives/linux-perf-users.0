Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC52F8E8B
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068976; cv=none; b=dH9AsjT6hkCsKomwQnoEN/EAxV4cKLDF1zmNJmF5RjIoRxMMxmGuigLpu3Jvp9z3sC/dWWOoA1r+LIJRgseesbjfglx5zgWxra42/CoZVcaY6VcCwDBO7P14fEleG4gkfrzQqlYcFp/pB6nX9/+yJ/aF5PW3ohE3inCGXPKNb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068976; c=relaxed/simple;
	bh=oYnuplu422ANdFcYXxUEvmau9BgtYIrtymOZUGiYgGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDK0ziwtqfrlvZiNnuFm5/2xBwE27ZmkEBcFug3ygaqvrMjIvVgKJZQMLmb6OWvSoG6jlUZ4nULjCK1rm4y1CMid0D6k9QJ4c62SarpmHio8ZiSC9MQFC0SWlDtmhnqDur+YgjtVppAQigRQMobVgEqjUh3jlsT6MMJ8PwjBFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=rQvtnLwJ; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="rQvtnLwJ"
Received: from ms-a2 (M106072126074.v4.enabler.ne.jp [106.72.126.74])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67IEfpNR058426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 18 Aug 2026 23:41:51 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=DYJnXvkAQqrvBouOB3aUMIioFXlDzjDd9uQ4sK0FXqc=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1787064111; v=1;
        b=rQvtnLwJWJbKJf547NECqugoZAJAfOBrbkzhfLeHQZMhTly9qNGRU9ixEup5b4s3
         pGi/a86FBwqIUGxJH7y97XksDhBMuFEWWexFN8GFgX/++GZ6YdGeH7tqQJlIbYT+
         pvS1Zgg3Yf4NNHRQeQ9fVFuomhnUZXl6VEkmfTj9lilaZHUYowNf+eBr08PEl8qC
         46qvffpS0miZcTB1LMGQbTDZItWyVzAtVcnw6u84pLZ9U1lae48OOikiZCx56gdI
         VDzQyzJ0q7Ze03fYa9DJwZwoVPaTlr5mU8xILXAc82clzL+TMMWDx2QHFtN4g9k1
         fDAJ0D7GH72bM0kBt3Hy/A==
From: Kohei Enju <kohei@enjuk.jp>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 0/2] perf annotate: Fix source option behavior and
Date: Tue, 18 Aug 2026 14:40:11 +0000
Message-ID: <20260818144149.101248-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Source annotation has been disabled by default since e201757f7a0a ("perf
annotate: Fix source code annotate with objdump"), but the documentation
still describes the old default. Also, an explicit --source does not
currently override annotate.hide_src_code.

Update the documentation and make explicit --source/--no-source take
precedence over the configuration.

Kohei Enju (2):
  perf config: Fix annotate.hide_src_code documentation
  perf annotate: Honor explicit --source option

 tools/perf/Documentation/perf-annotate.txt  | 4 ++--
 tools/perf/Documentation/perf-config.txt    | 6 +++---
 tools/perf/Documentation/perf-report.txt    | 4 ++--
 tools/perf/Documentation/perf-top.txt       | 4 ++--
 tools/perf/Documentation/perfconfig.example | 2 +-
 tools/perf/builtin-annotate.c               | 7 +++++--
 tools/perf/builtin-report.c                 | 7 +++++--
 tools/perf/builtin-top.c                    | 7 +++++--
 8 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.53.0

