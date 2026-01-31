Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C036EA85
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889751; cv=none; b=C1CF7ggNa+RhzcXjEg4aZpe/oMormOCgXmxNJ0qI+LycN5ilxGXaBtoh5V0VWol4wHIuzWcRxKS88dzh+h0WyYNUJUTKBqlUvDNeqtnCgTF6C9+iioLFVgXrgy0Wvm428ZkIfI9VBk9jC3wG+SZEQ9ztoQmp6YXlawsTQu4lZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889751; c=relaxed/simple;
	bh=K/CPeSJdNznlVRFAe+IRwrvzwNL/FwQ7692V228ImDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MIBCWdJxS6T1BHKZ2JGJ0EI2C3Kv7+kiNUkdP9wskKXK4vIhvjh9V4pTb4x8KWMhGimOeuR/GpDchkLotnExg+1cW+Vk2HFxUGa2A4mDlODWtLw83dsS82SXsJT/cUKudmH98QDq9LdQ4rdC8YorXpRjcNCFKUP1EEPfn4AyQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3pDRCsXB; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3pDRCsXB"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b795cff830so849988eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Jan 2026 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769889750; x=1770494550; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUC+WDnW7L44j8AWJ3iUoM1jUSgb/IrmAbWsvMnp/cQ=;
        b=3pDRCsXBHAOuSjCMeU7K6hiY1LaqGX5CYy2SH2q+fpVl9wU02tMa3L2rG1sYiDKprr
         gPFuBvSF4B784L4+V+mXiw7FKdinuVQe9fiyttRL+U61uww+K7WegsZucprF8rrSEf8I
         9xJqExILH+It1v+J3pXIaUu5YcTkPnDG9EAKKd3urb4vaqyzXZ3L9RXZQJ8S7w2JvlMz
         XyKQTOxF9qf9Czg58VdiRUrnv8x8YuKKVVYjSvVzz6KPV5JfAIFUaqXLymtxjIuNoRck
         YvaLRKu9Kyyhnyvl2DY7+BwRmsAyAEFpg6LGWijdvHhkqtvsfAXfqXRaaqQ6KJAgnWIF
         Cv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889750; x=1770494550;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUC+WDnW7L44j8AWJ3iUoM1jUSgb/IrmAbWsvMnp/cQ=;
        b=Z4hGwtmxDdnGmIJGQcmTzezfegMzsne0pzm3L+tgc5uLSe5lxuL+JuEdRcyhh6qAAU
         W61s5HsroIpwrLyoj04qZp/ldpyisHJyZ8jdGvG2CClMKQDqV8GXlLTZTjbdyVgZCj7I
         gp0eNi5vtP5pS3iNJddbLqzS2cknBj0Pj4wvVgJm0eO41aSRxFJqQAir6ElhraUqw+hk
         y0IavJ/KZ73Ya4cMEbdETDw7TCuEDuy9Pio+xmmsTTE+cHgP8ViplU7tzKyYFVwtX2g+
         CxlaOVY9+ZtUfAN+d2BCOXzxeeqe7Hw3O2zGL+YYSJC1GnxTjJjvBOrQttwrizbfRvuH
         XoyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGBgO5TkGkbHU9yegr+1mroS0mnHw9fjbGBvvxvU0Z8OiKssreD/+EWAqxs7arD/T5qSJ3h4QstnI2iQTf1b/a@vger.kernel.org
X-Gm-Message-State: AOJu0YzdU7V74Br89rKQjrcQEGEnYQ82rECmtGNC9cTVeCb7Alee8B9P
	iRmfP5NfqXWPv6g2hy88vV/NcV2Ie7PllICgEHKupfarPOtGZmBhW9+DGFn7CfDOy6fO+yhenAh
	B7G1Jz+V7Tg==
X-Received: from dybpg11.prod.google.com ([2002:a05:7301:414b:b0:2b7:499d:745f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6095:b0:2b7:2d5e:3f49
 with SMTP id 5a478bee46e88-2b7c865542bmr2862726eec.10.1769889749601; Sat, 31
 Jan 2026 12:02:29 -0800 (PST)
Date: Sat, 31 Jan 2026 12:02:19 -0800
In-Reply-To: <20260131200224.1296136-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131200224.1296136-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131200224.1296136-2-irogers@google.com>
Subject: [PATCH v2 1/6] perf test kvm: Add stat live testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, Yunseong Kim <ysk@kzalloc.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Blake Jones <blakejones@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure the `perf kvm stat live -p ..` has some basic functionality.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/kvm.sh | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
index 2a399b83fe80..f88e859025c4 100755
--- a/tools/perf/tests/shell/kvm.sh
+++ b/tools/perf/tests/shell/kvm.sh
@@ -7,9 +7,10 @@ set -e
 err=0
 perfdata=$(mktemp /tmp/__perf_kvm_test.perf.data.XXXXX)
 qemu_pid_file=$(mktemp /tmp/__perf_kvm_test.qemu.pid.XXXXX)
+log_file=$(mktemp /tmp/__perf_kvm_test.live_log.XXXXX)
 
 cleanup() {
-	rm -f "${perfdata}"
+	rm -f "${perfdata}" "${log_file}"
 	if [ -f "${qemu_pid_file}" ]; then
 		if [ -s "${qemu_pid_file}" ]; then
 			qemu_pid=$(cat "${qemu_pid_file}")
@@ -96,6 +97,32 @@ test_kvm_buildid_list() {
 	echo "perf kvm buildid-list test [Success]"
 }
 
+test_kvm_stat_live() {
+	echo "Testing perf kvm stat live"
+
+        # Run perf kvm live for 5 seconds, monitoring that PID
+	# Use sleep to keep stdin open but silent, preventing EOF loop or interactive spam
+	if ! sleep 10 | timeout 5s perf kvm stat live -p "${qemu_pid}" > "${log_file}" 2>&1; then
+		retval=$?
+		if [ $retval -ne 124 ] && [ $retval -ne 0 ]; then
+			echo "perf kvm stat live [Failed: perf kvm stat live failed to start or run (ret=$retval)]"
+			head -n 50 "${log_file}"
+			err=1
+			return
+		fi
+	fi
+
+	# Check for some sample data (percentage)
+	if ! grep -E -q "[0-9]+\.[0-9]+%" "${log_file}"; then
+		echo "perf kvm stat live [Failed: no sample percentage found]"
+		head -n 50 "${log_file}"
+		err=1
+		return
+	fi
+
+	echo "perf kvm stat live test [Success]"
+}
+
 setup_qemu() {
 	# Find qemu
 	if [ "$(uname -m)" = "x86_64" ]; then
@@ -148,6 +175,7 @@ if [ $err -eq 0 ]; then
 	test_kvm_stat
 	test_kvm_record_report
 	test_kvm_buildid_list
+	test_kvm_stat_live
 fi
 
 cleanup
-- 
2.53.0.rc1.225.gd81095ad13-goog

