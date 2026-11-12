Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514751;
	b=QzX5g83qSDB4oJBwRZ3OQhoupmh1RQzGpZierWKJBTwqlDkY3Wky71vfHMm/vhttmMtb
	 fMhL7OkGotqThnGbQpjLKGZJKydTs97w5VdroyeHgBGLMZJvmZbD3pBjYKYWsYHaV3QUP
	 S6G9cW6GTAVGz8bDx1uoiMX1txy7wd6bvKL6WLcr7TJY8jZujgvE0jdYtgt/r+hI4fxHa
	 V9GubNzkpqY6PaG8NWkiJ7hgDNjfTffHe58i906pUH8G85hkQPIXaBMUCswnUx+Kf+A9I
	 Gboim74ctnIVZk77AA6azEkKeEstETPx2TOGFTmicOze8Bx9UwTQzSxcwUbVWKtEjXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514751;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=3sKFIOIC1nKZy4DhR0RZkmOh/Mc+v35w+zrcQxGTCTU=;
	b=YtsQgfdroE7J1zk18Ppz9neeClqSFHQ9TpFSx2DayrvGbgyVCfrbhSAUcbLVBgARYhdh
	 AOb8LMHgOfbh6qTNR9z4v8X1XKkWnCkiAMQdC6JJyRDxRbMD+GcpQeEuhJDuqXeMqJmtu
	 7Rrc6Pto3zHDxVweTqzgAPn9hAK4SQ2rNBLF8W3MeMpnyEdpPJPiedP94LoiaM7hJ6HpW
	 qOM7S5z1C0PxSbr4saLM+t1M4ewcROEDlrIkk0BGf9o7Bv9KpsT0VnkFoPUfbDJe5ZLr1
	 qyW6Q472SjMlA4/w6e6UlSvkFarzs8oPpCqmM4RooKVEOqVpH3Scm9oEL1rUWiMnv2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=serhei.io;
	spf=pass smtp.mailfrom=serhei.io;
	dkim=pass header.d=serhei.io header.i=@serhei.io header.a=rsa-sha256 header.s=fm3 header.b=fXOztFUU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FYVTj7Fl;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA1606A323
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 20:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51DA1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=serhei.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=serhei.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=serhei.io header.i=@serhei.io header.a=rsa-sha256 header.s=fm3 header.b=fXOztFUU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FYVTj7Fl
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B16A140049B
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 15:19:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 12 Nov 2026 15:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serhei.io; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1794514749; x=
	1794601149; bh=3sKFIOIC1nKZy4DhR0RZkmOh/Mc+v35w+zrcQxGTCTU=; b=f
	XOztFUURRhoON9kVUwCJK8wCIY1SP7fhptTnADdBpZVsPkO//O1QVseuyLh7VXNK
	BKpoFUHIP4jccYB2khCQU85cRHm2bbPkLtXjEuFm7HbNpSEXSPDH3e6V0JRpkq7t
	FiQV/uPlkTTVHDQmSasxTlnSAddId5nFz40c5429UL2hDZsbP9n9QwMCFzsIw/Lt
	qrQ+gcXcEdEOHfDUXQsqMdGifBdpbYdKc+6BJ0S9TacxdlsDohYXtAyIt0LrUdKt
	gu2/ttejbisd9lFa4ISkid/uVDS5W0Z47Dx6TzsWGTeqFV5fhoxavOpOBI+dbPe0
	8uXLyx9mO0n2G0T09mx/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794514749; x=1794601149; bh=3
	sKFIOIC1nKZy4DhR0RZkmOh/Mc+v35w+zrcQxGTCTU=; b=FYVTj7FleiJOXxNY1
	zSMWLhCHrd2HIhyoUH4HbAJ+MIE4wXfYCLLJ5BcBA2vt6Svlisf3F+XeACe/CHCq
	5mXMKa2ADeHN67nqFmf5pUlVvX0Fxazbl2FLCgfsHDbMgqHsFDcltN9DELK8WrSA
	c3vUYFvV3I4xzFC3GIS3LCs+duPXUZdbRbKvJ7kugO+oO0Sf61cL+hlG7m0u8ely
	B/B9Smj8byfBSbcq/3ygcOy/GwP0wAScYkac9Tv06ezcgZsBDu16NDEcBz4k/YwB
	B4UsMJGeH6HsQM+nNmPfSSl00TEIlZGzilBueHdcF8AJeGr/mc0AYOmJNXgWbxnO
	zomHA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=serhei.io a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794514749; d=serhei.io;
	mf=PHNlcmhlaUBzZXJoZWkuaW8+;
	rt=PGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:RGa9bEC1JhjmNnlmphQG/TRISHyrFp4haSlkN5+g1qnFbOC
	yyQHeUhasN6yB9IXz44hSRIth7lUvMBPAnB0Fc72IywQfqHW+Ty6OtF78RLWX0JU
	0oqLhQxHsdwpvpvQI6pGw2a7gX7m9wUswRVLcbgpBe61SKT87HkufrE7JUzo8toQ
	Mutp1XQ6rCna2tnI0x6dyu2H1t9Yn3VHXFmEb/MlYoalwYIeDfD3nqSPdMv31CF0
	QM1ppvlz/VAKUS/8fhV1ppEehJxvOS6KS3Htc+g+jUPs7YiIzT5iGrGoF8miTo+R
	Z2Lw9wZMIiBY4G8fG1aC0ZHljxenvDyUz4wrKFQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MX3GmluzZwEQg5iBwaEyawtM9K0PmmWHFmXacw79cvw=:eiympQQRv+ABeUIUd6Srp/Bbme9TJfPz+Km/IbnIzrk=;
