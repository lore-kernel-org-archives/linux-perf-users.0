Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B22E718F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969202; cv=none; b=twVe2xmzZ432w1ic/bdNVP6MPVdlt6XIPqcMEDEQdpBE8IwKPAP6VR99ytaKO3D/QS+eGJFXxTIknXAqhR10E8FFgsDkTNgO6rb+xSv8gKXORgrSdgR7BrRZtc9Xzt+rcTZ59kDYoBZNmFLQXJXY0suQmXh0EdmUB52T3e8O2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969202; c=relaxed/simple;
	bh=iM7cR0DJ0JIoQinOOJ/RX/6H6Ou9aX+fdDV8J3Xg0wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsBvrrFSiYEkE4g7IPjnHCJaT1vqB5xHEkk3j78vLRhBz+kOccWP1GoEIiZhJFPdjYh7iEcf9TY6i77IOVzzK6k5sBGUZcwIodmEgd+ranx/PPID51QBdaWTWaXYAQwBQ99jbm3sxvqa/Es0QZAlKXbZSMjacDtn6VFeN8UoGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsNsIN8m; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsNsIN8m"
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-37a3d86b773so34343641fa.0
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 23:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763969199; x=1764573999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM7cR0DJ0JIoQinOOJ/RX/6H6Ou9aX+fdDV8J3Xg0wQ=;
        b=IsNsIN8m7fC3YivlZWv8CtMbGZYIffW3auIFp3Tghw+6LnYdIJVu+Gvzce3X2h3ZK0
         OI1haxS24kM2twBMAhZKs2FBQJobs5lreAnNcCyICuYZkXAEDuJDPtCHb02D2LgRoWWr
         GH7KSgY5F+S8nYaCv50u7jqWQ1gIDCD1qwV8bsEWVClMBKGO0lXkBN8lb4J3jVjMQJO0
         mnIfsAHSeCP1rYRNtco6iY78HxMawkY02k4AbQS9GzuhZHQQRap5YwXoAPijz2dNCMul
         AFtuph3+M5mzJOcc+bOaiEy5U+dNdkHKL1Rqvwsi67qEeuYjBRjwOl0zZ/hKR8swhXXp
         esLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763969199; x=1764573999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iM7cR0DJ0JIoQinOOJ/RX/6H6Ou9aX+fdDV8J3Xg0wQ=;
        b=vUHGfK8UxYd5k4Gghtn00y3uoVamsZ9BpnIRNWXX7clOrOQ/jnn2501yXGlvL7+Hvp
         MNtW8GXYgaSgoJP/2rcB8ITgj8a003z97sqeUXBd/PNOJDknMjJXeRyasjInqYW0vLaq
         v8RfVbAqCR0AEdhIMYWELkahSyg34EeqtqbgRt0Od/B0GQIkDo4hoyGuN/iZ6E+fqpaK
         LVoKlA2Miabk1idW8K/4ZjDkq16je9n2qB5v2QPATa31REb4JnQxzw9+A62eWoZIpe5y
         OjUlAXVBvOTBkZDcAYbWh9tUUez6Js8y1hXwzG3jb/2jirZBoGJEeLxu7B9DQbueXeep
         URBw==
X-Forwarded-Encrypted: i=1; AJvYcCW5bo7ckm1aZgEDl1p6VxNox1oAIiKSRSh9D35lHy0nGt0nfUMBI84F+4fMaK2QI6qPqVSF8ZdqYUGI5K82lfmY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6YHcv8NjSuV2RJAwvc54ImJO1iqCfzVPBUlzRCCxob0rTF+d
	WSsSGwcq0usU+GWVaomlRN3bd+xT4wm+fSNA7Ipy3crjdSANoqen3zh6pdY7M5OoXAKmQ0Lwhd1
	daFnelK+Ze8F53gIyMnyTlhU4IRYMRSU=
X-Gm-Gg: ASbGncvmFekth/mlQbnVWgTNPty2ooyJCD5mp4GYgODe0p2RxqLP9Krj+4aPtyj6qPu
	KnpanAw8TN+HeP+GYjdv0C9fPwtps9TswXqe/Zx+UfIIww4dVBSotoGUWETevjYHWdvDLgaN66W
	hqvQJ+XbKnAFcHpS/ibmt9Vz8w4R89VC61IrUuQFAoZ0NUKNVo+hy9e5B/bjuBlBRFw1ay5711Q
	CkuYl7mkOaI1WMWTMdYqeKdJStEpJ3G5TvNW6X1HNxXm5dzShqI8VxFQl8o0jRXYomV1Qs=
X-Google-Smtp-Source: AGHT+IF9pyHf9s4/R4g+NL9rAheKhq6yLl2d7V4tltqJI+cFuOwC+SUIzGGpwWdUBJt7CFJ308GW3ytUTDugRMntncs=
X-Received: by 2002:a05:651c:2148:b0:37b:b849:31cd with SMTP id
 38308e7fff4ca-37cd92e2baamr21015131fa.39.1763969198796; Sun, 23 Nov 2025
 23:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com> <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
 <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com>
 <CADHxFxT9fXfKVDXWxoFs0KeG+gssNhZE3y6TGKGtS=AhKPdGAg@mail.gmail.com>
 <CADHxFxR2t4jMmjm3hMdhsxoRjUw+k3CtrG6ZzG39b_BhVzyzsQ@mail.gmail.com>
 <CADHxFxROMe++VB17J3UgOxSoEhJ7bNagBHO6gRQQPpAELc1ocw@mail.gmail.com>
 <CADHxFxTHHT0bWf__dwnZXk6E8Qb2sxL5=L5KDh_Xmzq-hNYs6g@mail.gmail.com>
 <aR9qkB_XY-elMxSh@google.com> <CADHxFxQuVjh4zVtVhjim1Ppobpb+CyeG1h6bRFFcxTCKpmaHkg@mail.gmail.com>
In-Reply-To: <CADHxFxQuVjh4zVtVhjim1Ppobpb+CyeG1h6bRFFcxTCKpmaHkg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 24 Nov 2025 15:26:26 +0800
X-Gm-Features: AWmQ_blSfvRzHCnowuOjtsqw-hP5res4hj2nffNIawcgDHLGqK3Oj3wHSRqPjdc
Message-ID: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo and Namhyung,

On Fri, Nov 21, 2025 at 6:17=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
> > > >
> > > > As an additional suggestion, I=E2=80=99d prefer to keep both the ab=
ove patch
> > > > and the previously discussed PATCH v3, which would mean submitting =
two
> > > > PRs. From my perspective, allowing users to pass custom compilation
> > > > options via EXTRA_BPF_FLAGS is more flexible than only configuring
> > > > headers, so I=E2=80=99d like to hear your thoughts.
> >
> > Yep, I'm ok with the extra flag variable.
> >
> > Thanks,
> > Namhyung
> >
>
> Leo, what are your thoughts on this? I=E2=80=99d appreciate hearing your =
suggestions.
>


Based on our previous discussion, I have prepared two PATCHes. In this
email, let=E2=80=99s continue our discussion on whether we should use the
extra flag variable. For the topic of using the kernel=E2=80=99s native
self-contained headers, please refer to my other email at the link
below.


https://lore.kernel.org/all/20251124072310.3592-1-hupu.gm@gmail.com/


Thanks,
hupu
