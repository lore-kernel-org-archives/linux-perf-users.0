Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1C56465
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Apr 2024 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628181; cv=none; b=snQwrYRe6/E2HwSNrbQINxgeXesv6ZCWQdwfZvKztiRceadcmmEvQIkLy4vWvJS+e0X6MnNNy0XFuTvE6mrn4wa/b5zesFf+ZjL4xyHZnXWK4iDyub2pjLYInOscJm4LT5qTW4w3o1PXTVc00cd4I2G7A+qxKw/GgJZ+a2VEiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628181; c=relaxed/simple;
	bh=/66ANqhlgh6dfJsAL2UyKasucCcRFsXjIhwslGGnq/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z1GqGhlquaNWa95vVmhCoyz1JkVVZCVuSfLyrBOHswQS1a0ELABFcAZk/yihrDbuz6j/oU2gnNqGUVXsILWnWfHl4GEGum5MFM03GDVfWf7xVhVUX764PuBBGCvQ5crmpAXLrlGcYxmmkDXwb46O8VA0QM/mARiJ3ctrBs2e/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8DNuWvL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8DNuWvL"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so8416606276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Apr 2024 19:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712628178; x=1713232978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fpNLMOdTuzWqLni5ebK55upYwMGmEgOY//8538KyEg=;
        b=N8DNuWvLg3Dek3uI8v83apdHF9SLE1XFPySDK9L1YGz45j9sYI4m337gzEk4m9My9l
         NBZLqmjGtvxWinETu8607auqI99rW7LmGKX3LDLxGfU4gwClUCXTmK2e0D0aj/0PPzsE
         wHD9atofGr8b3GKrEwObEHYTKBDnQasXEEdbFHHujjX4VDwzdz626Zq8vJVZIy54ghij
         wQXg/bPppavQqNokBrSLfRPz9OvL8PWlfB/Q/R/wdshr4V4XmCjmykbzO8EVVe9b1X+D
         7a/Kd6QY+0ubKVMLkODNfwqv4sj6AOgxosVgBQLGJRrEMoewt2z7Zb1cQ1BQ0PIS9HeD
         P90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712628178; x=1713232978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fpNLMOdTuzWqLni5ebK55upYwMGmEgOY//8538KyEg=;
        b=c6HcFbpim8jSeKCd0I5CFu89V/SXPLzezCEYpTlTdVsXgqt7gZYIRibNMg/ffPAWzt
         xG2YLcra1qFbM18b21yMJxgzeDnT/pinbKJ8u7gdhxvyOfsaAHhkmERidpuNQCmSDkU9
         WdS6ynqcv5pRy7TM60qKOHlmUHRjq99OLTlJ7IKe1cwgkhiGcbv7VSvN0pBRy232pClp
         YtUrxk9kKJfOBoeST2549podCSVYIkJ0wLs/VdJlUAyKlHKsbiVvfBdi0GEZ9ToMKUEc
         ATXht+MqVBhvnia1jkzvVfX8Y5tFWExQAmWEUTP/Z6dJLk2Lf3AF1Z9JV8lo1xC8UkW1
         WEmg==
X-Gm-Message-State: AOJu0Yx+EHjp77ikYJ1YALGctrWSXKEpypXoW27kf5uyARl6bUpbkODp
	mH0zN+40yHM3TR3sTx+Bu2JhAdJqvJ6ceI91bwp2WCHN45kpRbLNsuXE6bSthus/qvafvBBns7j
	IYQ==
X-Google-Smtp-Source: AGHT+IFkT3IqNk8Swm6Z6BzO4HQMeVVomPflFll1hzbTPvwK61G/5hP4ruxToK9jO/RPTXxksja17dHvTW0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c03:b0:dc2:1f34:fac4 with SMTP id
 fs3-20020a0569020c0300b00dc21f34fac4mr3156555ybb.2.1712628178083; Mon, 08 Apr
 2024 19:02:58 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:01:33 -0700
In-Reply-To: <20240307011344.835640-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307011344.835640-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <171262750089.1420807.14858434543826601467.b4-ty@google.com>
Subject: Re: [PATCH 0/3] KVM: VMX: Disable LBRs if CPU doesn't have callstacks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 06 Mar 2024 17:13:41 -0800, Sean Christopherson wrote:
> Disable LBR virtualization if the CPU (or I guess perf) doesn't support
> LBR callstacks, as KVM unconditionally creates the associated perf LBR
> event with PERF_SAMPLE_BRANCH_CALL_STACK.  That results in perf rejecting
> the event, and cause LBR virtualization to silently fail.
> 
> This was detected by running vmx_pmu_caps_test on older hardware.  I didn't
> tag it for stable because I can't imagine anyone is trying to use KVM's LBR
> virtualization on pre-HSW.
> 
> [...]

Applied to kvm-x86 fixes, as I can't imagine anyone objecting to patch 2.

[1/3] KVM: VMX: Snapshot LBR capabilities during module initialization
      https://github.com/kvm-x86/linux/commit/2a94a2761236
[2/3] perf/x86/intel: Expose existence of callback support to KVM
      https://github.com/kvm-x86/linux/commit/0c0241c12332
[3/3] KVM: VMX: Disable LBR virtualization if the CPU doesn't support LBR callstacks
      https://github.com/kvm-x86/linux/commit/0eb2416c8111

--
https://github.com/kvm-x86/linux/tree/next
