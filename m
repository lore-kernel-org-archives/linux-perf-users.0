Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616136;
	b=F5QopHhi7DO1rHBezCtwfOL0XcCqdl31pEqXLbe+UCeFcYrahSJgBICrfNwoxIYRHpfS
	 rJXhNj4hX+hPmICDa7nXPrIWGO7EnB0wbWWGzqxs7TYSKAiXKLPw41M/cCJWGynQYVljc
	 8NzN3QrkDv5F/Muu9VVoZSi9cJLfVcOXWbMvQZKGWnzH6y03CYce+3PH8lc0FxieZntmY
	 J0c9nAzUxni9fbR5qQux+C0c/rhH+RDx5BsD6RpuoFO7ZpiQc0znGEiJnHJBcb/vrmk8P
	 s8u1iDBP6DBmxd2MOQxu/x4cCgqrRJESn2P+Az5JPnz6M0BCSApgd3pUGNS9iVIYnOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bduUcpXtkOmTxyFRZdyAPVl9VAhrZ6DhzOg/BEf13tE=;
	b=o9Sx0nlFNd0cUsHZtGgeUDicN/qJUtAYFMUlCXZseTuGAG+5O8ooDECgaxWsEsIObhcW
	 z27s+S9ac6HlzAGW1zNgNpsyQi1o3B4UCXuoYGGdWPsep3Bdwsh11ioISnyDojMFv1Xpv
	 SmaPJEQK3jmqrZFLFGU63N06pEQTRAaQghJLhYfna321tGnXu/N2tjDzU6zdIfr3iFQrP
	 AeblOVr6y/4Pk/X5eraujxeM4OTfLVE9hn5yt/h3EgzbANROR/uz/+uRnNaaS4LNAIJYr
	 kclILkddWmbXYiV6P9/02jDDnmDWAUYi2b/YD1h9mI5V81lnmfxlLWwBV7ZXn6gAspA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F1T9KowB;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E1606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 20:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE3E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F1T9KowB
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-99059bdcdeaso307112241.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792616134; x=1793220934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bduUcpXtkOmTxyFRZdyAPVl9VAhrZ6DhzOg/BEf13tE=;
        b=F1T9KowBBnAIpilNjTW11zXtvGWc+wkCskzq8zI1quuT3rfLVRT2jTpShd9YvjJ2p4
         hxZ0zPUpAKsliN3lZ5WNsxbSR4/eaSQFRWMKhUIcn+dgxM9RN7d5dAVXG1Ec06EhVJ9m
         /rCmElThGj9KX2PztlO8N88s8lKWw6SjidaTZkPjmB44VkFOAp792KoGsJSJUQAzbf2Q
         HdOOsY41DDgeXPK2kI2B1dKjj6Yt6hpp4zIPY1wqCWF5B9/xtabUqlhnFFnpn/qYM2/s
         mdxkuqIRtBsBDf3v35Qck+msXAjTNWJM/afcTYfP9kJPgcBQ0VDOgT1Su8HzU37ESMbG
         3XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616134; x=1793220934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bduUcpXtkOmTxyFRZdyAPVl9VAhrZ6DhzOg/BEf13tE=;
        b=mLm9hCFtFeqUufPiOdR7rUukB1bWYW6VyRU7EAnC+gIRh0NaBjoAwsqLa/2ETibCzq
         xyjmm35bni+p9LHNqkH4xcD27U1wRObBUHmqS6rSRyY56MnzcCW06fnOHkGosrxjbFEX
         4zERd1It1HzJMpKBdS+9Zm54xztZt7/Ta96yCN9EYjiWBmjS6GSzgM/EzA5N63d+SUZv
         6Es1brRdO78AcSOwTzbRIbVsbzyoIn3zADbGHexxyDN48VNErImHS95r7NVjhPTP3Ee5
         PKVxnvqP9KNqgi55oriSREmVjuXkxhLWZsfMv1YR+0w78KON6ExckrDgN/WGrvBO6Rlv
         REPg==
X-Forwarded-Encrypted: i=1; AKwUvBw12X17eHcC5yPjDRfBW6wkQz5nZUykVZ4sGYAYVhc3ub0OyUoKY9UilrZ1C29vCBhv/2jwyVuxO8m3ByvxBT8p@vger.kernel.org
X-Gm-Message-State: AFq9FYKxOCiMIda/qtQmXAl6FEZ1b/j4+4rZi5oJB7JS61VJMJ9OYjCC
	bIVXK30tZ0uypKZjyku232Tjm7NWEza6jOWQqhJhr3qVPStnwxNQcyku
X-Gm-Gg: AYBFou1pMgRNLChUE8pEpzNIskj8AYQJFefNt5bRWLkBYkbL45ePlDjCCa+zkero0z1
	+4LAxkWKToDyKK0D3u1cKYXWMA3/IgbQEnayzJrmIbBmHLlXOkHgMAQvtLGxC+wOqg6TbofexXl
	ygha77yNJVcGuLmZ3mjO7XBz2tAWDHC5/uSB7DCjyJ7IBtydKSsKFo72AVKKuVujIBuIkGsW+t4
	tstVhSAnY49JJISp7N6vt1aXCN7B024sXnloOoei+JzQXXD+Q/jBe4AwijjHJKehNiCqfexinbt
	PjNkN4o/W0ugDW+CxGk1J7EZE52Yklkne505Wy7Grff9G+IQkYs6E/tQQLgax9/JWIDH3+RoFgn
	wQ1lNyVCCixoKSTHeMFhGb6AuZVCkq/qBafzco3sNpNyihXGIF8MaNabKypxzaJKsmVwCv9kewQ
	haNY+7zAEXQ2wlfa0TPbPTByB3OiTigTS7LPiYEK7vR4d9HsqI/Uq3cFj4G6aab0NyTFlX7BSTt
	ddq/MWU9Mqfl+PxqXfXpxDFfg4fxK/HSn8qv4EGIDG5+Wep2FrYWGtS9uX628GcR/6gflbM70K6
	14RCX8FQ687pMS1Bu6sXWSKAsxJQ9BO37QDE/KPatQ==
