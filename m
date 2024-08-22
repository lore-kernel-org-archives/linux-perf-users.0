Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414F1CEAC8
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348635; cv=none; b=jUF0J7rQTnw+d4sXgpLKoYj1QmgcanZzu2bOeMWx6h04SUz7/8Xwuakkev+u95zyrs26jA/sAveFb6O63cGMc8x/k/8MPrJJ7YZdQ35CM6wlv6+0lpM8T4/tS558+KTl3Y1tXr0H06bAgkdwNJblgGwryLIIhIZR57ZWxU8pZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348635; c=relaxed/simple;
	bh=gBwYdCWoxYKHB3pjFQnlQt8nWinlcImOnljxnMc8RxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CAiY/c9uLROq+HEZujOxc+SPUwpBuetXciaad/2IpehKY8BSESiH7ot6eBqV60X3JlZAKMhuVwZeSmcLcmP1x/z6RHnRTFknKwnwD7XLQerY4TFjmVtFPh7actelI+9W3xGjx1yZTuWn7q25WSd7+yf6bhDaSxSWmXcDUf9RZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2sE1S8xy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2sE1S8xy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20353e5de9cso15365ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724348634; x=1724953434; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBwYdCWoxYKHB3pjFQnlQt8nWinlcImOnljxnMc8RxU=;
        b=2sE1S8xywt5Egsn099EXKm2IdxY8Lp5S8N06ehl9oA/S9MPLQFJ5XuWoEwS7U+XWWS
         b+TZabdYH0zlG/fvNFL2wePdUx92tld628eZ7nSeb8yy0UeEt1tryw2ugtpVaKdASOr4
         Xum8X67ffOi2j4wqbBBMY/OGq34Q7YheyI5Dpo/wnj6vt2BPvLsXeGK82MtNlUE9CSQr
         IU1HtGAXCilOW49+KnFG6oU5GCZYcel2bLRtvcsjPeRdiuDm6K9F/WcxJDQyiowHfCW+
         V+BjmRhWJITwml32yrGVMVHNvd5B3dPpEsfo55g5EP/G7czL8u414hafaB89mDeAGa7o
         uiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348634; x=1724953434;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBwYdCWoxYKHB3pjFQnlQt8nWinlcImOnljxnMc8RxU=;
        b=R2tf1DLxM6c3RqFJK0/Qjna4cvUMu0m7HuBq8RtsGiBpDrA99bmoPsX19t4f4SHb7/
         1UcXwBBfGwJRy5K2WjI45qLJ6va7w6k2gQtlZmOC73C5zXgnMQpZ8ka/kyF/nshhePfA
         wGV4Jh3C1W6L8Bbohb8L4SLhpG/SFYnE8VYNu3NF6eU+qZIJE5Kv4kTOWC9wNJi5iPGG
         nOBr0SNJ/g4zhYl+arHwhhiyU4MAV1IHrpKU955Bc933SQbEJjexdKsq+I/WvvQ4CvnQ
         k62/wX0zjOyc6L7AgtLu3FRT0nlGfcFld0AMroHf9b2XgqGSZcJwhWKGU/NB/cKtHZJm
         8H9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWxqQU+J+cYNM73P34SDzKo0AfMoX30zu1ft/x2zeV4QpzkqV6ZPgwkSxPPfI7aLwKkv/7v63W7Q710E+PZquL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqhld3kF+A7dEJTXVgvlGP1KIDZGH8Eo4XvZw79MrHLLWiKIrZ
	Myn0xn4ZQiuRrL2egb0uwsqI7z9uazXOtNLmaZSVNUTEomJ4R1Qw4fupq7wKy/yVheHpxLNrxru
	DvPY92ZNPgl8BX5jFu1+4rwM/nAvfWYgYFIcO
X-Google-Smtp-Source: AGHT+IE5mcoF++97X335wv3Sc8tojC3jQDCPkfTD3rKhCYg0Yw1XwNSdK91WlLqVgjFxyGWr1JpSvBBoAqGh+xWzzj4=
X-Received: by 2002:a17:903:1c6:b0:201:df0b:2b77 with SMTP id
 d9443c01a7336-20398fce025mr125465ad.0.1724348633363; Thu, 22 Aug 2024
 10:43:53 -0700 (PDT)
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
 <CAP-5=fUSMDhooNetywiLfcYEHMPeyPaGHuBhJHUb34zM8DqtQA@mail.gmail.com>
 <CAP-5=fUbJcxO=h65bqZ2nx8UTPHsapOVsfcCaY=+q4yO9YBY-A@mail.gmail.com>
 <CAP-5=fVazh93ZRqyubCC1MEE-thDKoamO-L_d0-LZjNyYmD0vw@mail.gmail.com>
 <CAP-5=fU4fwZdWNXbCKjs5+T4G2NnfibyhXFfif130vKZwyYcBg@mail.gmail.com> <CAP-5=fWKfUFV8f2b06cTOp2JSJg4WnEja2f6dH2_NggOiKKNxA@mail.gmail.com>
In-Reply-To: <CAP-5=fWKfUFV8f2b06cTOp2JSJg4WnEja2f6dH2_NggOiKKNxA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Aug 2024 10:43:41 -0700
Message-ID: <CAP-5=fWd6DuPsM=2Q8xOBtTZn01rTKgEDrWtYQf=61GLjT2Hmg@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

It is the last week of GSoC [1] and time for our final office hours of
the summer:

Linux perf tool office hours
Friday, August 23 =C2=B7 8:00 =E2=80=93 9:00am

Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Topics of the day, GSoC and thanking Howard for his contributions.
Looking forward to seeing you.

Thanks,
Ian

[1] https://developers.google.com/open-source/gsoc/timeline
