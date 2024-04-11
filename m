Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA7D4D9F2
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854663; cv=none; b=cFHneTtQpAU9ow3yPFY1EiRxELV4KDLSXxvR+RwBWshxALfdz3gfPV3biz2aQROJgn2s7GyB331Rg2kLwr+3oXyGKREl8tkwXiUzJUEj7FNmopcd0Xm4OiDoTsgHXGNQd7ePK9JOyGyo0V2hM8PJ16ipwQuphStewAdp5fmWxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854663; c=relaxed/simple;
	bh=mW9Wy5zwtCPwddAQPsiCFCBdlF3xxhTlbzOesWPW9Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GY/Zs7GlVp+faZIjaWRq7oFGh6CpU9NyF9ZT3KDR6aoHbxx+CVnDSvHYWOf5pUXwjjCVGl/RpdrBvFRPFTfQjuQy1P6QiR3x/Hb0KKzk8cWfW0l++qhlrvRTsyHI/2B+GAeu4vNXgyv5xPWE5IHljJZznL95JuLMhfT5g2NeB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bq8kXP5M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bq8kXP5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712854660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzMoeKDG3HLVO21BydyhZtfJookrt2+0z0ZoaUJK4l8=;
	b=Bq8kXP5MkuS3XlmJgPrN64Q1/iXQRKGX6ssRCLiiB/npbhsJe5J5QPll85IKXyVcVBe5T0
	P6i2Z/KDltJ1Bp6cHXYOsxBL1jzHH53jd3V2nHkDrIaI9OHg63sxV8ZqvSFza8OpSPLbtE
	NSy0gh6YAogdcY/UN8s4pii88bKFqNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-DSpxDUNIP4uv5hctmfyA8w-1; Thu, 11 Apr 2024 12:57:39 -0400
X-MC-Unique: DSpxDUNIP4uv5hctmfyA8w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-416bf29ef94so379075e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 09:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712854658; x=1713459458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzMoeKDG3HLVO21BydyhZtfJookrt2+0z0ZoaUJK4l8=;
        b=e6+PzhuzzKqMTLvxoJb6owS1ij3GgXjiVrjLQMVtgYxKJmS7zWKvDWV/mgZNq8nnNR
         dAtzcLIXmh4yNSUfM5IiPzPzfhvVd57LX6YRiSQXbmGUdSpzroz5qDizBOQ4nfcehbNb
         3o9HOPIOXeGte8Moll9CmP5yIZ83W4cbuzBWt5HsNtLfeew2+OI4CyY+7Pfo7ts91cY6
         qSK1lJxTYNPzUFS3ZrFJ6a5+VrfMoSHnNFo775Dwo1L1z6t0QZJMR06qsXoo1zmxymDm
         x+4T7w2mrTKDqD3qnPP2sWT5xO8ig4mwuqJgS+zdyPMrtVRc9s784rCd28F/b1O3Bh0Q
         ESeA==
X-Forwarded-Encrypted: i=1; AJvYcCVPftICSoKBsnCjNPKr/6vGIEfkllqg2YwXDHeTGJk1lvPcqMJrPJsPXLkMxPLZDPjUeaVqv+v14Tj2GooSChpJ1pHyQSrH5CYEKvdTx5QmTA==
X-Gm-Message-State: AOJu0YzExj4D0wbAnJT35DrYFcZOyU8+2GQ/DZ4Gd/1sZZ28WnA6s49f
	sVsvLbf+KmsN1iAP0iqGZCgjBq2YXHY6BtDjO3HvVNrsi448EgfPOkWDGjvjrQIYe7I+nhUqOfG
	u9dwWi9mqphuwOxO8RwiaImIUzAbRLPwLNTFLj4GtJUyAb7i9AbmHe2L+Pwxnjs2ixtkzGdPxmf
	qcj07Zomd7l9gT8eVYWANcTXbvOEgwlQg2Uf6s3tvCEQ==
X-Received: by 2002:a05:600c:c07:b0:416:b75e:ffb9 with SMTP id fm7-20020a05600c0c0700b00416b75effb9mr294492wmb.19.1712854657984;
        Thu, 11 Apr 2024 09:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmoGFz39xTCvG23vKtpQgogb148s+KvVt7/U1rBvktp1dcwHHxjM7spsq3rgOmQW5LGi5xUnT62q1v5vcy7Gk=
X-Received: by 2002:a05:600c:c07:b0:416:b75e:ffb9 with SMTP id
 fm7-20020a05600c0c0700b00416b75effb9mr294473wmb.19.1712854657685; Thu, 11 Apr
 2024 09:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115815.3226315-1-pbonzini@redhat.com> <20240410143020.420cafd47bf8af257b2e647a@linux-foundation.org>
In-Reply-To: <20240410143020.420cafd47bf8af257b2e647a@linux-foundation.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Apr 2024 18:57:25 +0200
Message-ID: <CABgObfZiEiLbbp35gNmSGd9vNr03__Eep+D_Mj7r2o+XbF96TQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] KVM, mm: remove the .change_pte() MMU notifier and set_pte_at_notify()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Sean Christopherson <seanjc@google.com>, David Hildenbrand <david@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:30=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri,  5 Apr 2024 07:58:11 -0400 Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
> > Please review!  Also feel free to take the KVM patches through the mm
> > tree, as I don't expect any conflicts.
>
> It's mainly a KVM thing and the MM changes are small and simple.
> I'd say that the KVM tree would be a better home?

Sure! I'll queue them on my side then.

Paolo

