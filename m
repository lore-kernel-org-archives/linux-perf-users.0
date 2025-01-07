Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B01D958E
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282299; cv=none; b=J/Du2Na7n4eo6hkD5FyjXT2tGLtIMzgAWxvThebU24TqEx1fXMO7WrFamajgHB7N6OmAFMoCFrNd4T51KocY1UzpxOPAnmTPXochIdG6iLMU3J1RlRGySUnOtVbYJiIRFjE/N6X8hVp3VGkUKclw3Xf3cVueG289FC1htdLwk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282299; c=relaxed/simple;
	bh=CVIVvlQk68H9dVsq0u52vG23Qvel9MGuz2OToYPb5WM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I13zzi52c0G5S4XhViAXUht07Ey4HVQligStRVKa4qyD5SZA+3P/AwJlJAHJb0nB2VWcnxrvwtwnw2gymUg7IfwsVFFMhEn32Pey91IyXHxGZGuB3wmmsQnIrooK98Iiu+1xWwV6PmhTYVUn5kzPpDEwDh/W1IJyhihYc6f+BrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zhr2UA7m; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zhr2UA7m"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso1285ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 12:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736282297; x=1736887097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kYbQn42qX2gEVM48wheo93zojQdWC9WZHHQ8mnvxzQ=;
        b=Zhr2UA7mQyJiGToDEj0u18UWSLl+RYFPMk1+VchphNFX+yY6dC08B3cZT7En+Qhlkh
         ECU7mu9JtWeeKktbui6lz1eNlz2vYjGRgS7jQWgUsJZ6qO9nbQl78Gh636vcI4SB9Oqn
         zMJuJXpnm+8rH/5XYIYlRT0mO6p7C9Qm7f24upMVsfYvrwxMGSc8U75qMR1vs10e6a4w
         w4ZDDDWzdtnxMP0pzh93fp9/K1CXZxXJL300cUJdtwZEGD71uAJYhzmBdPksRrAIoIhK
         1JJc1wn2hHgba/Yh8JnmvXcYW4PqZeXM/68u0rR7LQAfsGAaqg5C17UbcE2YPVoWtl/P
         TsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736282297; x=1736887097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kYbQn42qX2gEVM48wheo93zojQdWC9WZHHQ8mnvxzQ=;
        b=annCyKf1Q7ePloAno6tueUn2p1u89LgJhXne7NoLN3T7+Gvw9E01rf5dHCloV7Vi/h
         UFq4vvofdj3EDm2S3Cz4qnTxz/1XTOEV1K8KSO9BgYgLNlGKmEA8dYhcyE4TuVDdAucT
         N39NoEASkYC7oq9oBFo4w1Ygv4sGsESSfAiR/FjMWwGhK1UyYg3953/h3lNrRGnInWYT
         f0qJDXVoqJszPl8vcnce5BbTr4LWa0Nken91HFTpOmc8XflKyfx/gTPZVw2BAy/VKDra
         Qb6k3Fg9S/+RvcSZzh7jR9VmICxSr0W9WyONThwYk8KOWNzPjjyjIyG2OQUKvir+LqLv
         PV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7/vv8ys+iw55xvv8lrUAHT1L07tXh8G2/YcoOfilCyxTZIMZjvzZEKe5DfjdVYP/ufOhH+veq0HbAC0+a2qvO@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8FT1yrxBN3IRUC2JiotzU9gWV0lquoKXWF45v9WEmCaJwaGh
	iYSiJux2Tmq1s9Bff9V08yKvfthf9YyTN0H4H6PHSaneltbhImKXdRg0dOXyb/SZXk38ISGK7N4
	eXMqasHRWDY793B1w+cuyo4WZMbnJRD3T3Ddj
X-Gm-Gg: ASbGncspXX+9BXQGWA5tNzWV2QEyInngiuCysJLkfCmpuuW1IvP5YA5G2GU+Zx5NWaY
	sxLRTpDGBwi4ZIK6pOHT1UA1147RsdOIvE4EGU+0MryVKLmW7WFTXavfnWiurYlT8T23TQA==
X-Google-Smtp-Source: AGHT+IGJ+dOTWOGNAx5ptzD0A66qLunGPYpichZ1GnVCojvpZ/ozA+J7H4SVtqMyOx+Xe6BbJPmZ2qvRlkpbzmhx32U=
X-Received: by 2002:a05:6e02:1a66:b0:3a7:dcc1:9936 with SMTP id
 e9e14a558f8ab-3ce3b1de621mr412135ab.23.1736282296490; Tue, 07 Jan 2025
 12:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209222800.296000-1-irogers@google.com> <CAP-5=fWr9R74-NbKbW96otG6KitQYaQng4D40Bv4z9ov9yvNJA@mail.gmail.com>
 <Z1iQhL4WXFL4Wf27@x1> <2ae362c8-b8f4-453e-9c92-a25ad989ffe4@linux.intel.com>
 <CAP-5=fUTXzZfRqre0Vai_5pxue_mAvb9oh-Ea9Sgr7U=Lrm_Nw@mail.gmail.com> <Z32G7cNV3hZ2bZHT@x1>
In-Reply-To: <Z32G7cNV3hZ2bZHT@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 12:38:05 -0800
X-Gm-Features: AbW1kvZuwQ07QciJ6YF5PK-pfpStPZJ3kb7rknWrLYIiMAXIuTclwqSPpl0Aj7E
Message-ID: <CAP-5=fUOyqyQuE3vQY6wd_XYm9nXgRmsXLJ3-ocMxD08+739VQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] Intel vendor events and TMA 5.01 metrics
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Caleb Biggers <caleb.biggers@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 11:56=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Jan 06, 2025 at 09:16:56AM -0800, Ian Rogers wrote:
> > On Wed, Dec 11, 2024 at 8:24=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> > > On 2024-12-10 2:03 p.m., Arnaldo Carvalho de Melo wrote:
> > > >> I should have also said, this series requires:
> > > >> https://lore.kernel.org/all/20241113165558.628856-1-irogers@google=
.com/
>
> Checking that this is in...
>
> > > > Applying that one now to perf-tools-next,
>
> > > > Kan, can I have your Acked-by or Reviewed-by?
>
> > > Sure.
>
> > > Acked-by: Kan Liang <kan.liang@linux.intel.com>
>
> > Happy new year and thanks Kan! Arnaldo, Namhyung please let me know if
> > there is anything more necessary for this series. I don't believe it
> > needs a rebase.
>
> So, the Co-authored-by: tag was used and it is not documented in
> Documentation/process/submitting-patches.rst, I think the right tag her
> is "Co-developed-by:", and there are some rules about its usage, from
> that doc:
>
> ---------------------------------- 8< ------------------------------
>
> Co-developed-by: states that the patch was co-created by multiple develop=
ers;
> it is used to give attribution to co-authors (in addition to the author
> attributed by the From: tag) when several people work on a single patch. =
 Since
> Co-developed-by: denotes authorship, every Co-developed-by: must be immed=
iately
> followed by a Signed-off-by: of the associated co-author.  Standard sign-=
off
> procedure applies, i.e. the ordering of Signed-off-by: tags should reflec=
t the
> chronological history of the patch insofar as possible, regardless of whe=
ther
> the author is attributed via From: or Co-developed-by:.  Notably, the las=
t
> Signed-off-by: must always be that of the developer submitting the patch.
>
> ---------------------------------- 8< ------------------------------
>
> I'm taking the liberty to make these changes locally, please Ack these
> changes by replying to this message, ok?

Thanks Arnaldo, this makes sense to me. Caleb is adding Signed-off-by
tags from you okay?

Ian
