Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743548;
	b=cKJv7ydO0AFNbfdbEiiQ420S2ZBETgM413EMwCB4cbalyaOXwjbr2ryt2REjbfwoy+WB
	 cVnHvgfFNCSccjwbnwjx06Qk8j5NCwOP9NLvxpoI6/0t8/95F5okksWANN5aPoB9sl/CH
	 QIiSYKsky3X2kNPPdQzVZbbLBJMAnsSi+yyUa1Yu3xyQmciHVJhWxJDkTzyZGveZa9u13
	 LTXOikMM5ju3q46mORb7pR8BrpT9+dEVj+Ot+uqUrYNE/o5xlVHlluMmU3aHpjz/wBnrI
	 t8jQZe+Jc7DR9ehgX1h+dub+dpp/MqlMHN24YpExc8EQf8AO69x96d4SZqhyHYwut1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=n2DIOXLiiSsHaiRctOxg+Am+oK1savNQq8G2wbq4itM=;
	b=tHJ4b73Dtf3d0PgrtbhGPnA78/vLYuIKT17GKbDxuTtheasBzXrevT4Eu2ERqBv3LNz7
	 M3ZCxeXS5+Wltk3WZgf0icwjt5W4NmH+/bXuYb6X8Npgs1tXzzetzKEIpes/tJGJPkY+Q
	 60dOxkh7jzpFcDg+fGOq43iOSOiTs2o9gJ7ae3eN+WRdYNB3o2q32IKkAKgNOuTVzUF1p
	 bugwbpOYR2P437Zt5dk7A4pWyT47HTlZF1m/CnuWR9pXGyL+XFMebCO4ZSUHRXwNNa5lT
	 Uhqv5GxzEoRjkznj8xA9pN7Tlt2gW923Jh1rlV84JBVrUcrsPfOxcMk6GvXDYDSO9Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CctVd8/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FB606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CctVd8/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62D61F0089B;
	Fri, 27 Nov 2026 01:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743547;
	bh=n2DIOXLiiSsHaiRctOxg+Am+oK1savNQq8G2wbq4itM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CctVd8/XYY+cJQqI3cbpXMRYSh39LOcaiCLC1/tAd0UQxaBmwwyc55E3/9+9GupJj
	 tOpCEDt0Dvs83IP7O5y7u7qERaaf1FaqqFEKsqs1xt/cPiHw9SmcnpyXIMuyuALDxS
	 bfwLlpZ39m/Ao4MmtFsv8YwS0vWJgyjaoBC+luNtpaQSbfU0PEUmPJBAJ6j5yEi9Sa
	 TckgKvFhBqgNqRM5l0Slnn3Btvh/kfX9fPNTMDL/cYWTYYo3Kdwuhp0tOLXRzko9YK
	 Mrgjgwzn7cQy02CAKgFoLWgp271bCw+9zulrFEeEt0r1d4c46p3pzf9XcvfztUgMUt
	 QoFKfNCvmKwBA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 16/18] perf tests lock: Exercise perf lock report and info
Date: Thu, 26 Nov 2026 22:37:59 -0300
Message-ID: <20261127013801.14841-17-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127013801.14841-1-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
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

The lock contention test records and reads a perf.data file, but only
through perf lock contention.  Walk the report sort keys, combine the
locks, and check the thread and lock lists of perf lock info on the
same file.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lock_contention.sh | 55 +++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 5df9a0cd48a34f4f..ebff99bd3688bb94 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -65,6 +65,59 @@ test_record()
 	fi
 }
 
+test_report()
+{
+	echo "Testing perf lock report"
+	# the output goes to the stderr and all keys are printed unless -F
+	# selects a subset, so walk the sort keys
+	for key in acquired contended avg_wait wait_total wait_max wait_min; do
+		if ! perf lock report -i ${perfdata} -k ${key} -E 5 2> ${result}
+		then
+			echo "[Fail] perf lock report --key ${key} failed"
+			err=1
+			return
+		fi
+		if ! grep -q "Name" "${result}"; then
+			echo "[Fail] perf lock report --key ${key} has no output:" "$(cat "${result}")"
+			err=1
+			exit
+		fi
+	done
+
+	if ! perf lock report -i ${perfdata} -c -v -E 5 2> ${result}
+	then
+		echo "[Fail] perf lock report --combine-locks failed"
+		err=1
+		return
+	fi
+	if ! grep -q "Name" "${result}"; then
+		echo "[Fail] perf lock report --combine-locks has no output:" "$(cat "${result}")"
+		err=1
+		exit
+	fi
+}
+
+test_info()
+{
+	echo "Testing perf lock info"
+	if ! perf lock info -i ${perfdata} 2> ${result}
+	then
+		echo "[Fail] perf lock info failed"
+		err=1
+		return
+	fi
+	if ! grep -q "Thread ID" "${result}"; then
+		echo "[Fail] perf lock info has no thread list:" "$(cat "${result}")"
+		err=1
+		exit
+	fi
+	if ! grep -q "Address of instance" "${result}"; then
+		echo "[Fail] perf lock info has no lock list:" "$(cat "${result}")"
+		err=1
+		exit
+	fi
+}
+
 test_bpf()
 {
 	echo "Testing perf lock contention --use-bpf"
@@ -347,6 +400,8 @@ test_csv_output()
 check
 
 test_record
+test_report
+test_info
 test_bpf
 test_record_concurrent
 test_aggr_task
-- 
2.56.0

