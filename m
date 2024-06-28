Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFD14EC79;
	Fri, 28 Jun 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585900; cv=none; b=UdG3X8nlR5DNHw7Lw8nPbymm0jv+NrkD2tgHzLbquRDeNkEz42PAveW3nN9T3xpbz7JsG999FE3bGgANHtNpOf4fWQdNWUUmm6Wy1Ym/ov2HUjY4C0mzuSmMUaPha+PYqXdJHvjw/M3buSZ89USj72zo8fg0y6HYf/wF9uaAj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585900; c=relaxed/simple;
	bh=DmLqzFjJbB0hJBMh3LrdXIhkKP11RtHF5Wv9rb1z7JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfUr4/XzmIkaRRjB/+g6h3NNr/hpDhqy7oYnwE4itae8ZK15ZdhV6uRtlUybpJDKK/lcDd1TNRIuw0qMjkW3L6QoLzZ7u6hz0kk88uIaTzK2lwM2eU9m0/sPZ6ctwBkzZeZqOA5uj+WBaMu9thmiLXM95bafpuKq5eROoX7w5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/thw11u; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/thw11u"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfac121b6a6so558412276.0;
        Fri, 28 Jun 2024 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719585898; x=1720190698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY17Rl2BBYwhSYey18wXJP5wuY+jww+c9dAKfRtKfzY=;
        b=a/thw11uZIU+cZVl5eoKZjqcANhwcuUMv4SQT64F4+Gd5as/ti+rhiE3iN8nfro27/
         Obw2rPQTsOceDZAetI6f1wi0wtW1FBdg4/l6AhmHpWPaaM3ufigiQk8RHijgeST+OUss
         WSEYSKWscVXyqrUOBmmtzfCvxNphuXNgh2Av1RJ6vDJKyApiqroGriIXIDSCQ8SO1mbL
         hWUcTDqs8gN3Wqk6lggwnD/mQSEIGhbwRT9d8+mekN9mDJ+5rl1ATBl3v6nvmW1Z91tX
         RL1MA4DkzVMgQO3w73jfreVrbtw0M6IAkO9Zw3fb1jpFi0wfPM0pm4sji3JChlXI6QAh
         jXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585898; x=1720190698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY17Rl2BBYwhSYey18wXJP5wuY+jww+c9dAKfRtKfzY=;
        b=vCryU+64mYglJmneFHHRln2MXOT44t/B7XWrHxdKzfRwhclI3w2kidXkPd8JmbISOx
         gjOewNQaToO6kDUhVsYsvq5Ggyr6X+EJU7emxoNFnVhSKeIA9CZpIVPekGR3L49bNkfH
         2VWf4XKdWOvb5Y5qYztVPUE0Xs/0X8zCso+1oHPIon/kOsWE3CdJUo5L0HTb20ZC0/aG
         uaCEaetjlnZ06+supaPFep+5gBsh+pC8NDZ+GATqx4cqZ1sCR53HA07N0a31QJmTWOQh
         YOwFHusNgRGBvnpXl0ZLpDOpITSiZW669JK5KP5ZTG9+ARlaZuZwJHXsh9bHdSUdhWTN
         a14w==
X-Forwarded-Encrypted: i=1; AJvYcCU36vQnlJnc7nWv/Gxca8mkUArnUZJdKA1mZgaoRc825N1tjq+0101Fpt1nA117trp7E2IcJ2ee24rG/H4jjim5Xips2xiAkbGtJG9PfUnXewUn2AztcxXJez3YmKNff0Uq7xBy+QO7/t/XHrPSVQ==
X-Gm-Message-State: AOJu0Yz6ZorlwHc9nbZVuicru5Mxzqy6qRsahILVwjMsZYdtW0xfptuZ
	WA0fXQSvX1fAuUd6QIMNrBJxe58PCEJLUQlXKotL+q0lTEzdnGUV43tToQNl+z2G2ocx8Wm8so6
	NWNYseaTjhpPbSODqyQWFD4fQ4gc=
X-Google-Smtp-Source: AGHT+IFLjWEoHasp3B27U0Ucd8KsgjiQoPHc/utqKowc7r80+fpHK1Z/WVZL3Ss3qf8YiVx97wCE1/y2tGDZdfk/wlg=
X-Received: by 2002:a5b:18b:0:b0:e03:61cf:a9f4 with SMTP id
 3f1490d57ef6-e0361cfaa7bmr799871276.16.1719585897716; Fri, 28 Jun 2024
 07:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624181345.124764-1-howardchu95@gmail.com>
 <20240624181345.124764-5-howardchu95@gmail.com> <Zn7LoTU45bhZaihh@x1>
