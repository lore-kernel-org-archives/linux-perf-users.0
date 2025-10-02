Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910471E480;
	Thu,  2 Oct 2025 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410329; cv=none; b=EBNEpSUCDd4LqFP8RjALM9FeuzvSCjFmhLJunpCoIArTiviCXcEm8R8hJ9Bne/vyM0pAQiGBrMPNWjuppNVgC+iM+00d004NLDnxPD49sNE9xhgghbK1nYW7ReNhmazym3Ob033GjCa3Ysl19eaub4WSYC27bScxK6pDaiWWv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410329; c=relaxed/simple;
	bh=afj8svAg+O+Rcv4PrXWjw33OYX3xxNR7edXvIz5juag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NuLrDDX7YGnIEzZw124aZ+mK4sCNuljKCnFhKJ1IdcXDgWaoYgJrFXuDVEKRzNreLQtDnY8WMM7NtYN++4fzAGxaPn94vZJliTUQvJzUhR8vFrdahDAumnxB2AyKFInW7AcBU5VncbLcelp7Ob8cnZzRBPNy1n8MufC+iVTPBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq94r276; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq94r276"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A28C4CEF4;
	Thu,  2 Oct 2025 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759410329;
	bh=afj8svAg+O+Rcv4PrXWjw33OYX3xxNR7edXvIz5juag=;
	h=Date:From:To:Cc:Subject:From;
	b=sq94r276ZyrffvzfBTP8Q6Jqd39Bas0nomXvU6aI9jvJp+PHiNLyf2qXC6DvSztDd
	 vF9h1g5i9FghcDvFM240bdkBxK1iMenHpJKHCa768QhuDTnQlhdpdkjHKzHVjlaa3M
	 DroeghsZG25Esdj1O1KibyD3/PqYnqrNiP3bDQJV49VKJcfISSix5TgDmcJrwwS1BO
	 JnatDOapUECyHY6qt+dm++UBUXrL7LNr5CPFykmbABHfEmT4Py+g7UIIUE5mg762Nd
	 unsG1RKGwd8Q+RFdEbz9ZcODdRWeHRp0BMRi1EIwoLcoiRc0hAXqToZrrmP1WekMow
	 3wSu/JaiHB46w==
Date: Thu, 2 Oct 2025 10:05:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] tools build: Don't assume libtracefs-devel is always
 available
Message-ID: <aN54leQ54ozcUXBO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

perf doesn't use libtracefs and so it doesn't make sense to assume it is
always available when building test-all.bin, defeating the feature check
speedup it provides.

The other tools/build/ users such as rtla, rv, etc call $(feature_check
libtracefs) to check its availability instead of using the test-all.bin
mechanism, stopping the build and asking for libtracefs-devel to be
installed.

Noticed after applying Ian Roger's removal unused libtracefs
configuration in tools/perf/.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-all.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index e1847db6f8e63750..2df593593b6ec15e 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -150,10 +150,6 @@
 # include "test-libtraceevent.c"
 #undef main
 
-#define main main_test_libtracefs
-# include "test-libtracefs.c"
-#undef main
-
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -187,7 +183,6 @@ int main(int argc, char *argv[])
 	main_test_reallocarray();
 	main_test_libzstd();
 	main_test_libtraceevent();
-	main_test_libtracefs();
 
 	return 0;
 }
-- 
2.49.0

