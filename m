Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F71422A2
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Sep 2024 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392093; cv=none; b=I2Mt4tN22yAmjX25nm5iNVKgQyaOFCd8FegJRQBV0xMV+CBDHTkAzHIb9CpGZ1LWTWQLuL10+J8Qq5lCCt0/ovll/M9cEH3RBwyvqpcIUva1XGzDNV6eo+lLL9Jg/q8HW/dkMWvhyl/Xh4qUzuoo+kW+cpx5UmUjc1hgYhAaF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392093; c=relaxed/simple;
	bh=UShskrRI1DRsJKg6TMK+JzmQnbWj40zzdhGhaCwR9Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLElFkzKo9gsjf2C8dpM2qyjftPYs1M2ZtXgf+OzZRd/4MEEYrlFFDTcvB0w9ULz97Ld35AEw5NXPUu+G7bInfBPjSU/WGW7qhaAHfhNzH5tIYboldYIxRjlEfhzWiW1hJ3aLmebWGc6RwoFgkk74namf0mDGlhJMPfoAJhk8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UkKoVMlC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UkKoVMlC"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so5435455a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725392090; x=1725996890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J2FmMLBB3NwjKynA6ICAmca4TgXkk89mwzwmgF2OaFs=;
        b=UkKoVMlC7LXDqi1al6vyDWCgDMsSNdbgLXAjonEINswJ090G89U4iuN5z7cCy6YhI2
         FOIMd/tBBsOlL6jNtKMj6nn+2snf5YKpjDMLwlP3613zVLIESPcO7CqIrtWZABxFDj+U
         AFUr40A71WhxEu/aVzacG7RE8Mc9KH++Rgp9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392090; x=1725996890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2FmMLBB3NwjKynA6ICAmca4TgXkk89mwzwmgF2OaFs=;
        b=viBUEd6GnwfmY1tHA0Vc6KN1DCGgEZI8AbFzrNNksJRwq6Dj70BSnZDp9INx3KWr0S
         RSn7w5FQ5Ls/iehSdblDRYUl8olRNVS1GHO+qxTZm+ZS3xlu7iUMmLThJfVfxZnQmWhe
         ljW4TBdENh2UAdsXkqJNrZMe1O8DvdVPXFxR5TAdHujMZYRv3ccIeo+Wr3zfk0IWPFoW
         3BFplMtXLqO2iQ1I9wisUmFFYKbyBMPA+mr2ipk+uDyo80lPurGBrtr0BxPXqU8DjjQ5
         o/9jnsIBxHInOzkgCv8hIWjelhML4hsvA1qtMm5VSFq+m7mbKBgY2qEjtu2KYP3wM3DX
         5gUA==
X-Forwarded-Encrypted: i=1; AJvYcCUkW1noRg5xwOnX+BUcmD6+aoTLhNlD2x9OWPOs9v/OyvEtkMZliVyaz+iyNaXC7zmsv0eENyWLwTItw6v9fJh9@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDNdPKPatPX0e3wmAipNI/lGPKR3p0Dzay9QzHfG5dv7ePUjc
	/blZLHHOpqGfA1nixiq3KxX778nnuQGahjbK5sQOj7z0J3FEjHPKiDcjcZcqG28A2w+Rn9D6jzb
	6kjd2zA==
X-Google-Smtp-Source: AGHT+IHyK8NmjjLVOzf3vJgDEN6t85Qxp5J4ndb5KCyWHEBV2ZU55IBLChXgcTznPRBgdcxtwn2Mpg==
X-Received: by 2002:a17:907:ea3:b0:a86:ad4e:c468 with SMTP id a640c23a62f3a-a897fad4ee1mr1482896966b.58.1725392089234;
        Tue, 03 Sep 2024 12:34:49 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989022a69sm716269866b.87.2024.09.03.12.34.47
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:34:48 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so5720083a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 12:34:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCkNVefuJqA7lLho66lVch3Nm8mqVluCNbiBl7ZO3O8tCONiapmO0KGGLWwr3ecDVJPjiLnT4WV0RWC6SxXQD6@vger.kernel.org
X-Received: by 2002:a05:6402:848:b0:5c0:b33d:5fcc with SMTP id
 4fb4d7f45d1cf-5c21ed52b2amr15503716a12.20.1725392087234; Tue, 03 Sep 2024
 12:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com> <20240903090843.GA17936@redhat.com>
 <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com> <yt9d7cbso7p8.fsf@linux.ibm.com>
In-Reply-To: <yt9d7cbso7p8.fsf@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Sep 2024 12:34:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0Y+1r+0K3uD9viMU3-7oxAQubGsGQLx_ruk81b-ZdAw@mail.gmail.com>
Message-ID: <CAHk-=wg0Y+1r+0K3uD9viMU3-7oxAQubGsGQLx_ruk81b-ZdAw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 12:31, Sven Schnelle <svens@linux.ibm.com> wrote:
>
> > Either use kzalloc(), or do a proper initializer something like this:
>
> I sent a patch which does this today:

Ack, looks good.

This should probably be backported independently of the new close()
series, since the mremap issue seems to be a longstanding issue.

                     Linus
