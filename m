Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884028;
	b=JnfDjen1tDo8F7rBq5BYpKSnInIggblTLcED7NBDKxquvEUFKPBzG9pRIVv81wtdfDXm
	 sIGnoECPcMwBVJMOTUiwV0cOTnJGnXIvXKpZMX1g0LWUTNgX+d7ajTr1iR2B1eVKXjO0e
	 JHgGxpTlgvzjy52eUuJ3HZT3S4W61do1fhGyRlOB9IlKsJvxy9SItS37u3VrJTPjCeQN+
	 Z6sqGBJliMvL+eTMddO7J+e+Eh2V27LYZ8x9vlohaYNd2xaHaxjYglG0UgcCs5cIsTYU/
	 qTeYkJx0NSCOQtn9Hh2sbTrj3GLEjcme1+NZqLjfg/yC88AR+mRKMF+7LRNu8DcxKgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884028;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BaKFBe33jveFlusq4IBjG51wEJMm0MOD2d2IipYSxHQ=;
	b=CIVkhwd7ss4EgBa9WHR1PxdwieKBRSVd3RvMLwMgZA3UC4sFBzergNfKJSRNrSF668TL
	 O2MCliuI/RjKekZ7sEtXT8yLVtaByVrw+rIli7KN7pw5qvtvUo2GF/Bw6RzvE7mgGIdkq
	 yqucqGYcIKe0Y488Z0ErafKNRgMYTtEF0bthff9Zgy4HxwGd9hwoAA2gLKItNtrv8IFAF
	 Tkb7FkN5v71Zq7A0+C0zDN66DxPQ9rD/ubHHb3GAOYr9v5mp7RNhn5IW4smg29eS1I7db
	 NXLfnXy/C5mwBTkHubLNpuzGRx97WHywyfm1oDm/zsJA6/Pb5Q51pZE69Uxge5sombw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBNbqGpr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350B606A332;
	Tue, 17 Nov 2026 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBNbqGpr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31081F000C5;
	Tue, 17 Nov 2026 02:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884028;
	bh=BaKFBe33jveFlusq4IBjG51wEJMm0MOD2d2IipYSxHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IBNbqGprHyPWjFY3nxSr3fK+gPn+98qggMg4m7jAO0oaT6rhl2jEBDDPfBbcwFJ+8
	 C421Bl3+QHudE/t8XI3sWoTzFAoILdNRQk2tMnuHwFlM7Hbm6sutE9NQULpRYe9dn7
	 DcWlIoNdvPlTTyT+zU5ceF251snTYCPaQ/orkj3/gpMcuJnifxuHNGmAnFaUrLHH6z
	 6G/Ms41tZ84jB7sCnx4gFNt6nqU1HwMmmDsSAvfGj8tYWCAH6Y4Fj4wiPQ8LcySzQS
	 4HR4Ue4RFYB2Jq2ZlYPWzyYdhYoYXNTZHxH1ZEov1S7q004LiDIf+Ekv5p22TcnVd3
	 7dXN0iPtYX9Ug==
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
Subject: [PATCH v5 12/12] perf test: Skip the LBR inline unwinding check when unsupported
Date: Mon, 16 Nov 2026 23:53:04 -0300
Message-ID: <20261117025305.3958882-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117025305.3958882-1-acme@kernel.org>
References: <20261117025305.3958882-1-acme@kernel.org>
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

Probe the record and, when it fails with "Invalid argument", "not
supported" or "doesn't support branch stack sampling", exit with status 2
so the test reports Skip, as the branch stack test does.  The last string
is how evsel__open_strerror() formats EOPNOTSUPP for branch stack
sampling.  Any other record failure still fails the test and shows the
error.

Fixes: 446c595dc0dd ("perf test addr2line_inlines: Ensure inline information shows on LBR leaves")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 24 ++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index e8754ef2d7f21ac2..092adaf3c48d3e15 100755
--- a/tools/perf/tests/shell/addr2line_inlines.sh
+++ b/tools/perf/tests/shell/addr2line_inlines.sh
@@ -8,6 +8,8 @@ err=0
 test_dir=$(mktemp -d /tmp/perf-test-inline-addr2line.XXXXXXXXXX)
 perf_data="${test_dir}/perf.data"
 perf_script_txt="${test_dir}/perf_script.txt"
+perf_record_err="${test_dir}/perf_record.err"
+lbr_skipped=0
 
 cleanup() {
     rm -rf "${test_dir}"
@@ -71,7 +73,23 @@ test_lbr() {
     fi
 
     # Record data. Currently only dwarf callchains support inlined functions.
-    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf test -w inlineloop 1
+    # Some PMUs advertise branches but reject branch sampling for cycles, e.g.
+    # AMD BRS, which only samples its own retired branches event.
+    if ! perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- \
+            perf test -w inlineloop 1 2> "${perf_record_err}"
+    then
+        if grep -q -e "Invalid argument" -e "not supported" \
+            -e "doesn't support branch stack sampling" "${perf_record_err}"
+        then
+            echo "Skip: LBR not supported by the PMU"
+            lbr_skipped=1
+        else
+            cat "${perf_record_err}"
+            echo "Inline unwinding lbr verification test [Failed to record]"
+            err=1
+        fi
+        return
+    fi
 
     # Check output with inline (default) and srcline
     perf script -i "${perf_data}" --fields +srcline > "${perf_script_txt}"
@@ -93,4 +111,8 @@ test_dwarf
 test_lbr
 
 cleanup
+if [ $err -eq 0 ] && [ $lbr_skipped -eq 1 ]
+then
+    exit 2
+fi
 exit $err
-- 
2.56.0

