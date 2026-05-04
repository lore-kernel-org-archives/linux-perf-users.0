Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3423FC5A
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777866701; cv=none; b=JLVUhoXfdZje+zwKFNQ31Ucrbni9VfeYyzw9clUy7CNtErkeO76q8wpi2KxFlqKS6feynuCy6NUx+Xp+uw5uqBd2Xc+PdOSJ8CXKaQ62PWjwa0lVhnNE/7o6i1jXuE/uFBlX25lPddGCW8b/cookouPocffGUKGzTG2lV7HkXxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777866701; c=relaxed/simple;
	bh=oO73p1xRPTCaH7zWY9uPtQL6ZrNpPDEb1CrIWcRHrM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MXVZVhD9MMwrnxdP4hhN05OwUabajUgczYFjeVLiHjcaRcwo90ty130ZH2t7HJAqoBuiyNuGv77pMbcwkUEzbYWK26tM6zj5cK5sG7j+Q4IC0eywWtBmEMerDOWMbvO8pR5oaK4DesyWcijG1K7fHZCSvpR/qKYOIqmx/NUQJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njgijQdj; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njgijQdj"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1275c6fc58aso7413572c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777866699; x=1778471499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdtzf9eHR5G9u38wQE27Ez1yBHseJb6vJmHAUnBL/S4=;
        b=njgijQdjeI+S156AYjrQQ0RWaO9hI+kZi9ftc6cIL11QF+PC+O4qVjc2Y9bBt+OtAb
         xHzQ5H0hu8hgcuYtV1Io2+78YlhS3KznOWyTqOOKwZRgLr+y3W2wpK60ZayHhkETITtg
         1QQVTo7KdbnGwbChXGzjsDPuhoO2iHnQ3XGr3fnxSOQnAXZRsm5699kapFbh+jCSQ5eq
         aYVfghpAAWWi6IY2yRq/5HW0wDES+LMJ2afflzbIBsHuCHyqz8fvIJkgu/9J+AXASJ0b
         jTe85KyK2kL9JNKBjFP+pW1zR8ij3sNKpcycjPYcVzh5x2/mK40MOgguI/F6bwcbyM2S
         eA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777866699; x=1778471499;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hdtzf9eHR5G9u38wQE27Ez1yBHseJb6vJmHAUnBL/S4=;
        b=oHby0HUszd/6iyedE0CfuLmnwlXaLri12wyDqvFuZ5/WGCAee3mU/pfVCE8A5eOtds
         mEG4XLrM2CmGb6QW6iJ+pf/iM6Pd/kF0HWwilunDUfZ14tAIt49xtp1zOX5X+8l90o8J
         wmjX/aw+NUoBXARiTAk6FAIuaeYRLivRLuMnseXim9GOoVXXT4oJPhCZcTKVFvdWXUxn
         GNodjf/SiX6FNqbxVpcKKy1Vn27rO3ZHt6dLqLwkLbg9IzO79feM/oB6Rh8kiKep+WFY
         DpvYpwok4AFMe315rLjeYEw5jluiLVVvcb3l9r56YVH25kTvDmrzqCnCKwlL4CHgXC/m
         VtlA==
X-Forwarded-Encrypted: i=1; AFNElJ/LPBjqfYpdoZ1szdSlnLCu3RlMuiMqrScLFsMQTgV1oo+f+235d+T+zllq9seoP9Sez2hDn6Hz/4VGDmOA+Zt4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpi3LOgA1/BIAdby2Q0YEtJZtxCRvCHWqLiXFxX6RqcNx9VroV
	k7GGzFLPwzMh6hKaQ2Zb0kYXXivxwKoE+KmC5zjlRRm6IBGme102tqIArN3NJ/yjZXJZn4xmz72
	+UGrZoyDsDQ==
X-Received: from dldz12-n1.prod.google.com ([2002:a05:701b:418c:10b0:12c:91ef:91f4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e1e:b0:128:d20a:2f40
 with SMTP id a92af1059eb24-12dfd79e773mr4170199c88.8.1777866699093; Sun, 03
 May 2026 20:51:39 -0700 (PDT)
Date: Sun,  3 May 2026 20:51:23 -0700
In-Reply-To: <20260504035125.1851720-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425020529.3246331-1-irogers@google.com> <20260504035125.1851720-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504035125.1851720-3-irogers@google.com>
Subject: [PATCH v3 2/4] perf tool: Fix missing schedstat delegates and
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

