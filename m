Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D76241695
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028362; cv=none; b=Wp5fT/EwXZ+/A358fSqlMFf8S8zdQJc/rVq8gZES50IAlmGDMuSwpYCbXzJUNWeb+fL3zjgHmVXgLvFGobo7eWrl+mmgPx6s7r+SGoVL6H/p37kAB0DMvyWhbyZo7EXiwznRQYwN+www/73l2BPIihuVk3xMW5lURJiBnm6ua50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028362; c=relaxed/simple;
	bh=oO73p1xRPTCaH7zWY9uPtQL6ZrNpPDEb1CrIWcRHrM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lnIYz5jNbSIgja9T8OXJoQwYknAx7JYNQPb0LcdeTDGhXuvT6UbaixKH8Zu2BkSNVGZleheQr8DeVgyMwMtsWXTPDhLY61IR0NxdehLKZXS2H9ct87zPR22vnbsENn3VB3lk29JMWl58l4OrlsxOhqU3LMmMHeJyE64EjQwaMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNoeC9UY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNoeC9UY"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365161a9de4so3669060a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 17:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778028361; x=1778633161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdtzf9eHR5G9u38wQE27Ez1yBHseJb6vJmHAUnBL/S4=;
        b=BNoeC9UYsmqxQVls5dd55Cya7lspBnfxOQ5ZcO4LrzgZiEvzy4vhF8+uObx9XoFq8W
         /iHWXrP147wYYFYwOm6bOxbwV27vTVGBMPXUtn55yuo7ipiTJd5n1sxYhg+aYhw5Fb9L
         Bo56aQE4eRVMuBiF5UDVLTykmZ7fd6xcYdD+4q4w8KzqgEueY0M0z3/rP1T1rQfpYvww
         T6ThtfUiwIAtZWSmNs4BodD6pWZj09Tj8Vrg3mUE8HK+3VTM0wek7kPnGqoJrGI5ioDi
         2zLU/NKsCGM6Ku+sR7vSOLWjbamDuxol+06WOmSIXbHPvVCAQIl7aRqMWd7ljFSGTg94
         Ov9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778028361; x=1778633161;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hdtzf9eHR5G9u38wQE27Ez1yBHseJb6vJmHAUnBL/S4=;
        b=d8xN5mkszfq6ag7Efp6IzSBGQImmP3MFbLbu6fAQCSFPO05eeR3qCmwIdaEUWLNhXw
         yoZy+QbiQftE0QZwkDXgi57p6lmG2gd1pnz3EH2Vz9p5oAvxx07Owcp2jNsmf7cDuB2n
         3iD1WosmLEcA6gz5bLwys4WSVrs4wKhAgAYvcO9Mt5ZU5tDKFD6PR7mgRawHLVtH6BQS
         OAcaKjVLMxcDcWUUKdgUhGSISBbYPKQuUsBEioZFHTsU+6RQnIok2JhG/c0MM2cJBuDC
         GVarOXMBudoz1u2+CvLJfN8InrIE9dZBzzt3tuy6ObxQ3vG0hLCM8yNo7gHQ2u0zNN4w
         ihew==
X-Forwarded-Encrypted: i=1; AFNElJ+XcmfbqnbTDyNFL8eCdC8+cx1p1X55akKjzPvzez8CtxpXOrbHjX8KsD2DZX75Rz6OotJfALV15WKmza52UeBX@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxTgFHrd2y4nbTF1IjITFp/f8dUf9LYGDLIvpNwafYDX/Mfw/
	e/HVnwhU+1tqiZ7359fd7Wkq9JBTL3zjsYoWf+KT5570txhwd00bVjm2UvDGyuNPrH42EI9bo1e
	8RYQSsUMB2Q==
X-Received: from pjuj12.prod.google.com ([2002:a17:90a:d00c:b0:35f:b7f5:9c7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2251:b0:35f:b5df:453
 with SMTP id 98e67ed59e1d1-365ac7757c2mr952090a91.22.1778028360556; Tue, 05
 May 2026 17:46:00 -0700 (PDT)
Date: Tue,  5 May 2026 17:45:43 -0700
In-Reply-To: <20260506004546.3140141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504072937.2103453-1-irogers@google.com> <20260506004546.3140141-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506004546.3140141-3-irogers@google.com>
Subject: [PATCH v5 2/5] perf tool: Fix missing schedstat delegates and
 dont_split_sample_group in delegate_tool
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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