X-Received: by 2002:a67:e702:0:b0:7b5:7cd5:2a1b with SMTP id ada2fe7eead31-7cc92650811mr1194197137.10.1792616133325;
        Wed, 21 Oct 2026 13:55:33 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae980f64esm4553359e0c.13.2026.10.21.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:55:32 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: irogers@google.com
Cc: acme@kernel.org,
	namhyung@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH v4 2/2] perf/tests: convert check_*.pl helpers to Python
Date: Wed, 21 Oct 2026 17:55:06 -0300
Message-ID: <20261021205506.26736-3-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021205506.26736-1-breno3011alves@gmail.com>
References: <20261018134322.26445-1-breno3011alves@gmail.com>
 <20261021205506.26736-1-breno3011alves@gmail.com>
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

Faithful re-implementations of the four Perl test helpers in
tools/perf/tests/shell/common/:
  - check_all_patterns_found.pl
  - check_no_patterns_found.pl
  - check_all_lines_matched.pl
  - check_errors_whitelisted.pl

Same CLI, same output, same exit codes. All use only the Python
standard library. TESTLOG_VERBOSITY and TESTLOG_ERR_MSG_MAX_LINES
environment handling is preserved.

Update all 37 call sites across base_probe/ and base_report/ to
invoke the .py versions. Update Makefile.perf's install-tests
target to install *.py files (in addition to *.sh) from
tests/shell/common/. Remove the four old .pl files.

