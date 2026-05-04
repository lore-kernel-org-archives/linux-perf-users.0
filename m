Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D212E06EA
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879807; cv=none; b=IicdA4T26QEP1zSmK1cu3C3uJmDfgzFKE5WEwghVUjvBlLJMnz0I/e9LR76x8KxYc2510D4h7EETqcDDjGWUGCXxjFUYcJlMJ30Lbsbm7EIYOiDgKIwJQiZdmJwZ+3erxoxjs8VAeRqE9ZECki7SzeB9WUr6M6AFYdeWEmLGXAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879807; c=relaxed/simple;
	bh=oO73p1xRPTCaH7zWY9uPtQL6ZrNpPDEb1CrIWcRHrM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hSDhfFVir8Q/ZWFIeOGL942CY+zM6RozXHs5/2i6E6IncOSjT5VmYbhnxvi+fa6U8pd3EjMFRgZACNnWvHz7UOdKRnVhbYTANh5jVdXWnWPzKOcm42BaXdXUQWpPIZNCM2L+nBa6ImCJLJPBjQL3AYvqZfGVrfM+8Pm1VlXl/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RryvgqRi; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RryvgqRi"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c797d8c9c2dso4676654a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777879803; x=1778484603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdtzf9eHR5G9u38wQE27Ez1yBHseJb6vJmHAUnBL/S4=;
        b=RryvgqRiXbCZCQ0huAHJfZK2ZHiuL5hkDsBeYB86u+9HC1J8LAtSKMCDPpUcTZi4nj
         f/Y8hNXvJjxMESKNXpAdRwRiS2od2qZlPamsMV9cw9CKySFO3m3TQVwv+CJjC44+kCeF
         kL0GRqDd6IFJSqiD/nqCz9skBmvf9vJv8k768PSxJjSu0H+c/pKeMxGIsy1lEN3JDj4C
         qf8VdI4cWlI9EKKZ8vHu09nguBSDskyvwWmwUX0drTj6IIl7CP5OEAKqI7LNkK7WBmxC
         WjOnSpy7Uwn3bswKTemOBwCVtzyQB8wwkwKH632I33vhrVHiTAMXEJWcQ5GtzgTvdiAd
         /3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777879803; x=1778484603;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hdtzf9eHR5G9u38wQE27Ez1yBHseJb6vJmHAUnBL/S4=;
        b=SlQXxMZAY1FZY+ju09QRD6tcSHJcsbs3jf8bA6XgUNk8PvNr/7OG1tp6m7mPlrRx8h
         1KxxciUc3RhhtxjLCwfmwUG+u/Y2AGkMOmp6ZL3eyph48VU8VCjXoBojfCEXEgPLFv/8
         DDLktsV8vECIKmCwi7ezLlAEVBZV/aaeOyE6mjr3WkFN/4lfCNaoWeMuNA84Xanvw4T0
         uz9fqU1FYx4sEy762n+Q5GFx2GjLnG93CEyCyHJ94blGjAOnwsULdg/kq8XGjaeusjTq
         pbIKNiU8OWW6pNveqFvdDiZtRA4bMANHwDfXpZ4zmoKATUwVD180zWvRCPXdt/UA9Mj3
         Z6uw==
X-Forwarded-Encrypted: i=1; AFNElJ/yHHN7XEMWq8PnfgQEqpn54MhF58ptiwpTxdbeSEaXjyTbpdVgBXNGT3AkzJ82YI9OSx9Ie9h6ZE2OIA9aFsaH@vger.kernel.org
X-Gm-Message-State: AOJu0YzILXghtEpMlKDomt6dhJCuLtTGmrv3FMRi4LKfNCQGKUrNxijl
	Y/s00zlI1HrhiQhFUQfLXBbIvWUyW9nHwanNYphexFkmNKnfHZDSvkIwx3ThoWd0wqOqmnXTbpu
	P/QGhWmwlIA==
