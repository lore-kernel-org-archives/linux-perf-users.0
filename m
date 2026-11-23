Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471287;
	b=sAtNOQTV7o6PZLAEqshJIzb1Wxt34iqfD8ue3Upw8oh1bvFGGFZviZcomJvgLCLri53f
	 3xwYwcypsO4BOhzHBLBi4UdNMEVY0BHGvK2/2XVFBsSptNpGqyz1sLxMm/zAzrvQzf1BS
	 /b7Iu1QXC9bXWYE6y5pcmnxYJZb9Q+eXG0+Q6elqzNHEUEbR85H7AXsqDvjoPhg28eWhR
	 5hPUYi2rwzD/T2SeVSE72TWuWuhBk57KyFwi043Q5Rnq5LYZzBDM9HvcCXiOC4DFWqGjF
	 H5dv3Nm6Io1TQegM3wSH7ID8gpi113dfHWAzoiqmvbpmHQBcDzxpvrgosAMVT4WS/lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=szWoBBkaaybqAV8yTP+DE9/CHBddLTwI9vS5xMrLr9o=;
	b=MLReDZj0OSWv4FgNBdLFJoIpKdHbo8X/RAJYKpycM9+ti0b81Td5DkJs+DEA6eWWeovX
	 LFZ52PvBqeBd9HulV3CKjqzPwy+z2dK8DbEQfaZKYtNhUGHQtgtT7ds2TrqUyXbyh/T+w
	 QkfgBXS/Orytxdgn13TjA80oPmp1DOJiTyVcDZhbdDXHq4FNmVC7B2xeorkKTr4vKbAw4
	 5ZF2/rhtyIsYwLzf4U9GReAH6b38S0mlQLgyyeYUem+LCHgFrde5wuqqvxIMNZxchBMhr
	 q2SG94sO2MyutgVlBN9a0LzQPRbR54LMSe/9amOsC3zZomWFYqeNDlQu+t2uWGgMB0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPfHxP9p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F25606A331;
	Mon, 23 Nov 2026 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPfHxP9p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9881F000C0;
	Mon, 23 Nov 2026 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471287;
	bh=szWoBBkaaybqAV8yTP+DE9/CHBddLTwI9vS5xMrLr9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DPfHxP9pkOYpSWi+rSjMxaD3VUS8/BWppCspQZqU9zEIXK6SuHIE9yjDGZ7PYfpqp
	 3uj7AdpGtgaFlbs7gHHh456GiCQgTE1yBCAwIInvF4T28aaELp4iUu2vy+HzygFOHl
	 +jXUfvCBmpcky0MM0Cu4qflQTAeTcGgYagsVXzxuhRHg1Sg6Nc1BPfdcA8sVPMGG5n
	 tKhMD5c/4PxmRDrUWgD4KxtUYQkZYDBAkY2cwOj5szKCElwnsFFZ4vWv0yw3gWFZvh
	 ypMupWkVw5UXVP6qlJDZytN+86Jxp8vj4EWw8/WiEQkn9tT+R7Kx6Ki3HLtOPVHjsG
	 XhH/2jozkWwdw==
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
Subject: [PATCH v12 17/19] perf test: Avoid online CPUs in the offline stat test
Date: Mon, 23 Nov 2026 19:00:22 -0300
Message-ID: <20261123220024.14891-18-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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

find_offline_cpu() treats a missing cpuN/online file as an offline CPU,
but kernels without CPU hotplug also lack it for online CPUs.  The test
then expects "No supported events found." from a working CPU.

Treat a present CPU as offline only if its online file reads 0.  Keep
the absent cpuN case to exercise an invalid CPU, and skip if neither
exists.

Fixes: 5123509628e1ebe7 ("perf tests stat: Add test for error for an offline CPU")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/stat.sh | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index ac9e031831daca9c..7cd9999fd526bbd6 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -43,21 +43,28 @@ test_null_stat() {
 }
 
 find_offline_cpu() {
-  for i in $(seq 1 4096)
+  for i in $(seq 0 4096)
   do
-    if [[ ! -f /sys/devices/system/cpu/cpu$i/online || \
-          $(cat /sys/devices/system/cpu/cpu$i/online) == "0" ]]
+    if [[ ! -d /sys/devices/system/cpu/cpu$i ]]
     then
       echo $i
-      return
+      return 0
+    elif [[ -f /sys/devices/system/cpu/cpu$i/online && \
+            $(cat /sys/devices/system/cpu/cpu$i/online) == "0" ]]
+    then
+      echo $i
+      return 0
     fi
   done
-  echo "Failed to find offline CPU"
-  exit 1
+  return 1
 }
 
 test_offline_cpu_stat() {
-  cpu=$(find_offline_cpu)
+  if ! cpu=$(find_offline_cpu)
+  then
+    echo "Offline CPU stat command test [Skipped - no offline CPU]"
+    return
+  fi
   echo "Offline CPU stat command test (cpu $cpu)"
   if ! perf stat "-C$cpu" -e cycles true 2>&1 | grep -E -q "No supported events found."
   then
-- 
2.56.0

