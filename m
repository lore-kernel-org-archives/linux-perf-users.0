Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6014AA9
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jul 2024 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060874; cv=none; b=PP4Kr8GXX18nc82QeplJLUi1xRKk734jW2uUvFcWVNr2Z9bFrtO6qVcWnHO/Z4KncgVmSRbAmIjz0hvHE/qoT7l2/tbIhZatmiNPMZtw8g/aAd+knz7MwTRo3sYnJ0i81cGeJLPy+CFlYiK2AJcCG8LiyaWcDJgVxp7ebpxkGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060874; c=relaxed/simple;
	bh=gl2mEMlJS2O89e+UGt6UhI56G+G9JoheAX7OSw6XTT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ia1a9eKPBvJhxRwlGcHMBDv29Wo72mpUwflSEGkNXOUHJyw4AmdCztBTKtHWUoLQ2Q+JAzKctJvsnEMb7dkSjWKEl0Xd3tEeyxvZKdX3qnUaUoAvtUdNYny3v7tE4GyJexKb57FGKlsQb59O5Tx6p8gkYKt5Enf8yYnsp+53GuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRpJexOi; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRpJexOi"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e03b0e73f14so160090276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jul 2024 19:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720060872; x=1720665672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl2mEMlJS2O89e+UGt6UhI56G+G9JoheAX7OSw6XTT4=;
        b=ZRpJexOijXosUF1YQFxKZag6Yq/5BbG4m7BFGu1mjZDqgouGbTXDxU7DY0qpsak5MC
         z3bsqV2nKtP8HqpyF7mqmgRd+ubpCg92JO4KRaeEoJDbswUByeCOvNzxddKLSA7kZ3dY
         YUxg64DSJBzVDnHhYDMiiNdRWzWAm7TdhgGaQ+bmWRicbgjpIBAkmE+vLNSLCrf1d4CS
         oKGAHlumzPt6k4N7yqYrQTx38vRw33H4WlPtJSMBDT/U+Tx5GnsBG7oY0WhTtg51rxMb
         cWF6WAw88El3b3WD1T4I+8ETHgxlrvMXn0VDzMBGxh2OH4A0Hhsw7A8CCyJXMtyw6+YI
         gz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720060872; x=1720665672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gl2mEMlJS2O89e+UGt6UhI56G+G9JoheAX7OSw6XTT4=;
        b=Ge5UrKDxQbFEGdMB50vsV5ac3mjYsI9DHEVCYsxfl0NYTxjXmTgm3/S0P09Sddsv8w
         8KfxvcbZCSueewTCZwXLVo9rsGZJlkR638IJYDmpIOsLrVHj6k0Qio9Xzcwe/K4gUAji
         ua/MsfxB1phvtg2njrF1JapZtpbnL5J+dchrcwx5PWqBkx1K4FG5/JtAGvrKtdNIdAuK
         RE37YaXdzgMNO1cW5eBl2xqt/7435OiEeQz9PS/z+2IhWUH3El31AP7F0MIc72XOGkaB
         9jEyvcOraUpDHOG4ub9tk70h6D8kQH817C3BCys0hzptdxSgvsiHRfnH4GQ14KXAA0Yi
         T9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWyx0iVjx3FAPr40sMb2HNOOi/DjPCImTBwStxOpdaHwW32Q4IA3ncwLpCc8l+WWfMYLZ8qR3xrxTNurrxB0PBRYCB22/Nc7Z2XXfcdYR1j3A==
X-Gm-Message-State: AOJu0YzINkyOf8NvxaMbkR8aNnSKd2+aVVY1flh6WThk8gloqtTUUaYo
	TFI6QR5uh/j3fx3BHck7OgxK4vfid059L8c5jNRQHG5SSIiPveoRJQpFN4O8pwGTCEETgbD1VFB
	X2PJjRtwd/W0JmXKKU3FD5mnPaWUELPoV
X-Google-Smtp-Source: AGHT+IFsZXVAjqZyWHMkIYen2zElHG2qY4OXi1Bk9HZOFK3dqPa6i+VS8kZTinRIdroI+VkOM83D8FVZRI02OTBNycY=
X-Received: by 2002:a25:d348:0:b0:dfe:5405:e8df with SMTP id
 3f1490d57ef6-e03c190d77fmr319604276.17.1720060872359; Wed, 03 Jul 2024
 19:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
 <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com>
 <CAP-5=fVF9LVxO5kpyutmbOTC31ywQCO-qgNk3qnqv5rVOf-JDA@mail.gmail.com>
 <CAH0uvoiCX=asogf6e4D8mZ2Yw+8pj3HMTyvYTtQjFTtgKKP6GQ@mail.gmail.com>
 <ZnRP4hJLcRpZzs4x@x1> <CAP-5=fVtutBamCT9VJNJv+nXB1VMBZ3V9ed-mAMtWNaVbygvHA@mail.gmail.com>
In-Reply-To: <CAP-5=fVtutBamCT9VJNJv+nXB1VMBZ3V9ed-mAMtWNaVbygvHA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 4 Jul 2024 10:41:04 +0800
Message-ID: <CAH0uvogumw30VSAjX_RmmxABLsvD_FhEUeUo4nNE6vwBNSni1w@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

6th week of Google Summer-of-Code. Office hours this week are the same
as last week:

Linux perf tool office hours
Friday, July 5 =C2=B7 8:00 =E2=80=93 9:00am

Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Thanks,
Howard

On Fri, Jun 28, 2024 at 1:49=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> 5th week of Google Summer-of-Code. Office hours tomorrow at the normal ti=
me:
>
> Linux perf tool office hours
> Friday, June 28 =C2=B7 8:00 =E2=80=93 9:00am
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/tif-efem-uiq
> Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
> More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256
>
> Thanks,
> Ian
