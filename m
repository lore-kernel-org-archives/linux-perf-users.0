Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634657;
	b=2vsifDoBrpN8hz3etgtcnLxSb8D2NC2h8BngR1444EvnLwwiFb2qWdf/KWmbC1sOh5AM
	 iLX+vZKwL41FoI0kWxiXaVeT1ajDWydtc/zSFbwounsTfOcUbqVF/KYOgWk72Ev4TnmhF
	 Xr3QosGTr3Ew3y2RXEKGnRiOZ8arAMhmH/07E0E724OP/ERhj9xhGKkW/u5O8IFXdJXDi
	 R4msg0FoE+sSuQo7gfHTq6vL4ZfvXCs8tR6w7f2Zkeg+J4sekWpqsu78kAqN3ZWINjUgz
	 UvlmV3vZQEon+tncpvP2tQpUxjuydTS8qArA/LJTOrpCfaSnRANgzAKe/u85HXBJmUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=szWoBBkaaybqAV8yTP+DE9/CHBddLTwI9vS5xMrLr9o=;
	b=n0V15FRK+ERCQyf6Ky+tPWwJgE+UxM8ltJEdebutJCtzlddQ/WHLZhu8ZAyk828V0JuC
	 QP/Gd48hdAR+VBT9b9gGg5dWdhJ3yO0XuJv1m9GFqr5wunW4S4UFgimtklExHmcK8vKGY
	 aRV18q+AiuJ92+m7aTkJ8yDNU7LhDfJteM4Kn69CFqpzPanOWFzhrmgPw7lRrjWulnsR6
	 4OXey62sxIieb+krWrkSzTw1G1gWnvAmuVNcIDV8EgX/pmUdmIgC0MLasS7Hy4NVK8HRI
	 FHzUIw0IP8oc4OSki1WrGjmUzas6BblMmC9zCFrQjtBH4Zm6n7sIb5ZMPKco3LiN9CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQlaZdrW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154A606A6A9;
	Wed, 25 Nov 2026 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQlaZdrW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9B41F000F2;
	Wed, 25 Nov 2026 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634657;
	bh=szWoBBkaaybqAV8yTP+DE9/CHBddLTwI9vS5xMrLr9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQlaZdrWnmSW/O87CWfBhfs62CFL7m11e3/EyUsP6VNdwGs01zvnsJbe8XsLFyOV+
	 XslxUv2nHUzJgZRVHoUbfNfmLaW42+6GLDNftgL/PqOlSmvKx1Zlu1dQ1JduK/NMBY
	 i1L8SD/u+R5S624aJ1ERaUPWsYd0Cy/qmoTKFvSGGGd2MiUozIUQunqwtrilf6addG
	 cbzqnpcT6iM7uyyKwTg7SKzh4Bal2sWPDeagAAWRZWqHuf/+0Nt2xi57Z2g2Vjrv4i
	 RBy7l02Kvw6scO9b+FbPKgZj+coEiUTO04nQaLBakYDg8huieshAMdtGXpVYxXO97k
	 q67YwOBnhsS2w==
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
Subject: [PATCH v13 17/19] perf test: Avoid online CPUs in the offline stat test
Date: Wed, 25 Nov 2026 16:23:10 -0300
Message-ID: <20261125192312.34134-18-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
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

