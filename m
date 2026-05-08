Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200F376481
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228858; cv=none; b=Yq0bvGZSBaKGAfYE80Tm+s3aC2hI6bwkUWPMIVTu/tQ/VFWcMM9kzuUh9uZIz/mVQ9RHWvaIm6DJtYteFPdR4jaMvvMYQMsHDXUfPY4+TC5YBPhxltPRd0bZjrsTn2gF8eAFloHKxwBP4BOz3VvkSI24/wcvqjVKQhC60T6f6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228858; c=relaxed/simple;
	bh=61XWGaFKOmn+SNuFop6s61N38Tmp6A9UBKhOpH6vCUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZ9jLLBAkrv1AvV5UD1ENnry2aj/bIcqBvb2Fo37TJHA4eudDwFoQkpvZE0iER/q7QcD9IhAT7/mEFSEGt7bNCNsDN/yYd10167DDktC2LVC7imTU1MyLumgl1nwhF98LDZVDKPiOO85xjAg5y4p4MOGShdK2Dx+I0hCTq5cnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nt/2POv0; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nt/2POv0"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132736fdff3so2262775c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778228856; x=1778833656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0ui433QL46rA01gquLwWXH1KntcAtkrT2sKr2CD4mc=;
        b=Nt/2POv02juOYRKmxnTr4JyWjFii2D+rsCXWLaHHGAYKQR9vAt8WbVMixNlpPWXgfI
         sY4Xl1eVSI8j+lEPpwwboGGQf9Ubre945UrshD8nbXazQMwqFW6Eyxf8Eid0A0kTZRvl
         4Kk003hahtjMg9dZOuYxm7yGKKoWmSYnKkj2EhB/VjGfwRj+1IZ/hzxhMrrRcITCySHp
         k46E8ZV6xHc2b6Hh0Qy9WaI5TltHrgQFKA6c/Wpj43eDgA6gHzi6aIqjkN9H9rzq16ix
         pBfzS8gZwIa/hW8NJece6YqWDcsC+Ky7RC3PJoNwPQ2SIoyZj2tck8AyzBgTWgbEaVea
         4xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228856; x=1778833656;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F0ui433QL46rA01gquLwWXH1KntcAtkrT2sKr2CD4mc=;
        b=grbcdguWpkAFQtEA+BtlYQtUiNCNLOkMPDihnHfNKdfdaqGoGN8+lZZ25LWLwfmsMu
         pKoeZVTcdwqviFrr/v8doZ1WflXcXV60ttYKCN8xgvjAY4a2AcQ7g6JbjVHj6qrfsK24
         FvqoDbpt380lEaf847rJj65BT8EeuqRpldbIXEqHII1pTfpEuX++xik2b0g3TrZGHKLD
         wzhAVvgcVzp9FavjesLu/cnhdJ8d0UhuMbgu0U+k1+KFuiSze1x+WqW9bVLeDilh/t4+
         WMlOqw6aD+Te3j3Y3FdSiKFf1i+qkrbOpEZ5D5MB0+FXvXYM3ldVLx3GuX0K3oEIJ9NJ
         BhpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gZJSw/mhPyd19Ik2LPAVFehmVfksRUnB6qRJMvBUMeh2+1zxsWrxu0+DbX+bJyB8U+bSPVeZKRl407iRTW4YX@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGcFKX3P2h5keqEk83dRS4SkEWAkPFime/g8AjgkAXljB5l+W
	JT5fQz5n2qjskXHXD04ZGgNYk2zmWo8DXJ5Npe9rx3v+b2+dhsfn/sU+9r+5rtDWUcXflVIV9AE
	Y/RP8dVtxiw==
X-Received: from dlbsn2.prod.google.com ([2002:a05:7022:b902:b0:130:c9dc:1b88])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:221a:b0:128:cedb:33c6
 with SMTP id a92af1059eb24-131851d7c36mr5807637c88.16.1778228855651; Fri, 08
 May 2026 01:27:35 -0700 (PDT)
Date: Fri,  8 May 2026 01:27:22 -0700
In-Reply-To: <20260508082726.2795191-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506004546.3140141-1-irogers@google.com> <20260508082726.2795191-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508082726.2795191-3-irogers@google.com>
Subject: [PATCH v6 2/6] perf tool: Missing delegate_tool schedstat delegates
 and dont_split_sample_group
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, gmx@google.com, 
	james.clark@linaro.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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
2.54.0.563.g4f69b47b94-goog

