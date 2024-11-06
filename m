Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8E2E414;
	Wed,  6 Nov 2024 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853004; cv=none; b=KQ2V7fOrRuqhh/NMkoliZsv5KzXJ5WcHDUx4AyUKfrK0ScOnHld0ccLFm8KD0zJA8QYPij5Qo/jlO5BkfZIrooUnd0op8uGj5poMRtp9WFI5oWFaF2rVGEet2bGZrjI3QT8geqChpe5QGLFpsh4bc2k4Zs3bFNawSaTOvE8IFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853004; c=relaxed/simple;
	bh=SvTZ9anqdqLkDP9mkBXnlIduEzxiWw+Kp1hFVBLDlWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/lxKKllMHAlG9g5mIcy/jvSBFUvvH/RnWM8cJjbNUxv3Lgdshf0AXsL676nCO8fy0XhRQZM/Cjzdjr4LJi0sexaN1jF1o5Y60vSjrzpDeHkktSpfUVf5pOzLFNH443grRqWKvKUZ2yDTzJpPHoBBc69dAcVZgSBpvgrqrJGF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxS8m9rO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxS8m9rO"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea339a41f1so52833247b3.2;
        Tue, 05 Nov 2024 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730853002; x=1731457802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvTZ9anqdqLkDP9mkBXnlIduEzxiWw+Kp1hFVBLDlWM=;
        b=PxS8m9rOMEYz0uHCXq1rAXdSaE/B4zYyMWkzD/WFTUPe93pjr1QFOi921zRcYhTNwz
         fgW8XeDmGbjwl4Xp1/pWZYuarcZxetJ/qVlTUulgPDFT7rBv7BOdQPrnjCm+f3+A5JKJ
         kZKjzPJG8anuX+yFxTzuDf8f3ar9YnihvBCnNQjrAhTCRJEqb9GOZZ4YrSxKtOUcpc09
         9Ejib6JsTxQFbb9V58zrQRU9y1UaREZdCF7S3uEk3XCJzcNj8oF9KmlY7uy6pcc8QphV
         RBVFftkw3HL34SAgYfYjFZC/BVhPmnb9iU8pLyQx6AXpesi/NbUeHZ5OhYZjSkNl4M9F
         uJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853002; x=1731457802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvTZ9anqdqLkDP9mkBXnlIduEzxiWw+Kp1hFVBLDlWM=;
        b=iYhr659pnFvXf40vqOyoobBh7GpvHshlDgQgFVfVnT/b180yDdTkj2lG8Qp6n13SN3
         R8Qr3zKNo1VCrTB/ky9pDpPtjoE/Hlg0qi+/cv3Ty3bjU6L14+uMQoMLQB6CDBZp2Uyx
         KpJycC7QbpdKG/rdmm9x25hJ2DLTU0eMXX8N6uUM7sc30LYt3VooU00vNAsHHXNINQPi
         3PtzX53EhdeeEq0mRaUDiogsYIxO4DBm4snLsffxS0JU1jc0pch9NuwClnbkCm8/HAUD
         tpPfOEsRh3tm3bWjwoHPuzSnIKEEhg596Eh8/nH5GRtz3qedfZHzmS1CHDLxPtXlxrGF
         ToOg==
X-Forwarded-Encrypted: i=1; AJvYcCWVkfRvY/OQoMXarNra1FBsJpZUh86N06I4nSKh680rX2eUfdvgOg4q/36qej+432ZsYkseK4BrMKJ+KTjCLPMAVw==@vger.kernel.org, AJvYcCWmtpdHZxNN3FX3bhrQoF9TAQ7mpSbjNjEYcjhjDVc5JNDUQPVnZCVZlOaii6Ye9djjKCFIfosrvhd+zsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUOOYuudlrxKt6VjeHy/TRFjVlgvV+oF/lRdYjQtLvLLsaEud
	JQtNLTUsjP6o/29rH9RYCw1bqC/nWX1L/rXUTQJVc+cjXRHyz4VspkRmBr0Kb5O+bsyJbOavgdm
	5oA7nnlY2AxFQ5ydRke6y5+PRyXTeloCagNk1oA==
X-Google-Smtp-Source: AGHT+IF3bFUpeU2iENfR1omoILaQqFbe3hskL8zeNMNJ6Lhtk8rni9S1T6CjjlIXlVSoP/UMFjAZC4X2STJj742A+lA=
X-Received: by 2002:a05:690c:25c8:b0:6e5:e571:108b with SMTP id
 00721157ae682-6ea523216f0mr218477547b3.8.1730853001537; Tue, 05 Nov 2024
 16:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105070046.424750-1-danielyangkang@gmail.com> <3CA737FF-2F21-42CA-BF95-5F0341F6B68B@linux.vnet.ibm.com>
In-Reply-To: <3CA737FF-2F21-42CA-BF95-5F0341F6B68B@linux.vnet.ibm.com>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Tue, 5 Nov 2024 16:29:25 -0800
Message-ID: <CAGiJo8RyjXdgNqyPNhZFJ_5oH0z1RWeXnM6RGnq65KCDbyp6DQ@mail.gmail.com>
Subject: Re: [PATCH] Use strscpy() instead of the deprecated strlcpy()
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:25=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
> Hi,
>
> This hits a compilation fail:

Oh I see. Apologies, I thought compiling the kernel also compiled the
tools directory so I didn't get any compilation errors.

> So the strscpy here is defined as strcpy itself.
>
> Ian discussed about having an strscpy shim for perf here :
> https://lore.kernel.org/linux-perf-users/172892779710.897882.149495430825=
61189584.b4-ty@kernel.org/T/#meaa2f8d993c6db435f9ed399dc1bf10132a31292
>
> So IIUC, we are yet to have the safe strscpy in the tools perf.

Is there any issue with just porting over the kernel code?

- Daniel
