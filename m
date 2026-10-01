Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66F428B7EA
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893368; cv=pass; b=TFI5paGQNA4vlQN34vtOmlr+RBBkbBYjh9Mg1dUcSb1L+uNLfZpp5SMZgXn/zO1XDA+5RJKdlbHoaay+vVMSh/7phHeKma9TA14JfFY3In9SA7tiDvyra24OaN2w3V2MlBCCkkkumAU5QTRZscQVbFbJeaRjY//7NK9pOg7aMCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893368; c=relaxed/simple;
	bh=jRjHDbuXKLMn6PiuB+tFuhgDq4MLCM9aKggiyanaEng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbECDQOitEptSwdxJJYZXkbTpxo5FAQdPBlQvlvYYBb5g7HBXxa1bqup4LTzHjyW2T+rnXtOvZhpG1O/X3UERuIdK0trqxmZi0l4+YdoHaAWjZFLWHOOoOiNgBBwnbECn0FRDYCArFDC46K8/j0KWeirxt/0vHJxvKnuWlsVBOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+zscGa9; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+zscGa9"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ecebb6cbso2605617c88.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 15:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790893365; cv=none;
        d=google.com; s=arc-20260327;
        b=Qusvaz/lbJFbgtkaJ1CyryQVQyUrssbApQikcz1u0R9oxLuLcSkTSEoobe70Iwu6n4
         O0IBneUg1vInsqW8JZc8FwAL0OZCA1wNnH4KO7m8fPLnjpLMOW7bTjag9E8Sui3siDvC
         KDqbx4iVLbEGctufWctbSfUmMimDvjIbfiyfI6wWUtGyhk87ol0T0lecRjgyuHnHgTH9
         G5bP5hSuBuM2727BAQ5NKN3OSD1rIMeqF51Z6FkSoxCJ0TGgQWNkkiwKYMmBbhPYhR+F
         1rewGvvol0TQMmuip+62xmqZ5twdJS8SJJDgtnUDdcXjConaDDyIBUlOyMEVn/jWqh7j
         0l/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wfKwgJtYMsEYEWlSf+SsfhmhLRaFUNim0MEAFnPkGYc=;
        fh=vB5VciAMwb9hiL2hPy+VX4sAtkrCDJnOAvn8JFo15+M=;
        b=IlqDmzQQDU7n3LgJDoV1kV2aholjl0yy2qxWCYC0XLhaRUVFWUlE/ON5Tq4jv8I2qJ
         scxyv7R6wzZ/amH9FytuYrsqRppc2F6qC34gVfLthsOiHa1SvyKUqMYz0WJNgtEhW5PE
         NmLG/lYkbn6/GO8V8kiv23QwlIgwRbQ0uOGPzW8rZu4jcZbW7I4FEcLo20x7OElXXvSs
         pDokMygRFJ3OWJvgiAKr5W2SvSHH6RmgsfoIm9jBu33VdoohwomM/RSVmpsHo3bzs8Ud
         bBC6o757IV7dTYQXkmaXl7+WlHLtwyPHeWWaXRwY9yR/oEt5cFb7+lgvr737eoZGm6Hy
         UCqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790893365; x=1791498165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wfKwgJtYMsEYEWlSf+SsfhmhLRaFUNim0MEAFnPkGYc=;
        b=P+zscGa9lQEWDDYzQH23tCBhk8SY7Ae9UmEpjPY5QIrju00GARaRJ4jGspFw+ZYPPA
         +1ivdAVizgRuh0RiNMK2Y/otBtNTzouMToemHllyQ78DhXj050UoZWla7IyN/xgyux/m
         lkfAqOWJMQki+1Ys2UaSdeuqA8KmpWOyPE1L+muBoLj3g8G7dTVcoUgRJxDQiMHMI8xa
         gXcnBeBW73fX6RG4gedP01jr8KPoScfH3m5YcJulwxeMy2FT11jeMHEs0QaPZBjQDH61
         UxeU6b+2peD14qoDOQOpUCzadDioxFwvHTG4Dp3wsuUVAnttWCuyvEHEmSdK5gGpYP/J
         GkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790893365; x=1791498165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfKwgJtYMsEYEWlSf+SsfhmhLRaFUNim0MEAFnPkGYc=;
        b=a7v3p342pJ9LsSBRr1nf0r6j3kq+lT+dvN0Ff+9FF0aE98SxqnxkR05IXciwzc7VQf
         WYsBWTlEGHN69MJ3kpYy4hZDPk0Rp18KYl7x1bGoZr6hKz9kwldT+xbnMybeZ4mdRojs
         GhdE30qqEBcXl0ZfVkspxg47n76azsB4KJQDY4SIyMWWpdSVtPaZJSsJOFySgdP2F0KC
         rWfupfPW8qcdKEYtwDByAdkocJxQ+pEpVNYnukW+QHxFeQE8FipxjGBU9ZbhbV0LzFcy
         4XaiMCpRrr0iDWDmY8Hr5EV+JWpyOOBf3aOr2G6h6Fp3PQT3TyRK/6wpRd/KkZs0N2x7
         K+/w==
