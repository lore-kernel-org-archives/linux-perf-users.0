Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617471C3BFC
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296193; cv=none; b=pCIqGvQgdwOK0NHyLU9KDLuiI+hw7k3+xkIYBamoetDzpvtyhI/0ibexZNYxFAOIs3BVA9z0fbv2Z8SUodYxpnmtMD8xOrQtCje1i7+hqjd86pzk4Y1mf6W/X1L8gvRHXFTt2tggfb5Iu9WIDzVD46xDN+XzdZd3iP/U+2Qg3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296193; c=relaxed/simple;
	bh=ESo8adYL6QabyJApQ4LPsfXjKpfgqwShaS5GxF/euyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=niKpviY5jmgHYYmkjxmmHuGcz9sAkB8tRd2KJrE9JfzoPhzaiQMkwGg5iRq6b9hJs5zy8M1FU+uTJ5wbtZfk6wqE/AUOdc41pnrsaKdw1iSFeG63vPkdZ2pw70K00B4LKbMLsLO5hIJPhaxL3LtFGMFwT1wnehwqT4fjx+/V6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFm1KMG1; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFm1KMG1"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2be0575e290so628376eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 23:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773296191; x=1773900991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ER74iEy8gUVJnZ6jeSlc8bWwSBKIum0sBcnkXAXKwV4=;
        b=YFm1KMG1fbFLgUnkkyZuP13dETHRuWC6Zmf5bzMM6+5N+S/7zcOtkrPHvA1ydWp/pK
         1ySEPXkxeGpSDyi6lRQq80Fnjr5gRuUrsrLODeMGIVBMsEefIRdZC/PFnTblV7qDCR12
         CixZXNBSciDu/q6i/yGkwXhjVtuCZn1HEO57EsctkOdmZN1lvvLD7YIAzPvVgwL/sAle
         LtRCCLPW+DmygL/KFUzWCp55HeBpC704FE/txfX8n3X1rUjT1SztCnbqLveon27l4nc0
         DiRVqcPBObPQ/qahSt/vh+Dn1/yOH05OC5Huq3v8PpjushVor2TobKAQ0bNToouYkEHB
         bEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296191; x=1773900991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ER74iEy8gUVJnZ6jeSlc8bWwSBKIum0sBcnkXAXKwV4=;
        b=pBoe2pyiVSwnAGHHPad6UO+E8m6p0hrS4e9i4lEWHNbzX4jv5qxDmSbuTpzmZuTJL8
         1DPGEpyzO1WcEZTSkp9mK3P9suKEh+ztP/NRuxGAoqUanxUJBTwQC4R4oBk8WR2k9Htd
         kPKlQnQYg7yXY4iCjSUWi4FtSiWJI+CYgbOjb3kqBF3SvnDs1qTSDl/il+cwBJVKkY5g
         Ve6WNIN2sniKRKm/SkR/WWgaoFDcx/eR/qaWW+uABHumRHusYvaA1THJehRG2X+IJ9yu
         POsccg3sYnA1HuFLMMH18QcttgWP9yStP5+MdUY/muH8FxAgt7aXJgiJq65LjlxDdU30
         PRlg==
X-Forwarded-Encrypted: i=1; AJvYcCUm3ryuf82Y1BpHv6MLRM8UcEnruPTMfsA29DA0wpL9vpKs9tQI/pcwzsHtB99CmyuLW+KSJPN2xsKJLxH8JVBP@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGDhnLY0I1wgn39Xnws9ZyLjReQvg/qd5Jt0Kxf72Hkboy6b9
	LDpzx5cl2eJJdvd3F5VUV0ntJ47/BXmFHgdcPY0u9ByDv6P5AE0KK+ghD7LIfA7bR8bIqABDyTd
	ILiEqjrKO7Q==
X-Received: from dycnr22-n1.prod.google.com ([2002:a05:7300:e9d6:10b0:2be:73ec:b506])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5784:b0:2ba:6fbb:5e7f
 with SMTP id 5a478bee46e88-2be8a52f0bcmr2052812eec.35.1773296191280; Wed, 11
 Mar 2026 23:16:31 -0700 (PDT)
Date: Wed, 11 Mar 2026 23:16:26 -0700
In-Reply-To: <20260312031928.1494864-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312031928.1494864-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312061628.1593105-1-irogers@google.com>
Subject: [PATCH v2 0/2] perf evsel fallback changes
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Discussion with Thomas Richter in:
https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
showed that the evsel__fallback wasn't working for s390. These patches
avoid the problematic frame pointer callchain on s390 and fix
evsel__fallback from a range of problems when falling back to a
software event. I simulated failures when developing the patches but
they are untested other than that.

v2: try exclude_callchain_user for s390 rather than fully disabling
    the callchain. Fix a missed clearing of is_pmu_core if the
    software event fallback.

v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@google.com/

Ian Rogers (2):
  perf evsel: Improve falling back from cycles
  perf evsel: Don't configure framepointer callchains on s390

 tools/perf/util/evsel.c | 51 ++++++++++++++++++++++++++++++-----------
 tools/perf/util/evsel.h |  2 ++
 2 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog

