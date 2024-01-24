Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2A440A
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070621; cv=none; b=aX+ZxY8m2SOqS7kS30DXlHNO/7mub59SenMtQDul+qjHsdg0zdcDvhCrbzXniq41ZgUHWA0q3kemgaCAR4j0Uzzh9BdIwajDtY1xNoMtlLcLOvHQBTBq96YkSQc/eTh29svaJvZwUdGQwsFS9DcdGqOYz6Qv6xT+MxFYON6i9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070621; c=relaxed/simple;
	bh=kZckxd2Y2SmFxfYlXLIg5gka+elYmXwAwi4rkByho4w=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=PtJG02qP7dmlrMBouJshyh6oug6gF9ipq3nEpp60DSrz+7Zbo7xCnsbIJnhw6VqURoKOo7uDZyadWTlc/wLAckX9JCnZTrxAvMBorlDe+6tJSB66E/TR/Y7Xx8fUdWzx3kEYDdyg4Fouqfb6X5xzk1PQxBW7Hl5CcEc6eo57gug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWRLfZ5A; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWRLfZ5A"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eb6dba1796so79722417b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 20:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706070619; x=1706675419; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sx6gx3pXvR8/WWqfzfORTEMxkJMYhHXX7CfsT6ClFYU=;
        b=qWRLfZ5AjEWVsMKH7nor23szXKQg0AwBt52rIbuLI9r+8jcLRToqm76LAp1FAI41Xv
         J0zsWFksQRsFIM42+71V45m3dU/ogA6tmbbm/6ZnDVusm/o2SGcT3LtsSQqTM0/epOuG
         ZRexA0eunp2tQXWmxWpVcQreXvGSJJe7apq+pAU8cm6uNbY2KVFLhOBgng/yaPzwbMJN
         lHrHYszFa8lMCimwx2nyxMyzn4acoQWHvXp6BsFDS66Up0tx7YdPtH2jBE/hgxWEpwaW
         MTENQS+LLhIp2FMGTS319E0+fFC01n7fn57p0Py1NHcP16/pRDBqAQIjiw1A9bfnWo8P
         7dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706070619; x=1706675419;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sx6gx3pXvR8/WWqfzfORTEMxkJMYhHXX7CfsT6ClFYU=;
        b=cakZXTuxYGiV6W9uZM1PrYlSvsnUM6F1JnCXjUpzb0K51jqQUC6zT5bYMkY/QbohM3
         +ouUabFJFmnT5AujuIB6pUWN/49zHlJtU8ApOVVHawHLEa4Bc8NYI2IAwCkjMKAN1tyr
         1m+3PKxBdTyZaECGSQj05AsnqeT7Mx1qtLmLRqB5Xay/z9SNo9iZSUcc1cu/LaX1QMFu
         rebNpd+/TgIbzf2UbCfAVXojqW53upJ751KLvYSVo1nePHo8Rd92Q6h3S9sgXWVZ25L6
         UAdsMeOk4D8cBAN7KWeFiHgBTB1ph2zSn9t7QSo8wAkfEY5oKepwPZ8KTtoSm1GvC/nX
         QiYQ==
X-Gm-Message-State: AOJu0Yw6G9nDIrBC9IOFp7oDrYa+DjN3vBWMz7TOkY2suk4ATYmNMkbt
	wgvnFSsEHKgjdk7txKFUV2pMixvcfs3XKaArWmncioXCybLrupmuCCI3OnySIGFv1srAGFz4muk
	DG2Rimw==
X-Google-Smtp-Source: AGHT+IEIWuPYM79jBl7bn8VuT+ZBrK7h/m8zExOWK5gv4yLjDd00DRamQ23w7paSUMORtgPYYjwhhqA+T6TE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a81:994e:0:b0:5fb:7d88:a558 with SMTP id
 q75-20020a81994e000000b005fb7d88a558mr140250ywg.0.1706070618751; Tue, 23 Jan
 2024 20:30:18 -0800 (PST)
Date: Tue, 23 Jan 2024 20:30:10 -0800
Message-Id: <20240124043015.1388867-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 0/5] Fixes for 6.8 PR1
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Discovered some testing issues around perf list, perf script and perf
daemon based on Linux 6.8-rc1. Some of the issues were discovered in
the context of an Alderlake system.

v2 - address Namhyung's review comment and add his Acked-by.

Ian Rogers (5):
  perf list: Switch error message to pr_err
  perf list: Add output file option
  perf test: Workaround debug output in list test
  perf test: Fix script test for python being disabled
  perf test: Make daemon signal test less racy

 tools/perf/Documentation/perf-list.txt |   4 +
 tools/perf/builtin-list.c              | 211 +++++++++++++++----------
 tools/perf/tests/shell/daemon.sh       |  34 ++--
 tools/perf/tests/shell/list.sh         |  21 ++-
 tools/perf/tests/shell/script.sh       |   3 +-
 tools/perf/util/print-events.c         |   2 +-
 6 files changed, 177 insertions(+), 98 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog

