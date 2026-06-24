Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C24188596
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278146; cv=none; b=JnuZnGID9LnNvPHDnvaokdM8BRxpyUu9tBPCLz/MT8Mfef+6UG3grJ8SHmgf7CV/p5bvr2fXr15DPu29RwfKeIGd/npAwHPxral/IHHXU6egsA482NkT9cqZVcZMtG3VrsKxWT15lOwPgGcP04/Aq13y6T2OWatUkdnq/VfsyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278146; c=relaxed/simple;
	bh=5IR3Y7yxwYU2NdldzOBlpO60YnfYPkrVOuYWDq5rgVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ApypvSkBrRToRd57iwMzrg4QP19scSK5872Bazqk5pG7UEUHoB1otoEvNMlonfr5gsIt0l4iys5nusVgGu3bztSKxOX2yMdbWhpQAv51XGkWRF7j5QseiX7CGCKf7T8z1xoxBKoYC4XFI6Ke0gqJIpWxIPhtGhOftkciyU1sfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2rFczlB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2rFczlB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139b74d67e0so2473722c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278144; x=1782882944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bIL+Tp6zKMWwaF87s5eZEL1dndgClmwDblOjZVw/Mi4=;
        b=Y2rFczlBwwjqsnjXbLo3BYSrz5JjbUkEiCH3OuX+pR4kogmMspnClcMymsQmaeT6h0
         mBh+QQO7/ACcXPwCQzyzvCzl85pL7gpm4/nQ0FOd9d0oe8sSILEsY0RSxgwZtDvzOFgD
         GQWv2oZSi8XVei8usjHEL+YUVKR1qo2g4ITtceg5qHwNMbR2iQNTqavpg1dlGxJUD8Ro
         HfNRqxRjCk3Xg0lAXeqI2rNf2iziGBnYzvAKzttf39y8v+fit+NfrPeo5YGakqSv+7qf
         TixNCLm9/cRDn7We3EdqeKq8zrcnvJIgbmoxvJmkFiRwPfBIgYM3DT5bLXifY3i/UaLp
         wDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278144; x=1782882944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIL+Tp6zKMWwaF87s5eZEL1dndgClmwDblOjZVw/Mi4=;
        b=ltHXq4dGHXzAfR36hU4K22n+GtMJGbkGurexP5BLXj7wPr27SqPFtU4XGN5EojromQ
         f8Zueyw7qLUD7ejuj6wKXBFJuDvu0jloZBg/E0U7/gUIg1xi8p8bGq8JIeu9V9CQSc5u
         sLrjWMPmuh3b7fTyQbVclucknT1n2Xbc6E+XIzoP+B7Ck1FSsBaXr2/0/eJ3svL0eHAO
         5emutF3O/RWRXmgM29q5jU9LFfRE50PuLOPZL8klUNc9FeoPoH+HdVfJwWQyM8AkvAL6
         +Rxqlh2YSoM2b+cO1oDbI5QC0g76NGhnA5sERKOY9z3LWdDxdSCdKEQ1O1wpkgucAopV
         UVfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iuv0nctoTPhTcjpN7G57aKi9XFJQq+a49CtqV0mmscME/9HsG5ryId+e4JpyRuSm9XcAhS5gaenyhUzK3DhDu@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGveXIlT4G0Auer0+na0omWXxSDc/O8y4L2OWuh6fiGoMKq2g
	CrXNKDZGIpYeijI/QvyfaGkh1fjNSxTr89uLzjdFaKvk99P2zi6uM6ojBCdObBWeMp8D4vhN3FC
	5ZzLvnp4bTw==
X-Received: from dlec20-n1.prod.google.com ([2002:a05:701b:4294:10b0:139:d29f:3560])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e995:b0:137:9ab:2cb8
 with SMTP id a92af1059eb24-139ad6ff181mr11869364c88.21.1782278143899; Tue, 23
 Jun 2026 22:15:43 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:19 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-3-irogers@google.com>
Subject: [PATCH v2 02/16] perf stat: Fix evsel_list leak in cmd_stat
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in cmd_stat() where evsel_list is leaked if an error
occurs while opening the output file.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 361c99a661a7 ("perf evsel: Introduce perf_evlist")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3f897b2e8638..7cb6ea937e87 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2718,7 +2718,8 @@ int cmd_stat(int argc, const char **argv)
 		output = fopen(output_name, mode);
 		if (!output) {
 			perror("failed to create output file");
-			return -1;
+			status = -1;
+			goto out;
 		}
 		if (!stat_config.json_output) {
 			clock_gettime(CLOCK_REALTIME, &tm);
@@ -2729,7 +2730,8 @@ int cmd_stat(int argc, const char **argv)
 		output = fdopen(output_fd, mode);
 		if (!output) {
 			perror("Failed opening logfd");
-			return -errno;
+			status = -errno;
+			goto out;
 		}
 	}
 
@@ -2738,7 +2740,8 @@ int cmd_stat(int argc, const char **argv)
 		parse_options_usage(stat_usage, stat_options, "o", 1);
 		parse_options_usage(NULL, stat_options, "log-fd", 0);
 		parse_options_usage(NULL, stat_options, "interval-clear", 0);
-		return -1;
+		status = -1;
+		goto out;
 	}
 
 	stat_config.output = output;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

