Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518501AC8A6
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723766431; cv=none; b=dW+3D9nJfPTptnd69GhToDbNG2qedAWgnbWmB2g7DLVnuN6mWWUy+Ew73bDdtWBy8/tOA7gq3qGBGRIEZsAWJMeK68eNE6WyFb3Nvd3dy5DHiwWR6mv2nJWVxC6XBWFAOx3bOO69a1PkS+6ya7pwk3RuHyzMz3nq4MzOtEPm1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723766431; c=relaxed/simple;
	bh=k90ZT05quib4caGUBiFc57Usz6uy7VWpEw3cKsHg+KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CcuemN+QNIA4Pbg9zTuVv3gJnEQH+J7aREIAfeKiJk+H+MZts+wcwiZQqfVFPqd1OxfkO1kIjX/0Ms6+iVmHxmeU6bxXHqWdPR4EdtUrTQAY2d2x4RcNUyUe082zHO4LkwSWOKpCnSsyRWBFuGwu3hsGnKhbOK6vRMjJxJW8HLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKvBT8BF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKvBT8BF"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201e4cf371eso37455ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723766429; x=1724371229; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k90ZT05quib4caGUBiFc57Usz6uy7VWpEw3cKsHg+KQ=;
        b=XKvBT8BFuSZBeWGBJp7JZOzNjSZpOIbO97TeCOLSFSfwurdutFZZ4BiYt0XBPCE3Mk
         MS+n72fYoZWSQAVMGv1sq+50WU0y4rpwI9q06aAePEifNpZwUpp+vevlkr6pRo3YIN4m
         a6xMj6iHFZUxbeHwmndbog6yyDcxXYCF9Ty0joifK5vmTCeew7+APrF3IgwpEmfTyZWW
         3Y3r8FkZC8GzDKwNa0XrfFoG3s3k9L4A9WpQbmPtt18XgiIvzJqRN5keHr7cdOmkRMK5
         cFE8s1MEnprO5d8Fg28e9UgNc5ETtUzeOHG1GKNYJIvCTh7QwspMP/V2VwqTq+QciN3Q
         foJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723766429; x=1724371229;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k90ZT05quib4caGUBiFc57Usz6uy7VWpEw3cKsHg+KQ=;
        b=nO92lAc9+hD35GnDrlg5FU5MctfjANP136DH+xNKgbvh7dDRykSYKlLxCFDtlt9/1x
         tQDfuBYnwwIKCzC8Tsx3Mo8PLrknt8/y1l4NpbFUBsk7447u1kpj8mNOcqfbYLfdYApF
         bGgEkZoxwguDYAgGIBNyihRDlF2wGGid1v8/03kakEydcNt1rftS2nHv5JYwuaQUxiZS
         QL90TeP10Mk7x4YV0bDcUpjCF+msi57T1BjUe3k749mdJxYZ0IvmeEMuDv7jyUDP3rsm
         8fK4+bdM49S8P8PGsxu+312aiR+LRQiYjkOkye1n1wrGSX61XsknoLAQ4KAU0fFs9Y7A
         ld1g==
X-Forwarded-Encrypted: i=1; AJvYcCU5cIwuLVGQ3FqQfQppw3HElE7uQK2065tAr2m1R0bz+MU0H8KwTD4YmWk6g9uPCVBrfAssIZK/cLC75aD8MjNDnDLxkMVfO7yM8ZShUFTSCg==
X-Gm-Message-State: AOJu0YxCTf2A9IRV92PD3qc0PDNrhU2nE50zArA2NwhUI0dYGCDI4ftq
	xfPNRlXDSmvEx1dQzsnf5FOK2fj7xnCYwutX68GCYQzqQipdFiuDBch+VxsA5o43iisq+WHK7CL
	YzhnNoppeBg1S8/9vH1Fcqxj/OdmeydXObxNR
X-Google-Smtp-Source: AGHT+IHa6juDFMAMS6B0huLXTFiZsxLdn8sNWl7ANIVBRxCn5iHB9MSOzDWU5IaU3tHbjL5+tEnIwgbFVj+zju+kZSE=
X-Received: by 2002:a17:902:e849:b0:201:fba5:3ed with SMTP id
 d9443c01a7336-2020854d15cmr328195ad.27.1723766427440; Thu, 15 Aug 2024
 17:00:27 -0700 (PDT)
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
 <CAP-5=fVazh93ZRqyubCC1MEE-thDKoamO-L_d0-LZjNyYmD0vw@mail.gmail.com> <CAP-5=fU4fwZdWNXbCKjs5+T4G2NnfibyhXFfif130vKZwyYcBg@mail.gmail.com>
In-Reply-To: <CAP-5=fU4fwZdWNXbCKjs5+T4G2NnfibyhXFfif130vKZwyYcBg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Aug 2024 17:00:15 -0700
Message-ID: <CAP-5=fWKfUFV8f2b06cTOp2JSJg4WnEja2f6dH2_NggOiKKNxA@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Next week is the last week of GSoC [1], so our 2nd to last office
hours are tomorrow:

Linux perf tool office hours
Friday, August 16 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Topics of the day and GSoC. Looking forward to seeing you.
Thanks,
Ian

[1] https://developers.google.com/open-source/gsoc/timeline
