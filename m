Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AC28E583;
	Wed, 14 May 2025 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253408; cv=none; b=Ji5cwNKlFGJuOdybdqLND6gaugYhFyqyI0r68m4io8TP4gwVDhrhgIHZ7cNCuDrgbozavrC7mHuG2Qna2fm/qdDY/DSx/kt9oZY8/kvOcy4mdQffGuLajI8e61I1EDnAwpju0C6dX6u3YsyjkOghS3CqQZAQrEHP7uvGniow668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253408; c=relaxed/simple;
	bh=Vor2JmERlhiBjTMLvMnGJFx3PllRrl1yk8TtqIk3sY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNP9h8rfCnS43g4OPSfkyHK7i0rZ4r4+0f/aT36wh3GAjPWZ0T5rhWR7M7E2Na+otiAlyrmjTO3DI+WPLL3qwrp3jVPzxnIIYw2yFDCnw+VLbtiT+tr/WmKJXB6H+Y5Y27ZvBmQvuHxYRvQgRuTy3vu22AP2OuFm+QBGNkw2hxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG5OPFnH; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG5OPFnH"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7080dd5fe92so1743417b3.3;
        Wed, 14 May 2025 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747253406; x=1747858206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yC0JYTBLCAjFMJ5IHciqczec5NK+wwTHRVRJnm/CnUs=;
        b=PG5OPFnH2bjHc2zTZ3GDEZEdigNrTS5ZdzX/xhv/KVE6sj3CdfDKsaQgS/rUr7PgnX
         rTAO8Pk77I9iNtYlVId37DLo+hnjys1evksYmLQUJmzpk3SGiwzb6Glj9lhiFaHtZINr
         sXREWom/0IXBYoI/1v54lnxQEPMPfUq96FZ44+9p75Rjnw+3DGIv/FeCOvxG7aSjPogM
         DTcf7595ydyb78onE2iXwmY7PV7spdtKA9tyRElxD6iD4Q+Hul4wKLqNHFgGzbg9GlPu
         6RPBxn/S0wKDzojNGBmGE4KIVira0GMAECDYz2Ewi1cE3vfxewcvQjSKhdHTHBBMN0Ju
         bp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747253406; x=1747858206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yC0JYTBLCAjFMJ5IHciqczec5NK+wwTHRVRJnm/CnUs=;
        b=Q3k5auFvR0uavWfBZlxVkK54xMpjbfI7lzFQ6IjZW0GTZ+6PbJzp7GoLQv3dhQc9bM
         5X3txWkrnZgvVQA56u/9MMioIZDX5obbnw72nd+sk5jiNVuCnnG1n4bY1F37XR2RjFfS
         86f5NWrUu/q+BBDexUsaxgKgMYaP6hZfWUaokVMFL3H8RRRv1WFpZRRpAueAFgmvl7Eb
         uPx6EmpVCXkbx2p5vBEOJTVauNb7Cmofn6wwyCzUqpOo6FuNGWN6dcPSxztTrnM/rCSR
         DFZ/P9zEaJ+SajvoC/JgEjDl98fQLCsForR+BpzsPbagA8MwMV6482nBLNfPFI/VACxg
         4w7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxaufyDJwA8Y1Rc4AE0RRwiZAJ14nDsSZQoeyIWebRVqP6BuCbQw9UhEFXo08ra0Um9IxB95VHPbsISv5WKGH+ww==@vger.kernel.org, AJvYcCVys2O1h8OFdEuk2cNhIx6GRLjdVlzSRIak8tgE5D/++Mn75s61RQKx+ZyfKXf8uxeqH6R6mSIpWUFA/dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2ACr2ZoVuq3McsdT5AsVkoZzE4nr1A6AnGMeESktNWZvt165
	Jp6wcdVd2h6+wejCA+Htci7cH50BBk+PmdN/mvrWQi/W0K0/NMh+3yJ7NAJXwq/tTfgRk09cyy1
	PkfZEtXiwcYODgXpaGQTMf0gFeLydMQqnEXTSRw==
X-Gm-Gg: ASbGncszlj+cUrrEf4AAxevjyS904eBZnaValvVCE70xU+bkvGAkvXQhFou4V2L3/cd
	BXXT5jDRhHh8YgfSCKa15bsCJ9GeAv4GIImTuWKXgpBxE4erYtXHkEKt3EMwdImCVR4/Cr+e03V
	xtN8DbzSIrBIgD1dhQyuFGj2GyMDI52hU=
X-Google-Smtp-Source: AGHT+IG21FJyi+kfSLXEbQ9XYQljr3Q2+lTXlm9xHhZAiZrLk1xHBcTQUEthvNVzwmylHK8H6BQ4/5ZXRUgM4wijX4k=
X-Received: by 2002:a05:690c:640c:b0:709:164a:fec with SMTP id
 00721157ae682-70c7f1437c2mr71180407b3.17.1747253405693; Wed, 14 May 2025
 13:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502204056.973977-1-namhyung@kernel.org>
In-Reply-To: <20250502204056.973977-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 14 May 2025 13:09:55 -0700
X-Gm-Features: AX0GCFvvwFy1hO7UqGryskqTZR4hWpkamqCCUqEGvSy7CE3r7BC_54bHt4evydo
Message-ID: <CAH0uvoi552j-5a-rqR7CbiycUiuz1Rres76hK=1rqiDS-9qbOg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Show zero value in STRARRAY
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Fri, May 2, 2025 at 1:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The STRARRAY macro is to print values in a pre-defined array.  But
> sometimes it hides the value because it's 0.  The value of 0 can have a
> meaning in this case so set 'show_zero' field.
>
> For example, it can show CREATE_MAP cmd in the bpf syscall.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
