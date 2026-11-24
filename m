Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543910;
	b=Mi2xlMTVbfKXXjljNQ1rZ6zzb0FiZaBgXaPbyhtuq6feQS4/++pGOCcQq71mO8jlV4OW
	 /sT8w+7+GqbZCFbUqTUMTeZ1GWv8NzlD7Nqu37fUJPUTz/ZswmkyA7j5waYGmHM4yUPfw
	 EVUEven/E7FlKPiQ9Zdu7U1ISVrEUKfKHNVfOo/ZGJ2GRvLtsMeb1JqBCrtZ17OhE00QZ
	 Cfp73tPvMO5LroHkR+RxaCJOBH4xvwiifmIEH5FK3DPO6YPMmBO8O95+u7UjgKMNfBLhm
	 Qu3SevYzNN6YoRAqgfBDYpUkFhyOcICxfxwF6zELCSy3+0/vJLzvMb/B0kibIEApOBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+Bxz0RgjO3382FqzaYyqYZXdqna4kIjDuC2RGaRLnFI=;
	b=UJ5wUVMFx4+Txued8tjmFDv0wUcuEYg5jN5zkNbnS2MhLtbPNLU3oBE/38YqCWLH/lQk
	 QLSFYO0mk5nmejNs9FuO1+4Mlj4HfNBEpJArXEoGDdpDWIxNRfFtVwY/REd/94okmeHwR
	 U2zlD7awqxVPVAWp1srA+s5hBkOhNJuu4M8UCl10hT4SE08fuXRZO7RMN2CkSEHeO9f0I
	 lJnPSWS4Mbr+iyXZl0MRGVtInagauTRNbVjyE9kIqeF96Sq/O52CYjN822wsgs5ytJpyO
	 3xaoWgHYbzk8m20NhlFvqGtUIQWBBUTQ0yZGf/JOsqlx0ba2ouoz9OHIP4ADv+W/dKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hjSJHICZ;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F01606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 18:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F01606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hjSJHICZ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49953abe51fso34104155e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795543909; x=1796148709; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Bxz0RgjO3382FqzaYyqYZXdqna4kIjDuC2RGaRLnFI=;
        b=hjSJHICZnY9Dt0kdXc7sZULnwHNkH2R3M0eYMuBFkj3sYgx8WEgGP7JF5gyimh4WeE
         RQVHSjGyEIhwq0lk+GD4HGEgbinMWxTCBA7eVQjiR5OeXh33ex4bxKM6ykcRVdw+G/o/
         U3Wv66xpmoDDcVd2ibytRoNjCmSR2Zi93xmxPU7fAZ/q8iN8QRnUBQ89Xe6T13XL35V3
         z+H0vdantVNaieVR2m5fgIetOiHpq3i/WeiX+8ye+NXSOrCdpsqjARGSjOFcDpg6aXXR
         06+c2Fw0HxPMqJO3j0MDYjJqWi0IMDFHnE9Mv4Ggqd2NSOKQ5vjWtHkpQCL8Ybw8Uqyy
         kGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543909; x=1796148709;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Bxz0RgjO3382FqzaYyqYZXdqna4kIjDuC2RGaRLnFI=;
        b=aBqHpIxATrzGkMrIcLUJ2yaHixAWlpqQSX4agyh7sPbIsSif2408Tcq51u3FgRpkAD
         hS+/cTMM3cAUzJU/L7pq9iANwL6HY200EolfkzMWe8hY8nmhyueT/tzOobYi11UWzTpO
         HEfxfbhsNhN+Vp7hEPr2TblgQEcpAU+AGvg7zTlKoSJKmLELSxXiqHGbtFEXcdaAOnGB
         RrRDIrQSEwiZy++oufYlaQDeoiXtNo+XfYqaSmm9Lo6voKGJVlRjRXZMPOEBY7b3RS2B
         xDKalnNdD3yYXRtlB9xOwW2GB441b9PAeN5FgzkoOIuUG4bzQ1Mc3dZqmX14EPN9YzTc
         CrHw==
X-Forwarded-Encrypted: i=1; AL+hErHoA59OA6Et9Kpyu+inHet9xbD9WZ3st7BkG4oSgaYvp9SXOvE5lgLD16zHu4Ui9a2nVmkbnwXDMz9C8zwWvjnq@vger.kernel.org
X-Gm-Message-State: APuU4Z82sTjG1Xvq5dK+ITDVs4HBn5YEZTdw4dw4eFfTy88fup17bjiM
	jHeI5Lrxp/aw5F/SedWf89r/ONLcWiYoUmgTnvxaatsiw0J2SGbfnpn0pNT/6JtOAq8DaDwp4w=
	=
X-Received: from wmbz10.prod.google.com ([2002:a05:600c:c08a:b0:4b6:fd58:3209])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:848d:b0:4bb:52d8:73ef
 with SMTP id 5b1f17b1804b1-4bb88940f1bmr314109915e9.34.1795543908771; Tue, 24
 Nov 2026 10:11:48 -0800 (PST)
Date: Tue, 24 Nov 2026 18:11:48 +0000
In-Reply-To: <20261120115601.GQ2668564@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192228.2661266-1-dmnk@google.com> <20261120115601.GQ2668564@noisy.programming.kicks-ass.net>
X-Mailer: git-send-email 2.56.1.663.g77904e546d
Message-ID: <20261124181148.144716-1-dmnk@google.com>
Subject: Re: [PATCH] perf/hw_breakpoint: fix ctx->mutex vs perf_event_mutex
 inversion on attr modify
From: Dominik Maier <dmnk@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Marco Elver <elver@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, dmnk+artist@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

Thanks for checking. I'll switch the second Fixes tag to 82aad7ff7ac2.

For the lock: since perf_event_modify_attr() walks child_list inside
ctx->mutex, hoisting each target task's perf_event_mutex out doesn't
look workable. Would you prefer a dedicated mutex on task_struct under
CONFIG_HAVE_HW_BREAKPOINT, or a larger cacheline-aligned hash table?

Best
Dominik
