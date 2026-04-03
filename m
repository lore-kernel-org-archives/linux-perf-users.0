Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B93DC4DD
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248878; cv=none; b=UOwujyPSCJ6iqCmVmmtZtoS+fK1yyUZg2DAdIHp9CbzUkUUdL8eLcSPuL/M7W/Y3WEUjwaWhQqv+3dxDUecCy+dy+j2QxVZpuHKHbue/zJmV5XXRudq45LTCCBfftzXWepEa8MkY6szOjgiAjtRfJGUmLYMft3aycw4dAY28roI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248878; c=relaxed/simple;
	bh=0Keft5t7OBXgX7YaxEhWnWuQSKMAek/Moq2pD9h81W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjOr/9FzhTlNm6THfaq18n5Afk9UQZ9ENc5qj3Ste2Uy2aNYNM51JOFnZJn7ObIvNnOeECtxgV59BrXdbUzrokyqqMI8PYPLUGg6TELHsCDRX6APVOryzwTx9Ac9q6iCSP+iL1+Gb41aKryhNypzRBg/nN+mNY5vQCs/NmL16vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZyep7Zu; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZyep7Zu"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1279caef718so3684389c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248876; x=1775853676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DD9DzZmqkeGtfBm/333ve8pZcjoUvLLGIPaFR8uqSWs=;
        b=CZyep7ZuoiyRsz9hroi7nbo6pv9x9ArKLhMADVMseqOemggOs5YtCmEu24xYmoTGZp
         +o8cECOoizce6MVutEl5/rVQc40zzIpUMG3JidUV/8pCE2tvYyy/LxHZv4/CjjukVya7
         Co/hFFdzvfRe7HSfjGxYQp82nTtRkEXaMvCeVLS6aQfigof8732xHFE7WdLuZqpohl56
         67UPbFwIbsHSX0qysuhLOkTjqtK5EvahlBQ0u9Kc17x7tW4iamkHnDhArmM3kxF4JSll
         bf/gLxBUGPrfAqx3RhOZYNa2CdGSWe6iz93aH+PPTAgXBB4BsQTH+IoEW9l0U3Jbd5xN
         PO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248876; x=1775853676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD9DzZmqkeGtfBm/333ve8pZcjoUvLLGIPaFR8uqSWs=;
        b=Ugt3iu1m0KHivZkqYDiHNJ1UhgdPbHefkpVi9Nx0m8t6MeG4KwmysQTJMWv442kIKU
         bXT5IRTdzvlnE5W4zEa5gxfoWVmmX5GW8Cjkyfcx/m7fl6XEk6iCh+GGOCT3PK1xVpfZ
         TAs5qyhFLNaYVTuZw3zxq/oZjsQuTVD3s+UJJII+D2EsnQH9CsnTVplgy5yQNvF0jJA4
         zx7OBeRL4AjGse1j1a8tHAH+6Wk29EwSunt3RvfqapCv/qZ4jMU7yJ3MdYx56MimSf4e
         ElUOEgfTVhVT9i/IyogbPtA/HBk+wgeljYgWQUMTz9JE8cIvNDLz+TlGH2UZZ2fLF003
         mWyw==
X-Forwarded-Encrypted: i=1; AJvYcCUUsZ8+L43QUNrpAkUqfC6zc1rbzbkU1MT8SmIUTrBVsyuEH0dwhUSpSFPrRKKIsRr3IPeEdt3UGpYWgeEUdTrS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YgtZ4ud2Fr4fzckC38HSW8mDC40Zn+qZ5dNOslIQEYgdaTFj
	DTYZnAUrzf0ISoyfbk5MtHEqMXhBZ1su5i07fP72wNj07wBOskImcLwJMGXbXPv/ARVWPAfcDoI
	CraTzCrHNhw==
X-Received: from dycpq3.prod.google.com ([2002:a05:7301:fd03:b0:2c7:1a46:6250])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6629:b0:12a:6b99:1ad4
 with SMTP id a92af1059eb24-12bfb6fb392mr2091620c88.11.1775248875900; Fri, 03
 Apr 2026 13:41:15 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:14 -0700
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
Message-ID: <20260403204017.2919994-23-irogers@google.com>
Subject: [PATCH v5 22/25] perf evlist: Try to avoid computing evsel from sample
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

If the sample has an evsel, don't recompute using the sample.id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c           | 4 +++-
 tools/perf/tests/mmap-basic.c      | 4 +++-
 tools/perf/tests/switch-tracking.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a66666e89f67..f8bca1cb5769 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1164,7 +1164,9 @@ static int deliver_event(struct ordered_events *qe,
 		goto next_event;
 	}
 
-	evsel = evlist__id2evsel(session->evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..a18d84d858aa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -142,7 +142,9 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		}
 
 		err = -1;
-		evsel = evlist__id2evsel(evlist, sample.id);
+		evsel = sample.evsel;
+		if (!evsel)
+			evsel = evlist__id2evsel(evlist, sample.id);
 		perf_sample__exit(&sample);
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 22b0302252db..e32331fee277 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -138,7 +138,10 @@ static int process_sample_event(struct evlist *evlist,
 		goto out;
 	}
 
-	evsel = evlist__id2evsel(evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(evlist, sample.id);
+
 	if (evsel == switch_tracking->switch_evsel) {
 		next_tid = perf_sample__intval(&sample, "next_pid");
 		prev_tid = perf_sample__intval(&sample, "prev_pid");
-- 
2.53.0.1213.gd9a14994de-goog

