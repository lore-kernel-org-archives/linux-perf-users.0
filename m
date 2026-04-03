Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B163D9022
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248859; cv=none; b=liWh4gDmsMTr4MaNmaNouT0BOaa203GDdCx8OdXWMU6qaF3HgQwbOgUOUYPLsbK2nOegTaawvAka05ttl6vGlQ8XkVO5or2EtLYqwZc1KuUWO41q4TkwmPud/ySI56cdaI2Kd+6lLTp9xlgGfCTgo+yKLCmECxURTMxCX1xjg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248859; c=relaxed/simple;
	bh=JgM+52mZfp1KpJI7qRA2MZX5dCKkv3vx+FbrM+Xh2Vk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BItL3Y3eYDp0BTRncBAyr2biMVxPcBMeu+t+EMnsvjPOkXgN5tWCbwj4XorsjlKEmbgPt5UwQoBqdeQpdClTxHg9R0zq4TDrjpXZC6Y4jNDE4TRtPJvGc4CxK1YMoB+UxdJcbSFNb2Fv/CY+36jOECaI3nEA4lcwEpczKOqNxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8jm58Mn; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8jm58Mn"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c895e7de52so7077209eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248857; x=1775853657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JpZYRI0yfE+caWiHFk758a3ExOIBuBQsAJlndyijH0=;
        b=A8jm58MnDeg0oeaZ5O+pQ94XVCuHYOKjQpvrw4MOXUWr1eIgNnFs9t3M3G0H9QtEIJ
         I6nqZ8VjOf8/lI9R+3A6nxl8cKAGr4hJAbE2MaxXQqU68XgFq3UfjPuWvTVQPQEZ3oD/
         qrUFs2zxDwl+0OxnA9pRJ9ZErDiOYhn8bqoEQLmHFH0NHnxvH3c2gsBq4cvp0xGIxqW2
         lEo6zk+iWYZZNqtuCtdf67Wmjg/8r6ONXeTnNtnBrp4Ytn79zKWx15yb+7rZzSj1RPDv
         58h18Ahs9cEXJrtdv8amYozMqXONoPeszZganeYaQvvxOyjzymQPhRBci257WrKQlOgE
         4MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248857; x=1775853657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JpZYRI0yfE+caWiHFk758a3ExOIBuBQsAJlndyijH0=;
        b=OTtoj3Vur0xYryu9M608hZax3UntXWFWH7n2zBdHUppc9QejOTunh/LiMqYraweFs5
         PV+uaOFx3l5OHEQYDIQa+fQmtWv8i145+gC2DWRQxVlaiZaJyvLazkaROIblank+OyTz
         aQJ+R4++D82zx7z8lq1Ec4S5GGVzWMpmHjdXycVGXXCXbsbZPcRzuG5h8xMmsbf4YNVk
         6uIS9vLSrkSzH1mCCvKyJTZSPhQy8Of/BEssa7+y3WIIJFAgrDl2sAyWPNUShJOIBX78
         J4jbn27ScYHHK5FyysSireWek20NISmbOxEoeIiCqJ5glyfU1IjPOHLRHjC+kcXgPuzq
         CrLw==
X-Forwarded-Encrypted: i=1; AJvYcCUvhaOduZcClZkfd6hribOvzs3W6sMlN49bA6HWqk1ZCZG+ctbKSq/Vj8uBsZi8diX5bJBLOGMw1XB0lKWHgVua@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9pDVEdUdqGzGfo5nAoBRQgz+YbKNNQHnPX39h3j3n0VVMl4j
	LEYOi62LT7QeuVQVug+EbqoPgHRAb0Q68ECpyWX8Lpzv2Gss0HO9f5LteV6gBerJ/7bNeeWAHid
	+2Ga+RvMdEA==
X-Received: from dybb26.prod.google.com ([2002:a05:693c:609a:b0:2c4:e587:8597])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4090:b0:2c0:becb:7640
 with SMTP id 5a478bee46e88-2cbfa9b364amr2115953eec.12.1775248856697; Fri, 03
 Apr 2026 13:40:56 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:06 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-15-irogers@google.com>
Subject: [PATCH v5 14/25] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
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
index 1051d7b75361..d53aa7a94192 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -793,9 +793,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
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
2.53.0.1213.gd9a14994de-goog

