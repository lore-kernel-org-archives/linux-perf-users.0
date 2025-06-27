Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FD62E9ED4
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043329; cv=none; b=Az9dLdkiUUhKwcdbPWYlUyt4kdJI9OKGedxVh+kjn+nVCq6YUwPxqIPdDZgVdxXm5gX5YMVI1zAOJrmFtNAOYmSvqj4e1MZAD/g9sBBuO1u0vEzumdY4BHejV7BP5cXeU9cdSLblpBbtDm5rjSeudA3P8FsTPeZ+Fi8gZGT2XDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043329; c=relaxed/simple;
	bh=WzuNp8fggmNQSdOMdCp9Rv2L2qJowlPOrqD/MfoEN2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw0KOrTPcv59Xbph0mYRKSqDXyWychfzBI0CMk9b5s88m5oy4w/elicNTnXTbInNo1wtiq1rHNPdPs/esKqFOh20Mh18CM2NZZqM5lLladCjEKPsIGgw1UVKe6sGONpd5M4uvyLyiyU8Iu9/1J6FFqB9aK16OoWHfmRhb/65w1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fC0QAzTV; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fC0QAzTV"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so14725ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751043327; x=1751648127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzuNp8fggmNQSdOMdCp9Rv2L2qJowlPOrqD/MfoEN2o=;
        b=fC0QAzTV4BP9BuVx6X1bN1S8/6V96d6Sj1VrZxXcCwMt3yWeZOYYGeb8RECeI26GXz
         z+TTdkbnGwBxAmgNLsbDrY8/a9qmNvELI/N+xPUoiczG7FmUX2Sn5lwlK2oV/3Jl70wG
         ATxc5/3Smsib9NcsZHZvDuxLDXfrEx9LgIxlUkE5sxB8xo3OHGH9iZyrrHxZzeXkNdva
         kEjM0PsUoqdncJljllR/fOyFQZgcNAoUlffvYwSi1eLqCbhxEFFNP/v8doUjmfTqhZcG
         xvirimfP7co7Dr3GI9EmBxxMg15iYaHr5uEKC0rYPA1pkeoJBD6MXBq9XKIJgOQReu19
         e1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043327; x=1751648127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzuNp8fggmNQSdOMdCp9Rv2L2qJowlPOrqD/MfoEN2o=;
        b=imDiBEnD3su7MQZZZ2ERBYmD/yyTyJsl+awFY1vN/XZJjf4ul5j4nIvXby19VpTJpe
         i2J/YR45zqM/9bpmYA3X9Ke79xX4Mi1m58Kt1QUEQPb0jsFoidWzKeT4V835EjDRnaNM
         GuLyPRa9Za9RT58AvrUaJ/TFRkyCG29yAX9UhD8+6rMYUBTyhe5I+fH1Nr87W4QhAqLY
         ZZ5ezRnCq5QSGVpY3iAT6qE/IAqj5QLNnmOZftzr92oZ0/F0QAwJ/xLqOu6Pocte9kZL
         bbXuMrp0n2DjxRfCr33gUSE1Bdk1mnEN6CZRs90WqUak0g3EkNux9eyruUUwgcU60bH9
         ysaA==
X-Forwarded-Encrypted: i=1; AJvYcCUk3PF/svx0CLn+R/uzw0kGKT6OxrZ1Qkb9D+8qreQGZdERdMtiwd7S4vTuIIhOOE6oTUIwcaZd317DAacjJbG6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrgkcz1v0UxX6ETpzEq2VA4O8KsN/li2Y09/cht9DngBr1sv++
	ZmmZ8iQ0C5UXCNxYO/l5I9C80g4559m6dVszaOsc6lduQ9LjgS0sPhbpvrYrn9PB3T6wxMP2gUd
	DOTZ4AVeq3jtDCX60nd0sGFDHzZx4iUWLckBOG35i
X-Gm-Gg: ASbGnctyB/a0bNoO1MeQ3QJwiIFjLwrvmmBBZXwBB0AiC4/gBdjZ2IuGtmhRXDkwliI
	TNDyzBtAFFr4d8O/mNfcjkVqZy9cNFeVKasON+6veuAV7MDWKtRnIAu+JWK65vKOqf0c4K5zqhv
	wGQyfG2vkUwRbTSpMLjkTFFmuDlnv7WOnwJ+dnnUDKk8sn
X-Google-Smtp-Source: AGHT+IE5bGgRxFzXmQ/GK/K2hDeu4kZV1vxh0NaCBm134jFcoqYIxFe7n/gmLkBp4tcqZHW1FSxbKy0H3FhyJhjAvAs=
X-Received: by 2002:a05:6e02:4719:b0:3dd:a562:ce54 with SMTP id
 e9e14a558f8ab-3df53c25bacmr505685ab.15.1751043326954; Fri, 27 Jun 2025
 09:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623132731.899525-1-tmricht@linux.ibm.com>
 <CAP-5=fV_hXzq0A-91NakejcQGnvPp+uJGGe=vccwM+47JVCmtA@mail.gmail.com>
 <ad905a68-a89b-458d-8a8b-2081a6656b91@linux.ibm.com> <283e109b-9eb5-4e7d-b7df-215f54496503@linux.ibm.com>
In-Reply-To: <283e109b-9eb5-4e7d-b7df-215f54496503@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Jun 2025 09:55:14 -0700
X-Gm-Features: Ac12FXzYMDHRBdMmNG-uDcOa6V7yaYqEFMkI9NCQ5NDul3g-e1u9_oRedp0lZFU
Message-ID: <CAP-5=fVcNqE9txXQgO+EUV6xz3Mvsqin9FP8FNUztPp35LW2Ng@mail.gmail.com>
Subject: Re: [Ping][PATCH] perf list: Add IBM z17 event descriptions
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 1:13=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 6/24/25 08:35, Thomas Richter wrote:
>
> Gently Ping
>
> Ian, I have responded to your comments some days ago.

Thanks Thomas, minor nit in your explanation the events must exist as
they are in json, but the json events are only exposed if the PMU is
present, so the has_event is more of a has_pmu test. Maybe we should
add a function like this to the metrics to make this kind of case
clearer. Maybe `perf list` should test the events of a metric and hide
metrics when the events aren't available to avoid the have_event
logic. I'm a bit uncomfortable with that as the events may not be
available because of permission issues, but it'd still be useful to
know the metrics are around. Anyway I'm digressing.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
