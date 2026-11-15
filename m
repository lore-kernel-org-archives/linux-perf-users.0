Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706904;
	b=zkxPtZtdafHXBg9GwFTFdul3dcqx3BfSWtDb/5RW4RklqhASZV454szaalL6iQ1/ra/G
	 QZKT7TqpSJeSdMb88dHjkkX5YwlZZq7XYVxZWA4NqoR32j9R8ja/LtIHxZcnYVR1yEIN6
	 A6gG7KJO00Yt4XIwT2Y/DYLg+QCP+joF4OfohTK2yhPiB/cSti0rGm+6LUeUOZMjXW1mD
	 i4HPBYL/Myk+RHKcqHH0Z9Cf00VW4Ejp8KPuzBYuRoEbPo6YvhTXgKJnYqGuZuTwRfPfB
	 NzKVd3SjbuZpg9HwYjfoffA36eXj4UYYx6gxRkKCi5JJnyMIEmtPoBpQP8V3Y/26O1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706904;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9e3Qa//uWc3BpHB8ONOCYmO2C1eCwrThoVAQoCUkmd4=;
	b=ttLVpmkqvACyYhz95AQ/scgvFD2PWCnXQMWTxAM0sTiLzqvM+Z0/TeWYSSYc1RqdjNDW
	 AKmGpklYOyL5em6Glf5ShIhqCHwWTj8lAEbFOt3IRnM0Ou35vWFXl847FSIGfMawsoGCz
	 VXMrTMnCbx+MWDxZlkwaBcJsexNEqwjItKDOEyvKLP2eV3fe9LiXYRB08TfI5Bw0txNB9
	 nXahRlneBAlCdAprckWq3ykgl3rJ138vB1IDeHV2GimqnGdJJ4PgWSA6CFqozAlEPLiUV
	 8y0V2w12PDY1OumSzpfl9HpHvrx/jRF/EaJuQe/GzxMVw2KFYMjoKbD+oMiZc6IxcDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGa0UFVl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342ED606A89B;
	Sun, 15 Nov 2026 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGa0UFVl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E51C1F000C4;
	Sun, 15 Nov 2026 01:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706904;
	bh=9e3Qa//uWc3BpHB8ONOCYmO2C1eCwrThoVAQoCUkmd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dGa0UFVlouYCaxmU110uE5Eos+i25w0ZGABukVoekB18vHR1IkHDHwMxRDM3No4Se
	 Pi6+ihI81j94LcleK0ibxPIuQpP6kuaOpM2c8zFF5ZJ5yUkC6C7+pNd4JI2nbfWihe
	 lit1H9GZzUFvMbV7kRd3bNqQlXYAZn/HTPCc0u2UdJMLk2OBJsX4gxrqHxAkJceac+
	 Y6jwnINIiglhzwKmjcdsHrGsBRzNQvG9wgIFN16EfKmycm4edir/uC8RbAC388VQcQ
	 m09bkAXoOl9G3C0CJD/nTf7c62drNlzpj6ZQh/rjfTPpKAqAP95yDa+yu9Mdf2iBk6
	 JXaUoNqLr5+ig==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 12/12] perf test: Skip the LBR inline unwinding check when unsupported
Date: Sat, 14 Nov 2026 22:41:00 -0300
Message-ID: <20261115014102.2879372-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115014102.2879372-1-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
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

The check only looks for the PMU's caps/branches file before recording
with --call-graph lbr.  AMD BRS advertises branches but only samples its
own retired branches event, so the record with cycles is rejected and
the test fails instead of skipping.

Probe the record and skip when it fails, as the branch stack test does.

Fixes: 446c595dc0dd ("perf test addr2line_inlines: Ensure inline information shows on LBR leaves")
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

