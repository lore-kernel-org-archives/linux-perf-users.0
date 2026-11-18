Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041497;
	b=2BX3qmhH8bChe1Ezl9Fgydaz864dl3vmiafekBjWtTss5so0G6l54b0RfrpOLwOjM5u9
	 Gkxcynec+gYzP9hI+QfiC4SQpXk1XfppY1fGP4ZRML7PqzNPxzA5OZ5u+O3+k60bs6ipH
	 UoAX9S9GzITyt24BpTeMOVksPpiz1JuCV9HPzghVG9S27IZ9hNyJlmmHHl6Du1lkq3P+s
	 nKG99aHrmJRgbHOAbecFqOqETgU/FDhw2tvzk0M6bGCdkBKlf21zvKf1gqKec28ywlrH+
	 1vk5Rdy1p7vAzJ2dVFOO1zp9cVSjLsKp/j4mFao7lEgl6gUQOkVWI8olU+agZGn4jhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041497;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HqdU3TKWtk+QHYDMIs0OjFQmc/8QrMHOsCdFuTPEaI4=;
	b=Hi7+bgm8aQz76r9dfodMaDnnXTgqEsvx2te8ziNGgYs2cfinkkvxXCyTii5HJJW+GmlV
	 1BpPTTd0EKRbmGXjKq1GqwsWlEwEyoMc7TA2ktyg8+M71OAdWMRLT4i9DxMFnLRYrUU4S
	 BGTt5fN8KKfH4UvjnvyHUmmoatFX9fLAliaMBguakPjzyKq0THeArLi+paBIs6tp5RXLp
	 Sg6T0aeD7U0buGjqPzw1gujqYoITZJLLmHoE9m20pjvBGfYpXIZ+ovAR/ADHkSbvef3Lv
	 x/kgED4i5ric7DSb4b3EsUvJjZQDLpdiXxnwoSPkT4AAXkPzqEIhueqU+V6mHlLSQtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3+wml2g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ADD606A982;
	Wed, 18 Nov 2026 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3+wml2g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170D01F000C7;
	Wed, 18 Nov 2026 22:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041497;
	bh=HqdU3TKWtk+QHYDMIs0OjFQmc/8QrMHOsCdFuTPEaI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j3+wml2gJ3BgGLQqgolkF6LUc4z/IJs2VsYx1toLXe4SuzsRyvd3GWG1ZkjIocaGx
	 O/01UWhndj4ZGNm1SidLp+aZX9mCYDy10DrQ8Ol4F3PaUM0K/IKaj6eY+P0CG2+Xgj
	 VYmPx/nDJFyrTWEa2aKNs7uk47F691kv3mkvCAJlKIQtNBI3F3Gp1tnT9//K5BJylM
	 +epQq+TXXn5Dno9twav6p6oxxXrHrUMZY3QNuRYlRUjZj9BtVkBi7eOPnr4AbaVNKB
	 Oy3kQFKSpWhmn0XGNCcnUAbW4EOtZ5rqdB5LdxXCPuXk/EtfSMCbexpJlM8SYSCl5Q
	 T9TZyW0FFXccg==
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
Subject: [PATCH v8 13/13] perf test: Skip the LBR inline unwinding check when unsupported
Date: Wed, 18 Nov 2026 19:37:24 -0300
Message-ID: <20261118223725.121500-14-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223725.121500-1-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
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

