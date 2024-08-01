Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB201482E2
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722543320; cv=none; b=Pzo/C1yNOe4+Noy+xr6qY9qV+nQNTvtVNwYmx7r87YDrJs7Ud77rgRrsNXsTRvHcbAVfCvgJfRMrwWrUtBN7gH2+r5gkZEAHOsmGSTJPqB2zSWQnspi5AYK+k6kOO/T3ljrtcf53yiJMZ0N4WRXoiZlt89D1QqHkJvUhb+8tEfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722543320; c=relaxed/simple;
	bh=tt8T8jvzx7JsMy8e7Z2plBd+e3RVrfH2al/W1GhtYj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=osLcJIJu3x2SU4eBIiwL5tS0K+RO8g1GLbwBWXAh5AYrMBAW9J5joz/qbMqCvHtf0rTZMuWLEotQdj1o3IdHY620kxGcy3Mlr5d31k5mZdzRlGCHYPHOUaHRUswRNdos+5t6XCuSOUTSPiITMZPS07bLixLmAlg/llMP9GfFv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ejrtas3A; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ejrtas3A"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fed726aefcso436085ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Aug 2024 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722543318; x=1723148118; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt8T8jvzx7JsMy8e7Z2plBd+e3RVrfH2al/W1GhtYj8=;
        b=Ejrtas3Ap0flInfEhNmhpcqy8aFSTbNZm3+yU0IOyZj7g9aljmLHFEEv4Aj92waD5x
         oUg0mPdwHJv2RuaUL7plwjwEOQGmjCWGH1OwGp9pKUHbSpseLWNoLlRI5a41qHTfHvnQ
         Sk58D/z9iz5YxBAZiL0ZIx+SupOxSIZMLJFxC6aJGwekT5jl5fjNqOQuBvWMMmFFk6pM
         E+NgNW4LXCCFRqmkOor1qPtPlXDsvd5TQt7219rPO6tOOKZtOlXeCzXH6PUVudnR3hwp
         IVFqEE39CNKmIo6vbUWxMPfYeqhOavURvxVxV9C55agiYUodRLCDa6CsTmaloHJ82c7v
         ntFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722543318; x=1723148118;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt8T8jvzx7JsMy8e7Z2plBd+e3RVrfH2al/W1GhtYj8=;
        b=QPcAvEBjLgnfzMlCEOkHok3jKlETfDZ/52GOF3sdQOuQYIFlWoY/Ua+AzShWOiiq5S
         Ou/KJ0bPqI9Rk1OynO22b+H/vk6JrWXFIbuAaOCuGEKr640s/UlcR93J7szMvTKSlI7N
         VDkRE1wLmiQKpw3ArZuaGcu5yHGn+OgSoOnhGACs8P9qNgRmqqpAmeU/D/z2qmGsJIju
         lx8uJ7A9XdZyHPohikznPUqb0Mk9ymD5d4ZtMR4xi90QC9x0vm6RZAaxFLhvtkxs5fDa
         blvlK0iMV1AMdc6SSw0UJ8+FWASIyDqZTbuP0KBcFV2M6cggzlr4kOcgcQG4TIE3Q/m1
         vX8g==
X-Forwarded-Encrypted: i=1; AJvYcCURgGzr7sFPUal/rOayC37+zpiygpK5cD425nf9fGuMXK4JJwjnqwBLxxBgdFK8lZoJbY9iskSeGf5YtfGNlYA45iIhpe6Xxb/a5AzPHVuQxw==
X-Gm-Message-State: AOJu0YywvX9HXjlGWePtH0Y4R9fi6K7NfI0RkC94Qr0fpeft9/3jqyKV
	s2HK/wCK+KZnBoyXwHmT6TSa+jCrXTITSD/wDIoN1arVQO06hubGuo++6uLOEHdatnXouD9XCDs
	R+Uyd8chWJOM8CDWWKUQcFV3zVTZBNvoyGbsU
X-Google-Smtp-Source: AGHT+IHfUfiGBei+Pr1I57cwslQD53Rpm9v9nk6p3bpiMQcsAgIOfDp/4I5CicXlDIG9dsbeg3WI8uGrdTZiWMKfpQ4=
X-Received: by 2002:a17:903:18a:b0:1f3:61f1:e340 with SMTP id
 d9443c01a7336-1ff5c27ce4cmr21405ad.13.1722543317939; Thu, 01 Aug 2024
 13:15:17 -0700 (PDT)
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
 <CAP-5=fVNC-bBvkg851705msG+jA_Qu8HNPPX1evqDD6TM7ZrVA@mail.gmail.com>
 <CAP-5=fUSMDhooNetywiLfcYEHMPeyPaGHuBhJHUb34zM8DqtQA@mail.gmail.com> <CAP-5=fUbJcxO=h65bqZ2nx8UTPHsapOVsfcCaY=+q4yO9YBY-A@mail.gmail.com>
In-Reply-To: <CAP-5=fUbJcxO=h65bqZ2nx8UTPHsapOVsfcCaY=+q4yO9YBY-A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Aug 2024 13:15:06 -0700
Message-ID: <CAP-5=fVazh93ZRqyubCC1MEE-thDKoamO-L_d0-LZjNyYmD0vw@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

A reminder that there are office hours tomorrow and we're a few weeks
away from the end of Google Summer-of-Code [1].

Linux perf tool office hours
Friday, August 2 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Looking forward to seeing you.
Thanks,
Ian

[1] https://developers.google.com/open-source/gsoc/timeline
