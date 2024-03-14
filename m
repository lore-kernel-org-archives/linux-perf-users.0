Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0003D268
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395482; cv=none; b=b428/98nw9+5hl/prqi1G6kuIqDS4RipUQY2ch4Xjwlg0NsxqNkKE6Sl7M+L2evkOEI26uoj1/UEViC/Gs7s+GoLZhAw3Rp4gsO5kREBNVZ7W+9oo/n0MxWuzkjNBFhlL+DhUlsVQRpdLYG97LtustazxO8KUyOgc7tScyEieMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395482; c=relaxed/simple;
	bh=pYwFBWamBieIdW9SZt9AVp6RucUVMKW9akUtx9h7loo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=q/mgZWpn2PqkBQgkjoShUJGLcJQGPFDTxIB/zrRIiaj+9qBhDW5VeMVogvhMaGVVhQEXOd/AbopVoV0+ziJaVGNmrF/zKealf6vYthtdFIVe/ICkoiNfZfshWawtJc0YlA7oqTM4WFxFTo6QfigGNv1YAliSVliLxK10DWeGeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CO9py+S1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CO9py+S1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a4ee41269so12720887b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395480; x=1711000280; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Ycxt5yLzxCom5vbiObPBkTkTg6hjsPvowJcvLZ1CJY=;
        b=CO9py+S16TCITvJ+syklCg+mB0n32HiRA+0gFeySmLSIzl53wuaezzVvag8TAxi83o
         mC6TXaK7YEcAbKC9f4tNXmA+IOihaKqwAw1Y28+cWyFxDdxMtM7bVk+h/b5BLnK10Nju
         f4TPF60EZh9W18en+4GnW4tyiMap3XxIvZ1QSDsWZDnW8+qhp8hqt19wC4Z1+glZqdz5
         GP58P814iYmB9a0wFLW7WFF+xCXuC456XENaHkEwGZMf+jvbWUKkSBhTdAM/esRyXdZq
         n3EOYKt6kpyGdsOrPuLig1rJS+Sjq2GBdLOiCQIUx8bsYKJPwJOziOUXnqL1usQP6AfS
         1tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395480; x=1711000280;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ycxt5yLzxCom5vbiObPBkTkTg6hjsPvowJcvLZ1CJY=;
        b=SprjetjLZX5yVDZynS1pJJy9RNgl+jANMC9EPuWo71v2jevE2cwOHQSoiUBUsUkYA3
         jLOnTKQI8MrMupD8pwmnC93h1RserzvZhoQBRjmuGwhhhdyt2YafSe3svAKsfihj90sI
         64Pjj1/8KtOp2uFfe5c/ZLmg3fuOSg+TcsEw62XaZ9OGuDC+PNalCbihNQZaAOk7JIEE
         thnQoRTqpS9D7MlUPIDxY3ucO+RJqq4urftcBWXJUGB3gQ+SSk6T3F8c55OAUvqXgHcF
         K/wDFVEP6QjRgG4RiWR/1wBkpcZWvnhT5NfYdTkKddom3cpuyrW2GzJO2QVJe4D7fSz+
         Pcxw==
X-Forwarded-Encrypted: i=1; AJvYcCXMJ5YjjPmpiXYeqw7qLsHfB6JJKDyGqgeWgPiLJcxAPI1PXwZttwAnyUFTgyfkfK1nNRy41tDM/0feyUNSH0LO+rG2y6mbghPc+TLzR3KXuQ==
X-Gm-Message-State: AOJu0Yw4sPn4ltpiutQIIFBEekYxE5IlDGZ+SaIJrNT0oqLL1wQPFrRh
	PWUL7hKEfXhsfHa8Y5A4hvUupcrNXqVyRnKVtbHuwmZYL7IY1fNdOFliNZtqxf5yMmwR6m3ZU8U
	DjtNJZw==
X-Google-Smtp-Source: AGHT+IHe1agMqsMATLFIo2OsHql0jl2X0vTCAH83A2XiKg/x3LK3+VtXRJBuf2uvfomEwPmpZr6WfAQkwEAE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:e04:b0:dc7:68b5:4f3d with SMTP id
 df4-20020a0569020e0400b00dc768b54f3dmr250371ybb.11.1710395479705; Wed, 13 Mar
 2024 22:51:19 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:40 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 01/12] perf jevents: Allow multiple metricgroups.json files
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow multiple metricgroups.json files by handling any file ending
with metricgroups.json as a metricgroups file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index fc704a96ba0b..f68b0a60cdef 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -608,7 +608,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  if item.name == 'metricgroups.json':
+  if item.name.endswith('metricgroups.json'):
     metricgroup_descriptions = json.load(open(item.path))
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
@@ -658,7 +658,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
+  if not item.is_file() or not item.name.endswith('.json') or item.name.endswith('metricgroups.json'):
     return
 
   add_events_table_entries(item, get_topic(item.name))
-- 
2.44.0.278.ge034bb2e1d-goog

