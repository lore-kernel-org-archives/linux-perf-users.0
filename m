Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546025;
	b=AIz11aaamA4nWq+WvIbLr53TgMPYqE4Lqafm6v2/LRD82u231q7g623mI0TomVwzS9c9
	 MAj877AT+oL4/nvdhpGQFM2Dph8rUgfTGdBUNY0QgA1B/up7du2VbinLFwNkVzhiWpFhp
	 It52pa/LFD80wD5y6VXuw8WY007Gkt2yDOdInfPHRjGPoB30arGRJMyUJVJeW8c5MIiAy
	 8lQzVNCEbK9LpfMaatBHqWiKjKIN046E5M9zR/NKSl8FS8mJ2qtyyPbVx2xVCtA4Dh5K3
	 5mgvRmYuuL4oHBCu83WGtsUII5wVERk1OT+zI0fgXYdr8Dqk2M4BE9EEq9VHc33vNhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546025;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eBoTwm88TsMRWm0NT2X9XKKVRZmbXeDrAjNy/+v2arg=;
	b=3vuZinhukU+VEywJOI8hx6zgQ2psLBh+lXSaj27SLUBFWdlyQPxDSXhPppnsCrV5idmm
	 gfxFg/Rpj2Go0p54uzoOJQOfmyb9dx3YtN7Jy6e1MVXQpyiGZAzTBH/tqxMpLNS+1G9G2
	 TDCrp8ihy4+ZDHLiwWylu/H6WKrdB3iSxarTj+pYDQ6NnvJ/nX996c3sLZ7mHr044OylM
	 NpvpD8O30KzBqfy44bNEEw+tTmgOZcNLHYjtLzzj+E8T5z5Tnc16vx4lt2z3pVOIGJmxr
	 rEeVDi4Ei/TzoEIWibvKGc7nST42qXSA3B0+HMJyUvpMv9yw8ZFszoCCIgxWq7En1tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRNfeth8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D079606A326;
	Tue, 24 Nov 2026 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRNfeth8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563A11F000F4;
	Tue, 24 Nov 2026 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546025;
	bh=eBoTwm88TsMRWm0NT2X9XKKVRZmbXeDrAjNy/+v2arg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bRNfeth8rAGRPCD7B2LPdxB+k6kGxNvj9Z9JQrBrtRHC8nSpnLuk99nKGCokhE1qE
	 MdbAhsFHSlLXWBhR4nH827CwSTIhNDC/6Y+9JCQ+SjqLARm+2zQUSS4Pu++SElVz1H
	 GQEGTav4v6rYDZJurmrVAuMFG8bjadL20YyxP3Csw8LXfwASYUb8476rw/avq0CUcb
	 bN7+DfJmAHLjX0VCk3rOxDbaGw4+a703geahNXA+bmbqRwVW2OTFXmGTi3Bcs1T5b4
	 ZH7w9Rwa295ZvmQ7EMReHh3ph+qdVWh1VF8GvENlo/aGfcODPqpX043gxP0x86O4AF
	 OndM4LbXHea1A==
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
Subject: [PATCH v1 15/17] perf tests lock: Exercise perf lock report and info
Date: Tue, 24 Nov 2026 15:46:02 -0300
Message-ID: <20261124184604.24983-16-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124184604.24983-1-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
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
 tools/perf/tests/shell/lock_contention.sh | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 5df9a0cd48a34f4f..a3056136e3767eec 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -65,6 +65,44 @@ test_record()
 	fi
 }
 
+test_report()
+{
+	echo "Testing perf lock report"
+	# the output goes to the stderr and all keys are printed unless -F
+	# selects a subset, so walk the sort keys
+	for key in acquired contended avg_wait wait_total wait_max wait_min; do
+		perf lock report -i ${perfdata} -k ${key} -E 5 2> ${result}
+		if ! grep -q "Name" "${result}"; then
+			echo "[Fail] perf lock report --key ${key} has no output:" "$(cat "${result}")"
+			err=1
+			exit
+		fi
+	done
+
+	perf lock report -i ${perfdata} -c -v -E 5 2> ${result}
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
+	perf lock info -i ${perfdata} 2> ${result}
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
@@ -347,6 +385,8 @@ test_csv_output()
 check
 
 test_record
+test_report
+test_info
 test_bpf
 test_record_concurrent
 test_aggr_task
-- 
2.56.0

