Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D8129A78
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Jul 2025 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835884; cv=none; b=bGCUjvNIfKbRuAVH9VMqtnl38Igb8EfrFtQ1G3jTJnKNRwnFHDsiM+FG0aABXBCagSzd7bhq+5eL93EsCWDouk5wGNcuR2qJ/k0jWW6I14MVQkOPu/xoFZRpfcL0Cao3MG4Dqxpr7+3aaMIHRy5mQEtlXhVZFAn4YlyBUKyQ9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835884; c=relaxed/simple;
	bh=PoyA0CcW92FoQ3I73ytTZfPzdZaHEfO3pw0xz04Rz34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uEyGKMntZcmDomPZbflreTuG/zeTKXo1kT3At1yIAiZL922l87xPi5bzDdQzK84u2UbuCdpCIU73mxtku7JnQ96q043eVNohEeAW3np++b3odzPtvj/pHon4WNgiBmOn7FJIw7Zzj+d5uVde3lUlxP/+lk7gGOT2mCYuKhrR3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcyuKJcO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcyuKJcO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af0857f2so5716369a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753835883; x=1754440683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PoyA0CcW92FoQ3I73ytTZfPzdZaHEfO3pw0xz04Rz34=;
        b=mcyuKJcOLvd4KWcA6XbGTOORwXL7XY2Bymde0/RtCaPOAYnsibjcnompPYeGvyqiBR
         sew8Ad6fOZq3KnLvmMOAK5GwJdtYUuK9nhreVb+xC4wVVwrTKSrCOUl/UZ3ihGFTBLvt
         uNwk/fjxG0yw7vRVNCUtVnW4DKVirBEdJsLUXAh90tXkP0h6BWB6OHO0qlQ2PHs7pnKl
         Hw+3KNmxLdyORTrz9RqYF+1BJKGHqLuQEf6xHNRtMpD5IE+BPcQ1wMh2jtqqow3efMOv
         kLw45fT//yUtqmL7O2ZtwgqSgSvV6oDEEPMqlNeY73Jx2lekTPB88zgjhmnmS1HxFm3L
         E3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753835883; x=1754440683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoyA0CcW92FoQ3I73ytTZfPzdZaHEfO3pw0xz04Rz34=;
        b=qsDBusIoK39I9M45zvdlQZ4pw3CSGtl3PNLRt67RiN/ja2m5iO5TOPTZF8wLVvk/s6
         lkxZBXDyQ9OoDk9Ad1VZmQikrKvT/oy9mAUZR/mrVB12BdPO10HCpG9dQdoRf31u4l1Y
         bTxXHo/ahzEGQ6652uaJpxUnwSYLw2VEfTkRIQkHZtVMrxEgT49jMfSFJ+nMWKv4oVsr
         YBA2DAgQHsAQkQ/dFVvKo8znhqn3NAoZuYAX34gnmcjeV4sC74Hcvil8eWi2bmnRVbgX
         zj3UhSwIDzVtufzgbMloQwueG1Dsg1L2y2mfhndmS4ZyB4mLfyv4WrD4Wh4ruKVv2x9M
         4eMw==
X-Forwarded-Encrypted: i=1; AJvYcCV165xRIsnL0osR43QcAOohYM/GQh+Bnl61NxZ+jELSK31vLLnqzqzhzeX37Q/qQj182x6FN6whH7GKxB6RVTQd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97JGo2b8zGWXXMD2ax9ry2vYUWPC2WAx5IvIKF7NiB03ZfJZS
	pNYRp1OYRqZRDsv7KLTZkD7/NnoGLTWSprckasBF+4AZ/fmG3ukwbo2TD3+H1Zu4PgXF4vWSV8S
	ZSkkTZA==
X-Google-Smtp-Source: AGHT+IFmEOk3LVUVJNWYxzRPuTmK+e+GHYpOt6lQopxXicjjLZ69T+VUxxaSfay3rEISbglMLxNY+x5v644=
X-Received: from pjbcz8.prod.google.com ([2002:a17:90a:d448:b0:31f:d4f:b20d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384e:b0:31f:2bd7:a4d2
 with SMTP id 98e67ed59e1d1-31f5de69998mr1735098a91.35.1753835882538; Tue, 29
 Jul 2025 17:38:02 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:38:00 -0700
In-Reply-To: <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-21-mizhang@google.com>
 <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com> <aG6QeTXrd7Can8PK@google.com> <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com>
Message-ID: <aIlpaL-yEU_0kgrD@google.com>
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

On Tue, Jul 29, 2025, Dapeng Mi wrote:
> BTW, Sean, may I know your plan about the mediated vPMU v5 patch set? Thanks.

I'll get it out this week (hopefully tomorrow).
