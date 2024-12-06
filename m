Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFBD211487;
	Fri,  6 Dec 2024 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518132; cv=none; b=jXGcoXvrZS0CHsgX/HvxNLiQ/XnTsRhVXBXXQfQxYSlaqRtaKOr1vzvuN23XTyfQJCt4+rt3gYxd3tWuO6O2lvcVhzEKKe2TRgggU+4HpUNgxKmMlTzrxFVVOSVg6G4ubUYObGiF/DhtjT1ZpdmARk63X9LnxXcr7KS/GSUScUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518132; c=relaxed/simple;
	bh=exifNXsQ/uJc1E+u/IwQR1lR8U8//3ghSe2sXRyzbCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPUhdwb56dtLn+s5Px15Vxe82AbZWzaSBcvMjfV8U+eK2EAqmkNQP6raU8S4DZp2jlJNXkC+bOGUgjojn+1YBIT8/JvBQch/f5tUS2zZfWDmEXYXw222L8i0YG0Qt1nt5ZTpr/YFjgsHlqyl6r3dapFXROIjQTL8p7Nzl5Hrv3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baGD88jt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baGD88jt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A688C4CEDE;
	Fri,  6 Dec 2024 20:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733518131;
	bh=exifNXsQ/uJc1E+u/IwQR1lR8U8//3ghSe2sXRyzbCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baGD88jtngqtNOeUJpVaCIQz+jyCVAQrExI07iQLJAQh2zDJLwTKyhC2KPl/7+Y+O
	 0w9irv7HfnIJ8UoLviY8Tj19xzdB45/vVpQ06uX03z8rao4ZpRPtYxoMO+BxtwvoKX
	 xxxGl+slY8ISuj8eZjFSdvbW5CUvOZpGmbWWgy5xff7k6cFewIRqK1KTnxLMBINBO1
	 iggHzsFDQpbITfNaxC3vdAfd7/lw0hCDxSXVqJMHP3lZ8LiWePvsApdtOePaqfqinB
	 hlrRbbvcATwRXNvpP5sPqaIimVa1bQhOxgXMiYv416N4wv1EPSVjEKkhbr69mADQ0f
	 mPVKuo5H4MRzg==
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
Subject: [PATCH 3/5] perf namespaces: Introduce nsinfo__set_in_pidns()
Date: Fri,  6 Dec 2024 17:48:26 -0300
Message-ID: <20241206204828.507527-4-acme@kernel.org>
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

When we're processing a perf.data file we will, for every thread in that
file do a machine__findnew_thread(machine, pid, tid) that when that pid
is seen for the first time will create a 'struct thread' representing
it.

That in turn will call nsinfo__new() -> nsinfo__init() and there it will
assume we're running live, which is wrong and will need to be addressed
in a followup patch.

The nsinfo__new() assumes that if we can't access that thread it has
already finished and will ignore the -1 return from nsinfo__init(), just
taking notes to avoid trying to enter in that namespace, since it isn't
there anymore, a race.

When doing this from 'perf inject', tho, we can fill in parts of that
nsinfo from what we get from the PERF_RECORD_MMAP2 (pid, tid) and in the
jitdump file name, that has the form of jit-<PID>.dump.

So if the pid in the jitdump file name is not the one in the
PERF_RECORD_MMAP2, we can assume that its the pid of the process
_inside_ the namespace, and that perf was runing outside that namespace.

This will be done in the following patch.

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
 tools/perf/util/namespaces.c | 5 +++++
 tools/perf/util/namespaces.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index cb185c5659d6b323..36047184d76e2f80 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -271,6 +271,11 @@ pid_t nsinfo__in_pidns(const struct nsinfo  *nsi)
 	return RC_CHK_ACCESS(nsi)->in_pidns;
 }
 
+void nsinfo__set_in_pidns(struct nsinfo *nsi)
+{
+	RC_CHK_ACCESS(nsi)->in_pidns = true;
+}
+
 void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 8c0731c6cbb7ee01..e014becb9cd8eb3a 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -59,6 +59,7 @@ pid_t nsinfo__tgid(const struct nsinfo  *nsi);
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
 pid_t nsinfo__pid(const struct nsinfo  *nsi);
 pid_t nsinfo__in_pidns(const struct nsinfo  *nsi);
+void nsinfo__set_in_pidns(struct nsinfo *nsi);
 
 void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc);
 void nsinfo__mountns_exit(struct nscookie *nc);
-- 
2.47.0

