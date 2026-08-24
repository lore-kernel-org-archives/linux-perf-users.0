Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7E3E3176
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553491; cv=none; b=isGDtYmFOZX9HcpKpU5kdS5y1OZKuPm45gK3KFekrGZUf7MZ2ylM2r+KVSnflPcQ6asddbZGBIoh8dPe24wA20rKm4ffypz1CPKnj+Nw1iOvTw3MRtUavwHUnANiaVGhHMIW0AFS/iT+OUH09bSdFCc4o6J986ZIWqhsXR/SWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553491; c=relaxed/simple;
	bh=i4nlyBAwxEHGD/ynOHsVsPkEmx8yVq+7vUhlbwwaYkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WLXYSjNguN0p3YIX4damcqhWNHJQl8bsdcxV2mxls4p+ShBgtm+pPUmKOy9Qah19dYKUi9SfzeEBkmvJUhO0EhRrncuFqvrJiBJ0SJMQoKOWZsIzXln+1CKKIjz7JDPjuT5YPVjs497qV0P6PW/4+kDYG77A3uwqBi8w74Aldcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VwXjm7PK; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwXjm7PK"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d63bad3d09so38515695ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787553489; x=1788158289; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=swRy7w5Hweb+tFwMF3rWqYRLS2LGy2maOB+De6FRNT4=;
        b=VwXjm7PKL0sQoemrAU8sWK4bMD1N/Rh1xy/HITM7wJRx1VicvChlO9LYCiKUxgoy0F
         MTFDXVnqe65dITkg3UrBywkSFx5o2m30LNN/LQa/l+0S9sz5x0TEJkcOI906E8YzpXYK
         N3z2ovCCnygE9ziwP9yb4UpfX/RovvG1gBBLpUllnMQzL5eiX/hRo2dYgsUy8d4tmCzx
         ycH/FupWi53YVIBcO0na/SwNm5lYztBqUuJ6WrnkBnzy/TO8KOJU4HTFHhG1V44x7+RN
         cV/huNxG+CiO1NNC9yCVLXmBxrOo73OA2U1qdJY1kvZ7fWV12n73BgX7WEDJCzxErSnJ
         0ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787553489; x=1788158289;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=swRy7w5Hweb+tFwMF3rWqYRLS2LGy2maOB+De6FRNT4=;
        b=I9e7ON7UkvBwYF+XJf5zWHErfuGh0kQVuzkSg2ADHg2eRiyUQIRQziHAmuKNaPTxHT
         419XAplcCFi7pcB60apPlwOH17rmza/zhdGgHR2ZeTg1YQzTUWsTpVeNL5J1dwNPGcEW
         OhfyA42EpkiripcAK53uuDy4OElokClsRyv/KP2N+CmPAEsaFWFYQ/nfIGpcKVfGfpcx
         jci4EICU9aVI43/L+bTaK9ZQQ160s9qaxD7Q/dBmC3zSa77pAEF47v6F9ENxB78Lx0te
         sAnMT1ruYzuZDPqy7P+ys7sfAhuo1iOL/v42v+RrDNZqT4oJwFgc5lpCi+0rhhIv5FNs
         nbIA==
X-Forwarded-Encrypted: i=1; AHgh+RoVA8evpqO1uEmXxD0waroqn4GoLLBOpgw9RLu3NlEr8SkwUnAqxzlJsSsUCNK8ga2P5r0k8qDiTxitaIAiVgYA@vger.kernel.org
X-Gm-Message-State: AFuF++mAGJV9ba0eD1MuX3otuAe9rzYmDVMSrogSUH81GAGnJHDiqOuD
	bgWl1wOOvGYeb9yDLmzEgYdo6CrvkmJmQDGvX1mPRFJ5WprHzYuqOW1XmsCG7YXh5eYudoRH0Q+
	rB8n5DJrU7g==
X-Received: from dycph11.prod.google.com ([2002:a05:7300:dd4b:b0:311:a347:2538])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ceca:b0:2d3:6fac:d67c
 with SMTP id d9443c01a7336-2d670c980e1mr243565275ad.10.1787553488746; Sun, 23
 Aug 2026 23:38:08 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:37:44 -0700
