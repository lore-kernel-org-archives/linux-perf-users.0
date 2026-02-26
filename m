Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906BB83A14
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124816; cv=pass; b=VkIA42SKTxJUSQNCaqyCMTwOQWFHKv/2ttQ07DCwijwd6gPltr3rAkqtpC/iOhM6PfkuX2Jmp+FsvyFkogKmtWKssZ4YGqXGBkLF6rYOSw+0Lbv2FZdJRVNAUstxjAAv65Ar1cz5D2EV7ZOlDt8ahyc1VDw2wT3luKTCb4oBkmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124816; c=relaxed/simple;
	bh=8mYCaDVCRmtdLuxEzHWHWG29fzqsfYQ4bUxiBPX3ZcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l22ZUbm+gnNt6Qx1xevg/J60ZsXAZWgBb4nUC+4jReCoo4+U1XnUrSUgq9TwkGBRrlcvdpckF987M9GZYMr6MzyKbEFeh9plXwYPK7U/WNP4O64lKVYZws5XIlVUnAKkiB9Y84qPW9sMhZafW2SUcAo9qWS9mPz0O5aay+SCwDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvbSzRqD; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvbSzRqD"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124a60cc9a1so12607c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 08:53:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772124815; cv=none;
        d=google.com; s=arc-20240605;
        b=CU/uglovaKkF3aWNCUOaujIkEg0RaoWAoIueuwWRBMOQxP+yJdgyCBnOTwzSNJH0Y0
         ZO59Xy/ByeHp8y04J6uLWLfIGVbFh9eCKEzeVPo0s3YnD4GVIuLANL9BmdAEWNgwaHv0
         +qEhwIO4fwoSYh2EfYawRyKFu0zXimiSSL61MVN2b5Bm4cs+R8fe4rIMaoUUmTsOvZ/v
         CNoIzkq3jdCYgcq0rcUjyjSRM4wh02+gfnTwPADboMYvap6o3i2zCS7xe+psrqJ4bu0q
         9cEyBMs9y7iNp7VNBc0b8TZ259cWsidmvUiz6cv9eDA8/K1SfsJx0u6chBjyHTbnuubM
         53bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PKsVpuOP/YKx2XmBc74MJ/i4TybDbkVfVTyDucBBmPA=;
        fh=y8bBk0J44kmTASTql/JO/4hj8BMNHZH2yQZbFofvO28=;
        b=fArek46PZdfjOB8e3NouTClbDZne6keBSGbVK9cynCCe6LNO5P0orrF1QCcFPSSN8n
         yGW7ur01W3/xL6K50bzu29Y+gee4+DKUwVYVm11kM8mPQ1Fehu/pxqob+HU1JxMOvz2D
         eXyegkJThZN7xzHetDm83uUd7JjYEq+V1dwGUDoFn498Wf2IivjC8aRCOl7oWyphxFck
         8PNIobPOFkdqZ1f6n4QrCXzYsSyJKJeThphorFJF8vSRLAuwBNuVBoL6AimN1p+KVQUC
         2BgpNIQbGb8OGD7zmdh846B41WhGllb4uBli07/mnEvmgPFuw1C8wT3F46oDQNK3+/tx
         lBSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772124815; x=1772729615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKsVpuOP/YKx2XmBc74MJ/i4TybDbkVfVTyDucBBmPA=;
        b=NvbSzRqDx34gRRDuEJDvt+PqG1UchArw4WYAApX2n4c/5ZYwWdgaoFHH5Uq8zCLUN6
         9+XZ6D5iAWGTZ+Bwq8X6A4rcQNOxUw+UY4xdGunez1nnrHBe+oUCKETOe98FL9hyNLtO
         nHhiQ9e038Ggp0XFx85dtQ3xPNxaCgy2y1BVI41EoFlwn/bxpW+v1u1uSq8yUU9SqUMq
         ZTmVbGJrHy/cECJAIMd2kGvyaTgoP8wPeAne+GVnKvc0hX6HGSdMCLex2Dfv53jjbgyo
         KGBw8hTie7LIgMcZk6fikkElxQ19D2YN/uuLCmfxcd4C1+BlO6rv97cr8QG3OMEdMDfD
         w0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772124815; x=1772729615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKsVpuOP/YKx2XmBc74MJ/i4TybDbkVfVTyDucBBmPA=;
        b=aj8Rh2VmwnY78bYCcyQf5hEXmRfzcT+1JX8USzRmdxHk+mHCnSdsPKY5WHjMZUJfur
         4n4efGnwbh/7CbFlDhkCW0smK/tKfv15oc21yyhqZuGjOgcXuszZwLqoOScJo/2TeAbr
         hw0f6qnCrIB+W/W37dEOHbDIFOjwQpR/h7vKaoUvRS4x1NcPmr/uCGawQfow6HDTBjLc
         y1lgL5dhcjI1kBSAhGSUjDExusfZEOJuLlCu33OCcwJ9OEnOE6KuBM9WG2NAOBw4G+yw
         4VCUmE/bEykfclwLv/NLiKGTMk4JbUoiM28N627xSfPPsmvAXSr09UZsS80L0dWhm26U
         OOeg==
