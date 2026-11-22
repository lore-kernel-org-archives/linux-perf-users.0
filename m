Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383692;
	b=4HqPAQrft4YBryoOt8kCpVEVyyuJc+/xkMl1RgvsExJbeq73G+lLJSLU/2uWUlX58R2d
	 /SW+z64tBa9T424enO3AKHwKyuLY6jtLlShcyikF937xGp2W30biPvq1bCx0SPwsb9Kut
	 U3gCi7PnunIgYhM6v09Req+6KtdtUZPv7QxeSrJJUVTFiR8/H+xkFecDfPTSTopNnFhFB
	 7YypfeTKKOhCfrHSU0fAnOxIrUSJTteQetXibFtH5gAmGW18AvaOhEtg3Lj1uCv/40Dtb
	 NtVfBSQDk98zAGqc1/u+aOUI6mlF47A2agju1ghtvfmd0ANbwEvis7ggQlZrwZIyqpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383692;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JZCH1WDOcfMsn+B645g6CmxiN6dgXP9BgX4hZ1VxRqw=;
	b=y3rkXsF+xts5EjyymROtdr/t8RUpQui3HaVXoSdWWox9fR7cA7lBEC0JmYeAYlmUNqfQ
	 v47T2P1EjV2RkDcRFOAC/1HLh2pjpayB5ZGUMqit02ImnY7zbiXgbryI7bZAoaqDL9B/6
	 1Bo1yJvCYqrA9AA3pGH5eqSt8FQXflb6Ebstbn3rtXNt0sxhoTMMp2IVS979awIrnVFtu
	 rzkQW9g8joQVCRJLss7Ynxykr613WKllEqQDQwA/ynzVlN++VUBQpxhCqMbOCnS0bg02G
	 QPa4pxcYO4Stch8p8mbUwsuCMyETQOuhBIk/8KOxR/afbum31+R+lRDhTBISlFpEJxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgoG5UTX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBC606A31D;
	Sun, 22 Nov 2026 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgoG5UTX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837011F000CF;
	Sun, 22 Nov 2026 21:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383692;
	bh=JZCH1WDOcfMsn+B645g6CmxiN6dgXP9BgX4hZ1VxRqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jgoG5UTXG0ry30FTzQbtsht4Yiwk4X71hv0KkmZLonAY3pE3vxeih7y88ZqFEh0vR
	 QJ8hIM7pur/jfosDKZLVzLimXpwZaU2nUtRUoln02iwitkKCFngu8zvFR62M/j9whG
	 CwmmhgM6e6ZkW7OeKMq5hscboFE66kE4Y8ad9l99YXTlCV5s+YtcDFkJ6gGQG+FiRJ
	 zRJexJI4VqMpjAbkG1Laf/R2Nj+ok8f0t0a/nM5Pv/X0JVQsvmJOuH3m1PJ0HrOGFa
	 7TbUWMcVwsYHfxDu0nA3UoHx+ohw2rHROPdQ7QVhqJXaqIwDbbY8ftMY/WHjBfK4ii
	 aOKYYqkUzRxvA==
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
Subject: [PATCH v11 17/19] perf test: Avoid online CPUs in the offline stat test
Date: Sun, 22 Nov 2026 18:40:23 -0300
Message-ID: <20261122214025.16769-18-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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
2.56.1