X-Received: from pgc8.prod.google.com ([2002:a05:6a02:2f88:b0:c79:7d5e:795c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4324:b0:3a1:d516:36f0
 with SMTP id adf61e73a8af0-3a7f1f1aea0mr8857778637.36.1777879803059; Mon, 04
 May 2026 00:30:03 -0700 (PDT)
Date: Mon,  4 May 2026 00:29:35 -0700
In-Reply-To: <20260504072937.2103453-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504035125.1851720-1-irogers@google.com> <20260504072937.2103453-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504072937.2103453-3-irogers@google.com>
Subject: [PATCH v4 2/4] perf tool: Fix missing schedstat delegates and
 dont_split_sample_group in delegate_tool
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

delegate_tool was missing the delegate overrides for schedstat_cpu
and schedstat_domain. As a result, when allocated with zalloc, these
callbacks defaulted to NULL, causing a segmentation fault crash if
any schedstat events were delivered during event processing.
Fix this by adding delegate_schedstat_cpu and delegate_schedstat_domain
via the CREATE_DELEGATE_OP2 macro, and ensuring delegate_tool__init
correctly registers them.

Additionally, delegate_tool__init completely omitted copying the
dont_split_sample_group property from the delegate. This would cause
wrapper tools to default the flag to false, which corrupts piped event
processing (e.g., in perf inject) by triggering duplicate event
deliveries on split sample values in deliver_sample_group().

Similarly, perf_tool__init() omitted the initialization of this
boolean field. On stack-allocated tools that rely on this initializer
(like intel-tpebs or __cmd_evlist), this could result in uninitialized
stack garbage evaluating to true=E2=80=94silently dropping non-leader event
members in deliver_sample_group().

Fix both issues by properly copying the field in delegate_tool__init
and initializing it to false in perf_tool__init.

Assisted-by: Gemini-CLI:Google Gemini 3
Fixes: 6331b2669359 ("perf tool: Add a delegate_tool that just delegates ac=
tions to another tool")
Fixes: 79bcd34e0f3d ("perf inject: Fix leader sampling inserting additional=
 samples")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 013c7839e2cf..ff2150517b75 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -285,6 +285,7 @@ void perf_tool__init(struct perf_tool *tool, bool order=
ed_events)
 	tool->no_warn =3D false;
 	tool->show_feat_hdr =3D SHOW_FEAT_NO_HEADER;
 	tool->merge_deferred_callchains =3D true;
+	tool->dont_split_sample_group =3D false;
=20
 	tool->sample =3D process_event_sample_stub;
 	tool->mmap =3D process_event_stub;
@@ -433,6 +434,8 @@ CREATE_DELEGATE_OP2(stat_config);
 CREATE_DELEGATE_OP2(stat_round);
 CREATE_DELEGATE_OP2(thread_map);
 CREATE_DELEGATE_OP2(time_conv);
+CREATE_DELEGATE_OP2(schedstat_cpu);
+CREATE_DELEGATE_OP2(schedstat_domain);
 CREATE_DELEGATE_OP2(tracing_data);
=20
 #define CREATE_DELEGATE_OP3(name)					\
@@ -470,6 +473,7 @@ void delegate_tool__init(struct delegate_tool *tool, st=
ruct perf_tool *delegate)
 	tool->tool.no_warn =3D delegate->no_warn;
 	tool->tool.show_feat_hdr =3D delegate->show_feat_hdr;
 	tool->tool.merge_deferred_callchains =3D delegate->merge_deferred_callcha=
ins;
+	tool->tool.dont_split_sample_group =3D delegate->dont_split_sample_group;
=20
 	tool->tool.sample =3D delegate_sample;
 	tool->tool.read =3D delegate_read;
@@ -516,4 +520,6 @@ void delegate_tool__init(struct delegate_tool *tool, st=
ruct perf_tool *delegate)
 	tool->tool.bpf_metadata =3D delegate_bpf_metadata;
 	tool->tool.compressed =3D delegate_compressed;
 	tool->tool.auxtrace =3D delegate_auxtrace;
+	tool->tool.schedstat_cpu =3D delegate_schedstat_cpu;
+	tool->tool.schedstat_domain =3D delegate_schedstat_domain;
 }
--=20
2.54.0.545.g6539524ca2-goog

