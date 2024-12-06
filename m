Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E21FFC69;
	Fri,  6 Dec 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518136; cv=none; b=QABPaMyhxW39ZRlu8aIniSjQQ6LfA4M7RwLUmqXI0BOLqJleveQHxC4Ng7rhWjDzjZa3dkPixklfUqAqIH97CfypS26J23dAMSKofgfgtUHY4TDM8iv3ocApBDmqqSprvv8KhVPqxcWYWpil//tUE6jw00t4D/bk+19tCQfuQjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518136; c=relaxed/simple;
	bh=C/GYO19WCUxdqbu0P1HVnqbnay9/cLMX9yt7EvaV+N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJnmCfhfOmESGi2Ks/Bny5mfocHeYHCU+SFypsS2kWzR4jvqUC6zdCE2828jzsJHqlezlTwbiQY8gpitLi1WmjVERlznQcAWHS0XsEG41jvcChLYPaPlV8cyZy3oywjKsRe0Znjh5p2xuIlXPE6VoLFNXltKZK43mt5k8izhIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT2vjXGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT2vjXGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E03BC4CED1;
	Fri,  6 Dec 2024 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733518136;
	bh=C/GYO19WCUxdqbu0P1HVnqbnay9/cLMX9yt7EvaV+N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tT2vjXGUpU7QaBOvFWK6/6WhoCAj8fUBqmrFyinJ43Ql6Ch9wA4hWQnhdNlMEDkjX
	 4vdIYkUuFlJAVeMZrinzpydJ2zsvjDNtEF0eRPl5oqBqkY/f4d1fKwnNoij6ilEL0J
	 bTWDcCzXPVMw95GoXs6NrBQPKZiq0D6KoKbvWjuIsEvkuuowV2NbpQn4pbBa6va2uE
	 q9AR1Ndk3IwTPtmbh27nPTaUIQIeH+qimbzGQzsCpW4dkSP3QEfnLrWsKb3i3GPlBx
	 HKPd649jk6TdmhSzFooPFOdF2YHUK/QATbMempOhJuF8G/8d7A2rAmitsJtZiwEWV0
	 FIT0nzmJjiApQ==
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
Subject: [PATCH 4/5] perf jitdump: Fixup in_pidns member when java agent and 'perf record' are not in the same pidns
Date: Fri,  6 Dec 2024 17:48:27 -0300
Message-ID: <20241206204828.507527-5-acme@kernel.org>
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

When running 'perf record' outside a container and the java agent inside
a container the jit_repipe_code_load() and friends will emit
PERF_RECORD_MMAP2 entries for the jitdump records and will check if we
need to fixup the pid/tid:

        nspid = jr->load.pid;
        pid   = jr_entry_pid(jd, jr);
        tid   = jr_entry_tid(jd, jr);

The jr_entry_pid() function looks if we're in the same pidns:

  static pid_t jr_entry_pid(struct jit_buf_desc *jd, union jr_entry *jr)
  {
          if (jd->nsi && nsinfo__in_pidns(jd->nsi))
                  return nsinfo__tgid(jd->nsi);
          return jr->load.pid;
  }

But since the thread, populated from perf.data records, try to figure
out if in the same pidns by actually trying, on the system where 'perf
inject' is running to open a procfs file (a bug that remains to be
fixed), assuming that if it is not possible that is because that thread
terminated and thus we can't get its namespace info and tolerates
nsinfo__init() failing, noting only that that namespace can't be
entered, so don't even try.

But we can kinda get at least that info (thread->nsinfo->in_pidns) from
the data in the perf.data file, namely the pid and tid in the
PERF_RECORD_MMAP2 for the jit-<PID>.dump file generated from the java
agent, if the PERF_RECORD_MMAP2->pid is the same as what is in the
jitdump file, then we're in the same namespace, otherwise we need to use
the PERF_RECORD_MMAP2->pid.

This all has to be revamped for this jitdump + running perf from
outside, as the meaning of in_pidns is being abused, the initialization
of nsinfo->pid with the value coming from the PERF_RECORD_MMAP2 data is
wrong as it is the pid _outside_ the container since perf was running
there.

The hack in this patch at least produces the expected result in this
scenario by following the assumptions in the current codebase for
finding maps and for generating the PERF_RECORD_MMAP2 for the ELF files
synthesized from the jitdump records in jit_repipe_code_load(), etc.s

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
 tools/perf/util/jitdump.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index d53c6ac4095b663c..f23e21502bf8381a 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -737,7 +737,7 @@ jit_inject(struct jit_buf_desc *jd, const char *path)
  * as captured in the RECORD_MMAP record
  */
 static int
-jit_detect(const char *mmap_name, pid_t pid, struct nsinfo *nsi)
+jit_detect(const char *mmap_name, pid_t pid, struct nsinfo *nsi, bool *in_pidns)
  {
 	char *p;
 	char *end = NULL;
@@ -773,11 +773,16 @@ jit_detect(const char *mmap_name, pid_t pid, struct nsinfo *nsi)
 	if (!end)
 		return -1;
 
+	*in_pidns = pid == nsinfo__nstgid(nsi);
 	/*
 	 * pid does not match mmap pid
 	 * pid==0 in system-wide mode (synthesized)
+	 *
+	 * If the pid in the file name is equal to the nstgid, then
+	 * the agent ran inside a container and perf outside the
+	 * container, so record it for further use in jit_inject().
 	 */
-	if (pid && pid2 && pid != nsinfo__nstgid(nsi))
+	if (pid && !(pid2 == pid || *in_pidns))
 		return -1;
 	/*
 	 * validate suffix
@@ -830,6 +835,7 @@ jit_process(struct perf_session *session,
 	struct nsinfo *nsi;
 	struct evsel *first;
 	struct jit_buf_desc jd;
+	bool in_pidns = false;
 	int ret;
 
 	thread = machine__findnew_thread(machine, pid, tid);
@@ -844,7 +850,7 @@ jit_process(struct perf_session *session,
 	/*
 	 * first, detect marker mmap (i.e., the jitdump mmap)
 	 */
-	if (jit_detect(filename, pid, nsi)) {
+	if (jit_detect(filename, pid, nsi, &in_pidns)) {
 		nsinfo__put(nsi);
 
 		/*
@@ -866,6 +872,9 @@ jit_process(struct perf_session *session,
 	jd.machine = machine;
 	jd.nsi = nsi;
 
+	if (in_pidns)
+		nsinfo__set_in_pidns(nsi);
+
 	/*
 	 * track sample_type to compute id_all layout
 	 * perf sets the same sample type to all events as of now
-- 
2.47.0

