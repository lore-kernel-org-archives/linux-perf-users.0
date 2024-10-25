Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1D20F3FF
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876992; cv=none; b=PZXWf6qmcNvTimEn599vCWU9MpapGLQUIIv6uFiXpGkG5tGVoM/J8hdolg7lo4W60wbRUDPKonYxpXoFcwGYv5xuGEjYHaCo7rABxrE/dKeWP7afVOuoJ5HcA9rqRiD8GH7CRrEfQ64O84kLNhE7UHGdXhMEtJOucvJ9+73zRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876992; c=relaxed/simple;
	bh=4yySnYzLZn+T4Oh14Unm00EmZJ7xqCsYNG3mY4KLftw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uNI4esfjsf+leu3s1TcF1jrJre1Zr0V+wuZc3ybojTph8ulWogL9hs7+ypewbe/GOSun3GzqjuGEDhOgLRo3ePoVeh4xC0pqeLBV7ssiH/t7ZfTWVCkXA4rVoC8gEbquVAHtMROg03WDJnStg+b6LsyP2Cb65+XfTUMVyoklYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqy2/QMt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqy2/QMt"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30859e1580so326240276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729876989; x=1730481789; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfqlArFfChSnPcH7RDY8Nm7G762SilyEqA0ClwBRXCc=;
        b=fqy2/QMtOs4O48lAtMQBDydd1a7ZKtI5hj3IEG3IyNlxg2vDz27hIeg9Lr3FEpURau
         hqbaJLou/8lXwQnB6PLnfSkPRLwSWtpy+YaofuyaenezajhkLnjOc+6iZebpeV3nrIyA
         dY2Jci40gVwua4EvF7SH03sU/m21HZkk9MX+kq2gOuVMAqEU9eWsZcixPrWMiYcMgqCV
         cNP8uXO0bU7RbdEXmuf6LDIwQ4tJ4xSe3YqEjRT4Dx7DLrTWuuhje1vVfwdRHbriM8+P
         QQOJaG4tvP0wfyg9rcBYVCu/EP0ciDW+OeiEL9UanV614RxxOmh6d4vBaLu1Nkcvob84
         jtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876989; x=1730481789;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfqlArFfChSnPcH7RDY8Nm7G762SilyEqA0ClwBRXCc=;
        b=B+ecpakwjqi0krV3cDpInFvfKFWOPtC3mGvBErCkkaJef+A+seqJ4YCue7twwgHCUe
         k+SAN9ygXBe+Ut3qlQa8XCGd6GigiR+4w26fbztbD/Qg4ydU4nfyILxUUwz7E4MWkm3k
         54et48IK78BPWsZy1JaZs47qyNG8BwHzi5lt9seiR+FiTabMI0VVPf0/D0SnS1JJJB6j
         pwysHN0KwANN/tzLICyJo/6WKz7LjcDad3EhBGPqU6wfSv2dUJyCTMzOY7ZZX9qjW8/e
         vnwfveR7tvvMmrOlWtnVc8GpbpNJStV0K0/h2Yj4qdKbCDBnxkLHwU4wV0cRtmfyxacQ
         YJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6kPiCxfwyZMjBvjSHo3USBD89sl/JzdGNycvGzSj7f9e8AKCUp2/P5N4OvsxXoJ8SSpYDN/acd4rO4PfgNePL@vger.kernel.org
X-Gm-Message-State: AOJu0YzmfI640cLe8r07XGtcQm+R+y7z0QQTEHomZwazsvB20YzlgIJ1
	5RrmyhRisU5zobpIrKfG2klwVtUWnADWWkF7nOEfNIS52nJ60tw/+RqTH1QtWdJdbnLOB8ELctQ
	yrepJ2A==
X-Google-Smtp-Source: AGHT+IG0c8i0XzuFis0iYKAoQK1TYB3CJRJkBJ8l77PX7pZ8iakR5a/MycTRXZhjDL4y0M6goqFQhuWFXLTX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:6902:686:b0:e28:ef6f:3624 with SMTP id
 3f1490d57ef6-e3087b82cecmr97276.5.1729876989257; Fri, 25 Oct 2024 10:23:09
 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:22:58 -0700
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
Message-Id: <20241025172303.77538-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 1/6] tools/build: Don't pass test log files to linker
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Separate test log files from object files. Depend on test log output
but don't pass to the linker.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 5fb3fb3d97e0..ffe988867703 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -149,6 +149,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -159,7 +163,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 
-- 
2.47.0.163.g1226f6d8fa-goog

