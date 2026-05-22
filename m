Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F353909AC
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489263; cv=none; b=CaIxEEaQNEZFIn3+oSDiV/3VPRZbo9jRTQ91xvz5Ljm80rn8swD8sZr8wgHNihdRsazLlnGPXRhgyVKT7LIvBmR1nIbfGm/RA5+p19wYVDXvltcy7MPko4o6TkPhchUs2O8gpCwcTgFCb+LLc7RXVe29HNb6q5RzaFLrW2wQBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489263; c=relaxed/simple;
	bh=piD1lSGIvhfh6IOI08spPTHARGMJ8GTeKxUslcwb7DQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XesVnRj0116MdhAMOzGnvNFEi9DTtozEZbonHIHOjFSWpRpoVODBwF0whxXY/gRuvRQoRC1+xeG8yeO8IlioUzMBGuyopbnQu6qfydXx4D9XYt7hPBYkdFRW1nlb1U+X5zuhcRUhDA1gv/5qhTw4RC3QpHDFeBdDUXWL3yk5ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SUvIAcaM; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUvIAcaM"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so12951138eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489259; x=1780094059; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwCtL+MLETGslqK6F91RVIGBg95O8W6fS1FbAA07JO4=;
        b=SUvIAcaMG8AgwYVlqiM3kbPBKg+Hm77VO3yGY+euOUIIwTC6LP3ALr408DAptrdZXq
         I5Omu2FPzUDVG5/pC9f10Zri0sY0Ih6l1eECjHRH7vJ0GiSHuoykkehgvZHJHF6FBhhx
         J/FuKjFBcSpnmJG28Pv7D1E81Js8neMD9wQZbd4FmsK91Dy+4DMSn/23zNPRGn2mJnAt
         lxADuONk2lkDQphLqi8yoNgKiSAMXvKORABag6uzktGPW7mmmQLrcKDc+R3ocqe4LYYk
         d6aMSUipZpFtZR/AIV4sef0/8W6csXICJXTugLScRwUt8H1gVWDnsbO5BZqeS0s8btQo
         INYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489259; x=1780094059;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwCtL+MLETGslqK6F91RVIGBg95O8W6fS1FbAA07JO4=;
        b=cxfXdPsIMDM/QbQQ+t2//ERx0FyM5K5tNT2O5crF1opdeBZ7o2w0bTEOtqUJJ+yzux
         LHQjKYGkBSIL0Isf81c/Q1MPYB0HVE20RtcKmX3uDu2dD3/ukppBQS24S0i/7eY7LIh7
         jl+0kVQ/KWPD8CdwpCVhRphQCFdW4WFHvx0+EsX02/O+mOdHGyzP7TlphiR39gE6yIV1
         eA3hhIG/RJFFJgs7yvlhFirHIyG+W4NZqK80STtagqvwNVSX11u0C4/7u+IA9jj9b53O
         daSU0BKMevuOvFSyet8ihg48E+ccs4OlBvBSSPaZk0Ca9UdOCQiw1KRiC4Iy6b2j14Y5
         5NBA==
X-Forwarded-Encrypted: i=1; AFNElJ+lsLWd2n/r2zoMG50CDHvnDiQNM82qTBjUYcNFRCyNeL9P9dvtLeO/oqSej8LTmz0Yfaa5RdEo/470yQvjUEv7@vger.kernel.org
X-Gm-Message-State: AOJu0YxLueADjOvFGi/zyHHse+HR56oaLg3jgPLUescExpLgAjDQ/oBJ
	gdfP4Qz0btD8qA+GqL+ul/KDSmvhL06x3RvZYAw8DIyvwD9NtcVe7VxfJt9BZZUkqWa4PMMxbJS
	DCSC1RNIm2A==
X-Received: from dlbup7.prod.google.com ([2002:a05:7022:fd07:b0:135:bc52:ad87])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:31a:b0:130:ca3d:f963
 with SMTP id a92af1059eb24-1365fc637cemr1839341c88.41.1779489259176; Fri, 22
 May 2026 15:34:19 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:36 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-9-irogers@google.com>
Subject: [RFC PATCH v1 08/14] perf stat: Extend CSV output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+csv_output.sh to run all
basic and core aggregation linter checks a second time under the --new
CSV print flag:

  - check_no_args
  - check_system_wide
  - check_interval
  - check_event
  - check_per_thread
  - check_per_node
  - check_system_wide_no_aggr
  - check_per_core
  - check_per_socket
  - check_per_die

This guarantees that CSV outputs produced by the decoupled printing engine
are formally verified and column-valid across standard and interval modes.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/tests/shell/stat+csv_output.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index cd6fff597091..e4153a03d716 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -88,5 +88,21 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+# New API CSV checks
+perf_cmd="--new -x$csv_sep -o ${stat_output}"
+check_no_args "CSV (New API)" "$perf_cmd"
+check_system_wide "CSV (New API)" "$perf_cmd"
+check_interval "CSV (New API)" "$perf_cmd"
+check_event "CSV (New API)" "$perf_cmd"
+check_per_thread "CSV (New API)" "$perf_cmd"
+check_per_node "CSV (New API)" "$perf_cmd"
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr "CSV (New API)" "$perf_cmd"
+	check_per_core "CSV (New API)" "$perf_cmd"
+	check_per_die "CSV (New API)" "$perf_cmd"
+	check_per_socket "CSV (New API)" "$perf_cmd"
+fi
+
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

