Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D93205AB2
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379232; cv=none; b=QlVZnAPF1wEmoUiDe8DxMrfrupgHf6CobNcvre46D0IFagVooWGUrh45GMp6CenYb2DFrkYni6nzirsnAID2XmKpZ2TfD9cbyDduh+JRllF0XDVAfr5bft5/RglaF5M+dmdLkFg1XQNOgcpMP6vTUi9PcqDEcKdtWDD5tx9jZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379232; c=relaxed/simple;
	bh=JaBoPuh2liKuEzkZUaMd4QOoDMraI9AIn2xSl35QZug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1iHpWFc8uNAaACLpO+DHs2sG9udlD+BB0vCJn0K0RIp/2DI53Gdl/1htqJQ8X7l3i3di735lA2f/mcn81ZL4+5kZ2jKHQ8dZKNc42ufAnuUppmKJSp3YQ5lcTaLFygg15yUCDsdIY71kx4kUlktIPuitgOUdDDZXe7Jck4pmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xFYJ5V8D; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xFYJ5V8D"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso17525ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748379230; x=1748984030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/Egbckowtg4mbFDRc5WWolxnK85TNH/cSEuse5tMFA=;
        b=xFYJ5V8DCthIwEX0goXf/X7clM8/PfUG/mG0GKJUsVDic3upZLfkn5/R5iEQ2/Kiv2
         +qO2wKOYTS5Mtk0GNPaLDBTcJpefE0BwntmfCyeptISA0Pe1+/E+0fXpjEu6c7eOvyb9
         nQ77UGOF84m7YjmJlY28D3jtHCs8hgj1o1ljx3XPsPqSnhazA+OyaS7q4BzDIAEw9B2o
         wheOuqFAtuQUzF0WV8EMx7CrkoIniulyKZMZQBchdBiyhJCQDeo4jEGvEvY2YiaRwius
         KTKdjFIKFQIALrZVGhGnI9+gBegq+EHPTZOsOmD4bJNWz++u8yWQcNGRIf6fDOLhiAMD
         Cfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748379230; x=1748984030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/Egbckowtg4mbFDRc5WWolxnK85TNH/cSEuse5tMFA=;
        b=hVm7pRVXHM1tjKtVjARTmaihUa6knYF8x/13IVAv3yf0A7cMuFAjShIBfCbem/Vss8
         tE4Jd70eFKGlb4XwLNKyCRvQNdjptD8akjVBlJB9ACF2kUU29OLRjFP5phAzVVTe+h1m
         zBojcEO90wXI7A3AsdZpUVMwG5mQ3RrT+YssHE7Z+JZhE9dUYo5iSO/XnMlCrK1QuggK
         g2Q/2dwcMYyc7eLKQ+6TUijzmuQgPmXUKNIiY3Xl0Gt6w/VWuGFEh1k6xAeXlZN90Ym2
         icNZkARVweH7gBxuTzfdi1i8baz7SjJER8v3DJNMpbphqpVBmLy4Rd80uu2bsQe+Ynom
         HagQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1HRPZQsrm/PbyoGIAWYFAYY0nfUyUo6EQ5zyXDM+9WWR/JQAHbIFXsQLCN87xY46bKqJwaERII2s9Xzx7IY1N@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzx3koT43yiCUrfLWbbhfDdU72z3tc+DjhlDtczGYn5pKd7uQ
	Iw3pjlSafDVeraXBEKDxwJDHCn6CDAUtOU9NZs6H4XwGSiMtggrk4N1SpXfo/HT4tWgU481HrKd
	FC+/2V3YIKi7au1nJcMuoqNk9pX0hApq+QL9PT3AX
X-Gm-Gg: ASbGncsfm7Qx0/SzVF0stHtigiOS58GHmSWIyZIipKXqJjN/EfuTTN1/Ep/Me8/rQhD
	DDIEoknTOhpqbDz/wagh3tn54z/+m6/aLTZQFmx3FipShEGQgjtlKGrYucXTbZsqLLKZGOMqWzn
	ecCBbwfbg8Zz1w8I7pcDzjUUuxnKMircjP+L0WryV+zlzP8NJObeuks4dkUO6DCE3/Ad4E9f/3
X-Google-Smtp-Source: AGHT+IESjRqa86xXrwB+JfdoCQTKoc8siZWxd5KbuYCWZODADNacqM+YyPkxeS1QKg4kEDphf++qtuTPxynb4aPotNM=
X-Received: by 2002:a05:6e02:3c83:b0:3d9:6cb3:d6d2 with SMTP id
 e9e14a558f8ab-3dd88f513d8mr1055455ab.4.1748379229766; Tue, 27 May 2025
 13:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410202647.1899125-1-irogers@google.com> <Z_mK9BVv16MT7shL@z2>
 <CAP-5=fWykL-01S=35zz-6JASbM_cQkx6PHdKS7pJAX0=JBTuNQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWykL-01S=35zz-6JASbM_cQkx6PHdKS7pJAX0=JBTuNQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 13:53:37 -0700
X-Gm-Features: AX0GCFvRnFp7k6lOspw7S4fvZcaUmElbp5d1cVmzFvqBlHbjQ_Qi2gmEKTa9M94
Message-ID: <CAP-5=fWFYS7-FcbyJ5Z5U2rqA7eYwwJ4dMf90TUzwJ0Shh2yxA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf build: Fix build for clang's -Wunreachable-code
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 3:14=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Apr 11, 2025 at 2:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Apr 10, 2025 at 01:26:47PM -0700, Ian Rogers wrote:
> > > Clang's unreachable code warning is able to catch bugs like the famou=
s
> > > "goto fail" which gcc's unreachable code warning fails to warn about
> > > (it will complain about misleading indent). The changes here are
> > > sufficient to get perf building with clang with -Wunreachable code,
> > > but they don't really fix any bugs. Posting as an RFC to see if anyon=
e
> > > things this is worth pursuing.
> >
> > I'm not sure if it's useful and don't see what kind of bugs it can
> > address.  The proposed changes don't look like an improvement.
>
> The goto fail case was in OpenSSL the code from a bad merge:
> ```
> if (...)
>   goto fail;
>   goto fail;
> ```
> Meaning the fail path was always taken and checking on the non-fail
> code never executed. Newer GCCs will warn of this because of the
> "misleading indent" but  clang won't. It is easy to imagine similar
> mistakes creeping in, so using compiler warnings to avoid the bug
> could be useful.

Ping. Thanks,
Ian
