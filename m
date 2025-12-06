Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F221CC79
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980255; cv=none; b=JGXR32nf14EliHmexTfYduWZ6G1le4W69c/ir2EvvXIyKUvyS+rw4qjymQvZur/OT0z5LFoERAqAWekGG/iPWXdOuXt8erXlg33d5m5bTptcGGeGHfXY0aZ9BwOiQAsLTUavWSKW0Zblc6vy20fzts2Nj2o28emBnB95v2CN/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980255; c=relaxed/simple;
	bh=LI1sDcOO4Y4+JFloEIGoQdv+YZQhyxul+6jzUgodhT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iFQop8SordN6kGoPFMOHF6oG6yxx517CeKiO+p+CEp0ogwtCzB8jSysacovN22Rzedyc5o/rFV65gjnrVn1b2aFl6wJlg0gLw0c7tBuLVBJGe29XE/+03zDn6vmVBoaSK5cXt2zf2SbGibNXOIr2f/8SvTmP0BUptNH9Q+qGIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVau5ElV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVau5ElV"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b80de683efso4335340b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980253; x=1765585053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8zDbYh8g4andZgSq5KjxfJP+Yx1X56NwE8CC/T+SiEI=;
        b=pVau5ElVfZwx0/su8cO5Rqh691AFnnWz6RrzYp3Sy65JPI1sKLjj3nW7KYdYWSmgsA
         wqN6uooeeNSfiSWQFYEKWRKU9ZwvgOCJBkSzZIj08kSsx/88FS4ffQzGkIwZoDTYK2fe
         YJIMyGVKJKi5DgVWO1duCxNlrtonrWGH83SxF98yGTP5vVDKUHMvdqQZABZ36WTJ29iL
         RI5r+azoW8h5jtBTj9Xq5a58S16XF3XksydgNWse0hYPABjSLnLJS5pjFaYDr/N18kw3
         ozAvHONmGu+4ouR4dU08quepnzo35TueGFCL97Yv3oFX4i5vB0N70+o+A0xMxMmtCF/0
         Iiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980253; x=1765585053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zDbYh8g4andZgSq5KjxfJP+Yx1X56NwE8CC/T+SiEI=;
        b=bQ5IbT6JrioHUdNRRrSTyKE/mwYapaZmsvty5e5JStvO+enGwsh+bRKYKZrMdJSfe/
         Ew9cyPqksXBkagfF8c7uNSlcq5CiOUyj9JrCtFjbPiVA6M/8avqvsaqcb9R2QXdUshkF
         gGU0rscRjeNwxKU+clSBQ3Is7XWpNo7Eg4xPhtHNGts8nYgrbj83VDNdFPj/ioilT8+m
         RS6+KoSKFfahW5iDZuakCx3oabT9esInyL3vSXdL+UDgTLBmNlq0g2LBbpuLZOkDqWyN
         3p9wpGi4ddF89RShqIpqvjxa6cIf6UCRpuo1oBklkWAu0ZceW7gUAjTaywKduh2NoyGF
         rKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/OjqpNA9FRipPH50gqXW0ElPdpjf0tsdInlX5xK3fbbojPo8FzIVHkfUbI0/ziegdYDUfMR2XCSxQEqqh/igC@vger.kernel.org
X-Gm-Message-State: AOJu0YyLUVNle7tlSNme5d90uGfD1VpelXD7CvFSoLhkPzySt1mOIyJ1
	v4gyxw4rRtelikJTBDVol7dh4kAllnxC6NIYXGrTC8aJNnjkIE+8p3+IU9frMVBl9sxLFlayCjw
	kOY9Ojw==
X-Google-Smtp-Source: AGHT+IF/oM705F739LTH8aiHz6AKpqWGtQrIi8ngNpofrp5S2I+xWIdijTs20meiR96WS9wVH7kHD0C0BxI=
X-Received: from pgce2.prod.google.com ([2002:a05:6a02:1c2:b0:bd0:79b2:aa3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7b23:b0:366:1880:7e06
 with SMTP id adf61e73a8af0-36618807e8dmr621575637.0.1764980252791; Fri, 05
 Dec 2025 16:17:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:16:39 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-4-seanjc@google.com>
Subject: [PATCH v6 03/44] perf: Move security_perf_event_free() call to __free_event()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Xudong Hao <xudong.hao@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the freeing of any security state associated with a perf event from
_free_event() to __free_event(), i.e. invoke security_perf_event_free() in
the error paths for perf_event_alloc().  This will allow adding potential
error paths in perf_event_alloc() that can occur after allocating security
state.

Note, kfree() and thus security_perf_event_free() is a nop if
event->security is NULL, i.e. calling security_perf_event_free() even if
security_perf_event_alloc() fails or is never reached is functionality ok.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1e37ab90b815..e34112df8b31 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5602,6 +5602,8 @@ static void __free_event(struct perf_event *event)
 {
 	struct pmu *pmu = event->pmu;
 
+	security_perf_event_free(event);
+
 	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
 		put_callchain_buffers();
 
@@ -5665,8 +5667,6 @@ static void _free_event(struct perf_event *event)
 
 	unaccount_event(event);
 
-	security_perf_event_free(event);
-
 	if (event->rb) {
 		/*
 		 * Can happen when we close an event with re-directed output.
-- 
2.52.0.223.gf5cc29aaa4-goog

