Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150D30C35F
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570669; cv=pass; b=uxR8RdNwllddba3VBGPdWPEJWzM6QSGD5qaq+FMQ/9fIRxKx58u0cTt1Sn5pTEstu5VLZHyVBpTbJ39cbXXBPF091PZT+aoOyzKpOEqrU9ZuBt4s2ce/Xi6nuIbKvYsG0S01u3Yc78kKbEbCIe/WxHzsezHwS8Z75T99WKvfQoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570669; c=relaxed/simple;
	bh=6TcJhsAFwAe98ARop3zlCHVHJXLHLIZfv2Lk8irIkx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twUuRjXd5QoZKVV7qAVKCSgAamR25EDvkG68nMlzTAN8U1XlLfT8RSQeEb4TmTmTfWB6oT0l5/8XrNvpkI5QoFVxMAg3CNeXpsm28dtU3T6SfK0zwuy8nyyTs9pq+hByJLEV0RYstovJwCcDB/cbUHZZITPHknpxjedLC0E1Ih4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMPBoCjv; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMPBoCjv"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10e86e52so24231cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 14:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786570667; cv=none;
        d=google.com; s=arc-20260327;
        b=E5kukVnozWbDhCNSaZ/DZ+HUhqFnBuvcuGhKhM4UglIAPZq3w2H+6HvYdVF8GHRlMi
         AuQZWV+HXlDbCcmG/2mFjrNHvz+MFof4WJ0WRFm+BbCj1ONE+bhUMJt3VYd8OnWATm7/
         NR1TeD11BvAKDOqUbN7VHb/k8FQBt4QqYkk0BPaX0Gb5OwHSKevCTlWuw1ll6i+G5LNk
         Llun5sdwadP4sQH8TuGNenEwhQBzy/mvIpY1Tq5syy52ONskqJXkKEsA0VTiledrjbgm
         JsxBgM4YtjaKHtIho0LdPb8jQPNGaZ1qxhm/RczqiKrtF3fWB7F0wdgHyAWgFne7zyBV
         uGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6TcJhsAFwAe98ARop3zlCHVHJXLHLIZfv2Lk8irIkx8=;
        fh=z0QspGeJomA1dg19H4pv2TO4Gi6C6dGXIY970VMCILI=;
        b=MV/kXOxHBkufj+HsWUD+lQiU7VVePobbY5AiDuuenU+Q9ixXKNUweF2BvRKeR/EYIN
         493SD6ILpIo84j8jp7mJZGd881uDxwQMBtooFrwOqpNjCOlEklcdbivWN4mOW+PX9jpc
         nt5EQwMkNquIVFrNdTxSaZU1lXgW8BkWMDFh01dth+FzmkFlGy1zqzu3diiVFt1+3bi1
         NzrqCavBRN6yu2RxED+QzjLTbC/J7mWL/XFpzuZAT+3U/xHCz4Ha1pKwb9j1iaXPGBMn
         Z7oYY5w2EIonvQP46d35YIru6/RozeaouOSp35P3I6kLqwnLGadj954djgyYGeKKoyMn
         KTrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570667; x=1787175467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6TcJhsAFwAe98ARop3zlCHVHJXLHLIZfv2Lk8irIkx8=;
        b=eMPBoCjv4hEstBTh4noswhO0FkqScthQusftsDZnTmYJif6oYOOnk4UnBqJkwOPYaQ
         u5PqyReNwc7v9mY188ZHDi44rcexyGl2ZRbuAMQRFPU50R6+pf9dUw4sBM/Zi+g7pzor
         qoZj6GAsUUdZFOv5GifBHoRCdvu/fjvagliwj5vOsl/FG5z6jCa05C2BpDPtTvUWaUhq
         Rb1PVLwEcPoN3RmFqPN1OhDcuLXmHrIkRcLaXADiN0UQv3X0daIeEIyKIiIiteOlU79Z
         vu/NAU6uGbhk8HcUvaQlZGRzBOzy1BUwPnY/fGorpmN/6qxuBNYHrko2lC0Krj6caIRU
         chBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570667; x=1787175467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6TcJhsAFwAe98ARop3zlCHVHJXLHLIZfv2Lk8irIkx8=;
        b=cyM/P7jpqVxlvxB+dNuNn+ib7IQh6YVxmuFTGaLLJv0uC0iPIYTWP2++o/rLq7A+YE
         Yq+M4paJfFrVYCjyrVR/w/YL4JOVLfFf0FnKBouT/dKgVh4bVBRdwG77XqeIuGbX1Ht8
         +dxt3t5VtVnP7h/8cYMBQz+147yJxn/NracD/hnV97Y6EH5VLaWDTVLol/oB2sXtu0Rh
         R9BAunuT+iVCYhoNHx1YgnZiAoDbfwn2+k/Dj1cRxkZiTULSqOICyoaQw1nT2cRrDJ8i
         GoOMWfIXHfCY4TMfLhDQYXNBPACkZYO38FaSHpqG4iXXpFGhG9ckIP32dKnWVgEboJA0
         KIxw==
