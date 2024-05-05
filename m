Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36117C2
	for <linux-perf-users@vger.kernel.org>; Sun,  5 May 2024 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714878990; cv=none; b=u0xAQIIy0dDcwJUxCeReTiPwsapX8qOfvweOrSfLjRpLoPfF4PAZFvSg+qybxeEH14P3auCVIhWS0NpUU6NjAK6CvHrfvxTH5lZGTZnmPGZurP90SLDnMZQ/kcLs00wgF8K4uRiC9zmuW7P0OAnvEkMUT9yDHqE9gJaBXNGmWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714878990; c=relaxed/simple;
	bh=Z8j5CRrOLdlJCjGWI4GvBp9N/S6N1gw7if+g2FTj0jw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=EMeoQLnzMbDxLRqyFtLTJx+exlH8l5q8Y+PM6xYOZCq1K2aRt3BQ6TvjNSUGqXkwW9xj/A5uP3vza8Py+y5yLAZ08OIVpuULT0RistqQrLN8oFCOc5FJFAlIq3INcaIOeKxqIDdtnRn8OJfD9/4KgyJQ6vPZtB3KDErl5DTuYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hwa6VxAv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hwa6VxAv"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bb09d8fecso17738787b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 04 May 2024 20:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714878988; x=1715483788; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9uiYYye9ZD+jb2gb5x6Dw5C7UWM8eKydBAksThATf1k=;
        b=Hwa6VxAvym+QmxF6OALkVWIM0+7IvoJ52CF6w8n3T91AdgcVte6GDk/Xy9751QkJCs
         cjPPfMcUSdd+k6FiKpLlKVEtM+vtmQ4QJ6lmMgIoUSKCchIQYfrc3ZgS3eUa7fwFOLcc
         K5xLGk/ddPbbXgLu2cFvyFS/oL+Bujih+giHOFDfxlc+D9zdwWh93O1FiUjpjnO1FVFx
         w5uMcfe2rmEsa9Uqp8dxuQHDfveqisNtsLeU36vMcW0dsXtT6uMLwSt7EWe09r1gui47
         cCtTsurGjF5vqmC6tD74Nhht8HZb2zU40Vg6oDXQOx8HppsD95O6SwoyS2EkVs56jM5H
         cUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714878988; x=1715483788;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uiYYye9ZD+jb2gb5x6Dw5C7UWM8eKydBAksThATf1k=;
        b=XFcmAroXJPN5S47v0g1QmUwp7roDuPwQuHG5UY6rLRiZ5NszaOjMRnptHqhnUOUmfh
         O9LN/xzPxShwhvogINQ+NxWEowzKkuxJ+tmbvHZMOqnxcIh63MgpoywYLMSL3mn4CPLT
         YLUwG3d9Tt12eaU2HBi6iDdWYE7m/RkoOfhsiVvdaxIR+Nf5OswVX6g9tEZbqHlnsXmE
         CNqB/dMIoYDHPH6chL2K7l/gng6DZZPo9DkdUN9tKQmsZ9mLlpMOUP+jwOcrldcWggq+
         0P6N1DIGx3OltBaRKbooyNSwIYuhjAIh0+Fd0gtMH5Yn3XRsc3s3ZZ7AMRP675HuwSP+
         ELrw==
X-Forwarded-Encrypted: i=1; AJvYcCWQSAZY3ga2Aw/G+cEdEuyGfdDsew6jH+i7MsyXQjWQ9JaANjggLlSP1vPT2U5F4E0cfpNg5/ryVxYP/YmJ5hMidXTc+znaHLE6VDsJ4xLT2Q==
X-Gm-Message-State: AOJu0YwHTJ1JqZsdL8hNqXvaq+eRDi7DUtdY59p3b4dnzAijTYJAqPq7
	6bnjjeI5r/JTF3q6C7rvXaZu9OvUgcjEa9aDwPQlEG2GUsaVp/iFJ5wxQAKT+mI30eFkgevjuE7
	3/Roz0w==
X-Google-Smtp-Source: AGHT+IGu0Hu57WV3E0cZzcFCwREdxLNwrUq64n4z3CSgqpW9W9N8ZRmk/Uydox4zou9vFjG62TyC16YGXhYI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:566d:1f52:f5f5:c8ec])
 (user=irogers job=sendgmr) by 2002:a81:4804:0:b0:61b:1d66:61c4 with SMTP id
 v4-20020a814804000000b0061b1d6661c4mr1512634ywa.10.1714878988379; Sat, 04 May
 2024 20:16:28 -0700 (PDT)
Date: Sat,  4 May 2024 20:16:22 -0700
Message-Id: <20240505031624.299361-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v3 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The mrvl_ddr_pmu is uncore and has a hexadecimal address
suffix. Current PMU sorting/merging code assumes uncore PMU names
start with uncore_ and have a decimal suffix. Add support for
hexadecimal suffixes and add tests.

v3. Rebase and move tests from pmus.c to the existing pmu.c.

Ian Rogers (2):
  perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
  perf tests: Add some pmu core functionality tests

 tools/perf/tests/pmu.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  |  4 +-
 tools/perf/util/pmus.c | 53 ++++++++++++-----------
 tools/perf/util/pmus.h |  7 +++-
 4 files changed, 131 insertions(+), 28 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