In-Reply-To: <Zn7LoTU45bhZaihh@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 28 Jun 2024 22:44:46 +0800
Message-ID: <CAH0uvohNPeR3NFr4iFLkfDnkXZ_jJt3nzkO+UxLeeO3MXYfpsQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] perf trace: Filter enum arguments with enum names
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Making this error message better is great for user experience. I will
implement this.

Thanks,
Howard

On Fri, Jun 28, 2024 at 10:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Jun 25, 2024 at 02:13:41AM +0800, Howard Chu wrote:
> > Before:
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode!=3DHRTIMER_=
MODE_ABS_PINNED_HARD' --max-events=3D1
> > No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set fi=
lter "(mode!=3DHRTIMER_MODE_ABS_PINNED_HARD) && (common_pid !=3D 281988)"
> >
> > After:
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode!=3DHRTIMER_=
MODE_ABS_PINNED_HARD' --max-events=3D1
> >      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, functi=
on: 0xffffffffa77a5be0, expires: 12351248764875, softexpires: 1235124876487=
5, mode: HRTIMER_MODE_ABS)
> >
> > && and ||:
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode !=3D HRTIME=
R_MODE_ABS_PINNED_HARD && mode !=3D HRTIMER_MODE_ABS' --max-events=3D1
> >      0.000 Hyprland/534 timer:hrtimer_start(hrtimer: 0xffff9497801a84d0=
, function: 0xffffffffc04cdbe0, expires: 12639434638458, softexpires: 12639=
433638458, mode: HRTIMER_MODE_REL)
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode =3D=3D HRTI=
MER_MODE_REL || mode =3D=3D HRTIMER_MODE_PINNED' --max-events=3D1
> >      0.000 ldlck-test/60639 timer:hrtimer_start(hrtimer: 0xffffb16404ee=
7bf8, function: 0xffffffffa7790420, expires: 12772614418016, softexpires: 1=
2772614368016, mode: HRTIMER_MODE_REL)
> >
> > Switching it up, using both enum name and integer value(--filter=3D'mod=
e =3D=3D HRTIMER_MODE_ABS_PINNED_HARD || mode =3D=3D 0'):
> >
> > perf $ ./perf trace -e timer:hrtimer_start --filter=3D'mode =3D=3D HRTI=
MER_MODE_ABS_PINNED_HARD || mode =3D=3D 0' --max-events=3D3
> >      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, functi=
on: 0xffffffffa77a5be0, expires: 12601748739825, softexpires: 1260174873982=
5, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> >      0.036 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, functi=
on: 0xffffffffa77a5be0, expires: 12518758748124, softexpires: 1251875874812=
4, mode: HRTIMER_MODE_ABS_PINNED_HARD)
> >      0.172 tmux: server/41881 timer:hrtimer_start(hrtimer: 0xffffb16408=
1e7838, function: 0xffffffffa7790420, expires: 12518768255836, softexpires:=
 12518768205836, mode: HRTIMER_MODE_ABS)
> >
> > P.S.
> > perf $ pahole hrtimer_mode
> > enum hrtimer_mode {
> >         HRTIMER_MODE_ABS             =3D 0,
> >         HRTIMER_MODE_REL             =3D 1,
> >         HRTIMER_MODE_PINNED          =3D 2,
> >         HRTIMER_MODE_SOFT            =3D 4,
> >         HRTIMER_MODE_HARD            =3D 8,
> >         HRTIMER_MODE_ABS_PINNED      =3D 2,
> >         HRTIMER_MODE_REL_PINNED      =3D 3,
> >         HRTIMER_MODE_ABS_SOFT        =3D 4,
> >         HRTIMER_MODE_REL_SOFT        =3D 5,
> >         HRTIMER_MODE_ABS_PINNED_SOFT =3D 6,
> >         HRTIMER_MODE_REL_PINNED_SOFT =3D 7,
> >         HRTIMER_MODE_ABS_HARD        =3D 8,
> >         HRTIMER_MODE_REL_HARD        =3D 9,
> >         HRTIMER_MODE_ABS_PINNED_HARD =3D 10,
> >         HRTIMER_MODE_REL_PINNED_HARD =3D 11,
> > };
> >
> > Committer testing:
>
> Further testing:
>
> root@number:~# perf trace -e timer:hrtimer_start --filter=3D'mode !=3D HR=
TIMER_MODE_ABS_PINNED_WRONG'
> "HRTIMER_MODE_ABS_PINNED_WRONG" not found for "mode" in "timer:hrtimer_st=
art", can't set filter "(mode !=3D HRTIMER_MODE_ABS_PINNED_WRONG) && (commo=
n_pid !=3D 103306 && common_pid !=3D 3476)"
> root@number:~#
>
> Maybe we can list the possibilities, i.e. print all of 'enum
> hrtimer_mode'
>
> This can be on a followup patch, just recording the idea here.
>
> - Arnaldo