X-Forwarded-Encrypted: i=1; AKwUvBxyf0jDmUUUdgZEIQB5kSrkZrqM/vXRiWtPHOgdU1WTnNiyihqrnKTyG8B/lbZbV2aQcvyrt6eRr+Uvur+FC9st@vger.kernel.org
X-Gm-Message-State: AFuF++njcAVNlz4V0qkd2m6sT5FqBpGvJt8EtP/n9cQ5SUjEnX4hGfxs
	Unh77jaS/aTTwacpwKt65RbV+JRz0Psua2rF/jR6jIOrZBz3v8/2e63PqomjNdcZVl8NI1a4Vl0
	bsEgcSDeJk+qeeqU4vwGK7m5McqP9AvrhFt4i3la3
X-Gm-Gg: AYBFou0NtiGqm1s9tC6iro/gRGsmKH+5W0KWT05K59jtQXN6rsrOhegzIxDlDhcxYrj
	HO31IXq2pirWEizMp8Zh+LU+Ud7KhVyrFfJ2futFsFga5oBw/bLyMzQnhKJLkdGRltQ2+B4gxRC
	0h8sxhdULb2yaqcDccvJlqKkuSP+wlEzMqvtlnB18FM4neCdg0CUBup3Xqp+R73PLLV3BI8c1+q
	wssKP6YHMiSLWpymYJzSRWxFrfMdQGXIjQXcpVFjtrbmxajc/ZIk0I/H3nkfOfVOukBBIpnG+zX
	4YmAvzhhqtrsEFdBiU48bS2nI2NHlWUEwqzLZaALVVjCi/a3AS4GO2s+qoXc6oDI
X-Received: by 2002:a05:701b:42d3:20b0:143:72b1:9004 with SMTP id
 a92af1059eb24-14f5cbd2c4bmr587221c88.45.1790893363916; Thu, 01 Oct 2026
 15:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517114026.6817-1-vasant.hegde@amd.com> <amc-s_W_TjLYnbw0@8bytes.org>
In-Reply-To: <amc-s_W_TjLYnbw0@8bytes.org>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 1 Oct 2026 15:22:07 -0700
X-Gm-Features: AclHuK_pUfvqEqlIhxon9tDrY8mIgK0Ky_lHDUxAV5-XvBm5W49T2B5l4bbA0VI
Message-ID: <CAJpZYjVRRsof8KsgOfGL1ZBE8zM5hTY1+U5PHdz9=gkSfeRw9A@mail.gmail.com>
Subject: Re: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, x86@kernel.org, 
	dave.hansen@linux.intel.com, tglx@kernel.org, bp@alien8.de, hpa@zytor.com, 
	iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping for attention.

Thanks,
CT

On Mon, Jul 27, 2026 at 4:26=E2=80=AFAM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> On Sun, May 17, 2026 at 11:40:26AM +0000, Vasant Hegde wrote:
> > IOMMU performance counters are accessed via MMIO space. Currently IOMMU
> > PMUs uses a single global cpumask (iommu_cpumask) shared across all AMD
> > IOMMU PMU instances. This prevents collecting per-socket numbers
> > (ex: perf stat --per-socket).
> >
> > Fix this by adjusting cpumask based on IOMMUs NUMA node.
> >
> > Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> > ---
> >  arch/x86/events/amd/iommu.c | 29 +++++++++++++++++++++++------
> >  drivers/iommu/amd/init.c    |  7 +++++++
> >  include/linux/amd-iommu.h   |  1 +
> >  3 files changed, 31 insertions(+), 6 deletions(-)
>
> Acked-by: Joerg Roedel <joerg.roedel@amd.com>
>
>