X-Forwarded-Encrypted: i=1; AJvYcCV7gLQlicRfkAg1SYgV9N1FEgLjuGkK4lrcDSoSTgCCOYO6KsNah+jJ5IAt+XhJnBXXYedcbXvyQtCnOi9bGiGs@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2Jcd3jc+cOx3wbJnUux9mBq+pnDve/YKy/Xkqec4b2CeTGnZ
	ZlHLawjtqzPrTj8yofuBrnP1mnMc3ExtzgEQypGZUJyi8OMbJVi6vBR8kq0BZx+0sak2C0cfQ+D
	Rk0QKiSngql+7GXXFQcZ3FiqW2zqOr7f72RfXl1b8
X-Gm-Gg: ATEYQzy5Nx4+Sjn4qnG8oNW2qRXgt3COug53V38RYLPqZHLtVjiEWVUwLbDs4tJBdKs
	p2fsecD5n5xTJZFvQHuJs0HzXq3BXO43qB+0Uds+56pcY5g51z+U1EFuITmVPolJcHiiiu1E2ZX
	qZom1W0JoBg9iTscWxgHMm5O31UPL6P5vReCxWYdglXnJgUjRdjZPNQi/db5ddoKVqPAG+2BtWD
	8QQBaRyXyUs/ml0npWh9Flwq68DY8ZrvLx32n1dLKK68KTI8QdSMGNvkEYHqiuYnr91l30+RhiW
	k7izUhYpqlU/lX6c3x3LHgmSj0+QlJ4CbLHQ
X-Received: by 2002:a05:7022:e01:b0:11a:2c18:9e70 with SMTP id
 a92af1059eb24-127899996damr181762c88.11.1772124814159; Thu, 26 Feb 2026
 08:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216042530.1546-1-ravi.bangoria@amd.com> <20260216042530.1546-6-ravi.bangoria@amd.com>
 <CAP-5=fV_cJskvLRZhQQXMGAcPUb_Rg_b30PDJNXzxL49JK4B5g@mail.gmail.com> <8b99652d-155a-444e-8395-d461714bf4b8@amd.com>
In-Reply-To: <8b99652d-155a-444e-8395-d461714bf4b8@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Feb 2026 08:53:22 -0800
X-Gm-Features: AaiRm50lV5MxPOqbszA6pSz3JXPp80Lne4KOF3F5_GEzX1kRN8xd8rV3BdseV3A
Message-ID: <CAP-5=fWP75UJ9C8kjBzhZS26rHD3Teq+ECg8Vb6goAA2bmZKEw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] perf/amd/ibs: Enable RIP bit63 hardware filtering
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Sadasivan Shaiju <sadasivan.shaiju2@amd.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manali Shukla <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 1:20=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> Hi Ian,
>
> >> IBS on future hardware adds the ability to filter IBS events by examin=
ing
> >> RIP bit 63. Because Linux kernel addresses always have bit 63 set whil=
e
> >> user-space addresses never do, this capability can be used as a privil=
ege
> >> filter.
> >
> > Since x86's top-byte-ignore/linear-address-masking leaves bit 63 could
> > this break in the future if the kernel later ignores all bits,
> > including bit 63, and user space wants to use bit 63 of the pointer
> > for metadata?
>
> The AMD equivalent feature is called Upper Address Ignore (UAI).
>
> o Identifying whether an address is in kernel or user space by examining
>   bit 63 is so fundamental in Linux that the UAI design was revisited in
>   UAIv2 to restore bit 63 as canonical:
>   https://lore.kernel.org/lkml/6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.f=
astmail.com

Fwiw, throwing in my 2 cents. IIRC bit 63 wasn't canonical in the
original ARM64 top byte ignore work, it seemed like a legacy thing
added to keep older x86 drivers working. Imo, this feels crufty like
passing the number of float registers used for varargs in '%al' and
the lack of non-GPR callee saves on x86. Given APX means we'll be
recompiling all x86 binaries for the extra registers, it would be nice
to have made these issues history, given runtimes an extra bit (2x the
encoding space for metadata), etc.

Thanks,
Ian

> o UAI applies only to data addresses; instruction addresses must remain
>   canonical.
>
> So I assume this should not be an issue, at least for now.
>
> > Does the bit 63 assumption hold for guest operating systems?
>
> Yes, this seems to be an issue, even with current swfilt approach. Let
> me inspect the code and get back.
>
> Thanks for the review,
> Ravi
