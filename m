Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02D32B9B5
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890667; cv=none; b=cXRebFuXxtf13vbEcRfg5VD3JGMsm30lgnN4gbW9EJNTYYyTw/LuTILOWFzgy4peZpl4PYZgxrxY+Hlh9FUi0lFiwmt3gNGV6oM4WYKzdDJGeNPgJoaSRR6sYzTZ/TkJzJX2UHqWhnKJjF0t0XAZFB+Yp8KbOws/yARDb8L9S4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890667; c=relaxed/simple;
	bh=7DLuXWzqSIL2retVeMJj3OZEmlA0F6lhyp+Bekl45bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tt6b4w35kmSHqAK7ty47UhPy3Qw+bphqtbReQCoscbz7vJdGKIADGHjoUgxHyONiF8Pg/OSptjWqINIc1CZ2227iZaewX03AxggQWvg9mTvzaLVrOnZE+KE3L+pETiMkS4MElYPR+foevf4rpFvEmmwnvVY/hnKjiTjBU4u/31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2w72bnn; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2w72bnn"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso3523711eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890660; x=1776495460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpMQz9BtqhH5QFTNLQH9VXJ1GuG48kQiZEjqAB6l0AE=;
        b=p2w72bnnCY2NaTGIFin6MMrZBGY487J8gHOHXfKkdBv8J5W11okaX7mWlyK2Kmpgy7
         ETEuskEHeKXuGMFaj1JEJBZyNIsB0wDAqIoEIBdFLBMv9hvYzW1z7U7lboZIvqPzfhjE
         Dnzzof1vR+0SZI4njKIjochio99oiXuXixTov/WhK+I32vg6mZPa3SbjbrhPe8JoshkU
         TlYatyIPhY1agIl/7O06mGmIgm+t7T/AVowo7qJ1v0AN8QuTPxAZwf9K8faBdi1Gj8Q4
         9No36MCvYgBmYOfO6uL1KvlEBFo79JXN0aNAookZI166cIKTOaWovSH4DUlIg/Ddb+MT
         +JGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890660; x=1776495460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpMQz9BtqhH5QFTNLQH9VXJ1GuG48kQiZEjqAB6l0AE=;
        b=GWwCcyIyw1HLFaWxFBEU1q954/mDXeFRWTe60J3WsCnfo9HeIfBE7d3C7+G7YOzmDD
         KNCfoQdfwXx3rvLrwVf91rBBb7OInUk3oxsdb+yXYfUrXhVUY/5xwtV8zVBmepItqPzp
         wTEjUORlo3JlEgUmAffLOTvTY0KnJrvRqXz1QfaPbJX22fRFVvMMLzfhd/MyoI9yg05k
         DoI+nLnCvRGdkQTVZyJPL+dDY3LvJQwITCOpxEbm8XxEk0hRNkvoER0Us5xrQaJJbBPg
         OzrgdcBYQFx6p5JZBqT4YxTdr+OVxv9WgjxH7aMOoCbM5NGhS0iU/3NHMcGZjtX2CirJ
         TpmA==
X-Forwarded-Encrypted: i=1; AJvYcCVL96ID9+PppM75FYj0Pbmw7bvCFLBtjh/EkyfOY11/gJDbw3lDizPQ4roBlwc/o6oO7Ns7y+iFS0EK8KEL9at4@vger.kernel.org
X-Gm-Message-State: AOJu0YzQt37CUUm3gUXeS/moHvTymvQ05lahP3OIM0FOb8G1Z8b71ipH
	5bYZSexQ+nKxt4q6xtQQaJ2qRV8VUSOqlWC8Nzmiwal1o7vP8Dv+VmY0eBAcJ3yrePSjLJmjZZD
	rpEJ/2Q/69g==
X-Received: from dycno6.prod.google.com ([2002:a05:7301:1446:b0:2cb:30a4:447d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6788:b0:2d5:3a24:1507
 with SMTP id 5a478bee46e88-2d5873b2d13mr3399293eec.7.1775890660311; Fri, 10
 Apr 2026 23:57:40 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:56:57 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-9-irogers@google.com>
Subject: [PATCH v8 08/29] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Structs don't change and so constify.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 2a6fc4c97dcd..09fce546b31f 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1179,7 +1179,7 @@ static int report_lock_contention_end_event(struct perf_sample *sample)
 
 /* lock oriented handlers */
 /* TODO: handlers for CPU oriented, thread oriented */
-static struct trace_lock_handler report_lock_ops  = {
+static const struct trace_lock_handler report_lock_ops  = {
 	.acquire_event		= report_lock_acquire_event,
 	.acquired_event		= report_lock_acquired_event,
 	.contended_event	= report_lock_contended_event,
@@ -1188,13 +1188,13 @@ static struct trace_lock_handler report_lock_ops  = {
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

