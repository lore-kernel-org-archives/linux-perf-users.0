Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355733556D;
	Tue, 11 Aug 2026 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470719; cv=none; b=VroND3IdxKwopOtROfakquNAm7Qmvl8cRsCp3q1aKYOPRawLDByI0q2BMlCkOiIgvWsR094O44A5ll5mH27dAgxPuFeA09pDhW/tN+3PjdJGYZr8STM5z8Tio0NwuxGRj8IfJ72iiwplm5r+LfEfHW8JKs98ZuaxUQ9B2vfNlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470719; c=relaxed/simple;
	bh=jAoDEexzBfmVbDUQRA+8xn8rzqgPgumPJ6dP0DvzSIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUyuahwuHFxNBfIq5QA+GlRZyweyMRWYnZBCUCBGdY1NCsjMPOZXFoVaG3Zp0tHwKchNRBnMPSjTW8UWNde2FV+UbRJWNuzQeHjqSthjs54f3tepevOfYiFpEx02dNp1AFHx1Q8YgDfb46gPitNtiRdrE8V7adiQV6EPZfjfEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAdtkkJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAdtkkJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4561F000E9;
	Tue, 11 Aug 2026 17:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470718;
	bh=IbhEIOSm80yDQVumaY0vuMXvC7o2n8XYqsqqUww+NlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JAdtkkJbJLZfFqzRC13/4Alud2PARS0mIdWvihg+EYOcyogy6Dsn5c4687Juap/RM
	 hCRddp7JqkXlH7fnzJhJkFyp7MRZttc/4OtJz3KFXnzPjF71SzTUKd7p9ShUabM5Pc
	 csaKfJyoRYUBIJRg+ykr2pdM3MExxd7jSE+EsoAiUBPorhL+hGvx/ExxGXjFtvNuix
	 gnBGmy2ISzCIZ2wcX45c416liXu43iFEFJYOSe80QZ+c2gz4D5A7VXMzBda6jW22uG
	 xNtBS3eiIYp9AA6fGSpIVxPaNgBu/I+JDkY7CaxmtgaVsWaX0e4zFsCB4FrqH7UXWe
	 mwhkBEYbXsOKg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 2/5] perf dso: Guard close() against invalid fd in dso__decompress_kmodule_path()
Date: Tue, 11 Aug 2026 14:51:31 -0300
Message-ID: <20260811175140.7235-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811175140.7235-1-acme@kernel.org>
References: <20260811175140.7235-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

dso__decompress_kmodule_path() unconditionally calls close(fd) on the
return value of decompress_kmodule().  When decompression fails or the
DSO is not compressed, decompress_kmodule() returns -1.  close(-1)
fails with EBADF and clobbers errno, which callers up the chain
(dso__get_filename → __open_dso) depend on for error propagation.

Guard the close() call with fd >= 0 so only valid file descriptors are
closed.

Fixes: 42b3fa670825 ("perf tools: Introduce dso__decompress_kmodule_{fd,path}")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index fcd4b462992be6f2..124193453675ca18 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -395,7 +395,9 @@ int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 {
 	int fd = decompress_kmodule(dso, name, pathname, len);
 
-	close(fd);
+	/* decompress_kmodule() returns -1 on failure, don't close(-1) */
+	if (fd >= 0)
+		close(fd);
 	return fd >= 0 ? 0 : -1;
 }
 
-- 
2.55.0

