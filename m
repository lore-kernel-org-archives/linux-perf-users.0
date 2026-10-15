Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9649F113;
	Thu, 15 Oct 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070302; cv=none; b=iPQu8niNxpLj9X034wBdHbfg5y+yX/wnVFKrrltVJ1lhvT32lU3rxevGe6zoDHn+QaV+rqzMIuyYFL0Q7q2Kj/u4BlMg4RrnbUCKhe4BdmToMVRQw3Rlmc7Mc3/p2VjD2fmQnVQHO8eRWsxdrHDdRMKbemiLPGcwXSDAXYG3+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070302; c=relaxed/simple;
	bh=VTQc32GL1c5ToZ48riNhFl2dWw3MkiwvpNZMasHijUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFmIo9HXjERXc+/oRT2TQGLKkCPJFO/ucNwYqCVTBnYyt05qFF8Fhs3rEzSd4ABFxAf74xHnzhXPPT3L8oQjLCBXwigfWON+Q/l3opiwJRbkH6nIqPq6nI/6CQ8NNP2yxb5WgXawjNDNKVPNDJWt5K7iMP6uPCptcQO86DkoKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zxfa/qmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zxfa/qmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA261F000C5;
	Thu, 15 Oct 2026 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070300;
	bh=Zl59TwabPHkvXXpBgkYuYfddVBknp3IKvZWbg/5f6s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zxfa/qmCrbcdDe0Cz9KaaRRJ3xR/OrMVqKxwo1FcFjhsPDIIyKvrFJcR3M4YBbOw/
	 3QeevE5mBRp/qLp0cLkjivADcPeABgmI0zPgiCijBt5UwXDZqmAp6R9N3Bzx2OrNH4
	 dBxDG/rurGzvygdSiW5pBTb5CzVS+yDZ1coEG5cQH63H56RBuRHVFOQgT7zSgKu1Ve
	 iSdkFpv1/CKgre9RABT3RiPAi1thB+enlhZ037KSqwfJo0X/1tLiad8w3KEaHfeu8p
	 1x1xRy3DbWgNMcUuI6FQwewsjp6vXMkbKXhvkiXjftRadYgJg6AezlLY2yvclqaYL2
	 /5cr8tLdmUYWg==
Date: Thu, 15 Oct 2026 10:18:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 07/11] perf tools: Factor out dso__find_binary_type()
Message-ID: <atDSmfwd4v_oLg4m@x2>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-8-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013172155.160869-8-namhyung@kernel.org>

On Tue, Oct 13, 2026 at 10:21:51AM -0700, Namhyung Kim wrote:
> Separate out the logic to detect binary type of a DSO.  It checks if
> the candidate file contains ".text" section.  There could be data-only
> DSOs but as our use cases focus on the code (perf annotate or intel
> PT), we can ignore them for now.
 
> But it also can fail due to open file limit.  Handle the case by
> retrying with _dso__data_open_lock.
 
> Introduce bintype_searched flag and it accessors to prevent repeated
> (failed) search.

This one, when compiled with clang, catch this in all my build
containers:

  LD      /tmp/build/perf-tools-next/tests/perf-test-in.o
util/dso.c:942:7: error: mutex '_dso__data_open_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  942 |                 if (dso__data_open_cnt) {
      |                     ^
util/dso.c:940:4: note: mutex acquired here
  940 |                         mutex_lock(dso__data_open_lock());
      |                         ^
util/dso.c:942:7: error: reading variable 'dso__data_open_cnt' requires holding mutex '_dso__data_open_lock'   CC      /tmp/build/perf-tools-next/util/maps.o
[-Werror,-Wthread-safety-analysis]
  942 |                 if (dso__data_open_cnt) {
      |                     ^
util/dso.c:943:4: error: calling function 'close_first_dso' requires holding mutex '_dso__data_open_lock' exclusively [-Werror,-Wthread-safety-analysis]
  943 |                         close_first_dso();
      |                         ^
util/dso.c:949:3: error: releasing mutex '_dso__data_open_lock' that was not held [-Werror,-Wthread-safety-analysis]
  949 |                 mutex_unlock(dso__data_open_lock());
      |                 ^
4 errors generated.
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:95: /tmp/build/perf-tools-next/util/dso.o] Error 1
  CC	  /tmp/build/perf-tools-next/util/thread.o

perf adds -Wthread-safety for clang builds (tools/perf/Makefile.config),
so it is -Werror there.

This is because __dso__find_binary_type() takes _dso__data_open_lock only
on the first retry, under needs_open_lock, and then reads
dso__data_open_cnt and calls close_first_dso(); with the lock taken
conditionally the analyzer can't see it held on every path.  And for the
try_to_open_dso() caller, which already holds it, the requirement was
only implicit, the helper had no annotation for clang to check.

I've folded the following into the patch, see if it is acceptable:

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 47241077ad26..8f274b8b1030 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -925,7 +925,8 @@ static int dso__find_binary_type_locked(struct dso *dso)
 }
 
 #define FIND_MAX_RETRY  3
-static int __dso__find_binary_type(struct dso *dso, bool needs_open_lock)
+static int __dso__find_binary_type(struct dso *dso)
+	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 {
 	int ret;
 	int retry = 0;
@@ -936,18 +937,12 @@ static int __dso__find_binary_type(struct dso *dso, bool needs_open_lock)
 	mutex_unlock(dso__lock(dso));
 
 	if (ret == -1 && retry++ < FIND_MAX_RETRY) {
-		if (needs_open_lock && retry == 1)
-			mutex_lock(dso__data_open_lock());
-
 		if (dso__data_open_cnt) {
 			close_first_dso();
 			goto again;
 		}
 	}
 
-	if (retry > 0 && needs_open_lock)
-		mutex_unlock(dso__data_open_lock());
-
 	if (ret == -1) {
 		mutex_lock(dso__lock(dso));
 		ret = dso__binary_type(dso);
@@ -961,7 +956,13 @@ static int __dso__find_binary_type(struct dso *dso, bool needs_open_lock)
 
 enum dso_binary_type dso__find_binary_type(struct dso *dso)
 {
-	return __dso__find_binary_type(dso, /*needs_open_lock=*/true);
+	int ret;
+
+	mutex_lock(dso__data_open_lock());
+	ret = __dso__find_binary_type(dso);
+	mutex_unlock(dso__data_open_lock());
+
+	return ret;
 }
 
 static void try_to_open_dso(struct dso *dso, struct machine *machine)
@@ -972,7 +973,7 @@ static void try_to_open_dso(struct dso *dso, struct machine *machine)
 	if (dso_data->fd >= 0)
 		return;
 
-	__dso__find_binary_type(dso, /*needs_open_lock=*/false);
+	__dso__find_binary_type(dso);
 	dso_data->fd = open_dso(dso, machine);
 
 	if (dso_data->fd >= 0)

__dso__find_binary_type() now requires _dso__data_open_lock, the public
dso__find_binary_type() takes it around the call, and the needs_open_lock
parameter goes away.  try_to_open_dso() stays as is: it is annotated
EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock), its four call sites take
the lock first, and now clang checks the whole chain.

The patches I took (v5 07/11 onward) build with clang 22.1.8 here and
'perf test dso' passes (read, cache, reopen), so please fold something
like this if you respin, or let me know if you'd rather have it done
differently.

Regards,

- Arnaldo
