Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749576;
	b=ep0dxWNDG2wwqV2q1J8MW50JveVwVHRzjShv8Qg6ElHp52grgOLuwDrciPNuW6eDWEEz
	 Iti4p0ab6xgcmP87eXYuNm98qxuf5Je1PqdSPaRsGs06WE4r02RBj4nG7K8+egCkeZl/k
	 NbakbjIUNas2xb7TD61T5ZxqenfXDUI7PFqbVlFUZ+mIlDaq6BBtjlOprBErA9nwL/EpH
	 XvioJhBca0SOFewJZNH3Fmcwo7gYPoLAMaAFc/+vnS19Gn16SDaPG/JhvXrfLLk0jGZ+h
	 q39kpHJP3h3xKIhfsRqXtoOHqVGhFdW6uFCxi7wveQtlVKW1fXrBmFegW7kMQBlL/cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=x0S3vEvOp+7SdbxIvR6tN/MJ2TGIuQLHYwcU4rWNdGE=;
	b=Uxnmwn/8ZYre7YCvXXFWXS0QQI8/o9AjJlbf2M0YMPPkpKJME49Gcty7JS+sdEYdHekl
	 F3Ne50tLNOc34vEjjlJspLkNCr7rkpuC4/ubftCE/Iwuf1MKkAriz4UJc7K+Nxe1GG3mg
	 QejAhJ1VSP0XMz4t0wzdQToS/U7jS0ZhzcKemF6/ohTPT+DRX/fQaK2S8NhwKcvQHrDHE
	 qkIJ/qEYcbBj7CJX/CEe19ES3MgUwPKwUXg8AkGtLx0wIY/PrKcGqTwaSLivZMmAVR/93
	 B/lby4hbgPqA/VkE6xCiHanXw64XoXLSJ0E41jN1ItGXyF0iSVgyNChV38aeXrmGq5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="S/m3q+yu";
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F479606D802
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F479606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S/m3q+yu
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-351788121cfso433605eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749575; x=1794354375; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0S3vEvOp+7SdbxIvR6tN/MJ2TGIuQLHYwcU4rWNdGE=;
        b=S/m3q+yudoMqo4A5ijv0bbf6wDGpV0cYt6puVOGmYHsyNf7H/AOqOwKOFqGUN0MezH
         RfAEZJ5MDHCHwDHt5WNUaGhMcZFmvhvOXbTZjD8+4YRJyJvmi70f/Nv3uizQRFvXk1eN
         YTgxwCPVpCWKNM+cIsTVS8InWnX0tFNFBroqKp9nYu3C+wUV/qBQjpPC5QW4KVt/Ayi/
         8rbm+7xMjE7jE+7Mf5q2TNHE8rXRrGnUuyTgYm/yc1o/txu9SxA6TsWgrckWCwQb+52Z
         m20YJZZpHpoB2JRyNN/EfQ7spjRsL7lTtLKklSkzHIwQIE1siCikXi15NkM9ni560riy
         v+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749575; x=1794354375;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0S3vEvOp+7SdbxIvR6tN/MJ2TGIuQLHYwcU4rWNdGE=;
        b=inw/Bm/M0WcNl+SzPhYhOFcYJOIqZ1r4djmueC8YCspBzEWeVa+6l+CKhqbgoWBQhe
         OwjAiY2oBn8o/LJcSeVp/Y1wgF4d1uGQL2aKLifQlSAiGIvOrVaadtaEoRi3GUK8vK89
         4aV9UbkcHdauItlhlxxbzeACVlXH+5YoCpHVPCP+gmoZVhyWmLMn/zZFcA3cy55b1NZW
         pxqZ40TXeUAgKhUKBjRjC9+kb5+pA+CB6R+BOd+bolvzMGxDQenP7jDMczShmmikKDwo
         m8/w1SeB4InjRhka4P/6kaz2k0XStzz2KUOa8qe720s145pdQwXEY+e97Wjvu3wR4feK
         oBbw==
