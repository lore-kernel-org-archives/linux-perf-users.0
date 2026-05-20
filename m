Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAC3FE37D
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303991; cv=none; b=ZvK9cKnrVhkppx5WgDyjSy1eWGd/HGaOwpa8t+IXC8f3X/ziobfXlrdknHfV/4cNgswQ//wzV0rwYGxCZTQBi9Rav1n0obpcrq4HZ6pSnE0GqvyQslcVjpY0jGsRm9mJ96+rl0f8XT849cG2mQDt6/Q3BYTd670l91VflZ6hnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303991; c=relaxed/simple;
	bh=apVy9ur16wbOiVtPPb2fN+IDEQPmSjVHCdfsyETc200=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VlwF5+h9hO06l7Efzko9hk3x3fHDliDb6WmU8yIfFqTB0qsTjIwzaeizwfaSVMAMd2dzhJBMbn/78zveXZXVuIUJtwvtSdxrUXqn0hNLNRRUrfIp09ZNj6+7T2iBDEGQHT3gS8a5z1DijdMhAORR7Bt0UETQsAM5ENxuJ465+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lrcu1cfV; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrcu1cfV"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1361d52b3a0so1151795c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303990; x=1779908790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfrm14HIpsT+y1+N0gKKl5Ph2oM5BFJPWR0ZCkGuD9Y=;
        b=lrcu1cfVoCXkmt2ii7OWHbXpoqereOWAvYUU34dEP3+JQNwfhRlIO0h6lQ2rulticE
         s8Vll5wLFCeumXJ6CSliKlMU9xbBMYKtLY0pA9Qdn4GuDppfqU2jshjuy3PASvcKoEpN
         29epEz+oTGZ6TvTwaRC0O/Jd6phwJEBwO3iel6NruKocPpBUFRhdkBw7O7Qq4ytQqjSb
         W8zC+oN9H+H9wT0h6DzMmDNy1kuJAXmNnCg1YEo2XiNjoanNiDdiACpUtjpyIIOOHQP3
         pbUEbNHyfJEYpxmZvoNReW3hpG8BcsQiv/F2HFusS37k+/KjM+OjZk30lJ4mpZtXhJHr
         OKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303990; x=1779908790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfrm14HIpsT+y1+N0gKKl5Ph2oM5BFJPWR0ZCkGuD9Y=;
        b=iMSw3EgYNLYQ7v+CCt2eey79Q46mkYaPz/Ixk8Z24+7g8Yc8AANInioYP9CMm1PMk7
         JsLWuugAhA8B83SZkM0GQPLa/qgWRSBpyCtHT8FoorhJBBYi6YysGKq7Xl+BCEt1HD5z
         9zkYdFceR+FFhKLFVUZh7c5+tMDioHjxHKmDn79Bx4eBbBiL39CmzAwtq1/YaEJPJR87
         fsot/NOYESg2Ckqs+8QzM+qeSmo90SJ+DcwCOHWpERw842ZE+NVtVkDQPoZTWs8KFgPC
         krKZHa3Z7zOwkpJeXcivrEkPlK6w6Y/gsNrCbGccmhyK7oba3DDYRJdoAoqBaWaSyCsN
         SvKw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZFDQARVe8nxRikpFbLSxGHRka1TcAFuwALXSkgY/XByqtmoJGTsRUPbKs+VdnHAsH12zO/BkTcmSdV7FWyg3a@vger.kernel.org
X-Gm-Message-State: AOJu0YwiiYp/TovVvP5ynmv9p3XO7lxgNapC+jpCHpVbeuDva07SW7gV
	lHTJNZaoQka0ukpKEh/fZEXvoLhV7hfbpSGqBe+NGO+PTLOr4x7s6+MbRQd84rknt03yt3mR4kg
	Mq0i2vqzUiw==
X-Received: from dlbem2.prod.google.com ([2002:a05:7022:1002:b0:132:8d92:4d6e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2201:b0:12d:de3f:f3db
 with SMTP id a92af1059eb24-135049521b4mr9969757c88.37.1779303989258; Wed, 20
 May 2026 12:06:29 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:28 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-23-irogers@google.com>
Subject: [PATCH v14 22/32] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

Constify the static trace_lock_handler structures.

Since the trace lock handler callbacks and definitions do not change at runtime,
declare them const to enforce read-only memory placement and improve safety.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b6533483ba64..89a40d385b27 100644
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
2.54.0.746.g67dd491aae-goog

