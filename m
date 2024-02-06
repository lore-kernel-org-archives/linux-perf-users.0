Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79161CD1B
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Feb 2024 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262574; cv=none; b=sO/zzIeD5lxzwiIWAVfSm2lVjrec1fqbYz3325rtJZxqWw/gwl9EMSr2X0+B0ug0I5Cr2GebwDNNjeNm57uJxwVgVjnewrT6r5GwiijFpeH086+cj24EbE7+879AI+L8yz/pvvw62pDGHQNswP9GdMj/bD3opCv4ps38WmveymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262574; c=relaxed/simple;
	bh=bT8iSDQ7VIIkJ0SalPInfLv65CJM5qhL0227zSPb0uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTcB4qUJyAnsAQvy8N+OhvdGycGMzw8pZGw8QR3p9bZPlv7mnW5wPT2tml0oCoLmq7zydjSId37olNKN1NwgE6vXeTQlysto7DXk8BSvildDVCkosgpM9nE4TQNXGl+TWUTJKkCzxl/lVWqDCTVCgKCBF0iu1+F+OyPSCPzeMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xY2jbs2a; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xY2jbs2a"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d9daf74f41so19805ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Feb 2024 15:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707262572; x=1707867372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xi1hqRLQYsZ7IksfZ2m5n0Ha2D4yNJBsDeETYfat3Y=;
        b=xY2jbs2awvqTI+zdITKVPR3nf/vmnNUtySSS9btOdLoqnNKM3d1fQBVDcAnNDRKhnz
         r5549pmIACd2nT8vimA1KTLW6iPC2FDGz8QCE744rVCDDc4EbhZfnjipjOp4AMF67IoQ
         ymgMUpcsp17e4rj+qYPE6ZHI26EnG3Ld1xceSPiFoxISkSSaTygRlcVClV0cliTHvmOk
         1u/dkrRTGow/kq5s0WJsJ3wwsf9hYwIWHgs9/NKWBaR0ck+dYNoHtUiyQ+Hjf0dNoAXm
         GVvKPMAhh/jM8YxrsXD948YWP+Fpkd7ONKoopq94+GyW75VwoO7RiVdiN8+9Rd7vLWXF
         6oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262572; x=1707867372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xi1hqRLQYsZ7IksfZ2m5n0Ha2D4yNJBsDeETYfat3Y=;
        b=AlYqTj0OC+yjnxC1gpKwwKNqQW2OZ8jotqhU3vZTMHylZwDXIH3JIFAn0OmxcCeFBz
         00NVYHhE1KaVkQm8zBATad7MP5AzMEDDEI6f95neVPJd9jW04EgwVZOhT/5gvyDCt/fw
         xKSQ429W7xBK8kyXVasHgZLIVi5F9S1qAKsDEFMlEfVLHbDCLTLbPpiJKYArhfEQzdSt
         uz9ynGreG9lh7mCtlKWY+bH3ZQ2/CSaF/wAhxuM/kec3mnziGTXGhHoBsgfsTuj25UNJ
         IjhXXX75YToWKAKmMpiTd46a5Qqp1csLFK6HoHSEgxO18YwADZr5bL4PzBBqQqC22JTP
         tA3A==
X-Gm-Message-State: AOJu0YwZ/q5LtPpoL8wUkqwR8gWXmODTqhhSzdtR8Y2f5+2BQRrEkM16
	js4ruqe5BCaDJtbTkeHUD7UaNfNLvmf7TyYf3VQ1uSwX/efsRutMEX0Ue2Sai/mQzTY72mNHnra
	+ZyYvq6fNF3mmFgBw2286PBWJhUFuMGo2P6Mv
X-Google-Smtp-Source: AGHT+IHUaiRg0gv0A4PhdoXFVOz9ohKuZkpJ/MI21N+l3SsCRsghs2NzEr8ElhMb20dBHkuxfNLL5As+po3JgE65Kfg=
X-Received: by 2002:a17:902:db06:b0:1d8:d225:699d with SMTP id
 m6-20020a170902db0600b001d8d225699dmr1428plx.16.1707262571902; Tue, 06 Feb
 2024 15:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-10-namhyung@kernel.org>
 <CAP-5=fWhHb8iomEQ_rhwC50kGhPEVbDZv6X6riY_3pr787bhAQ@mail.gmail.com> <CAM9d7cg4Apu0OhDrn2uPzRnzV24-vK=L-yR04=2eGR=n_YngTA@mail.gmail.com>
In-Reply-To: <CAM9d7cg4Apu0OhDrn2uPzRnzV24-vK=L-yR04=2eGR=n_YngTA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 Feb 2024 15:36:00 -0800
Message-ID: <CAP-5=fVPfSBGi1DrNkv3Moug_HyPZdEyab6X6sDyg=1-F2NAWw@mail.gmail.com>
Subject: Re: [PATCH 09/14] perf annotate-data: Handle call instructions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Feb 2, 2024 at 7:09=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > When updating instruction states, the call instruction should play a
> > > role since it can change the register states.  For simplicity, mark s=
ome
> > > registers as scratch registers (should be arch-dependent), and
> > > invalidate them all after a function call.
> >
> > nit: Volatile or caller-save would be a more conventional name than scr=
atch.
>
> 'volatile' is a keyword and 'caller_saved' seems somewhat verbose.
> Maybe 'temporary'?

Sgtm, perhaps temp for brevity and the documentation to call them caller sa=
ve?

Thanks,
Ian

> Thanks,
> Namhyung
