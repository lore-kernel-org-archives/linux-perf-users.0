Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872858;
	b=XaV2UcsHiK7SW7Y9pmrewxSo7p/uWu+0QnQooTJmHGV68bbxekaDFv6xc4AkjHtoCNge
	 Ui7kymhBYCbs/sgDBVE+wv6YHflEj9mN8d087fIHJfpSBug5G7FrUt6YXrrhTJo/tibDg
	 AkYStltAX2LDycrih1XPp/ky6DL0GiQGNbLVryohWtQBabigf7K7h8Xx8oMJ6uO5G5/BB
	 8yPAyV056rfZ+J9MJFk6ktaMlS7Aa9yobexA7h/vDwAmLaQkzYCNS5skTtjoZJ+c6xVq5
	 h+iSbuM0n7TZ6RxXu+qOGa6NmCUL0Sms69HqOESVHmORxZ1N3/6KR4WjZbFbdQDJ4MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TUILjw4JTE5DU1Syw/BswgPgtWCByy6icnmnJ0nsU8s=;
	b=m/yt/pBqB4PTBFHwYxlS1GXyhDCqxL5ExyAHtzmMopMkMzTWmh7V8RXlLm8ULgRBGr/P
	 XDR70CJIAZdP8GQZvoUXLzSWisaWnbwJPQ0Ig3fOVY0u535zArYDJmqBNoca3AAYDNjtY
	 4l1sO6UfeKE3re6YeqkC85UNs+lwHvl73YClYa0vUYBQSA05NGy9jr0XrFVL/RXAlH0ZE
	 fBf5Vp0Mz5cu38PG7cGGQCaTNBn+WAMw1DbgOz2dykSV33i0nhEZvRZSaCYBVKsuhbLqf
	 W1yFtMUEpDmP9gePzMiLBOz3uaVlDGHT8fSTlaKonA2yOSKy2lYhVxQpvECvc/D3KBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyTxeO+l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932A606A33D;
	Mon, 16 Nov 2026 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyTxeO+l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B571F000D1;
	Mon, 16 Nov 2026 23:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872858;
	bh=TUILjw4JTE5DU1Syw/BswgPgtWCByy6icnmnJ0nsU8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kyTxeO+lc6/fCptynj3H9sPPs7kuZ2yeoNhXU1yazRcZ3xBmeuKEGVrkut+ooDWGo
	 o3gT0FeBlMh3Zx0iU1hqrG5bwzDYhDxGRUWTPs7J0++Mw9fumq98ABdiBmfnnchigY
	 MItsg8mvliNbaJ0QBogg5uOZo4uEst8IAIPzJ+81kerarc/ZG/bhd+4qDm1Wz3owm5
	 wIjYbwPWhGwJGCYzuqFfdbmQ2LdaJ2Bq6XZ/2aE94yIpPlmOrPd7z4O8RAD6Ycrwqh
	 FWqd7E6n88qonVipH2cV7xvwFkdD7VCDyiF58o+v43WxWYouaeJ6gw7OXBp+B9P5Iv
	 BUB9nikJDbO4g==
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
Subject: [PATCH v4 12/12] perf test: Skip the LBR inline unwinding check when unsupported
Date: Mon, 16 Nov 2026 20:46:58 -0300
Message-ID: <20261116234659.3950531-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116234659.3950531-1-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
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

Probe the record and, when it fails with "Invalid argument" or "not
supported", exit with status 2 so the test reports Skip, as the branch
stack test does.  Any other record failure still fails the test and
shows the error.

Fixes: 446c595dc0dd ("perf test addr2line_inlines: Ensure inline information shows on LBR leaves")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 23 ++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index e8754ef2d7f21ac2..be0bfb70143a1294 100755
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
+        if grep -q -e "Invalid argument" -e "not supported" "${perf_record_err}"
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

