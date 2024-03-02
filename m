Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36597D516
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Mar 2024 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341202; cv=none; b=uF66GmJbNQciz5XdhrtWZjlfGJM58nMKDgNbtZUPCM+Bidmrv0HUQJ8z9n3aqbFs65908WA4ClVwwOBe2wkMVnxyZwdLGSJgHFb44B5y2VxbqMyJc/fKgOBmybpGIWIyWgQAgseLdejQgzxTzrpOKQHtsUMwokyrKt1fTDPZa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341202; c=relaxed/simple;
	bh=Q8r8JCAtkGCJmmXhKhiAJOofwbQwry+nv4WJ1Szla+w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dMF8cbRcK0eSrU2WONffOniBfUV+hRUI++iOAzpypo98M7YIDz8oPvUQLG6Zfz63Fog/x+1tFyubQKW1AvWmweK07uvwznC/7IXpCSbxN8QHbGJgeXID1B+Fy5lQiZZOIWz8f2RavTnw0XsCrezWxGMj1g++G8/Sn1kLnMiXB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+k4w4qd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+k4w4qd"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dcb30afc63so30702325ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 17:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341200; x=1709946000; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZPkGRhHwcNWwVteqhq4++b4hJ8f8BvedCtUPDM725Y=;
        b=D+k4w4qdK0KSO0PU3Qk5EpR+BUWjjWv9Mp//dUGjJaHhPwGc0wgLKoreWgWeXIicBu
         3MrEVzhmztJ9sy6Y+IxVsyZ3psvuWbZaEtlnBplOLC1fk0zEDT0XXOfOUfvcapNSvTyG
         bV2MSLnNWTWZEcTsv2Pz2+GxaG1bW64w0UtPufc4LoIWOMUJLhKtUFWVwwI6Qd90Fvy6
         TEghm/bIgRq8byQtxtlPwW1hpCs9FWC7uh3K2dMV528Zf3kUyqd9dD7FVSgEE/ZzcM6V
         ZiZCfzHq60PClDcodmT4JM6QMYwiniFxtI7+9i7MCZK2/zCUvgK0ntunllCCaXGry5tL
         GZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341200; x=1709946000;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZPkGRhHwcNWwVteqhq4++b4hJ8f8BvedCtUPDM725Y=;
        b=G6dNkMyvJV05W089dAylin7rHdAn8nJkR4PPyS+MUMCCqsFCLhYHuIBgynTBGr1Of3
         YUggqVIa0ZvFLr4xhXph7O2iR+ytG1CujCevIxgxxhcwCZQ6PUl6NDu0THxHKCX750YI
         WRLTEJMvM7mjhx1T/vJIyUQxCX5log5aKnNwRrUVAcwSWLKqyNHcWXJ0SuhnhMXeTKuG
         VgV5LMoau1kIwmQyaW5yS4TnsoBB/fZY6zbbTXvJ5W950XDNeE0ILVEhSdNSyTiRY+Oi
         gbMUaRVEkp5AfCUx9MNu1MB+/U6U5ubhJCFEWj9P3qeRw51qcuJANkXM/0V2rT0YTeSA
         gjXw==
X-Forwarded-Encrypted: i=1; AJvYcCWayO0f2Fe20q2RXWwMnEHnvMM6rmKYcjUYHKxcum83TID37u4fAPEysSE4EpBuv47NAbSY0s3ut1pjJhzzb3fmC0UGd6+aWhHx8sTLBIswTg==
X-Gm-Message-State: AOJu0YyF8HPkvHEJqYPBOalNlKq8dNPGhKcIemHlOwLVSKqF7992E+Zy
	wvvB7anmqzW7z5DjkAd/cB3nJ4PN16qjlAoLjKs3EmQssuFp1DZnDH4kKVPESj4Djo6QtYgqnaw
	cMqhUGA==
X-Google-Smtp-Source: AGHT+IEMQI04qGuYa4Zy58eJ8B0dl7EShvAo5QCBxfWARRYtox544qmVY1jy44EJRh7ccXwS5r6FTR47WEBw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a17:902:c40f:b0:1db:e9ed:bbb8 with SMTP id
 k15-20020a170902c40f00b001dbe9edbbb8mr143679plk.9.1709341200314; Fri, 01 Mar
 2024 17:00:00 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:39 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 01/12] perf jevents: Allow multiple metricgroups.json files
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
index 2c7e5d61ce92..65ab03ce5064 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -603,7 +603,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  if item.name == 'metricgroups.json':
+  if item.name.endswith('metricgroups.json'):
     metricgroup_descriptions = json.load(open(item.path))
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
@@ -653,7 +653,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
+  if not item.is_file() or not item.name.endswith('.json') or item.name.endswith('metricgroups.json'):
     return
 
   add_events_table_entries(item, get_topic(item.name))
-- 
2.44.0.278.ge034bb2e1d-goog

