Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D081E157493
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018513; cv=none; b=McRQVw5gWbAuuu3PsxW+0GGxtq+ZM8Cm4WRhVs9jearklLqtRFvjJdecd67eqBu9nM5L2jw1niiNu7B3rS5Ftv/W40et7uLQnjDgzr2uj4C2SRvO11MOlO66Y9p1IHc1azGbjzsEjToznFBEK+ALY/DyoBtBHaKSjj4Yl6MTjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018513; c=relaxed/simple;
	bh=j8Z7oAr4T/RVK6j3SDFulgi4NDpLrg8sogiffRXB6e4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=otdBJ+ajTTX9i9Enn8MPSPaRGCqj3eaoYH7PvcHPdpC8krp5m9NcLkpmpu8b0bx7Daw47r9YoOdSniSuQnRgX27Pcww0+ilItzATwiBiq9DlCs/h/TvGnsxXHd9XuNMiARD8ICoIuHxfBUUsJMM9gemaX71B5VIrvfzSaIzYK44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYzbgBq0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYzbgBq0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bd64c9eadso41180977b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 06 May 2024 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715018511; x=1715623311; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hckve5lNnoWU91k19E5DrtO6+aB3SdYV2ufG0b9QIiw=;
        b=GYzbgBq0CUh7mv00eV/hN0y1zvwgUiP/COI4VIZG8ZwEMLniCT6zksTNohOXptQ5cT
         wfzc1QAlUozr0vmq2yZJ/0+gSVkosniVBbLSRJhUSuhl9ZSVLMnpBjJkRvp7WQn3ZZgD
         lSiqiZVgeSTL1Y49xXCFq+/5YJg3BY64Ar9PAjuBdr0gcP3HNTc5NKDiwJlZ0r6qbLE8
         BnMC0fulkneRyNqE62tHwHEA5vlzhyRYLQ252a4zFKO3faBj6cAXnLYqr5ssGa5N6lVo
         obvRvQnLnOIbXgucgLF96zTHmpDYcBJS6BVUEzomPy4i/mSCDOeeEcrRsYMzm/oKQFo/
         yXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018511; x=1715623311;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hckve5lNnoWU91k19E5DrtO6+aB3SdYV2ufG0b9QIiw=;
        b=YjCfxDa+nuGCrHXsS1bPCGdIBqJ5B94psEUH1cT1aFwywAaN6JxKDqvz6yZlyqFH0G
         Hc+g/eajtMVtGIDGRicDerVvfB4ovfTbqwWisnppx7Y4SwwFjF1sAmvE0nAA5DvTLuQE
         tVyzQwo57ZCUKmCzBXhOX/gbosPsrbefA3qccFsog76zA8Fn/DmsUdmG86iZk7ufYZjV
         RmXiTpFFlDYLzw9tKMoexfV1f1GGx8qjVp/dLRTvVZvf7IqlNNjQGZLp2CbF2OoI2JhB
         rnZWqERF3Cl80rPWVqWkI+gmYu7koz5fsfwyQNDgzSct2q3EI1gq2Czje1fk5FwHxJ0a
         pPmg==
X-Forwarded-Encrypted: i=1; AJvYcCXHgZyR3kD2sVNa2y9IFp6rY1LvHRTvalsZefBD/bOWSb5lUBo8/xiXuvFgPQ/4OPQB7Qb4cbcr5CfPa5EukLtNhzBjm0T2wkkZc/f9KCINkw==
X-Gm-Message-State: AOJu0YwIdzBdpgRIRv2dx8y3qWCN6UotIruz4WMtMvjjCq+tcykcVnNx
	55ImQNirbjAN33YvJvyynCq0ecWP9jN/IshZ4EYNsa6EqahuQvakLKYZL5JrlYEFJiXTspCHwOi
	svk9Oiw==
X-Google-Smtp-Source: AGHT+IG3NCkA5GcJ1BRwj4DJ3132qCOi6Yk8/px2hKYaoO10eMAK/YabhDsirkl8KleNCntIW7iZiy7P1DE4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91df:9b7f:c8d8:409a])
 (user=irogers job=sendgmr) by 2002:a81:498d:0:b0:61d:3304:c25e with SMTP id
 w135-20020a81498d000000b0061d3304c25emr2878746ywa.7.1715018510893; Mon, 06
 May 2024 11:01:50 -0700 (PDT)
Date: Mon,  6 May 2024 11:01:00 -0700
Message-Id: <20240506180104.485674-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v7 0/4] dso/dsos memory savings and clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Changbin Du <changbin.du@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hopefully the final 4 more patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
a near half year old adventure in trying to lower perf's dynamic
memory use. These final changes fix reference count issues, some
introduced by making find returned a getted (+1) reference counted
DSO. The last patch lowers the overhead using container_of rather than
a pointer except when reference count checking - asserts maintain the
validity of this.

v5. Rebase, adding use of accessors to dso as necessary. Previous
    versions were all rebases or dropping merged patches.

v6. Rebase, move dsos__purge NULL assignment to dso->dsos to above
    dso__put to avoid a warning reported by Arnaldo. This was part of
    patch 5 in the v5 series.

v7. Rebase dropping 5 merged patches. Break apart the fixes per
    file. Tweak to the map dso logic as the else path was missing a
    dso__get.

Ian Rogers (4):
  perf map: Add missing dso__put in map__new
  perf symbol-elf: Ensure dso__put in machine__process_ksymbol_register
  perf symbol-elf: dso__load_sym_internal reference count fixes
  perf dso: Use container_of to avoid a pointer in dso_data

 tools/perf/tests/dso-data.c  | 60 +++++++++++++++++-------------------
 tools/perf/util/dso.c        | 16 +++++++++-
 tools/perf/util/dso.h        |  2 ++
 tools/perf/util/machine.c    |  6 ++--
 tools/perf/util/map.c        |  1 +
 tools/perf/util/symbol-elf.c | 51 +++++++++++++++---------------
 6 files changed, 75 insertions(+), 61 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