X-ME-Sender: <xms:PR_2amkPZYhYR_n7HhwRMrQ4Z3fYPV43T4IkSPv5XrwGD9GT2_AgnA>
    <xme:PR_2amcp-hi9-U9ZOxoVyIauAh_Lew9jkHpQfBd_hiPQY9KVoWtCjJqlFprBDKlc4
    MgaagGMeS685fcd72868PqBC2jrmLMxdSeF4JrDfItIKj6Nz4YNx1Q>
X-ME-Received: <xmr:PR_2asH9jtfzht9swzSCKf9w5cAI7Gh2peb4ZPMMTt1GXGHSZoMhxTBCVDFGbjtlSKM_gZRaoSeAqj7ul1rm1LRqCcI>
X-ME-Proxy-Cause: dmFkZTFBEiwc3j5dZ4gJUDI0N6WMEjuKGN24wxyUDCgv+q0EWK+gXK5KWwofuXWChA4cMf
    1xfIDW946vHI0WlMCdujQ/oEN7n0V9FLb1+HQ1etj6yzuy3p8bS7kHEGmWmNY6yrikSAyb
    CuVYtG4LNH1LeCm42mJeh6hnQG8kIFnKRMGWZ61jDg+tVyucLvcmOWxRhECFcsi1AbLU+E
    JQPdoE+52kXcNPzbcBG009Wrpekry5MyVVnvth8t5s4BwdWZ99B2r2i7rkQB9rWgpfeE5u
    jGmR/hR4xTTmyyQcYaAn6IrXsl7Y2ORUBFt4Ua+fWcB5gdbHeMCUqFmNAwzdh4qB32fUXw
    k9qGB46ni0FwI0RH4NLEfiNkdXHrnOBlDxn8lBArc+jl/3IM0H231fUxC5An+Iyj2FAVGy
    BgWyOjQNZkibntVMCmiUIsrI1i6XQNpsobQHdp0mid6g35cQqojAH3bQgHI2Wf2BIStG45
    3gSKxNnhz/OzjASG0KfDfUeLmx8eE2PLGNP5FCr4zJhv8VpNyX5ZDXV6Is3aa26r1o+g9g
    eJOsR66oUwTlZ5QDxWrf6AhOWyFVeuY5iE3BrfIe5taDT5eSzLMxMWciLxd22TYl/EMSxa
    k3vncWIyjVLtpzkenCcyystNjxmLOsUnjpU6mOkhkuRANo0sTGOjlUFKZ4xw
