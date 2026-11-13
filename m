Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582398;
	b=nJaoO0JDT1OMcsWor29KquUmEEMmGc26lnMLORZLKu+xEXIRNe6n6LcbwKGafpUV4YFD
	 qcCahTHy7sp86UU9rdgKcLyk9277ps8KsPx7GhHLyTVC6NzuYe9rZfy5ztYGyuFFx+KNC
	 D/XRhngtNca5OxhsiauBJ1i5UzWboRigMsM64AEvMgagZSdFyrP6J9b0qvDVXRb/u8adC
	 E6rqOROM2ToKzxOqCLwYZWel+VEzg9GhD1svzovt6vhs0kF7jPeuFNecdOqln6nfYRaPP
	 hvhpdv79u7KX72bLMKpeLHbJhJi63CHIWIEnhnziHu5r/S4BxMr7U6GHowOZUMdJ0Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582398;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XTEJgb4bW15e0G6borSoOz5hL2cQ4aFnQuarafK2D6s=;
	b=0EKMD6oiZ8pKjEfW944u+N5Y0eUxWcvVhtOa7Y2XEQQ59Nia+i+iAnKlHoS5TgsKpgH0
	 IjhkClTA2BhIHPtlHqjJj6+E4TqrszCYlWqgraNx8MiMW+hyCPP6kOwzKOQLok6B+RmVQ
	 GzKjQb8MfiVFTcsGL1LUuAl5l4CkQnLHKdOc+ZuXN44fMslNo3PzVteOIen/Nwb+5V+No
	 z3Tif7r2e1hinNPfUzZ8gSOzRARQ1fHcb0gU9lsTrTEAPXL/ziQqAfQKJg3uDYHk4mcec
	 ZK7CS8M24YL85Qy1wfykRVizPd7gBCg28KY5iQenTP01C4LhDN10bsnQR9IImv22Wqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vw+f8fDE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D9606A8A2;
	Fri, 13 Nov 2026 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vw+f8fDE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712EA1F000D1;
	Fri, 13 Nov 2026 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582397;
	bh=XTEJgb4bW15e0G6borSoOz5hL2cQ4aFnQuarafK2D6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vw+f8fDExoSVoWizuM66ZaJmUltw+0QtAD+Um98R30em5sXigN9a+DUNos3r04sfg
	 OPCtFWcHeCR1a4ekXzHzqSiw4YnOmBwlVyEBKsJdkR6wGGb+9hgIFxJegngvsM/s3H
	 iaUFurSoEgpJyk1FtVJvW0UD8L9ohOdFlb5lT3+RpfQxg35iYp6qqBJETJO8Pmt7XL
	 6VYzvC383YFakEHnYeyU++DLU73P2xngdJH0JQRqjso+aKd4agM46di/64ugXYYNdz
	 I7v8N3hOZ88QwCGMrxlzKbv7+kyznvABJTHsIq/Ns0YHiGnsp0O2vcWqNUsh6gXM/R
	 rIeiWY0556MvA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v1 12/12] perf test: Skip the LBR inline unwinding check when unsupported
Date: Fri, 13 Nov 2026 12:05:53 -0300
Message-ID: <20261113150555.1163049-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113150555.1163049-1-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The check only looks for the PMU's caps/branches file before recording
with --call-graph lbr.  AMD BRS advertises branches but only samples its
own retired branches event, so the record with cycles is rejected and
the test fails instead of skipping.

Probe the record and skip when it fails, as the branch stack test does.

Fixes: 54a23bff770961e0 ("perf test: Test addr2line unwinding works with inline functions")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index e8754ef2d7f21ac2..6fe47909dae4f812 100755
--- a/tools/perf/tests/shell/addr2line_inlines.sh
+++ b/tools/perf/tests/shell/addr2line_inlines.sh
@@ -71,7 +71,14 @@ test_lbr() {
     fi
 
     # Record data. Currently only dwarf callchains support inlined functions.
-    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf test -w inlineloop 1
+    # Some PMUs advertise branches but reject branch sampling for cycles, e.g.
+    # AMD BRS, which only samples its own retired branches event.
+    if ! perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- \
+            perf test -w inlineloop 1 2>/dev/null
+    then
+        echo "Skip: LBR not supported by the PMU"
+        return
+    fi
 
     # Check output with inline (default) and srcline
     perf script -i "${perf_data}" --fields +srcline > "${perf_script_txt}"
-- 
2.56.0

