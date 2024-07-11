Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598516CD1A
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715160; cv=none; b=Rkj+olu4Yo0/vyc5J8tmQpqOmi9I8JRfZDifJTFCZdiq1PO+uTsIKf3lm0VWKXzlP9ESTYpqOXGbWbIcpjzXAMng+cKyQ3n/DXA0Av3G8YAQXEqBo48NuQYqUgWk2CN3HmXrg/4phlJP91C/4Pj8MQcHiFe5zu4YvQCE4wU0tZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715160; c=relaxed/simple;
	bh=5nsfvlLmhEPvRyUz2fxoPUUNuIRC45SdUXSsV73mJFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlDafL3P83pT8Fs6FT2IeJzLznVtJqfaQzuvff15jwqthkHGfWP/FERQNjHkIGsZTClAI5vw2+i2dNgVALyVST0r3SXR0da46lBEkt/P8GSFFoRcX1h14tas1qASaizX7Wb4vOtKdgqfSzAJkIy0VY2rb3AVLw0lfDKM5Leg+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkixohSf; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkixohSf"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44e534a1fbeso26191cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720715157; x=1721319957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SEpCiUOQvgPIzDLhrNd4BFzg6FCRjdLml6RucYrX6c=;
        b=AkixohSf2wGn+th9OSaSUGSwGU3Roe12V+l/vKbPaQ2F4qQslvjQrIR8mijRC0EGG6
         FGcsSKkZWh8+Sdf9MeKKR1/1pK//Rg1Jrm5XNKfwj/MVi/GP8VbSfWnxJUi6Hj7kHuZg
         m9B3oIM+eAdNT1gHDhuwsmb32vz5TwtpeBMpVhkxBRkXGKnsqOG0GY5ExUnz8wvTpnbr
         5ULrjn1PRxAwdC09wePUXyrSRb5tNm0sylNcZPTksxvCngXwKqNcQp9COwIk59692+Qa
         WkO7OmsglvGkeQ6DHm+jrj8a1uyjNXFEjr8LVF0jdHVY7h0NYixrgHQr8+0vyd/wQufV
         XiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720715157; x=1721319957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SEpCiUOQvgPIzDLhrNd4BFzg6FCRjdLml6RucYrX6c=;
        b=KMs5nMkYpX738U0qIelZqRoEiGDLyQWJaMQxjDf+8nhBRFxuSLiaZdEwWcrolZu/yj
         d+jginzTVO5mZ2mduaROMEV7i1+45C6RsXCpf+aeAAJSQK6yG0RkAt85TwoKTQGSWi2E
         P7e9xX19JEyjse1CPrCcdx3tk3Rqr4i0DP3o6ZxWlvAaDH5OplVI3nesD16oUTwT+Wd6
         /tTHdvSnxVEJrsW/MQcibw9hmTYoSRXYqfx9LOKHfuE+AOgF72GwfIFQYZ1ojIO6xZj2
         ghONBzV2GKd06GGgYtS1TIr/cEQ8Bbpf7aW6ZpGF5yTmn213zGJz8p0rQtNL8iwMndAo
         a/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUkKyleWZt5rAMTLWfntbg/pmZizd2ig4Q70vCTZ5be0uyx34Xh1YUGWPmLsr4EitvlBhlhyJ1eogFyHioGuQeybiEmo/37nSDXXMdZKSL7ng==
X-Gm-Message-State: AOJu0YwpW/1oLaFs1gScvUqZjmjMpc4YUp5TRA4sCTJhNcDUETESupoI
	D2AFq8mHSqvM8WNHgOoJWox9rjwmHzSi029Mb6rSD5Fn2bb3buOJo/vV6ouL0s1f+TNLN9ZAbu8
	eNfkAZRvsjEToDXOqst5jjVqygbY0d7E609mB
X-Google-Smtp-Source: AGHT+IFPOFlYJtl+9KpTPLHCZ8kBfntK/k6bdea6y4VDGrLMHW2XyoGDDVRfyezdEAeoi6MASDv/Wa37jmIQA3eNLAY=
X-Received: by 2002:ac8:4c9d:0:b0:447:d78b:fdf6 with SMTP id
 d75a77b69052e-44d0aa44ee5mr3767161cf.10.1720715157365; Thu, 11 Jul 2024
 09:25:57 -0700 (PDT)
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
 <CAH0uvogumw30VSAjX_RmmxABLsvD_FhEUeUo4nNE6vwBNSni1w@mail.gmail.com>
In-Reply-To: <CAH0uvogumw30VSAjX_RmmxABLsvD_FhEUeUo4nNE6vwBNSni1w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 09:25:46 -0700
Message-ID: <CAP-5=fVNC-bBvkg851705msG+jA_Qu8HNPPX1evqDD6TM7ZrVA@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Week 7 of Google Summer-of-Code and we're around the midpoint.  Anyone
with a perf tool interest, please feel free to attend! We're happy to
discuss perf tool issues, Howard's progress, issues of the day, etc.

Linux perf tool office hours
Friday, July 12 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Thanks,
Ian

On Wed, Jul 3, 2024 at 7:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello,
>
> 6th week of Google Summer-of-Code. Office hours this week are the same
> as last week:
>
> Linux perf tool office hours
> Friday, July 5 =C2=B7 8:00 =E2=80=93 9:00am
>
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/tif-efem-uiq
> Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
> More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256
>
> Thanks,
> Howard
>
> On Fri, Jun 28, 2024 at 1:49=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > 5th week of Google Summer-of-Code. Office hours tomorrow at the normal =
time:
> >
> > Linux perf tool office hours
> > Friday, June 28 =C2=B7 8:00 =E2=80=93 9:00am
> > Time zone: America/Los_Angeles
> > Google Meet joining info
> > Video call link: https://meet.google.com/tif-efem-uiq
> > Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 9=
68=E2=80=AC#
> > More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256
> >
> > Thanks,
> > Ian
