Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231305;
	b=SWjdHg1fY/St6s1rtqbESynD61Zc6HpY0VMxEOBKi4jZ6567AhUUPKnaEsJmYAWq7WN/
	 5Co369t8ShF24wb3Apl/V7Qn3skPvmJOR5ziq9XPUkcSjZCAmdWjFEspJ1zgriav05/lb
	 OSQm05048+jItQ7tlA78MhthOvZAdiAlPh0cBNRJKFK8+Q2+BqbajoPjN/f/hbBOCknQS
	 hoQnqDHQH5vWhfj0kKrmAU/1ihMywC9BPMARUBwa8uMsTS8+9j5W0SMIQsVhma8V4/ID7
	 Una6Oziv94oHG3hKP7ECduebmn8N1nLGDmvxXaL9mqjwveXsOzk6uj4ier9xNnd76Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231305;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b0K11NKHw7BrnnAi+JcrbgkOQ968MsBCoC2SvxgNHcw=;
	b=byvFmrrHg0EZop+hzTVywC+dums393AbvuQl5eDSUArG0K4PfZoJCc4sLvPDddHXlVIT
	 wztySy7SfC/Tc8pWHy4MSK1WBwYtcEoPXob0Z+NhvF1zAOL0XKoh2hQ6S9j1J52v7O7Sg
	 3HAPErP5X3cOkHbSIST/Npo+3mX2gwYyamWYsrYXP0Cd5HBeKI5Qf+XwCjFPWzg/KZk18
	 rqQrXdvyv44MvUmNoAQzFqNqtUDCjZ/RLKgcvj+hF/33gQA/pI8Imr+OX9tv/qnaE/wLJ
	 gCPzsKiBJZkEdMYvcMG58ZoyjEyET0hDALduGYDVetTgUTQ3ObBh9jRhk3JBCbvBzcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVYir4eT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B2606A681;
	Sat, 21 Nov 2026 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVYir4eT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44E91F000CF;
	Sat, 21 Nov 2026 03:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231305;
	bh=b0K11NKHw7BrnnAi+JcrbgkOQ968MsBCoC2SvxgNHcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iVYir4eToDqLFcgHfkkpi/YEuv/mKLSmUX8Xnv2bJ6t1wiLPMP7BFODhE2JS2cAfM
	 XeQqDeAQPWV/US3THsInmw2tNe86r0fQv7yvGbWWhA3iOPQZwUNhcsXwScLOtjpy/u
	 7jfUIEUBPZAVcSeS4G/YhBfIoMV3pmnNp0Edr/ePs/WtQ5TZqO4jJRS+9P8uloYASw
	 2q06K8lpxe/8oeUHInE1Lv4y2tDT1nVMh4hM4pE869ilwz5GuEVGGUsb+lbxQDHG13
	 AAYBtao9G648n9PCvHAUdF+PjdRo728duZTL9a+8+j7WNry3QLUam8rbiocidXgz+e
	 YQHn/Jnxx53Uw==
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
Subject: [PATCH v10 14/16] perf test: Skip the LBR inline unwinding check when unsupported
Date: Sat, 21 Nov 2026 00:20:50 -0300
Message-ID: <20261121032052.1392234-15-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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
2.56.0

