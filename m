Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB01AF0B6;
	Fri,  7 Mar 2025 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334912; cv=none; b=CuSVP3kmHQwiyDFRODSV3Sw8tlLuHz+qPBsxQ0slJXvYz2g2nwb/IsfCDBVW28DKdMsoS5zJ4QhPmI53otGWOiwiq8bZToF6DGCLOufrfhV+dxsKYgqTgBmzHRHYHwLm5Cut56eq3TwheDvb5cswSsJqkHEmknixMUvaTnUSfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334912; c=relaxed/simple;
	bh=4BARo/cjwobjmSME5nO7CRD+FHLh/HeQwPQ2OqndDIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc7n3YSc8pEPNZSZwJrKo2U+s/9GZraSy7A58cRjw2SKITSXO6TXUs650ipHuurzKS1WoDowY1kvxvCum6SLnmtS5Gyzu2pWrz8qtisEd8M0fsaLhg00a02vJSD5iCSD4iMiQ0vRM0ZyxEAUflVNecslybHjK2cGKXZbES8Zzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVOlfDYY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVOlfDYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB84C4CEE7;
	Fri,  7 Mar 2025 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741334911;
	bh=4BARo/cjwobjmSME5nO7CRD+FHLh/HeQwPQ2OqndDIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVOlfDYYXyi2umF6eY5R0ghus07YAFarCUzwbw96yW/k0NYSYXPHKFVKt8JLrSb/c
	 GpL7v0QLRp1ITe+nb2viqBao6z28vyIT2a4QxxlWai6oytBuiKkJgWYUpYQf487Bpn
	 Tuf0YjOITKW5RRG/4iGJ/pj7q9vW+mGpj2+XZs1zooyjP6pZv9UvGgPrwBWuoDGCjc
	 vJzm6cnpb73ZXO44Hccor2/6J3kQhUfamjR3NunP8TczX9a7rxKJd4SPNdkXvLlSr9
	 ivxlRtyvIDSdXXOyhpczn4R/lqRkeL6QdUfp8LahxnQ2CQ+PIqdMUnQCeXRV3iip35
	 VhfUq92sGwOsQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 3/3] perf report: Disable children column for data type profiling
Date: Fri,  7 Mar 2025 00:08:29 -0800
Message-ID: <20250307080829.354947-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250307080829.354947-1-namhyung@kernel.org>
References: <20250307080829.354947-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've realized that it doesn't make sense to accumulate the samples to
parent in the callchain when data type profiling is enabled.  Because it
won't have the same data type access in the parent.  Otherwise it'd see
something like this:

  $ perf report -s type --stdio -g none
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 2K of event 'cycles:Pu'
  # Event count (approx.): 8266456478
  #
  # Children  Latency      Self   Latency  Data Type
  # ........  .......  ........  ........  .........
  #
     698.97%   697.72%    99.80%    99.61%  (unknown)
       0.09%    0.18%     0.09%     0.18%  Elf64_Rela
       0.05%    0.10%     0.05%     0.10%  unsigned char
       0.05%    0.10%     0.05%     0.10%  struct exit_function_list
       0.00%    0.01%     0.00%     0.01%  struct rtld_global

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index fc776e9d7fdfa273..b030ce72e13ea8d1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1719,6 +1719,9 @@ int cmd_report(int argc, const char **argv)
 		report.data_type = true;
 		annotate_opts.annotate_src = false;
 
+		/* disable incompatible options */
+		symbol_conf.cumulate_callchain = false;
+
 #ifndef HAVE_LIBDW_SUPPORT
 		pr_err("Error: Data type profiling is disabled due to missing DWARF support\n");
 		goto error;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

