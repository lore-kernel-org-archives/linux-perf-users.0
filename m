Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DB17A5BE
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088644; cv=none; b=VYffq6f+ZN8LOE1Q5Opp1wLEzpRL+78GIJGDcXjqBvH7kOrcHMYEa3rrMM3Esrv0bz0W40S/eao282seO7X9vExVXv9v1dHZXc7812+Yb80eiH6K3BhwBaL5LKwHJDpW9GvgQP862fRTxdwGjC95BCcYIrlnSIc/oOjyv/2zgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088644; c=relaxed/simple;
	bh=JR2W9BY58B7KI+DPucllOVM9yijzERRopT+DlqMeLCU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uLKc46/bRYBptTET7D84z/jGT36cNRRbwnnSn5Nj9SJTQKcS/0rMBCJDjlOrvfDHVRoOQ+70uP4xKnqcXTzZoSQMnhnLSagMKsgbiSh9FvMzJYzXQ4DbI3ds3PbSypzaAxRkUdy61m2RkXL+YpaDgtL4Hl36RacRjoatc++v0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryfLI8ax; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryfLI8ax"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71ec3392c25so2520649b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731088642; x=1731693442; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=ryfLI8axXIYC/kyAyTsQGObpmCYm7iRdyqn1eQE6qNvulvt3MD13ugEqQK8Y+H4pvy
         I8MYycReZgyymSytLmEQStUU6huVcoXzeoGzcEyBQy+thNr1kvlX3Tic8Iazc0BWGHZO
         pDbMIoWSAC5ntRuBrLAGhxikq5PcxRkY67DDpKRr1X/GC69a/pLXoHsj4wz/R3G90xC4
         13U8Zj+HAVMzEoUaXA++d3KVXkdJMB49PpJBosHJzHWsOnYJev1Nj/EfVROD5wI5t79G
         5ueQyJJShIdJc82GyU91+iu0pXuAiKG5GcmjL8x3M33jDfIJKPadyuTTkNHHF+Dl2NdT
         Coww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088642; x=1731693442;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SPWlc2lPTGFJEvFedKLB5LrjZb1UnFHbKvI0m+mSBo=;
        b=VSGIexAj5+/kYIxyHyDoAdL3n0tKxzKLu1J0SZEZCdlsHybkD4yCaTFVBbofeh+Cow
         RpSPIFvcFH7Nbs7wImc6KXyIiK3yydyATy3/hbSCQ514bOYZQdIgFXPia6ZmJOBbbrpU
         g4i6pbuT7je8lsfNICieC1yVrdC0e+0+FjiqRl8tRAVGOxOuiJAOq81ab6LxEgASNoee
         +A3gGdezH8E7+78xxOCD4Lgh8KJv9X9nIMZwNuCsX9wtUHffL3DeF1WQn51YPRcL632s
         XGnzBFl3XIPNTQ2ia4mg760SXDLLt43GQUZoPX8fw5TULQvQpwYoLI2Cg1k9FAP+y2gN
         PCnw==
X-Forwarded-Encrypted: i=1; AJvYcCUfoB+E+Ss92gQ7SPTcJehR/yM3xCseRB52KqNPGXOJ8/46d9sUQ1jDG0QIlQ2bmIzq8wRMSYf1QfiqSnkClAf2@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMB17+v6qNc1WQQ+tmiGvkSN9eR3Pc1U92TnFa1FpYTTeag8z
	qUuMj13ONspar3U/m2fxDgmVBfHI2OO4jIdk1CkclvgbgL5R+GdMGsjQMTxg+eX4eFPe+iGSMjj
	U0ir2SQ==
X-Google-Smtp-Source: AGHT+IEAWTZOnwTQFoToY0xNhAjfb0Ia0T03EjU5HdYouUS56VsfaPEHa+Wy7A6wb8fWps+6s7hfhOFdAc5/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:d885:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e337f844041mr2415276.1.1731088188463; Fri, 08 Nov 2024 09:49:48
 -0800 (PST)
Date: Fri,  8 Nov 2024 09:49:30 -0800
In-Reply-To: <20241108174936.262704-1-irogers@google.com>
Message-Id: <20241108174936.262704-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108174936.262704-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v7 1/7] tools api io: Ensure line_len_out is always initialized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure initialization to avoid compiler warnings about potential use
of uninitialized variables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index d3eb04d1bc89..1731996b2c32 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -189,6 +189,7 @@ static inline ssize_t io__getdelim(struct io *io, char **line_out, size_t *line_
 err_out:
 	free(line);
 	*line_out = NULL;
+	*line_len_out = 0;
 	return -ENOMEM;
 }
 
-- 
2.47.0.277.g8800431eea-goog

