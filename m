Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546000;
	b=GUYXWrJWeEQ3jRKqa3PIQXmvlcM52nFGvUFkeA6JI8L5OHMYgQ8+U/d8L4Q1PxAaRIFs
	 F1hL6+44Le4y00AVLR/p00CufKERDbuxp5fNeregj7hOvjdSQJi8XMU1OFYfNgnw38aFn
	 YvKYjGZ2U7ONqSKItyZyxAmPj1X7ubRgigLjgHC7RaOCi3Q6GAkSWhTz8EidcgnEayT2S
	 fmrxs/Fv1V1B2JMNIaoSo1DO7zzZyWvxLQVSodOCkVRRmv38xu6V9gpTjsR6q4r5RtNyN
	 tNM2XeW5I2NEG75Ru8kjt7V6B0vDf9S+0Yn+KiYoOMadlqzL2+Ui/oj9AKYBbgXPtIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546000;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TMiRfIRA0Tu1oy6Htb3mclDEbrrcXq0iN4bugKXLH94=;
	b=GBMct+CAR08apFg34lR4Cc0p7lAI4C+fs1t1hFs1fQ/MphYcRaNDclpGprTjFv/afpE9
	 MRGlpTrkHjqQlzfuhcSnvg/x/j8bj/qh8ekC887f4gFuJ4XN6iaJs8wX7wlzbHdge7cG0
	 IqRjj1atN+rkoS76B104RN4grhxtqqomuBxw4p7Eg2hO3QIymiOsM7aziH4s2rQ/hXDXq
	 JxndifUQHlVzvc0/zzGC0EnMhwNbSLlCR1mTxaUJ1DHmlKoFese2AYFEM8wuYl41wY9S4
	 X0Qg7fnvG5z29BWOWGfKyHL3HZ43SJNCCQZxtwRfLgPN/n5bw7NXJ1SWgBwF0MLh/WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPjZ5wit;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9975606A31E;
	Tue, 24 Nov 2026 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPjZ5wit
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE5C1F000E6;
	Tue, 24 Nov 2026 18:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546000;
	bh=TMiRfIRA0Tu1oy6Htb3mclDEbrrcXq0iN4bugKXLH94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oPjZ5witn57YmGK1M3joexTw+O1+ta9k6gpKwUjnz4zaSP6S/OQyA0Xqb9FOjtYYb
	 RDWfvJu2e5e01qU6exEVrMfVyPpiZWQ7FAjwQG9sciAr5zYfP1wEa2swEWXMIEQtqg
	 buDfHWaWdhIzVvNF8+F0U91jb7SwfiCHC24Z2uuMY7Mrn0pwnCJvGhb2UqM8vpOMYj
	 IjJjtsoO5YHlxxGuUZfSz34H0p4PDT5u/FAewAGOcoEQ/q3yzyqaedLOYNoYhZW6dL
	 Jivhyo1zbF/TJi4iyFzX/PvnBlbwsSq9oBPyKoYHsIsAMWvlo7+PqzGqkXCI32IReS
	 Mb1JRxTr8sPdg==
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
Subject: [PATCH v1 08/17] perf tests annotate: Exercise the output and filter options
Date: Tue, 24 Nov 2026 15:45:55 -0300
Message-ID: <20261124184604.24983-9-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124184604.24983-1-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
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

The annotate test covers the stdio and pipe modes.  Add the --stdio2
output, --print-line, --asm-raw with --show-total-period,
--show-nr-samples, --percent-type and the DSO filter, the last one
checked by also annotating through a DSO that is not in the data.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/annotate.sh | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 26411edf5cb4ece1..d799414690402fc0 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -105,8 +105,72 @@ test_basic() {
   echo "${mode} annotate test [Success]"
 }
 
+test_options() {
+  echo "Options annotate test"
+  perf record -o "${perfdata}" ${testprog} 2> /dev/null
+
+  # --stdio2 prints each instruction with the symbol header
+  if ! perf annotate -i "${perfdata}" --stdio2 -s "${testsym}" 2> /dev/null | grep -q "${testsym}()"
+  then
+    echo "Options annotate [Failed: missing --stdio2 output]"
+    err=1
+    return
+  fi
+
+  # -l/--print-line prints a summary of the annotated file with source lines
+  if ! perf annotate -i "${perfdata}" --stdio --print-line -s "${testsym}" 2> /dev/null | grep -q "Sorted summary for file"
+  then
+    echo "Options annotate [Failed: missing --print-line output]"
+    err=1
+    return
+  fi
+
+  # --show-total-period adds a period column; --asm-raw is the default
+  if ! perf annotate -i "${perfdata}" --stdio --asm-raw --show-total-period -s "${testsym}" 2> /dev/null | grep -q "Period"
+  then
+    echo "Options annotate [Failed: missing --show-total-period output]"
+    err=1
+    return
+  fi
+
+  # --show-nr-samples adds a samples column
+  if ! perf annotate -i "${perfdata}" --stdio -n -s "${testsym}" 2> /dev/null | grep -q "Samples"
+  then
+    echo "Options annotate [Failed: missing --show-nr-samples output]"
+    err=1
+    return
+  fi
+
+  # --percent-type selects the percentage type shown in the header
+  if ! perf annotate -i "${perfdata}" --stdio --percent-type global-period -s "${testsym}" 2> /dev/null | grep -q "percent: global period"
+  then
+    echo "Options annotate [Failed: missing --percent-type output]"
+    err=1
+    return
+  fi
+
+  # -d limits the annotation to the given DSO: perf has the symbol, a
+  # DSO absent from the data produces no annotation
+  if ! perf annotate -i "${perfdata}" --stdio -s "${testsym}" -d perf 2> /dev/null | grep -q "Disassembly of"
+  then
+    echo "Options annotate [Failed: missing -d output]"
+    err=1
+    return
+  fi
+
+  if perf annotate -i "${perfdata}" --stdio -s "${testsym}" -d nonexistent-dso 2> /dev/null | grep -q "Disassembly of"
+  then
+    echo "Options annotate [Failed: -d did not filter the DSO]"
+    err=1
+    return
+  fi
+
+  echo "Options annotate test [Success]"
+}
+
 test_basic Basic
 test_basic Pipe
+test_options
 
 cleanup
 exit $err
-- 
2.56.0

