Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796C481B1
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Mar 2026 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582804; cv=pass; b=MLgjKrPV+kOTTk/atb8uLCz2g4AxLyKMY+GInKBfNuUqp3/q9PjaOr8CsilE7tojOYu4PWEDK7tHqqAiH0mg7q6PPaSFKBPMy7eKW3640OE8eFHMwMKAHpxUxfvEAaIAVWU76PpTdmwC8F3vEuKkF4VOG2PcgpWZ2cQVFWe3x5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582804; c=relaxed/simple;
	bh=SE0iuTKzP7Mva7jgcYokHYOcLSARQ9ahmEoA1aPrACI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pg4gUsHaZOBy5X5Z1R54NoAE6VKA7Ws9KwN//Y9ciiA+d6DpRvkTTV1EU4QGt1zofqOlykyrLzqSjK7r36bKSZgvIb5yU3AIdDsIkIgtLeOBU5Bd0vbwfW13ttgrIz01b0xd6YtNEhf4PQKkupllWiBeMSQT93vf4kAtwh2k0q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eb6O1noC; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eb6O1noC"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-505d3baf1a7so739441cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 16:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772582799; cv=none;
        d=google.com; s=arc-20240605;
        b=DX9Oy+TXpn4a2cxS0OWuApmaZBpuvgZjLMwICr3+oztuGNWZLXrl6xABBznbCBkZwN
         P+s8RRBlf9zBmXoQQQEPpWiRBIgwdlh543QJcM6s4/QeUz2dQu8XqtslLBmQOWzVRJau
         6mGoRZuojZN4ITNWeF/D1SeW9JPWSjiKUEZVVjIWXoRw6Ggesu4VJlwkQQnEFHha4WCB
         Q/EMzkmv/mvVb/wSaaUxrXwMc+TdYVwxDXV+/SnpXyYs5nUWNmTXvYdme+1hjDJWQVcB
         Pzku3byxHR7cVcy7SanDFfAf4yt4w2nuG6cwNtegX5Ci9w6b3rJdbQiJ1WJ+DFMiU+5V
         9gfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y/PStokD6IlhvxuuSo1FJomzpaCmyss/AOhqDAfuiyc=;
        fh=8ZV8CDfwpyrdz6pQVsr9Gzk7QwMux/bKblgP9D1GWGw=;
        b=eYACYXb6LQp3ILDkyFtbEUVjkksyDGjI3PjEUgPKAiE1aCMt5d/IWEVMspxzazw9lO
         1e051EYjXnnxnQ7cVbAUuSW9KkoV187gDmS8HPUqG/fVaDq9Nbr/fuOpmXp87JPOD57M
         p+X1hjMI/En1Icwo9drVeRZYabwopypO5H4vWLSwZjFraynaLkgIR+iDGke7vEJNs2ib
         r+hhzOxwr5zT8reJ+faE2cu30Y4WNVbxoqA3pCYFgnvflESDpKy7yYugP56Azdd6ZSAG
         VUPiTPVqV0rLORrzxkTQ2GGooElmBhF1ZSHJNO61VQB6MHxzQhjmX0ZPqGGHL1L8oodL
         woSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772582799; x=1773187599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/PStokD6IlhvxuuSo1FJomzpaCmyss/AOhqDAfuiyc=;
        b=eb6O1noCx81b6pSPf1xwCFVVycirntcp1MZfhIT9qqx2THKksct7AG1tzu5WYfX+c5
         NicSzAf+12eGfu3aYACPbg0TcdS6ALuNV4npKcWM+5hoGD5zl7rL0GSFkTmLKhZofAvu
         FFTAZzHKI+An/48bYpxuJ6JzuEdC2G3tr/NM3aXr/AI/PdakqnnWm3Aw/jzvVTLshvJn
         3UhEEPYIVNtqHbR9N8lpw2OsUUehRmTvy7Vbbb5yw/wH8ltRo4Myx2jstDLYiiSBIWNN
         IaR9Cipv7yOaXNb1po7fqfNegjQq/RIsJrOPntPq6THSvggbzj6n0neCrRQImIwf/Ncx
         n3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772582799; x=1773187599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/PStokD6IlhvxuuSo1FJomzpaCmyss/AOhqDAfuiyc=;
        b=LvYH4WPWa7D5P3lezN0d9ncllBBPCllSHyhk/XVJujeyAgRqliz+1f/ZhHuP1yDPQi
         A6sGrJyhgkjjFaadfe94AOarILBpScOCRtlLGDLr1uQ3/GLRVOk/IDGudQYRENZDqFqu
         2QZTYIWvO9QPWupDO4Ymq1YaqmTbgh59PdWIp5aMCjx2yzHPrSlvGe5CY++b3rapyL9x
         kaNuXTllMp7dSw8HwaiGT8yYugfjPP5p1U3IO5mmXdaY7ZXr8LIRsg/dyldANCykUEj9
         jzqQ8bITyhK3Rx6YUJWbE5sQVEkrpkNv7p55xmcqwKHS+jCRwNpymgN88qrbseXxflQy
         3c4g==
