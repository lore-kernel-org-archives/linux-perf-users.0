Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1103909AC
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489266; cv=none; b=DYiQlU+GMBHO6wC1YYvslVnP6lILUXiiDri1ZKH9Ujy0wbrU26ACLvLndW0sjEzjrnAXyXzmjlg2YUAiAPQjoixf/HmmGyX3U55Sq5Z2ikDV8K6BQFsbYfLSODzn3DNMkJ9n0JjW4b9GjsThk8IvsSW9rb4BVoIDOjhckK8Fftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489266; c=relaxed/simple;
	bh=FEVyrHDBlet1P9BzFLFGACvY7k3jpDNi+mhxyn+8vK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rQxb3qfhWOPhiYIg8ipq/ylRCynX6P3hHldHpS+/KB/zfqHpQv9AErSeeHw6cAPHbViCigIFegrdpm8jhC99QpvTCMw/31zBiuKKjPlPJiyCrH4L1Q6HdAVcd/Hdxbsf4gQBmMbe5haGY/ywOyTXTxRoZjoYRnZNDDJDIZ2j2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgDCqcDj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgDCqcDj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso9393842eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489261; x=1780094061; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xAFihfRLWRFUO8em9E3yweTug9bGII+pn0wa8seQfq4=;
        b=cgDCqcDj+XO4+KWTzvOX6sZ/2eJ4SzABteLElUxbWAGn1vjzMGEtfrU2s4C2rq2uIP
         chNqrUoayddIhW2XUEpDhwaGQOWBiCcnuAvm6muVACP8ubaH+35bW7AaQ2yBNOcpBYry
         bkCbzgA098iLPHCse7sbzRg1O6uVhzfjETz4E3z0lyDg3GfJ6wEHzlEc3xZCi3HMxwVf
         T6ACGga3ek2vSbtn7VBdM9Dr6U/nr74kM9Ti5LzeVHjJgnGOG4WDhbfkogKAUv3AkWU1
         JHeHAhGfdvoOloslB3vt50S1UYO94GU498jK3/UlAdwY2usVSjg0LgZbUpRq9gX4C+XS
         NGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489261; x=1780094061;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAFihfRLWRFUO8em9E3yweTug9bGII+pn0wa8seQfq4=;
        b=gLDdYqsmmjMrj41RGWWuIzBAOXwbIHZh/bLNLFvPf3plQ8HuXdG6NzcJwJJR9+Gl/d
         M5SD1KzyGqdlBnm9rckJifyx/AMvG8QpFjwx5N6QvWjbK6mzA2vSFIxAwSkeXo3tSWNi
         Y4Lwaftum1XBknnl8/aF6pOpccJy3t7WHinO3FQUm303xaHhGK++U9KjINiD8ueJrHJE
         NARMPhgF041FUlefbslGqC69xh3bNoIsxJUzrUY4RMx4rAscXwVGovrleEcjtKqZ/eKu
         bh9c1wtAGHdzP+LGRithpEk3RU1R1eAO6mwQmqvgr5dRLM3YSvY5iGNHf8FM723rzEg1
         Sc8g==
X-Forwarded-Encrypted: i=1; AFNElJ+Ih1HPiwuy0KFnlGTPSEgeLhnVrF8oiNu94hUkr5Es72UkZX1eJgk3bAO4tBncb5jLu9OYrGEGUdXTlWVDjkTd@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrKl2lGJHKhCKTUeVpk0UMYj0APgbBlI2kEzUOUalsob41Tjm
	su8thp2CLnAmUvCtbRd+vHLr6KGscuhZhy+6xkkt8sF6xdkIH6eye4KSOI6nD5H8OZZ5anuYNvI
	pHNwk4nQdUg==
X-Received: from dlx18.prod.google.com ([2002:a05:7022:92:b0:135:637f:2609])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b86:b0:132:956b:3c6
 with SMTP id a92af1059eb24-1365fc692damr1782939c88.33.1779489261156; Fri, 22
 May 2026 15:34:21 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:37 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-10-irogers@google.com>
Subject: [RFC PATCH v1 09/14] perf stat: Extend CSV output linter to test
 advanced PMU and metric-only checks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+csv_output.sh to run
the advanced hardware PMU, topology-aware aggregation, and metric-only
checks a second time under the --new CSV print flag:

  - check_per_cache_instance
  - check_per_cluster
  - check_metric_only

This guarantees that CSV outputs produced by the decoupled printing callbacks
are verified and column-valid under advanced aggregation modes and metric-only
JSON row-column layouts.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/tests/shell/stat+csv_output.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index e4153a03d716..78e3c0bd8f82 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -103,6 +103,12 @@ then
 	check_per_die "CSV (New API)" "$perf_cmd"
 	check_per_socket "CSV (New API)" "$perf_cmd"
 fi
+if [ $skip_test -ne 1 ]
+then
+	check_per_cache_instance "CSV (New API)" "$perf_cmd"
+	check_per_cluster "CSV (New API)" "$perf_cmd"
+fi
+check_metric_only "CSV (New API)" "$perf_cmd"
 
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

