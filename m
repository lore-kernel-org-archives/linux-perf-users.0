Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D830C358
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810631; cv=none; b=YS4cozYfjsAgI2BeCflugF7XBHq26S9tFz0uLV3y/EtME4I/+9OeKMERJdKsrOZyhIDeGjf+er9dEbX5ULUuGpB50fWxXWH9KcHqqsv4n3uZR6m8kQxp7V1KlRDeP6Rw0KqJKYTh51vltZRjEYTopDzydRu4U6fym7f0SFJ8H7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810631; c=relaxed/simple;
	bh=CdfXVXdcEVWV8KxlMBFv8tqG6D/onHIHIshcEqcEa2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzEJgU1m/+t3OvtRtLwbxPSL1t6MpLrH++m8tMBVZBwWbR6S/QoPL1mpKEkIUyR4ht+JVKQlczd+GK/9BC93WlzKazuepzhLzGmQo2RD01y6ZKFljGLwOqLXptjLcF5NO5l9KHK2C5aF9dZbWt3N/ZeGv5dPcLCBSClMPEpmJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5db2d2030bbso348372137.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 00:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761810628; x=1762415428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKqtAUe6d6BWCG6Zj08y0hgYpvyRn/Yr9YKqc5tlCW8=;
        b=aKOGVsbSbKLxOvIp11BZyW7fwm1yFFAr82SzP3XKjjrnlNoMEfaxGFs8Sx3Kclh0EG
         mM72K7cs1jO13DcOEYFcqF+WCAIcb3RGg+9LjJw+D/HKwO7vaDmSMzqGRmawA5HLyAis
         K55F8gwbTxdpCn/wEbDv/22Eygb3fuLqwBpdlBvl85VdCel/dyrfz+pV4JDQf+HfpZIX
         LVko8886V4LxH01mAOkFQD179ptYnNqp5aE8P1VvTzT2NgWkKi/V6YOCTpus06Ms3otB
         UGeFXu28Ocyblnjt0m86hseae/N78tqy41k8I+ryLeXz7PShUfyoOOcW8iRpgYCBqEcz
         iR4A==
X-Forwarded-Encrypted: i=1; AJvYcCXSVv+sMAM9Hd4IqiEjX0NlHGBVvst1ttLTMFT0kBx1fyuX0BECh78IEN85ExpJGRY7S9Xwofcu2x5sKqwyYPPh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4khfA6I/w+2HmDVCrAvDfSEI3JGobZsbaE9OfX1SHTvdzp7NO
	jz+XeMhVPW2iZGwbCkYedVPQ6f1qbpX1NN+eJroiB/Cw3TvR3y/rqL4MrM/sTw==
X-Gm-Gg: ASbGncscm2N39HpF+0E17IYL/fjZeupbN43BVSdCXVSYk6gPRdNlkzwrdD3qsbFThYc
	tN+XAHSQDaJ3jfsOh4bIcaeoBP5fucUZcdgHUOLop+faPNk2dO/BKwJkUxJGW1l5h79SmwrzAd2
	9bjCJL2ApUsgPajgPkol7FoLJltiQzIV/7iTXq1aezEEr+6VoWBzAlcP1c/7akq5dABnljYX39H
	IP0NXOgh8ocZs1OPjKmlF/uREF3rsiVf6r7pWtUBq6PHa77MX42LccJTjxL3Ep9YQ9mF3gTIrpu
	7Le9K8b37VoUhhjLmQPj6PeEHYuOASrttjNPzQDSb60d0bcLOfGJ/sT74mkQo1XjQjyhZe+TGhz
	c1msoqB2XBrXLHnuxsg6ro6Le7qRNQ7UrEeUritYidk9gdF1wO1d/f+uyu3cHee+KhOlgfnrU4k
	DYljnzxNdjhi1JgFOmJeVRKLTY42ZgLATTVwefDrlO
X-Google-Smtp-Source: AGHT+IHol/a5Sz/hXrvhXNdfyWPiy/+aLNM3mFqhPSWmt2OXGix7TxNmeKACXORsk8iz2o6Am4Jugw==
X-Received: by 2002:a05:6102:358e:b0:523:863d:ece1 with SMTP id ada2fe7eead31-5db905c95e8mr1895169137.17.1761810628414;
        Thu, 30 Oct 2025 00:50:28 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93501888dacsm432120241.5.2025.10.30.00.50.28
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 00:50:28 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-932c3aa32f3so386753241.2
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 00:50:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQMcVtsNSxtWnsHnT/ljkKjqzRt3PEAI4tVFEXGSVhzziCxQ8n5jnIkUH1zxGzrAcRfuIYUDM/VyrMKXJJYagY@vger.kernel.org
X-Received: by 2002:a05:6122:1d9f:b0:556:4f4e:812a with SMTP id
 71dfb90a1353d-55814105b1cmr1922901e0c.7.1761810627957; Thu, 30 Oct 2025
 00:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr> <aQMUGvXv6sy75nKn@tucnak>
In-Reply-To: <aQMUGvXv6sy75nKn@tucnak>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 30 Oct 2025 00:50:42 -0700
X-Gmail-Original-Message-ID: <CAN30aBHOw16Tzdn_Z0TZKie7Fyi39bmB2PQK4LB-rjU1vn3zQQ@mail.gmail.com>
X-Gm-Features: AWmQ_blIh4FHNSYYQRBDu76pw1cN_M4hli274r6aO84F-zHC22yGF-j77KUjiOI
Message-ID: <CAN30aBHOw16Tzdn_Z0TZKie7Fyi39bmB2PQK4LB-rjU1vn3zQQ@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Jakub Jelinek <jakub@redhat.com>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:30=E2=80=AFAM Jakub Jelinek <jakub@redhat.com> w=
rote:
>
> On Wed, Oct 29, 2025 at 11:53:32PM -0700, Fangrui Song wrote:
> > I've been following the SFrame discussion and wanted to share some conc=
erns about its viability for userspace adoption, based on concrete measurem=
ents and comparison with existing compact unwind implementations in LLVM.
> >
> > **Size overhead concerns**
> >
> > Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is a=
pproximately 10% larger than the combined size of .eh_frame and .eh_frame_h=
dr (8.06 MiB total).
> > This is problematic because .eh_frame cannot be eliminated - it contain=
s essential information for restoring callee-saved registers, LSDA, and per=
sonality information needed for debugging (e.g. reading local variables in =
a coredump) and C++ exception handling.
>
> I believe .sframe only provides a subset of the .eh_frame information, so
> can't be used for exception throwing, and you don't want to lose
> .eh_frame_hdr either because then dlopen becomes very costly and it will
> even slow down exception throwing.

Right.

> If .eh_frame is considered too large, rather than inventing a new format =
I'd
> suggest to work in the DWARF committee and provide further size
> optimizations for .dwarf_frame which can then be used in .eh_frame, or ag=
ree
> on .eh_frame extensions to make it smaller.
>
>         Jakub

Thanks for the suggestion.
An effective compact unwinding scheme needs to leverage ISA-specific proper=
ties.
This architecture-specific nature makes it likely fall outside the
DWARF's scope.
That said, input from the DWARF committee would certainly be valuable.
