Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02A1DBB2E
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743537266; cv=none; b=M87UseoGhSGdawKrg+XpntZbsOdjnd8ArCkFk1kWrsAxgt5rH+B+Zp0J6wMzk2yvEPQdEdHgfsSAQcpdPxH1yG6fjPUa2OVcvnK1kryxtDTdDxBehLVP6cUK8YN/6cEQnJ+4+U8IM8yq5OEFFh+magENsqwDqhuX62Rahjm6jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743537266; c=relaxed/simple;
	bh=de/BtIj5To60CHP517asQruuMVZmw7HGpY7NsHjlU38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2lpJaAwhc9nAy+8n10RXExdXuZDu2E4iwSmM/RV/8ORhSgKJ5SQ2uxE0o/3ANYaG6ftpvnDhrhgH15/8ZxP90rieyS8PfGl/4JG+FZS+bufnkOFlxbMRCinS4jwhfArcVCwEPjHLvvLh6to80KQVr9/kR8dpJFAu4lUROBAAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNt2fYjy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNt2fYjy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2263428c8baso3005ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743537264; x=1744142064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de/BtIj5To60CHP517asQruuMVZmw7HGpY7NsHjlU38=;
        b=RNt2fYjysvv6091cvCbVZTN0pSs9MX3rbcwS+FXf0TvTyPYMttWIIJvfak1180Ew41
         iCfsUt0Uk0u1JnypaXVNgkoUSkA91yPeOxCxvcrfWJn6r8C+OhIGfWb5+KRMtcXC6q2f
         /iKUHB7bRIMw1Qzx8vXfhjzDWAdVrpRPY4X/mEmezU+xLKMsc8cg820LJSKsd6b3mcYm
         /OuiIYZxD2mTrhfbJtTEi6WZRVCI3pHtMoF4oB0ocoixH+mGpVb4ETNFvGkoLIA/HF8e
         iTCs7v0bzEG+/Kyuu7jTFFieSfv+3f69F1RrwM2eNO7cah/89yGg5O80ptNEzvaAqkbx
         sWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743537264; x=1744142064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de/BtIj5To60CHP517asQruuMVZmw7HGpY7NsHjlU38=;
        b=Lkv5n1BFw52/YUGGvqFgTmmyJx4SoA6sBmaPSDrlF6oQU2lYltLFQI7TqhuxtbRPAw
         kF9cNTsnEoKyeMKwglvYp+04NY1oqxGBtuO7l0svwYhc9OF4vT284ZQ4Mf87bCMNAH0w
         JyVJ2P3kSljnGBFEVvSdkytnHO88Hl58FqA9+xsOajFcp211oLWXm8IOMx8Sof5A5cu/
         H+TwVsiJklHKn01dmyff/YwNYvxe5INTCIcJ//RA6D9vjGYluxRnpdazwCaEH4Bfwgj4
         JCxLm66376chl+E/f4M0S60Wm+xKkmysaZU8UwyL64yj7sAcGALlPci6iCRbgW/JjGv2
         sL4A==
X-Forwarded-Encrypted: i=1; AJvYcCU53iuboA9P0tR7vFMLJmv8/JbDfVVs9Jhn1ZIMi1ny8yTPmJEiiJn6bJzx5Wo5NCbWHeA+Oxn4e3MMAvs9gEij@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGGk/c96aESsiHI2dyl3ObKx3Jg5ka58a/xwSSZ5lRwQzP1YH
	LmhnIzcep6XFO4OZobtaMPcmcaTQmNmflFEGXMcsmhba/+lO3GT5nVfywSC9O3upV1S3xxVUZCX
	4aT84SLRuarHkBA3J1HLpe55VoncAlLAUyQOQ5KetNgqSnrP8qpYXkwE=
X-Gm-Gg: ASbGncvwgCP454XTG2MrGdZxGLrLTOwmor6Kr8QNBjIZRcWR6TW4AQbKQAM8/2boKcl
	HQR4XLI8v7CEmsv+946bDH8+yl+7VWy7J+SHNaMdUqTBLH4S34ej6Zwe2wc4rhZWlmwlyM8ag5h
	AWNkeh6M6E9ON38gr+j+q+h81dFGCeVuBxPZpqVP5nsjKaKQXLmBCkDiMaDGBK3U3yoA==
X-Google-Smtp-Source: AGHT+IHOs9BdqrTvFPQWqJzaQfsrpiXeP0qaabdPaOzhGdnfECmfbLNE+FP+wHg/1tSnxeoJnrwfErtVjaEBIcva9iE=
X-Received: by 2002:a17:902:b68e:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-22969e99900mr464395ad.22.1743537263944; Tue, 01 Apr 2025
 12:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331172759.115604-1-leo.yan@arm.com> <CAP-5=fVsgahBhOEOac52PmL0V+n1jqAxzf7n9PVWgWsxq9TvgQ@mail.gmail.com>
 <20250401091422.GA115840@e132581.arm.com>
In-Reply-To: <20250401091422.GA115840@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Apr 2025 12:54:12 -0700
X-Gm-Features: AQ5f1JrOuWrNQZJezs0L3XR8GhYfLpTvpu06rrvr2p2w6K3tJeuVBfouNq8Z_vk
Message-ID: <CAP-5=fUGLy9xGmMO+6PXvfviB4U8Q8O7H3iTSSqEf72vin8gDA@mail.gmail.com>
Subject: Re: [PATCH] perf tests switch-tracking: Fix timestamp comparison
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 2:14=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Mon, Mar 31, 2025 at 01:18:31PM -0700, Ian Rogers wrote:
>
> [...]
>
> > I'm reminded of a Java check I wrote for this:
>
> Nice short article.
>
> > In clang -Wshorten-64-to-32 looks to cover this. I'll see if we can
> > clean those warnings up a bit.
>
> I checked a bit and seems GCC has no this flag, but it makes sense for
> me to enable the flag for Clang.
>
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks a lot, Ian.

I made a small variation to the change in:
https://lore.kernel.org/lkml/20250401182347.3422199-10-irogers@google.com/
to avoid a subtract and just directly compare the values.

Thanks,
Ian

> Leo
