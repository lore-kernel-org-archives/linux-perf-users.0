Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A641ACDE8
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726169496; cv=none; b=eK9hIh1UOdPrjhP6MluLSxlTj/Cd4fO1fDz0YJbntiOCtoW+7XfZ84FIZdqPvvs87eYpIU8Np2DXRAW+Zz6tMiDp/eQEhVmw9FrnctghbdSxkX6TBqn+2MbpbswXJld/1j7ZTDEDePIeU7HfQP07/dRpIZGJxN3yORpMQ44Lvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726169496; c=relaxed/simple;
	bh=Cr5zlDMGaPNV64I3wQ6jiU1g/Gs4cGVM1A+QGKe6gR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9J2eNZN1aNJlxNUFFj2YqiD77Rcqx/yftYjEfCM+5x9wSAevELK6bU0+rclpBYWn023WfT9CtJV4bAfHK4OT/wV0P0dkZOwJ0+YRebCbWpTxCt7TTHeCpQz7f9c2AdWIMAQtxCeLmtUfCJFG3ToQdnbabSKuB5t5frKW9SIOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4MxGLPaP; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4MxGLPaP"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d2a107aebso40355ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726169494; x=1726774294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr5zlDMGaPNV64I3wQ6jiU1g/Gs4cGVM1A+QGKe6gR0=;
        b=4MxGLPaPTmC3AlKMOaz0FPsdGsogkhpoeZnyxWwykvUFrBpJFGW9fajYOsqIT7LU9I
         tYIoeaIsQfX0L7/u2lcfMr+8SX6r/pqzvUh3Ag+hIETedKg1biJ1n+eLO976i7DGk4R/
         cgm47xDwGCP3jf+5DCIHVFpPYIN8YJ0rkVB2Ha35I3zkalLNr5Ghjbz6BVbjnUo/09J1
         eqBzxlcC7cgBLrUAHHL2qAPJQWIsSBjNBtnu2o8Epep9BhCm4yzQGajHinZQip21q8f/
         2IepCT5T6UwhLTPCkIdbJY2RAFyocltRfv9KX4iU/yz0b9jQj3OOMKBYyHcTUppKZh1o
         2PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726169494; x=1726774294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr5zlDMGaPNV64I3wQ6jiU1g/Gs4cGVM1A+QGKe6gR0=;
        b=QXR/rnAabV1ay98cQkgB7djoNZIj5gjDojXugclaMuy1p5vSw5KQ4dgJR6ztiiE66o
         H92zQsxkxivImkONLCryS3Isw5TziRwljhkcpwHsFFiF6p/QGtSGahVYc9/ty+JkK6xB
         JO/4d3cfzdpoBO63/8YFk812yz9KRemPTYrv60HRF6OlLFrLsXa9jwND7D5XhD8kS0Ti
         DzYERNNBCfvHCjbA+zQl/CJa12PDCgrUmRZB86KaDS1VItf4sep5PNz3rGUnszmvIvx8
         x9JzPCzyic9vfRO912FkBTLdZN2PttMe/DJrAZPzASlYh/9NjHTgPgbbc9+YyGmtI3uV
         Z+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIWqO4hMp/4n4Uu6nDSpJyQKmLX7gOUkjjf1CtIrE/ZpubeTMfWxHUC3UnlGTpg00rxF9NXDmF6d4lLSGClSz/@vger.kernel.org
X-Gm-Message-State: AOJu0YyHsnmniSwzeyI9a62XBEgU1gSLbgI+Y2zeT1kOBu8BBwEtveij
	iECH4M2SpPUXJnK8llfW/mnuWiPo7spAQCcSalvS/JYhoa/vhg03xKG7GSpxC15Vne1qMziVI1o
	tIvhsZMcxgR4WPzn6kEMjG41/Q4GIpbXrEsZC
X-Google-Smtp-Source: AGHT+IHvH6+bWkd/eSNntgoj9UD2X4cfQfRs08lgUinSsz7xEoyunyuN7JXR3FANHFFusAgInC4jFNzt1d2xEHsRndg=
X-Received: by 2002:a05:6e02:1a84:b0:39a:f2f4:7ec1 with SMTP id
 e9e14a558f8ab-3a0847e81b2mr5237655ab.20.1726169494308; Thu, 12 Sep 2024
 12:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912182757.762369-1-irogers@google.com> <ZuM9zc71XXXZ3eRZ@x1>
In-Reply-To: <ZuM9zc71XXXZ3eRZ@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Sep 2024 12:31:23 -0700
Message-ID: <CAP-5=fUCVa3VoByKUFDp8Q+M2ZOTdy7ccL7Ter8E8dSE368KAA@mail.gmail.com>
Subject: Re: [PATCH v1] perf vdso: Missed put on 32-bit dsos
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 12:15=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Sep 12, 2024 at 11:27:57AM -0700, Ian Rogers wrote:
> > If the dso type doesn't match then NULL is returned but the dso should
> > be put first.
>
> I guess we can add:
>
> Fixes: f649ed80f3cabbf1 ("perf dsos: Tidy reference counting and locking"=
)
>
> ?

Yep, that's the one that added the reference count increment.

Thanks,
Ian
