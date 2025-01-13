Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2A20AF74;
	Mon, 13 Jan 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785631; cv=none; b=P0xuhQv+MMy3rRFdigLPN9p1hJrr5lk4zZE3lSaMadqhKUPyXYH1AgGd0P2s9F2bvgLFq6u6VsI8gYcSdkjQDqxAz3gINKZScjgX2mdTJQl1fFU6yX9G46Au6SaybRRJOdJOXLDHxJX8cPTChyWh9T/PRJlDZD0r2vYW9EYHF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785631; c=relaxed/simple;
	bh=+14yFuYK/mSJitNM8vxDpe1OQ5GwdzmZzGvkg+n7lIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1BeQSP5Qu4GbbsLGE6O3iNnLfQ873lQXyYguclKyavapCacJw9tPdSwQ3+3ZNZc8uQwrvUP06xZ/uMvHOhC2SWoFqYD5Vsb+/NEt8VZ4H98FvwGmqKhaODPF6riJkwzsB/N3M0XkTA3/8xT6ZTsnZpUcSa3k2gmPvIZ+JUVIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a37a2a53so54649111cf.2;
        Mon, 13 Jan 2025 08:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736785628; x=1737390428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEzYVItTrJXiGPIOh2cYL7kRqnTbUubRgdjTGFJendQ=;
        b=YQgy9WeN2Foq2Wjtilr22ojIcYrHq/zS3bYXN01DkI2zJJnVuqWJWY0YTrw9TWAdS/
         4MGvamYbrqYoDqmSggKVkSR131rQOJ33FpC9YaKcSuswVNzGziUPhgDIWIQsk6VV9LmM
         zSWMPbkqmp5LZ1+7xOv1GaZPostnosYJgUOARQDO9InTw+Lekbq8UOHE4eCLlpX+cfTN
         RA2XBHrRH8Y0Y5LOE9fncb8fVxKXNxbeK39rfkyOYJfHMF7Q1KArVCt2/epotd7o2g76
         IGezsvVKVnjV8S1b1AgpIuoDKwTCwmpQP/A9tFJYFyC9DqJTqo/gpCLb4ObB7rzHJj7P
         JfcA==
X-Forwarded-Encrypted: i=1; AJvYcCX0CIO0PmusxnCB3co8zHbykirSVjWue/m0mLrB7EojFxP5E8zwfPvWpicr7wF2YVO7aOCOQZMu3fNvvGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZpc+kiBs3VlZwvZaLhIBWMwTFlYMlcWW0xlX6odBCjlae03y
	oWAgZ5llY/rIVNIXzMuOpIK6M2ru0NZl6VjSj7auTUHnkfh2PPgVunoRairzbXI=
X-Gm-Gg: ASbGncsoj6HWbI/O1R501p5sBi6yaP5qBq1LM32wWBfyMJJV2uBWUQjPOHLUBs/4E2b
	H5VY4M0d3sStFFha2vT5RqRv2JE5YQgeXhxy8Hie38QBSKBy5zbQYCEQ/QSD0Kl0JHFvkLpo277
	XnEg19bOmRxQ1zz+5I83qaSuajsmL3txJpoaw8CPlij2d6kgMjjyMVJgEm0Z5wjKT2/tXWEXq/6
	weqMOQMZAjLj50yNCeBxsA8zKOMV/LI0f21NhTwYtyt+9sEaA61VebRF18/jhsIadzdi0wrH410
	tViJG65UoJnNr1bWrgGo9+mACw==
X-Google-Smtp-Source: AGHT+IGGGl1gZr33TGau/nUA27wD+dPTEeoaQpEOwDq4IIJL3xXoSliW8cQYvwtQrH+5gR/T8MV7TA==
X-Received: by 2002:a05:622a:250a:b0:46c:7276:7997 with SMTP id d75a77b69052e-46c72767a71mr413445581cf.13.1736785627729;
        Mon, 13 Jan 2025 08:27:07 -0800 (PST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873454c1sm42466961cf.38.2025.01.13.08.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 08:27:07 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso38194686d6.3;
        Mon, 13 Jan 2025 08:27:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdUZ03z/aBN5SDOtHHfqpnxDW0YQVwkQ4TCxYXuCCkTgWvf6iD9Fj3B+aezexq4vdB0zUTj12GuEkkhsI=@vger.kernel.org
X-Received: by 2002:a05:6214:260b:b0:6d8:8874:2131 with SMTP id
 6a1803df08f44-6df9b1eab44mr290915456d6.13.1736785626734; Mon, 13 Jan 2025
 08:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com>
 <c29a4cdc-9419-4f1e-92bc-a75c3b10e37d@intel.com>
In-Reply-To: <c29a4cdc-9419-4f1e-92bc-a75c3b10e37d@intel.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Mon, 13 Jan 2025 11:26:56 -0500
X-Gmail-Original-Message-ID: <CABg4E-nOWV-xyrXHy0i9Yf1iEaM4cH6esLnbVHRXnK-85TMUtw@mail.gmail.com>
X-Gm-Features: AbW1kvZzacMoNoQDEpmudbEvN0Sbjz5mIvEvzGbK8b-jISoszbzHiY9oySTI7IA
Message-ID: <CABg4E-nOWV-xyrXHy0i9Yf1iEaM4cH6esLnbVHRXnK-85TMUtw@mail.gmail.com>
Subject: Re: [PATCH] perf intel-pt: don't zero the whole perf_sample
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Andrew Kreimer <algonell@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 3:15=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
> On 11/01/25 19:56, Tavian Barnes wrote:
> > C designated initializers like
> >
> >     struct perf_sample sample =3D { .ip =3D 0, };
> >
> > set every unmentioned field of the struct to zero.  But since
> > sizeof(struct perf_sample) =3D=3D 1384, this takes a long time.
> >
> > struct perf_sample does not need to be fully initialized, and even
>
> Yes it does need to be fully initialized.  Leaving members
> uninitialized in the hope that they never get used adds to
> code complexity e.g. how do you know they never are used,
> or future members never will be used.

Right, please ignore this patch then.  I thought I had seen other
cases where perf_sample was not fully initialized but I wasn't reading
the code carefully enough.  Sorry for the noise!
