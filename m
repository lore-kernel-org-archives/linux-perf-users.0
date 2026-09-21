Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200B4BEE5A
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005670; cv=none; b=Cs/6EZSZeo6NdKBnQdM50zfqhNmvseBNxyvotqXEU5dTERJovjZkyq8Yu0IsFi6lfbWFlWAzumkfCTO6ag/Xp7/2ZflT1+xHchiNc7wOS2+RnEWor5wpE7Yj2f1CbMQ4+j/fqVwMzDWMP6cWOGGoLFoT2H5l2mJYEgrgTRGsIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005670; c=relaxed/simple;
	bh=wJj5GXZvrtIY5U1jzMBIIobCu779Aq8NC9i0Ztxqe+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAYfLVuP9efy0ja5E6BmnSTYY5Q8jpHcFPSKKoS2ZGdSKO32dGESinVQtDfLS1F639zxPVPWukwBUZKI0uAroyJM8YMIDYiuDk7vfbEfhUKq4Vv49RhUtJsYfOtUf3FWsFMhvlKNDHpFaHTQA4S5+EjYNEXrmTrH9NptbxEVj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O3FDlMtg; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3FDlMtg"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso15388145e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790005664; x=1790610464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nNk3gKnBrsdOSw55H+tL4fJGQ9ze+6N52EZUoCt+Fu4=;
        b=O3FDlMtgkUqoHL3PAr8+3nO/jEG5HLsvbSJQQXpa3ajCH5MYEF5Z+ReR4F+/CfQ0qm
         E12NTxWF+rmvDGNsu4+CSLYGk4k0aqaFJH63wMoVHdA6uMQxWpChNPjVq62LBuGwaGQA
         V18GZlQWpfBFM007y88ndqpnI2JY4hEXgGooT4fDgr6XiWymXn7hUjWjH+hWbng+i7eu
         hgmGJH+I7uT93g6R7L9nIGfCydypUNZKIZzMCdv51V5OSeVaY5xCEH/dVRO6XjI+Wk7I
         2H2RR7E/1TejKEZ++KWaaNF/oK/bSYWJMpNAG8iwvu1pdYV4I+6+fa796eegn6xRImig
         sEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005664; x=1790610464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nNk3gKnBrsdOSw55H+tL4fJGQ9ze+6N52EZUoCt+Fu4=;
        b=sLnCPvQ4Yyt2fqHvsYFX1uIZSmL6mY5ltZGtniORlK8x59vajT0WD4feI+beiamQo4
         4m4thgsOlyAoDSrZpu4lRkZWZfYtSuX+fb3/WxBc9yrIyVYoXrGfRU8lWwdh4HGjur/j
         nTEV5i5voeS+BOuPH71Sit8fOfYuuprV5GYZSyTomcb7/7thx8tLFYSsmm4S62Ucn3dz
         agrsVLGTu/XaDs2qywWI3kHjFSh0zmAQ+gpAlh/fqDMF3qrNflllwnmPkbzeT6mgMnQY
         3OMAye2dYzfwSBN93dNsRyprvm5uOqWSB9Frqg9+yG7EUxzgmn614CvkYcUlr/LNRn6q
         1emg==
X-Gm-Message-State: AFuF++myBG7XheATVFY7Mkilvlr/at+BSE7yG848k1TQ6OLZTF+u0RpV
	fxAm37Sbsg/SaCW9WT0ylG+iJbcOE+mKEVvkBD+U3T92y3jyIiT4MCDtxCRK2bIsQ6I=
X-Gm-Gg: AYBFou2tQxOoABt53soKyd9V0k0/JplLqk6VC1wu2qKZ0JvUXaeAQzR1OAmv4LgoyzN
	MiYwcfPDHFYQMJnNVhTGiurNVeSqPmBS6leU7jjIQLfbSHhjp8/wYW89xLKQLfW2e4SPuOGPANe
	z6WGRAAIKor/eweRBnpeC3o4FhtRD+BqHL+0s2UTuSeaRKFPRxZg11udIQnsrIJPYoehvseRYOX
	IAPK4S3pwfX6NS4SravO9RTJ/iucdkNJeVwFTYAUYgNFYvmSupHJnRPdr+uHXmm29MmuogVH9gM
	8hKMYXoZ4/LwRVN1XweZnpr+sPiXZg4vm1qsU0Lfkvr1bLhrg6bwnqaSpcBanhDhhf9ZHBq3gCY
	lzdQ1UFP973HcoWorQNHJhanujwo9Rvya/dbM/G+/4VvpPUP7mlWt2TE7y4Q1XjsNabA3Q9RIID
	VptnTh8sb7qW4qjeg5d6Cwr1wR8ZSolpDzj/qc3/aPwkNmZPMQ6kLmSBms4YhUkkHCWEbwNNKTa
	PE=
