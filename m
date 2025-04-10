Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2318A6C4
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249100; cv=none; b=uS2rFcqK6P7/aSDhzBp+pZTJt/DryTveu33iQ1qdyC3ugqLqnaxvCvaIP3W5VV1SvTCDBuLzsvwIqpexJC8p5rUvEBR47KPamci1fwD/t17Sn1RfFZEmRC+8TamR37YJW4ITsZ2rV5IolYDO+d5RqDCJ6ggnHHTZh2JE5WAcvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249100; c=relaxed/simple;
	bh=jqF90+SJIUh0pwpqcaxI1UtPq5M2zIwMZMhfr22J28U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q883x/GgzPUGgurGPvdfjF+EQVifYO1XPOXOQHkX1HTp6fC1kWoNBZS2sD3FFG8RXIG2lUG4diOnJs21VdW03kUkFlUHTn8gumAFJFJ8Q9T2FI6V6g2OQqBYlEQqHoH9OdR95ieD7WoHejv9GzOnz/MGGxbTShJMPfTax+7Hcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVQOjMB6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVQOjMB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B4BC4CEE7;
	Thu, 10 Apr 2025 01:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249099;
	bh=jqF90+SJIUh0pwpqcaxI1UtPq5M2zIwMZMhfr22J28U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVQOjMB6q7oJ5FfqTLqkcsZRuZMvgLSwJBzH+wmRvrAni9XI5kjMdZ6svaR2Fo1Hg
	 F7xW+MGTvDprP71R61egcx4Ew+rIqQ7DboxbIPqwCEf57p+ShCCdSqRF9KKXIzW6Iy
	 ecS0SANEnjRcXU23oVA7por8zfM7N5w/pUwVXxlRHbu0V39I2WGjQpEnw04A2fvYIx
	 kK/r28runf8aYnG9j0fehiMfUhWo6z1vr1m86bOJ18pdccbotnlm54ImSb2HKFJiOf
	 uHqAxQqiART6cI0eITO1pR+z0miBe9nGQlhIfkvukmO0d/deqsEg0VbJhKYB6ruUmW
	 CQHtA9SPgBoMw==
Date: Wed, 9 Apr 2025 22:38:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_chCGYb1_hMS1F9@x1>
References: <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_TYux5fUg2pW-pF@gmail.com>
 <Z_XaOp4TCBKe-M0o@x1>
 <Z_ZltdaHx9XuKcd9@x1>
 <Z_aY0fTs53id77CS@x1>
 <Z_bHtD7umCsKeWJ6@x1>
 <Z_bI7wK8mJYVOWDH@x1>
 <Z_bl8tabAwfqKuy-@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_bl8tabAwfqKuy-@gmail.com>

On Wed, Apr 09, 2025 at 11:26:10PM +0200, Ingo Molnar wrote:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Using 't' to zoom into a thread and then LEFT to zoom out works, ditto
> > for 'd' + LEFT, 'k' (zoom into the kernel) + LEFT its just 'm' + thread
> > or ENTER + Zoom into Thread that isn't working...

> > Not even that, there is something subtle, investigating.

> > But as a suggestion, pressing 't' zooms into a thread, pressing it again
> > zooms out of that thread, rinse repeat.

> Indeed, this works it around. It's not *that* easy though: 't' goes 
> into thread view, but has to be pressed another 3(?) times to get back 
> to the previous non-threaded view again.

> > Ditto for 'd' for DSO and 'k' for the kernel DSO, 'S' for a CPU socket
> > (Kan Liang implemented this, but not for 'c' CPU, will try to add that).

> > Anyway, back to the bug.
 
> Thanks for having a look! :)

I guess I found it, another one-liner (well, two if you count removing a
comment line) with a long explanation, see below.

There is a tidy up patch before this, all is at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-annotate+build

So far:

⬢ [acme@toolbox perf-tools-next]$ git log --oneline v6.15-rc1..
4af32d73e850cb2c (HEAD -> perf-tools-next) perf ui browser hists: Set actions->thread before calling do_zoom_thread()
caab12ee523ccf7c perf ui browser hists: Simplify the routines that add entries to the popup menu
dd2ca9ca0d76a04b perf ui browser: Accept the left arrow key as a Zoom out if done on the first column
6b4e380deb02de46 perf ui browser annotate: Don't show the source code view status initially
befd9928ac3b0914 perf ui browser annotate: Show in the title the source code view toggle
6c557247d907487e perf ui browser map: Provide feedback on unhandled hotkeys
dcee76bd1ef37cd5 perf ui browser hists: Provide feedback on unhandled hotkeys
7cd3b61be22b6111 perf ui browser header: Provide feedback on unhandled hotkeys
4226b944d6cfec62 perf ui browser annotate: Provide feedback on unhandled hotkeys
96f43ea8e198b9cd perf ui browser annotate-data: Provide feedback on unhandled hotkeys
1101a930a674936a perf ui browser: Add a warn on unhandled hotkey helper
bdd6ce8eb8c2f2f7 perf ui browser: Add key_name() helper
65185f2cf7af5026 tools build: Don't show libbfd build status as it is opt-in
33da8804f7c00056 perf check: Add tip about building with libbfd using BUILD_NONDISTRO=1
da4de82814f54c6c perf build: Warn when libdebuginfod devel files are not available
d5f1c3eb842aaafe tools build: Don't show libunwind build status as it is opt-in
6cf8fa4dcce720f9 perf check: Allow showing a tip for opt-in features not built into perf
07f8bc136355d09a perf check: Move the FEATURE_STATUS() macro to its only user source file
a3fb01a0d062d9f4 perf check: Share the feature status printing routine with 'perf version'
c2bc1a34f2488b7f tools build: Don't set libunwind as available if test-all.c build succeeds
⬢ [acme@toolbox perf-tools-next]$

I'm starting to take a look at:

⬢ [acme@toolbox git]$ head -5 ./llvm-project/llvm/tools/llvm-objdump/SourcePrinter.h
//===-- SourcePrinter.h -  source interleaving utilities --------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
⬢ [acme@toolbox git]$

:-)

- Arnaldo

From 4af32d73e850cb2c0c1679a0d30a65d8d5f4222d Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 9 Apr 2025 21:58:19 -0300
Subject: [PATCH 1/1] perf ui browser hists: Set actions->thread before calling
 do_zoom_thread()

In 7cecb7fe8388d5c3 ("perf hists: Move sort__has_comm into struct
perf_hpp_list") it assumes that act->thread is set prior to calling
do_zoom_thread().

This doesn't happen when we use ESC or the Left arrow key to Zoom out of
a specific thread, making this operation not to work and we get stuck
into the thread zoom.

In 6422184b087ff435 ("perf hists browser: Simplify zooming code using
pstack_peek()") it says no need to set actions->thread, and at that
point that was true, but in 7cecb7fe8388d5c3 a actions->thread == NULL
check was added before the zoom out of thread could kick in.

We can zoom out using the alternative 't' thread zoom toggle hotkey to
finally set actions->thread before calling do_zoom_thread() and zoom
out, but lets also fix the ESC/Zoom out of thread case.

Fixes: 7cecb7fe8388d5c3 ("perf hists: Move sort__has_comm into struct perf_hpp_list")
Reported-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/Z_TYux5fUg2pW-pF@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 0db2a3f06e23cc5a..cf022e92d06b9b28 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3264,10 +3264,10 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 				/*
 				 * No need to set actions->dso here since
 				 * it's just to remove the current filter.
-				 * Ditto for thread below.
 				 */
 				do_zoom_dso(browser, actions);
 			} else if (top == &browser->hists->thread_filter) {
+				actions->thread = thread;
 				do_zoom_thread(browser, actions);
 			} else if (top == &browser->hists->socket_filter) {
 				do_zoom_socket(browser, actions);
-- 
2.48.1

