Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D1199E80
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312683; cv=none; b=TcsaA4OsRJaWvCtiRyNhq054KXCpm4yUhwPywoIZxICQV7NTCxxEcaiaa3LDZYDkkOx3ZP+GUnfEDba/c3Cj7e73hKMREpJygThhGyVbQx8cSIj2gQzFCWUW+xwvL0NJdof3hKFmVS24I+CxE1crE8Y+9Y7a2v8wHV6nlJ/+Az8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312683; c=relaxed/simple;
	bh=0Ly72ZYq7RIo8KXKjul9y58c5p/oa2pQnjcQhtbDLZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcAZRpKARePMC6h2rkRPhjLInIj8pUMcK4kqF57SaP6T4UcbN0LTjZYw8ijCAi+LAbTgmigHLVr3sIeFaWcK3tX9s/XUWrDRqgrpqvw3dLzbF0K0mre9CgqyxiVRhdTMCS0zbqCW2qAZWXKaOaQbRp8QL850/BBo25RZ33sIwbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P63Ka1Zv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P63Ka1Zv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240aad70f2so241135ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742312681; x=1742917481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ly72ZYq7RIo8KXKjul9y58c5p/oa2pQnjcQhtbDLZU=;
        b=P63Ka1ZvL3jn1K/Xb1CwGuil4qQe8uYtny/8i/bQc4VuCv76w/K4I9+qzZiHqh+9rz
         oTMkBcztHJKlRuzJy+yVUts41vg05uzJXy+dxVCw86FzaG8RmEEZcv1Ph7t02RdAaQam
         S8xVvQrMkQePQdWGOT/IqG3sKxq3aka4p9INxaY6Zp1lYbUrGaGg4dqGzYbJuEh/QTGu
         Y3Fl/jVjs2V1FcgZaPZ9TECAwBp8NdIS6Tx49HDDhKg2HLH+yrTDbtqxwpTUYObvcEwS
         flI5tuvVFdcWtD10Yl6CtjQ2eJyxP1Q+M9tKmOmbkpuWBSWmTv0t/nGvTvKHJnuF+DO9
         wmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312681; x=1742917481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ly72ZYq7RIo8KXKjul9y58c5p/oa2pQnjcQhtbDLZU=;
        b=QTuatdDIgH9AJOCS+GbOhKc4M1qQTdsIVYFrs5CtBbzp+Or6969PaBQIhtbYtNdItm
         q6ZkIBd0P/cmf3KujYe/VdmTmtRdQjZF2pX6VIgh47awV0iLvQSCtANisSSPk+E6rG/V
         t2fsMZ5iPsmW+h4JZdhlNF3tgzoRrz+dLhHPXhFsMIdPS1/eDdP8ODYHnon28kCt2obx
         iFUFVDNxWO2AN+ePshV4zJucB9yeXkJPYugeCrxuv5lFHR7UXauGSY1/vf19tso8rrcm
         blCCby81Dh9e3XgWZ9V1V+uGmR7L7uPx2205rSdTys5JuHKGWCuhpYhf5x3PTcBaF8vc
         mdKA==
X-Forwarded-Encrypted: i=1; AJvYcCVctuXjv5fvk6nJsiF/R0c3gcPEjFqkkmXnAMt+Rqpe/tr4Uq60CRRKW2/ICyWyi3xJHtFXx1NIzFXLGxtdkP0D@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHgbmqDdagCTLHSvq6IyLphXVVvn75K1CECAezd6UNW1pe+/A
	fuqlmivFaPGHX2J5opQ4ab7JToX1FlvaMm0IEv5fwV95k9UqveJ3/H4AsTnXQjXanp6HgW1XOGL
	fiI93XSG8PHnm5txjZRFFUOp/RzNYltqhZkKn
X-Gm-Gg: ASbGncuwegYs/m33SnQYEwtPFRXksEIAEuBPf2EadmvOfZXS5599gVtpHyyg2N/buUC
	34Ep4qT6M4i+5J1EZgJcVS12nFf3xhExTkwMApxXNcf2ju84G6Jm4WSGav7aJVe6UI1JHdBqYFf
	JQBv2ndnxF9wARq5rdmnxGscFunU8tXIydgBsu3g3KNz3Q/rPbqVj0bKg=
X-Google-Smtp-Source: AGHT+IGh+2xZ8Ms2gVdUDlDHetxkQkzf082zJP7mKnLMc3K5OnEeuJwvj28gipqOgwHRgL1ljn+HQg5UkkyHg9KmHxU=
X-Received: by 2002:a17:902:f605:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-22631018e82mr2453915ad.10.1742312680721; Tue, 18 Mar 2025
 08:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUPz9R60Lay=k-0k5Q8C9AdStAMycOgsKqA5MJ_o7Ag3Q@mail.gmail.com>
 <20250318021703.78297-1-yangfeng59949@163.com>
In-Reply-To: <20250318021703.78297-1-yangfeng59949@163.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Mar 2025 08:44:29 -0700
X-Gm-Features: AQ5f1JpJbsNyitrKe8-u7csMc8VsRaKxiXcnfy9KlhRdj6oGLdKKOKioQE3_iLo
Message-ID: <CAP-5=fWuavNZv-x-t=f5-suLZHAyU-1y6PFj7WYNf6O_-RW1Ng@mail.gmail.com>
Subject: Re: [PATCH] perf kwork: Remove unreachable judgments
To: Feng Yang <yangfeng59949@163.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 7:17=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> On Mon, 17 Mar 2025 08:44:45 -0700 Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Mar 13, 2025 at 8:10 PM Feng Yang <yangfeng59949@163.com> wrote=
:
> > >
> > > From: Feng Yang <yangfeng@kylinos.cn>
> > >
> > > When s2[i] =3D '\0', if s1[i] !=3D '\0', it will be judged by ret,
> > > and if s1[i] =3D '\0', it will be judegd by !s1[i].
> > > So in reality, s2 [i] will never make a judgment
> >
> > Sgtm. Out of curiosity, was this tripping a compiler warning? If so,
> > could you provide the details?
> >
> > Thanks,
> > Ian
>
> There was no warning during compilation,
> I just accidentally discovered it while testing and analyzing this code.

Thanks!
Reviewed-by: Ian Rogers <irogers@google.com>

Ian
