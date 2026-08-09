Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE03AAF61
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259730; cv=none; b=lXQ6qpgbLM1GohpxOUK5rZu4nirPuAQrhtGK355BXUH1srBsbl4tf/EFw/oIoZPPrc61aUNWNTtjZLBueEO542euExJkVJiyBuxRiy+UsgNUR1AtYNxV+/ID/vFwiQoPA7S4nwT7etB8tEh3EpBv6Mpd6uD81gL+nfhytkdoaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259730; c=relaxed/simple;
	bh=8sCG0f5IGimuJ+fsQUifv2/QjLt5UBT/0kf9dJVm/O4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hA9e2Y4puWF025ENvDV59ONe4VUKi1ymhajFFwHE7oksBhMJQ0ZQzW53HDCnbOStDGkm0QLKuVxc9eyEBxDBYiFRkQA4zx0u9C+AyQFM3ngwEPCQIneC7+nsuTjXhrjnUNgG33Obim8fRkr34tO4NOJ7KXewnbmJ8ePIrLNOJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVN6oE1l; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVN6oE1l"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so1136517a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259728; x=1786864528; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=guXh3nj4hXqwhdHJMCtl6P47kx2KJmAnA1aawSbLzyY=;
        b=cVN6oE1lbFOqwbrhrjn+B0zXUw/99ZJlAj0zGEoou/0OWomyS+/JCD51EC9idMiEbl
         qq/lTwR7lhl8+WhfhPyQxg4RGrWF1ADQTmFhRVLdWhG71Ubqg6UEGOlyX0LDM12n14L7
         nxG7qJJD2eYt9b+gBMgH5eB9vtD18Vo2y7/FilOF/De6f2a1FtOjT/PSas0iCqGmDBod
         A+IdyuRCteudpFdhsXZ/5OSIKwIG4GzE/Rq+1guXRG6t0pqjwYJPNpLiJUw076j0Rd76
         eIE92uSCjTwiA+Lp6dPWFMMQCtFN3YseEWTZLAenlqXHp8G+j4FIi1sSBb/91zXZRzAF
         /Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259728; x=1786864528;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guXh3nj4hXqwhdHJMCtl6P47kx2KJmAnA1aawSbLzyY=;
        b=iNVZlnSmLxff0Ew1d0GXQkrQ0VQy5H5YAPsP+ux6i1KSoceSl6R+GU8owZwN/Ie/hU
         VEfjAEgZOPQhzq8nBUzYq8uWZF1Ax6lsl5hEPT0gLhtUHDz1YqxbIJTMOGHENgcaB1bx
         q5XAH8EyHT1CWKEjo5AJt3q96EAAE/y7w6z75YaGPK+XPE/TbONZuCEUogDPTs/Qn32o
         /ymoC4FlyGPvL4sEowwEiEGsQ3oW5WmWf4SOdYu6CY5fZt6KkoITLTe0+bAyQ+LAcEuH
         s+XYt5L8OZbUkn4hHeW5B8Q0PekkjrwRnZGnleQcRi9HBMsGGRcQYoUqv7+Ymxw+bUdi
         odDQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTKVElkci7juTb8PlS6VNrpkabl6bZ7e/Eynv4KRpEV8KHL2tLLlHHt6IPFtVE5zuh3CIJQZG03oyExlgzXT4P@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjnlq26s42Wr4LRpwOa2+/Q7IxiT/K4Il+O6hDKUV3YB6RUtuv
	QnizjrWM9CDrgfPTwZIO1oaVLylrS991GCrDLjHjdNWgORiZmbZo/o03i8SNORvY60WVxertaA5
	U+6gseKbUcg==
X-Received: from dlbtp10.prod.google.com ([2002:a05:7022:3b8a:b0:141:729:41df])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e352:b0:3cb:b3fc:510f
 with SMTP id adf61e73a8af0-3cbb3fc5a0cmr17277123637.24.1786259727722; Sun, 09
 Aug 2026 00:15:27 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:52 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-14-irogers@google.com>
Subject: [PATCH v3 13/15] perf python: Fix count_values memory leak in pyrf_evsel__read
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In pyrf_evsel__read, if PyArg_ParseTuple fails, the allocated count_values
is leaked. Move the allocation of count_values after the PyArg_ParseTuple
call to prevent the memory leak.

Fixes: 739621f65702 ("perf python: Add evsel read method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fe5afce17333..71431c9c2e76 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2210,11 +2210,6 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 
 	CHECK_INITIALIZED(evsel, "evsel");
 
-	count_values = PyObject_New(struct pyrf_counts_values,
-							       &pyrf_counts_values__type);
-	if (!count_values)
-		return NULL;
-
 	if (!PyArg_ParseTuple(args, "ii", &cpu, &thread))
 		return NULL;
 
@@ -2233,6 +2228,10 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 	if (evsel__ensure_counts(evsel))
 		return PyErr_NoMemory();
 
+	count_values = PyObject_New(struct pyrf_counts_values, &pyrf_counts_values__type);
+	if (!count_values)
+		return NULL;
+
 	/* Set up pointers to the old and newly read counter values. */
 	old_count = perf_counts(evsel->prev_raw_counts, cpu_idx, thread_idx);
 	new_count = perf_counts(evsel->counts, cpu_idx, thread_idx);
-- 
2.55.0.679.g6767b8d81c-goog

