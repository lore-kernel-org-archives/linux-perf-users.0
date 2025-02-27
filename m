Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFB1E8325
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635114; cv=none; b=lO99CnFO1zef93ePdZtJ316LKaaePjgPT0FlXn/lthUnxU4GUqSP7WMYUeFtzPwybNPRW3gLnOSQFHJuI1R/knvrYK5bptOD8BGgE1PJOekhegVX12QDa3gPtBdXXfNEegbA3Lk1pDx6mstJiJBUq16q4UuglR3W4vd/r2VD9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635114; c=relaxed/simple;
	bh=SLWiea0Aef9fX2gsI+qPoqBT7kUfg9c1v6vDy9mQ0sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXov3NOkhvr1Wlpzn7ZA1trqpQsll5q6y7tZxc5VADQINaLaN4B/mjMH/PC9Bt57VOpN1AHWwpHBKbPpYrfQhKcnbftaoK1Y9rOpRJaCjYggetW/pdwllPN7/jrS+PmPHtpID/41RiRYUt7iCJq2uZYPJWYIgiiqCMFXnj/hqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ArfBqFiV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArfBqFiV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22342c56242so115015ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 21:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740635112; x=1741239912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLWiea0Aef9fX2gsI+qPoqBT7kUfg9c1v6vDy9mQ0sU=;
        b=ArfBqFiVQBBHexCx9iEu/HZXz9cSigDu1LV01pC2IgORd3rOVVq50fPrGup5cCkJNF
         Ove4jOWrkFgjcBhoEt9NqzcValW4J9hejsZazsQLuriMZ6sM7Cds58aHoGPtCvYcAptn
         eWXfYs48s3dE7+DcnfJETYQzhmHtWqyT61gv9OmaTzMM4oPAfmLMZK7N/+wI19nnh8PF
         n0GE3Cd97YELhJAnbQi9mckCq99e37McfVTkaSIkyX53J3ylBaX5ANyTQVTo2UJKTvq0
         CixmiOjN7CFuVbkpbfgT7dKupHZokivq9/qIiPggR40Y2+9fYNojRZHOKA2tbWk3jo7Y
         bICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740635112; x=1741239912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLWiea0Aef9fX2gsI+qPoqBT7kUfg9c1v6vDy9mQ0sU=;
        b=w55U5TKtz5STx0qr79AFW1zYPvG3R7UiFUKo8jdIqMppoRLOzxKzDZMYoDjdsyQxQj
         TeyP/wTBKxvWKUIqb7lAh7S9H1b4PLIlBeVrxfdj6psZfCYsaT6tpCc4BIlf2dWxQVIr
         mGsQhaU1DBGZBBXosL1JI9IhsP62ehgKOAP4moHHaJY9G2DabGeE0JiGzQ7MlzFXZRTa
         jjtE/n9Sz3xHUZFBVX8xQGFUclhrwaAXI8IRFfoHeP0dWGhdapes9yVy5UrYJAq0wO61
         tgqcdR1ZDmsBKp0MEGmNj30pXKZoIGkEVROcVkux2iEqWQzrIkk6tUd0MgjWOhRuK0uT
         u8AA==
X-Forwarded-Encrypted: i=1; AJvYcCVYRYBQ2BpU4LEJjjU+kKd8WmMQD87vzgJd169aXxCbxHQXj4PKxAPsAyHN6b18TD+riD3QIg875OwqivHHWzRY@vger.kernel.org
X-Gm-Message-State: AOJu0YyE3Fbp3K3BoR52lSFWZENC7n9Unv16QyXAtKq+zIVuRJ/8b3lM
	XQCnIaHKZojtMfAaFUChOiR2MhLKLRb/Vw6nPqOAziutQMwsknxz/Sj2vC7/1DdpJaq2hwb9lYh
	+tSmSeR7pRFbjlVA+Ru6SWPGNZ1r123IrEfGV
X-Gm-Gg: ASbGncuTgnOoAJ/fOGiTaTvyCCqMMiV8Wbf02G8J62z4wKwYyLEXYQkmh2DlWmI2gsn
	Qr6CTc17s/p5wXlPrR+sr/rqYYqfn6jduYvsZ+J1bnxYkr9vMEy1K67AKrnpUtvVfku41otA8t0
	6rFGmBAdD6
X-Google-Smtp-Source: AGHT+IFqMkL79/eWy4XdP1xrv06mvjKziZfqZQMUg+khB8ASx434G1slmVA6vtC/7p6WJ7qOVGq4Gr61wBvDlu7Wfaw=
X-Received: by 2002:a17:902:f68d:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-223517240eemr1135965ad.7.1740635111816; Wed, 26 Feb 2025
 21:45:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com> <20250109075108.7651-2-irogers@google.com>
 <CAH0uvohxfk0wYv8NB5i7dZJ2+0PX22iqVAJqWLGqKykrqC-RgQ@mail.gmail.com>
In-Reply-To: <CAH0uvohxfk0wYv8NB5i7dZJ2+0PX22iqVAJqWLGqKykrqC-RgQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 21:45:00 -0800
X-Gm-Features: AQ5f1JrC7rYKfwyjlISX7_myPvKvTqHLZNMUocCpugV2ryp_Qy5FbTi0KdWsdok
Message-ID: <CAP-5=fW_j_jisBsMw8AU0t3NgQdfE-ZBgqHN5y4ezA+bvRWW2g@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] perf debug: Avoid stack overflow in recursive
 error message
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:40=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hi Ian,
>
> On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > In debug_file, pr_warning_once is called on error. As that function
> > calls debug_file the function will yield a stack overflow. Switch the
> > location of the call so the recursion is avoided.
>
> May I ask how it created the recursion? Too ignorant to understand sorry.=
..

If _debug_file is NULL then debug_file calls pr_warning_once which
calls debug_file which calls pr_warning_once again, etc ... :-)

Thanks,
Ian

> Thanks,
> Howard
