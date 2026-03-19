Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9C40F8D8
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962674; cv=none; b=hwWh/jmp+meLGtw5gewgGEnszrxl+OODDhG4gWRnz7yFgQuOP9UAGmsRMezR0/hRpoUV58steu5ha/9luBQsmSK3K2afZetXHkIgNsopuCd6k9OnXUwKa17DzCRRDp2EkYrBYFeLA76c/itc7Oyfb6m4MpYWgifXLuebhWCWqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962674; c=relaxed/simple;
	bh=VBRBWOOsTuUZUQAm9Xp4jFDUX44iF/hvvynPgGnEBf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7s0Zk8wKBPKK9IBpynqFvPR6J6BQqbvFem5RLc1fjgM6yLFBIQahVKtYZ1a8voqC2jfJ/6TTSldXUetrzDXTNGQyE4NpXB+s70KWBnk9HMs8hXJGFih0BSzixhcSO/CjNl2/1GDevAZ37DmkYmcjliktfiPXAVENpuNTNOthJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFnesHFp; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFnesHFp"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128d285d6c3so74935c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962672; x=1774567472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex7esaiGl8GWNlFO/kP2nPhlftSsne7shuQzPr/LD2Y=;
        b=pFnesHFpc4re5JSDwoSd8VvdbF7AXgxGBEGC4BImK25y//YBz0HsgAUQ0eCGyCTAM8
         2XPm+S1cj3Ln907/uTeGCKhxt1nAN7NVjE7oWvfwjNC5TyfCD29DgfH40MS4rOaSnlR/
         wlk8vskhlESOUhbZwXr1ia11I/zSfYuhjjytl90MdNMEwItGT7X4QY9LHls6tx0HS7Gl
         ZR+dTF5uhfosDoGHXX+76a0Xfat4zYKWZc5ENEDbrHh8YWAUE3mmMjfP2DfO3BrrrC1h
         TuVPUt7CoNgPNeDn8BVzcByjxiyAN8uN9VN3xXhs2YxGByU7CMKVsz3bXKgrH1pLVNPM
         EcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962672; x=1774567472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex7esaiGl8GWNlFO/kP2nPhlftSsne7shuQzPr/LD2Y=;
        b=JT9msYoFmVCdl16zhmEnt/imYirbsqBWqoOLhrfRcZ7yqQAU4OTUlvYUw1HyAjgskV
         aKIMocX+y+KX5jpM5IAqGlBiJh1J1sdtpB7a2W9lcRZX9C6IkFBDQ7p8IH3hc7RH8+SU
         tbshpp/zNqFvegPKYa8Z+EB4F9SXOGldp0t0ekiaYDJB3p+Z/pF9v8ipYRVT4gosKTNX
         g4/O+CeLflQ612kTTt6q4xpXQga5PrE3oX6jGPWCklbAsW0mRgLwMqxoBYiMApLmBCwD
         eN0n2n53qABAYZOt71aRUmpNHQjDGdI3D2n8+vDJK9lHytH1nRYmfITFKZb/WJfNE7vV
         zTlA==
X-Forwarded-Encrypted: i=1; AJvYcCXCJ++NGZNaeyWMWk0AnUYNJdCpC00nMgzE+4WGeZKjDeFc7CrzhnjTEi6hgQbt5ixtKxhgFyEAhJEiX1JidhKz@vger.kernel.org
X-Gm-Message-State: AOJu0YwBazg17b/8IL1BTZF570pw0ZsKhpiMMUNa700/qExesyO3DRew
	1nQbLSwq3tmbNmBgu98NXbsXdHwHajQLvVPjqnXdULd9UOCmoTw9LOd6lnO//XNraTObpQ2H2Td
	VQ7zVM2Pg6w==
X-Received: from dlaj22.prod.google.com ([2002:a05:701b:2816:b0:128:dd08:f36b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b83:b0:128:c77a:6c8e
 with SMTP id a92af1059eb24-12a726f5a21mr398186c88.28.1773962672083; Thu, 19
 Mar 2026 16:24:32 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:23 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-15-irogers@google.com>
Subject: [PATCH v2 14/25] perf report: Directly use sample->evsel to avoid
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
2.53.0.959.g497ff81fa9-goog

