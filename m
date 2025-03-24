Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75E2676C4
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837595; cv=none; b=rhnzCLVsXWtZa74ATGyUmpFR1pnvOlHChHcEaHSYosCaGKpA2IUFr4kaEP/qhLseoMBRB7dVjUKt36rh1ubIM3iKpCvZdhf97UOjEd4Jdp2U5j/irapNS5rQ2AgFw3+zcT69Kqsj1gLeWnRdyxkH5dmN9kYN+C9cq8LCN0VUUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837595; c=relaxed/simple;
	bh=xgxYVwZdjRquH478VTURKv/ZwPIL/P+KKLaH5KZ8A0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XIpVW6xU4W56izVl3tUxp6ILLUOM8nKqo6V7dVUsN1z7Fv6ADSmfQKV8YrsrRqnSJGlUJuA9wd+TydAoj09Hsne96jtD12p67E8mk5VEmPesO8YfMT8bgoHaw+I7lD3dtCV6sMJXFsNTIQyydoK1ID4Sx+A7rhxvE6Va2vQCKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYMaB95W; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYMaB95W"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032ea03448so3599322a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837593; x=1743442393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5OIbd6+hOx7hGMg1T3kEmCwLM9O3N837RBR3OmTqUzg=;
        b=rYMaB95WbcGG1k1CIUlndOliRt3vEQHamyedYYykG3bBU06zS++5geWA6MOkt8RXt9
         lkbnjL2bSVN6B/BC3+aK7K3blAFEj6CqsBVcB3h1fs9qPCkNxQ91sTElP01qBuwLYXNQ
         yzYDKNEuKRlpnWnFYqXC5o9gnAPLS9O07+trxq6t9OEwf4rfxNypDdLhTrsd/eqP/w9w
         LwTEObju00+w2nVTEpsdGy87/Iguz0oT/XNS5GqIoSQdqQfO8mDy03KH1WLCBmA0ShF6
         y0AtHmvptkceRfwIru9D9bbQ9dzqC57CzAd8/II/4CqO2BQgn4pPsHpBszqLeV7OISRl
         VyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837593; x=1743442393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OIbd6+hOx7hGMg1T3kEmCwLM9O3N837RBR3OmTqUzg=;
        b=mFJKcgUCMcfqmZ5VmTJy+IsERDOHjMzIMH9Smi1AaejoIUfq40YgsuR+TGAyh35UtT
         C8sHOIkR8gYHXxQZV7L1GBCF13/0Tf11tvS7f+IBHwGNWqa1jzK4eAXDxIIL0qMS22Kp
         nbiVfoJ+BKoYPflylHdTHUmIbhN30NyA4TpKjMdQqPZkJRnJQfP7P0iJjfr5jkplsBKR
         C7WHfi+EbWHghivujgFN/EA4ulkyHULpoR4vhnCE9r4pQDFaKLo+X2Ec927Bm0Et0Uwb
         y0jIDBdy1TNUvYuNGTCBNUiZET0R9b5anXSWkmzw0MGlD3YHhGdajWm9xq01M9IHFC0l
         84JA==
X-Forwarded-Encrypted: i=1; AJvYcCXyHmwW3BA58VSGfVcSVHbuwJ2iZldvQOwnz/t9mB/pWTPaCSVUVt1MHYJg0yEQHuPaZ98gjjuo2I0H7Y34smh2@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGZeOHnpmpT1fd+knmih2OOkFK+4nFIBgpUM2yaVOUxq9m81F
	soe4rCnQzWhJccd5G8RXVkCR0eplN+5/3RUA7tROQUk/Za9cwPsBde9/iTfh6W+4huR+MNGa7hC
	DMAW4jg==
X-Google-Smtp-Source: AGHT+IEdo7ypzX77GetTJ9C36fdgW9oGowukok+4d1hBh9wD+ALdjl7qpWu1TMmZXtF4P0hSuyHVg9HGlwBC
X-Received: from pjc7.prod.google.com ([2002:a17:90b:2f47:b0:2f9:e05f:187f])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b10:b0:2ff:796b:4d05
 with SMTP id 98e67ed59e1d1-3030fea7630mr23371014a91.11.1742837593268; Mon, 24
 Mar 2025 10:33:13 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:53 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-14-mizhang@google.com>
Subject: [PATCH v4 13/38] perf/x86/core: Plumb mediated PMU capability from
 x86_pmu to x86_pmu_cap
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

Plumb mediated PMU capability to x86_pmu_cap in order to let any kernel
entity such as KVM know that host PMU support mediated PMU mode and has
the implementation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7c852ee3e217..7a792486d9fb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3112,6 +3112,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
+	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
 }
 EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0ba8d20f2d1d..3aee76f3316c 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -285,6 +285,7 @@ struct x86_pmu_capability {
 	unsigned int	events_mask;
 	int		events_mask_len;
 	unsigned int	pebs_ept	:1;
+	unsigned int	mediated	:1;
 };
 
 /*
-- 
2.49.0.395.g12beb8f557-goog

