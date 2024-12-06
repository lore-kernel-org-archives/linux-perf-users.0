Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E27F20629E;
	Fri,  6 Dec 2024 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518141; cv=none; b=iZIQ0iDZG5WSnUGwja8TCGjd7Ek8Y0kEvBjG5Vw4G92xClL0EKFtRzpEp/8AlLFO1vO6gDAkbUxyUB/5Oej/VsT9K70gfj7SBwZPsw0cyL1ApYEhqG2s3gv3MITVoit858psLWAodBL2BK35H4YuEoyTqB6R8IXHU6iqSnlOxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518141; c=relaxed/simple;
	bh=qs5MTe5EbBWsH8cCkewwpdPdfFM9D7tPgyDJ5fd16FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSZl3Cpd6KefxIddtB2yUaxfuHcfnfVihqnr/rTGFj6x6nu2eA4GfwxWokhjwHAXe1VQoJBqhFkM4BolLbArLkj7zBGOZ2V4i5bC6/Km8gittI65Wnm9o9UxSoTcV9FftKw5uCDncgWu4epOqkod2H4enbee0Y3bqGvpFzcbOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdwILxht; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdwILxht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DBCC4CED2;
	Fri,  6 Dec 2024 20:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733518141;
	bh=qs5MTe5EbBWsH8cCkewwpdPdfFM9D7tPgyDJ5fd16FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZdwILxhtQSQLdOAdRvrpVk/Y1qsXnDk7PEHahUUqrvg9RM3TwRtJ4Dn4FnThvoLmX
	 GNhPIIJRqLs7wdKd/yDuc6BIux3Fx/nxk8FVPoyUZEhiEeDsX4SncR/8t7977xm6le
	 V09dTrHRVlSrMwjZfdfmVn5jOWgSrd/78CoZYZOiCeNob5j1OOkjhTho1AbHCDD7Kn
	 U3yUK/tknceRyE5RoetcsCMaljf+jAyDeYvr80m7PrgcG1eMicJxqFssfBS6NAvYBh
	 N2IECJfyFZHmjc7/e5NZ+EOsoWs78k4a4jY3sRiBY94LCbO5PxD+gvhAxdiD9XPWOn
	 hm3GIGPUuobfg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephane Eranian <eranian@google.com>,
	Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Cc: Francesco Nigro <fnigro@redhat.com>,
	Ilan Green <igreen@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
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
Subject: [PATCH 5/5] perf namespaces: Fixup the nsinfo__in_pidns() return type, its bool
Date: Fri,  6 Dec 2024 17:48:28 -0300
Message-ID: <20241206204828.507527-6-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206204828.507527-1-acme@kernel.org>
References: <20241206204828.507527-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When adding support for refconunt checking a cut'n'paste made this
function, that is just an accessor to a bool member of 'struct nsinfo',
return a pid_t, when that member is a boolean, fix it.

Fixes: bcaf0a97858de7ab ("perf namespaces: Add functions to access nsinfo")
Reported-by: Francesco Nigro <fnigro@redhat.com>
Reported-by: Ilan Green <igreen@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/namespaces.c | 2 +-
 tools/perf/util/namespaces.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 36047184d76e2f80..68f5de2d79c72c2c 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -266,7 +266,7 @@ pid_t nsinfo__pid(const struct nsinfo  *nsi)
 	return RC_CHK_ACCESS(nsi)->pid;
 }
 
-pid_t nsinfo__in_pidns(const struct nsinfo  *nsi)
+bool nsinfo__in_pidns(const struct nsinfo *nsi)
 {
 	return RC_CHK_ACCESS(nsi)->in_pidns;
 }
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index e014becb9cd8eb3a..e95c79b80e27c8fc 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -58,7 +58,7 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi);
 pid_t nsinfo__tgid(const struct nsinfo  *nsi);
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
 pid_t nsinfo__pid(const struct nsinfo  *nsi);
-pid_t nsinfo__in_pidns(const struct nsinfo  *nsi);
+bool nsinfo__in_pidns(const struct nsinfo  *nsi);
 void nsinfo__set_in_pidns(struct nsinfo *nsi);
 
 void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
-- 
2.47.0

