Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3A33EB1B
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420237; cv=none; b=NggrqqDqj3Ff/pk13nMNSA/s0RPAaLhH5uN2AvdpZujKhIhzWLqAO98E6UwUn4I5ZgMznaV65+V6cEhzWSWCpzA6oq2Ox5TebQBF7G3FuBM+XFwKXXpkgyIJb4YGbAcsh67GCbrGP+VAgvZy1mqYCMfoXfX/pn/NRSBg9ga9vDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420237; c=relaxed/simple;
	bh=gWBYvoXvMuR+XWw4Tsmg87T8vN6PxbDkYFOQRNHGpm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guCbG7un6CNQhIbpkxahWi2NIVmhZaoGjC6hDRTK1xBuHUv/XCchKbo5asf0y+LoHye2kOY0CkqStL4QsycYr7XCqplS0WD1do+YC46QbFpIb7dgRLeG/JcrVSjStoetccH8o956sq3aIk4zm+goTTrg3FAPWXOCa1mKXkaEyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/GM3YyO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/GM3YyO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceaf8a1265so40432125ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 20:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786420235; x=1787025035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UzLQVcGZ5l2XVUGPdqbb3e7Oajp0X5+/MxQRIPlN0dE=;
        b=O/GM3YyOirhrW+Lysm1oxIeHknUS6sS+gCLYJ6xtqlW1z3eupaZ7Nwu0ORc94/wT04
         9d51ml2dxk13VnFwCX1iunWpeeWYCfm0YoZ0/BSwEs1Ch2vBf54anw9hqi2Q9j9QGoXN
         F4XvLtn3dHXiiY9kNDRd/qH3VmvPwx2b1DiVQDIjBMGAPLkASjU1PJp+5HLLTQqjKux2
         johfrs9a8mgkvklLS9VQZaNS7UEMWMitmUL2incn0pR1VMuwI/pQJdXuslvijWKN70H7
         bEVL9/nzSORCBhJskRWx6refaWmUAZ7q1qMeiXAEcHhQO1HllAAzM/vhfCfWwKuMWXeV
         w/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786420235; x=1787025035;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UzLQVcGZ5l2XVUGPdqbb3e7Oajp0X5+/MxQRIPlN0dE=;
        b=UjR4OTqaASKS+8nwIEQgitUKrmbK/8T2/wfUNWqDB0Ei3atdDGnHqb6bT5gV/Q+44G
         BaDmixn7gzy+nuWcrcozohYQQcN/MTGRvIKIKDxZ4WL4OIBwxoxyKOTNsWRDSZroGIb7
         JnZMvEycyKaF7aVM32P0tqyxazeZ4dbfGQzF6KC5UTzhtEa7axBPqsqVYaVfHgGL3P9w
         g7wMt1IFomQ0M+md1vnjG+TOoZaGZ8YWZ9La/xNtx2s3rtKJoKQm13lBSgSQKmgv4yL3
         n3HHNtpapQaN/Pz6rFqQpjaFv0lPZJ9pyUgQC4nx9enk0za2T6wj7A3ZtXIWs9Z33jT6
         CFtg==
X-Forwarded-Encrypted: i=1; AHgh+RoJts+E46ayXqqlum03BjDAJBUj7af7IGO2QirbaDY69z55kmK6X+hEF7eRMYY/c6irKiDIYc6Nqz2CtTU+MMpJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5FygaXn3bdkHHajtcN88VuAUVx0cJeTco69gdMkV4B83a2Aye
	EHxOIKTz8eVB9Bjuj77rkJP0WELUSYgNayrR7UuoCLa32tfhfffQgosp
