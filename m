Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F34A998
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3WmLLwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B9BC433C7;
	Thu, 30 Nov 2023 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701381245;
	bh=F2LL2tyOMkM/IejxRX2kitlYZIvwjcdRDFnefjDcVMo=;
	h=Date:From:To:Cc:Subject:From;
	b=L3WmLLwKh6NeT6J3aFK04LeUyBmhvgtceb3N2UdBsAEFPqpkZOB3zyvWbbw+Hq4Dc
	 Rli7HkGd9iISYnWSlPmGAX/r/ehPthTjh5wnA5j+cCqVhqusdbfZwh+olX93f86CcF
	 5PkcEYEUKjHoFDRP4roToQ7yNujOT5CKQfu1TaIh0YzjqonF8s2RNdOFEVNWS1KTEf
	 9v/YABzrUPxHCJqioVWp+6b0MeCqNTKv9bgAGY8w/O+y2dLO3XzYOLUNowwo3v0qTw
	 Bf631bglYGUt7OF2TAsMIHeJzu7Ho2Ug+d+Ykud+wUw675mpTPoiRGcGho9S++mzBA
	 qqmBHRAf7rnDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id CF8D940094; Thu, 30 Nov 2023 18:54:02 -0300 (-03)
Date: Thu, 30 Nov 2023 18:54:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it isn't
 available in busybox
Message-ID: <ZWkEeqdmCHMLhLr2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Namhyung reported:

  I'm seeing a build error on my Alpine linux image which uses busybox +
  musl libc:

    In file included from trace/beauty/arch_errno_names.c:1,
                     from builtin-trace.c:899:
    /build/trace/beauty/generated/arch_errno_name_array.c: In function 'arch_syscalls__strerrno':
    /build/trace/beauty/generated/arch_errno_name_array.c:142:49: error: unused parameter 'arch' [-Werror=unused-parameter]
      142 | const char *arch_syscalls__strerrno(const char *arch, int err)

  It looks like busybox find command doesn't have -printf option

    find: unrecognized: -printf
    , Yesterday 9:16 PM
    ,
    BusyBox v1.36.1 (2023-07-27 17:12:24 UTC) multi-call binary.

    Usage: find [-HL] [PATH]... [OPTIONS] [ACTIONS]

    Search for files and perform actions on them.
    First failed action stops processing of current file.
    Defaults: PATH is current directory, action is '-print'

So just remove it and pipe find's entry to a basename loop to produce
the same result.

Fixes: 0337cf74ccf2a434 ("perf util: Introduce architecture specific errno/name mapping")
Reported-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/arch_errno_names.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index cc09dcaa891e04bb..3ec8781344db13ba 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -76,7 +76,7 @@ EoHEADER
 
 # Create list of architectures that have a specific errno.h.
 archlist=""
-for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort -r); do
+for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d | while read arch ; do basename $arch ; done | sort -r); do
 	test -f $toolsdir/arch/$arch/include/uapi/asm/errno.h && archlist="$archlist $arch"
 done
 
-- 
2.41.0

