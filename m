Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E415B119
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512908; cv=none; b=ugAwB5Yacaa/zyKdF1nWFkQqWzOTaxjDWmvzS3VXFkeu4n8q4E5FXyqqugGWAmLcbqpR7TuwbphJSU4At53Eiu2XeJXeMKoLmmCyX+P82EssSiEkf0OYNz7IOAudlzN/min3vLxSnvNAWMisgBPo3K229ujXi8p/VV86T3B3/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512908; c=relaxed/simple;
	bh=Yzmnrq8M8rsSSfvUx5r3D5WPD6XM6bZJijJyFHqXuOE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=ovI5ifviOdnRB4QwMCmwaT0gWHPoWhwLbix425zZ3MIJes7/AIW1RjdqQm56P7WW3aHrXR9XneiKebNjiWTMXG19yvmJxEjKIj+BoTWrFshtWxeFauj+jDjOBV1Oj4Fbz1s6fSyplhG/cGv9od8rRaoZM+UOrzlxA+HbDBDQg98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWhuZBKV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWhuZBKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726512905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2KKfzMhXsEKpItIAddj1d1dXMFqyODjm2oiNjjp6v9I=;
	b=GWhuZBKV7+CVHxfybXsKPrnp8y0uNGjN3RNc6v28mY9hzYtomeoFOS7+uRPgyICWyxcZBN
	rFJpe5rgfp0CFiMjP1a81PkXhUx66IgeVxID+n8vj8K3LBxB5m+obozvgh4VxVO1LTmhdr
	BtED8PnA6aBDVIyTRzU6dPPupy+s/uE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-bBlFPSP2NHGlup7zFfRWjg-1; Mon, 16 Sep 2024 14:55:02 -0400
X-MC-Unique: bBlFPSP2NHGlup7zFfRWjg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-45824c3986aso73389201cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 11:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726512901; x=1727117701;
        h=content-transfer-encoding:mime-version:user-agent:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KKfzMhXsEKpItIAddj1d1dXMFqyODjm2oiNjjp6v9I=;
        b=wzwiawmz+tvOdeloHEwZg9bsuM1myEv0PtDhWzJLzF5scCxB/A0VQ/r5RmggEafrfj
         TaYCUTBns3DASkUhMj7X/D4mYnGk0sj+W8ua5tlGwY9UOVKUeTKjC3pqofRVp6spPN7n
         ZSCZ5npVqVWdAUdNpVP02ZWxY4PMBDs/ZBJuowFBb/h9KilqCpRfydhCM0OcmcgVS3EC
         YWVqZUD8hv3GFwzb+cyKwMsyx6pBuo9x1xKzJE1a1+hdeN9z41eCEJf+HtIOEXXjaOsh
         gW54/Kfs5G3eUlzi/nI5NBd0EQzhr8moXsXApl1n8cDTUet1cLa2hsEXEi8gpOqusuGJ
         zVtg==
X-Gm-Message-State: AOJu0YzNzXVN4UUcdv7oeN87L6p2iLQmvlGDBUHc+R4BEET2b8IU6oNI
	fHS8PDAfq6yEXQR41yqbwACsgRP6OUFKIrVutsDO81WKHoNvE04rvFcs1YFkX36iKwVNndN1v0R
	WqTgDlU55mqzp/daOMrgeqLQQ8hKZiM/8slf23+h+q7EUo/KIjE/qEioWZ+5mafpxrg86T+7bPZ
	TL8g==
X-Received: by 2002:a05:622a:1a9d:b0:458:4bf1:1f42 with SMTP id d75a77b69052e-4599d29ddcdmr217289711cf.45.1726512901373;
        Mon, 16 Sep 2024 11:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMezJIJg67zwskPLKJXaEJ3701UxX1gubyA5pdrrIU/GH9Mk1PMFfPU1Cq1RjJUZElTh9LDg==
X-Received: by 2002:a05:622a:1a9d:b0:458:4bf1:1f42 with SMTP id d75a77b69052e-4599d29ddcdmr217289431cf.45.1726512900936;
        Mon, 16 Sep 2024 11:55:00 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aaca55absm30301131cf.54.2024.09.16.11.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:54:59 -0700 (PDT)
Message-ID: <5ddfb6576d751aa948069edc905626ca27e175ae.camel@redhat.com>
Subject: Small question about reserved bits in
 MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Date: Mon, 16 Sep 2024 14:54:58 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi!

We recently saw a failure in one of the aws VM instances that causes the following error during the guest boot:

 0.480051] unchecked MSR access error: WRMSR to 0xc0000302 (tried to write 0x040000000000001f) at rIP: 0xffffffff96c093e2 (amd_pmu_cpu_reset.constprop.0+0x42/0x80)


I investigated the issue and I see that the hypervisor does expose PerfmonV2, but not the LBRv2 support:

#  cpuid -1 -l 0x80000022 
CPU:
   Extended Performance Monitoring and Debugging (0x80000022):
      AMD performance monitoring V2         = true
      AMD LBR V2                            = false
      AMD LBR stack & PMC freezing          = false
      number of core perf ctrs              = 0x5 (5)
      number of LBR stack entries           = 0x0 (0)
      number of avail Northbridge perf ctrs = 0x0 (0)
      number of available UMC PMCs          = 0x0 (0)
      active UMCs bitmask                   = 0x0

I also verified that I can write 0x1f to 0xc0000302 but not 0x040000000000001f:

# wrmsr 0xc0000302 0x1f
# wrmsr 0xc0000302 0x040000000000001f
wrmsr: CPU 0 cannot set MSR 0xc0000302 to 0x040000000000001f
#

The AMD's APM is not clear on what should happen if unsupported bits are attempted to be cleared
using this MSR.

Also I noticed that amd_pmu_v2_handle_irq writes 0xffffffffffffffff to this msrs.
It has the following code:


	WARN_ON(status > 0);

	/* Clear overflow and freeze bits */
	amd_pmu_ack_global_status(~status);


This implies that it is OK to set all bits in this MSR.


Can you please take a look?


Thanks in advance,
   Best regards,
	Maxim Levitsky

