Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F30206F2C
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736485073; cv=none; b=iYe3Qut4O7FTcK7eVBdStnoGm3VcxHi0/tNkg31+AAzHqHFx7FU8xUfMpo/ZbxbYSN+6zy1SkSQiMcle9gXCZ7y026lIspkH+9oVGB9IiKIMb1iaTN7F9ijlJeQohseSSQK6rWKhJmj2ENf53PvaZyNRxeXJ/jLKcqbPP//vStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736485073; c=relaxed/simple;
	bh=rb3nJ50Qx6Av0jjPKM4BDhZRCZf5SaYdGkra8TgFlyQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=swsx9hqtQhSZapIKUeFXaO0KN7J3b/rYtS57BuX2QraZTXM1UE5G9v3oBKmEyqRKiv2NO7LRPQneeQrodLAnLDKK99PJW8smScT8oMTPR25Pgnc9slpty1yMAhu3tWT+GkCsiSqVqcL7oxMSTkkaL2QcPanyu2xvtg4kCUr6bHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fan6/XZi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fan6/XZi"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e5380c13e07so3924926276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 20:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736485071; x=1737089871; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XY2zs0NTwgAFtZHHxTu56AgcGBqwz9PeDUjhHd39VYk=;
        b=fan6/XZiBnJm2zZlvwEMm9efPeJV1fwwhPdCveNpExAZP/igb87wNWlH+km030cVZI
         LNFctBt747SV04T9GiwaUb//EQ8AOTlR5302sT88bLksiRqAqtSYbxqDicGYIiMaffrz
         PQz93/q2FErJ+88WD5KGj9/ViY69lL0JJtaxdIOg4CrR+PmbqXDx3qWzXRBgZedeVDGK
         9oAhVCtjehsV9HYG4IYtL2iXTib+U+y5pB5Ah0NKXPeLSCp2L5edlbhUgUXc30Koedp4
         ivlg6+mekvgZkP3XZKWcnsr05pu2DgvXwndj7WHDiznHgXmNXj3wrVZnZQQo+25QhYwY
         zgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736485071; x=1737089871;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XY2zs0NTwgAFtZHHxTu56AgcGBqwz9PeDUjhHd39VYk=;
        b=OHc0x8vzmX/rTIItDIKm1ZfsdM3Xo8C6+fCsZjyjE97O68qNDszM/7hX0GackQvCqH
         zeQSQM8YsZnwO7aCcyJePO8fqvGSbDNlkr7FfhPq/ahKldKXNAvelaYjjRRQ6AmdtDKX
         GuLLuxcMX2AiWBFMMB+VqWfTn/+hH/dk8dSpWXPcxUlXHr5UKNkB5HFk6if2qMBql69/
         Kuwu+GLgOPm2lgbRrPqfvNJlI/46VfJ1rMwOVzqlHQArN7xgWLgVkyL/z1K0ujO0rxhH
         hIicEg/woduwb288ImDpxbchLPWYKSzj1uvOTZyqAq5knGjoCGF0wNaz+A+8OEDkzhNj
         7dcg==
X-Forwarded-Encrypted: i=1; AJvYcCVVtAhGZUFGFrtsQd9tcr4oO36/Ou0KRhM1fC6Z7OVn+pG6lPhdWJI/YMoA/kXOOAY22ERTfCWG9U+RgbA9Ho9T@vger.kernel.org
X-Gm-Message-State: AOJu0YxDG7leDCKkKbnSZOvMRMLbPI6R3GX3y+2we6Tv+Iq9X7+gBb+v
	ihhd4Vd8V/aFXnR7eMTuHTKom4IU36/qbRd5tbNE3a3cAC+uFuukHdfV2jN1nw1OjNK679Uh0/1
	CDWoJbQ==
X-Google-Smtp-Source: AGHT+IFIVuzArGHZBa7KPHOYY4abC9lrWC65jcX0uiEnKNDtualD+N8pzCnxGBoqwct7KUkJxB+AZRqcdjJo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a05:6902:124e:b0:e48:6770:76de with SMTP
 id 3f1490d57ef6-e54efe6685dmr29054276.7.1736485071247; Thu, 09 Jan 2025
 20:57:51 -0800 (PST)
Date: Thu,  9 Jan 2025 20:57:36 -0800
In-Reply-To: <20250110045736.598281-1-irogers@google.com>
Message-Id: <20250110045736.598281-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110045736.598281-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v5 5/5] perf test: Improve verbose documentation
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a little more detail on the output expectations for each verbose
level.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-test.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 85f868c324ff..32da0d1fa86a 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -28,8 +28,11 @@ OPTIONS
 	Tests to skip (comma separated numeric list).
 
 -v::
+-vv::
+-vvv::
 --verbose::
-	Be more verbose.
+	With a single '-v', verbose level 1, only failing test output
+	is displayed. With '-vv' and higher all test output is shown.
 
 -S::
 --sequential::
-- 
2.47.1.613.gc27f4b7a9f-goog

