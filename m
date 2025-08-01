Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DBF1FE451
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Aug 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091132; cv=none; b=Ilkei8D0Kb0bgNddaxEMRFxdxreNhTs/SqMuQ7BkUxTvg7u0GXZW1NjlBA3D4H9yohX2h4qAQt30o9NZ5J1EcUyij6TVDSxtNNd812m7YO5MXqaVvIRJ89Ocjz0SsQ8q9aDn/q0q6F0CmZJvymLkcTsWGbcB0GpTxXNRYOSmwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091132; c=relaxed/simple;
	bh=02BRk3qOj+AXcW6cS1tsqHn8w2sSkZL1ah0aPFZiI64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ir8H49Q89xUiM7KNLI2GlZUI8Bl1uT48g2JxXQeXW4qCgRhOOHlOuztXU5xYKEL+3/QHLEDp6E6tqtCKqWGZ//Bi9DJwR7GAj/fBvgZGcVUWE7D251Cay5Xra//t/DQZaLnkv7Q+OWGrwxNIMgxaU31lyH+o35TsGuC3mePZJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZSjt7nd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZSjt7nd"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ed2a7d475so1551457a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Aug 2025 16:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754091130; x=1754695930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSc5/xHGPO2izKvP398GTrx8yfXFlkYy/vj0X5FEFGU=;
        b=BZSjt7ndhpZAlU7xJLtztdYs4mtRRBGYnHytQEpXDuyDCruFN2t3pd4m5uRg+Ex4En
         enEYip+AGoqn1ZiZcwT1nihuENPh6pGQfGl6diNQJ5JQzvHYawsfLLkXe9Bq/yag9iwu
         QaeoKRcUzBdLuuhrIEGOBhuBF0ti04adGi4zfRXc/J8LA+ZUTWTEWRjE7L0SVIkNBHhw
         Zbz0j7EHgWYd7MlKUClram8X6JElAN2cWw62/u76O+5AUtMAyvT8lhSn4FQ4XVnmkjRa
         itjySJxXodEp/G6ZrrvTCRsGE7iJf2+HzJ9JDVyPJtPNR0n+5tkS90OiaXfcu17MRtli
         +l1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754091130; x=1754695930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSc5/xHGPO2izKvP398GTrx8yfXFlkYy/vj0X5FEFGU=;
        b=nVDokUz+Q4GoeK9JGk/b3FPCI9ugCFpgBlJZKDqdAW6tX3dlaz+PlPIumKzrta2Aoy
         5Mv1SW/QzAA01GnQhbUvTbOlZtmyYRbjYpP82Q901l9orPMw1pPhqE5t44r1KpH7pi94
         eGgyb6pv4xwbtDCNi5apBy5fw0efrztcjxkZbyuN1q9Yy1Gm1yVdNvm0kxH0VJrpN6ZI
         uUNaKYItKJ6iSiwJTe3dhXpeGFHF3Ea864RGqHjLweUpnRAiFtHNwiuWucPkQG527bi/
         /hCVQHyhFZwRuuasvXzsvb8/juOiAg7w3jl6DNrW2wX3oBhLH38z4ZlAauRQRGA7Dw2D
         ItCA==
X-Forwarded-Encrypted: i=1; AJvYcCU18IwPlMkaifgpSAXO7iEZ5/r/Zs2mcAD8/E6+bVKvzQ23n/ucsm/4GHdfJjJAkMmR0DDHuBOaFk0/682KH7E9@vger.kernel.org
X-Gm-Message-State: AOJu0YzHCuiqaqOKLzDz1KjWI4kaLydLxWHbvj6VD5c9Zcrs4b8qdOmn
	iDWIelrakh6NGL92w9CIR03TSDUMusY4pvmLQVXWfox9tf2gw4b8nJ5linCCc4duxZbDAaDPBxk
	rhaUXYQ==
X-Google-Smtp-Source: AGHT+IFswYzNJSBzjZEx6753vDf34RgMKloGefTqDtW4F+VAa5PH/hjJaMnf4SfTwiHSsphb9MXAnDq3zbI=
X-Received: from pjx3.prod.google.com ([2002:a17:90b:5683:b0:31f:26b:cc66])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec2:b0:311:ff02:3fcc
 with SMTP id 98e67ed59e1d1-32116210418mr2258056a91.14.1754091130448; Fri, 01
 Aug 2025 16:32:10 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:32:09 -0700
In-Reply-To: <7de2b6ed-af39-4434-9ead-5b06ed4761c5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-21-mizhang@google.com>
 <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com> <aG6QeTXrd7Can8PK@google.com>
 <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com> <aIlpaL-yEU_0kgrD@google.com>
 <7de2b6ed-af39-4434-9ead-5b06ed4761c5@linux.intel.com>
Message-ID: <aI1OefS8b9vfHyu9@google.com>
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>, Mingwei Zhang <mizhang@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 30, 2025, Dapeng Mi wrote:
> 
> On 7/30/2025 8:38 AM, Sean Christopherson wrote:
> > On Tue, Jul 29, 2025, Dapeng Mi wrote:
> >> BTW, Sean, may I know your plan about the mediated vPMU v5 patch set? Thanks.
> > I'll get it out this week (hopefully tomorrow).
> 
> Thumbs up! Thanks.

I lied, I'm not going to get it out until Monday.  Figuring out how to deal with
instruction emulation in the fastpath VM-Exit handlers took me longer than I was
hoping/expecting.

It's fully tested, and I have all but one changelog written, but I'm out of time
for today (I made a stupid goof (inverted a !) that cost me an ~hour today, *sigh*).

Unless I get hit by a meteor, I'll get it out Monday.

Sorry for the delay.  :-/
