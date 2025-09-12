Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEF28507C
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659354; cv=none; b=Oyz7Ty5C1yVcg7TS0qVBSTl2dSk4wkjvAroo/kKhfeZBMT7O3OFtfx5Ce9L3hJGE8LPVsxRMkWQxFbbXIFYzH6rLljaToyp2j1XEuzPPIGuXBNT5kXHa7svB0onUipm49NpwIL1ucXjD3y2nijRobkEJCTbUbOso2yuOYZX/LiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659354; c=relaxed/simple;
	bh=NiDw3YhiRCuiqX3s8Sx2YRwxOWOYND2WGqxePm5DDYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZrIShStbq0jXD9Ip83ZchyrdVgJeIEHs2CMHejrKCBvrjO1V85yBZlBpiq0c6EHfv1fOaex304Rh4aughBm5enrDG9vOfzgngpy19KoShiXtdoWakacOd8XWUme4GTP9vTOCwUJ8P4vcGrGw3/2V3utJ6z1b7TjbW4LwjTBv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=py/X9XdG; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="py/X9XdG"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7211b09f639so16925806d6.3
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757659352; x=1758264152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiDw3YhiRCuiqX3s8Sx2YRwxOWOYND2WGqxePm5DDYE=;
        b=py/X9XdG3CpLIJmbtrlx9qUjems+Qc7ksjzpDBoJfTUDlQ/q86HjPVcrNWB3emvnN/
         0gIDzaY6CqJeP5rUF/0Le1MwTEkQB49kz0AQKyRJajNNZ71mgWnsaEZDmUqnk9h0UAcq
         z1XK76Nmm5BggXIN0SIbEzNmUKC/iUaESM8PN02RKhYtVf7FlISRVwdh16vu6XsbS+g1
         0AgWwwJlWjud7XM1n0eG9xSi8PzwAooUrIRDsAVSBZJbc42wiSywO9CCeWhd6nwXcq8i
         QPXGs/fvTk6qRpHKWjpkHUmY6yqKRa16bB+Sqfri8JMGPjN72iouigBdKBZA3tO4vqIq
         6mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659352; x=1758264152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiDw3YhiRCuiqX3s8Sx2YRwxOWOYND2WGqxePm5DDYE=;
        b=ru+vnjk8xExM+iToW2rW5oTSWkdjZZYuqh8Dfac40P47HGGeSvHR15KC8F0qMeMOUn
         Ia6INd7mLBi/1GmGI9TtKaAsisnaFmlwcUz/tadfiGnyF8Ukokn+2Utw4ClPuw5XbHxV
         S8o7jRaXBGjALxh28H2xh6wXK6+uxwkmfeiRTcz3nrdnj5A1vwR8vNx9d3glfSfwmsFG
         Jnmy7p7KdvPORmU2lmVioi5wmUNrCNFqn72zg4eZumKljEwfywwqOdF4TJ7rwxHO9sl/
         Rrm3ADDDdrG+oYpal2lYaapTmqIRy9JvmEARJmq3lGvhifDsx/BgzCTMm+UtXOWOKw2M
         xMTA==
X-Forwarded-Encrypted: i=1; AJvYcCUjjwLvCKW3Bfp56trXg5YSsBe5ZLXG56aGA+njz3xnkFDVZKwpltEM1vZe4bBP1s5+GOb95BtaZ+FGQueSfljI@vger.kernel.org
X-Gm-Message-State: AOJu0YznM/jYzy/IXxOTDhSB2D98/+o/ChsBcWhaTWPjZ9D+nGYVQq7t
	F4/6082xMLhoORthpet3sLLYtZ4ZnnL1/tIb65+z2klZE7rRmqva3gefkjHyZ/9ZriTIMfHrZXZ
	6JZyyVWaES6Ogsl5zAKRHs0bUFrKB09DyiZaoXxtu
X-Gm-Gg: ASbGncv2IWfjO/b9bOlaNYmSI8IH8V8Hlchd8HhPH35RybPSTTN/TOgkTzUpPyvFowO
	udxeyGO1LZdahdbyhdEOBrUwL93KfZEH9Zg5M5Uom6MDayBr4t7iaXY4Lo2NvqYYBmrLRLjbF3I
	vNzshof0uowXdmWhjPHVFtRWwNDRqTPBcYCenQEzynCNjOI+z/oESlgOmprOvEWaIQewiIrMlL4
	PW1b7Vng8b9L8ZuNKrbTfbsNUkiE2mecxTGaDBIlmsaEaDHxMXd/UvRNaoAcao06w==
X-Google-Smtp-Source: AGHT+IEySOSJPa6hD6RP73UcA+EVycB47r1tHjCeHNXYQHml1cj7aZJMRHV/AJ60ELcB5pCg7c1N2toT6ZWS7YO29Ps=
X-Received: by 2002:a05:6214:410d:b0:742:1ea2:b5fa with SMTP id
 6a1803df08f44-767beaa719cmr24286056d6.27.1757659351417; Thu, 11 Sep 2025
 23:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910052335.1151048-1-wangjinchao600@gmail.com> <aMO07xMDpDdDc1zm@mdev>
In-Reply-To: <aMO07xMDpDdDc1zm@mdev>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 12 Sep 2025 08:41:54 +0200
X-Gm-Features: AS18NWC5FlcfxTDi4nqpRg0jzSdo_HN5yk0SuuDRYsNBfDIot3LDMm7TkcnabIg
Message-ID: <CAG_fn=V5LUhQQeCo9cNBKX1ys3OivB49TuSeWoPN-MPT=YTG6g@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] mm/ksw: Introduce real-time Kernel Stack Watch
 debugging tool
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	"Naveen N . Rao" <naveen@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, 
	"David S. Miller" <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:51=E2=80=AFAM Jinchao Wang <wangjinchao600@gmail.=
com> wrote:
>
> FYI: The current patchset contains lockdep issues due to the kprobe handl=
er
> running in NMI context. Please do not spend time reviewing this version.
> Thanks.
> --
> Jinchao

Hi Jinchao,

In the next version, could you please elaborate more on the user
workflow of this tool?
It occurs to me that in order to detect the corruption the user has to
know precisely in which function the corruption is happening, which is
usually the hardest part.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
