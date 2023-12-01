Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Huz+6C2N"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F1719A6
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 15:50:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db49589f622so1415064276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Dec 2023 15:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474657; x=1702079457; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lUnGKwfnXUenrlTEoRlDOWCoPKyTMDM98VpoOLbg3Q=;
        b=Huz+6C2NqmiG/UkpuwkCmC6sEWSHrlhxShYluejTROtV6E81hDMcxG0bfuIdqR1q3x
         gImPvhktLUBrkbPoFkHQQMNMMkWg4bt3KMLBaD7SVSrxTynEfJG751Ycd/cfG5RLNTmc
         fkaPxZB4V9VbYLEeXiH50dILKf5lH2fgaM/Ke31q5qIXZpd3DJ9QHD+4GYlUUEYB48HY
         fxKcWVcfocnwLiXow21P6W2hAJZHPmQJ5CsIfIyziWMsV0Vttrqjgk+x9ftQvGB6ho65
         IoAjTMmjB2g37s6hXqt5w9WWvOZ9v8Nnn9k5QM87rzyjqXWC0DHbFAmxO+KR8h6q7efr
         SAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474657; x=1702079457;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lUnGKwfnXUenrlTEoRlDOWCoPKyTMDM98VpoOLbg3Q=;
        b=Cjh4IULsEqapZLDilJntX8yGeP3yxjh8L9c6sXhJ0IylGuNS1HIFXd39K1OCIb8Pxi
         GxMJvkZDIAMFFueEyqrIv9OAm7sr4QBvAvycBaqsRKRO87pKxsXmI+PGTDVxl3jxgv6N
         Cv+bXWXMcOiBHjC4PThgK5KdoxLR+UQ9kon3bCs0vW3CIXRipG4w1IMq89fHWz45doZj
         cyIBPLMlyGl90w8CQSym2bMMpfB/MZp/P6I7pE61Rlgt8D6SNti1kfx2QjayYaSqnShR
         dpyJF6A3tkuiJGPW+j1y0tE+AWxWKRAz2MvE8Z50EO0KwflC9QoLrEDLXX+tz/06CV2/
         WjLw==
X-Gm-Message-State: AOJu0YwbISH+y9GgvOR9AF7S4yQWMk6o9KOfA8qcVEfR1ME+N7NgQPI0
	IFa/S9slpKai1rwIsz9xtshSCiL2kLWV
X-Google-Smtp-Source: AGHT+IHhTfxjeqb/2Oow+1932o5xoEw597jdDkx3b5HoCXdGGldelKroIRhiDKbkrHbi1LEljtDajoEqDaAR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a25:74c9:0:b0:db5:3b4b:ad1e with SMTP id
 p192-20020a2574c9000000b00db53b4bad1emr240617ybc.10.1701474656852; Fri, 01
 Dec 2023 15:50:56 -0800 (PST)
Date: Fri,  1 Dec 2023 15:50:30 -0800
In-Reply-To: <20231201235031.475293-1-irogers@google.com>
Message-Id: <20231201235031.475293-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 8/9] perf srcline: Add missed addr2line closes
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
2.43.0.rc2.451.g8631bc7472-goog

