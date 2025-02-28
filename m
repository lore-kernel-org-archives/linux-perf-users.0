Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD941E0E13
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781454; cv=none; b=I54/1Xnd9XWKGRDnUOV1WWjjpwSE9behYBHbtvVpfE3/V9s2NXjCQoxipP4QmYQI7YzxQeT7uExic00Hh91JF5/bQbhaVLqwT+hA5E5KYk1ETh2hGNM3OIUOA2pR8JC7lGXpgYUGx9+o+LgKVmgj9w5lmOZnToXaeJfqvfTrENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781454; c=relaxed/simple;
	bh=wrht3Ck1Kuq4sobgfeJPBu1XYS24mA6fKpUErZdwyt0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=EMHSSEpBiBnS5HN1nv5uWA/KOuswOZIeU1FTrf/KjBOJwNjHhTPwtZHqgSgmNBfeTfcgQZgQ4mDd9lhG5EYBhhaNU3R21p218isfG7I2GWJpGczHbUzUelXAZDGx14aAypnhzY4aOw5w265pfPlJoLU8e7lo1wNG1ZFGvKyadHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cySwLqlk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cySwLqlk"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2793679ebso30661447b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781452; x=1741386252; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlh6ybn/t9Eio4NDtMpr3RQAX90AF4f82uyAhhltD3A=;
        b=cySwLqlkj5aew/DtHv/aObb7sGos68TjBzav8F25UXieR/XsnETPEhp5QoqV3yn/8Z
         4pxg89LFuJRD3ZLA+udxJ4JLMzjyW/99AMdznwXj5j252zQ8OcQohrlima8yZKD1wfeW
         Cf2rMFCmMZ/ao7eELjUYnlQ0o4JOh1k/J9AGSp6S8Zw6Skdoz9M1aWgMhMRhx0w2CeM2
         Xd9GH10DoTkiWtZakUuvFYGNwi0N7M8iaymVzMWfRhnVHBe425Jw15yGTvSkdktTFX/y
         obJu/TszoQK5vUPInX/xq0Ldlv4an88fOdY2Cy5xlYrJf/3J+qHN3LOGJLHkKJhCdR2Y
         C+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781452; x=1741386252;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlh6ybn/t9Eio4NDtMpr3RQAX90AF4f82uyAhhltD3A=;
        b=U9jpasOBwCYakeKT9yfE57MNB6NvSwi1NReD2X3GHEOk5O1nZklrLAhRtgqjOtpo52
         BO1JjCZnt7abSu9Mqo6ly77/YDgE4cNeBDgIdYSJ0NZbsOmTbu0EpP51V49mdouNxVPi
         jI3z3kdZ2ya/bBa7TVZKEoWk8cf+SV50Db/MBXgn5BiKYhjlCF3MuZPCD19K3qMQn8vP
         WvTslCuyl8ir9z7cy1oVQCcUcLUW+T/OF2PZkdXmjrC4LUItK5mNRAGkQcLS4wf9+PyX
         WUP3/qYVppGqnous9oGW+SobTmImEB0SHRSJbXS56wVaq8lTAZsgkSpby9urQEQ4EdmP
         OTVA==
X-Forwarded-Encrypted: i=1; AJvYcCXRcnRdyXqVt8MSVIO6Hn2Ls23GrV4J4PgIlfPBlPe3s9ahmKyBMUjrymjFURzpWGQGC5IceicgpdW0nrPtXKvB@vger.kernel.org
X-Gm-Message-State: AOJu0YzsgqFWy4+ve2qg287iSppXu+xN4tddvdTznZlmZeJtgQ1aD+Yr
	SB4w/j69YGdXbD9DD/yF640cxIDkiGxRwoM5KflvpZqyTNl0hsqZkk5x1LOdE/Jx/zh+vJ2TeLb
	Nxf+sTg==
X-Google-Smtp-Source: AGHT+IGS9PUiVd2wbpTmw0ubEIttIIVjgmvg2lVbKCLsqMOnkXdig84FL8BYfckMna/3eucCQ4JlVoCn2p+F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:c18:b0:6fb:8461:e7f4 with SMTP id
 00721157ae682-6fd4a0d3b59mr3420887b3.3.1740781451797; Fri, 28 Feb 2025
 14:24:11 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:06 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 09/11] perf python: Add evlist all_cpus accessor
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a means to get the reference counted all_cpus CPU map from an
evlist in its python form.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 7f2513ffe866..c55c8392bc07 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -874,6 +874,16 @@ static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
 	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
 }
 
+static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
+{
+	struct pyrf_cpu_map *pcpu_map = PyObject_New(struct pyrf_cpu_map, &pyrf_cpu_map__type);
+
+	if (pcpu_map)
+		pcpu_map->cpus = perf_cpu_map__get(pevlist->evlist.core.all_cpus);
+
+	return (PyObject *)pcpu_map;
+}
+
 static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
@@ -1057,6 +1067,12 @@ static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
 }
 
 static PyMethodDef pyrf_evlist__methods[] = {
+	{
+		.ml_name  = "all_cpus",
+		.ml_meth  = (PyCFunction)pyrf_evlist__all_cpus,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("CPU map union of all evsel CPU maps.")
+	},
 	{
 		.ml_name  = "mmap",
 		.ml_meth  = (PyCFunction)pyrf_evlist__mmap,
-- 
2.48.1.711.g2feabab25a-goog

