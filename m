Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D93AAF71
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259711; cv=none; b=W8jN0T7RzH7Lw3zuTTMld+sZVgvNorheOgj0OkDjcw1uDbYYIMtn8qV3Rq0oXJ0NgUduD+TwX+8Zw7dRJ3uuKoU3DL/WBNJmyBbQfXQ0wVz77D8gUmaMHMpDxkMIx/Qs3cjfe6tw266ay94lm50g10KqvHs3NZFdYh9qNDaW22Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259711; c=relaxed/simple;
	bh=EkELwjuoEifgq4yoiaYV05o2puOmeFtCBPEzq98DDQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UPY/L15u/Eo0lhKQEUPJaWnc6O075qpeH18lYU633PHcDcR3O+w8TCZlXp50At0ddfeulrguMMrtbT6e76F83jjISdwGjq2EHx+J52wXll8lTMr10CCdpDo42OKsrdp63dGjuJO5rCwatquVzfsjxnes5VO92eO1gcZg3H83rY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tvyh45Lh; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tvyh45Lh"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso1608968a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259708; x=1786864508; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0IYRX3k7fgU84M+1N/2f6gf9z+pbW3gfbOLrfXfOEg=;
        b=Tvyh45LhrgkR9nhkSrn+mMopYKiSCwmgUo6IOs+6/Gd+8SMwQCCpRHT8aeVwBMoluR
         LVsvY+A6az2XhaHEu519kig3oLucmG8PYON+JI0nte9ZhuAn2yS5eFsQEUIbOrU0eaLT
         S44y5+RvP3TzIvCQUM4kXZWTPXbtsbr3EM2rulG8GuW3p6+jpYB1vCH/E2LeCMgxdqh+
         acyb2DztugmTX/8tc6s1cqMPHxfXd67PHPfDl7W6a4pZ1KzI3qIZxf1A6b8yl6hGU4dT
         +8QiqMOoZc/qFyoi+ku8yybhdc4s5wgwtWI7jlJjrNUc1ImC1TdH7haYR2R+UZAfTPeq
         Efwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259708; x=1786864508;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0IYRX3k7fgU84M+1N/2f6gf9z+pbW3gfbOLrfXfOEg=;
        b=by2o7+oC2kHuxnVj8iBsUK98LwFEs99zDM5l9uTIPN1GwxRY7gbiNVciIORsybGozU
         ESMMAi5iy3FPiOXmr6mnWjPlMD10SLJbxDOlKJ47SFZGCA8tAIpYHv+lx3HnWE0bQWnq
         HNYTlNIsrHxDZYU0c0xV7BObJx0gcDen/Reo/TQVmVprXo4W3PFyypdClcYNtFdCMus8
         tZrtQMqKqzaINPpxN45jefrkCYUcbgMWQMz8hep77QDuKEREQi0MJmXu7Yn11orq31OQ
         DBotu/Y4h884/TktEUj0xZgo+g2U4L3LlxLYSqW31mu7+AKzAQzNjtSDMirhiPgJzITm
         NERg==
X-Forwarded-Encrypted: i=1; AHgh+RrtjRPH3jlWmKGRS91rcvK06f0frhnfu6eNjfEdCzbiwVVJvNAhBO2k5HPoOKy4DiZ9KUDNWt9WdNXJHL7CeezW@vger.kernel.org
X-Gm-Message-State: AOJu0YyfE7U4YNlvVli20sRbgw2BiDJuIqAlyXHPmlfywBo2A9QqJNkC
	YLMfOvVSfpxk/iw/Dp9tx+K3dKxINV7e39UCb5UoUwpLV6jbq0qjR4Vjb69wP75pp+f9bmRX2aP
	2RRZu3V0MhQ==
X-Received: from dldyr9-n2.prod.google.com ([2002:a05:701b:4509:20b0:13c:bfe9:dc09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f43:b0:37c:6130:7a5b
 with SMTP id 98e67ed59e1d1-3903c54302bmr35912690a91.8.1786259708257; Sun, 09
 Aug 2026 00:15:08 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:42 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-4-irogers@google.com>
Subject: [PATCH v3 03/15] perf tools: Fix sb_evlist leaks in top and record
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in cmd_top() where top.sb_evlist was not freed if
evlist__add_bpf_sb_event() fails. Note that evlist__start_sb_thread() and
evlist__stop_sb_thread() take ownership of the evlist and free it, so
we must only free it if we fail before starting the thread. Also set
top.sb_evlist to NULL to prevent use-after-free bugs.

Apply the same fix to builtin-record.c to avoid leaking rec->sb_evlist
and calling pthread_join on uninitialized threads in the error path.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: b38d85ef49cf ("perf bpf: Decouple creating the evlist from adding the SB event")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 2 ++
 tools/perf/builtin-top.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f58d7e3c7879..a57987851cf0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2258,6 +2258,8 @@ static int record__setup_sb_evlist(struct record *rec)
 
 		if (evlist__add_bpf_sb_event(rec->sb_evlist, perf_session__env(rec->session))) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			evlist__put(rec->sb_evlist);
+			rec->sb_evlist = NULL;
 			return -1;
 		}
 	}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5933c46ee137..570410599f1b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1881,6 +1881,8 @@ int cmd_top(int argc, const char **argv)
 		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			status = -EINVAL;
+			evlist__put(top.sb_evlist);
+			top.sb_evlist = NULL;
 			goto out_put_evlist;
 		}
 	}
-- 
2.55.0.679.g6767b8d81c-goog

