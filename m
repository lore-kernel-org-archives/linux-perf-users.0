Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B13DC871
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311301; cv=none; b=Rps6XHlZiFaVx63s7xJ8f4q+cbLRiJ/RdBukbk1er3Axo/zb16ZXf3p3bANXn9BhS30HjjitIOT32ldlf3CTNbWB4aqsqsjKOA+gRMklk8uvg1Yy8AuImJSv7yzghw29O16mAQUtNActjiG4xueNhNDwe9/tP/9nUi46KjAyCEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311301; c=relaxed/simple;
	bh=w8wuXuqZRSwSM8fLbVAMsYoAfncMdUicO2+YtgOFGpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GlVMoHTY2T+DsAtIfa7we8cQACzDvTmgtdOlWwj7u8tBT7nXyLHp7P30wpRm72WNBKD5TEQXfo1CsxGzPGDeAJz6qwD12HptClZG8+ITPCJ5R3VslGW5dfHKN+saS7dacELWOwPA6aDXFUDm84dN+I14+B7DCWqrV4zSr1b5Jxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmg+6agx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmg+6agx"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b0f59a5fdaso5497237b3.3
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792311299; x=1792916099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QCXmkSF8Q00yNTDA7Iqi2j9t4mg42xgLViS6iyB+IxA=;
        b=cmg+6agxX6nO2BEhZBcV8ArL1XG+U7Dl6mLgQn4s19QvsVD9SynTgLzSayEcqXQKRT
         J/lPs0heS6fMlQ1hh6rQsZKmrKoDwvtwlfW3KBM6HJjYjAHc2BpZSQUH0M96mIt0l/88
         MbWiSnCRbzpKsRLWC/NJt8YKA5nPgsslU5yIg/SbRlwF3GIu4LyjroHCfWPv2VLeBuuR
         u0EZnZ2/S4wzULKmCx5tlKUKWreQ/TrafjnZ4sz+F+m1W+6cNyFuTDK3n1dQaoz5PAqn
         Xw415CpcmP6McBYapc7tgsMoWNHwWtVzS/i+zg7/54OJ90UI4PgmD5SykDPqNAc5rTZw
         N8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792311299; x=1792916099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QCXmkSF8Q00yNTDA7Iqi2j9t4mg42xgLViS6iyB+IxA=;
        b=PD0rMQ5kObCyThAfO2JPG7DBT3twbua4w7q++zTU+0U8Uw9tTeWMIYwKbkPgyki4Ys
         YQCTDjffNXEr5ZpRIe21kusWOXeOcawtTyCLB1rCFv8zFjqRuNoZgDJZT2XMnwsTkTF8
         uv5Eg6msuLngttyAI9WgaffBSTfk+V0fhon8L7Tk7yj0L4bjBf3PIAWOBUwrD9DV/6id
         vJuwj4OSY2CuPBKKVsxSYx8YU1Jnbc9dO5PuYByLIFO5VyMj44zwYa4RYI90K72JCD1X
         6EejRcQ6QHhnqyvjGg4w8W7DlLRAUZTIl9C4FmNA3ZJaVzIGNKcYeUvnyZ8tVaEQag79
         uHhA==
X-Forwarded-Encrypted: i=1; AKwUvBzf9JvLmMm3oxXMHM3iPtAD8RRpGGBg67Yoh8MmrtwASiSudaZ8vDpWY53Ol/lHMjvrDzc3F2vEOcptSDUb/qqC@vger.kernel.org
X-Gm-Message-State: AFq9FYKxppqJzUgydJ+Wrj1iPLfniZICy7ieJARDn/dU0pdReM8ysTu6
	1w2bWorBD7dffkQLJWzvFdy4zllmmIwl/w9nc5Llz6ic1UGxaAzbXPkT