X-Forwarded-Encrypted: i=1; AJvYcCX3QnSUD7WgJp/kYVjqYWEDsuiZpuu9qY1cf4Uib64cbcoj+rwxF52hOh7oAmVTSusSWXFARGG/pmCBq5/Bzh18@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2qxxVsThtcuRYB6B38r4V71m3u3xifmVH3JA7K+IoOg8KCoQQ
	xv20gN9X7CceUtSG/jnMvr14dvj3HwSjWoS1b/Sk9ugn0HKba1rkqqeTigQDZ1YVR35g1svgPoC
	OpWwZU0yq2aCPskQH1yh0QOK/oystl9eI2jvLS2ub
X-Gm-Gg: ATEYQzw1Iswp0ZgQ/xg7zIKIZy/R4d4/gbI9i6sE4upiVccKmcTOZAQ9Td9WsV7Jrh6
	E9CV0eazaMgA5zJHJD3fXlU80GRIovMAGFY49wHfmm636M8Os1tra13+g1K2Y2eRYMMw/raQrNu
	DXKC1bHJVyN7Ck5M1c6U6Zb1ESjIWvAbLR9PKlq3b/HrmsFPsvf8JUF0Y9rGKUMmCGDtF9eyYlM
	JORtlkV74nRDcpj7m0t+yr/RIWR8JDbo/W4FHN0hyVhMlSTfD7KIYIObY6uymiSdiNFyCbeNtWH
	2DUJG4gPrP2wjw+4c2D8MEUYkxkVWa7ELtZcWrDj
X-Received: by 2002:ac8:7f07:0:b0:503:4bc:c925 with SMTP id
 d75a77b69052e-5076186631dmr41314681cf.13.1772582799147; Tue, 03 Mar 2026
 16:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com> <CAAhR5DF5BAcFO2tj0H63ZoRCcdpDS4Jw9XzqC=L2xWMW0M=0QQ@mail.gmail.com>
In-Reply-To: <CAAhR5DF5BAcFO2tj0H63ZoRCcdpDS4Jw9XzqC=L2xWMW0M=0QQ@mail.gmail.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 3 Mar 2026 18:06:27 -0600
X-Gm-Features: AaiRm51ACYQne9diQMSqsETp8etVEqCczz3Uj5tSioGxwFV-IALILtfuhbSZAbg
Message-ID: <CAAhR5DFVmu5dViPBuwd_nSu_Z4=jL5W83q=sRkNP2bOqW-5_NA@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] KVM: x86/tdx: Have TDX handle VMXON during bringup
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 3:39=E2=80=AFPM Sagi Shahar <sagis@google.com> wrote=
:
>
> On Fri, Feb 13, 2026 at 7:27=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Assuming I didn't break anything between v2 and v3, I think this is rea=
dy to
> > rip.  Given the scope of the KVM changes, and that they extend outside =
of x86,
> > my preference is to take this through the KVM tree.  But a stable topic=
 branch
> > in tip would work too, though I think we'd want it sooner than later so=
 that
> > it can be used as a base.
> >
> > Chao, I deliberately omitted your Tested-by, as I shuffled things aroun=
d enough
> > while splitting up the main patch that I'm not 100% positive I didn't r=
egress
> > anything relative to v2.
>
> Tested running TDs and TDX module update using "Runtime TDX Module
> update support" patches [1]
> Tested-by: Sagi Shahar <sagishah@gmail.com>
>
> [1] https://lore.kernel.org/lkml/20260123145645.90444-1-chao.gao@intel.co=
m/

Actually, looking at the "Runtime TDX Module update support" patches I
don't think I ran those with this version of the patches since the
"tdx_module_status" changes are incompatible. So it was just the
patches in this patchset.
