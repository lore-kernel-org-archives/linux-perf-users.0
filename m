Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0830DED0
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278153; cv=none; b=jw8krCIVcDFmifWnzZ7lA1t09VV7DOIEqkdBGR4xCZiuohyJ0FcFK/baluPaoKYeWSM1FNYyUoMURXPSreELYksZ6UqQ58jCn3xMZKKS6tYKeTArvkvfLZtqxwGzVjIIaYkrAQrc+nYpq/XROzVjJEHgJs3n3vmfBsRd5VsMTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278153; c=relaxed/simple;
	bh=bg38aem3dRgxxrk43rqzKKIwQoEWTyq5SDngervhvDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fd+ktIudSsPrdA4XR5AipKUOxLeK6C1zXqAvdzFOGvgYie/Wjp+VT7DJ3M44Ghq+B+CSyFhC7FgCFPZWD/3d/esBWahGWlnLWKsUrf2XyH7dFqYy4Epe8Lr91AirOhVMtJLiOxJF9q4jHMSwIWMM66K+oc8/IiLA8menXAJ91SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SOeUTcy7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOeUTcy7"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30c62861b3bso1789243eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278152; x=1782882952; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ83MloBDVhnVzmNpDfky8cBZjRi2ReFfX/sUYDH8fw=;
        b=SOeUTcy7iEFXF685T6UwDqLqmUyFAYhQolYT5XKZXg8QMmtMjs/VG8ineJ2/sNXQKr
         GARag9Z+Uk1nn62d9FtKwttgfG9tzlwoFUJ7kzv6YhgvsvrwsmP51iM1yzTdWayvQ3G4
         W9nH7UQsSX8ceoMwx1qmPc7PfbeQHbVzVmt/awg/BTCloqLL84d7AkQWfDHze4GRLr4y
         wLbUCcQDgZ3Qor+pwJmnCmgLA2i/RtENN4i6EOKh0+LHX9PojdXsk6HDtXP/WVAbTKyr
         9yKDEVXRaXp/UZ4YVHE608Sv9MQOY7Sxk6LJHPa1ZksCmcIPx8tbbGlBaHnRzttC3oy5
         BObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278152; x=1782882952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ83MloBDVhnVzmNpDfky8cBZjRi2ReFfX/sUYDH8fw=;
        b=bKlsTAryEyssUisqyC3WspLi++4bEWl0FKrE7Kfwd9WFAriPfv+DgzBK1FARkJZV//
         4YPi/+4s00d5TTvg3LSwd/5vAbVS4yzoPD86unbtCzj5zAo2tAdZO0nNnA0+2Jmf2EXA
         5O6I4VNtt1apNYQ215IkYzPcxPSF76AAnuLOxNXAUmEQ45B/gW3+JIrDfUHREe2Z8RNo
         ahMk0Ru75Q/pdVu8VV6EFd8daHf1PCZhEGj5Wk/OYT+h03Do+QdEAvbnmmUmtd2iyAEb
         P8FmYMgLfepKm+b8EI8mjHPimLP0k4fUlLK3iGtwcnG+rR6kgj1sZ0tILhYvjbzP4Jj+
         kycQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhXKF2J3HPt+4sP04uRWiO7jJ9SLaap7nnIxTBaaD3PYKXOqUHgBvi8xQJUY4y99rjM1ZEoNOxxQTp72j4Nuie@vger.kernel.org
X-Gm-Message-State: AOJu0YznJOxsQ2EGO/V/qqhIKQc2kg+iH15mrxxu6+PQwxd1I0+F6mmg
	E3ZrGW5217rkl4jAzd7ok8QZ/nu69ZFqRy5DtsY04g8NECqCEmahCmffTCAW9pUtg52Y3T4EUxz
	EoyTaZMXDWg==
X-Received: from dybvz1.prod.google.com ([2002:a05:7301:7a01:b0:30c:5a76:5abe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4e0c:b0:2ed:e16:6b4a
 with SMTP id 5a478bee46e88-30c1dc8957cmr13537283eec.32.1782278151264; Tue, 23
 Jun 2026 22:15:51 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:22 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-6-irogers@google.com>
Subject: [PATCH v2 04/16] perf python: Fix memory leak in pyrf_evlist__get_pollfd
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a Python list object leak in pyrf_evlist__get_pollfd() by adding
a missing Py_DECREF on the error exit path.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 11e1f39c1bea..550f1e7d1449 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2825,6 +2825,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 	evlist = pevlist->evlist;
 	list = PyList_New(0);
+	if (!list)
+		return NULL;
 
 	for (i = 0; i < evlist__core(evlist)->pollfd.nr; ++i) {
 		PyObject *file;
@@ -2843,6 +2845,7 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 	return list;
 free_list:
+	Py_XDECREF(list);
 	return PyErr_NoMemory();
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

