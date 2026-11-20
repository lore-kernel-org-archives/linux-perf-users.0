Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138399;
	b=ARjEPsSBZ5HeZr/+kSZWslVmxfuZf4s4k57hMjoOjEZhnNp4odaRem7Rdcs5ua8Lmf89
	 owgGNwZUEKGLMTBmc5pJXKC4qnAXhcWYvJ4MdgzwaRQxv8usu/3mZ7C7wwOPSclEjIlb0
	 nn2gkVjpeNvm5zpk6aCvWw+OAm4XTMvO8rG7MFokpIi84RxinoWpVUNnwW7lRgqWT60ej
	 yZDmlb8/+PSvleoN8fAIP/TdOmxNX6kOeZFWPneFH2N03w1/JoA8qOcHEixuyEk+z53SN
	 eYhRodnZ1iKdanega+GmxCIseNtrfvQjojzZESBaLyTe6EVSyNn6sXLkmHZdQnJR9Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138399;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HqdU3TKWtk+QHYDMIs0OjFQmc/8QrMHOsCdFuTPEaI4=;
	b=rnfzr8VHjDXbnE4XqbYR6IITTB8BUpyAu48e7lwZWfYRh7nvIQmX7Q8Hy9//fCJBHNkh
	 tpjp/zf3yi5u/VDWgNwRxdzpEtraJmU8lyaBYrw+lFe/Uz488ykDFlqJpFIphYUKTVmYp
	 eULW3ofRFqJBF0bGoazXM4VMHPD05Hil9736hHGToG4G/oqG6cdQnisEK+GXaNtN9Sml6
	 6XJXp7Ne7XWKumo0MjJCCXjLOwd4Aoonadq1XTirELS8/Rl8IfyN7yHL7WYpxebKyAk9R
	 KYK/4flRsC42JSZqydtpCLLhtWKr+WFqxhqF41Pstqe5KbGfeOsitDwfZnVkf38S/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asVNAi0k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D6606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asVNAi0k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C51F000CF;
	Fri, 20 Nov 2026 01:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138398;
	bh=HqdU3TKWtk+QHYDMIs0OjFQmc/8QrMHOsCdFuTPEaI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=asVNAi0kybe/vv3nLOOP2KIYjRVPlFJvtfgp8NsK3pcl6ae2sCXj5zN+G7EecM9k8
	 iD3omkk8Y+l7KXvcaps4WycxHhk44If0NpJjleiD+5Q8oxo/Wc8sQM0/8CcCC3Kdzb
	 kT792tkRkyaZhvqEvronRXlTq1Eh1mThwUQ/Bb5s8qYorRaxKKwdKD5bcJQHkzlDvy
	 gKZ3vYfeQpCtlOmpkGYxC43t0r9YZCXNf6iHE6hxux7mEYGrPKg0FzjlL4Mw76uqYV
	 Hi4R4SE3sQPG6ewnPC56eFpGlfhy/MBr1asE9t41snVl67OFtr+fY72zCLLUPCh4ib
	 5nVLrzLT9KRcA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 13/13] perf test: Skip the LBR inline unwinding check when unsupported
Date: Thu, 19 Nov 2026 22:32:08 -0300
Message-ID: <20261120013211.1510-14-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120013211.1510-1-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
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

The LBR check takes caps/branches as sufficient to record cycles with
--call-graph lbr, but the file only says the PMU has an LBR: AMD LBRv2
rejects the call stack mode with EOPNOTSUPP and AMD BRS, which samples
only its own retired branches event, rejects cycles with EINVAL, so the
test fails on AMD instead of skipping.

Skip when the same event records without the branch stack, so a PMU
without the LBR call stack skips while a perf record that fails for
another reason still shows its error and fails the test.

Fixes: 446c595dc0dd1759 ("perf test addr2line_inlines: Ensure inline information shows on LBR leaves")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index e8754ef2d7f21ac2..050e95c0fea12aae 100755
--- a/tools/perf/tests/shell/addr2line_inlines.sh
+++ b/tools/perf/tests/shell/addr2line_inlines.sh
@@ -8,6 +8,7 @@ err=0
 test_dir=$(mktemp -d /tmp/perf-test-inline-addr2line.XXXXXXXXXX)
 perf_data="${test_dir}/perf.data"
 perf_script_txt="${test_dir}/perf_script.txt"
+perf_record_err="${test_dir}/perf_record.err"
 
 cleanup() {
     rm -rf "${test_dir}"
@@ -71,7 +72,24 @@ test_lbr() {
     fi
 
     # Record data. Currently only dwarf callchains support inlined functions.
-    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf test -w inlineloop 1
+    # caps/branches does not mean the LBR call stack is supported: AMD LBRv2
+    # rejects it with EOPNOTSUPP and AMD BRS, which samples only its own
+    # retired branches event, rejects cycles with EINVAL. Skip when the same
+    # event records without the branch stack.
+    if ! perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- \
+            perf test -w inlineloop 1 2> "${perf_record_err}"
+    then
+        if perf record -e cycles:u -o "${perf_data}" -- true 2> /dev/null
+        then
+            echo "Skip: LBR call stack not supported by the PMU"
+        else
+            cat "${perf_record_err}"
+            echo "Inline unwinding lbr verification test [Failed to record]"
+            err=1
+        fi
+        return
+    fi
+    cat "${perf_record_err}"
 
     # Check output with inline (default) and srcline
     perf script -i "${perf_data}" --fields +srcline > "${perf_script_txt}"
-- 
2.56.1

