Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0033372D
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274241; cv=none; b=lctPY3AQD9RuHgVoGUwbiDdUoiKlUWJtuKXOgvSV1c8lu1JBP0sG/E+ccBVk15SAwduzvX49A1XgzYqvB3BcNhvf5pgppR+WiCYbMp3egv0ane52o3vISAGVhde3CSJs2iwHg/8OvLPGRHUsV68tDJXgLARLaQTj6ogFcm5wtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274241; c=relaxed/simple;
	bh=SYrJANGR3+3OE2V0oHZ0BNrkaTsib9ddsYIXs4rLT8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvM/i1CebOhsSlZjRdv6MrT+sr1I0bAwCMj/5B/U5yF6l6eqIXeQUO8grd3rLX2oTC+uEgsjhYjN8yDlW3ewZ40Eaggwx2elKtxCV4zKA5hrnyl06x3UHWbULc34A/I9C4DUyZxRltByw+RREL+Pk6HoVqxRtxKTwJEbA2ZFQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avr+WZPC; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avr+WZPC"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127133794b6so3726260c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274239; x=1775879039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1+MYX0+5YGMm7TjdJ/WWiuEu/OsAkIHeLC0vTnO8zk=;
        b=avr+WZPC+7eX/+lzHKqCtsBbv05b1eAppgLHHc34E6oio7Ayo+Qmk7IRlveyXYimpS
         22/UnqS7zKvK/LmW8UUGOX/fLzyFX3qvJgjrYdwgBsvk8VXZjvPbIKXhHZqMnjOOqLtg
         9Vd3tUxaw4qno/RDofqvsJHmqNRWjh0Y0cnIvXBIjxc1xdeHHHwFV+tnUkHj1dZccbT/
         9nOxIi49yuiGIaGNghB8IouZs0tO7cV+DzUwA0DjqxN+h1h/eZ0xq0ULQZTSbqj0W9sg
         DT2lU+4VViw4L0xsoaI+6kC2SJcxg4YwISRpi4/SBOV7+ecoU/hzx3tBJTk615gAfdK/
         3F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274239; x=1775879039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1+MYX0+5YGMm7TjdJ/WWiuEu/OsAkIHeLC0vTnO8zk=;
        b=soXo3fM2azlJi8TAFt6O7VPXu3UeplC4MeIGcP9QGeL222riFaeNmSIYuTZoahKpCa
         hI0MxEpcIeQ2As+eUgnZywUIzZI/B6EM+gODKC61gyHhd1ct3MIIoo+CHXd9Bp8o+IQp
         5m77l/wnvFC2VfIZHAzKrduhaGoFx6qpop6A32KGRIcqpgYMPGh22kX04K5TkQZdB7Cx
         JiDQDc0oW2zyIbgDLH796vbQAYBqvfKyAc8tktc11DY/vBXWnyAMsFYJ08f5j+dhwQSB
         JL+PalXyE+Z2SX3cO1LiK7FEmMJxypBjWXr1kOgtpIrRH/BF2+wWrcB3QGnUrxZMq8F1
         ymUg==
X-Forwarded-Encrypted: i=1; AJvYcCWH61cwWpZzjgNIQsX2qdVTIZXGERQNHIE/c+Qnuqn0R6c+CGtcU6ICUFpBL+S/EcuN1HEhP5iFtA9GB4Imo/qy@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnWQHiYHa7v5gxkNsPqlXhOq7nbTPrEL2YeYT1h+y14GPq01+
	T12LZAikWOAgg1n62q/R9yTel0RREfIQe3RJDP2ZV+/DcbhYBFny0mAi44gxFB5Lx2JDWMAzzb0
	RoabCp+8RBw==
X-Received: from dlbts25-n1.prod.google.com ([2002:a05:7022:b059:10b0:12a:6ccc:6d06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:43a8:b0:11b:9b98:aa4b
 with SMTP id a92af1059eb24-12bfb6ec461mr2614294c88.6.1775274238390; Fri, 03
 Apr 2026 20:43:58 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:10 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-11-irogers@google.com>
Subject: [PATCH v6 10/25] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Structs don't change and so constify.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 8ccb64415d3b..7b23d22d8f48 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1182,7 +1182,7 @@ static int report_lock_contention_end_event(struct perf_sample *sample)
 
 /* lock oriented handlers */
 /* TODO: handlers for CPU oriented, thread oriented */
-static struct trace_lock_handler report_lock_ops  = {
+static const struct trace_lock_handler report_lock_ops  = {
 	.acquire_event		= report_lock_acquire_event,
 	.acquired_event		= report_lock_acquired_event,
 	.contended_event	= report_lock_contended_event,
@@ -1191,13 +1191,13 @@ static struct trace_lock_handler report_lock_ops  = {
 	.contention_end_event	= report_lock_contention_end_event,
 };
 
-static struct trace_lock_handler contention_lock_ops  = {
+static const struct trace_lock_handler contention_lock_ops  = {
 	.contention_begin_event	= report_lock_contention_begin_event,
 	.contention_end_event	= report_lock_contention_end_event,
 };
 
 
-static struct trace_lock_handler *trace_handler;
+static const struct trace_lock_handler *trace_handler;
 
 static int evsel__process_lock_acquire(struct perf_sample *sample)
 {
-- 
2.53.0.1213.gd9a14994de-goog

