Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA681208
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031340; cv=none; b=N+pSU1/Fngo1r5IZTLA1yYHLQ7MbcWJKzKFliYaEuqMY9BR8KEpDN+2IoTrX7CxQgTKULLApYtJ5f5/9Fbd4VFeS8ETMBNcjbhAcESWafncUk12ApdCUA2RyAT4WKDpxaT592EbfQT5LPhM/bWJWq3oaA2OvpjRiCHMo9Gqmr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031340; c=relaxed/simple;
	bh=DMHG/rdFVPeY6W11N9D+zF9frP0CBTOs37iGBVuC1G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZObbUUyaXsFrSKDG2qoG/dFlz9yafuwnLty6zVP59ZdIpbIXhU7aLGmOhbW0U5+oC2tONUbNyw6ahEE8dNShQuFmE6OmnQXbl4oSwqMX6EElUnbQzMWdypIdwcRFKr5ieZBczauRSlgujOD3gAB2rifkgytZ7vCNOBEfDlSIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jiGRR2rE; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiGRR2rE"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-361a829e012so125795ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 09:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706031337; x=1706636137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DMHG/rdFVPeY6W11N9D+zF9frP0CBTOs37iGBVuC1G4=;
        b=jiGRR2rENVxmiNSvO/AbCnd301VccyJXi90bUUABu1xfcKXJL/z+vjB18DZf5bSHgF
         3h74V63qFASaS9tOHTyz6n9964h6v/kv8Bh7ACFdNdOV3guGkb/n6vbk0Vy6ZgVlmvw9
         GWvxb/Sf1Y39ohMPV80SwaMIr8To6Z209IAsY+yMj4OwtlklZqJdpCil0z6cT0zd0a6t
         Q6ZOe4+o0TCoS35Z+DmWOvu5Qc20FqoXUdhsZCHAW573hMjCndRShwn429e5SuexrAqi
         WnxLJgkSPlOJ9lAbnuU0hnqDeLFk3+aTl5PwR6iY3wSQHVnVoNqWneK/SJBph5vqjdFn
         e3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031337; x=1706636137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMHG/rdFVPeY6W11N9D+zF9frP0CBTOs37iGBVuC1G4=;
        b=MQ69379JUkZg3TDwgnrXi4a/25idUOwX1nKafVxwIbra3yjPuzip6a7VyT7A+/FrS+
         uxyJg9RHxjcSzVFHiTX5Mxx9+xEnhPbE41y385sezzVNQTT5pI2wYYh9c5eloc6BQotD
         cK1Je6sOc9lCoxVXGbv1ATfH4oPwBkg5abF76LpWc3nsBxNo6vswJLvuyczsBCeNXTz+
         HtTCDvOU0oscz5MJlVmnZagarxBdNu3l6D9VfxjiHbV8Opfy98fgyLByFRBByEA92/5o
         73nHhGui1O+ufOE3ZFEicCm33vGyB7mPM5j19xfMeHIm0GDo2ipd+WlfXjFBW3M8CRX6
         JUlQ==
X-Gm-Message-State: AOJu0Yx7ZlHqYeD4ZPd1mzAM+tBa1Wlk3s78HAnpKotR/S4KObRZ0fvI
	TthnnvfzMHy1eAkWDyX6iiFaaIIQozPPZ9GP5gGdQUuBCf5Wb+/fpjvkANzfDVwt4TvDdJ9pEAt
	yoGKs6sjUjn0LfVZJqoAItAjNLttrE5BHKz2xhZNs7AhCNMOkf+oI99s=
X-Google-Smtp-Source: AGHT+IHJ1f5H+58Jq/jyEppPJXQi4cr8twIFWsunABegDkSuDkhteSdLxsoqnp6njL86Ot3Ut2+Vvlsaa2O1uK5bwqU=
X-Received: by 2002:a05:6e02:2183:b0:360:2a51:ac03 with SMTP id
 j3-20020a056e02218300b003602a51ac03mr27150ila.25.1706031337271; Tue, 23 Jan
 2024 09:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0d74749a-52e8-4082-98b3-9efafeb1168f@gmail.com>
 <c947fa14-40ae-4736-a951-ec47738b79a3@gmail.com> <CAP-5=fWSfUqZ9pOCZM47af81WdV2e8Bm67e-2XAAi7_cve9FXw@mail.gmail.com>
In-Reply-To: <CAP-5=fWSfUqZ9pOCZM47af81WdV2e8Bm67e-2XAAi7_cve9FXw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jan 2024 09:35:25 -0800
Message-ID: <CAP-5=fX_V+8vuTV8hWQawxZ-pQsRCCOWT-zAyskE_a08JPM57g@mail.gmail.com>
Subject: Re: Google Summer of Code 2024 - Project ideas page for the Linux
 Foundation online
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: Till Kamppeter <till.kamppeter@gmail.com>, Aveek Basu <basu.aveek@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I've refreshed the Google Summer-of-Code project ideas for 2024.
Please take a look, suggest more ideas, volunteer to mentor, etc, etc.
Help is definitely wanted :-)
https://wiki.linuxfoundation.org/gsoc/2024-gsoc-perf

Thanks,
Ian
