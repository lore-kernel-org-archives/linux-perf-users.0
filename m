Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7C2BE7B0
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510257; cv=none; b=lLuDo9EsXZMgRv5MeCpN4PkMe31zZ6NR19/8Ywf3XOPDX96WeYyoylq8wBapnhCRGNoiBo9Zy273SGeIAdr3DItEqtCZyZhgZnEEVtLbKpkMhEEh8/wgI7dTRYeifWdV5LgFpkPSAbyfUcQIy8FS1IrtLkYipvBWz6jrsvy/2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510257; c=relaxed/simple;
	bh=tS0WmC5r+kmTtxkhhYKlXDU+egOc68kS1ctzXr8LOA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nFu5u8AAIzEg0tYQnaKQ1fDzS6bRImGsNldt+zIdFDI2S/PBE0FgdIY27LZGCcRsjc8ZiA4WpYo1FzDZ7sbcM1YcisCa+LDmv1i+x394aZVNPcz4dREuUsfQX4tI7lDwKFcunazZVLgzXaoYkB3YcnjNubF5JfxKNF9GHOYTpRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CcqyyqZT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcqyyqZT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3f71e509d6so259005a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510254; x=1755115054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tP9GWyHDKyhyNham1AJeXmzoVBEhNFAEzN5Uklpk9I0=;
        b=CcqyyqZTQ9+tu9RFgIsmhK8g25sm1T5DiiFL+2GVwNSk1syEvZSf6LdcDIqXgOvI41
         gQNYjs1UElWpwcKrpQnRV0alfOEx8/MHN4ilTPUYO+bCnxFXUy6TORaL3IytBor011yJ
         SFPcNAoXHsE51QXzOkrfgJhinKbMsfCLFNJBEzup9ttMWtu2rVjcdDXUHw9IZfNOHCrn
         EEwrVOklD2vysXLvc6jZM2RUEd71y6yZsUEfBkk+xXpnhQm+++9FWk00CnLwhxk/qLLL
         pkWA/vG3zqUcofDwL1dD4nWTtxnZUMm2Eg8hJIFeXfLpURozsDlQj4h5tbpD6XmN+IhV
         YpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510254; x=1755115054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tP9GWyHDKyhyNham1AJeXmzoVBEhNFAEzN5Uklpk9I0=;
        b=FAOJJrilIIqrK+OkrqXwnxOsKapsdZW4bXd6DlrYgwqBnDQEqvPQgp+QYCJO6inVcG
         UHQ63DKv3zNV+Ak9rblwcKbRyJuKay+9XHU0SsoOAs45WyJu/FJpxATT4PARoz2imk+6
         15tlApZDFB4ijNmoy4ngAjmThOSMxbsly8SrEiQWOrOeqiy0AEYEp/RVRfn+4tANXUpa
         1RtM5izjqBkGudRlz48Gpuj7irC5NHKmINgiLw8XwPCAONZ4X5Yo3GKaTnVvfE3n3YWZ
         Txe8+H3cSaOAOjcxxshtArz/MJ0/+L6/lDuHcqn4wV3Nkguj1knWsS62qGBhdoFMQJuA
         RmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWauU6vNz9mJscrfcRsyXzhSU9KM+6Q38RVvDtnPP6CJD4pjsA5JX2ylLGpeAY5tYrtIXU8M9N/JwDDiH2fSriJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxrexVfC4Q7Ctkg8Rs4XjoW+QSLCadHcJuwEtd8hszaRgb26lMH
	cJBvKdUgpatNDjUFU3d3boJd7iRRml7yqiA4xgsOHElnnWrbMOrkAy9uv3Y6oRx+Me9JQu7/UR9
	Rtt/qmg==
X-Google-Smtp-Source: AGHT+IE0CEB3xtAs9hI54+H7B1IyMBLcepknW0FCY+2mxv/eXxKsKgLhnBmg0Z6EMAhWWlTkD97yQMZQQo8=
X-Received: from pgg21.prod.google.com ([2002:a05:6a02:4d95:b0:b42:3ec5:d919])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5493:b0:220:aea6:2154
 with SMTP id adf61e73a8af0-2403125bcacmr7040722637.17.1754510253905; Wed, 06
 Aug 2025 12:57:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:25 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-4-seanjc@google.com>
Subject: [PATCH v5 03/44] perf: Move security_perf_event_free() call to __free_event()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the freeing of any security state associated with a perf event from
_free_event() to __free_event(), i.e. invoke security_perf_event_free() in
the error paths for perf_event_alloc().  This will allow adding potential
error paths in perf_event_alloc() that can occur after allocating security
state.

Note, kfree() and thus security_perf_event_free() is a nop if
event->security is NULL, i.e. calling security_perf_event_free() even if
security_perf_event_alloc() fails or is never reached is functionality ok.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3a98e11d8efc..1753a97638a3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5596,6 +5596,8 @@ static void __free_event(struct perf_event *event)
 {
 	struct pmu *pmu = event->pmu;
 
+	security_perf_event_free(event);
+
 	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
 		put_callchain_buffers();
 
@@ -5659,8 +5661,6 @@ static void _free_event(struct perf_event *event)
 
 	unaccount_event(event);
 
-	security_perf_event_free(event);
-
 	if (event->rb) {
 		/*
 		 * Can happen when we close an event with re-directed output.
-- 
2.50.1.565.gc32cd1483b-goog

