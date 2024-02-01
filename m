Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901646ADB
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Feb 2024 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746540; cv=none; b=PVuoVJRExvoOSPX80cDnyKB0XMEdJST47ybeHgotjNa9veI6Gm40KXnQ02XeUt74Jqb322ZS0LOwPLRKmPxTfy5YRJE/sxY39+v2wPmUobgwPQsyJ/aCaPwBJrtiSHtoYzwo+Hah5VSQDuFKkzlBzMuuHoL552MWju6tPurMuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746540; c=relaxed/simple;
	bh=BgbevzhY5rXwE/cxiO5W7UDDeP39KQp1tv4kTf0nGCo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZgigcNZeijLi/IpzuktfFrbyaERk67M8XVcxfCwvptrhH7u2dYGA5mwkZZd3K3wapRNFYTm/q4uet/CzCk+QQd5NubBVeQVpx6yNlz0YPgRn40PkdZOulozeqQRcpgQxwqx8Wjk4jdpAlmD5SyKCIzqv4fqO8MDb4i4RYUiJ2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4UK/Ish; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4UK/Ish"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eba564eb3fso7183397b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 16:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706746537; x=1707351337; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjs9Prdq5u0ou9NuYNbnA11pYi3QUD5UfnclKxl1vhM=;
        b=l4UK/IshzIPonDImmOkfylXz83QurfCJ9ayFXyYzdYbolcbaDNC0dwFeSryJdbn/8e
         FaqVNZelNKeff4gNxtva8Ptb5+kDOGzadg3bd5iLdvzUzP+FQAb978pF1UI9/Q/sP9WL
         tiYstvYQZ7ZlY3RDobCqthx/sKUfhwtDYsS+KbCA6c9PPGDMQQ+ldB7ahbQfv6en8aJC
         Ee7iq9aF29+SwBke4zsGPir/noCXzGzwuihMmW+c6F7csAVa5tFlgTrMvZ4HHKlqUVsy
         kjw4eyDLbwPlpKaXwLFVGqExLuQ+G7CPrKypX05b/Gi9IUYHzomu5jfs9k6gyJ+ucUJg
         N1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746537; x=1707351337;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjs9Prdq5u0ou9NuYNbnA11pYi3QUD5UfnclKxl1vhM=;
        b=DfcCel7g9lHAiETL0aQEh9HXGbbnZYWEljznw3QpVBpTgOV7dLK4rB2Rei0WQI2A4c
         HLtXdchpQjSgaG2aqiUPQ1OfdtflEGBsu1oXIlpiCy/LueSBT8hCb1Qjr6Qg/vdFbKPe
         1Q/uSNvVxsusUnunBF6YwzK/1OSfl0+9zYnyEZM5b2Q9V6KgLa+siQhUVfy/17vbTW8S
         7xhQojThL2h25NxypnVi7rMPKUpXkP1L6Ze/nHyQwBY18vUmnBRfQBDyeaXTHNq+8gLf
         L2dUuVryKaRQNHk+M2e6iLdQ5O9CQxTUfMn6CIi5UrMLVjOQbQyZbQP91txJOoEz1Pzr
         VbAQ==
X-Gm-Message-State: AOJu0YwkidA34Z3/sHL3tSVxkbGvHRyAk3wIqa4Bky9662yhWW3a3vws
	Zt+gxsIrIHFs39VLQPA8ntKQYL2QiKoOJcz2ifp0Y0KGH/w/jFTvZkWGteECX5XA1CXp4TkV9Yr
	XB37JpQ==
X-Google-Smtp-Source: AGHT+IG9f55j5uLbOnosxQV9gtm60AVV6VLPCDRs6eZec5XZgYDiDclOGHQZ3LhLStMno2rqZyYBHJGAGdPv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a81:9b4d:0:b0:604:5ca:5ab2 with SMTP id
 s74-20020a819b4d000000b0060405ca5ab2mr727828ywg.9.1706746537532; Wed, 31 Jan
 2024 16:15:37 -0800 (PST)
Date: Wed, 31 Jan 2024 16:15:02 -0800
In-Reply-To: <20240201001504.1348511-1-irogers@google.com>
Message-Id: <20240201001504.1348511-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 8/9] perf srcline: Add missed addr2line closes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The child_process for addr2line sets in and out to -1 so that pipes
get created. It is the caller's responsibility to close the pipes,
finish_command doesn't do it. Add the missed closes.

Fixes: b3801e791231 ("perf srcline: Simplify addr2line subprocess")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 034b496df297..7addc34afcf5 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -399,6 +399,8 @@ static void addr2line_subprocess_cleanup(struct child_process *a2l)
 		kill(a2l->pid, SIGKILL);
 		finish_command(a2l); /* ignore result, we don't care */
 		a2l->pid = -1;
+		close(a2l->in);
+		close(a2l->out);
 	}
 
 	free(a2l);
-- 
2.43.0.429.g432eaa2c6b-goog

