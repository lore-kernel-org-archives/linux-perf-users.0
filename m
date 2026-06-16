Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57763890E5
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572592; cv=none; b=bMkCQoFzgw/HqMrm7Szyb4kiU6lY0fThmHR6uUddQXkNzvED8bTyFNcmQRgwLPD42DQJAXjGuLiW0s5/bPEDMcZLdb50cG73ilpXu0fMW2TQc8mjsT/kBLohjtApxO1KINvNM1BuEqu4xKPnDnuslz732l1nYF/RsoDLm+yNpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572592; c=relaxed/simple;
	bh=zlKNDRleksEo18Bo4F5pa1gJEu8ZpW4kHFgmWSCc7ho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eWt42N5KsBGPMNiCm829mnLJ2d9rDinFVK5hN8P6YGc7C7aIqB+ciBevogznAn9mpRnGK3Jq8/M+7SR1XqqbYnm43BnIxZjadYpaSUyApyVtQS51haGZVtnX1TKWuhqpK0FuAH+lQbSUR5Mlp2ZjKq719GNfqOQg5OKB2Tyt8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F6X91Oxj; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F6X91Oxj"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ed777a96so2626945eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572590; x=1782177390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCuiJ7cpJrvvup1SmgZEXA/C64pNGqrjRmbjWW0EDWo=;
        b=F6X91OxjsYCogNbfYbAlr5DM9FlNz+DPqEyYsN/A769lIcNHUd2bNUtRQ+Oqo8OJmo
         86Yo+i24/iyjc7RweC0s3A/BqAXQFkWDmsueJu6cNcEWyqJGeRbrZC6lZYciBzu7CEf1
         z8fmKObPMwW0STsapPt+HmhZiBiWpwazXtGeW2aaAFIowd6hZe3uEatNUieX9QqJyPie
         95fSFoHML0cDDdz8Z4zchZ0rKu4uA+wQe4QjNblFMmdjLdM8gymbw1u1NwbOHXTmHVrX
         7a6H/naNGzqvbcJD+cXbT6LBsIO8RAuRezklBmq44dRf4Kac8Exjj0D41rYNJwZRKzwo
         xLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572590; x=1782177390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCuiJ7cpJrvvup1SmgZEXA/C64pNGqrjRmbjWW0EDWo=;
        b=eotGKDioDCgF+ah5M/1/zeWkrkUexiw/p4yIYgnQ2efZliX6Pla8nn4H/G0yA5yf6+
         BeoZU7LZvlOhzR4nQAxhlwUojGIL716cxknjeHtctWkdJA3mX/LETAtySA74e1UGztBy
         Mv7tZFdOqib8W5M8sWH0jvQsjKH8045NIHQh4bCsXzI8kjT0jQidTMCJzkt2uM2nxnvr
         g/DRHacmCssb2Xez/LPvewb3QBjbq931w2mhERm8mXYccC4hOf/dwdhw6OAn46eTnBGN
         BUqQLVoH4Qmu2iAbVyoqwOC+9HFJfcQSV07ve2NJlFV01oTw0KKin2ETZ3Nw6iBUfkNE
         KsXw==
X-Forwarded-Encrypted: i=1; AFNElJ8M3oMDZWSnopgkUCXEzX2TuVecJhm/O0HWTh1Q/2MUKoyGSkJQNIuBEsU9oPG4lOThVHEODrknKe/cjNmXmeJY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/YOQwUbaMBunE0oqWeungO2xYPqzyaLynRooDUc6zuaFzYNNu
	oa8oMtC/eNzk/+LDIdv9DBq99r1vorf41JgRl6zHb7Krep0eGlvEgkphvAU9SwCsqJ+9n+rgSEf
	vqEKkU6o0Bg==
X-Received: from dyclv10.prod.google.com ([2002:a05:7301:618a:b0:2f7:9a2b:1dba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8615:b0:2c6:67b6:3acc
 with SMTP id 5a478bee46e88-30ba3961dc5mr981586eec.15.1781572589763; Mon, 15
 Jun 2026 18:16:29 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:41 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-20-irogers@google.com>
Subject: [PATCH v21 19/21] perf python: Add type checking for parse_events/parse_metrics
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The threads and cpus parameters in parse_events and parse_metrics
are parsed with the 'O' format specifier but blindly casted in the
C extension. If a user passes an invalid object type, this leads to
memory corruption when dereferencing the expected struct.

Add runtime PyObject_TypeCheck validations in python.c to safely
raise a TypeError if an invalid object is passed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4ec5a91d45c0..11e1f39c1bea 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3341,6 +3341,20 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
+	if (pthreads && pthreads != Py_None &&
+	    !PyObject_TypeCheck(pthreads, &pyrf_thread_map__type)) {
+		PyErr_SetString(PyExc_TypeError, "threads must be a perf.thread_map or None");
+		evlist__put(evlist);
+		return NULL;
+	}
+
+	if (pcpus && pcpus != Py_None &&
+	    !PyObject_TypeCheck(pcpus, &pyrf_cpu_map__type)) {
+		PyErr_SetString(PyExc_TypeError, "cpus must be a perf.cpu_map or None");
+		evlist__put(evlist);
+		return NULL;
+	}
+
 	threads = (pthreads && pthreads != Py_None) ?
 			((struct pyrf_thread_map *)pthreads)->threads : NULL;
 	cpus = (pcpus && pcpus != Py_None) ?
@@ -3377,6 +3391,20 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 		return NULL;
 	}
 
+	if (pthreads && pthreads != Py_None &&
+	    !PyObject_TypeCheck(pthreads, &pyrf_thread_map__type)) {
+		PyErr_SetString(PyExc_TypeError, "threads must be a perf.thread_map or None");
+		evlist__put(evlist);
+		return NULL;
+	}
+
+	if (pcpus && pcpus != Py_None &&
+	    !PyObject_TypeCheck(pcpus, &pyrf_cpu_map__type)) {
+		PyErr_SetString(PyExc_TypeError, "cpus must be a perf.cpu_map or None");
+		evlist__put(evlist);
+		return NULL;
+	}
+
 	threads = (pthreads && pthreads != Py_None) ?
 			((struct pyrf_thread_map *)pthreads)->threads : NULL;
 	cpus = (pcpus && pcpus != Py_None) ?
-- 
2.54.0.1136.gdb2ca164c4-goog

