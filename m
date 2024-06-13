Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3DE1E519
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286508; cv=none; b=HOmHr6d21I5nL5S7ICJtZa1Crao+AwdHbvtGRppGKq4QcEGfXdlJb8Zd/Fk1yzvfCAKo4Nq+gWFs1+5DWD9rrYJLUgytX7Qau77VywGSjYr4WGlqlr58ymRt9n6s530v7X/ZVmdCqKrWBEbBGik+TqdBelHUqtpG/IiP54aHXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286508; c=relaxed/simple;
	bh=CVGRkuKZN8tL9dIgYW9AdXLHSULaMuz/Q8UAe0uT92U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CkrIkiWk5gDjUxZs72sCVXJuwttwy8XDSeeT/Pn4efUtwImapDmBSdWeqLYVdd9Uv2RFdWJr1at6STot0HD3s6leO1XrqlR4Wm80kl6BvBrgs3TrtHY5ATLq7mMoKhtipZcimiRSX/BZ73fSji4821mMZC3aEpd68FF/cCsnWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zh3a+ugQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zh3a+ugQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso170805ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718286506; x=1718891306; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVGRkuKZN8tL9dIgYW9AdXLHSULaMuz/Q8UAe0uT92U=;
        b=zh3a+ugQYAnYeO3iMJvmvbbyGch8Wrsn60zkz3syrDrRHQg0ap3xYDAMNYodWKFo9f
         soZxvKTkSQ10/fS5q8xJEEiEPQsrK3IsE5GZB+fECLLXuy868pdVjqNNnkEZK2S/vgsc
         iiytkrGEUvuEHx79eh2xjFNw0B4NhPrrmAsxr2rwtmBtR4cxhqDDY7hv6Z+P2ZBndhor
         V4rCWxJxPnwukSor9i6Z8iasMphz14fzMiR7/B1rLSJ0AnwtnSlVLnWTZMGsHvc2whHc
         GXrYYqms+iypf14nelQO/owzFhV5MtUbZ5NM8Aek9HOQo75lnY7pmmbm0AFo8oUp51oo
         G0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286506; x=1718891306;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVGRkuKZN8tL9dIgYW9AdXLHSULaMuz/Q8UAe0uT92U=;
        b=oOiE7ErTtsioF4Lv4YxvvlsCb9YIX3g0OhMa8pqvY+RBaItwjLml/aHLm0IzkxHCnc
         +Lew4HlfnpY00C2y1q7R2oHfU7D2/0ZgK7VI9/94wursbOMSxZoAjBJ3fpNx698UFh9Z
         8T9pba1NSNTupSQeGCbONg94t8bUnQCGRnHj8pjA86yqDvgr2/xVmPQ31uNQTZGPevid
         QteuqvDhfztDYzun0mcdw0SeQ5ATVN9D1sdkgHZi4oo/kEYGFjoZTAsg7wyDzKAnMG6q
         KdPFXzc30j4WpcRbeO4vcyJGFYj9WUGSLgsEtHYDMyssQbRWRgCQwtdELtmdAuPQWywr
         AUjg==
X-Gm-Message-State: AOJu0YzmyrPUqXqvGS0sA2EfBPvq2El7wPaRSHwzNOEHtJADNAPeQ0F3
	1XWs6piMqCdl28HylVPFrtyfL/NprhKtgs+rnTHsXn7ZHq5FyAWuiTYrPfNr3ALMXbdG601EXiF
	uiJ75qz21siiaJACO9dM5oo5tvPf1x1sngImxCXqUtgy0M8cOaKWm8qw=
X-Google-Smtp-Source: AGHT+IG3+y+F9NN5CUf8cLbNkVMLV2pFiOfkehsDFipgWzjEPkRo1/7LrK9f2s4y1XsZC4nM3WNBNvzq6oVlVdn8Xag=
X-Received: by 2002:a17:902:bcc7:b0:1f4:50b4:a50b with SMTP id
 d9443c01a7336-1f84fde63b4mr3085835ad.18.1718286505748; Thu, 13 Jun 2024
 06:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
 <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com>
In-Reply-To: <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Jun 2024 06:48:14 -0700
Message-ID: <CAP-5=fVF9LVxO5kpyutmbOTC31ywQCO-qgNk3qnqv5rVOf-JDA@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	chu howard <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

3rd week of Google Summer-of-Code. Office hours this week are the same
as last week:

Linux perf tool office hours
Friday, June 14 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Thanks,
Ian
