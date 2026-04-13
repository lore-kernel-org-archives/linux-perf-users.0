Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0C2D3ED1
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053576; cv=none; b=Ojgv7kI9tHEzAexxikLAdMtuzKDaejJFGlF9QJH56noFWfH9DEaOUh1ZoKGTdksRGSVq85ZVK6aXJT20ZuSUG4KGZr+qYVVaopXkeDkcm6IAX9mB+yCXJO7sSWVyiamGgB5EVknT55h3twQo+u6XZBB+SyLFFfxVH0SUJNLbkwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053576; c=relaxed/simple;
	bh=/TJHliXZNcJc0WMzmCn1uj85dssMOv30WvsxQWbGYts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YdnJZgb4RQbszQbsJIUE4zNJSzyLfgeQrOHSZDKUObW27OAmeQh0ppbM7RNRD4i1Q1endjFOR2xUraYlZKlNH5jHeHxd24m+xEUmbNfnev01zWoluraccEbMLoV7D3zWyrq+umKThdaEv5AbwAyXQ6PyaHNxxDAYptNsnZJ+VeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Djpz9qJh; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Djpz9qJh"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so3376885eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053570; x=1776658370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ky2umPzRcxH/XBrATEo/kk5mztVaDExoaZNmlerHag=;
        b=Djpz9qJhHK3ZFmrHN9s7ovDPajf8WCfrT2AsKJ9vJSjtU3asvqLI8Li2YYWKBZ004e
         w8Ut7J40+4nyspZ3qxUuGPV4tFHT0W2yNj/TTLNUDnk43L++jXVj2phgYNl/CgoMPdE1
         LFH2I7aKrBTzofYth9igT/qyOSFXFcqa6NyRNlo4Wmwi9tzjxTsmtFXHVJjT5qjEPkk+
         oDQEcqzD4iPmjXoWX9KN2XZaDG/YYTFwNkNbV00TJlx8PgcgSNx1nt+0/pPjbs25Iq+9
         QfhbrXY4CwjKu1u0HL/crvxS72eQ8uhMI+sJ+/YvOHAIsAphQBkylO1CHSFS4TXu2ewM
         OVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053570; x=1776658370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ky2umPzRcxH/XBrATEo/kk5mztVaDExoaZNmlerHag=;
        b=Wtb81XMipwcDzJ3Bf7jV6EYOWoD8bzoDui/qPaldiP/oqQHlunwX69YtPJFDtfKaDC
         4By8gZ3HBf47dhMXtcxVFk9F+AMBsM/HWHs7NRJW/0Y5aIZXEPw460kZq/JhMCTEmqcS
         99wWJ+8Nke8NKsIUHfVqSwdRKjpDz5Wtf1TIexr6F+nTnxm9vJEa3s0olM5FAU51d9jw
         h2gFfqywAD8FOb9uOBfHZHluJl7UY8LAcL9jsFIhN6hG43JTWerb2Ib3STTdcwVmpWcU
         9yy5yGuFu1BxG103v5qxNz+GmcIf0/KrvQLosI+XE4wETBaikffoLggVWOyovS/dIodV
         xImw==
X-Forwarded-Encrypted: i=1; AFNElJ/IKsrTQYGoLF+Q59spW4myekfRacIc5Ub3lNucviuusfsXL0shRpZcTSIQqwv68/h2Vxj1RzYqvDbQDDF8NKO6@vger.kernel.org
X-Gm-Message-State: AOJu0YwegR3t5tLj1xJaXE9JB3X5SBAWQ+VAAix3NbASSmMbdMAM1wf1
	ydKrSrCGRElMIUpR4anzCm8SU2jZTFH3ZBrQmaD1SErK/L6IM9r/RgprHi6yHY1MzatEa+EKHSS
	lkaB7f6f9RA==
X-Received: from dybml11.prod.google.com ([2002:a05:7301:150b:b0:2d5:b23e:f5cd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cb0e:b0:2be:88f2:3c98
 with SMTP id 5a478bee46e88-2d599799551mr4845574eec.1.1776053569593; Sun, 12
 Apr 2026 21:12:49 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:33 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-24-irogers@google.com>
Subject: [PATCH v12 23/33] perf lock: Constify trace_lock_handler variables
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
2.53.0.1213.gd9a14994de-goog