All four were verified byte-for-byte identical to their Perl
counterparts on synthetic inputs.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 tools/perf/Makefile.perf                      |  2 +-
 .../base_probe/test_adding_blacklisted.sh     |  6 +-
 .../shell/base_probe/test_adding_kernel.sh    | 44 +++++++-------
 .../perf/tests/shell/base_probe/test_basic.sh | 12 ++--
 .../shell/base_probe/test_invalid_options.sh  |  4 +-
 tools/perf/tests/shell/base_report/setup.sh   |  4 +-
 .../tests/shell/base_report/test_basic.sh     | 54 ++++++++---------
 .../shell/common/check_all_lines_matched.pl   | 39 -------------
 .../shell/common/check_all_lines_matched.py   | 47 +++++++++++++++
 .../shell/common/check_all_patterns_found.pl  | 34 -----------
 .../shell/common/check_all_patterns_found.py  | 37 ++++++++++++
 .../shell/common/check_errors_whitelisted.pl  | 51 ----------------
 .../shell/common/check_errors_whitelisted.py  | 58 +++++++++++++++++++
 .../shell/common/check_no_patterns_found.pl   | 34 -----------
 .../shell/common/check_no_patterns_found.py   | 37 ++++++++++++
 15 files changed, 242 insertions(+), 221 deletions(-)
 delete mode 100755 tools/perf/tests/shell/common/check_all_lines_matched.pl
 create mode 100755 tools/perf/tests/shell/common/check_all_lines_matched.py
 delete mode 100755 tools/perf/tests/shell/common/check_all_patterns_found.pl
 create mode 100755 tools/perf/tests/shell/common/check_all_patterns_found.py
 delete mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.pl
 create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.py
 delete mode 100755 tools/perf/tests/shell/common/check_no_patterns_found.pl
 create mode 100755 tools/perf/tests/shell/common/check_no_patterns_found.py

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2d9379fea267..494a38871560 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -982,7 +982,7 @@ install-tests: all install-gtk
 		$(INSTALL) tests/shell/lib/*.py -m 644 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/common'; \
 		$(INSTALL) tests/shell/common/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/common'; \
-		$(INSTALL) tests/shell/common/*.pl '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/common'; \
+		$(INSTALL) tests/shell/common/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/common'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
 		$(INSTALL) tests/shell/base_probe/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
index f74aab5c5d7f..867545a62908 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
@@ -54,7 +54,7 @@ for BLACKFUNC in $BLACKFUNC_LIST; do
 	PERF_EXIT_CODE=$?
 
 	# check for bad DWARF polluting the result
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"$REGEX_MISSING_DECL_LINE" >/dev/null < $LOGS_DIR/adding_blacklisted.err
 
 	if [ $? -eq 0 ]; then
@@ -75,7 +75,7 @@ for BLACKFUNC in $BLACKFUNC_LIST; do
 			fi
 		fi
 	else
-		"$DIR_PATH/../common/check_all_lines_matched.pl" \
+		"$DIR_PATH/../common/check_all_lines_matched.py" \
 			"$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" \
 			"$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" \
 			"$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" \
@@ -100,7 +100,7 @@ fi
 $CMD_PERF list probe:\* > $LOGS_DIR/adding_blacklisted_list.log
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" \
 	< $LOGS_DIR/adding_blacklisted_list.log
 CHECK_EXIT_CODE=$?
diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index eadac837f108..5058700f566c 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -44,7 +44,7 @@ for opt in "" "-a" "--add"; do
 	$CMD_PERF probe $opt $TEST_PROBE 2> $LOGS_DIR/adding_kernel_add$opt.err
 	PERF_EXIT_CODE=$?
 
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" \
 		< $LOGS_DIR/adding_kernel_add$opt.err
 	CHECK_EXIT_CODE=$?
@@ -60,7 +60,7 @@ done
 $CMD_PERF list probe:\* > $LOGS_DIR/adding_kernel_list.log
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"$RE_LINE_EMPTY" "List of pre-defined events" \
 	"probe:${TEST_PROBE}(?:_\d+)?\s+\[Tracepoint event\]" \
 	"Metric Groups:" < $LOGS_DIR/adding_kernel_list.log
@@ -76,7 +76,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: perf list
 $CMD_PERF probe -l > $LOGS_DIR/adding_kernel_list-l.log
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"\s*probe:${TEST_PROBE}(?:_\d+)?\s+\(on ${TEST_PROBE}(?:[:\+]$RE_NUMBER_HEX)?@.+\)" \
 	< $LOGS_DIR/adding_kernel_list-l.log
 CHECK_EXIT_CODE=$?
@@ -100,11 +100,11 @@ REGEX_STAT_VALUES="\s*\d+\s+probe:$TEST_PROBE"
 # the value should be greater than 1
 REGEX_STAT_VALUE_NONZERO="\s*[1-9][0-9]*\s+probe:$TEST_PROBE"
 REGEX_STAT_TIME="\s*$RE_NUMBER\s+seconds (?:time elapsed|user|sys)"
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"$REGEX_STAT_HEADER" "$REGEX_STAT_VALUES" "$REGEX_STAT_TIME" \
 	"$RE_LINE_COMMENT" "$RE_LINE_EMPTY" < $LOGS_DIR/adding_kernel_using_probe.log
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"$REGEX_STAT_HEADER" "$REGEX_STAT_VALUE_NONZERO" "$REGEX_STAT_TIME" \
 	< $LOGS_DIR/adding_kernel_using_probe.log
 (( CHECK_EXIT_CODE += $? ))
@@ -119,7 +119,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using added probe"
 $CMD_PERF probe -d $TEST_PROBE\* 2> $LOGS_DIR/adding_kernel_removing.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"Removed event: probe:$TEST_PROBE" < $LOGS_DIR/adding_kernel_removing.err
 CHECK_EXIT_CODE=$?
 
@@ -133,7 +133,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "deleting added probe"
 $CMD_PERF list probe:\* > $LOGS_DIR/adding_kernel_list_removed.log
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" \
 	< $LOGS_DIR/adding_kernel_list_removed.log
 CHECK_EXIT_CODE=$?
@@ -149,7 +149,7 @@ $CMD_PERF probe -n --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_dryrun.err
 PERF_EXIT_CODE=$?
 
 # check for the output (should be the same as usual)
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" \
 	< $LOGS_DIR/adding_kernel_dryrun.err
 CHECK_EXIT_CODE=$?
@@ -168,7 +168,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "dry run :: adding probe"
 $CMD_PERF probe --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_01.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" \
 	< $LOGS_DIR/adding_kernel_forceadd_01.err
 CHECK_EXIT_CODE=$?
@@ -180,7 +180,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: first pro
 ! $CMD_PERF probe --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_02.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"Error: event \"$TEST_PROBE\" already exists." \
 	"Error: Failed to add events." < $LOGS_DIR/adding_kernel_forceadd_02.err
 CHECK_EXIT_CODE=$?
@@ -193,7 +193,7 @@ NO_OF_PROBES=`$CMD_PERF probe -l $TEST_PROBE| wc -l`
 $CMD_PERF probe --force --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_03.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"Added new events?:" "probe:${TEST_PROBE}_${NO_OF_PROBES}" \
 	"on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forceadd_03.err
 CHECK_EXIT_CODE=$?
@@ -209,7 +209,7 @@ $CMD_PERF stat -e probe:$TEST_PROBE -e probe:${TEST_PROBE}_${NO_OF_PROBES} -x';'
 PERF_EXIT_CODE=$?
 
 REGEX_LINE="$RE_NUMBER;+probe:${TEST_PROBE}_?(?:$NO_OF_PROBES)?;$RE_NUMBER;$RE_NUMBER"
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"$REGEX_LINE" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" \
 	< $LOGS_DIR/adding_kernel_using_two.log
 CHECK_EXIT_CODE=$?
@@ -229,7 +229,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using doubled probe"
 $CMD_PERF probe --del \* 2> $LOGS_DIR/adding_kernel_removing_wildcard.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"Removed event: probe:$TEST_PROBE" \
 	"Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
 CHECK_EXIT_CODE=$?
@@ -243,7 +243,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple probes"
 $CMD_PERF probe -nf --max-probes=512 -a 'vfs_* $params' 2> $LOGS_DIR/adding_kernel_adding_wildcard.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"probe:vfs_mknod" "probe:vfs_create" "probe:vfs_rmdir" \
 	"probe:vfs_link" "probe:vfs_write" < $LOGS_DIR/adding_kernel_adding_wildcard.err
 CHECK_EXIT_CODE=$?
@@ -268,21 +268,21 @@ test $PERF_EXIT_CODE -ne 139 -a $PERF_EXIT_CODE -ne 0
 PERF_EXIT_CODE=$?
 
 # check that the error message is reasonable
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"Failed to find" \
 	"somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64" \
 	< $LOGS_DIR/adding_kernel_nonexisting.err
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"in this function|at this address" "Error" "Failed to add events" \
 	< $LOGS_DIR/adding_kernel_nonexisting.err
 (( CHECK_EXIT_CODE += $? ))
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"Failed to find" "Error" "Probe point .+ not found" "optimized out" \
 	"Use.+\-\-range option to show.+location range" \
 	< $LOGS_DIR/adding_kernel_nonexisting.err
 (( CHECK_EXIT_CODE += $? ))
-"$DIR_PATH/../common/check_no_patterns_found.pl" \
+"$DIR_PATH/../common/check_no_patterns_found.py" \
 	"$RE_SEGFAULT" < $LOGS_DIR/adding_kernel_nonexisting.err
 (( CHECK_EXIT_CODE += $? ))
 
@@ -301,7 +301,7 @@ fi
 $CMD_PERF probe --add "$TEST_PROBE%return \$retval" 2> $LOGS_DIR/adding_kernel_func_retval_add.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"Added new events?:" "probe:$TEST_PROBE" \
 	"on $TEST_PROBE%return with \\\$retval" \
 	< $LOGS_DIR/adding_kernel_func_retval_add.err
@@ -314,7 +314,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function with retval :: add"
 $CMD_PERF record -e probe:$TEST_PROBE\* -o $CURRENT_TEST_DIR/perf.data -- cat /proc/cpuinfo > /dev/null 2> $LOGS_DIR/adding_kernel_func_retval_record.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"$RE_LINE_RECORD1" "$RE_LINE_RECORD2" \
 	< $LOGS_DIR/adding_kernel_func_retval_record.err
 CHECK_EXIT_CODE=$?
@@ -327,10 +327,10 @@ $CMD_PERF script -i $CURRENT_TEST_DIR/perf.data > $LOGS_DIR/adding_kernel_func_r
 PERF_EXIT_CODE=$?
 
 REGEX_SCRIPT_LINE="\s*cat\s+$RE_NUMBER\s+\[$RE_NUMBER\]\s+$RE_NUMBER:\s+probe:$TEST_PROBE\w*:\s+\($RE_NUMBER_HEX\s+<\-\s+$RE_NUMBER_HEX\)\s+arg1=$RE_NUMBER_HEX"
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script.log
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script.log
 (( CHECK_EXIT_CODE += $? ))
 
diff --git a/tools/perf/tests/shell/base_probe/test_basic.sh b/tools/perf/tests/shell/base_probe/test_basic.sh
index 162838ddc974..a702be7340c0 100755
--- a/tools/perf/tests/shell/base_probe/test_basic.sh
+++ b/tools/perf/tests/shell/base_probe/test_basic.sh
@@ -31,24 +31,24 @@ if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
 	$CMD_PERF probe --help > $LOGS_DIR/basic_helpmsg.log 2> $LOGS_DIR/basic_helpmsg.err
 	PERF_EXIT_CODE=$?
 
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"PERF-PROBE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" \
 		"PROBE\s+SYNTAX" "PROBE\s+ARGUMENT" "LINE\s+SYNTAX" \
 		< $LOGS_DIR/basic_helpmsg.log
 	CHECK_EXIT_CODE=$?
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"LAZY\s+MATCHING" "FILTER\s+PATTERN" "EXAMPLES" "SEE\s+ALSO" \
 		< $LOGS_DIR/basic_helpmsg.log
 	(( CHECK_EXIT_CODE += $? ))
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"vmlinux" "module=" "source=" "verbose" "quiet" "add=" "del=" \
 		"list.*EVENT" "line=" "vars=" "externs" < $LOGS_DIR/basic_helpmsg.log
 	(( CHECK_EXIT_CODE += $? ))
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"no-inlines" "funcs.*FILTER" "filter=FILTER" "force" "dry-run" \
 		"max-probes" "exec=" "demangle-kernel" < $LOGS_DIR/basic_helpmsg.log
 	(( CHECK_EXIT_CODE += $? ))
-	"$DIR_PATH/../common/check_no_patterns_found.pl" \
+	"$DIR_PATH/../common/check_no_patterns_found.py" \
 		"No manual entry for" < $LOGS_DIR/basic_helpmsg.err
 	(( CHECK_EXIT_CODE += $? ))
 
@@ -64,7 +64,7 @@ fi
 # without any args perf-probe should print usage
 $CMD_PERF probe 2> $LOGS_DIR/basic_usage.log > /dev/null
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"[Uu]sage" "perf probe" "verbose" "quiet" "add" "del" "force" \
 	"line" "vars" "externs" "range" < $LOGS_DIR/basic_usage.log
 CHECK_EXIT_CODE=$?
diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
index 44a3ae014bfa..d88bb7ec5da6 100755
--- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
+++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
@@ -34,7 +34,7 @@ for opt in '-a' '-d' '-L' '-V'; do
 	! $CMD_PERF probe $opt 2> $LOGS_DIR/invalid_options_missing_argument$opt.err
 	PERF_EXIT_CODE=$?
 
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"Error: switch .* requires a value" \
 		< $LOGS_DIR/invalid_options_missing_argument$opt.err
 	CHECK_EXIT_CODE=$?
@@ -69,7 +69,7 @@ for opt in '-a xxx -d xxx' '-a xxx -L foo' '-a xxx -V foo' '-a xxx -l' '-a xxx -
 	! $CMD_PERF probe $opt > /dev/null 2> $LOGS_DIR/aux.log
 	PERF_EXIT_CODE=$?
 
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"Error: switch .+ cannot be used with switch .+" < $LOGS_DIR/aux.log
 	CHECK_EXIT_CODE=$?
 
diff --git a/tools/perf/tests/shell/base_report/setup.sh b/tools/perf/tests/shell/base_report/setup.sh
index bb49b0fabb11..10fe4b553c4e 100755
--- a/tools/perf/tests/shell/base_report/setup.sh
+++ b/tools/perf/tests/shell/base_report/setup.sh
@@ -26,7 +26,7 @@ SW_EVENT="cpu-clock"
 $CMD_PERF record -asdg -e $SW_EVENT -o $CURRENT_TEST_DIR/perf.data -- $CMD_LONGER_SLEEP 2> $LOGS_DIR/setup.log
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup.log
 CHECK_EXIT_CODE=$?
 
@@ -41,7 +41,7 @@ echo ==================
 cat $LOGS_DIR/setup-latency.log
 echo ==================
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup-latency.log
 CHECK_EXIT_CODE=$?
 
diff --git a/tools/perf/tests/shell/base_report/test_basic.sh b/tools/perf/tests/shell/base_report/test_basic.sh
index 0dfe7e5fd1ca..9bfec006879b 100755
--- a/tools/perf/tests/shell/base_report/test_basic.sh
+++ b/tools/perf/tests/shell/base_report/test_basic.sh
@@ -26,36 +26,36 @@ if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
 	$CMD_PERF report --help > $LOGS_DIR/basic_helpmsg.log 2> $LOGS_DIR/basic_helpmsg.err
 	PERF_EXIT_CODE=$?
 
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"PERF-REPORT" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" \
 		"OVERHEAD\s+CALCULATION" "SEE ALSO" < $LOGS_DIR/basic_helpmsg.log
 	CHECK_EXIT_CODE=$?
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"input" "verbose" "show-nr-samples" "show-cpu-utilization" \
 		"threads" "comms" "pid" "tid" "dsos" "symbols" "symbol-filter" \
 		< $LOGS_DIR/basic_helpmsg.log
 	(( CHECK_EXIT_CODE += $? ))
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"hide-unresolved" "sort" "fields" "parent" "exclude-other" \
 		"column-widths" "field-separator" "dump-raw-trace" "children" \
 		< $LOGS_DIR/basic_helpmsg.log
 	(( CHECK_EXIT_CODE += $? ))
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"call-graph" "max-stack" "inverted" "ignore-callees" "pretty" \
 		"stdio" "tui" "gtk" "vmlinux" "kallsyms" "modules" \
 		< $LOGS_DIR/basic_helpmsg.log
 	(( CHECK_EXIT_CODE += $? ))
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"force" "symfs" "cpu" "disassembler-style" "source" "asm-raw" \
 		"show-total-period" "show-info" "branch-stack" "group" \
 		< $LOGS_DIR/basic_helpmsg.log
 	(( CHECK_EXIT_CODE += $? ))
-	"$DIR_PATH/../common/check_all_patterns_found.pl" \
+	"$DIR_PATH/../common/check_all_patterns_found.py" \
 		"branch-history" "objdump" "demangle" "percent-limit" "percentage" \
 		"header" "itrace" "full-source-path" "show-ref-call-graph" \
 		< $LOGS_DIR/basic_helpmsg.log
 	(( CHECK_EXIT_CODE += $? ))
-	"$DIR_PATH/../common/check_no_patterns_found.pl" \
+	"$DIR_PATH/../common/check_no_patterns_found.py" \
 		"No manual entry for" < $LOGS_DIR/basic_helpmsg.err
 	(( CHECK_EXIT_CODE += $? ))
 
@@ -76,11 +76,11 @@ REGEX_LOST_SAMPLES_INFO="#\s*Total Lost Samples:\s+$RE_NUMBER"
 REGEX_SAMPLES_INFO="#\s*Samples:\s+(?:$RE_NUMBER)\w?\s+of\s+event\s+'$RE_EVENT_ANY'"
 REGEX_LINES_HEADER="#\s*Children\s+Self\s+Command\s+Shared Object\s+Symbol"
 REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"$REGEX_LOST_SAMPLES_INFO" "$REGEX_SAMPLES_INFO" \
 	"$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_basic.log
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_errors_whitelisted.pl" \
+"$DIR_PATH/../common/check_errors_whitelisted.py" \
 	"$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_basic.err
 (( CHECK_EXIT_CODE += $? ))
 
@@ -96,10 +96,10 @@ PERF_EXIT_CODE=$?
 
 REGEX_LINES_HEADER="#\s*Children\s+Self\s+Samples\s+Command\s+Shared Object\s+Symbol"
 REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER\s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_nrsamples.log
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_errors_whitelisted.pl" \
+"$DIR_PATH/../common/check_errors_whitelisted.py" \
 	"$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_nrsamples.err
 (( CHECK_EXIT_CODE += $? ))
 
@@ -122,7 +122,7 @@ REGEX_LINE_CPUS_ONLINE="#\s+nrcpus online\s*:\s*$MY_CPUS_ONLINE"
 REGEX_LINE_CPUS_AVAIL="#\s+nrcpus avail\s*:\s*$MY_CPUS_AVAILABLE"
 # disable precise check for "nrcpus avail" in BASIC runmode
 test $PERFTOOL_TESTSUITE_RUNMODE -lt $RUNMODE_STANDARD && REGEX_LINE_CPUS_AVAIL="#\s+nrcpus avail\s*:\s*$RE_NUMBER"
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"$REGEX_LINE_TIMESTAMP" "$REGEX_LINE_HOSTNAME" "$REGEX_LINE_KERNEL" \
 	"$REGEX_LINE_PERF" "$REGEX_LINE_ARCH" "$REGEX_LINE_CPUS_ONLINE" \
 	"$REGEX_LINE_CPUS_AVAIL" < $LOGS_DIR/basic_header.log
@@ -156,10 +156,10 @@ PERF_EXIT_CODE=$?
 
 REGEX_LINES_HEADER="#\s*Children\s+Self\s+sys\s+usr\s+Command\s+Shared Object\s+Symbol"
 REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_cpuut.log
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_errors_whitelisted.pl" \
+"$DIR_PATH/../common/check_errors_whitelisted.py" \
 	"$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_cpuut.err
 (( CHECK_EXIT_CODE += $? ))
 
@@ -174,9 +174,9 @@ $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --pid=1 > $LOGS_DIR/basi
 PERF_EXIT_CODE=$?
 
 grep -P -v '^#' $LOGS_DIR/basic_pid.log | grep -P '\s+[\d\.]+%' | \
-	"$DIR_PATH/../common/check_all_lines_matched.pl" "systemd|init"
+	"$DIR_PATH/../common/check_all_lines_matched.py" "systemd|init"
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_errors_whitelisted.pl" \
+"$DIR_PATH/../common/check_errors_whitelisted.py" \
 	"$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_pid.err
 (( CHECK_EXIT_CODE += $? ))
 
@@ -190,10 +190,10 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "pid"
 $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --symbols=dummynonexistingsymbol > $LOGS_DIR/basic_symbols.log 2> $LOGS_DIR/basic_symbols.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_lines_matched.pl" \
+"$DIR_PATH/../common/check_all_lines_matched.py" \
 	"$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < $LOGS_DIR/basic_symbols.log
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_errors_whitelisted.pl" \
+"$DIR_PATH/../common/check_errors_whitelisted.py" \
 	"$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_symbols.err
 (( CHECK_EXIT_CODE += $? ))
 
@@ -208,9 +208,9 @@ $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --symbol-filter=map > $L
 PERF_EXIT_CODE=$?
 
 grep -P -v '^#' $LOGS_DIR/basic_symbolfilter.log | grep -P '\s+[\d\.]+%' | \
-	"$DIR_PATH/../common/check_all_lines_matched.pl" "\[[k\.]\]\s+.*map"
+	"$DIR_PATH/../common/check_all_lines_matched.py" "\[[k\.]\]\s+.*map"
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_errors_whitelisted.pl" \
+"$DIR_PATH/../common/check_errors_whitelisted.py" \
 	"$DIR_PATH/stderr-whitelist.txt" < $LOGS_DIR/basic_symbolfilter.err
 (( CHECK_EXIT_CODE += $? ))
 
@@ -224,7 +224,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "symbol filter"
 $CMD_PERF report -i $CURRENT_TEST_DIR/perf.data.1 --stdio --header-only > $LOGS_DIR/latency_header.log
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	", context_switch = 1, " < $LOGS_DIR/latency_header.log
 CHECK_EXIT_CODE=$?
 
@@ -236,10 +236,10 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "latency header"
 $CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data.1 > $LOGS_DIR/latency_default.log 2> $LOGS_DIR/latency_default.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"# Overhead   Latency  Command" < $LOGS_DIR/latency_default.log
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_errors_whitelisted.pl" \
+"$DIR_PATH/../common/check_errors_whitelisted.py" \
 	"stderr-whitelist.txt" < $LOGS_DIR/latency_default.err
 (( CHECK_EXIT_CODE += $? ))
 
@@ -251,10 +251,10 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "default report for latency profi
 $CMD_PERF report --latency --stdio -i $CURRENT_TEST_DIR/perf.data.1 > $LOGS_DIR/latency_latency.log 2> $LOGS_DIR/latency_latency.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"#  Latency  Overhead  Command" < $LOGS_DIR/latency_latency.log
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_errors_whitelisted.pl" \
+"$DIR_PATH/../common/check_errors_whitelisted.py" \
 	"stderr-whitelist.txt" < $LOGS_DIR/latency_latency.err
 (( CHECK_EXIT_CODE += $? ))
 
@@ -266,11 +266,11 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "latency report for latency profi
 $CMD_PERF report --hierarchy --sort latency,parallelism,comm,symbol --parallelism=1,2 --stdio -i $CURRENT_TEST_DIR/perf.data.1 > $LOGS_DIR/parallelism_hierarchy.log 2> $LOGS_DIR/parallelism_hierarchy.err
 PERF_EXIT_CODE=$?
 
-"$DIR_PATH/../common/check_all_patterns_found.pl" \
+"$DIR_PATH/../common/check_all_patterns_found.py" \
 	"#           Latency  Parallelism / Command / Symbol" \
 	< $LOGS_DIR/parallelism_hierarchy.log
 CHECK_EXIT_CODE=$?
-"$DIR_PATH/../common/check_errors_whitelisted.pl" \
+"$DIR_PATH/../common/check_errors_whitelisted.py" \
 	"stderr-whitelist.txt" < $LOGS_DIR/parallelism_hierarchy.err
 (( CHECK_EXIT_CODE += $? ))
 
diff --git a/tools/perf/tests/shell/common/check_all_lines_matched.pl b/tools/perf/tests/shell/common/check_all_lines_matched.pl
deleted file mode 100755
index fded48959a3f..000000000000
--- a/tools/perf/tests/shell/common/check_all_lines_matched.pl
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/usr/bin/perl
-# SPDX-License-Identifier: GPL-2.0
-
-@regexps = @ARGV;
-
-$max_printed_lines = 20;
-$max_printed_lines = $ENV{TESTLOG_ERR_MSG_MAX_LINES} if (defined $ENV{TESTLOG_ERR_MSG_MAX_LINES});
-
-$quiet = 1;
-$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
-
-$passed = 1;
-$lines_printed = 0;
-
-while (<STDIN>)
-{
-	s/\n//;
-
-	$line_matched = 0;
-	for $r (@regexps)
-	{
-		if (/$r/)
-		{
-			$line_matched = 1;
-			last;
-		}
-	}
-
-	unless ($line_matched)
-	{
-		if ($lines_printed++ < $max_printed_lines)
-		{
-			print "Line did not match any pattern: \"$_\"\n" unless $quiet;
-		}
-		$passed = 0;
-	}
-}
-
-exit ($passed == 0);
diff --git a/tools/perf/tests/shell/common/check_all_lines_matched.py b/tools/perf/tests/shell/common/check_all_lines_matched.py
new file mode 100755
index 000000000000..732a48255fa8
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_all_lines_matched.py
@@ -0,0 +1,47 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import re
+import sys
+
+
+def main(argv):
+    sys.stdin.reconfigure(encoding="utf-8", errors="surrogateescape")
+    sys.stdout.reconfigure(encoding="utf-8", errors="surrogateescape")
+    max_printed = 20
+    if "TESTLOG_ERR_MSG_MAX_LINES" in os.environ:
+        try:
+            max_printed = int(os.environ["TESTLOG_ERR_MSG_MAX_LINES"])
+        except ValueError:
+            pass
+
+    quiet = True
+    try:
+        if int(os.environ.get("TESTLOG_VERBOSITY", "0")) >= 2:
+            quiet = False
+    except ValueError:
+        pass
+
+    passed = True
+    lines_printed = 0
+
+    for line in sys.stdin:
+        line = line.rstrip("\n")
+        matched = False
+        for r in argv:
+            if re.search(r, line):
+                matched = True
+                break
+        if not matched:
+            show = lines_printed < max_printed
+            lines_printed += 1
+            if show and not quiet:
+                print(f'Line did not match any pattern: "{line}"')
+            passed = False
+
+    return 0 if passed else 1
+
+
+if __name__ == "__main__":
+    sys.exit(main(sys.argv[1:]))
diff --git a/tools/perf/tests/shell/common/check_all_patterns_found.pl b/tools/perf/tests/shell/common/check_all_patterns_found.pl
deleted file mode 100755
index 11bdf1d3460a..000000000000
--- a/tools/perf/tests/shell/common/check_all_patterns_found.pl
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/usr/bin/perl
-# SPDX-License-Identifier: GPL-2.0
-
-@regexps = @ARGV;
-
-$quiet = 1;
-$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
-
-%found = ();
-$passed = 1;
-
-while (<STDIN>)
-{
-	s/\n//;
-
-	for $r (@regexps)
-	{
-		if (/$r/)
-		{
-			$found{$r} = 1;	# FIXME: maybe add counters -- how many times was the regexp matched
-		}
-	}
-}
-
-for $r (@regexps)
-{
-	unless (exists $found{$r})
-	{
-		print "Regexp not found: \"$r\"\n" unless $quiet;
-		$passed = 0;
-	}
-}
-
-exit ($passed == 0);
diff --git a/tools/perf/tests/shell/common/check_all_patterns_found.py b/tools/perf/tests/shell/common/check_all_patterns_found.py
new file mode 100755
index 000000000000..42cf4bc2c0d4
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_all_patterns_found.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import re
+import sys
+
+
+def main(argv):
+    sys.stdin.reconfigure(encoding="utf-8", errors="surrogateescape")
+    sys.stdout.reconfigure(encoding="utf-8", errors="surrogateescape")
+    quiet = True
+    try:
+        if int(os.environ.get("TESTLOG_VERBOSITY", "0")) >= 2:
+            quiet = False
+    except ValueError:
+        pass
+
+    found = set()
+    for line in sys.stdin:
+        line = line.rstrip("\n")
+        for r in argv:
+            if re.search(r, line):
+                found.add(r)
+
+    passed = True
+    for r in argv:
+        if r not in found:
+            if not quiet:
+                print(f'Regexp not found: "{r}"')
+            passed = False
+
+    return 0 if passed else 1
+
+
+if __name__ == "__main__":
+    sys.exit(main(sys.argv[1:]))
diff --git a/tools/perf/tests/shell/common/check_errors_whitelisted.pl b/tools/perf/tests/shell/common/check_errors_whitelisted.pl
deleted file mode 100755
index c57d355dd76e..000000000000
--- a/tools/perf/tests/shell/common/check_errors_whitelisted.pl
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/usr/bin/perl
-# SPDX-License-Identifier: GPL-2.0
-
-$whitelist_file = shift;
-
-if (defined $whitelist_file)
-{
-	open (INFILE, $whitelist_file) or die "Checker error: Unable to open the whitelist file: $whitelist_file\n";
-	@regexps = <INFILE>;
-	close INFILE or die "Checker error: Unable to close the whitelist file: $whitelist_file\n";
-}
-else
-{
-	@regexps = ();
-}
-
-$max_printed_lines = 20;
-$max_printed_lines = $ENV{TESTLOG_ERR_MSG_MAX_LINES} if (defined $ENV{TESTLOG_ERR_MSG_MAX_LINES});
-
-$quiet = 1;
-$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
-
-$passed = 1;
-$lines_printed = 0;
-
-while (<STDIN>)
-{
-	s/\n//;
-
-	$line_matched = 0;
-	for $r (@regexps)
-	{
-		chomp $r;
-		if (/$r/)
-		{
-			$line_matched = 1;
-			last;
-		}
-	}
-
-	unless ($line_matched)
-	{
-		if ($lines_printed++ < $max_printed_lines)
-		{
-			print "Line did not match any pattern: \"$_\"\n" unless $quiet;
-		}
-		$passed = 0;
-	}
-}
-
-exit ($passed == 0);
diff --git a/tools/perf/tests/shell/common/check_errors_whitelisted.py b/tools/perf/tests/shell/common/check_errors_whitelisted.py
new file mode 100755
index 000000000000..72250d4cd8c5
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_errors_whitelisted.py
@@ -0,0 +1,58 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import re
+import sys
+
+
+def main(argv):
+    sys.stdin.reconfigure(encoding="utf-8", errors="surrogateescape")
+    sys.stdout.reconfigure(encoding="utf-8", errors="surrogateescape")
+    if argv:
+        whitelist = argv[0]
+        try:
+            with open(whitelist, encoding="utf-8", errors="surrogateescape") as f:
+                regexps = [ln.rstrip("\n") for ln in f]
+        except OSError as e:
+            print(f"Checker error: Unable to open the whitelist file: {whitelist}", file=sys.stderr)
+            sys.exit(e.errno or 1)
+    else:
+        regexps = []
+
+    max_printed = 20
+    if "TESTLOG_ERR_MSG_MAX_LINES" in os.environ:
+        try:
+            max_printed = int(os.environ["TESTLOG_ERR_MSG_MAX_LINES"])
+        except ValueError:
+            pass
+
+    quiet = True
+    try:
+        if int(os.environ.get("TESTLOG_VERBOSITY", "0")) >= 2:
+            quiet = False
+    except ValueError:
+        pass
+
+    passed = True
+    lines_printed = 0
+
+    for line in sys.stdin:
+        line = line.rstrip("\n")
+        matched = False
+        for r in regexps:
+            if re.search(r, line):
+                matched = True
+                break
+        if not matched:
+            show = lines_printed < max_printed
+            lines_printed += 1
+            if show and not quiet:
+                print(f'Line did not match any pattern: "{line}"')
+            passed = False
+
+    return 0 if passed else 1
+
+
+if __name__ == "__main__":
+    sys.exit(main(sys.argv[1:]))
diff --git a/tools/perf/tests/shell/common/check_no_patterns_found.pl b/tools/perf/tests/shell/common/check_no_patterns_found.pl
deleted file mode 100755
index 770999e87a5f..000000000000
--- a/tools/perf/tests/shell/common/check_no_patterns_found.pl
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/usr/bin/perl
-# SPDX-License-Identifier: GPL-2.0
-
-@regexps = @ARGV;
-
-$quiet = 1;
-$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
-
-%found = ();
-$passed = 1;
-
-while (<STDIN>)
-{
-	s/\n//;
-
-	for $r (@regexps)
-	{
-		if (/$r/)
-		{
-			$found{$r} = 1;
-		}
-	}
-}
-
-for $r (@regexps)
-{
-	if (exists $found{$r})
-	{
-		print "Regexp found: \"$r\"\n" unless $quiet;
-		$passed = 0;
-	}
-}
-
-exit ($passed == 0);
diff --git a/tools/perf/tests/shell/common/check_no_patterns_found.py b/tools/perf/tests/shell/common/check_no_patterns_found.py
new file mode 100755
index 000000000000..92842ec0a1e1
--- /dev/null
+++ b/tools/perf/tests/shell/common/check_no_patterns_found.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import re
+import sys
+
+
+def main(argv):
+    sys.stdin.reconfigure(encoding="utf-8", errors="surrogateescape")
+    sys.stdout.reconfigure(encoding="utf-8", errors="surrogateescape")
+    quiet = True
+    try:
+        if int(os.environ.get("TESTLOG_VERBOSITY", "0")) >= 2:
+            quiet = False
+    except ValueError:
+        pass
+
+    found = set()
+    for line in sys.stdin:
+        line = line.rstrip("\n")
+        for r in argv:
+            if re.search(r, line):
+                found.add(r)
+
+    passed = True
+    for r in argv:
+        if r in found:
+            if not quiet:
+                print(f'Regexp found: "{r}"')
+            passed = False
+
+    return 0 if passed else 1
+
+
+if __name__ == "__main__":
+    sys.exit(main(sys.argv[1:]))
-- 
2.56.0

