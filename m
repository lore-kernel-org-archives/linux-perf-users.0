Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A221805B
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Jul 2025 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148096; cv=none; b=F/DS8VFwjLNHvQdUW+lqtZVog1AmqIEZfopoyjyz4esKTVYSZzSO+pDWiWOdLJLRg13HQcKDToVNe3ajwTKxtjtxhujNc4hSXxD6muKDJzVWUik9jbV5NwNTGsDqOnUwDF51+WZX1+nSMC41Lt8DdZPQIhsFv8H8XRHWPGqHPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148096; c=relaxed/simple;
	bh=ml+CruI2TrPMvJL6Ve9QrgFk1hQk6xyzgZpDd4Hsx9k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=NNCuI1MHEd4nUkXUFgBpOIJfFCB8Qvz0dQd3Og4kY3i8TbhJvhgCKdZ/95UFu+FvmDYw5zKWVWMyu2jNhHGfxrUOuBLvtuq5758IUHtfoJYFRnvQNxv7NYIaCj8oVBnmoiZuAZJYqlK53X/RXUXtA++FvZxU4pYfbBVAaMpJ6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvlcyMGk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvlcyMGk"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e7337f26so5169514a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753148094; x=1753752894; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QX1c9/Mh/EGaQrrI9AS/O0cONZegTS8Gy7pO7vmBK3s=;
        b=MvlcyMGkvguZyE/HX2S3tFptEZmfdf6um0/FPqZHi8UMivcsnUEi554qlrqwNVihUA
         xuZE15yOrxj6NGIcNs8E2aZtIPeH/PZeAKyUECUZMiV6+GCqt+uNIMqvNfqZjKGr9zcd
         yfDAknww3QNBPAXAalZr5TdhZM3DzPPfbOVgHbvmUMAuOPQYzqAtR6qyY2Yo8CUW5KUi
         8J7FcJiY9tZMmI/8Y32oEUWXFDIW3eKfHVp6jcEnEw5u8iMtN0stAJVb9EscxiNqSrJ1
         E9SNUROma8V0OcmmFYMocQQRRNN33B+CtT8T5kZgu8Tgqv7QFmtXT59hzr2ZAqWbiYfF
         BAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753148094; x=1753752894;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QX1c9/Mh/EGaQrrI9AS/O0cONZegTS8Gy7pO7vmBK3s=;
        b=mhlskGLe62YzmsPqTfQBnyIK3CAHCAMYDAneeEW1NuwWaAmm+J54TGLBEuCA1ih4YQ
         gHH997/WBoZbpmlZTTaoC20Kvis2GzRuarWqXWcs2UvjMPxT8e0sMzT7MULRqFwdT/yE
         0kac6OFwHuEIkd0/cNPkBjEmuAddZQzV0FZtSKq5WCgyJUiDq596nywYTFUanf0l8Gu3
         VUD/UUwv9IqJsVJYtnGMXWO55M7/75/NGI4EvpT4SSAr6Rtp3KYQiapQT8HR0BeCcaKt
         Qtg9JI30jsB4UeAHEmgn9WUw3SsU3HOUIm8sgSPMRL4vsriHQbXoQysL9825YbjUWjvG
         Unzg==
X-Forwarded-Encrypted: i=1; AJvYcCXPcl+ZBCOchv0cw/Cq7gx4u9lVsEN+okNXlT5SjmBJIZ2y/nooyxRxzhenGqegYQ9c8YuI1NnWS8a1Uf2bx8p5@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaIOy9d8iHO6Gy2rjxB2Gzkal3jvDvigHw0fqwu2xbO8A4vUB
	uEMh4L/euSPOwomNbXI8NxFy3ZPsXtfhS/iBZeA0PcFKOYgmijAghaJRpgymj4SygIQczhJ+rHe
	KLGHg5O1bNQ==
X-Google-Smtp-Source: AGHT+IFuiYRn2c2rkf0K51zFEPQoIVUZo3CfbVzecU8nFOP9As6coBCa/SJWHmxy0MbELM4WWmNrSHBrySJ6
X-Received: from pjuj4.prod.google.com ([2002:a17:90a:d004:b0:313:242b:1773])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:310:8d4a:a246
 with SMTP id 98e67ed59e1d1-31c9e6e515cmr29689084a91.1.1753148093986; Mon, 21
 Jul 2025 18:34:53 -0700 (PDT)
Date: Mon, 21 Jul 2025 18:34:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722013449.146233-1-irogers@google.com>
Subject: [PATCH v1] perf pfm: Don't force loading of all PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Force loading all PMUs adds significant cost because DRM and other
PMUs are loaded, it should also not be required if the pmus__
functions are used.

Tested by run perf test, in particular the pfm related tests. Also
`perf list` is identical before and after.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pfm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 0dacc133ed39..e89395814e88 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -47,10 +47,6 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 	p_orig = p = strdup(str);
 	if (!p)
 		return -1;
-	/*
-	 * force loading of the PMU list
-	 */
-	perf_pmus__scan(NULL);
 
 	for (q = p; strsep(&p, ",{}"); q = p) {
 		sep = p ? str + (p - p_orig - 1) : "";
-- 
2.50.0.727.gbf7dc18ff4-goog