X-ME-Proxy: <xmx:PR_2akiMlFuZCZWEYJH4eAspdFKB0CdcksERDhB33_Xh4IkM5Czp7Q>
    <xmx:PR_2ao3V2fMwTUkVczRBNOQcULgu_1RQ6sQCPi-may0OEuh1brocew>
    <xmx:PR_2anfU6XXleqRr4k3Cu2xHyk5JCDJNzCd5bkBBcRJMp7Uil3-Azg>
    <xmx:PR_2auyd1Iuv61wXlrWGSE1vj73muFBpWZrr6aUUbpgkrcpoVC-Juw>
    <xmx:PR_2auRa68H-MGKbfsFJFEdKJU4WZ1rA0ROO83QV0KK0zkZQwaDfIpFp>
Feedback-ID: i572946fc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 15:19:08 -0500 (EST)
From: Serhei Makarov <serhei@serhei.io>
To: acme@kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	james.clark@linaro.org
Cc: jolsa@kernel.org,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	serhei@serhei.io
Subject: [PATCH v2 2/2] perf test: Test piped data in inject-callchain.sh
Date: Thu, 12 Nov 2026 15:18:33 -0500
Message-ID: <20261112201833.78630-2-serhei@serhei.io>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112201833.78630-1-serhei@serhei.io>
References: <20261112201833.78630-1-serhei@serhei.io>
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

Expand the test to verify --convert-callchain on piped data.

Also, check that it's now safe to run 'perf inject --convert-callchain'
on events without DWARF callchain data. In the prior version of the
code, the up-front evsel check (not possible to do with piping) was
guarding against a segfault in the prior version of the code.

$ /opt/perf/bin/perf test -vv "DWARF callchain"
 89: perf inject to convert DWARF callchains to regular ones:
--- start ---
test child forked, pid 1952580
recording piped data without DWARF callchain
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.075 MB - ]
recording data with DWARF callchain
[ perf record: Woken up 33 times to write data ]
[ perf record: Captured and wrote 8.266 MB /tmp/perf-test.B1OMir (1025 samples) ]
recording piped data with DWARF callchain
[ perf record: Woken up 33 times to write data ]
[ perf record: Captured and wrote 8.283 MB - ]
check --convert-callchain without DWARF data
convert DWARF callchain using perf inject
convert piped DWARF callchain using unpiped perf inject
convert piped DWARF callchain using piped (input) perf inject
convert piped DWARF callchain using piped (input+output) perf inject
compare the (unpiped) both result excluding inlined functions
compare the (piped) various results excluding inlined functions
---- end(0) ----
 89: perf inject to convert DWARF callchains to regular ones         : Ok

Signed-off-by: Serhei Makarov <serhei@serhei.io>
---
 tools/perf/tests/shell/inject-callchain.sh | 63 +++++++++++++++++++---
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/inject-callchain.sh b/tools/perf/tests/shell/inject-callchain.sh
index a1cba8010f95..900459a8dc9e 100755
--- a/tools/perf/tests/shell/inject-callchain.sh
+++ b/tools/perf/tests/shell/inject-callchain.sh
@@ -23,23 +23,74 @@ trap_cleanup()
 	exit 1
 }
 
+trap_err()
+{
+    local SIG=$?
+    if (( $? == 139 )); then #SIGSEGV
+        err=1
+    fi
+    echo "Unexpected signal ${SIG} in ${FUNCNAME[1]}"
+    cleanup
+    exit ${err}
+}
+
 trap trap_cleanup EXIT TERM INT
+trap trap_err ERR
+
+echo "recording piped data without DWARF callchain"
+perf record -F 999 -o - -- perf test -w noploop | cat > ${TESTDATA}.nodwarf
 
 echo "recording data with DWARF callchain"
 perf record -F 999 --call-graph dwarf -o "${TESTDATA}" -- perf test -w noploop
 
+echo "recording piped data with DWARF callchain"
+perf record -F 999 --call-graph dwarf -o - -- perf test -w noploop | cat > ${TESTDATA}.piped
+
+echo "check --convert-callchain without DWARF data"
+# verify that running on non-DWARF data does not produce segfault
+perf inject -i "${TESTDATA}.nodwarf" --convert-callchain -o "${TESTDATA}.nodwarf.conv"
+cat "${TESTDATA}.nodwarf" | perf inject --convert-callchain -i - -o "${TESTDATA}.nodwarf.conv2"
+cat "${TESTDATA}.nodwarf" | perf inject --convert-callchain -i - -o - | cat > ${TESTDATA}.nodwarf.conv3
+
 echo "convert DWARF callchain using perf inject"
 perf inject -i "${TESTDATA}" --convert-callchain -o "${TESTDATA}.new"
 
+echo "convert piped DWARF callchain using unpiped perf inject"
+perf inject -i "${TESTDATA}.piped" --convert-callchain -o "${TESTDATA}.piped.conv"
+
+echo "convert piped DWARF callchain using piped (input) perf inject"
+cat "${TESTDATA}.piped" | perf inject --convert-callchain -i - -o "${TESTDATA}.pipein.conv"
+
+echo "convert piped DWARF callchain using piped (input+output) perf inject"
+cat "${TESTDATA}.piped" | perf inject --convert-callchain -i - -o - | cat > ${TESTDATA}.pipeout.conv
+
+# skip reporting/comparing .nodwarf vs .nodwarf.conv
+
 perf report -i "${TESTDATA}" --no-children -q --percent-limit=1 > ${TESTDATA}.out
 perf report -i "${TESTDATA}.new" --no-children -q --percent-limit=1 > ${TESTDATA}.new.out
 
-echo "compare the both result excluding inlined functions"
-if diff -u "${TESTDATA}.out" "${TESTDATA}.new.out" | grep "^- " | grep -qv "(inlined)"; then
-    echo "Found some differences"
-    diff -u "${TESTDATA}.out" "${TESTDATA}.new.out"
-    err=1
-fi
+compare () {
+    local OUT=$1
+    local NEWOUT=$2
+    if diff -u "${OUT}" "${NEWOUT}" | grep "^- " | grep -qv "(inlined)"; then
+        echo "Found some differences between ${OUT} and ${NEWOUT}"
+        diff -u "${OUT}" "${NEWOUT}"
+        err=1
+    fi
+}
+
+echo "compare the (unpiped) both result excluding inlined functions"
+compare "${TESTDATA}.out" "${TESTDATA}.new.out"
+
+perf report -i "${TESTDATA}.piped" --no-children -q --percent-limit=1 > ${TESTDATA}.piped.out
+perf report -i "${TESTDATA}.piped.conv" --no-children -q --percent-limit=1 > ${TESTDATA}.piped.conv.out
+perf report -i "${TESTDATA}.pipein.conv" --no-children -q --percent-limit=1 > ${TESTDATA}.pipein.conv.out
+perf report -i "${TESTDATA}.pipeout.conv" --no-children -q --percent-limit=1 > ${TESTDATA}.pipeout.conv.out
+
+echo "compare the (piped) various results excluding inlined functions"
+compare "${TESTDATA}.piped.out" "${TESTDATA}.piped.conv.out"
+compare "${TESTDATA}.piped.conv.out" "${TESTDATA}.pipein.conv.out"
+compare "${TESTDATA}.piped.conv.out" "${TESTDATA}.pipeout.conv.out"
 
 cleanup
 exit $err
-- 
2.56.0

