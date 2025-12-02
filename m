Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB52D0C9C
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697871; cv=none; b=V21EANRNyGfRRwmJUk+7RMK3WQIgeiH18fx7klxnZS1APt2ZUhP6CSIGalHo7EPv286FadiNtIRfsQ6+V4BvZHm9P1cylrBjc2HtV1F5AOUisU9bxTUmtIg++qmQXZgKjTweoRyEzSBSpf/Beg/gNMmsIhBfHE8EfBD5S/tffO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697871; c=relaxed/simple;
	bh=TEv1/HAzSLHeBA3NWyF7DX5ZlJzYioSuwudoqiQdkGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TMqSrGlWa1efhkKaoLbMNypIdgJq/d4FLD93T4ZX+ACZCgYu5SP+v7RoZg+Hy9rnnNuLF96mkgRk47Atw5v6ufQiboLcD7BM+c/0nVE0vqOVFvJpkgUZvaHRwhlr6ueBjtSwbgQ/DsgmXiuyYSDUj3VYWOnHB380dIgtTo4dEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3oPlgIT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3oPlgIT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2956cdcdc17so54830445ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697869; x=1765302669; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NH2u4VUQ3fj61HenZr1UXZRG+xsck/DPqaTtHXUTkxo=;
        b=m3oPlgIT2RWA1EQ8RnEnd17DyFOMuQs7dS/QnQj8cLqVvI5157uh1J/0j/xTfwJxf8
         7YvLHnavT4PZsLZLdGgS8CuEaS1fKtf66iDNs2klVy8x0ZGjbKq7uvyf2Ly3B6N0H6Vp
         5z7yhPC78FFkCYFajhE459evNCwuBMcDSDfQghiCBjNC7ftoAF4egTVfrvTr5BoWmdwi
         vXZzbBk5fC9/2TYiZtPQQUHvUmxGSUoRflre91E/PO64JOTnJSCi7qqA7PDFMSAtU4Aq
         ZTpXN4xWqpGK//ToDIAUe5tge9FXQdy5qZ/qctbVk6ILSGIYkML7Pbwyy39X8F+n+Xug
         FbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697869; x=1765302669;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NH2u4VUQ3fj61HenZr1UXZRG+xsck/DPqaTtHXUTkxo=;
        b=Qa/EXyBu4rRyeL48Ypo6x0VPP25cmVblY+KGEpzyDHYWapOU63kSjtPsYv4RfXTbDy
         rnLlFNhYU4PwLJtKDv7g6d9gD+Uo/gxGZpN8qybsakZ4q9m8HwftsxLSYkUwCFkZ8sl3
         YKmbDenR0AsbHGLhYDclaGJ+4bAp6zCLwDtBckoz4fZ7dJgYkVs76Rw3H8du6hhioi83
         l9gZheHm0O8WZWhY5drgv/wURvwwlsIRvUxW/NS3gp2muCm3TxIbl2J1Yg4KHoupa6rZ
         pst1NGGnTez52Zk+qKwW5eJURUbRI4FyDsm0NeFSvHafDwtSIDx5i8ZUAJdEDG6g2fa+
         rsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXac2Fkxwm+vkLSeHvloHJvskcQYiawJjq7eIb9k7g9I7J432GwZn9PPsX0Xm4KQqdE7AF8WSOk0K21kFCjfSsW@vger.kernel.org
X-Gm-Message-State: AOJu0YyGeD8N2wF+cv03bU2LuF2Ha2wk3vZidU9PrE02rSG3sRoJlo6h
	bmRJzMqlcc9bHlspH59GQQp0CotJff65dXeiG7LpySx+Pu6Bn4GLHAdBXkIpe0u39cZ3hvGNCvm
	i3iC63h7lSw==
X-Google-Smtp-Source: AGHT+IFlGTmkGGNi+SC78cD9hWU6PN0Yrfo0gXOZw0nJvl3+hn9RGHqM3/7qCGozUF6udTtmu99BfqGzB1gx
X-Received: from dlag16.prod.google.com ([2002:a05:701b:2510:b0:11b:998d:bdf4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e03:b0:11b:e21e:5653
 with SMTP id a92af1059eb24-11defca66c3mr132520c88.19.1764697869345; Tue, 02
 Dec 2025 09:51:09 -0800 (PST)
Date: Tue,  2 Dec 2025 09:49:58 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-4-irogers@google.com>
Subject: [PATCH v9 03/48] perf jevents: Allow multiple metricgroups.json files
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow multiple metricgroups.json files by handling any file ending
with metricgroups.json as a metricgroups file.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 3413ee5d0227..03f5ad262eb5 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -640,7 +640,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  if item.name == 'metricgroups.json':
+  if item.name.endswith('metricgroups.json'):
     metricgroup_descriptions = json.load(open(item.path))
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
@@ -693,7 +693,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
+  if not item.is_file() or not item.name.endswith('.json') or item.name.endswith('metricgroups.json'):
     return
 
   add_events_table_entries(item, get_topic(item.name))
-- 
2.52.0.158.g65b55ccf14-goog

