Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E41D1726
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040242; cv=none; b=EBfgfJXo8bFxvQbyOtrGJxFTFkIY16QEhz/woBUzOSr8EoNcjMDW6lIoL6HZ9PRa4E57gUlfKKZpdztwkcn1Ja/O1zEJZJxMlQhReDMpaaDjbfyi2Q1owQrkhxBKLPoQuWWOBpnvbCFKhenGqzqZaBU3olKPmcw9zk2czymk5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040242; c=relaxed/simple;
	bh=yWAOfS70V7ykfbPo9lVakB+tpRxVE3dXUn/zuxg/4r0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HhbESeOEkzXx/aLkacYTdS0kV3fyr6pLEHHnw2/dQ10WZsFeVDRdYtcnh2CTd2rfsIYCSWHs24jpqTcWP46CYqY6fkgauTxTeNtE3RnOVOKIGp4gc7jOepVKj/7C7CDN9mNlDAdkC4cnLgrfU2wXvCm2ctSBQJLF5HcUC2VDdIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9TACT3N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9TACT3N"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ea3512feaeso4214081a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732040240; x=1732645040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWAOfS70V7ykfbPo9lVakB+tpRxVE3dXUn/zuxg/4r0=;
        b=H9TACT3NRG8jDxbSIQ/MQ9mX7Se2Re7qQPT1DMX/Tincj0ZJMGEo6uUDe2MWEciAEs
         8EELel9zzTqFg5qfX+xG9WHg8JpY3osoaQDSzPOdfRgUAuU0paiuSwXoQTWdwnm0kZRk
         yI1atyNxX4gxJkoZ83Q2UKzhFS7v51gwCMwwRg2t2WL7WirzbaJF54PecfvZ7unn2/ZQ
         wJohWO2oEzSCH0kVuifi4O+yDO3EtkimSp1fuYE71gBNeXT2wotKpQwyp9NSufgH0Kr6
         cVu1t+SgsWYlQVbADQQ1Xe8c2tDbnHtp2d3IZvFJP7dc/m2t/YeYMBrJjhGiR+m8qfl3
         fdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732040240; x=1732645040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWAOfS70V7ykfbPo9lVakB+tpRxVE3dXUn/zuxg/4r0=;
        b=Mg8oYUvXh4rIfKBpkBdV1zrgfysbxO78FSAJ9r7mWSF+LrKdkR3nSiEavEUfrxSpUH
         u2sevjwIei2PPHX8myF10XJNbwTIIkkx8ANcb+6NRV95zxSeceSo4e43g4YBYFWbYyJq
         /HOfbiVb4WOt1QUAOstceccJtfx705cBf8tVe300O4tQJqR8EkFFqO1kRRC5RJCUt1KJ
         EsG/L47bi69601zA5wK23W0TUnzK1FqwWZEB6QPyGgp2nnh+wtVI7IUMAf1pxAWLCEne
         MlAZds4wj/cgpgRJk6RLOO3ifrTDCdJ4IlH7I7ESBaSdO5UG0aKVuloPX/6e6UOM//XO
         B7hw==
X-Forwarded-Encrypted: i=1; AJvYcCXtZjEK+cMGfEopjrhjvbCyxKuvTOM3VMZCVTbch30wnRIGh/WrdhWBkVbNZ4NV/1dC7qQ+Kf2VWghZWLO0wmHh@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIh/QSYzyvJokf3coZuplkyFmlynnwRCmOBQ9s4T/IhAibDYe
	fVI4HOMW2FDHNrHV1mrk5/y6SPPesz22uvghvgw64YsXLZkZ5khqWV54ToGtGYuTb1G3mdCvi5q
	Ouw==
X-Google-Smtp-Source: AGHT+IH0JFG9Lp8YAUzd3PBxQROrdMMVFBIgGsPAEiLH2cpW1JEThd9yz3YMCM/ceiGYf1Ip7w7GxgVlvIE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3912:b0:2ea:6f85:28d2 with SMTP id
 98e67ed59e1d1-2ea6f852a55mr21270a91.6.1732040240243; Tue, 19 Nov 2024
 10:17:20 -0800 (PST)
Date: Tue, 19 Nov 2024 10:17:19 -0800
In-Reply-To: <20240801045907.4010984-28-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-28-mizhang@google.com>
Message-ID: <ZzzWLyhFmwSON6K6@google.com>
Subject: Re: [RFC PATCH v3 27/58] KVM: x86/pmu: Create a function prototype to
 disable MSR interception
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiong Zhang <xiong.y.zhang@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 01, 2024, Mingwei Zhang wrote:
> Add one extra pmu function prototype in kvm_pmu_ops to disable PMU MSR
> interception.

This hook/patch should be unnecessary, the logic belongs in the vendor refresh()
callback.
