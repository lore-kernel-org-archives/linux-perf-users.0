Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298DC9463;
	Wed, 24 Jun 2026 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782259535; cv=none; b=JiqmolMo0NYHXFQ6djnf8lB2sWoL739Wjc5XnPWlp87rVVFJ/ZGm3p0X3uEqu4MzZggZKa+T83Ae2trbJBvzb0ekn6gZsSyFSe9XrKfkpy/kZM4CQxTgcPMtkavzhudS60y60Iqv6JfbN8/9lBAttuyZzKKlrBnFPeuXs4E4REs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782259535; c=relaxed/simple;
	bh=tseaaar3FgzOfHVbjsRg/rQIFhUw7ULHsr776xtTwPY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ojeKTDeMMFzcaYt1q26JrNK5IfzraFH45wn6DYt97jxn6wTK2X0pz2Izajes8SdNbmNN5ICpZxQWGN35CjGm9gUQFTuh8qjaJ+SGDLcIRh0TasQf8H9kjwOF32w/zo14qJ0WK3HnQBRzkVL3pANuPLbie3M4jAS1fcRcOI+oCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLMH1QXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLMH1QXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322B11F000E9;
	Wed, 24 Jun 2026 00:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782259533;
	bh=enO2id2p+i9jMoKe0el4j29yxZLGsPLm04Pp9vqp1II=;
	h=Date:From:To:Cc:Subject;
	b=kLMH1QXRcw5gG7kQbdiLURxUwBQ2nau+hE7EPjvWnhVhkqWZLX3l35bRgh68Xc6/1
	 alRJdkB8DILmYpdYw00rB59PN0+ZY2vSsQAnwI5uhosC/MJMUYOlgYRQdzz+AKi1E8
	 TE7S6ydYN9AMAv9RIHti206aEKbFCRcDX2hjXbPVy5Raxw6F8YHpPi730FBi2JO9co
	 fhBmQNvEp6dDZcwOmDa+9/jTyaJmnLroRD+tFA3uP8XSXsykTnEXk+AusR2y1JcWr3
	 Tro6ipqOeDBlqXzHcCeVSBtUZou5yiKUka79IUg0JJDHwHu8DItVhdcSYqxnT8CPQE
	 W3qsQ+naG3d6Q==
Date: Tue, 23 Jun 2026 21:05:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf bench bpf: Add missing .gitignore file
Message-ID: <ajsfSkRm0T7J2eF3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

	I'll have this in the next pull req if you prefer not to merge
now,

- Arnaldo

---
From: Arnaldo Carvalho de Melo <acme@redhat.com>

In 713eeb2279402758 ("perf build: Move BPF skeleton generation out of
Makefile.perf") the bpf_skel used with 'perf bench uprobe' was moved
from tools/perf/util/bpf_skel/ to tools/perf/bench/bpf_skel.

Copy tools/perf/util/bpf_skel/.gitignore to that new directory so that
files generated during build get ignored by git.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 713eeb2279402758 ("perf build: Move BPF skeleton generation out of Makefile.perf")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/bpf_skel/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/perf/bench/bpf_skel/.gitignore

diff --git a/tools/perf/bench/bpf_skel/.gitignore b/tools/perf/bench/bpf_skel/.gitignore
new file mode 100644
index 0000000000000000..cd01455e1b53c3d9
--- /dev/null
+++ b/tools/perf/bench/bpf_skel/.gitignore
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+.tmp
+*.skel.h
+vmlinux.h
-- 
2.54.0

