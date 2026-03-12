Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F230EF64
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296198; cv=none; b=ep7wZNKgahNldcs0kkcWcIubyVuFPY/6fVEPqYH80lSVq5dtwk9dRBEKqlVjMEuX1jW1yp1lHblDykY2PkVZTT0QAMWQCC87TkMMwKb8oA0Vlezv62gTS1lFMci4XF4RKbw5PoYLFJXqHLSdVAFY8Pz/datytsh65tVIId+PoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296198; c=relaxed/simple;
	bh=AHPgpQXNpmocpftwSDROOrgKtU/VXiRe/PzkSgRw7+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BuNT+EKpjBKm7i3lRwa9RqjPHjiJYBoj+1ZvzMY/o7UPtLcb3Wwzu+2DPgl0TN6b14dl1CgIm/Fwxn9GY3uBlAS/QfFIR1qfq6e+gSEF31dfxqn1czLAg3AenIlKkBWwLtT0f7GzBimNbWOHZo40Mo0cudokkk6OTfCXdWGgx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7ZhM/0x; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7ZhM/0x"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdff07d8f4so1039008eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773296195; x=1773900995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBDz1m5N4ziATwBlDRma/nMU8Fwj8JUl1F3v6VB29uA=;
        b=u7ZhM/0x9mh0q2lDmDYJR9wNFf9Kfoh1XpDvDBlKS3w2Wuxr+OpcA+1eDcXiv38icC
         SS741s2ot0ZPyIixW/QCJeeRYnPCAttSVd4PD5axDEbQDkNmZSomWbydC1o6du8S/BYC
         dCe2fwz03dcNTCokFcJ0Lt/V00cAJDB7j+U/a2p26HsVFYjvEcbjUOHliFzxpueQ1utV
         9mLU0cJAzqctZmbUkiVMyTExnhlJLP0qzd5qKOWG3tP3f/6eIzxHq7QMvA5mNL5BLCJY
         MjdjKwe1H0QwN0UgGNstbg2x2/5gOsOkOUPYdlIFOddx065g3tv+v5yuDsknHiVFpbYU
         ey6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296195; x=1773900995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBDz1m5N4ziATwBlDRma/nMU8Fwj8JUl1F3v6VB29uA=;
        b=PTUVhUGAYIvSZ+OmgMdn1G6XmRq8MRTyXnbj07myvRIXCtN+DXlZ1vEi02NBOgkMH/
         9KhtExznMkzATzsAVHbvQ6hKBLQZzZoPPour0tO4pFcPvEWuVCMg8+HcA6Ipn7l73H9w
         IQ+tWG+ZhVeQRrBJA1uJ7WytBIhpgTsCczNI0ha9vb3GL9SyhZo67gjCjGFOsAS6N8DZ
         5nAmhDfaHOW7v0p93a0QMXqUwyx/OtBW3pMGZZocYs9DmoK2SGDCAlg3jSD//GX0eqNF
         kMwac5/CWsnTk19an7Pb6qHfUYQ91O1yFqd8xREfQ5JwuFhSStHlMcEGF4s6iuKHINN8
         wyhA==
X-Forwarded-Encrypted: i=1; AJvYcCUSJBx+NRcoZHSyw4SNmUxy3pLZeiVLseU2UEAA6DRdSp8sU4O2nDdPd3Z0IlysxWzCty4JT34N9WazX0DR7o5l@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdXQ1HcdHDuXSs6FMAUFLW/BCRWRcaxarcYlryyTYoL51my7k
	oot0MhJgdqcCjURDYxjsdVywDrbI3LrCDxfaarXuiAtaJoiFVlHWvX4UCvE2C1/CY48VM1iR86i
	viPf+SvDkyg==
X-Received: from dys13.prod.google.com ([2002:a05:693c:800d:b0:2be:798b:cb2f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:310b:b0:2b7:da62:a5f9
 with SMTP id 5a478bee46e88-2be8a57b407mr2086093eec.18.1773296195273; Wed, 11
 Mar 2026 23:16:35 -0700 (PDT)
Date: Wed, 11 Mar 2026 23:16:28 -0700
In-Reply-To: <20260312061628.1593105-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312031928.1494864-1-irogers@google.com> <20260312061628.1593105-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312061628.1593105-3-irogers@google.com>
Subject: [PATCH v2 2/2] perf evsel: Don't configure framepointer callchains on s390
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Frame pointer callchains are not supported on s390. Ignore the option
and print a warning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Only disable user callchains as AI is telling me native "kernel"
    callchains are supported on s390.
---
 tools/perf/util/evsel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bd14d9bbc91f..fa21b48cba86 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1076,6 +1076,12 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		attr->exclude_callchain_user = 1;
 	}
 
+	if (EM_HOST == EM_S390 && (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	    !evsel->core.attr.exclude_callchain_user) {
+		pr_warning("Excluding user callchains that are not supported on s390. Try '--call-graph dwarf'\n");
+		evsel->core.attr.exclude_callchain_user = 1;
+	}
+
 	if (param->defer && !attr->exclude_callchain_user)
 		attr->defer_callchain = 1;
 }
-- 
2.53.0.851.ga537e3e6e9-goog

