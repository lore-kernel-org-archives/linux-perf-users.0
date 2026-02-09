Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2738A72F
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658865; cv=none; b=hpn0nGTbrp3LwwCAHrqivzv373mTOZF90AKYRaTgu3j78qSUuSPMnMTASwXoZJG/jLgJgRwnEQJFz1q1KdZ8uaCciwN5h9ASf1D08zKNt23snheavJjcmFsF+cpT7ZW5wfhXVdp5Fr9iqvcFv1Rdg/Cenve16v3QeKP4TY8kl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658865; c=relaxed/simple;
	bh=s7ebJ8coCCRLS7j5tvDUOu7GZ8PPy+u7aer0iwR2zPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cZo2IH0uBG4ZmRuNmb7behADWuy9msst39sLKmpHuKK4YXrTU2IkbFEzvx9KASJvFGxkdaMeD+ifKuhEH7UXEfF5c1m82JGP1Rih9L2DBzR7ASJcREEXgG4uh1PLzgR+CS/tOGLYG76oFwY4JX47yA7a3ge9hyye9HokBUTMFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3T0GRbs; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3T0GRbs"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba66faa692so1157019eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658864; x=1771263664; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWN1rpGTUgCpQfhUsVVshjhCY4UQT3jiWsJWesC5Xbg=;
        b=M3T0GRbsPeVg5hvNTaBTNdw774Z8ycWouxT1vCv3NyL8x5YGd1OfTMlOLQ4RYSo+z2
         tp6s8ujvhQwBZqcgp4Y6Gf0KdrSM6EBgkVfcOY0e8+d6tywKDSTiZGsZtY6/naY2wXEV
         lauE2jgck1NIJOrzD8YXirjM6I2XYcoe5tokFwcDqDJ+6njIN+Fpg8GjUq9Y2DJRuihP
         R3QfL+wtPdasPWhgSoShsViU51NhxwtzK1IvKoSTctPve2hDREPEebjSTtUamvD7CF3l
         118MBkscqbWdAlI1oJ2zu4tC5r2OcFKjzW8kUuRjqKioFZYpL/WSbqpcdi3sNQ2wOQ6c
         cKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658864; x=1771263664;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWN1rpGTUgCpQfhUsVVshjhCY4UQT3jiWsJWesC5Xbg=;
        b=KFQRRJSvxUn4yE4jqsIadSLBOyy9erxPh5IQcZmpyX4lKMtWddohU/L5BPpRF5ryjW
         lFhAF38GNTQujESncwS0lRnXNxdSkTTtH39F0cEkD4z5nu2wi6NvtosuLpEXnGyFLuQ3
         +6i1c8UDVpO9YCPHmAIoy1qZFxN28vxu6x6VoFf9bTfEUIkLHhR0kOKmNscoO89tKfFK
         UFkC4i884fr+cdcJIBhSU5ptB6TG8OjHDnGYHHKGfAYjJRmo/fshKljc1j8rbEnDdyBY
         cj8NXni68tiEIvqk9M7xXGSc9hrcb6LouwPDfNyiuRxhdxjAlCiPhYdvIAzUFiWxSmv9
         sROA==
X-Forwarded-Encrypted: i=1; AJvYcCVqFCcmFWr8QMpBs38yWVJ0V15fX1nP8GQJNFyHHRbVr5CwuDbaQh1NKseeXlwuSDAbc1DuXlNWMT+aGWDB0HeX@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKsXNX/5eKoCt5Fuf1WMjT2AEwxVkD9QrrVTeVVkIQ+MF+KYs
	UQ/d+PfiOkWsrBM6sMhMxJMbbCrg+mRdEaBIOILmT2DSbLDkUk7JkwIUP+OvNlb1wYloMAba+2+
	QN3c/JzVh2A==
X-Received: from dycnh3.prod.google.com ([2002:a05:7300:ce83:b0:2b9:3292:ebc6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4190:b0:2ae:51fa:b7ec
 with SMTP id 5a478bee46e88-2b8567240d5mr6327506eec.25.1770658864382; Mon, 09
 Feb 2026 09:41:04 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:17 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-11-irogers@google.com>
Subject: [PATCH v1 10/25] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Structs don't change and so constify.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 78fb39d06e7c..735e6bb234ae 100644
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
2.53.0.239.g8d8fc8a987-goog