X-Gm-Message-State: APuU4Z/4pfW1JFzOqCgWDYcd20VeJZeZzmt/AI9pNi6eG/u9JVyUNBoj
	IpycVbinBs7M81gEyn3pAuTmZVo8cFIQcjEr0j7jq8/wuzzabQSVtNEMLVKoaQGsMk6Od8vR4px
	i6Mg93m1jfnvLhM38FAKU91H7rsar8ttLiB0LCnprOd5x4U0RbR723xNejtvrhuqpPvQIxAOqKP
	jR3l6Nbn/2tmbxP1tf4pGXzMRqpH+jSC/TVa1VP0sAh4XlgAxthos40cU=
X-Received: from dlai26.prod.google.com ([2002:a05:701b:271a:b0:199:7dc2:7958])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5f0b:b0:1ab:de8b:5f0f
 with SMTP id a92af1059eb24-1ac5cb18717mr20136030c88.40.1793749574559; Tue, 03
 Nov 2026 15:46:14 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:41 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-26-irogers@google.com>
Subject: [PATCH v1 25/41] perf test: Add stat record metrics test
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Test that metrics measured by perf stat record are displayed by perf
stat report and perf script, and that events recorded with -e only
display matching JSON metrics in perf stat report and perf script when
--all-metrics, stat.all-metrics=true, or -M is used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 116 +++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index ac9e031831da..bc7d29ec7b0f 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -92,6 +92,121 @@ test_stat_record_script() {
   echo "stat record and script test [Success]"
 }
 
+test_stat_record_metrics() {
+  echo "stat record metrics test"
+  if ! perf stat -M insn_per_cycle true 2>&1 | grep -E -q "[0-9]+.*[[:space:]]+insn_per_cycle"
+  then
+    echo "stat record metrics test [Skipped insn_per_cycle metric unsupported]"
+    return
+  fi
+  stat_data=$(mktemp /tmp/perf-stat-test-data.XXXXX)
+  if ! perf stat record -o "${stat_data}" -M insn_per_cycle true > /dev/null 2>&1
+  then
+    echo "stat record metrics test [Failed record]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if ! perf stat report -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf stat report]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if ! perf script -i "${stat_data}" 2>&1 | grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf script]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if ! perf stat record -o "${stat_data}" -e instructions,cycles true > /dev/null 2>&1
+  then
+    echo "stat record metrics test [Failed record with events]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if perf stat report -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed unexpected metric in perf stat report]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if ! perf stat report --all-metrics -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf stat report --all-metrics]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if perf script -i "${stat_data}" 2>&1 | grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed unexpected metric in perf script]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if ! perf script --all-metrics -i "${stat_data}" 2>&1 | grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf script --all-metrics]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  stat_config=$(mktemp /tmp/perf-stat-test-config.XXXXX)
+  printf "[stat]\nall-metrics = true\n" > "${stat_config}"
+  if ! PERF_CONFIG="${stat_config}" perf stat report -i "${stat_data}" 2>&1 | \
+    grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed stat report stat.all-metrics=true]"
+    rm -f "${stat_data}" "${stat_config}"
+    err=1
+    return
+  fi
+  if ! PERF_CONFIG="${stat_config}" perf script -i "${stat_data}" 2>&1 | \
+    grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed perf script stat.all-metrics=true]"
+    rm -f "${stat_data}" "${stat_config}"
+    err=1
+    return
+  fi
+  rm -f "${stat_config}"
+  if ! perf stat report -M insn_per_cycle -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing metric in perf stat report -M insn_per_cycle]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if ! perf stat record -o "${stat_data}" true > /dev/null 2>&1
+  then
+    echo "stat record metrics test [Failed default record]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if ! perf stat report -i "${stat_data}" 2>&1 | grep -q "insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing default metric in perf stat report]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  if ! perf script -i "${stat_data}" 2>&1 | grep -E -q "metric:.*insn_per_cycle"
+  then
+    echo "stat record metrics test [Failed missing default metric in perf script]"
+    rm -f "${stat_data}"
+    err=1
+    return
+  fi
+  rm -f "${stat_data}"
+  echo "stat record metrics test [Success]"
+}
+
 test_stat_repeat_weak_groups() {
   echo "stat repeat weak groups test"
   if ! perf stat -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' \
@@ -601,6 +716,7 @@ test_null_stat
 test_offline_cpu_stat
 test_stat_record_report
 test_stat_record_script
+test_stat_record_metrics
 test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
-- 
2.56.0.385.gac671c819a-goog

