Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22903C2B9D
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562667; cv=none; b=oT078a+I0sbXwXumBGw10kjVqGIRG4Z2opyer+9CNB6xhdGT+pMLkbwDxbOtIvzRkm+mqg6kENBIxeIA3N3A43hsg95gX17Is0jdqSu0GwWbHmFe6cQgvMLdCd4fPEZjTvT0lsttBXf8eI4Pqy2UtIwdAVLRZLACJtieDsVh/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562667; c=relaxed/simple;
	bh=b+zFPPddi5vsuvVelPM3s+QHu6ScPZ/Q3IhGSJ9QvrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JBmthXDsN2/lSoaMjUR+jzDBaFXqdYyTU+a/tvEnOj2IdLEBtG55MvT9gCev8W3kV+V1W21PgIhjMHPBJs/hK9DLBotFgfSAV/xb+mZZf1n9SpMd77OnGG0BwHKRfjrZFn+y90z4YkmQIiSc807u94pa/nifc+ovBH5mgckXWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObC2gyTN; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObC2gyTN"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304df51ff3eso8204468eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562664; x=1782167464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhNmHmJTzevaW5Ie0slFVTtwGbX/K4JKnDxjqTLGpkg=;
        b=ObC2gyTN1q42RBBG+K8RgEQEQkCQzpPVFnzh97GOuInygy4E6BxkGnsggfhQyh1EQj
         fIjF2GFvKuJDm/17qYydUeTqRTnXKFuPddVLShd09/SDNgeXSjVubo5bDQ7MO05lMyDy
         QswsUzA48gLSYGjas9HWgmiolGt5dWR0tLS3bZppely5HCKmzPzZxY1+9IkroNSAYTiP
         fn25Lx3Kiiy8Thps/zsDlNl13oOkEwJgPPbxhUxvnPFJb/1nritfrwukZ+BGTwBYfp+V
         3zZ582MhTP1qRvnPhodby/JxkOCNYATw9f0fVSYnHo2kuSuuCAjtndz/gyDfO41IHAOp
         Bqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562664; x=1782167464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhNmHmJTzevaW5Ie0slFVTtwGbX/K4JKnDxjqTLGpkg=;
        b=mJYX4vHOTNUeaRdE0EaZVjK39+qdfnYJ69MpGOAsJFLIIPg1XbmRILxTeBjD3QY33A
         blgpay7/+jPhwKXAFDWCD9M95mUAWQLldSZK92keJy4Qq6JUMy0BEKWVwjFzigekFEnp
         vyTdeKJclerj47DJXiIdeLO+nHZHaOQ1TUVPazr2LeRk2PNGYIF8JtHUIHBVk3jAeMJL
         rXLkv7dn1kKF/4bn92fZYoi0I0cd/NDfK5VMCorLIkVCbO+QBMbueVTUJ32AUVGfcpWc
         n+Jja7IGrdQSdfkdD4NDLHfGt/LIWekG0r61pfnh+A/6EvsB8VHww2PTuFBtD2B6S1Vd
         BaDw==
X-Forwarded-Encrypted: i=1; AFNElJ8spAnKSDNoBmNWRkajPMhUBJ5kKHNizczlbo9XkYETt+UApEnr6V6nHzqCdSNiIjwaQFlJDZ6zUWv50uUQ3ZMm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy07Rnyqplifl9p59YvczDBtPMOOJ85oKu/s7r6Wm3Dopjev3Ta
	27LU4SjggctXOWLDS7JF6mTVPa2HgSqMVWpbrdojSSfSJSwskdTqfXIutZfeO+HtGDcBzreKxxl
	t8dd241jyIA==
X-Received: from dybbs28.prod.google.com ([2002:a05:7300:a21c:b0:307:bbdd:4346])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cd93:b0:304:db3a:3919
 with SMTP id 5a478bee46e88-3081ff4b664mr8334433eec.6.1781562663736; Mon, 15
 Jun 2026 15:31:03 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:30:08 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-19-irogers@google.com>
Subject: [PATCH v20 18/21] perf python: Handle Py_None for thread and cpu maps
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The python stubs allow passing None for threads and cpus to the
perf.parse_events() and perf.parse_metrics() bindings. However, PyArg_ParseTuple
parses None into a Py_None object, which is not a NULL pointer.
Because the C code lacked an explicit check for Py_None, it would cast
Py_None to a pyrf_thread_map/pyrf_cpu_map struct pointer and dereference it,
causing a memory corruption crash.

Fix this pre-existing issue by explicitly checking for Py_None alongside NULL
in pyrf__parse_events, pyrf__parse_metrics, and pyrf_evsel__open.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3a9f4e35d0bb..4ec5a91d45c0 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2091,10 +2091,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 					 &pcpus, &pthreads, &group, &inherit))
 		return NULL;
 
-	if (pthreads != NULL)
+	if (pthreads != NULL && pthreads != Py_None)
 		threads = ((struct pyrf_thread_map *)pthreads)->threads;
 
-	if (pcpus != NULL)
+	if (pcpus != NULL && pcpus != Py_None)
 		cpus = ((struct pyrf_cpu_map *)pcpus)->cpus;
 
 	evsel->core.attr.inherit = inherit;
@@ -3341,8 +3341,10 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
-	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
-	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+	threads = (pthreads && pthreads != Py_None) ?
+			((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = (pcpus && pcpus != Py_None) ?
+			((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	parse_events_error__init(&err);
 	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
@@ -3375,8 +3377,10 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
-	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
-	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+	threads = (pthreads && pthreads != Py_None) ?
+			((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = (pcpus && pcpus != Py_None) ?
+			((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
 	ret = metricgroup__parse_groups(evlist, pmu ?: "all", input,
-- 
2.54.0.1136.gdb2ca164c4-goog