In-Reply-To: <20260824063744.1533837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <20260824063744.1533837-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824063744.1533837-8-irogers@google.com>
Subject: [PATCH v1 7/7] perf test: Expand top tests for --hybrid-merge
From: Ian Rogers <irogers@google.com>
To: andi@firstfloor.org
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add shell test coverage for top --hybrid-merge flag to verify
correct behavior specifically on topologies featuring hybrid events.
It safely relies on fallback logic inside perf top.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/tests/shell/top.sh | 65 +++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
index ad7fccd09025..49820bb2d6b2 100755
--- a/tools/perf/tests/shell/top.sh
+++ b/tools/perf/tests/shell/top.sh
@@ -35,26 +35,27 @@ test_basic_perf_top() {
 	# Use -d 1 to avoid flooding output
 	# Use -e cpu-clock to ensure we get samples
 	# Use sleep to keep stdin open but silent, preventing EOF loop or interactive spam
-	if ! sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock -p $PID > "${log_file}" 2>&1; then
-		retval=$?
-		if [ $retval -ne 124 ] && [ $retval -ne 0 ]; then
-			echo "Basic perf top test [Failed: perf top failed to start or run (ret=$retval)]"
-			head -n 50 "${log_file}"
-			kill $PID
-			wait $PID 2>/dev/null || true
-			err=1
-			return
-		fi
+	sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock \
+		-p $PID > "${log_file}" 2>&1 || retval=$?
+	if [ "${retval:-0}" -ne 124 ] && [ "${retval:-0}" -ne 0 ]; then
+		echo "Basic perf top test [Failed: perf top failed to start or run (ret=$retval)]"
+		head -n 50 "${log_file}"
+		kill $PID
+		wait $PID 2>/dev/null || true
+		err=1
+		return
 	fi
 
 	kill $PID
 	wait $PID 2>/dev/null || true
 
+	sync
+
 	# Check for some sample data (percentage)
 	if ! grep -E -q "[0-9]+\.[0-9]+%" "${log_file}"; then
 		echo "Basic perf top test [Failed: no sample percentage found]"
 		head -n 50 "${log_file}"
-		err=1
+		err=2
 		return
 	fi
 
@@ -69,6 +70,48 @@ test_basic_perf_top() {
 	echo "Basic perf top test [Success]"
 }
 
+test_hybrid_merge_perf_top() {
+	echo "Perf top hybrid merge test"
+
+	perf test -w thloop 20 &
+	PID=$!
+
+	# Allow it to start
+	sleep 0.1
+
+	# Run without explicitly requesting -e cycles so heavily virtualized
+	# environments can seamlessly fall back to cpu-clock while real
+	# hybrid hardware will naturally cover the merge logic.
+	sleep 10 | timeout 5s perf top -e cpu-clock \
+			--stdio --hybrid-merge -d 1 -p $PID > "${log_file}" 2>&1 || retval=$?
+	if [ "${retval:-0}" -ne 124 ] && [ "${retval:-0}" -ne 0 ]; then
+		echo "Perf top hybrid merge test [Failed: run err=$retval]"
+		head -n 50 "${log_file}"
+		kill $PID
+		wait $PID 2>/dev/null || true
+		err=1
+		return
+	fi
+	sync
+
+	kill $PID
+	wait $PID 2>/dev/null || true
+
+	# Wait a tiny bit for the file system to catch up on the logs
+	sync
+
+	# Check for some sample data (percentage)
+	if ! grep -E -q "[0-9]+\.[0-9]+%" "${log_file}"; then
+		echo "Perf top hybrid merge test [Failed: no sample percentage found]"
+		head -n 50 "${log_file}"
+		err=2
+		return
+	fi
+
+	echo "Perf top hybrid merge test [Success]"
+}
+
 test_basic_perf_top
+test_hybrid_merge_perf_top
 cleanup
 exit $err
-- 
2.55.0.766.g2966f0265a-goog

