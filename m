Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA45732E73F
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837779; cv=none; b=Z9/MjX/EPD+F7EfoX/N3AnpzHHy3nNeUS3MJ+6o6mv7x0+2raquO3IIAeil1VVffGpokT7MdgMsb1+xOdMhD+kA1VlXSx5fJrb5nYfpByPjz+OY7zs6IuFTM1GrWJG5VWoQQFL3ff832Ks2rkD3xnzP4fPHn9wAFDf2Uddoh3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837779; c=relaxed/simple;
	bh=fm3m7nE7zVH3DatzDl8KJzZfqVDvtAenS6uxz+fC6sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=herTQpIR0LJVVhZnVDa9cH4xGZp8MZo+8ou7fVfkINdbggsFRycmyC+Up4TkNLQlkM9dno9nuj/Y9Xf7pa5gK93N6d6cZimAu6COl99pZpzWrW1dnBVQlq1sJ3775+1mpsyG7SlbSrI0uWdm6fYL5qdWzBzX2posVXXs51z43LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kt+L8ltg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kt+L8ltg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761837776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fm3m7nE7zVH3DatzDl8KJzZfqVDvtAenS6uxz+fC6sc=;
	b=Kt+L8ltgxK/jESZlnPVUV3K7tFKWVotGdDA8Njw8djy+Iz4kswpKY9uSnFjIQzreTU2NzT
	MeIhnxelw4ajGJSdSWE8EuiHm8Q5RcgNIbs2TOyqhwmEcODtzoUI3NDk9JDEMhaIQwIPNe
	H42VtP576NVzRFdRrSziS2Yd4KHFJdg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-8NDpBcV5NT-aTQlibgpb9A-1; Thu, 30 Oct 2025 11:22:54 -0400
X-MC-Unique: 8NDpBcV5NT-aTQlibgpb9A-1
X-Mimecast-MFC-AGG-ID: 8NDpBcV5NT-aTQlibgpb9A_1761837773
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-378cdf5e305so6893651fa.2
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 08:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761837772; x=1762442572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm3m7nE7zVH3DatzDl8KJzZfqVDvtAenS6uxz+fC6sc=;
        b=nl473ZjdxuqC2yTHZT/0Fd4f3d3XxW3V1yOC6z6TGHfXJHjYrg3iWYKwvuONnSiNih
         7ctdtbSUbVOVU1B8svAZ3SCqOJqr8tB03YtyOvb1/wA1yW6xjnXlCNTOzwXdcTQZvuJo
         yN7sK8bSnz4XIWx2xkwpJCHINScXVcJZU4pmFoF0VKhfMQaWK/F65sBy17T6bBVZ476J
         r8cdGBqvvQlmglDdXXEC7wSGq51pb5ufBIwtAty3q0RfEUjhMKMbNpYNL2FzDVP1meJb
         G2TlSbrf8x95/IszWVSTsmsc+R1zBeD0a8N9DdMzkhlgFoyuyDy5Kmue3oJzFqCEDSt4
         M0ng==
X-Forwarded-Encrypted: i=1; AJvYcCWf096uzULFfeS0Uo9kqbKCaHm+vOwh/BmX1ScekpAqQY0NTYEfh2NgIBlh6soU/6KTnIttaQnnyCnGnybWY01L@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nQIsomncScXsXYrs7GaKAD6tyfMeLYITUuSOr6PPrOjZbVtU
	3BPijUwo48tq2XNH75TJ6zK2RsUEmy+61cVHeGT7yN+7AHchp8yB0O8rR5o3CCsRHwxPfVNFrmf
	SV53ORWws8oT6eqd0z93pZueItLlZ+LDykCwyb3+PDn1TBzMbAYQHsLZ+ehb0pyO/A0TapooIMx
	Pmu3f9U5lPqpaoLZXTVrBathcPlPh4cPHMoADm5lwCjPtphw==
X-Gm-Gg: ASbGnctl4Wm8B0NQ3sV5KzJOoL8InBFUZjvCxgwcfKp+fs5Qjtrs0Unbc+vwVkZGF/3
	bKh5S3axI33SZLOc7qEhX5zV8Xds3+pS4UBFjHzeo6eZxFuo6Zl82h3Tl9aklEO3ge3MMsXXvWY
	5biv6Pte/BZl62l65bLYHisx9vDxl3q/BoDYntPGr3qsaTeiV32UTjuw==
X-Received: by 2002:ac2:4e0b:0:b0:572:1f0b:5ef3 with SMTP id 2adb3069b0e04-5941d5002bdmr58085e87.11.1761837772483;
        Thu, 30 Oct 2025 08:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBAVQ2FwAUWRuP2k2ydeZwG6VY23POJCaHckmnER7xw0TAls9V6Uv3+gye1bE+UrCmOpzgt/fZEFoLEn5Y+ww=
X-Received: by 2002:ac2:4e0b:0:b0:572:1f0b:5ef3 with SMTP id
 2adb3069b0e04-5941d5002bdmr58062e87.11.1761837772060; Thu, 30 Oct 2025
 08:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132406.78359-2-ashelat@redhat.com> <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
 <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
 <f674d1eb-c492-4dec-a49c-8b40833741a4@linaro.org> <2e756e75-7dc9-4838-8651-ca1a0f056966@linux.ibm.com>
 <CA+G8DhKTpZLzRbZvGiS6YZxOXecEcrtOUcNdHOpjDM9Cz0qzxg@mail.gmail.com> <6b1d742e-ae54-4c24-a4c0-11565729cb90@linaro.org>
In-Reply-To: <6b1d742e-ae54-4c24-a4c0-11565729cb90@linaro.org>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 30 Oct 2025 15:22:41 +0000
X-Gm-Features: AWmQ_blaF_xHYQOTIvPmkCsJHRkEnDghL9d7TS4WoIuqQygozPWrKgB8gpMan-c
Message-ID: <CA+G8DhKudvY-oXe76rBR_af0Z5fEAVf2wpgqFr-aWRbHrQLx+w@mail.gmail.com>
Subject: Re: [PATCH] Revert "perf test: Allow tolerance for leader sampling test"
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, mpetlan@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, dapeng1.mi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 2:19=E2=80=AFPM James Clark <james.clark@linaro.org=
> wrote:
> Isn't that the same throttling bug? A difference in cycle counts.
No, because nearly every sample has the difference. The tolerance
setting doesn't matter if every sample is mismatched. I don't think
this is the throttling bug. It doesn't match the big description in
https://lore.kernel.org/lkml/20250520181644.2673067-2-kan.liang@linux.intel=
.com/.

> I'm not really sure what "v6.12 up to date with v6.16" means.
The RHEL kernel has a different naming convention. The -145 refers to
the 145th iteration of the RHEL kernel that started from 6.12 so
6.12.0-145 is relatively new, but I'll build from a new kernel and
test again.

Anubhav

