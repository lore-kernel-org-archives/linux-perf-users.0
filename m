Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76A11CB8
	for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716133858; cv=none; b=WlXNtjWBjGBb8oW/rg4pXQm5v/WZ/X0Edal11wE00r6aa8+bm0cU4Y1MVzNrqOfb9QjDvPY0GzSMwGbZlIypSbZTS53jxb5FMcUdHSL11efFfFN3m+7VBF7J64Mif3+WECugQU0AiiVXTYYDjVONuOrqYeyxeCT1c31l0Dv1N5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716133858; c=relaxed/simple;
	bh=pstpHqIexnROQFTW3wHnYyPY7p1CLDiXOk6mk8/HvGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0H1d4Jnl90+NzzkGPfSuOcCQdyenKamhEYtfgHn/BcsluCEN1V173DB5S8NtOJVg2+QsVufRR0HXz2qLqWXlu/GmMZ6KT2tYBkLKXZ20KpZL+6Q8HZxzb2L4S7pdIM7WJXW0JhqSGNvlJpHIg6ilOoQyQ0l6VaoaeSYrtZVB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yI/TXDug; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yI/TXDug"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36db330403fso217355ab.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716133856; x=1716738656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pstpHqIexnROQFTW3wHnYyPY7p1CLDiXOk6mk8/HvGw=;
        b=yI/TXDugNhJFgWIoMNEKkw3nfM+Bd6Wjfz1jNuVr8YKBFyiOlZ/epkdvuewwLzWCwu
         eg5ASXtRqggFtmJiq4N1dHZr2wlt7nOicuMlIYes3skIxdScFm0H4LNwv2bliYlHxCMp
         3OzDiJunxU2jhWgYse5UCdaEN3SETCIQpCGxzTD8oAQP5vL4NLa6miGyu2ambm3sqKhq
         1q7tqCXEeNu9ju4XUuyg+6MpAhH34fm3gE7yViob08XxR6rkXYfDiiE7xaIXcmjhtkfv
         QpmdVj4jFJMFfs+tpIW+ySzdjm9EZUCoOYtXONy9CtTZaE6iDyYkJXa/gZYZUifmFueK
         CtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716133856; x=1716738656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pstpHqIexnROQFTW3wHnYyPY7p1CLDiXOk6mk8/HvGw=;
        b=FVSMgwVNZQAwgLLnuJH2aT6A0lHG1nzVKWRWa95Lk2nL4QyRaEoZdiniFvxk9ko64G
         jrPRBJ3d+10Jthkyd8sMGIRpi4UrGx/lqVNgFqQiy2YQoP71i56ME47BJrVhkGuwFtjm
         wXJU9MKy1gr01y7tGOlSoQnnLDT+ViNIsn+dpvnKZzmiEVmx9xg1H56hSJ7yufaj43Uk
         aY2dpZqu0exQxn++oJBYElm7Qw3vfBxUgoV9koGFogcf0mV8EjhRsF3sD8Ny/2r9xnmn
         Fi4raigf1boiYiP+uB4PxZvjCrXUdChKH1u61VG8IeMEL0yPEcg80C2+QOBltY0F8SZK
         ihSw==
X-Forwarded-Encrypted: i=1; AJvYcCWawgKKcz+YVMyMFJU07OLRgbpz02rubzU2UwEa4D0U0qkx1zsuzu3kNqQW7hvNj5lZ4EaQ8c+e1e9ht2Ux5IiIfuTYHmjxHoCoShcZOPwiIQ==
X-Gm-Message-State: AOJu0YxI5mNWnNXxuinZersTX8dlwkQIQ5HnOo+uurMCTo66qkOF420a
	84Av9HN6+J8ECQg917LlJbKkPo4Hiv2HxoKAfXhvxefYBFgzv6VDCTGziyx3OrgKHPt939731/C
	Tg5ucqEtgzw0t2ARpX6+KvNMqiSbEKtKE4Fl5CDI4QL0WUPBhzg==
X-Google-Smtp-Source: AGHT+IFMOSoMQwdTinCh/+XbmUz8jIFDcVUjy2yphBrctrLgnpgFTI5cV5FIAro94k1mFeFxbHdgRR4jDAuc52rqzdk=
X-Received: by 2002:a05:6e02:11af:b0:36c:29fc:a5b8 with SMTP id
 e9e14a558f8ab-36dd04fabf0mr3299535ab.6.1716133856232; Sun, 19 May 2024
 08:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518165315.3963142-1-sesse@google.com> <ZkjdQqN1dPsZDDRA@google.com>
In-Reply-To: <ZkjdQqN1dPsZDDRA@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 May 2024 08:50:37 -0700
Message-ID: <CAP-5=fXPFtS-aufdZE1_haEo6EpYYDw9JhG_4EjHi2AAzzf5RA@mail.gmail.com>
Subject: Re: [PATCH v2] Add a trie to map quickly from address range to
 compilation unit.
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 9:54=E2=80=AFAM Steinar H. Gunderson <sesse@google.=
com> wrote:
>
> On Sat, May 18, 2024 at 06:53:11PM +0200, Steinar H. Gunderson wrote:
> > When using perf to profile large binaries, _bfd_dwarf2_find_nearest_lin=
e()
> > becomes a hotspot, as perf wants to get line number information
> > (for inline-detection purposes) for each and every sample. In Chromium
> > in particular (the content_shell binary), this entails going through
> > 475k address ranges, which takes a long time when done repeatedly.
>
> I accidentally sent out an ancient patch anew; sorry, please ignore.

Presumably v1 should be reviewed?

Thanks,
Ian

> /* Steinar */
