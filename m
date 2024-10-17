Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77171DED5B
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181837; cv=none; b=ecWnHGeYpHLVfyOOHq6AuE8a0B3TQsfdpcDhahtNvXbCaIF7exuXuZeFbN9b9sfImrlLL/KloK4HVhS2P6awVD3L+377xEMFgntVFob6vq25/W1lMZ5KR8izVEYcOZJNxlOvSRAPSSGlgJZfqo13coTHXJY94gY7OksuMKUW/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181837; c=relaxed/simple;
	bh=NlGXNp3bNEjysVyIF38hdgezIoo8VoVadMB4IGHmm4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHVvRlsOvEx/DfJiNGkCWxwE108Q36HCyj/IIRk3mVnmlthyFCdbc0E1AvqEMa69hrkXl3mi7mMfjZfKE37i+AKqUzKcqW0ok42SlO6vR/tFXrVzUT2Pyg6Lgw8usyhp6CACddXEhoVBX3UslcKrPz799ibfwT4g/bp3r4hVbhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8pbaVu0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8pbaVu0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729181829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1s5mwERcAMxBf3Q/BdA4U5z3Aay/Q0A8/cpBZSs1q+0=;
	b=a8pbaVu0FYvUNBClvsg8E+6HWqSUgHLXWMhooVbHUexGXq6/hh6Qqq7lrQ+buuyjAJeYb1
	ZDEWO0RC3cpsetNuqCqJs9L9wVieuOrB/pCI7RcEWNp+OyRIpZ8WnPM8dszaDOjJUUK7vH
	XcTJ3Cowa1TXyohGmKSzjNcMfuPxVO4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-pf4pvaUeNLeE0aOBr1djeA-1; Thu,
 17 Oct 2024 12:17:08 -0400
X-MC-Unique: pf4pvaUeNLeE0aOBr1djeA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3561C1954B16;
	Thu, 17 Oct 2024 16:17:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.27])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E44641955F43;
	Thu, 17 Oct 2024 16:17:00 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf test: Handle perftool-testsuite_probe failure due to broken DWARF
Date: Thu, 17 Oct 2024 18:15:55 +0200
Message-ID: <20241017161555.236769-1-vmolnaro@redhat.com>
In-Reply-To: <Zw_mutl867MINXPi@x1>
References: <Zw_mutl867MINXPi@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Veronika Molnarova <vmolnaro@redhat.com>

Test case test_adding_blacklisted ends in failure if the blacklisted
probe is of an assembler function with no DWARF available. At the same
time, probing the blacklisted function with ASM DWARF doesn't test the
blacklist itself as the failure is a result of the broken DWARF.

When the broken DWARF output is encountered, check if the probed
function was compiled by the assembler. If so, the broken DWARF message
is expected and does not report a perf issue, else report a failure.
If the ASM DWARF affected the probe, try the next probe on the blacklist.
If the first 5 probes are defective due to broken DWARF, skip the test
case.

Fixes: def5480d63c1e847 ("perf testsuite probe: Add test for blacklisted kprobes handling")
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 .../base_probe/test_adding_blacklisted.sh     | 69 +++++++++++++++----
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
index b5dc10b2a73810b3..bead723e34af3f0e 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
@@ -19,35 +19,74 @@
 TEST_RESULT=0
 
 # skip if not supported
-BLACKFUNC=`head -n 1 /sys/kernel/debug/kprobes/blacklist 2> /dev/null | cut -f2`
-if [ -z "$BLACKFUNC" ]; then
+BLACKFUNC_LIST=`head -n 5 /sys/kernel/debug/kprobes/blacklist 2> /dev/null | cut -f2`
+if [ -z "$BLACKFUNC_LIST" ]; then
 	print_overall_skipped
 	exit 0
 fi
 
+# try to find vmlinux with DWARF debug info
+VMLINUX_FILE=$(perf probe -v random_probe |& grep "Using.*for symbols" | sed -r 's/^Using (.*) for symbols$/\1/')
+
 # remove all previously added probes
 clear_all_probes
 
 
 ### adding blacklisted function
-
-# functions from blacklist should be skipped by perf probe
-! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $LOGS_DIR/adding_blacklisted.err
-PERF_EXIT_CODE=$?
-
 REGEX_SCOPE_FAIL="Failed to find scope of probe point"
 REGEX_SKIP_MESSAGE=" is blacklisted function, skip it\."
-REGEX_NOT_FOUND_MESSAGE="Probe point \'$BLACKFUNC\' not found."
+REGEX_NOT_FOUND_MESSAGE="Probe point \'$RE_EVENT\' not found."
 REGEX_ERROR_MESSAGE="Error: Failed to add events."
 REGEX_INVALID_ARGUMENT="Failed to write event: Invalid argument"
 REGEX_SYMBOL_FAIL="Failed to find symbol at $RE_ADDRESS"
-REGEX_OUT_SECTION="$BLACKFUNC is out of \.\w+, skip it"
-../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
-CHECK_EXIT_CODE=$?
-
-print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
-(( TEST_RESULT += $? ))
-
+REGEX_OUT_SECTION="$RE_EVENT is out of \.\w+, skip it"
+REGEX_MISSING_DECL_LINE="A function DIE doesn't have decl_line. Maybe broken DWARF?"
+
+BLACKFUNC=""
+SKIP_DWARF=0
+
+for BLACKFUNC in $BLACKFUNC_LIST; do
+	echo "Probing $BLACKFUNC"
+
+	# functions from blacklist should be skipped by perf probe
+	! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $LOGS_DIR/adding_blacklisted.err
+	PERF_EXIT_CODE=$?
+
+	# check for bad DWARF polluting the result
+	../common/check_all_patterns_found.pl "$REGEX_MISSING_DECL_LINE" >/dev/null < $LOGS_DIR/adding_blacklisted.err
+
+	if [ $? -eq 0 ]; then
+		SKIP_DWARF=1
+		echo "Result polluted by broken DWARF, trying another probe"
+
+		# confirm that the broken DWARF comes from assembler
+		if [ -n "$VMLINUX_FILE" ]; then
+			readelf -wi "$VMLINUX_FILE" |
+			awk -v probe="$BLACKFUNC" '/DW_AT_language/ { comp_lang = $0 }
+						   $0 ~ probe { if (comp_lang) { print comp_lang }; exit }' |
+			grep -q "MIPS assembler"
+
+			CHECK_EXIT_CODE=$?
+			if [ $CHECK_EXIT_CODE -ne 0 ]; then
+				SKIP_DWARF=0 # broken DWARF while available
+				break
+			fi
+		fi
+	else
+		../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
+		CHECK_EXIT_CODE=$?
+
+		SKIP_DWARF=0
+		break
+	fi
+done
+
+if [ $SKIP_DWARF -eq 1 ]; then
+	print_testcase_skipped "adding blacklisted function $BLACKFUNC"
+else
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
+	(( TEST_RESULT += $? ))
+fi
 
 ### listing not-added probe
 
-- 
2.43.0

