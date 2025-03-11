Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D7265CAC
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729017; cv=none; b=GyQ2y/A/c8nON84jITh/HuDylKN78NSC7g4e8QlZaaMxuFHMLdEi1PskvLnrp9sexIACB6QZxlzfElBH3QpigQkcdfrnJhmV88uPZNjXfur0DlDxIuamIFyQKO9+gNqwe+Ch0Tej81ozutSXy5Isq2TfUaK21Ihsrg4r5YVVXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729017; c=relaxed/simple;
	bh=mLsQsEIO73xBmM9vsJ3R8Kz8fz9in2ymsfitS/Q+6AY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VoFvFiR2t+J09DDWvBKidVjToxClCnetLv3bRmIAU+xiyySUOmZRmtK0SDrnThi8qXdXwqfwPYiEdLPlHW0Ahjh6Zp+ln5lGkWX2N/RzQMYKd3JM1TSRX35FG679RiGElZUz/WkDnrYey1sDHL3qSOneWLZM0It2XVsfVi+YQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGehfEsA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGehfEsA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fecf913cb1so49318877b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729015; x=1742333815; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8gu1Di/zUmYbn8tyF2eqH0X4o4XUYppeibtvEPtbgE=;
        b=TGehfEsA9Kq+0Fcp1R3fkBNA0chl+X+vDjKayC3O1q8ZG0TgxM0M4MLuT6CkJJdHAW
         wMKGhtSgaaEl2kjj1S0tY0OL8im633QMKy8vCf7jNqhKPVUKJyUHRyCCB+dCWmj2rV2H
         AJMoCDhZNdVGh9Mi8EHeqsRNsPdWl9cYxh0x1v6gP5KvVEZLY9YLKh34P/LCOyA9BnJP
         xeg47M/WoGw1C8VXV2/j3wIdnkBGG8Zh0ftP2hkXbTLGaceb9YBFvyUUhSo1zoyXPZrv
         j/npBb74v+MJlkjoF7FG1vvCgEugrwWSDOy4L0kFWqGiLNeUgfK3msxoxDrJElAwG+YC
         nbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729015; x=1742333815;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8gu1Di/zUmYbn8tyF2eqH0X4o4XUYppeibtvEPtbgE=;
        b=U2/DU5OIDwudFcujSM5jYzuhP5GH7Klhr3B2KeRb+YroCV2Q5iw6iA8ucd1aMxC9Tw
         /demnbrS8xee8fco2b1+wvqIo1Ka6T0+M0eu71PLhZgljIW73aaJkwR8yxXdyqXAXd77
         EFKG+cQfsJa1FhJBYu3t0sNgLQBJAehJejPChkvn5mRCMdxa1AE+yEF5jx9d9LOGcabG
         32ciACxLAHons1E4Cjo/qCfqt6jEPL/NZxQnem9RvwmTrfthmD/Tf+B1DQ7RCxHsmCbu
         +UOjK/DfJh9U4O+QcPMxx5DRKPprbvigeJFCA9F8kpy0cmnZwPxoRCQaXZCIr4G9bm9O
         7uhw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Cxd3ChdZVTPPAz57b7xlkwsljhsBnQxgVBpxBqliKF0JRNRty0TitmFf7lfJxDMai26xxVzcCqBVebI9DbPX@vger.kernel.org
X-Gm-Message-State: AOJu0YyJgzwT2P3lji3funGbm5J9KvaMYyuTHFIVli6OEhqF4lmf5P+F
	jXsIClvY6VQJM44hgUXmd7pK8gB5fRN87MSp0LzS1yEyu3/0YN3iCFpZypwfrZDSI4qE14Enc+4
	ZnI5+FA==
X-Google-Smtp-Source: AGHT+IEz+LFN4quqaR5VAHqEapOidJstD7y2hXW/NZNzazTPdcKioSLliqOChxoYmOm5OavNY12rjDD6Xthq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a25:2651:0:b0:e63:7636:bedd with SMTP id
 3f1490d57ef6-e637636c624mr1408256276.9.1741729014879; Tue, 11 Mar 2025
 14:36:54 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:28 -0700
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
Message-Id: <20250311213628.569562-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 6/6] perf python: Fix setup.py mypy errors
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

getenv may return None, so assert it isn't None for CC and srctree
environmental variables required for the script.
Disable an optional warning related to Popen.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/setup.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 649550e9b7aa..dd289d15acfd 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -3,6 +3,7 @@ from subprocess import Popen, PIPE
 from re import sub
 
 cc = getenv("CC")
+assert cc, "Environment variable CC not set"
 
 # Check if CC has options, as is the case in yocto, where it uses CC="cc --sysroot..."
 cc_tokens = cc.split()
@@ -12,8 +13,13 @@ if len(cc_tokens) > 1:
 else:
     cc_options = ""
 
+# ignore optional stderr could be None as it is set to PIPE to avoid that.
+# mypy: disable-error-code="union-attr"
 cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
-src_feature_tests  = getenv('srctree') + '/tools/build/feature'
+
+srctree = getenv('srctree')
+assert srctree, "Environment variable srctree, for the Linux sources, not set"
+src_feature_tests  = f'{srctree}/tools/build/feature'
 
 def clang_has_option(option):
     cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
@@ -71,7 +77,7 @@ else:
 # The python headers have mixed code with declarations (decls after asserts, for instance)
 cflags += [ "-Wno-declaration-after-statement" ]
 
-src_perf  = getenv('srctree') + '/tools/perf'
+src_perf  = f'{srctree}/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

