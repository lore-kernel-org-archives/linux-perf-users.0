Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEEA1CD39
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622498; cv=none; b=G2jY6fICPNQy4CsoF8Hz1QiXAJFBsonFgpyJIsn2A3U0FOFJVedStTbbjb8dniWBQoeSbcDObNodIT1WQ2TAKnGT6rx9ztVi8CG1GN8/d9gKaWEvV3bqelsy8G0uHUpI0sbfv6rh2UnNhSHjZIvSCZV++YeFJ1jA7AKe+NYMMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622498; c=relaxed/simple;
	bh=RiQ3QH8Mevr7c85qmwqOFnFf8n7v8w8+896FGDtfLBk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=MhuDEMjt/EuxkTAYafQnSqmM/wkI3JEDE0NcQqpJgRoahPhV03HHefV8eAiZjisa3mf1RiHQ3Ez8ScKGYjUCoAhhXRUKngVj9BNL6i8QYAHcM3Az2ROKBL4kwqzk42uWEUl60FbHLKO+3hF1Nyi7VH3aUjKTAKJr935m2V4zHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eURM4FrN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eURM4FrN"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de8b66d59f7so609285276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 May 2024 21:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714622496; x=1715227296; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK4M7DhO5mIJIFP1QifUvK0BbiOYwnyjSGyXVIhqvoc=;
        b=eURM4FrNL+rV5M5jGHtUmXebIP7s+6tV09lWMhLoOkB5oUe95jtHIZhHMSF8rOC/8a
         p3p61sV/fol1XY16MrcNf7uho3djCk7BMFxJD9NURm7ZeyJslSVg3clElCdP7BA1PKpb
         q/EaOwEOebVpdRdd+MADbQDCFdLY1wkQyjelDg9QE5jJjLu5dLFVBvWLZG8RJnsPw4Cz
         8fd16JwLyVvPf7TI7gbTZh1D/BaAE8Pja7WogT838qlIu/KpbLrCPR6Bo30gxpHh4cQ3
         c231EHottefKA5ZI0qvAFh/gg5k0AGs6JCovnszhmAjsW4nOGh7/S5HuDAMEN7CJXX0m
         3H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622496; x=1715227296;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YK4M7DhO5mIJIFP1QifUvK0BbiOYwnyjSGyXVIhqvoc=;
        b=X4nuStpomU/Rmd0HS99a89Q0ny9fkbyJx1jvnEfyl2sl0wnKNSgBRO90Za/0aHO0yh
         wtZyUwu2VA9VarjAwfLe2+cYQmBfRq2aP0TmaItRFYuCqsjbV2lTnHkgpgfSBOhIqySC
         OMP59adZZuBhK43cqDxwk8mFdgRKpqOVELkbcHcS2/v8BnCVjJ89NLNhyZL7sGKk66WR
         dcioSIhbzsxU9cKlDQcomHp0nlgNPwdtPhtTFHX3XjVO7ZZUb5mMPfMRJDc0lV6ql4wH
         7trL06Eb7dOLebL6VH+b6U7eXchXkCxNhMzNPiLe9vM5fRryWDx2q/kcuvMhP+UfZC06
         zYoA==
X-Forwarded-Encrypted: i=1; AJvYcCVYivfwuyXOQWP4dyCe4vzQ7MnnTIpXRke941TKbdihE9JbYGXNdnH/ySbe2yU0SB6i4/v9MgLSGYDuF/7u1ys8ERh93aOOkHBxG7YZPXfU4Q==
X-Gm-Message-State: AOJu0Yzi0EXDggZk35CojztkBXBLJigG+VKxbAgMfQ+gzUmVeCZ41gdY
	6ls1YsNq99iSdhgzcmOs6vY7DZQzI6dD+paXShcuRegD0JkB5MI4pJWrukH3hcv220E2u8CS+qq
	thSVYhg==
X-Google-Smtp-Source: AGHT+IFPc6nblxvkSStjTR2HZemwo65gYU0j5fOsBfVD2NY3SXd8R9XN1dTAVlFK+TBORZ9QnkCT8WE7n4M0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:53b9:bbda:1daa:17d3])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dd9:2782:d1c6 with SMTP
 id w10-20020a056902100a00b00dd92782d1c6mr419962ybt.1.1714622495773; Wed, 01
 May 2024 21:01:35 -0700 (PDT)
Date: Wed,  1 May 2024 21:01:08 -0700
In-Reply-To: <20240502040112.2111157-1-irogers@google.com>
Message-Id: <20240502040112.2111157-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502040112.2111157-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Subject: [PATCH v4 2/6] perf Document: Sysfs event names must be lower or
 upper case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

To avoid directory scans in perf it is going to be assumed that sysfs
event names are either lower or upper case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 77de58d03822..e7efeab2ee83 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -37,6 +37,12 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		performance monitoring event supported by the <pmu>. The name
 		of the file is the name of the event.
 
+		As performance monitoring event names are case
+		insensitive in the perf tool, the perf tool only looks
+		for lower or upper case event names in sysfs to avoid
+		scanning the directory. It is therefore required the
+		name of the event here is either lower or upper case.
+
 		File contents:
 
 			<term>[=<value>][,<term>[=<value>]]...
-- 
2.45.0.rc0.197.gbae5840b3b-goog

