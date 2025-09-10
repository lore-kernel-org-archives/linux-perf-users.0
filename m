Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F73BBF0
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526378; cv=none; b=IRDSWUGrwYQwGJ1ppFM7/QwMhO5IMHIcy9IKkHDcqYymBURfqkLzSAzUVzge85+svkj0U9W4+gz+PrVVTwv7xIwYt+UJx46JWVKJLMHAhrXWfaU1YFyhx16PFTSa3KPQx6QRqdBWOCQeo5LwBnd3Xvu7B+dBd0ye8Pcc+7wuKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526378; c=relaxed/simple;
	bh=wQDj2zgvbMFrsyQiuWDPhZMsiQB+mYgEXQMPF6cvHcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW36PhR6YUEXYE6WaTTPv1b8Xj07i/UGumIWlyq4dKdj0SCs5+hn+VFfD27ELfDyiu74EuKYL3WfUInDKIOPx07Q1H87i4z9/qtsQJjDKYMLOC//5s9VnmeiYwHRV41cQNg6KzO0Wne+MVBfA2uLQ9j/FgCdkcbzqLhPzvIO19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgwonXw8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgwonXw8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24b2337d1bfso21745ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757526376; x=1758131176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQDj2zgvbMFrsyQiuWDPhZMsiQB+mYgEXQMPF6cvHcA=;
        b=cgwonXw8dyDedgscQUvq50it1Bc++WUKDhaZ5HFKEdLmbaKRoJIfbiM33P+I2lXUJj
         Dxs76BDrPkuc9UH01lhWoPMRzi5Cuf2IrIeqmNYZd5SBzf6A6AaUjyVLFabjPMwwlncD
         SQF7YU9bqnaeIQHnNE8w3WtlbwKGqwa/2YYd2C/9rCh4gTW1IVj5u7Z6JPA4YqG02I27
         Xi17QixactQH2uvsIKPKdhw6lmruGhb1+QJ3PzAV9D9TCCxKDXlQC0bZl9oFrwXJDZWi
         4MJj6rAhvV2v34X75AtlZ85kX5Xn87OFx7QXpLvinp6K+kpT77aUbFlM7bQ+5kh1iNEr
         NOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757526376; x=1758131176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQDj2zgvbMFrsyQiuWDPhZMsiQB+mYgEXQMPF6cvHcA=;
        b=WgUQrFN9Q6dkVGhLIc/Ql5UuL/WHnKWY1clVJ15Ue1jiGaA+xoRSCknfbhR/EW2bKx
         530lDKHXEwQNdgnxZHxJs31pjLV9DQmMZt43CKY91hOxWvcxLJvnbmLRT5uyHrgY4Hqk
         OX4PoAPJk6ff8Mju//UU58kzvgOOakihKhrV7XBc4Ou/Y+6jVbhQU0xgBN0ezrOaDo1V
         zFzUF3F0iU5UVU4ktCm+A0Gn38/MaBAqWvlUWlxOlx75JM8GxYOFCjlXY5wOQqoi34z5
         e/4Yz1v/wVRpZkCXX+N9XMz4IzS1+ZJhaf1iu1qCrZSQbXrsklFqVC2q71AK23NLpcTd
         /sqA==
X-Forwarded-Encrypted: i=1; AJvYcCWUI8WbmWt8yUXHAPA9C0IaUbbR3ZxwLiWEn0Oyzd8hQ1DhBopy5cmE7ZwmkI9lvNQdk+Airteu52Lg3p331+qw@vger.kernel.org
X-Gm-Message-State: AOJu0YzH23c04NVWrsT6l0JgtWG51wNvvPREmbhU6eecU0d7hlqwhsp2
	eaQYohbZI26YIWADZFh1s1FKdQuc15IeiTLhmvisUjgvWXilcfM/zZ9l3Um0LMMAmuKagHquijz
	FLKqhapKhWih+RSUvsa+S51dHqoy3T30wHQm1iJfA0t2RLjpYw89Vej3e
X-Gm-Gg: ASbGncs+4rZjiZwsyIzGnYcP2sfvXOc2ez95Qgko2bVN1iuk8Cm2Y7Fdzav1Rh0x331
	s4syrBSnoyDMYk5iqX4JsUyUXR+rTUNvNDivQIlyrBsF8eUGLB48ETlvRTmfDi3UnCAzHrBYU6K
	UHl0s0waTuxBuPvLmmv/aqRh66PAuMEDDEIZYCnxQPvR3EjDsG/F6gMD/UQ7hYpe/oeLWyZUIQU
	FoiZddn+fmgznWWm6x14+zn6a5DhFURutQKIdf9mDTp3XnFLdZmj2k=
X-Google-Smtp-Source: AGHT+IHueg9kXT0omqcYh1MygVGHuEc9hy8Rqr0QixuEBTlPZQJZorBCF+J+Y4ifx7VPu0iQKqplryA7OKjyoAcrw8Y=
X-Received: by 2002:a17:903:1d0:b0:249:1f13:9d67 with SMTP id
 d9443c01a7336-25a7ede71b1mr4755965ad.11.1757526375136; Wed, 10 Sep 2025
 10:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814114908.45648-1-atrajeev@linux.ibm.com>
 <aJ5FvBa4LPhMO0u-@google.com> <4772D6D1-D61B-4269-B20F-17A387CAAAD9@linux.ibm.com>
 <D3D67CAC-C609-4C25-99E3-4E130E2C9AFE@linux.ibm.com>
In-Reply-To: <D3D67CAC-C609-4C25-99E3-4E130E2C9AFE@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Sep 2025 10:46:04 -0700
X-Gm-Features: Ac12FXy9JX7KkckBNq3ZEM7F3jal1Fln24W-tCLhXu3xkjdfH2B3CUAxMYfp6AQ
Message-ID: <CAP-5=fXMKoF1z4TPDJhBFqz8gRdXcrCBTJdBvRLhY9rzrCFxfQ@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/tests: Update perf record testcase to fix
 usage of affinity for machines with #CPUs > 1K
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, hbathini@linux.vnet.ibm.com, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Tejas Manhas <tejas05@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 10:56=E2=80=AFPM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
> > On 20 Aug 2025, at 10:50=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.=
com> wrote:
> >> On 15 Aug 2025, at 1:53=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >>
> >> Hello,
> >>
> >> On Thu, Aug 14, 2025 at 05:19:08PM +0530, Athira Rajeev wrote:
> >>> Reported-by: Tejas Manhas <tejas05@linux.ibm.com>
> >>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> >>
> >> Acked-by: Namhyung Kim <namhyung@kernel.org>
> >>
> Hi,
>
> Can we please pull this patch in if this looks good ?

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
