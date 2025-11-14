Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F52EB5CE;
	Fri, 14 Nov 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763147005; cv=none; b=o1jLrs+YAiSsUHG+YUVp98pr6m6+qz81qNJxORwC222/TSyISJLZp+DEFU1ypfXwx5zpXtlf+CvzqPjmguVhbg/Ozh8OGfKLUJLaByTaA87p1LB7UWjnbsHIK9e0hu0zsEumtP3Dq3vu0Cjx0zw0SGIEQggxuVkd+b4P67LV5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763147005; c=relaxed/simple;
	bh=I4cSupUj1yArQFO8j1TCBB0/g4NCXS877IPEVCWSoLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctP16LWeankZjy4RwKNvxOMGpIgGwlgthQmkxuXi6sN2nJCyeb6YJa6+UTQ0MMit0C8qkNK40EvID+Lzp9ybWF14ETtUggZ705GFJ+AsNfYTEMijXKI44tSYG5k9cVgqJKWN7f/rX/5nUyC9jb5Hx7YBKgIh6HVu0K9mMt5Vi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQKSbZqN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQKSbZqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DC6C113D0;
	Fri, 14 Nov 2025 19:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763147005;
	bh=I4cSupUj1yArQFO8j1TCBB0/g4NCXS877IPEVCWSoLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQKSbZqNUvwki5F6jHL4I1rbKp1a2uZkPOyno1R7vn2giJMLL2XFOqLxCvf5wtSAO
	 ijhLgcnoJrxVM/iy9bsR+alcglMAbf8LLbHzCx+8gQ/Lhar4mL+RnXMQaLqA5DFXG+
	 FnW3idINe1hZe40IbZlP+E1vlEBNOQV3Yx5iaPB2yjios9M3wGWsYUoxbWwELWabnh
	 eD7ZDCJt0k+Dpoc1CKY2FZs9BcxDH3C5n1DkD247jnkyVNBYxFzilrp3mIPPRUY/0l
	 jGwq/W3L1xnAUH6jfqH/9tHleqk/3oQ+fzgiRP8xYPlxP3A9VufTCHu1bZ7//wjKuf
	 O9jBV0E9NXW3A==
Date: Fri, 14 Nov 2025 11:03:23 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Pablo Galindo <pablogsal@gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add python JIT dump test
Message-ID: <aRd8-4e5apdL7R6Z@google.com>
References: <20251114092914.217533-1-namhyung@kernel.org>
 <20251114092914.217533-2-namhyung@kernel.org>
 <CAP-5=fWLGQJ+jdc1kqSo0+wy6AVa2Dm-yp7OX8q+bNw94aV3FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWLGQJ+jdc1kqSo0+wy6AVa2Dm-yp7OX8q+bNw94aV3FA@mail.gmail.com>

On Fri, Nov 14, 2025 at 09:44:21AM -0800, Ian Rogers wrote:
> On Fri, Nov 14, 2025 at 1:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add a test case for the python interpreter like below so that we can
> > make sure it won't break again.  To validate the effect of build-ID
> > generation, it adds and removes the JIT'ed DSOs to/from the build-ID
> > cache for the test.
> >
> >   $ perf test -vv jitdump
> >    84: python profiling with jitdump:
> >   --- start ---
> >   test child forked, pid 214316
> >   Run python with -Xperf_jit
> >   [ perf record: Woken up 5 times to write data ]
> >   [ perf record: Captured and wrote 1.180 MB /tmp/__perf_test.perf.data.XbqZNm (140 samples) ]
> >   Generate JIT-ed DSOs using perf inject
> >   Add JIT-ed DSOs to the build-ID cache
> >   Check the symbol containing the script name
> >   Found 108 matching lines
> >   Remove JIT-ed DSOs from the build-ID cache
> >   ---- end(0) ----
> >    84: python profiling with jitdump                                   : Ok
> >
> > Cc: Pablo Galindo <pablogsal@gmail.com>
> > Link: https://docs.python.org/3/howto/perf_profiling.html#how-to-work-without-frame-pointers
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/shell/jitdump-python.sh | 41 ++++++++++++++++++++++++
> >  tools/perf/tests/shell/jitdump-test.py   | 14 ++++++++
> >  2 files changed, 55 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/jitdump-python.sh
> >  create mode 100644 tools/perf/tests/shell/jitdump-test.py
> >
> > diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/shell/jitdump-python.sh
> > new file mode 100755
> > index 0000000000000000..101c15e65da1a0c0
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/jitdump-python.sh
> > @@ -0,0 +1,41 @@
> > +#!/bin/bash
> > +# python profiling with jitdump
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +if ! command -v python > /dev/null; then
> > +    echo "Skip: no python found"
> > +    exit 2
> > +fi
> 
> Can this just reuse the python set up logic in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/lib/setup_python.sh?h=perf-tools-next

