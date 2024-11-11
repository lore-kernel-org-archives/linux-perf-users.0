Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585215699D
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354703; cv=none; b=tw9G2YG+LaIQOkz2H08TeN06zmcQA/IO40pHv86z9IAWaIoO1WNx8dfl2YYqU0FkM5Jvi87WLMBGyLaD09UJ5541tqHPDYtElsJHqZ+f7wWKCKJR0gPIx3gqKGptcEDhhjtxSMwxFmEUY8fSPN8QAhAauYIN+c2cKyLTWJB6gP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354703; c=relaxed/simple;
	bh=NosWJWuJege1oIf3Hq+OA9EmGZc5b/KkZp88K3w6Yi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpWmC7pooeS1QlLUZlkbnoMrD8ICG6dLdW4ZFUYA7H+ZTFQL4w9Sb85BlHA8HVGT65m/ipitzwAw9j57gT3YvYuGp69ksvZEj0EPa4j9ebC/GdvHE8YlunVjLPaAJKJV/LItf9yCgc+uY68f8v5nyrBamWqV8bu2w0tz5tlDKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VSBLxfFf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VSBLxfFf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ca03687fdso35755ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 11:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731354702; x=1731959502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/bwn9D84GWlDbOilb4ydUF+TXLSh+hSxOJ023fSrD0=;
        b=VSBLxfFfHUiKCE10h3BiQinhRkyjmgVBXWyS1Ybck5rze8hHChxt+58DerDGFGBQxg
         PvgecklWWreh3GQ3YZuHiIiPtogMwesmwkvBPVlUgIk/N7CC4Huo+Xp76cABjPqY4gyj
         /63bgYV6qlyQOA6jViGGA2qIf1fJzZXtzCa5T4m6MzYUSnjH09Ipn1Dc/DCLoXpXblEm
         /36gb1RKNTokCtOrt03/427hVqicBrhlXVcLn1qxWHSnCBqRyqqgXtGeAhGunc2XXGDs
         ri0uFtajDGyRJ+Ql8H6Ehjd2DkLKoK+H4f+1IGIg17xKGXuCwOLIEYtr1GokCG8+BvOu
         WhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354702; x=1731959502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/bwn9D84GWlDbOilb4ydUF+TXLSh+hSxOJ023fSrD0=;
        b=u2Ww17TsP/ffV7CYGWNb1jSbNJrHHOdaRX1fqfF42fTCHL3aYrZl4MgGrl4bj0WozD
         aRpIWAO0qmRZDmxr5d2cCGU3igWuqcRdADvAbsU0wwnRy9whkVTtT3leI8MuEuA2r7av
         f1TuFbCoLkgDTLtsCHgE6giF+DA84amJPXsHfE1u/6t+SbIo1JstXwTYRbLOUFRvkYAk
         QuQtONxSM5Vp0Y9VV93TEuKwx395NXliH8oRuKqPg8QZStE9/2sDpwYxeFQ04dRwNfFW
         MP6D5leWk6kA/qAhEmzIxbkEBkdepzrAQwo6fkPXSni+jU6zaTNt5TkMpQKGNAQ29fqU
         wfqg==
X-Forwarded-Encrypted: i=1; AJvYcCXB+1j0HTIIeMzdggqaoaDLwMby9rcsuikttQcefhmSwtGoJTi2I9mltH84tfTvHSfaXySpz5+hU97tvg5WPPgl@vger.kernel.org
X-Gm-Message-State: AOJu0YznLtmLVkFovUA0RYV55Ok6ll7gYV65ZW8UJEXjuc9m7nvxZYP8
	1LKIgQF40PNBNMhp4PLK6a5zctj0UoxSXEi0ixHwgwcCD52zh8Tm9ukrX0LeNzcFna/7tCG50gd
	VDzOG94Gjb3G8kcowTxPf2OLyteGrC37nTSY9
X-Gm-Gg: ASbGncuOf09Qjx5yMsygs4b1ULf1nEdlX6Lx9hKF9V8DviNGd3mxrMuFI6J6oRNqXp7
	7SvI2GS2fr4ba5Rzhl9oLf/YkAZtF/DNtSZurhCrgay1NnbMZODy5yhVZzuVGbx8=
X-Google-Smtp-Source: AGHT+IEyEcKoDFotDlCx11HNGo0yvP2mygnysMtivuiJPEeFIz3afC0FbuSNQvodM6soNzZ2AhNjz5GUVsalr96G/Pw=
X-Received: by 2002:a17:902:ec88:b0:20c:bb35:dafe with SMTP id
 d9443c01a7336-211ab001120mr440715ad.0.1731354701726; Mon, 11 Nov 2024
 11:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <20241106235110.5NbhrBJjBk6qY_Sg0BJUbMXfpfpi8KZK5R-y4rZfKXI@z>
 <Zy0MPdvV5ofHtyE3@google.com> <b28d4e57-a152-4aa8-8c91-69ce0198dfa2@os.amperecomputing.com>
In-Reply-To: <b28d4e57-a152-4aa8-8c91-69ce0198dfa2@os.amperecomputing.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 11:51:30 -0800
Message-ID: <CAP-5=fVKZt0o41J3C7BHW4gNTiuet3pJEndzEZ6MxdQxorXXqA@mail.gmail.com>
Subject: Re: [PATCH V10 RESEND 1/2] perf util scripting-engines cs-etm: Add
 map_pgoff to python dictionary
To: scclevenger@os.amperecomputing.com
Cc: Namhyung Kim <namhyung@kernel.org>, leo.yan@arm.com, james.clark@linaro.org, 
	mike.leach@linaro.org, suzuki.poulose@arm.com, ilkka@os.amperecomputing.com, 
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 9:58=E2=80=AFAM Steve Clevenger
<scclevenger@os.amperecomputing.com> wrote:
> On 11/7/2024 10:51 AM, Namhyung Kim wrote:
> > Please use map__pgoff(al->map) instead.  Otherwise you'll get this in
> > the debug build:
> >
> >   util/scripting-engines/trace-event-python.c: In function 'set_sym_in_=
dict':
> >   util/scripting-engines/trace-event-python.c:814:60: error: 'struct ma=
p' has no member named 'pgoff'
> >     814 |                         PyLong_FromUnsignedLongLong(al->map->=
pgoff));
> >         |                                                            ^~
> >
> > Thanks,
> > Namhyung
> >
>
> Hi Namhyung,
>
> I do not see this compile error, and I typically build perf with debug.
> This make command works through 6.11.0-rc6:
>
> $ make -C tools/perf DEBUG=3D1 VF=3D1 CORESIGHT=3D1 PYTHON=3Dpython3
> CONFIG_LIBPYTHON=3Dy CSLIBS=3D/usr/lib CSINCLUDES=3D/usr/include install
>
> I can substitute in the map__pgoff() macro in any case.

The map_pgoff was added for reference count checking which changes
struct layout when enabled. More context here:
https://perfwiki.github.io/main/reference-count-checking/

Thanks,
Ian