X-Forwarded-Encrypted: i=1; AHgh+Rpk08HCiCe51gmFuEDpP9uen6/mfkb0CsMRXHZ45ShbglJVznLKw14n5FwxdjufHV114zZN/HUdQK1++iAvDdst@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uxpb72jZDa2YNEIF8gJYiinaRtYUObSVInk/0t64QJ0HRdIo
	bwVq0J3BYBy+7bYF+RlHyw6NR3M8OZCHVGAPRBpU0FUpMjBMoJcqVNP5XkA/tHit6vyCc2mshDm
	JBlskKdlUzoBsqZNMdtO1Dfk1jckAxUBm3cFE0FKy
X-Gm-Gg: AR+sD111iO+FG1F+UGNZBSYsVq2LPTaPFRlVvAH+0gCOJWvrsmOTrIS3O0qgpyqVP0H
	0x1YIHWaAKjUk0uut3U8+l+qFxn8urJRSQsm1TukwKnX5tv54BcvwEJyx5jD/8jFCI18J3/gRv3
	euxtvYMP3zWFFFRYalYzCLs9FahCzZEanLyW+0L+5mAA7GzuJdxayGhQOSTIwurXHL8YchFMYUT
	sjljxZKIjJKrsj7iODiYI7x4Et2cBwgDyOwvmMCB7RduAlP2i02oFzdEGSFXHe0e2XIRdDtwPCk
	/3txcxA4oUCtGZkebP3Ky8tdhK7Z2wJ//X7y6bNWGEtPvQ4eAVwwaCC1
X-Received: by 2002:a05:622a:8350:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-52d75b5aefamr559341cf.2.1786570666092; Wed, 12 Aug 2026
 14:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812002728.2283079-1-irogers@google.com> <20260812052417.2361040-1-irogers@google.com>
 <anwuYYxLFbtDmmHx@willie-the-truck> <CAP-5=fW9bH_yd2VF+X1jnem91+dOHPjP53uNQ8x69xFmjLbt4g@mail.gmail.com>
 <anyd_NS4D8KRIuEW@monoceros>
In-Reply-To: <anyd_NS4D8KRIuEW@monoceros>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Aug 2026 14:37:32 -0700
X-Gm-Features: AUfX_mx6ue4h2BCdjm8EeHV11VCj8h9Rkk-sVPRcudhHCV3w57x-st3Hu-QMgc4
Message-ID: <CAP-5=fUrvxsJ09BtPy-3beSoypBG6LaNjX1iL4aKMMEC8LaH2Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Will Deacon <will@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 9:26=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Ian,
>
> On Wed, Aug 12, 2026 at 06:38:24AM -0700, Ian Rogers wrote:
> > The changes are sent in reply to each other because the entire series
> > is visible in one mailbox (b4 mbox), which I find easier to work with
> > and provides me better context. Others use semcode to do something
> > similar, but I've not explored that.
>
> The usual recommendation is to start a new thread for a new revision.
> Depending on the mail reader (configuration) new mails to an old thread
> might or might not appear at the end of people's mailbox where new mail
> usually lands and so might be missed.

Yep, I agree. People who configure their email client so that a thread
doesn't move to the top of their inbox upon receiving a reply are
prone to missing subsequent replies in that thread. I suggest that
people in that position change their email configuration, or use
lore.kernel.org, which doesn't suffer from this bad configuration, for
example:
https://lore.kernel.org/linux-perf-users/20260811083828.2057695-1-irogers@g=
oogle.com/

Thanks,
Ian

> Best regards
> Uwe
