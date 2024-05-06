Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798A12C478
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973510; cv=none; b=YACdWXCRFBpW1JuQDyZEsNYExAEzbsl/zc7ZYISCpUMv1STnvuXHLR4gUWfksDeJzmNW4+hm46iJTpb0yf+KOx6TzMVA/YAwIU6S5StHBMtXXW4YiHjklG4BasfOnLJtRUyuEXHRYfD3dodHVdtZ2Fx9gJvjxFHc1Es0sdGHXFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973510; c=relaxed/simple;
	bh=dhPbAFhJ8mb4pBRNt8/QCVsudVnkKq9AnmE8N85GoY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZYQwfpleYsk2+daRN7tsN1QUvdpMnzONdufVgdDV10uay4bsqx6HvWwdXRJT7/SjETBBY73Pj5aprF36Rzj4+QBI80HPx3Fj3ZL3UMBWiLBw6EaroWoisuRJERpyO12ZhAMHgpWSDwd8XtFY7WAg6vkFuPsKMTxvksnofzVEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuirrmSr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuirrmSr"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b34facb83aso2086066a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973509; x=1715578309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LVxcBKJRM/xj/uclatTOhxRt9aaIXTCvWP79vIrkrtA=;
        b=LuirrmSrUJppxWAJY+xa9hoAaZigy6KiINogMv1oY3aIoxIi+oFzxiLDn4IgUE7giQ
         tJ1fmcGvb+Gt9G+5f71+b1C8Q6n7VXJQLxpeJNF6q1UjmeLgiLG+jSBQ544wf7I7vt4b
         +8OUvV1owRf0rtu6krHE3X2xgyhjdFbdMZJucESDqz1MDroZdPNr+ciln0js9jbxTV01
         vbYr37jqVKQtlWdpgA3ot7/PcJY3EPcizKrJfhx+79AsMs6Qnm2Ydtn398eOVCr1ljE+
         iOcZugAj4Y2wpt3USQAzj0Fx63APZ4p3g/nSN9Jq3X6vxhuncC8Z/LH4zgFHQvix2Nyu
         9rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973509; x=1715578309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVxcBKJRM/xj/uclatTOhxRt9aaIXTCvWP79vIrkrtA=;
        b=VnjWmmWpWgvNy/t2Fgco7mX/u8/38DdfiWvhVbgvis6Xiyw0ZFmDm07QmAm74KMw/i
         +9uS7yR9jQnaFDyQ+iOafxeUV6700Fbkn4wb+q/RCul5w8MYv81AQEeiOd5yeV63FcpF
         5ik5GWWYrwnhrYZnk1x0wy/utL+TlDpE+MtBe8YESEY1O0/6jqGdIGZl/I3GFG8wVU3y
         i292myuxwIt3CdOKxVnq0kcdBZj+7ywXocrUigoNnior23n0FtsnAgf54k41TsUFJn+9
         oXLJ2OrMGYgCMVaRDBHHTpKsbeRrx75uaLCdXImjQjyAhLHd8WMOXJVNQovhghIQfLTe
         dDSw==
X-Forwarded-Encrypted: i=1; AJvYcCVTHGLXN1iXHouEG4rjrTk0VhAgVSsp9H8RqlKWPvJNr2eiU51TcGCb79K7QTFJvPHkVzZ1GLoC/ixqm+bu5QgLlQdX+MJPTB+c8aKAKDAsmg==
X-Gm-Message-State: AOJu0YxcsjlYeM8oA5rFYl5baM2z1uiuAcVZ7jXJFGdwbpAce6ZJUdjs
	VTAxytnGibQ4kQllUQbSZp+WJVYTp9AiAn3kpwo3mRbj/tgfxf1ev8VafGK4HAhtWGaWSrSoT+N
	ybnG0lg==
X-Google-Smtp-Source: AGHT+IE172p7cnEMx31yUx6AO1DUrBNNY80Q7d+yV5jnzzruiiQhToxQu7JpPgzaeKwzvvEndWq8+tBOswES
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:bf8b:b0:2a2:ff01:dd7c with SMTP id
 d11-20020a17090abf8b00b002a2ff01dd7cmr26238pjs.8.1714973508675; Sun, 05 May
 2024 22:31:48 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:08 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-44-mizhang@google.com>
Subject: [PATCH v2 43/54] KVM: x86/pmu: Update pmc_{read,write}_counter() to
 disconnect perf API
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update pmc_{read,write}_counter() to disconnect perf API because
passthrough PMU does not use host PMU on backend. Because of that
pmc->counter contains directly the actual value of the guest VM when set by
the host (VMM) side.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/pmu.c | 5 +++++
 arch/x86/kvm/pmu.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 06e70f74559d..12330d3f92f4 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -322,6 +322,11 @@ static void pmc_update_sample_period(struct kvm_pmc *pmc)
 
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
 {
+	if (pmc_to_pmu(pmc)->passthrough) {
+		pmc->counter = val;
+		return;
+	}
+
 	/*
 	 * Drop any unconsumed accumulated counts, the WRMSR is a write, not a
 	 * read-modify-write.  Adjust the counter value so that its value is
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 78a7f0c5f3ba..7e006cb61296 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -116,6 +116,10 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 {
 	u64 counter, enabled, running;
 
+	counter = pmc->counter;
+	if (pmc_to_pmu(pmc)->passthrough)
+		return counter & pmc_bitmask(pmc);
+
 	counter = pmc->counter + pmc->emulated_counter;
 
 	if (pmc->perf_event && !pmc->is_paused)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