X-Gm-Gg: AR+sD11ktoIdniZ3TGuQvZI2D0DmXds7a/lh/VYEL2dK2CaaiGbth3xa5gW49H4lYnZ
	JLJ1UJqRMdPrcjUO8SBnP99ZE3+Bmr7scxDI8qK+knmYjwbwUyHVih6Z6o061BPw+5mO1m5YHbF
	JaDm8k4wxQfacVHK6QQKMa5tNeQA9oHsJ1IfVr/syzREZp3ZVwKhI7sqdpCaAwy4uVxpdnQ3/q7
	8U6eqdcHZJxLcJN3mMP9yOQb6cEyT8w1JEuguMc3KFCWg7nGP8Vd3D8+tVTeuHVFkCdY8T7CAYf
	zRVVHG35642x28LPrEq31O8aG3p1G5GnY5QJrNdwKzUjtY2OIBeFuVKMBhgUqj1I5ZR/xbgzbBH
	YEuZVNVcZ7ZXUYX3oZWdFMT1L0L3tdoUc8uv2RNHQhmDZwm8gf9BjTfxZTpSXswlBjUf/ADQ/TC
	IWttjCtMGjYgtI3GI8bkiYY8j1GIYUBmkxP2UlgcSH/ZWLI5BkRMqYp8lVdOwF3Ded1ddVFcFtl
	HnvuWSmhzPg0YRY/t04juJ5piqhUN46tQ==
X-Received: by 2002:a17:90b:2541:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-392ec2fc235mr451558a91.4.1786420235511;
        Mon, 10 Aug 2026 20:50:35 -0700 (PDT)
Received: from blinky ([67.174.242.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d4050557sm1740457a91.3.2026.08.10.20.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 20:50:34 -0700 (PDT)
Date: Mon, 10 Aug 2026 20:50:31 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v8 12/22] RISC-V: perf: Modify the counter discovery
 mechanism
Message-ID: <anqcB37PywQpMhkc@blinky>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-12-7909f863a645@meta.com>
 <178453211938.543975.7016109597042850635.b4-review@b4>
 <ba053fa1-9df5-406b-9f92-df0dcc76ff68@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba053fa1-9df5-406b-9f92-df0dcc76ff68@linux.dev>

On Fri, Aug 07, 2026 at 01:08:31AM -0700, Atish Patra wrote:
> 
> On 7/20/26 12:21 AM, Charlie Jenkins wrote:
> > On Wed, 01 Jul 2026 01:47:00 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> > > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > > index 74d934238821..c20f1e33c65d 100644
> > > --- a/drivers/perf/riscv_pmu_sbi.c
> > > +++ b/drivers/perf/riscv_pmu_sbi.c
> > > @@ -1599,13 +1658,23 @@ static int __init rvpmu_devinit(void)
> > > [ ... skip 15 lines ... ]
> > > +	 * in S-mode via Supervisor Counter delegation.
> > > +	 */
> > > +	if (riscv_isa_extension_available(NULL, SSCCFG) &&
> > > +	    riscv_isa_extension_available(NULL, SMCDELEG) &&
> > > +	    riscv_isa_extension_available(NULL, SSCSRIND))
> > > +		static_branch_enable(&riscv_pmu_cdeleg_available);
> > This needs to not only check that smcdeleg is supported in linux, but
> > also that it is supported in the SBI implementation correct? Trying to
> > boot this on OpenSBI before 6bb6b61c27eb ("lib: sbi: Add support for smcsrind and
> > smcdeleg") will fail on an illegal instruction in
> > rvpmu_deleg_find_ctrs() while trying to access the scountinhibit csr in
> > the patch "RISC-V: perf: Implement supervisor counter delegation
> > support". The proper mstateen bits need to be set for this to work
> > without crashing.
> 
> Yeah. We can do trap/detect to identify if smcdeleg is actually available
> but that is bit ugly.
> The firmware should make sure that it doesn't advertises an ISA extension if
> that is not avaialble
> to S-mode but that model only works for newer firmware.
> 
> if you are running very old firmware with new Qemu/platform, the default ISA
> extension may have
> smcdeleg while older firmware may not even know about it.
> 
> In reality, I am hoping chances of that happening are rare as OpenSBI
> patches have been available
> from a long time and Linux kernel patches are yet to merge. I have not
> addressed this in v9 as I am
> not sure which is the best worst approach yet :)

I had an old opensbi binary laying around and ran into this. This
unfortunately crashes the kernel, but since there is not a good way of
detecting it and newer firmware has handled it for 2 years now, I think
it is acceptable to leave this as-is.

- Charlie

> 
> > 
