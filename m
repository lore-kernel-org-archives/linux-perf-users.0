Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1C1991D4
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735845; cv=none; b=PeE5Z4I73QblwP8sAtC09RaUvgFV0IIL6idR/SGkq0ZZedPoIiQO1dlJ5kxaknbvpYEmh4TxkptmtJiFscy2flDNNCmz4r+0tBQuS9M1SKTVuboF6GCI+3Kf0d+4bEEfL7dQoTdfP3yuzD8uDbBpN47o4ZcrU3YwgNyTp0rqOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735845; c=relaxed/simple;
	bh=QmvEcvLwMdZ67Q+orO7a1EFbutgSspJs9seQ1l5q7bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQjeNPgsjaOw73a3YmR4hGrVHHzWHdKBYXsD75515pq0Y2+PGb7FssE6mAyzuGnDVAaPBpBteLKXTE1hEUrTJog1j3jV8qzZRpNak+YVockzx/Nzxik33YpgUNPgnpDdjauyUv5U+fyjYdJZXka2fbWSRSbg6CzxKZS+PfV3Nus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G8XM8bpa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G8XM8bpa"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a843bef98so63393866b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726735842; x=1727340642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3bX8owsMFpeSMLK0J1ihsNP0TAugOLIv4seUNiUYOnI=;
        b=G8XM8bpaKTulB6Jo0zeswpnbkZM2JT/N6H8OtUN2xjRakzV8CCcwW2F2Sd3dkvI8EI
         z2P8/fQKVRaY5GhfuRd7R3M/WB1vGB/gtDIcEglmrMO2RmU+NVTv+reJHloG90EGn+u4
         iBMwkvjBgJxibwIb7IaOscpA9gb2IFXrIIUvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735842; x=1727340642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bX8owsMFpeSMLK0J1ihsNP0TAugOLIv4seUNiUYOnI=;
        b=awpgwbWhftKwHjQwc1nYv5PDTJpTaeCUMGO9qNVf8X1nmi1zjLdsRR8+v5Ad4Bln+5
         blyPsaJze6NkLESeNm6Vnh34yJW1lAecijNhwauF06VrOwWMnsLxiLlqb2lUzIGOEwo2
         Qh+i9RgNGil5nBOz8affbwAlbih8CdW64yVdC+to0jf7zBndv961MMZdtmyZcDANeAxG
         6Oqd7nW/Yy84aLaXl7S12go/+QmnQmoBzyci4M9CnLSqpQR9eeFrloJswHz8s+6iDfLF
         Nu+vJV/Vn4bWC4wMIu98s5HDRw6ko2YUU07pTZKFrXHobrp864mOkQzrPRdXceQze3R8
         SgEw==
X-Forwarded-Encrypted: i=1; AJvYcCXoj9rJbzrWouCLc+Ds7nQoZCmmaYNw4L7fe3eFcmI6/eV47vRrlFeLBMIrOp7vyMX6hz8rQp+DazQbacwI2zUh@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpOyVSyayrzzFKremFTzO76lTGBYpqPxPOq0GdiI+eonS/Bqi
	tcNyULMaGSILeGm61IT1ZUSI37BEqQeZBQF3k13k45UEBc2nZ60re8W2LaeVUKOxAUyl90tfMa6
	c312IXQ==
X-Google-Smtp-Source: AGHT+IHfsAgNElyNpSBzKxC9Wh+srMDLPrDedoP1RSFiZClqwMxFFHXc4Le4jCxJ4QAK9HVbMzsMCQ==
X-Received: by 2002:a17:907:9802:b0:a8d:2c3e:7ece with SMTP id a640c23a62f3a-a9047d1ac86mr2092684566b.31.1726735841975;
        Thu, 19 Sep 2024 01:50:41 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90bce77c68sm139390866b.66.2024.09.19.01.50.40
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:50:40 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d64b27c45so91022666b.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 01:50:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgpIfr25igg8BdlW/8hyduZGKgjIbkHcF65pCU/grrXgXMNnW99f37RpGKsSTBxil3yFkyItOsfYiZldlzZrms@vger.kernel.org
X-Received: by 2002:a17:907:948f:b0:a8b:6ee7:ba17 with SMTP id
 a640c23a62f3a-a904814d805mr2274425266b.55.1726735840258; Thu, 19 Sep 2024
 01:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurLc9qEjBH9MkvK@gmail.com> <CAADWXX-xNBRC8yAUmCdPxe3W==Dxa_Xi6P_ceYDAEAeKYiqC4Q@mail.gmail.com>
 <ZuvhwjNgDmpmReUl@gmail.com> <CAADWXX-Mu=h7hh1KmiWMPoDoVSTb=oQ5Huat+2=hsm59g4R6YA@mail.gmail.com>
 <ZuvlTLMflCigipCr@gmail.com>
In-Reply-To: <ZuvlTLMflCigipCr@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 10:50:23 +0200
X-Gmail-Original-Message-ID: <CAHk-=wj5VpYL8O8H+t8vwOKjnbkxA1KMu_5c495Za4BeCybS0Q@mail.gmail.com>
Message-ID: <CAHk-=wj5VpYL8O8H+t8vwOKjnbkxA1KMu_5c495Za4BeCybS0Q@mail.gmail.com>
Subject: Re: [GIT PULL] Performance events changes for v6.12
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 10:48, Ingo Molnar <mingo@kernel.org> wrote:
>
> I fixed my setup, tested that it's working fine:
>
>       Received: from nyc.source.kernel.org (nyc.source.kernel.org. [147.75.193.91])
>
> ... and then I sent you the email from a Mutt session I started yesterday. :-/
>
> This mail should be fine. I hope.

Heh. Yes. This looks A-Ok over here. Thanks,

              Linus
