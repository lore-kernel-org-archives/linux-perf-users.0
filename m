Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC4263C88;
	Wed,  9 Apr 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205735; cv=none; b=LM6HSOOtjE4B2HUFRGiHp+ycxJFmfskI8koRfTEITka8ILg325AHoc3eKxeEQnaCVrmh51q1j7lu8LUiwBHAUC/Kvg6ZzvzcRYB7ogHqAZClZlGFaKaTpZYU6RdXT+FwbP1Sc1376AF6v4WmIK+FalVVSsYgtDW0EnhR26PiEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205735; c=relaxed/simple;
	bh=ppKQBnSErD0/u0/gZkEC8eunlb+MMHTwKrkVtk5VMPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z5/GGDKyknzKhk/oE8HqjBMkGpQNQlhiUQnO7BFH/pCMY5JUlHUrhJokp+rpVES3sBQW94v3c4taV6OLR8rVwjaFE8BFbAWUyCUsvc8hLhOkJdvCvY9sW17FPfdhxITR8/kjITKnIm7LlkRl58ZsPqVASmPA41EAba4PR+oVeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH03iG4O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH03iG4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52D9C4CEE3;
	Wed,  9 Apr 2025 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744205734;
	bh=ppKQBnSErD0/u0/gZkEC8eunlb+MMHTwKrkVtk5VMPU=;
	h=Date:From:To:Cc:Subject:From;
	b=QH03iG4OIWAIrsxVDmqy27E/IdlvYOx2XBsEhPF0IzbGagUGr24twZ1wHu/uylC1Z
	 kJoNnBtlH4MUHpn+qYMQb2gbior54U5n8REbI7dV3hJ3hoeOBc+R2OcWZHIwm2JmHY
	 490pBrcTLLNLv3W+qWoOb2oogmvHr8z1/xz1LtZmtwowW5krsUyJ4l2QJVe6EgC3JO
	 MZORVEV5zCfqiee0q/0LDQCHRWvVHuTDujlTjnHMNG5b/Dt88kbBkli+UOEnmAFSrE
	 1lISCPfFQtzlNL404gLIXXUirGs9G/YUK8sZhZyy3CO6QTStn1EKeLvXrimBKdiS3x
	 k70bsNjG4gXww==
Date: Wed, 9 Apr 2025 10:35:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 v6.15-rc1] perf libunwind arm64: Fix missing close parens
 in an if statement
Message-ID: <Z_Z3o8KvB2i5c6ab@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While testing building with libunwind (using LIBUNWIND=1) in various
arches I noticed a problem on arm64, on an rpi5 system, a missing close
parens in a change related to dso__data_get_fd() usage, fix it.

Fixes: 5ac22c35aa8519f1 ("perf dso: Use lock annotations to fix asan deadlock")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 9fb2c1343c7fe205..0b037e7389a009f5 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -371,7 +371,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 	 *    has to be pointed by symsrc_filename
 	 */
 	if (ofs == 0) {
-		if (dso__data_get_fd(dso, machine, &fd) {
+		if (dso__data_get_fd(dso, machine, &fd)) {
 			ofs = elf_section_offset(fd, ".debug_frame");
 			dso__data_put_fd(dso);
 		}
-- 
2.48.1

