Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538804570E3;
	Tue, 11 Aug 2026 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468341; cv=none; b=IgQexCDWuqF5BqrPOOJIOLoJNpdvRwydG2MlWpSK1vv4Ar5QHMUHy/dvMJ8B5e8aZi7Ac70oe640EuX3+utEi0BErgyPPMOznE0MvvWW7BshZcBPBH4DcVkoRTB7G0xZKPY1BSbRup0RVbD67QBUWNFxuIOfTckeKRopE7W5iYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468341; c=relaxed/simple;
	bh=jAoDEexzBfmVbDUQRA+8xn8rzqgPgumPJ6dP0DvzSIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2xfvFqFw5CcwpbixAvftVm2+ElP/WLfSrWEQU/vXTixIGu0GH1KB6niWMEb72gDiRYhfDPxK6ZEJmTv9cWZA71Ep3bbXgLnHeTz/WDGkwEujlSM0gWTvy2jk/qa6Cb6cyJ/U7M6oRmpYXdp1L9rJXzCBNVHLc24OXgeu3QX7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX7/m1+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX7/m1+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737E61F000E9;
	Tue, 11 Aug 2026 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786468338;
	bh=IbhEIOSm80yDQVumaY0vuMXvC7o2n8XYqsqqUww+NlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MX7/m1+ZuiR+MdNdVXth2uN6bESSNYEyj6uv9XtL2b3iqKyzj/3CaPLRn6pLZ6UxI
	 dV4tixXUy9MCOjvOSBYvbeynYw7i+kwgUuGlWgNEXdxvLsMZ0G5v2NARkEcRAvs1V0
	 r3sBA0uE+U7j1xYyOdaxwwzrGnu0Y/r2DRgdpV/f9LqIrorvop4pPoQ6y+O+BQsbU2
	 ST82slRGi2tl8/YmfcbXGRYYlb675GY0yPdyeDb35Eo/VwsvN2lzNTsu1HvQhliduo
	 j0PsczPX6CmhCK6W9ZmW1/DHj3miwOtM8RO/hqsYL+MeRyALfpLOa8cqriafCF6Kzc
	 lUya0JiQkMfNA==
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
Date: Tue, 11 Aug 2026 14:11:57 -0300
Message-ID: <20260811171200.30096-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811171200.30096-1-acme@kernel.org>
References: <20260811171200.30096-1-acme@kernel.org>
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

