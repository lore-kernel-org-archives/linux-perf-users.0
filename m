Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74A198A30
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735364; cv=none; b=CWGC3ehq7q+cebhwWV1+1m8ES+vW/ZmYxvUPQgGJKvyUC9XW49mi37aBrTNvrAYewc9E9Y3Z7p/PV9x+yFbCzY9WQlOuPDny3Aq2eUGCw+3IX+AedecXYuZLmNVjVx9UqdfxLAXhhdrG26X9fBridM27eLJrjdWfUY8A8AG0/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735364; c=relaxed/simple;
	bh=AjvG9wYB2Zlm9ATKMGYH7jIuHXZ4cewAANEtE/mytYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmu4CpOmcTHtI/u3dbo0Inwu1FbYVHgwxlPJSgJ8gn0QSzpIq5QIn9qm6hVw61lbiyHZNjjnhc2KwygRE5nFW4rs5TQEau7xhv1Ken/m7Z3DmTkGHclZzmTdQcCGqFIBj45ueagI55pJpG976XVrkeFTfUVLOAPH4ceZutH3T/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WBvv6hDY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WBvv6hDY"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dbb24ee2ebso5193017b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726735362; x=1727340162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slAQXs/8gsxb/7jYrM0cb/6jV3C3g1UiOusXI9+lqus=;
        b=WBvv6hDYqWJzsd7do6x8DUYv/xVgPBysvzncZ1sDFstwYZ9Pih6qzyjGAg/7r/G1Gz
         hSROK9dspICy+8Gfh9de0A/7TlCW6vKI5dEQJOhi/sv3kYYRBIVFLBIrh45NAcCKO+r0
         l0fGUXhyj+Zl7f4ODoojE5YRyUm+jH1b6hVzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735362; x=1727340162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slAQXs/8gsxb/7jYrM0cb/6jV3C3g1UiOusXI9+lqus=;
        b=QBcBepUNDqqbvnA+U+5wSdKevPh5iSgyGa61fxO6x0t3deS+QfDFjdHktGr3mIV45J
         yJsas8CYPo5zOKlgHOOYpFyKGdZSVWxbS0UAz9p6UjYplplXAl1C8oITBsOw8vbyUQor
         5AQK6JDA6G9f1Z9AgZ3ZHLIJRfr2/6+bEwCOBPu+Vxm1gUF/Flv951pdI+vSRrchwkIc
         Jt4cNnzR8EtRSG9Juw4AQCgFLiqc3rRAzlpgxg9wBQHaA/lgPAfrumt81KSALM2/fLnX
         yycBkQbHOOidP+S8PdGe1MFd5GqUssfQuFV0Nsgp+UqhOif1u6cB0uJ4jzv/JfGOwmTm
         alTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBRm9WHh6Bt97TDlI6X0BibLUNC9GSwb+yU1g9c8x+WOUY3llzx/yKl2XUJcFN8LwTE9XuUQrwR+fIB+VT0DyG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7ljuuhF+0u6bTmSuCUkVarkdz5LQ2+tqm40QJoOZ88tlUIBZ
	ozBY97jKDhGGyQm0kFOTK0HUDloL9x4aHkROTmxD3jEQMrKRYwxmas+IAANBfgoQywyjlApzbDw
	aDgQiKoFtxkmHUS1SpZler23Mdg2k0k+8K+YY6w==
X-Google-Smtp-Source: AGHT+IFj00vfKV9ATD41y4iUwq9opmPQ0T3gBgBVz2kUsBxnSrNihAw+UT8XYIkJ82CMWHwArjry9OIZKMme+UHm1KI=
X-Received: by 2002:a05:690c:fd6:b0:6dd:bace:4a5 with SMTP id
 00721157ae682-6ddbace0647mr150035247b3.9.1726735361777; Thu, 19 Sep 2024
 01:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com> <CAADWXX-xNBRC8yAUmCdPxe3W==Dxa_Xi6P_ceYDAEAeKYiqC4Q@mail.gmail.com>
 <ZuvhwjNgDmpmReUl@gmail.com>
In-Reply-To: <ZuvhwjNgDmpmReUl@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 10:42:30 +0200
Message-ID: <CAADWXX-Mu=h7hh1KmiWMPoDoVSTb=oQ5Huat+2=hsm59g4R6YA@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 10:33=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
> Thanks a lot - I fixed up my SMTP sending path, so starting with this mai=
l
> it shouldn't go to your spam folder anymore.

Well, that didn't work at all. It's still marked as spam, and the
headers of your email still say you go through gmail:

  Received: from gmail.com (1F2EF419.nat.pool.telekom.hu. [31.46.244.25])
        by smtp.gmail.com with ESMTPSA id
ffacd0b85a97d-378e73e80basm14420731f8f.26.2024.09.19.01.33.08
        (version=3DTLS1_3 cipher=3DTLS_AES_256_GCM_SHA384 bits=3D256/256);
        Thu, 19 Sep 2024 01:33:09 -0700 (PDT)
  Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
  Date: Thu, 19 Sep 2024 10:33:06 +0200
  From: Ingo Molnar <mingo@kernel.org>

with no sign of it having gone through mail.kernel.org (which is the
only way to get the right DKIM). So it still ends up with that

     dmarc=3Dfail (p=3DQUARANTINE sp=3DQUARANTINE dis=3DQUARANTINE)
header.from=3Dkernel.org;

thing.

            Linus
