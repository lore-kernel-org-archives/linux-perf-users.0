Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E137500971;
	Tue, 20 Jan 2026 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947088; cv=none; b=ChuoPoNcZgPLSGYIBIwHPgP5zuZi7jsVQwdb+Ra6yr63SG8+9Dh4rv/n2IwhTBfrxzMxd4RIDFwdMgbZryM881KrXshDCfW8JvaWmyUjpwDP62PRYnydWhJ68jsvmx/8q9Vy0k2VYU8Aw0Jj9g2Ic5Rw2tBUVrIbeL2ibOG92tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947088; c=relaxed/simple;
	bh=2pqEONvGIfXTlzH0fJxXCe1oZHZRHM1wULCH7ZJHrfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyZ4T+5NGeGbrrVOHawUPtZxTXGdhMU0873amAGP6Wh1mag0YT5bxsECmuzP8XXBtggoJEtVZaXLL19/Gyil4u8nNNBQeYIKIPJUGhJIxGHPJSZzu7gn+Rfimk4PhntlkBj2SmXW9uJUIPlwRmYO+e26l1YsMbZGhpYPyn59CdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpKRJfjr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpKRJfjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA38EC19422;
	Tue, 20 Jan 2026 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768947087;
	bh=2pqEONvGIfXTlzH0fJxXCe1oZHZRHM1wULCH7ZJHrfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GpKRJfjrztyiiEMNtWFZwKCkXeHx6alZpgqN4Zy4eQpCnBAi7Q6GPq6uVPOmmuTbp
	 hnQPx/jja8z0RV7fT2C4nD8M9tZbzA/t2zIPPg3s3RcMLCOZTaG/yecTHM60iPdTCr
	 FNktK80cPHVcSXq0yvxxfbUlu/xRjy7N4IffUsz4ZEZiEpX22fkpGZOrjtS6nMDQFN
	 6b/HVSEHp+ljqrj/6LMxhVWwopzS8+MvnMHV/mLqPB2cg7EZJOacteTo50M7Oh9EVF
	 zpMH36V8sUY89T1Ielm1UzMZgkjef6GjV4OTuZ8j/WxKFAB6EALaVLoWaKX381zZnW
	 fqVwVwfA0DVZA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/4] perf list: Signal changing const memory is ok
Date: Tue, 20 Jan 2026 19:09:00 -0300
Message-ID: <20260120220900.366451-5-acme@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120220900.366451-1-acme@kernel.org>
References: <20260120220900.366451-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In this case its a temp list that is created just for listing events and
will be deleted at the end, so just cast it to get rid of the compiler
warning.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/print-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 898cf426509790cd..57c06f6bca1fced6 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -86,7 +86,7 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 
 	strlist__for_each_entry(sdt_name, sdtlist) {
 		bool show_detail = false;
-		char *bid = strchr(sdt_name->s, '@');
+		char *bid = (char *)strchr(sdt_name->s, '@');
 		char *evt_name = NULL;
 
 		if (bid)
-- 
2.52.0