X-Gm-Gg: AYBFou0ArJbiOFiUOpdsyx9V4FmxdVx4VP6fqasB63S18D+X3warV7BWW9zrefV4Xu1
	cBYML1LH0PhzTVoaej7Ulk8ImCVqp2rgx/F9pLVb9zqHYf6gvhPDlsJmAAtGBWKPtq9eDmBGA4w
	TNlWvpAq7QXl6jHRDQ5mPNaqvKm1mavekUI64ShCSsNJjjXLDWqhEJYKQyokaL/xILGdq3Ei9Wu
	fhlQY6I1FRp/t6ZePg8kzbD8g2mCg11JFx3M5s0r2sKCz+9AyFkhUWa/kQkrzZ67uSfa1J399eH
	a62PF3RPz6Zmb31af6ULg2l1+Mh3A3Fsv4AYQaS5OfQpkk7tEqpZTd+DLrW9oIJB1+bGkFWo40G
	/e1kr5buClA6cdDb8sYHaTieevTYg8rc1wRWuBj7mxXcfl+DTNbVNGiaxNoDvzbnfQ+Wu8t8gz4
	1ucEAeekLLHXnrSjt1K5WRmJ7uFbOQv9Igmim6LdHP8/5bDgdTnAvIZNtxCs/pf0nzEYyhIuDwk
	stSyHjPS+L/DsaV2PRrP99+ig==
X-Received: by 2002:a05:690c:a4c3:b0:8ad:bc2e:aad1 with SMTP id 00721157ae682-8b0f2147469mr11374857b3.17.1792311299113;
        Sun, 18 Oct 2026 01:14:59 -0700 (PDT)
Received: from codey.attlocal.net ([2600:1700:22f5:3930::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e594555dsm28611877b3.42.2026.10.18.01.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 01:14:56 -0700 (PDT)
From: Lalit Maganti <lalitmaganti@gmail.com>
To: irogers@google.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@linaro.org,
	leo.yan@linux.dev,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lalit Maganti <lalitmaganti@gmail.com>
Subject: [PATCH] perf python: Set up callchain parameters for sessions
Date: Sun, 18 Oct 2026 09:14:52 +0100
Message-ID: <20261018081452.1014460-1-lalitmaganti@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf.session never calls callchain_param_setup(), so callchains are
resolved with callchain_param.record_mode left as CALLCHAIN_NONE rather
than set from the sample type as in perf script and perf report.

On arm64 this loses frames: when a sample hits a function before it has
pushed its frame record, its caller is only in the link register, and
recovering it needs record_mode CALLCHAIN_FP. Comparing the callchain of
every sample with perf script, on a frame pointer recording of a
two-thread workload on arm64, 4 of 4494 samples miss a frame, e.g.:

  perf script: clock_gettime@plt <- now <- spin <- other_path
  perf.session: clock_gettime@plt <- spin <- other_path

Call callchain_param_setup() once the session is created and, as perf
script does, again as attrs are processed, for pipe mode. With that,
all callchains match perf script on arm64, for frame pointer and DWARF
recordings, from a file or a pipe. On x86 they matched before and still
do.

Assisted-by: LLM
Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>
---
 tools/perf/util/python.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 60dbe2dad5eb..92d18e24049d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -4842,6 +4842,24 @@ static int __pyrf_session_tool__stat_round(const struct perf_tool *tool,
  */
 static struct pyrf_session *pyrf_session__active;
 
+/*
+ * In pipe mode attrs are only known once processed, so set up callchains again,
+ * as perf script does.
+ */
+static int pyrf_session__process_attr(const struct perf_tool *tool,
+				      union perf_event *event,
+				      struct evlist **pevlist)
+{
+	int err = perf_event__process_attr(tool, event, pevlist);
+
+	if (err)
+		return err;
+	callchain_param_setup(evlist__combined_sample_type(*pevlist),
+			      perf_session__e_machine(evsel__session(evlist__last(*pevlist)),
+						      /*e_flags=*/NULL));
+	return 0;
+}
+
 static bool pyrf_session__check_not_busy(struct pyrf_session *psession)
 {
 	if (pyrf_session__active == psession &&
@@ -5061,7 +5079,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->tool.ksymbol          = perf_event__process_ksymbol;
 	psession->tool.text_poke        = perf_event__process_text_poke;
 	psession->tool.build_id         = perf_event__process_build_id;
-	psession->tool.attr		= perf_event__process_attr;
+	psession->tool.attr		= pyrf_session__process_attr;
 	psession->tool.event_update	= perf_event__process_event_update;
 	psession->tool.feature		= perf_event__process_feature;
 #ifdef HAVE_LIBTRACEEVENT
@@ -5139,6 +5157,8 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 		PyErr_SetString(PyExc_OSError, "perf: symbol__init failed");
 		goto err_out;
 	}
+	callchain_param_setup(evlist__combined_sample_type(session->evlist),
+			      perf_session__e_machine(session, /*e_flags=*/NULL));
 	if (psession->symfs && !symbol_conf.symfs[0])
 		zfree(&psession->symfs);
 

base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
-- 
2.56.0

