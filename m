Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CA2D6E5C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774780; cv=none; b=kcwEDSJJVwPa2Hpu47j34UcZ8SIeVJPPE/ecy5aigzVa6VZZbuNsy4tLuWJfyCO5+CgxA7A2rELHh6a6ZVSsEoVieYp6KlMx5KVloEMUnfjsWEzbXKtVXy5ifGN47JlWeCjAUA6dHpjzPDb+JjM+weq3yh6U2ENUGe+R59ktYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774780; c=relaxed/simple;
	bh=tQHrkngzVLUEqGsMf/7XWZpqU1lbr91is2l0EGQbIBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Wo6iezXsCbER9bB5YdUpMqOVrITWcv5IYT6DmMWp/1rxlKeVq8CH17/8Y8LvE+yizJskZlAGEfEajgtKIuI4K+lRixXxvPUehH8gUPqe68mWlG1GkPbBjRCc31U06tIV8aU5tWgou1P1CRWcpzfXTk02xVzsxX1e+zZUMtLtkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+dUx1/k; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+dUx1/k"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso466561eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 17:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770774778; x=1771379578; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/GTs5A9yek4he0BUlqIoIsxHRmHOoQilOIUJRqh028=;
        b=X+dUx1/ku5ehRavVOUt0AZynPHHNl8iFUuUVzloC2yPNiyIEHMDljQ/vjrCa+9BJn5
         Uim4Wc5uHjX1sCWJYyQUOOj+cVc8SDkmpeUiLXENeeyQQUwy8oSML1g/4DahWrDlH4GF
         x99/zFFs02mOZw2ur/u/IUDJ2mxh526I87TsOwNQg6yZ0/zKgdhpaGoxij48ZGyzTCQv
         8ChBipy+mQMy4qzPAtV/FlezuW64ELL3VAeXUw9PSMrjUGrQsTUUfLkA1q1Tpn6em2yt
         hEXJA0MEMtpZzzm87BRH07TL8JFGLgNrIjIuB/eNcjfYBwgC3fogy8+3ltDFiy1NK7sC
         91LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774778; x=1771379578;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/GTs5A9yek4he0BUlqIoIsxHRmHOoQilOIUJRqh028=;
        b=LP3COOrlIMEd2WPIM83syHJ+v0wKO//F+54mN/mVec8WwZwurCHgvFK/qOfypAVb95
         ktiBVhy2JNkBLcNAO46QbToEswhzwOU6YCHRBtN0tBOMqJst80ee1fl6i5zSoa9t1Vs0
         RIikkXBzMdi05aXPYDnkD9QBZh1VKwQ8w4ab6hPFpiHU6Vh3zBVQ847KKCUI6l9I7v9I
         FYskgPhRwbHohj1k7PRjVSmm5JTSKj73HsenJYBxTFTREZ7yYkxekf0/sCigdLZWi6NG
         b4bewCZi4LH1WTTX/NPPLQz1+L+h3FDGxO5RZw8xlOFZNtEAcfcb4xKtrLSXt8KINLic
         14rg==
X-Forwarded-Encrypted: i=1; AJvYcCXJCKZqXyY4UPAIBjNWIYHP5hRxFmgtgTmblw+Jn8vzo6M+z54MAm8MRRDRmf2qrBZDZUoWXfMe5NW4nDRc3bI6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uWzyIjIcz/79k1dztocwsBERRO9PzuBt1YhwvCw5UgsW4RJB
	1JLS6zejGcNKA7YsJ9rlXRwZc/TqkXr1pSSnkxMm8VrtbI6r2SBDLDzwlJjFB4eau8Et7LF0dOX
	bp6+SKIr91A==
X-Received: from dybhf8.prod.google.com ([2002:a05:7301:2a08:b0:2ac:3025:bdaa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2f99:b0:2b7:2664:ae9f
 with SMTP id 5a478bee46e88-2ba9e01564emr134737eec.1.1770774778056; Tue, 10
 Feb 2026 17:52:58 -0800 (PST)
Date: Tue, 10 Feb 2026 17:52:42 -0800
In-Reply-To: <20260211015242.2700218-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260211015242.2700218-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260211015242.2700218-6-irogers@google.com>
Subject: [PATCH v1 5/5] perf test: perf data --to-ctf testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If babeltrace is detected check that --to-ctf functions with a data
file and in pipe mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../shell/test_perf_data_converter_ctf.sh     | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_perf_data_converter_ctf.sh

diff --git a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
new file mode 100755
index 000000000000..334eebc9945e
--- /dev/null
+++ b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
@@ -0,0 +1,104 @@
+#!/bin/bash
+# 'perf data convert --to-ctf' command test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+ctf_dir=$(mktemp -d /tmp/__perf_test.ctf.XXXXX)
+
+cleanup()
+{
+	rm -f "${perfdata}"
+	rm -rf "${ctf_dir}"
+	trap - exit term int
+}
+
+trap_cleanup()
+{
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit ${err}
+}
+trap trap_cleanup exit term int
+
+check_babeltrace_support()
+{
+	if ! perf check feature libbabeltrace
+	then
+		echo "perf not linked with libbabeltrace, skipping test"
+		exit 2
+	fi
+}
+
+test_ctf_converter_file()
+{
+	echo "Testing Perf Data Conversion Command to CTF (File input)"
+	# Record some data
+	if ! perf record -o "$perfdata" -F 99 -g -- perf test -w noploop
+	then
+		echo "Failed to record perf data"
+		err=1
+		return
+	fi
+
+	# Cleanup previous ctf dir
+	rm -rf "${ctf_dir}"
+
+	# Convert
+	if ! perf data convert --to-ctf "$ctf_dir" --force -i "$perfdata"
+	then
+		echo "Perf Data Converter Command to CTF (File input) [FAILED]"
+		err=1
+		return
+	fi
+
+	if [ -d "${ctf_dir}" ] && [ "$(ls -A "${ctf_dir}")" ]
+	then
+		echo "Perf Data Converter Command to CTF (File input) [SUCCESS]"
+	else
+		echo "Perf Data Converter Command to CTF (File input) [FAILED]"
+		echo "    Output directory empty or missing"
+		err=1
+	fi
+}
+
+test_ctf_converter_pipe()
+{
+	echo "Testing Perf Data Conversion Command to CTF (Pipe mode)"
+
+	# Cleanup previous ctf dir
+	rm -rf "${ctf_dir}"
+
+	# Record to stdout and pipe to $perfdata file
+	if ! perf record -o - -F 99 -g -- perf test -w noploop > "$perfdata"
+	then
+		echo "Failed to record perf data"
+		err=1
+		return
+	fi
+
+	if ! perf data convert --to-ctf "$ctf_dir" --force -i "$perfdata"
+	then
+		echo "Perf Data Converter Command to CTF (Pipe mode) [FAILED]"
+		err=1
+		return
+	fi
+
+	if [ -d "${ctf_dir}" ] && [ "$(ls -A "${ctf_dir}")" ]
+	then
+		echo "Perf Data Converter Command to CTF (Pipe mode) [SUCCESS]"
+	else
+		echo "Perf Data Converter Command to CTF (Pipe mode) [FAILED]"
+		echo "    Output directory empty or missing"
+		err=1
+	fi
+}
+
+check_babeltrace_support
+test_ctf_converter_file
+test_ctf_converter_pipe
+
+exit ${err}
-- 
2.53.0.239.g8d8fc8a987-goog

