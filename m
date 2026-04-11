Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4032D7F0
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890672; cv=none; b=ChJlxnGFbUtjH9jZYb/kL1b9XYZz7u2oc+cDy68c27TACpwZ0872a3YRZIeOtNlcgwj9a9R9vLa23uYrg84iAYW/qNug0SpLqC+xPVyJL+Q/sJQ2u6fOWvT1G3VYTYj2fm7rNw2elGMvlKQVOnB2vdWgo5tIbuAiH2WTVFN4AfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890672; c=relaxed/simple;
	bh=cLWE7bs+0Cxg9cEMpw2DCvBK22szFSANqxVQJFFr1kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CmwV0yeY/0vA/kpqRmA/Dpquhn29NaleJ37h0BS9P2JTu5i8C/OiF6Qpy6jipxyDLld6XaQpppjUi+G6QZzCmqxIAYN/kpWfX1xqM6B3jAbVqywe1lm+9+1GJOS1xMwHx4INPzfWJz5soOnM70Lspaov0G0Ri3/JzZvY5gwexHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=seEXRj8z; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seEXRj8z"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so1822319eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890670; x=1776495470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=seEXRj8zKsJL4YzPEef/kpgcOuArp7Rz5LQKhX0UNUIe6LKScqdkZxBE+/1A9j+DHR
         R6YiQ0OBt9Oe+aOEeo80kLPR0hWlidpUEz/7LDdsYExS6cEPgqHawJGviRrxhxUOPk+w
         sy2gbK2C37h38giKCwxmg8wip5fMzImo/BYnYB6LNdFNyVpQPexCHIeJOoGomc2fohgw
         dtN6rm81btwH40psL1NQ2pKhGBNEul2Hy5Xw4WbD1fKNIugElwwcWT4IJpQP/5SZj71/
         lERio6IZ/KiIKCFl5iYve0GQGpGJAmCa365/iDP6C+QAyyfCKbWI6BnxK1sDX8F+Qw/T
         fY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890670; x=1776495470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=sZLjhbdJ/k97lRw5HvloDdgYLL2PS9nC3OdvfsXLKRyRAtA7FhPM9pm3QofLRgD6i6
         DB0O9rxDCHw4rOrNPrIWapEL2NTSRcPvs04GzpYakwmkLcTEzNXz3OwWfXQdzSybjQVh
         mp3AG/AS0g9PdLzLIjLylUbYOkHzAxQWycFZl1LTvnPlYuulyv3fRm7lp5Sl0tA4DzfV
         faJ5qMTI/6SUyqj8Cyyemib69a4AplAGnRev+l3t3MIzLRTxuIFZMrnu0BNsGUAKomtT
         uZA7q84+amRtmMAXN2n4RKYrNLdbGS6hG7mrqT+S6xmxnBm7pwmROR/5faOG+Lt8XBn2
         D7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVq75Xfso83FSc472gQO6yieySaj081FHCKRgZiQdKaf/JSOr4R6JmcG/1HV6WNZgPrBq8RE0Yfzujb7L/a1wFJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmwABiCinzX9PrgVD7z/uT+SERO5bgQyGLvWGJl8VopY5ySdn
	YcAx/7JDQ+A4XfZzcxYbDFn+guFrMFbMLi1yAPgEPYpm14jt0kvDdVROu1EQdXmDd1x1dSi0SHQ
	TxmHKF4VDHA==
X-Received: from dycnr20-n2.prod.google.com ([2002:a05:7300:e9d4:20b0:2c8:77e2:a364])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1925:b0:2c4:d01f:6ef7
 with SMTP id 5a478bee46e88-2d5883a3a2dmr3995598eec.13.1775890669322; Fri, 10
 Apr 2026 23:57:49 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:01 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-13-irogers@google.com>
Subject: [PATCH v8 12/29] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ff7117c5470f..3deb21f4d781 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -788,9 +788,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 				    struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 
-	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
 		u32 count = event->lost_samples.lost;
-- 
2.53.0.1213.gd9a14994de-goog

