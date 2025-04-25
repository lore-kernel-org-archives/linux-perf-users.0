Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E9268C66;
	Fri, 25 Apr 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593781; cv=none; b=r8nksgbR1GyeizG4zATNJDbHepeHHNILNIGaLYF4YVWE++oePkXQtAYBXplZLhX3yZ68LynTckHMR5pbXejGpxdAtr9UEoRcHleiearrH699MQjAKr0+hskDwGEUYs2hByloXBvaqBwsZvq8fKf+6ixqbnBx0X4AKJyK983b5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593781; c=relaxed/simple;
	bh=oonh1NXc7x48MBVzed3dn7v4cSOnDgtdIXNyC9GMHOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYQ23ABJGt/Pj+jQf6tbwJypmTm5+GX2GpJcuSEqzv0NwR4ArhFqu2xGY2UkOCApZPYdH9dSkeaXgZXBb532YQysBBJQg0jlEPmS+pzV8KzEpjlPTG4tBydfDtvFZ07moebH0Bt8A1BAKtvxfmsxq4xaYEXFYBUrq7XoHM3lXzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa4Wg8RQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa4Wg8RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EC2C4CEE4;
	Fri, 25 Apr 2025 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745593781;
	bh=oonh1NXc7x48MBVzed3dn7v4cSOnDgtdIXNyC9GMHOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wa4Wg8RQpYPnV5hT2loBRJRl3BXAdLpA1RE4byQdu01Si6tt5WpI9NrF6AiXOvD88
	 Med8EoaaZuncHUH4oJbA232D1OOq5OFnHq6KbH2QeC5bM2t+I8hn3r7VXxPWQLgLlg
	 flhMbhwnRuIYNDEMRHvp0Rt89bcZYL1IQCvxw8x/9KsdU+PCQy0rCsNjnnTKrrt1M1
	 sIoqmTerHBkSWAnDDJOGoYiTy1RVx3JmtRFKJQE6RYjIM2ohVjco/krIEEH5UAC1Rc
	 3OUdqU/Y69H0XMxhvUT2ac/1pcfpiHpziej9Ayjq1cOxmvwfsOqPXeEXK/6HFO/2yD
	 Vy7Zd7yNQJqEg==
Date: Fri, 25 Apr 2025 12:09:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	James Clark <james.clark@linaro.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zixian Cai <fzczx123@gmail.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Martin Liska <martin.liska@hey.com>,
	Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] perf build-id: Change sprintf functions to
 snprintf
Message-ID: <aAulsrAJuia49LR0@x1>
References: <20250424195831.1767457-1-irogers@google.com>
 <20250424195831.1767457-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424195831.1767457-6-irogers@google.com>

On Thu, Apr 24, 2025 at 12:58:28PM -0700, Ian Rogers wrote:
> Pass in a size argument rather than implying all build id strings must
> be SBUILD_ID_SIZE.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-buildid-cache.c            | 12 +++----
>  tools/perf/builtin-buildid-list.c             |  6 ++--
>  tools/perf/util/build-id.c                    | 33 ++++++++-----------
>  tools/perf/util/build-id.h                    |  6 ++--
>  tools/perf/util/disasm.c                      |  2 +-
>  tools/perf/util/dso.c                         |  4 +--
>  tools/perf/util/dsos.c                        |  2 +-
>  tools/perf/util/event.c                       |  2 +-
>  tools/perf/util/header.c                      |  2 +-
>  tools/perf/util/map.c                         |  2 +-
>  tools/perf/util/probe-file.c                  |  4 +--
>  .../scripting-engines/trace-event-python.c    |  7 ++--
>  tools/perf/util/symbol.c                      |  2 +-
>  13 files changed, 38 insertions(+), 46 deletions(-)

You missed these, that I added, please ack.

- Arnaldo

diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 9197128992510218..663c8f700069d42b 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -37,7 +37,7 @@ static int build_id_cache__add_file(const char *filename)
 		return err;
 	}
 
-	build_id__sprintf(&bid, sbuild_id);
+	build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	err = build_id_cache__add_s(sbuild_id, filename, NULL, false, false);
 	if (err < 0)
 		pr_debug("Failed to add build id cache of %s\n", filename);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 307ad6242a4e92f6..c10549fc451b508b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -502,7 +502,7 @@ static struct debuginfo *open_from_debuginfod(struct dso *dso, struct nsinfo *ns
 	if (!c)
 		return NULL;
 
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 	fd = debuginfod_find_debuginfo(c, (const unsigned char *)sbuild_id,
 					0, &path);
 	if (fd >= 0)
@@ -1089,7 +1089,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
 	}
 	if (dinfo->build_id) {
 		build_id__init(&bid, dinfo->build_id, BUILD_ID_SIZE);
-		build_id__sprintf(&bid, sbuild_id);
+		build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	}
 	debuginfo__delete(dinfo);
 	if (ret == 0 || ret == -ENOENT) {
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 3cc7c40f50978a0f..b74f6fe24bb61af8 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -859,7 +859,7 @@ static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 		comp_dir = cu_get_comp_dir(&pf->cu_die);
 		if (pf->dbg->build_id) {
 			build_id__init(&bid, pf->dbg->build_id, BUILD_ID_SIZE);
-			build_id__sprintf(&bid, sbuild_id);
+			build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 		}
 		ret = find_source_path(pf->fname, sbuild_id, comp_dir, &fpath);
 		if (ret < 0) {
