Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6A16F8ED;
	Fri, 21 Jun 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008642; cv=none; b=IVNm0jEdz1Bst4KoRFsoowMHmqrAbKTk5cDiAzfBM9VGzEVD6kz6wszLrbUbQ1UYl0BiiV/hM0EmNp4C3KcUIhDqzgZKPHW6QBeSvaHV8woAj3Y6NgfHCKe26GLQIjTlVzc7KTRksCngMko28WZIZKX2JIpHbkMOWFFHGTowpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008642; c=relaxed/simple;
	bh=XXty6hGBDPkOM763yRelUV/ggPiZMfvcd7jwZYXzhas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KntXKLImKDYTYMDj55YMeBE+LFbmOkb91X6B3Kn1fO3R29iNsefnJ9FdoAU5bT3enWaoFNxy5pHbrD/tJ3t7PKeuvI2nJ6Tc4qGif/WYjvwNnNvE+Crs6Xgq3TFUlYZOBUa3l0Yn4RfVCOEZYrcHvcAGKn+zUojav3SQKwmBG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcFLeM4t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcFLeM4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA47C4AF0A;
	Fri, 21 Jun 2024 22:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719008641;
	bh=XXty6hGBDPkOM763yRelUV/ggPiZMfvcd7jwZYXzhas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcFLeM4tjaAb+kjL8LDNZP8gQZrog+qTSG501UVW9bdzx/BZLb+3bAgGbUftMMPpP
	 G3KBO4R+hM1i0fXmQgCm/rz5K3kXgDgKooCdWCOOgk3xWuwdhjj5DQbdsl2JHth9zo
	 DIhPahqem2Ap5V2u/REFvR/AknY2v44Wj9ZiorJoAbGfuZE69cWRDzBdstF9/pd8qo
	 dKZk0Mdyiclgou0KeIcnTmX0Xd4FORU68ugB6ybs6fyQ1a5pBF8JVBimL7qsxifRIw
	 n+8haWjfGY94nV+ruSMZM/bpqB9hlTeQ1hIH79phLoLrweUdqub8VjrzpBaFNAKTEv
	 wv4/HQF4nNw3w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 7/8] perf record: Add --setup-filter option
Date: Fri, 21 Jun 2024 15:23:56 -0700
Message-ID: <20240621222357.717374-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621222357.717374-1-namhyung@kernel.org>
References: <20240621222357.717374-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow BPF filters for unprivileged users it needs to pin the BPF
objects to BPF-fs first.  Let's add a new option to pin and unpin the
objects easily.  I'm not sure 'perf record' is a right place to do this
but I don't have a better idea right now.

  $ sudo perf record --setup-filter pin

The above command would pin BPF program and maps for the filter when the
system has BPF-fs (usually at /sys/fs/bpf/).  To unpin the objects,
users can run the following command (as root).

  $ sudo perf record --setup-filter unpin

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  5 +++++
 tools/perf/builtin-record.c              | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d6532ed97c02..41e36b4dc765 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -828,6 +828,11 @@ filtered through the mask provided by -C option.
 	only, as of now.  So the applications built without the frame
 	pointer might see bogus addresses.
 
+--setup-filter=<action>::
+	Prepare BPF filter to be used by regular users.  The action should be
+	either "pin" or "unpin".  The filter can be used after it's pinned.
+
+
 include::intel-hybrid.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a473000f3599..e88dedc0391b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -171,6 +171,7 @@ struct record {
 	bool			timestamp_filename;
 	bool			timestamp_boundary;
 	bool			off_cpu;
+	const char		*filter_action;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	unsigned long		output_max_size;	/* = 0: unlimited */
@@ -3557,6 +3558,8 @@ static struct option __record_options[] = {
 			    "write collected trace data into several data files using parallel threads",
 			    record__parse_threads),
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
+	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
+		   "BPF filter action"),
 	OPT_END()
 };
 
@@ -4086,6 +4089,18 @@ int cmd_record(int argc, const char **argv)
 		pr_warning("WARNING: --timestamp-filename option is not available in parallel streaming mode.\n");
 	}
 
+	if (rec->filter_action) {
+		if (!strcmp(rec->filter_action, "pin"))
+			err = perf_bpf_filter__pin();
+		else if (!strcmp(rec->filter_action, "unpin"))
+			err = perf_bpf_filter__unpin();
+		else {
+			pr_warning("Unknown BPF filter action: %s\n", rec->filter_action);
+			err = -EINVAL;
+		}
+		goto out_opts;
+	}
+
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
-- 
2.45.2.741.gdbec12cfda-goog

