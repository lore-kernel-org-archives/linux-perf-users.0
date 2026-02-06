Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F43093D7
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416722; cv=none; b=sK3p1CUowfmxIYn2kdRgmgOvrkqf3yhrsTKBPPnRQ6do60woukWrNif3HMrblijKia7vmtrAtKyRuEz5KnAJ92JF+TAvYyAFuB1OqYA/fXGAiXMtmgHThUYrRjXaLGjemt1Q6TpkRerr8OGR6o90hni6WCGUirbP1SdppbZDAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416722; c=relaxed/simple;
	bh=s5HhmH++c0S6/4eaW7RJwAr9NrI5mDPAqNzC53KKvuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ayKrXm1Yu6eXKEoyCdYJZTJN6d6nDINw7PNacHfWkxPWd2LW+N36CnjGYRm3p/OzGy2wS312TsH5BHFP+JV9qJhreW/WaYMAnzG2LaXora2JRzf/+anVHfIC3tjCrzDkhW8lfAgO3IV4YzNfUlUH7Bon/JvQ57zHP1Ti7KY9gWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DabrC/ZC; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DabrC/ZC"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b71c5826fbso2696599eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 14:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770416721; x=1771021521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=grVQSNoKkwDwm/7kB0bTBCG79LQ7uooFEeHk2Xib8y8=;
        b=DabrC/ZCdDzkR28el37cy/dZ1pU9uzENnqJHzjU2A4WRf5Q7SGbdbHJWU3rCCzqtzG
         U4WNX3Lx0e+0rlu0RSvASod6urJ4V6H8azG41SjnM93oaDKO1LGhkU3UdYwpDMzsujRJ
         WbswQ37o1xdq4+bELACiBTp+obXiyTAW5KBwance+IcTRvhQliTxYPMkaj+Bn3Num/sj
         uw2QmthMjNr8wOb89eFjfldcD2flerzdSRW3lWF3K4qkkGcD9OXF/hHulXYqqRg6ajOs
         IzQAvWPo0gWUqf2wsWpJ2jRooFk5hzEurzk4izL9J7DCdUNpGdD+XAK3C8fOhB6fw+W+
         FjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770416721; x=1771021521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grVQSNoKkwDwm/7kB0bTBCG79LQ7uooFEeHk2Xib8y8=;
        b=k8spwitDfiPK4YJXW3uR8MGdqqUpOznFCeFoIgfQSyAnOgQKzWXEMFKITzxXXKmKZK
         W9dnMZ2of4ieafVXmrTpLDKR/W1+sU65P4fUn5MBXMzzAZwL5/UnAefdoJKMNLia2vvC
         x67x9DsZ9eRT+RmuDG/Rnl0/WGvB7qmHuETkdovYtoTxm64rF+Otz2sRZY4Xy5djwKNT
         r/4rQj5+gmDrrN9Sm8mWch5Sm0kk3qTR2rZzHd0iTWZli8uHk1lN0vxGASyx0SnhNRsk
         znw7SLLTB4VIKiX2eJ53He7ZyC4zpY9QhtbHK5nt1CSpVDfEDQ1DHMExxKuYNmr2jnlR
         fAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyy9dbswGHOwJTEbUbmwz7LDXpGW9Ojm2KZmEDIBED0qFx5emL/6QY2Yeu+lJgNv9RviDjWO+whdAx9XP2MhLx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx85tpS/bIMmWuTrn2YvHEUtOPHPesvgidSSJgRhyv3vIC9pjGt
	sDiNKUJ5zuQtfqoTDqapNQMvfzIPo39nN1MN0G4FbQ2bR/up1PaNgd8s/KXwiGyZqahITcyXJak
	x5/Pl5hjnWg==
X-Received: from dybpt13.prod.google.com ([2002:a05:7301:408d:b0:2ab:9468:d9cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3117:b0:2b7:2d5e:914d
 with SMTP id 5a478bee46e88-2b8563d8ba2mr2179061eec.9.1770416721194; Fri, 06
 Feb 2026 14:25:21 -0800 (PST)
Date: Fri,  6 Feb 2026 14:25:07 -0800
In-Reply-To: <20260206222509.982489-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYZnkYqWXnKpHd3h@x1> <20260206222509.982489-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206222509.982489-5-irogers@google.com>
Subject: [PATCH v8 4/6] perf evlist: Missing TPEBS close in evlist__close
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, thomas.falcon@intel.com, 
	tmricht@linux.ibm.com, yang.lee@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

The libperf evsel close won't close TPEBS events properly. Add a test
to do this. The libperf close routine is used in evlist__close for
affinity reasons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3b0d837e3046..3abc2215e790 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1356,6 +1356,8 @@ void evlist__close(struct evlist *evlist)
 		return;
 
 	evlist__for_each_cpu(evlist_cpu_itr, evlist, &affinity) {
+		if (evlist_cpu_itr.cpu_map_idx == 0 && evsel__is_retire_lat(evlist_cpu_itr.evsel))
+			evsel__tpebs_close(evlist_cpu_itr.evsel);
 		perf_evsel__close_cpu(&evlist_cpu_itr.evsel->core,
 				      evlist_cpu_itr.cpu_map_idx);
 	}
-- 
2.53.0.rc2.204.g2597b5adb4-goog

