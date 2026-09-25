Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA73D88E0;
	Fri, 25 Sep 2026 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370061; cv=none; b=mc+9QlLAx2j2NsGUr/edhVJ4naZOZde476UAR4e5F70BAinFvaDJFhqJk7yfJxzipIGOmX9jtblWVjUP7pJ2YTfillim3MT/z76uDV+f7y+oospJcsXUdYXrGOQqga3x/fWlakyfmUfgC3M5rttVmUg4kuWz0fuhqth9NN/UDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370061; c=relaxed/simple;
	bh=c1Ol/QrNjutlufK3LBDvwrAwlOuSo4qx0MGIZeYNJbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdO3wk9Vd8xobpAyh9S1ZnTOwOUNwu5fwLH6nGCiDu+le1kH3uYxrGboUT0rDSv+zqkMhwSeivMDkFqr7s5pHfYnZ9z6NGEzMxPTfBq2Ia8qVv4AuYAgplJCMnKZMOAIHexGZe972v/3HcxuPj+7lNgMpvBHoClfwe6fPdAzEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=serhei.io; spf=pass smtp.mailfrom=serhei.io; dkim=pass (2048-bit key) header.d=serhei.io header.i=@serhei.io header.b=hdAdxCeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDj9i0Bs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=serhei.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=serhei.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=serhei.io header.i=@serhei.io header.b="hdAdxCeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDj9i0Bs"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB9251400109;
	Fri, 25 Sep 2026 17:00:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 25 Sep 2026 17:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serhei.io; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790370058; x=
	1790456458; bh=DGPHwYcayA3RQG1dTsokMSggwFCdbgi12UWb7HqdBOY=; b=h
	dAdxCeVCtAHV0/Q7QQXcyW/PEhxRaKPAXrkD6Pgei0J9uVKwtUrEgemgUv+TP1dm
	vZblm88BJm28GTQVp0u30n2O3B/flAYR4oVPQilrcYzLamirxFcZkYgWgR9/Bl8f
	n74HsFMfe93cyMTc7qcHB5W/wdzNM3P24Eb4wjBk5ccHvJAAqLlR+Pmg0B2d3MUY
	sY8qKwKbqeG0McFqWlQsg7x9IvI6cPgaOUvoiXixra+gca067cOiOQPMqoCBoAel
	dAeomQdRCH+RxQgqhhtNNSfOnbAIrFPz71L2gNGzGDpu2CBa8m7k+TphSI0vy7WR
	wU7cYoXykKqh9InR+MjgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790370058; x=1790456458; bh=D
	GPHwYcayA3RQG1dTsokMSggwFCdbgi12UWb7HqdBOY=; b=EDj9i0BsYHyLY5rEZ
	xmubHyUh37W9Crjkb2pOcjN6znhnSA1zK/KPN/cLe1zUG0zjyn30ihCM5b8dtj3g
	sx5gJfRSxk6l/YjFLo7lv5lMEBpoSQJMLnjHrl8nVZlrKNR0FRE4DkXeL7u0tJoM
	LG5F5D00JDc23HQF05aaWX7cUalP5ktHFbD3Lv2yfv8aFrbzHpcTd3bYZN4ii/w6
	iz4FzDRrdrJWJ6HZDGcnEFjwrSREAZMqqZ0DIon2ym+c3gPojtxc1cPVctMHlRX+
	kM6wTFaQtwja3Aei3Kx2P6eU3QjJl9s6RiQrNQxTXmtAkfFahgT/pU0u5OyFtoh2
	aWPcg==
X-ME-Sender: <xms:CuG2arS1R6r5uixIbFk2rlSnVUR937eM_m9KZuJIHCV5Wm_B3mdIeQ>
    <xme:CuG2arCbMOqEwSb29bJUWj5ksYmakG9hUERX-jGc_5-So9GIlqCh1VxwWoT-aTlBM
    9LTy_nFc0jGxDCWy5tCyxD7XTnLuBtQ5v02wa4aTujFet25Ea9U>
X-ME-Received: <xmr:CuG2aqKtIIDoTdsHZUfvbSr8hGjYz_z90_sBClmlnyqgPjQjBP3YJW0IwT6qZi0D1tNHihJ0tQ3HAZMj>
X-ME-Proxy-Cause: dmFkZTFoYOXG1L8DCUTiKtM/1DG1MTtDX3DDdb46nmfIlMO8IXExQtWPL4lIg6e7LBnh3R
    tjALrFzZawgi+aekKDsbay7kD9KMTnWKblFMoK6JPsGdKV1Vhz6ttz7ptw17Y+/Wv8r/by
    fJwrMZ2RldFbiM/LGYfURBgFNV2h1l4wljdyMGSKwbmTsPS7dic65l72wKi5eR6fEZGDe2
    cQw76U+TORhxLSfHcXgzErDiC9f402F5b5qtgmWB8x0iAMIG83MyYRQjrLlbYMoPj9niDS
    PWL00u8/uvmdK64DKRbUk0BslESbM9jMRX1bhnS8L8FEjdXBH1BrJ8+8dwioqLDg30kVa/
    zkjoKYtI1FTkDvjBNmr3sE+p+AynqULk2eFBOrl3bl3Old3AGXNqyoOIUs/F8Qnrhr1yY9
    HxSwSlUJHe6kajdkRcHV3dKGiOnoi6Uurz5OGeO9w/gliihqoeQMVm60oK1BRUhKQjyR7h
    94BqFZcsshTHU1S8LnpeWiR1iCfPrzR4q3mr3KJMesTUoipdpD+hYxKqCa2Xz8yENjWxKi
    qFKZppJHU/axIVB7kd0mpzEQAS8zzAqMLL0bB48LUmQpltXBXaxOL8e36PzXiQc6OXTCKj
    /sngO4oelTp+KBck4+RxZ8Jn/S4c2INz0A1rrkXA/JTc+QT/9D6IEzboVoJw
X-ME-Proxy: <xmx:CuG2auBMJm71V4Vw0Ms8eBng6tzCwoesWIT-dhVQr3Uju2WPC_UG9Q>
    <xmx:CuG2ansWqz1NdBcqxhB7PUWsVM4UKKTCwm0nz0F0oTz_0iQWGQETHQ>
    <xmx:CuG2akR_oBgyaCUGjU994d5V-vsGLzDrnBaQAlMs1Mp6gmgWefkuYg>
    <xmx:CuG2amKBrsEmH9E7TpkMNe_qR51gVS4OFMw0z_BohAqkwc662czqgw>
    <xmx:CuG2atrSMFct2YS73xOIw71FlSfjMF0qDhrnZicsOKi2CP6O7TgGVcSh>
Feedback-ID: i572946fc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 17:00:57 -0400 (EDT)
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
	Serhei Makarov <serhei@serhei.io>
Subject: [RFC PATCH 2/2] perf test: Test piped data in inject-callchain.sh
Date: Fri, 25 Sep 2026 17:00:30 -0400
Message-ID: <20260925210030.1957778-2-serhei@serhei.io>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925210030.1957778-1-serhei@serhei.io>
References: <20260925210030.1957778-1-serhei@serhei.io>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand the test to verify --convert-callchain on piped data.

Also, check that it's safe to run 'perf inject --convert-callchain' on
events without DWARF callchain data. In the prior version of the code,
the up-front evsel check (not possible to do with piping) was guarding
against a segfault in the prior version of the code.

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
2.55.0

