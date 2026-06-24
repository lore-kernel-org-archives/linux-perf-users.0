Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1F319617
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278162; cv=none; b=OMGFcBhJBHCKa0iZtoGZasJEhk4jwyzKMCAvRqxsfzwBgFRfa9EukMAzl3xPKaqk2jPzqFZUTEkoIZtM5tNvD67c7IGl8Oou6V0f3TnC7bSVrq8I6vXG7rsNJxSMRnKb5ABgbu7AIlWrI1Tx8qRjCeHbtCyCGc/aIagMhyqcTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278162; c=relaxed/simple;
	bh=UOPyw+KH82bKmrT2wWo9qGlEDVIgKSYCQGuMNkhlRvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GujSfBCKfNfqptYSdV78P7iHcDhSlZeBWV86PWYkekVgc+cPVgymsuRccBOcHGQgiGH5JOrVPi+VsR2uX3aVY4ISDbzd+yzpjgf1/ikmukC5bGNCV3HhjYo/aqEPyojGutr2pE1FULiGhiL7ByPI0EMYJOILKHDQ0B6Aqi0gFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hU+nbVll; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hU+nbVll"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1383723dfddso1390033c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278161; x=1782882961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6IRXsGh6mE2mlJalCaM/DVcdrY6wWm8wNEi8wIAtoCA=;
        b=hU+nbVllhdUfY/THHOUAu0nTkceclfDhkke+y79iWurnQtCRNqozgcOGGltjtezu+b
         0JG4JqgwKx7StGrYkvdR8EvTHFEjgmuimkqk7AqP7yCm93rtghUYJlPB49qUYCf5/tAq
         e2NtOoKD9Alti0kiAFqusPriJve8Wk2Vr4mSPXHAxAwfLbISUHbKfEfUlLRJ91FWYYAF
         lNCn46WYzUkNgCW4aN2rfNkt8Wj5SNtNHYZyjQpKK70Rs3ivIKsjO13Tu5RwOuoex002
         5pdlAKB3i3i9dGWNvLgkWlY5idac2QZlSp3VHcefTO3ny3njiNChoPZVRQdyMTs0Btwt
         Q4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278161; x=1782882961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IRXsGh6mE2mlJalCaM/DVcdrY6wWm8wNEi8wIAtoCA=;
        b=GbhR168/TfWBHZ7SZwAaBH4fnHg2clH59kBTluKtmEde7Rzn3quSbMLA9nvsHRoQAn
         q9Yj+rc8Gg9hpR0uLaLgtSPFTE7i5dN2RVD1IcPhRClhny2GsiFLz+7G9Nj8AdTPGgJG
         Yu2jdzE8Lcbx7Le/lqb+037fYqmMN58RQ0RfX+qWHIf/CfOv9WVwvR0RlG8vdvAIb3e+
         xr/Dl4lTwi79iy9dV0Lg6r8MN159x5dm+tauFXzjdrqo6OSD+vMGYkxLO2pzPd33OqF3
         QcptEvnp2VBJ4jNHZLdfY10pFNjxmmJtJGWHByBZV2hiP6vpC2K9cJRl0Wi9KfwZJYWg
         K1oA==
X-Forwarded-Encrypted: i=1; AFNElJ+hXoAZW9rnJxrpVyKdnaVl4tqmLwEVGd6JAL7fjchIkuSB4nE+oXQqaJK8NFxwqUSImONscC7epq1Kz9rbsg7C@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIgFGQSacQB0JpXJY+m8U8pfSyMf8qYPJqA4FB2DS/GRSBqgS
	qcuP65i46wtuLm+ALHwe+LKwxAfg6J61enwCm1zv2gVUYJGNbCDPJ5qK/D3BjgN9r1gI3Nm/7nl
	xXud+1DupZQ==
X-Received: from dloo19.prod.google.com ([2002:a05:7023:a53:b0:139:c655:b2de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2386:b0:135:dd7c:7
 with SMTP id a92af1059eb24-139d0cf5943mr1595479c88.38.1782278160052; Tue, 23
 Jun 2026 22:16:00 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:26 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-10-irogers@google.com>
Subject: [PATCH v2 08/16] perf python: Check counts_values size in set_values
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The set_values function incorrectly assumed the list contained exactly
5 elements. Add a check to prevent out-of-bounds access.

Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 550f1e7d1449..c6c729808a0f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1881,11 +1881,11 @@ static void pyrf_counts_values__delete(struct pyrf_counts_values *pcounts_values
 	  0, help }
 
 static PyMemberDef pyrf_counts_values_members[] = {
-	counts_values_member_def(val, T_ULONG, "Value of event"),
-	counts_values_member_def(ena, T_ULONG, "Time for which enabled"),
-	counts_values_member_def(run, T_ULONG, "Time for which running"),
-	counts_values_member_def(id, T_ULONG, "Unique ID for an event"),
-	counts_values_member_def(lost, T_ULONG, "Num of lost samples"),
+	counts_values_member_def(val, T_ULONGLONG, "Value of event"),
+	counts_values_member_def(ena, T_ULONGLONG, "Time for which enabled"),
+	counts_values_member_def(run, T_ULONGLONG, "Time for which running"),
+	counts_values_member_def(id, T_ULONGLONG, "Unique ID for an event"),
+	counts_values_member_def(lost, T_ULONGLONG, "Num of lost samples"),
 	{ .name = NULL, },
 };
 
@@ -1895,8 +1895,15 @@ static PyObject *pyrf_counts_values_get_values(struct pyrf_counts_values *self,
 
 	if (!vals)
 		return NULL;
-	for (int i = 0; i < 5; i++)
-		PyList_SetItem(vals, i, PyLong_FromLong(self->values.values[i]));
+	for (int i = 0; i < 5; i++) {
+		PyObject *val = PyLong_FromUnsignedLongLong(self->values.values[i]);
+
+		if (!val) {
+			Py_DECREF(vals);
+			return NULL;
+		}
+		PyList_SetItem(vals, i, val);
+	}
 
 	return vals;
 }
@@ -1913,13 +1920,23 @@ static int pyrf_counts_values_set_values(struct pyrf_counts_values *self, PyObje
 	}
 
 	size = PyList_Size(list);
+	if (size != 5) {
+		PyErr_SetString(PyExc_ValueError, "List must have exactly 5 entries");
+		return -1;
+	}
+
 	for (Py_ssize_t i = 0; i < size; i++) {
+		unsigned long long val;
+
 		item = PyList_GetItem(list, i);
 		if (!PyLong_Check(item)) {
 			PyErr_SetString(PyExc_TypeError, "List members should be numbers");
 			return -1;
 		}
-		self->values.values[i] = PyLong_AsLong(item);
+		val = PyLong_AsUnsignedLongLong(item);
+		if (val == (unsigned long long)-1 && PyErr_Occurred())
+			return -1;
+		self->values.values[i] = val;
 	}
 
 	return 0;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

