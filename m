Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822D3A6F03
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625049; cv=none; b=OWX+Z37/oltm7rdXw0D2s1HKwu5mHOinZEf+UbpN2J4xTGPO6+R56X4erucfE3pWyFwNb5lJ5nMq0WHWpzgFQxNgDn6hxjpEPBU/79pIGYOF9Z2PDjQMhQtoGAhDX8d4kQmPJqBgN5z2O4sNi5+w88luf0ekVTFOiM7ShCqyN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625049; c=relaxed/simple;
	bh=7Jyb2PFx+FfpOpSI1HT3K9OrNlnZzdi8VOvRSrC1DXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c4j1dhStC2IgdqO1h6gO14C+DhykYXmXt+9BADzbblTodFijzKK1jXD8suukD0TmXkiVWOKbTNQBYdrwTmf4NyCJpcDdDGqJxrWPr54/ZFG3BiAemcaQyP+8JSoaj13kN9ay3jDzpZwF/rugEfk+7yGJ+MAduDEfbIkVPLTlCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BOnbGzn4; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOnbGzn4"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so6228745eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625043; x=1779229843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rzlwMe38tA2SDejBHIyJwujRkrn+4N0IrFXWbAE324=;
        b=BOnbGzn4+CC4L3D81vwJCXiC73Ttz8DUFtk6+v6YEjNpCaGI8ZChvOuWd3M2SnELFE
         vOhpXZP7WvFd2+WPbwSqjOdIE+aLOwkiGtYZ63kPFLHgvmGWwPJ8SdIVEHf/GuHzdv1u
         5XHw2xk32cdef4h/WfGjjjoGa2PiR5tSfQ16taHgMHzjubVkjQIctI8mtyVyb314v73F
         YXtDLgWX0qvCfU7iI4DiySZAPPzgjcmM5lLEUYY4r/g5M/vAlpONI5DqHwVk1aPFfp1f
         cb6WRxk0OueEQVB8vziIhPyQvBjl2LuW+/Deq7961stM9LI7ael+fA0UDFdT8765mygs
         nzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625043; x=1779229843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rzlwMe38tA2SDejBHIyJwujRkrn+4N0IrFXWbAE324=;
        b=NCMzme3+pYnK/qM0gvdoNiAv0n/2vjusC5aJbJihuaNZngbJDkRFnUFvVgLuWi30kL
         PUfSUA4EJ2AQKzIqYvR1kOKduFOik0Ml3KJOR1v5F2vIUC38WLUMWf9ThYGgJ1nd71zL
         /ofNDI2KhUDOXQFqmsvIWeR06Ysy4S6JP3vLhHsHmTEFZGfVaaugrBsgPmoacoQtQX4M
         2asK4TEClR18wGUC4evtpB/qtGuqrHpRhNjJpd8a4S2yzV1MWoxRw+qROfFIcKHHxFr7
         FPDkGypW8c9R6PwAWHTx5WhZgHRS89K2+uhSbZ1ZLZ1j+CyyXx6rUW7Z5OjzBCfo6I6B
         iAng==
X-Forwarded-Encrypted: i=1; AFNElJ/55rfflrfUnl/vKaJaa40Xc/ZvUzafPH7JsFiFGOLu4d74vktv3rZAiAuA25doe+UoFVRGMa101dmqjEA2SROg@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBV6RcXAqEoCWR+bKnPofhP2CUzJYwJk0z1fQWN6UVk/GBfKL
	du/EmSMhttJ8uzLhHl8azvXprPq0LEiO0e5jvXn6UOCV5td7KtP4e8EiyQtzV51fnePF6nDM0Vd
	Fmps8PB7Krg==
X-Received: from dlber14.prod.google.com ([2002:a05:7022:264e:b0:12d:b65b:1fb3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f68e:b0:12a:94ab:e20
 with SMTP id a92af1059eb24-134369910acmr511461c88.20.1778625042822; Tue, 12
 May 2026 15:30:42 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:39 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-11-irogers@google.com>
Subject: [PATCH v13 10/32] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ff7117c5470f..3deb21f4d781 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -788,9 +788,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 				    struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 
-	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
 		u32 count = event->lost_samples.lost;
-- 
2.54.0.563.g4f69b47b94-goog

