Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04378382F25;
	Mon,  3 Aug 2026 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753206; cv=none; b=fq1fnFEVc0xCqSOww5RQqy3Iy8gh2maXfwZ/EYyhN8h3OH/dhLdQUi8A0R1t+4Xr1ybvomJH/DPR7DXQ9PJeeg+M7RUt1VYrnC/7yMIUGjId9LS1p4eXEYBWcbqNGL2N0eMm1rCMfDdKjy10Lrd9Dzyw15h2XRc1o9mvBWfkuoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753206; c=relaxed/simple;
	bh=xc4DAGfdMMiRez3o1K4068JADxB0HqpgizL47L3i86E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p37aa/ZfP7X6t/gGrC1A0BW8jDhkZUFrAZvgqfUL9WQ2Em7QmMOXCrBJK5QXuMMnL3WHlsoTgrPTI0f2vFGTDdus+N7dMyj2lsriobQND+9Y8cIrdPJGU73hJJNEfKfKfTggJob5NBch+5JQOd3yt+hlbmWLn0u9h8LHJh00zGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrMDk+51; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrMDk+51"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7A2CC2BCFC;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785753205;
	bh=xc4DAGfdMMiRez3o1K4068JADxB0HqpgizL47L3i86E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BrMDk+51ACNA34TzCtd+oaU0TkMzEeUoGjeSAhr52hsaFEftVrM02a8rMCXXD8fhG
	 9PMKo3W1RGaQ1c77ndo7SHDnEH8kPEG+d9fh0cmKNjJwlMvxjLSxpNvQnswXVL/7/g
	 QKJEvdMJOdXgFBBhAj3t6DEkT5VEOL+Dw+7Ya9/zKqjyH0jgPbuA6KOx7C/5EjdoWS
	 TXaT+rXsSp53MN9apBkLHR69N8DpfAYgDVAZGdwhxa06P979eAt7NC8/dovSBbd1XN
	 eqdx6Cidg99DLNrz9LlNljn+ShaMap1EFU9UbkzdQtw2gSckI1/JKbVRx/LjEilU1p
	 6X8PUEqqH+Fcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9963EC55822;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Date: Mon, 03 Aug 2026 12:33:22 +0200
Subject: [PATCH 3/4] perf tools: Fix double free and memory leak in
 kvm_events_record()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-perf-kvm-fixes-v1-3-a5db849ac973@gmail.com>
References: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
In-Reply-To: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michalis Niarchos <michael.niarchos@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785753204; l=2074;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=qviC10maUOTVKZJOnRSF+BcmmvSChM1/SRTVYIej1IE=;
 b=JgHGYfn/OMDHkP4IQn0q/SxErHGCyDFFYQbYnRIM2qNQELby7MckSnN2rVtDY/SIz1BXSFtmN
 aWfuYzk5Yk9CnaxKidN+c+KxpB3njQpL1EA3WlSWChd6A/gv8Yt/ziO
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

From: Michalis Niarchos <michael.niarchos@gmail.com>

cmd_record() reorders the contents of the rec_argv pointer array, so
its entry order no longer matches the order in which the caller
originally allocated them. Freeing the contents of rec_argv by
iterating the reordered array results in some pointers being freed
twice and others never freed.

All the entries of rec_argv come from literals or pointers that are
valid for the lifetime of this call. Reference them directly instead
of duplicating to remove the need to individually track and free each
entry.

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
 tools/perf/builtin-kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 1a013698cae3..189ef3576e34 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1681,18 +1681,18 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(record_args[i]);
+		rec_argv[i] = record_args[i];
 
 	for (j = 0; j < events_tp_size; j++) {
-		rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
-		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp(e_machine)[j]);
+		rec_argv[i++] = "-e";
+		rec_argv[i++] = kvm_events_tp(e_machine)[j];
 	}
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(kvm->file_name);
+	rec_argv[i++] = "-o";
+	rec_argv[i++] = kvm->file_name;
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	set_option_flag(record_options, 'e', "event", PARSE_OPT_HIDDEN);
 	set_option_flag(record_options, 0, "filter", PARSE_OPT_HIDDEN);
@@ -1717,9 +1717,6 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 	record_usage = kvm_stat_record_usage;
 	ret = cmd_record(i, rec_argv);
 
-EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }

-- 
2.55.0