Will do!

> 
> > +
> > +SHELLDIR=$(dirname $0)
> > +PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXXX)
> > +
> > +echo "Run python with -Xperf_jit"
> > +perf record -k 1 -g --call-graph dwarf -o "${PERF_DATA}" -- python -Xperf_jit ${SHELLDIR}/jitdump-test.py
> 
> We can avoid an additional file by using the REPL, this is why the
> java test is using jshell:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/test_java_symbol.sh?h=perf-tools-next#n41

I thought that too, but I wanted a filename to check the result.
Hmm.. probably I can use a different pattern without it.

> 
> > +
> > +_PID=$(perf report -i "${PERF_DATA}" -F pid -q -g none | cut -d: -f1 -s)
> > +PID=$(echo -n $_PID)  # remove newlines
> > +
> > +echo "Generate JIT-ed DSOs using perf inject"
> > +perf inject -i "${PERF_DATA}" -j -o "${PERF_DATA}.jit"
> 
> Thomas Richter did a workaround in the Java version to avoid debuginfod queries:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/test_java_symbol.sh?h=perf-tools-next#n59

Yep, will add.

> 
> > +
> > +echo "Add JIT-ed DSOs to the build-ID cache"
> > +for F in /tmp/jitted-${PID}-*.so; do
> > +  perf buildid-cache -a "${F}"
> > +done
> > +
> > +echo "Check the symbol containing the script name"
> > +NUM=$(perf report -i "${PERF_DATA}.jit" -s sym | grep -c jitdump-test.py)
> > +
> > +echo "Found ${NUM} matching lines"
> > +
> > +echo "Remove JIT-ed DSOs from the build-ID cache"
> > +for F in /tmp/jitted-${PID}-*.so; do
> > +  perf buildid-cache -r "${F}"
> > +done
> > +
> > +rm -f ${PERF_DATA} ${PERF_DATA}.jit /tmp/jit-${PID}.dump /tmp/jitted-${PID}-*.so
> 
> It'd be nice to have this in a function that also gets run if there is
> a trap. It looks like the Java test is missing a call to cleanup_files
> on the success path.

I thought that it will go the end of the script regardless of any
command failures but we should protect it from Ctrl-C as well.. ok.

Thanks for your review!
Namhyung

> 
> > +
> > +if [ "${NUM}" -eq 0 ]; then
> > +    exit 1
> > +fi
> > diff --git a/tools/perf/tests/shell/jitdump-test.py b/tools/perf/tests/shell/jitdump-test.py
> > new file mode 100644
> > index 0000000000000000..b427363ae4956db6
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/jitdump-test.py
> > @@ -0,0 +1,14 @@
> > +def foo(n):
> > +    result = 0
> > +    for _ in range(n):
> > +        result += 1
> > +    return result
> > +
> > +def bar(n):
> > +    foo(n)
> > +
> > +def baz(n):
> > +    bar(n)
> > +
> > +if __name__ == "__main__":
> > +    baz(1000000)
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
