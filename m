Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F226296
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267959; cv=none; b=ZY4CNyGiNYIETPo/yBuwdYxs+jD6E0PNW/prMcv2BwmHVpMuUXBU/i34Ngs3BKCtI/I5JalFDUtzu+jnSTCCdS+yD6/Jc0nVKffvv+z5KIPRmckoEFbwduT4wlvjugyUL3YPkznFtACfpy5tC9B00vZN8PYScmdOLGtL/fXYmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267959; c=relaxed/simple;
	bh=WWTAljqGjigzo2ahsVS5AW4s5xTXB+6gUo7V2DIDeDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uo3s9c7dPvElRBX2kJV+IBubYUGgpxZM/xN1Zk14m1hLiMgCSCgYuE8BcDnLdxcmaNmLJWjF309Txl/KCnwi/FXI9eW42nxGHlbDv0jTSqmqH9THdGE2bp/SfIZBPZLRwQUu1D6tib39zAIIPgJnEUaJBEkV1dt07wnqajo1//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXDpBpx2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXDpBpx2"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30a96aca21eso427969a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747267957; x=1747872757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y0rWjnJEgSkZ5EEuFzNdJ+XGOmuhTpZYLseo2eQ7Pw=;
        b=XXDpBpx2s4ZF+Jc8qejaTMDOHbfIXxG1SomRxNvPln2/SqEAdLEndHNakPaBUWrchE
         FqDjsmpiY4UVzdjjACYZc9XZH07DXtmS9ogWG1F2Ek/8SoNEzjLsY9KgHK/C/yU89ZRm
         HhhC5uh9QdgkdAfKbt581fA0C6owzzq9R+Sl3YemiLJW5AOdoCkGDKjKVVV6pFKkS6+y
         rKnmcAuieyN3UszYrz6jj/ujDwogpA4CvlsoM4MCBa8+xv7TLVhGGa7YfSeBxt9NjsOP
         z9vW75KO2U49c0aQVZNSkmZiu9kUu34ydDQlnhca8B2BfJHQupz4dJG1KWUGylgURCXp
         5Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747267957; x=1747872757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y0rWjnJEgSkZ5EEuFzNdJ+XGOmuhTpZYLseo2eQ7Pw=;
        b=PjN/DTBC74SUmr6nEwPJQfxn9pzUcMS6+F86KZgan05IuxsamdZjUitl2iiEX6FFM/
         PV97H3J501JpsidiemtPyQRRGsvy9TVpFzfjJ4rN3G6CiRgY5AciCEX0StfS9umN85g2
         jErsMqZzpp7bFDonxok0JrXYmcClhglSaoxxcmkH5sitZ5N/hW9Udr/aFy5wrIqOCbYV
         D93iSwqz9v92pJXV6ZmHkROm2F6urQlGKHxa5DmmBqaqgGeOWgjzaDTX5i1N63DtZBDg
         GPSiw6iEY4gGx+gwYc9GQV9h5umIeCs0gSxY62e157jY+oCWe9W3QrG5afaNJppHfH6F
         Gjog==
X-Forwarded-Encrypted: i=1; AJvYcCVKLS+K5q1MBDbmqlJ2oJn5oc4HhsQ8HooJJpm2UZ5E2YzXuemD3jdiTYR4lfz2RFNeUOubd5caLFBQzHpSUE4F@vger.kernel.org
X-Gm-Message-State: AOJu0YzNcHZgNTbwmI7il1NLRwDoHHbS/C15LespNDymQl4t3AE56s0c
	oIfZCecmCHb8EHGrWXwE7OO+hoLl5g2QD6yIGXFZG4qgxCR0wGZ4cTHJIoP/rnh6F2iYL61gN4z
	7tQ==
X-Google-Smtp-Source: AGHT+IGuKZaiP7uhLwBXtbhrYaWam3Xnydy1XbmyTTmLh8aez6vEjqSYtDXffsuY+hhQJSHyM5jNP3mfQHk=
X-Received: from pjbpb18.prod.google.com ([2002:a17:90b:3c12:b0:2f5:63a:4513])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510d:b0:2ff:6488:e01c
 with SMTP id 98e67ed59e1d1-30e2e641e96mr7850147a91.29.1747267957562; Wed, 14
 May 2025 17:12:37 -0700 (PDT)
Date: Wed, 14 May 2025 17:12:35 -0700
In-Reply-To: <20250324173121.1275209-18-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-18-mizhang@google.com>
Message-ID: <aCUxc3c6Tt6yVmqi@google.com>
Subject: Re: [PATCH v4 17/38] KVM: x86/pmu: Add perf_capabilities field in
 struct kvm_host_values{}
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Add perf_capabilities in kvm_host_values{} structure to record host perf
> capabilities. KVM needs to know if host supports some PMU capabilities
> and then decide if passthrough or intercept some PMU MSRs or instruction
> like rdpmc, e.g. If host supports PERF_METRICES, but guest is configured
> not to support it, then rdpmc instruction needs to be intercepted.

This is wrong (spoiler alert).  This patch can be dropped.