X-Received: by 2002:a05:600c:3b8e:b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-49fc57144aamr200308715e9.8.1790005663884;
        Mon, 21 Sep 2026 08:47:43 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd103325sm279287355e9.9.2026.09.21.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:47:43 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Sep 2026 16:47:28 +0100
Subject: [PATCH 1/2] perf test: Remove redundant shellcheck source paths
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-james-perf-shellcheck-source-v1-1-adcfc107c997@linaro.org>
References: <20260921-james-perf-shellcheck-source-v1-0-adcfc107c997@linaro.org>
In-Reply-To: <20260921-james-perf-shellcheck-source-v1-0-adcfc107c997@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The minimum required shellcheck version treats paths with leading
variables as starting from the script's current directory, so shellcheck
is able to source all of these files without needing the extra
directives:

  v0.7.2 - 2021-04-19

  Changed
   * SC1090: A leading $x/ or $(x)/ is now treated as ./ when locating files

Remove them to avoid future copy pasting and confusion that they are
required. Because the paths weren't actually followed, they didn't have
to be accurate and accepted any string to silence the warning.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/annotate.sh                        | 1 -
 tools/perf/tests/shell/base_probe/test_adding_kernel.sh   | 1 -
 tools/perf/tests/shell/diff.sh                            | 1 -
 tools/perf/tests/shell/inject_aslr.sh                     | 1 -
 tools/perf/tests/shell/jitdump-python.sh                  | 1 -
 tools/perf/tests/shell/list.sh                            | 1 -
 tools/perf/tests/shell/pipe_test.sh                       | 1 -
 tools/perf/tests/shell/probe_vfs_getname.sh               | 2 --
 tools/perf/tests/shell/python-use.sh                      | 1 -
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh     | 2 --
 tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 2 --
 tools/perf/tests/shell/record.sh                          | 2 --
 tools/perf/tests/shell/record_weak_term.sh                | 1 -
 tools/perf/tests/shell/script_dlfilter.sh                 | 1 -
 tools/perf/tests/shell/stat+csv_output.sh                 | 1 -
 tools/perf/tests/shell/stat+json_output.sh                | 1 -
 tools/perf/tests/shell/stat+std_output.sh                 | 1 -
 tools/perf/tests/shell/stat_metrics_values.sh             | 1 -
 tools/perf/tests/shell/test_arm_callgraph_fp.sh           | 1 -
 tools/perf/tests/shell/test_brstack.sh                    | 1 -
 tools/perf/tests/shell/test_data_symbol.sh                | 1 -
 tools/perf/tests/shell/test_intel_pt.sh                   | 1 -
 tools/perf/tests/shell/test_perf_data_converter_json.sh   | 1 -
 tools/perf/tests/shell/test_test_junit_output.sh          | 1 -
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh   | 1 -
 tools/perf/tests/shell/trace+probe_vfs_getname.sh         | 1 -
 tools/perf/tests/shell/trace_btf_enum.sh                  | 1 -
 tools/perf/tests/shell/trace_btf_general.sh               | 1 -
 tools/perf/tests/shell/trace_exit_race.sh                 | 1 -
 tools/perf/tests/shell/trace_record_replay.sh             | 2 --
 tools/perf/tests/shell/trace_summary.sh                   | 1 -
 31 files changed, 36 deletions(-)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 689de58e9238..26411edf5cb4 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -6,7 +6,6 @@ set -e
 
 shelldir=$(dirname "$0")
 
-# shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 testsym="noploop"
diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index 555a825d55f2..eadac837f108 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -19,7 +19,6 @@ TEST_RESULT=0
 # include working environment
 . "$DIR_PATH/../common/init.sh"
 
-# shellcheck source=lib/probe_vfs_getname.sh
 . "$DIR_PATH/../lib/probe_vfs_getname.sh"
 
 TEST_PROBE=${TEST_PROBE:-"inode_permission"}
diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff.sh
index fe05fdebcab5..88f37b8ef893 100755
--- a/tools/perf/tests/shell/diff.sh
+++ b/tools/perf/tests/shell/diff.sh
@@ -11,7 +11,6 @@ perfdata3=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 testprog="perf test -w thloop"
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 testsym="test_loop"
diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/shell/inject_aslr.sh
index d83c2591db8f..6ee4c8b5c850 100755
--- a/tools/perf/tests/shell/inject_aslr.sh
+++ b/tools/perf/tests/shell/inject_aslr.sh
@@ -6,7 +6,6 @@ set -e
 set -o pipefail
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 sym="noploop"
diff --git a/tools/perf/tests/shell/jitdump-python.sh b/tools/perf/tests/shell/jitdump-python.sh
index 05aaa3bd900b..ad345a35c16d 100755
--- a/tools/perf/tests/shell/jitdump-python.sh
+++ b/tools/perf/tests/shell/jitdump-python.sh
@@ -3,7 +3,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 SHELLDIR=$(dirname $0)
-# shellcheck source=lib/setup_python.sh
 . "${SHELLDIR}"/lib/setup_python.sh
 
 OUTPUT=$(${PYTHON} -Xperf_jit -c 'import os, sys; print(os.getpid(), sys.is_stack_trampoline_active())' 2> /dev/null)
diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
index 0c04b3159cef..14a03e0290ed 100755
--- a/tools/perf/tests/shell/list.sh
+++ b/tools/perf/tests/shell/list.sh
@@ -5,7 +5,6 @@
 set -e
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
 list_output=$(mktemp /tmp/__perf_test.list_output.json.XXXXX)
diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index ce68d850c983..f4eb129afda2 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -3,7 +3,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 sym="noploop"
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 5fe5682c28ce..36dc319eea0e 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -4,13 +4,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
 [ "$(id -u)" = 0 ] || exit 2
 
-# shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
 
 add_probe_vfs_getname
diff --git a/tools/perf/tests/shell/python-use.sh b/tools/perf/tests/shell/python-use.sh
index fd2ee5390060..2d6017d5dd9d 100755
--- a/tools/perf/tests/shell/python-use.sh
+++ b/tools/perf/tests/shell/python-use.sh
@@ -5,7 +5,6 @@
 set -e
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
 MODULE_DIR=$(dirname "$(which perf)")/python
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index eca629ee83f0..4c9a308a450d 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -10,9 +10,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-# shellcheck source=lib/probe.sh
 . "$(dirname "$0")/lib/probe.sh"
-# shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname "$0")/lib/probe_vfs_getname.sh"
 
 libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 002f7037f182..ce20663601dc 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -9,13 +9,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-# shellcheck source=lib/probe.sh
 . "$(dirname "$0")/lib/probe.sh"
 
 skip_if_no_perf_probe || exit 2
 [ "$(id -u)" = 0 ] || exit 2
 
-# shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname "$0")/lib/probe_vfs_getname.sh"
 
 record_open_file() {
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 625240809fce..7c6657aa1c52 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -8,10 +8,8 @@ shelldir=$(dirname "$0")
 . "${shelldir}"/lib/perf_record.sh
 
 
-# shellcheck source=lib/waiting.sh
 . "${shelldir}"/lib/waiting.sh
 
-# shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 testsym="test_loop"
diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/tests/shell/record_weak_term.sh
index 811b00ffb47a..da418669ab52 100755
--- a/tools/perf/tests/shell/record_weak_term.sh
+++ b/tools/perf/tests/shell/record_weak_term.sh
@@ -5,7 +5,6 @@
 set -e
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
 # Find the first event with a specified period, such as
diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests/shell/script_dlfilter.sh
index aaed92bb7828..88222280f609 100755
--- a/tools/perf/tests/shell/script_dlfilter.sh
+++ b/tools/perf/tests/shell/script_dlfilter.sh
@@ -5,7 +5,6 @@
 set -e
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
 # skip if there's no compiler
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index cd6fff597091..a5b34c42e8d7 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -6,7 +6,6 @@
 
 set -e
 
-# shellcheck source=lib/stat_output.sh
 . "$(dirname $0)"/lib/stat_output.sh
 
 csv_sep=@
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 85d1ad7186c6..4969ad70b67b 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -9,7 +9,6 @@ set -e
 skip_test=0
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 pythonchecker=$(dirname $0)/lib/perf_json_output_lint.py
 
diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 9c4b92ecf448..64c2b81f02de 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -6,7 +6,6 @@
 
 set -e
 
-# shellcheck source=lib/stat_output.sh
 . "$(dirname $0)"/lib/stat_output.sh
 
 stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
diff --git a/tools/perf/tests/shell/stat_metrics_values.sh b/tools/perf/tests/shell/stat_metrics_values.sh
index 86c5c7f70933..0982f6b9737a 100755
--- a/tools/perf/tests/shell/stat_metrics_values.sh
+++ b/tools/perf/tests/shell/stat_metrics_values.sh
@@ -3,7 +3,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
 grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }
diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index 9172dd68a81d..8adfe81fa8dc 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -3,7 +3,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 if [ "$(uname -m)" != "aarch64" ]; then
diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 71550e0b37ba..fd05ebb5ae74 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -5,7 +5,6 @@
 # German Gomez <german.gomez@arm.com>, 2022
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 # skip the test if the hardware doesn't support branch stack sampling
diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index d61b5659a46d..edc528c11dda 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -6,7 +6,6 @@
 
 shelldir=$(dirname "$0")
 
-# shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 skip_if_no_mem_event() {
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 26243ff760ec..a2e87ef09593 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -8,7 +8,6 @@ set -e
 perf list pmu | grep -q 'intel_pt//' || exit 2
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/waiting.sh
 . "${shelldir}"/lib/waiting.sh
 
 skip_cnt=0
diff --git a/tools/perf/tests/shell/test_perf_data_converter_json.sh b/tools/perf/tests/shell/test_perf_data_converter_json.sh
index 35d81e39a26c..c2c4ade7609a 100755
--- a/tools/perf/tests/shell/test_perf_data_converter_json.sh
+++ b/tools/perf/tests/shell/test_perf_data_converter_json.sh
@@ -7,7 +7,6 @@ set -e
 err=0
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
diff --git a/tools/perf/tests/shell/test_test_junit_output.sh b/tools/perf/tests/shell/test_test_junit_output.sh
index 5104ac1e1e6d..38a29e646906 100755
--- a/tools/perf/tests/shell/test_test_junit_output.sh
+++ b/tools/perf/tests/shell/test_test_junit_output.sh
@@ -7,7 +7,6 @@ set -e
 err=0
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
 result=$(mktemp /tmp/__perf_test.output.xml.XXXXX)
diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 7adf9755d6de..83505093257d 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -4,7 +4,6 @@
 
 set -e
 
-# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 7a0b1145d0cd..28d3aa8a9e33 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -10,7 +10,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 03e9f680a4a6..b1a659e0245f 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -9,7 +9,6 @@ non_syscall="timer:hrtimer_start"
 
 TESTPROG="perf test -w landlock"
 
-# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 skip_if_no_perf_trace || exit 2
 [ "$(id -u)" = 0 ] || exit 2
diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index 7a94a5743924..06f4a704daf8 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -4,7 +4,6 @@
 
 err=0
 
-# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 
 file1=$(mktemp /tmp/file1_XXXX)
diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index db300cde94fb..024ff8f1d388 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -6,7 +6,6 @@
 # lost. Specifically, trace the exiting syscall of "true" 10 times and ensure
 # the output contains 10 correct lines.
 
-# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_trace || exit 2
diff --git a/tools/perf/tests/shell/trace_record_replay.sh b/tools/perf/tests/shell/trace_record_replay.sh
index 38fcafcdfb91..76a7bba6ef23 100755
--- a/tools/perf/tests/shell/trace_record_replay.sh
+++ b/tools/perf/tests/shell/trace_record_replay.sh
@@ -4,9 +4,7 @@
 
 # Check that perf trace works with record and replay
 
-# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
-# shellcheck source=lib/perf_record.sh
 . "$(dirname $0)"/lib/perf_record.sh
 
 skip_if_no_perf_trace || exit 2
diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index b80dea77cec6..d5da1d7d8d88 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -4,7 +4,6 @@
 
 # Check that perf trace works with various summary mode
 
-# shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_trace || exit 2

-- 
2.43.0

