Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945916;
	b=cU8Jw4BPaEcHnyJwGm9L/JW41oYbLUIUsZfwZ/KyPP7iMgH460g5BlJ2U+o0ZJjv2ffI
	 1PyFFkOcXKSMYM9WMC8W7hZfQr4kdyY4mS6MO7zzuMz1znI0W0LOq26TS67LfY+ry1pa0
	 Ugp6lYTIR8yXnq9+70WuNnQ7VXgaiuKj64h+15EeJCsHmHGkpeEfClh6upXxOTyOqyoe9
	 uLNSpj36RKukf0bA0bTJ7lfX+5BCsjCUK1Miszd1vMBmaM2qTVsqH5ymb/RV4JAQzj2pp
	 9Z3XViF9ZjisaKVKLZxHHf/7vA+PTNzExTjXhnjdVSL2mJQNeRqx2QsprmcGGe0IL6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5XGgD7g5FfN+5XKlQLPs4Cb9tYcgujXE1uddgNLi2X0=;
	b=elCO7vd84PZ29ppezQH0BPUbKVnzBueYE2bcSQblnwftVf3VBfhIXj4AIoYaDVI+lXxL
	 QWA9Y72792EOvWHlV8aQiTPPIEl+9AgiUmzA8Olg+lAL7MtmcxeMmwx0bIGZTpP2kaOZ5
	 TwrqpBORWPLBVU0ytfUQSJs+Gb8byQe3CS73fr2GFwKt8YOtFf9JHl5vzq92UNeKtMhJw
	 zl8O5Ad9S/D+mTNA+xN1XgeVChCPYAL3Ox8gyPD6w+2ukidmHf+PDLFot+XUIAFo/n4hi
	 2jE8FE9exWbYBkkczOCXyKFuotDn/egObu5Pl8meaD9kSMYvNoXPTT3tvKnKDlBkxIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaBchpZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592360A6F51;
	Tue, 17 Nov 2026 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaBchpZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF21F000C6;
	Tue, 17 Nov 2026 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945916;
	bh=5XGgD7g5FfN+5XKlQLPs4Cb9tYcgujXE1uddgNLi2X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YaBchpZTo3JZBKWcXdrgNVVvsvrVkksxucakSdme5gVQsHnkv+lguSUVj5dIlWy72
	 Xm9Bzu2+i5ddWFUB822WPj5POpXpkaI1G/7+AuA+GwmhFRAhgPFEDDOEpFNC0r3NE2
	 /JVn8w59DYV27Ud+g1Y720nid9q6E0eY40zaMwb/GBFK4r1dwpyOmGToUHtZ9YsmVL
	 JBSFzGfeXLkipj/s5IhVSqNVEdbLQ45StFfWhFQDI8gYpzO//3iqlzihLyGmzE/Pwg
	 OAV/9zJg2tfP/X//aJdPqTPZY1e7XmX4ks1EMx/Lvb1OQ7ado5RuGVltHUXkdBC58P
	 JFS6LinVIePOw==
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
Subject: [PATCH v6 13/13] perf test: Skip the LBR inline unwinding check when unsupported
Date: Tue, 17 Nov 2026 17:04:31 -0300
Message-ID: <20261117200433.45174-14-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117200433.45174-1-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
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

The LBR check considers caps/branches sufficient to record cycles
with --call-graph lbr. AMD BRS advertises branches but samples only
its own retired branches event, so the test fails instead of
skipping.

Skip only when evsel__open_strerror() reports "doesn't support
branch stack sampling" (EOPNOTSUPP). Generic EINVAL or "not
supported" may indicate a regression; show the error and fail.

Fixes: 446c595dc0dd1759 ("perf test addr2line_inlines: Ensure inline information shows on LBR leaves")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 23 ++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index e8754ef2d7f21ac2..ca88a6b886ca1ae3 100755
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
@@ -71,7 +73,22 @@ test_lbr() {
     fi
 
     # Record data. Currently only dwarf callchains support inlined functions.
-    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf test -w inlineloop 1
+    # Some PMUs advertise branches but reject branch sampling for cycles, e.g.
+    # AMD BRS, which only samples its own retired branches event.
+    if ! perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- \
+            perf test -w inlineloop 1 2> "${perf_record_err}"
+    then
+        if grep -Fq "doesn't support branch stack sampling" "${perf_record_err}"
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
@@ -93,4 +110,8 @@ test_dwarf
 test_lbr
 
 cleanup
+if [ $err -eq 0 ] && [ $lbr_skipped -eq 1 ]
+then
+    exit 2
+fi
 exit $err
-- 
2.56.0

