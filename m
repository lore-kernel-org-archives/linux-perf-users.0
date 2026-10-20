Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474353;
	b=AavsjSnsJIJC94R/bSIu7n5Dm2fV/z/4TSDdbBtpfPzn57Zn9agMh7xR45qyEIprbMIj
	 IXDZEhyE55Ilr+ZgVTle7TETb/Hrs1HjxDAnDKMi9qXXs5x1i7lzjaK10y+pRNx4DmAqu
	 vS6HFrmy6ydfUeiYjtaJY0PoWtKLgLGVbkSprxEBgmCWnIjaEvJK7IuDR5E5PYwOOPN5A
	 q51rsQufg5oerw8JRhP5Yktixq1ts2g6vp3nATAVW3XZJ/Il2+43Lo9FGoFJqEyYdwMe8
	 llOSVungRHq+UB4uq/3BMMtTdMf+EuJr8eOn7v6rEVMmFMq8ExpD6rrypQ6XyadgpQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474353;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KOulGVMaguEwuPmjIvDB0lBPaaawA/BwOi5X8lfpRRk=;
	b=ujteSU46fMGtkgsrdW1WD8DOZycqAQgmx8l7x4EhIRf/cDDF/4xKMp6Ua2eWbXlZGjem
	 Osv9ZBg16sEx0bu/uUbZ/tvhBU08xltrR9c7Lu+7M34XC1df2uKNW1r+6SMmX4bYc2NCX
	 Bt7kzei3dU9TsGe/BBAmhflj5OvXfzReI3sVrRzhWioFJ9f3f7if6bNHHR2FCqMAaqZa8
	 O6mVp7R+DwjADQSPmqGdYA3W+090nuYkbTi6T3wUKRTIXQUn935NXaK0euprxbOlB5Tqk
	 tq7ufJHVJRMb9IVP5IjKBCA8/M9PXC89jIaYVj/slzp1Xsk4R2NCPK3FZ8hAC2AuGcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNEWb9e8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD2606A319;
	Tue, 20 Oct 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNEWb9e8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0532B1F000C4;
	Tue, 20 Oct 2026 05:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792474352;
	bh=KOulGVMaguEwuPmjIvDB0lBPaaawA/BwOi5X8lfpRRk=;
	h=From:To:Cc:Subject:Date;
	b=kNEWb9e8ZCnLIsoikUEWNu2tWCbMiqa3oz9wt9F48SobTF/rdxgDlU/slFGMCQyRw
	 cy8e10qrcY8Ow9/V4WZKh75kbCZ1UZrijt7JxKBij3/ylvuL7rIq4D6eTU6hy6EaU4
	 nFCBbDxLC18wn84fEKQzjuob7BDMgwyHt+y/nuovqQjZEJQy4Q1H9dAqUUNSSFLSxJ
	 07gBNa2lxo25BA8Vj9Ao5UtOOo+g7DU0BHXvIotK5vpfDjXdECa/PrdrKPoO3trYzW
	 lCydXoALOSduPnbqfcHvGQ99HTAMYKW1wdG8m30haF0Bta3r2CuTY19h8LOTL1D2TZ
	 Ar+u+p2qVycZg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf bpf-filter: Fix memory leak on bpf_link
Date: Mon, 19 Oct 2026 22:32:26 -0700
Message-ID: <20261020053226.55936-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching BPF program returns bpf_link but it leaked like following.

  ==51328==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 1568 byte(s) in 28 object(s) allocated from:
      #0 0x7ffbe76ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 61e8165ca90f7a4f06b73f064a938c76deaae079)
      #1 0x000000625df7 in bpf_program__attach_perf_event_opts (tools/perf/perf+0x625df7) (BuildId: 5e6309fda155e58708e92f1c76d44cadd585d0eb)
      #2 0x000000beddc0 in perf_bpf_filter__prepare util/bpf-filter.c:507
      #3 0x0000008f3def in evlist__apply_filters util/evlist.c:1421
      #4 0x00000044bbcf in record__open  tools/perf/builtin-record.c:1469
      #5 0x000000453f9e in __cmd_record  tools/perf/builtin-record.c:2594
      #6 0x00000045dadb in cmd_record  tools/perf/builtin-record.c:4427
      #7 0x0000005df56b in run_builtin  tools/perf/perf.c:383
      #8 0x0000005dfa0e in handle_internal_command  tools/perf/perf.c:436
      #9 0x0000005dfddc in run_argv  tools/perf/perf.c:480
      #10 0x0000005e0333 in main  tools/perf/perf.c:581
      #11 0x7ffbdd450680 in __libc_start_call_main (/lib64/libc.so.6+0x3680) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
      #12 0x7ffbdd450797 in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so.6+0x3797) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
      #13 0x000000409c54 in _start (tools/perf/perf+0x409c54) (BuildId: 5e6309fda155e58708e92f1c76d44cadd585d0eb)

  SUMMARY: AddressSanitizer: 1568 byte(s) leaked in 28 allocation(s).

Let's add an xyarray of bpf_link for the filters and release them at the
end to fix the leaks.

Fixes: 56ec9457a4a20c5e ("perf bpf filter: Implement event sample filtering")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.c | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h      |  1 +
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 72e83ac1d6a4b075..2fec6004b1aabc1e 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -67,6 +67,7 @@
 #include "bpf_skel/sample_filter.skel.h"
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
+#define LINK(e, x, y) (*(struct bpf_link **)xyarray__entry(e->bpf_links, x, y))
 
 #define __PERF_SAMPLE_TYPE(tt, st, opt)	{ tt, #st, opt }
 #define PERF_SAMPLE_TYPE(_st, opt)	__PERF_SAMPLE_TYPE(PBF_TERM_##_st, PERF_SAMPLE_##_st, opt)
@@ -501,6 +502,15 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
+	evsel->bpf_links = xyarray__new(xyarray__max_x(evsel->core.fd),
+					xyarray__max_y(evsel->core.fd),
+					sizeof(link));
+	if (evsel->bpf_links == NULL) {
+		ret = -errno;
+		pr_err("Failed to allocate bpf links\n");
+		goto err;
+	}
+
 	prog = skel->progs.perf_sample_filter;
 	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
 		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
@@ -511,6 +521,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 				ret = PTR_ERR(link);
 				goto err;
 			}
+
+			LINK(evsel, x, y) = link;
 		}
 	}
 	free(entry);
@@ -528,6 +540,15 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 			free(pfi);
 		}
 	}
+	if (evsel->bpf_links) {
+		for (x = 0; x < xyarray__max_x(evsel->bpf_links); x++) {
+			for (y = 0; y < xyarray__max_y(evsel->bpf_links); y++) {
+				bpf_link__destroy(LINK(evsel, x, y));
+			}
+		}
+		xyarray__delete(evsel->bpf_links);
+		evsel->bpf_links = NULL;
+	}
 	sample_filter_bpf__destroy(skel);
 	return ret;
 }
@@ -541,6 +562,17 @@ int perf_bpf_filter__destroy(struct evsel *evsel)
 		list_del(&expr->list);
 		free(expr);
 	}
+
+	if (evsel->bpf_links) {
+		for (int x = 0; x < xyarray__max_x(evsel->bpf_links); x++) {
+			for (int y = 0; y < xyarray__max_y(evsel->bpf_links); y++) {
+				bpf_link__destroy(LINK(evsel, x, y));
+			}
+		}
+		xyarray__delete(evsel->bpf_links);
+		evsel->bpf_links = NULL;
+	}
+
 	sample_filter_bpf__destroy(evsel->bpf_skel);
 
 	list_for_each_entry_safe(pfi, pos, &pinned_filters, list) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 53f3641b66e18674..c4639e6aeac2ffce 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -174,6 +174,7 @@ struct evsel {
 
 	struct list_head	bpf_counter_list; /* for perf-stat -b */
 	struct list_head	bpf_filters; /* for perf-record --filter */
+	struct xyarray		*bpf_links;
 
 	/* for perf-stat --use-bpf */
 	int			bperf_leader_prog_fd;
-- 
2.56.0

