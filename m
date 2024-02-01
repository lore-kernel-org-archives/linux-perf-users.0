Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046FD1775B
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832008; cv=none; b=u2PuRUgWb0NgCApFDr82b9JzJFo6U6iG/GCh7E4nVdLRyprHy6epXGqTZwMPwaCE1IdASGGJdnIfEbYcuyWcPMB41YMFqftspENIgRAnzZYGjmqaa25S5eZn7jv3/Cg4rCwT3uqCqABwugUD2xsH+QrDZB01TJwzqWcPVSJ/F98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832008; c=relaxed/simple;
	bh=0tX7IlFeDf9pmylkRqCjR9iwG/aoOb1aOHdgN4EZ+lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDxA78Z4c43v653nARp/dSo3xxz+S9P49WwTOAkb03TOyy55Wf7T2Pk+8KTHlk7q2ER8y1WQNsw0lNWQu2/SjbVihWZTpmIkWZBQALiSgyLfqRizZ0Z8lHQcPN3W4YshFyxHtyNFZDUbiONhIjQM6xelT1zST+nlW1Ju8+Xa4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1325991a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 16:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706832006; x=1707436806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tX7IlFeDf9pmylkRqCjR9iwG/aoOb1aOHdgN4EZ+lk=;
        b=JUgkUPVKk91Rk9WrG5mhY1MEJl3rCuqqga0E/exmeaRSaMgDtn/a7SmDd3D1iJ8fxk
         j1CT3JtyDF+iMN+vyd/xpfVhDpLHG0eiG8CXEe6TmXZ48zOSXvSeEDpKjCVNODH6Q/c4
         W2GfmVJ9ZALDA6yZbyJ4MRBo/qO4MrNN3wxBwGdy5iEGT39inm1gKOT0eg2+a4G52Zqv
         uQ+gvzQ1TFO4I1P9XrlSbgQnHCZn3tho1a/dfFvufPAa1t/tSGImLfc5ho40ehgLqB1P
         dx/Rw5ntRlNLZkcnZWaTaYlFc7nCSqsZWm4ZaviTkKyJ2g6q81gIYDpMrS9nRe6KqVGz
         EAiw==
X-Gm-Message-State: AOJu0YxPjkf1xgrrSvU/6fL7jXKq9P/LEDKHGqhzIg1wu84PPyOQvLL7
	cFsxHpJIXvimlk2qJPq1tG6Qdhfqa2DSwTbzLvz83XSMGo1Q5noax15yUdCjEnlOa3Xgpofgrh5
	9MoR0hicOQabcKBM4qDeCQstNYaakP7muhfc=
X-Google-Smtp-Source: AGHT+IEzLL54H5vwa3LN37su6z9goqLPdnhkooNQHGxiCyBDjr4E/ti3AEeNwJyJ1VgMApxm64r1ywU8ZOsX/8kZKwE=
X-Received: by 2002:a05:6a21:9214:b0:199:d9c9:2b65 with SMTP id
 tl20-20020a056a21921400b00199d9c92b65mr7144081pzb.55.1706832006086; Thu, 01
 Feb 2024 16:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131113951.17077-1-mpetlan@redhat.com> <ZbpPa1ZjoOdGw9Yd@kernel.org>
In-Reply-To: <ZbpPa1ZjoOdGw9Yd@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 1 Feb 2024 15:59:54 -0800
Message-ID: <CAM9d7ciY+is936-cHi45PRYjDuCECbX9DNy=qnvjcNC5j8twNA@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf testsuite: Add common regex patters
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, 
	vmolnaro@redhat.com, acme@redhat.com, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jan 31, 2024 at 5:47=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jan 31, 2024 at 12:39:45PM +0100, Michael Petlan escreveu:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> >
> > Unify perf regexes for checking testing output into a single file
> > to reduce duplicates and prevent errors when editing.
> >
> > This will be used in upcomming patches in shell tests.
>
> Thanks for working on this!
>
> The cover letter could've said that this is an effort to upstream a
> pre-existing test suite that is being used for quite a long time, that
> it is available in github, etc :-)

Yep, in general, you'd better have a cover letter when you have
a patch series including more than 5 patches.

Anyway, thanks for your work!

Thanks,
Namhyung
