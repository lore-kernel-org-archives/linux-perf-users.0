Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148602FD7DE
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130032; cv=none; b=q5KCbrYEOwLIndH1/yXf0cR8lZ/O/K5bAuK9RWkllTKzvr9DMrpMGoJ0LXf0mc69Z74ec5h2gjeuJXZ8fYttAMmw/XWdcHU9HgPZSB1RGyUkwTf1EXNbD8juO8IlnEfV3YVb2dRW6Bd8vsljGumZv/VXaIcLyOJ2dzFi9DB/AmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130032; c=relaxed/simple;
	bh=S37OsdqUcN/1D9qcDSXyTKya8uM8qxEd8mF6qCfkiR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtUc9OLrVitmE6OLERjC23lO1Pes+XT04+/PyoUKXTglwjkdVij762E0L5syCoHNLsQffESNVaMAu4EXEwYSxTEh7h3PQ2+eF+dmPtSuvZJqj3l3AirpGOqsgZUobYE1Ki31DQaN5KPQT2n6VmUdi10ndvrR8Lll7srtc0Mewoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0VtpIJG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0VtpIJG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-265abad93bfso13385ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758130030; x=1758734830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S37OsdqUcN/1D9qcDSXyTKya8uM8qxEd8mF6qCfkiR8=;
        b=q0VtpIJGfJh/qP71nH2P6QmHh6rMvGc0Z2KPBa9AcpxFosuUpJVTx+vfTOAOIzYw6C
         i3mVkgGoUZVPfd/BXYDlC2qoklZUfR7KKZKki3wReghqzoesqFecS2Im41PuFPfFMOEM
         xvdP6/wA5uVeVhekieTc4693FWp7LV3d78PEUYXMXYYb9Mw4nW84PKCznrVM3sifr81T
         8NBt4XXR+a61UqiEaTUj+GTjGrYldDvKqt5yT6BXI8Ys5dv4CF0qaD5tYiaGQrL44d9f
         bDdqaOBojWbH3PO5r6tnMXHoOItY0896GPhqdZsW/dNJbTZZ7NzVI0qD0ePnQi/NgpBD
         ofqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758130030; x=1758734830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S37OsdqUcN/1D9qcDSXyTKya8uM8qxEd8mF6qCfkiR8=;
        b=G4ZUZGN7jnjxh6X0Zjl7p5W3VsVXdCAWhUt95gfAWdXfbN2cI47frpLMFlaWfyqXxA
         ZSML+GPL1H9S3SEl4WWNm2ZUVP1n4cQYjd6uxsm7L8D3gklpyPJzZjLIAX3YRbLzfpi3
         hPbQ2ZNqW5hZmBEBw1Czbsn5zgqVJNKn3aNIAaKizAMKw10bLJNh3gIoAXKhpOscrHCU
         8C3O6+/CNgL+0wyzQEvdH9uCAKFa70XsiAXAwe839LYr+AoZzW5wLU5vfJe8cOCh2XnV
         OC07qJLNvMsgRZiKD9BiW+bHNjWkNhP2iuWrrtj1JpWeNPF3DyUmyMu/pAjinRpdKLar
         OWQw==
X-Forwarded-Encrypted: i=1; AJvYcCUwgPRUNC6Kt0vOfLLip620Cz5ulN3Ab0eqXyX0g2UVwhUOxu09Z5EHgT+twlMcCF3LAm5APIWIuSi/WRSstY3P@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNKYQVv0Se94XFsJWLMtHe2Fp8NZw8tjrnpcFTAaF3BcTzj9Y
	9IhZMg3J7yx6pQfyZuCJJyY4JNYOBQmItTFzx5HxDftzsxa9Z53sTin/kR090R2A/e7v9DwgWU0
	Q1o/iwZlvmE+Ia/JyUWTT973IYTbsK5YqnjpR53xn
X-Gm-Gg: ASbGncu1fBEGboU1czPwR3/Yj1l9Yv21G0WTiZ4PBdzVuXJcnoQdgtxmyvDj8xMEVCn
	n7SOovn5vQYgIs4Kom9PP+fYKAl8Rt/GuCGKhRG7ZUHejA5GKEQ6aXIxsRUmZ1kJqPwrfoZg5c4
	MxkVqQVkJ/Tg56YiLGCJ/1FacBzAx27JUrhwoRmp+1eCc6rxKgy51gfW1gMpjvVQtpqDlYyNL36
	krzDwmd9/UtOml0LqmMfSmMOnVzBaPtCuroA/AHnPrsbYbO5prRRg==
X-Google-Smtp-Source: AGHT+IHeUBellzdLWHrCsZiiMG3D+JkHT50wdPiqT3xzj955Zk+a1pdM36lRO+ssSn+Qo3yJMHxzBoFxnbqDHwzT+q8=
X-Received: by 2002:a17:903:183:b0:267:d7f8:4054 with SMTP id
 d9443c01a7336-26800f68420mr6432425ad.16.1758130029986; Wed, 17 Sep 2025
 10:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728055937.58531-1-gautam@linux.ibm.com> <aMlmiHATn5WHUcSM@mac.in.ibm.com>
 <aMm5uvPsMfXEv8Oo@x1> <CAP-5=fW4JQYJ2NCRsRVePidCcZ9+JcQbfY=xQ00xZG-bSn96ew@mail.gmail.com>
 <aMqrmmDG65BGeZp0@x1> <CAP-5=fXnM15Zj5mCYcsd9usUMtHoPOd3Wz8-L1N5UaB-YvKuHQ@mail.gmail.com>
 <aMrk03gigBlGcYLK@x1>
In-Reply-To: <aMrk03gigBlGcYLK@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Sep 2025 10:26:58 -0700
X-Gm-Features: AS18NWCDCMZWW_hOMd5bnlhBoTlDxUUjbEdrSZ0E8xAR4aS_yxiC3kuYEDTQUGg
Message-ID: <CAP-5=fVhBUCjL4qe23apzGwUBQ--VGCgZtzKaopiuv4enxF5xQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	maddy@linux.ibm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:41=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Sep 17, 2025 at 08:29:24AM -0700, Ian Rogers wrote:
> > On Wed, Sep 17, 2025 at 5:37=E2=80=AFAM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > > And make:
>
> > > perf script rwtop
>
> > > Just call 'python PATH_TO_PYTHON_SCRIPTS/rwtop.py' transparently?
>
> > Yeah, that's it. The perf script libpython stuff is just providing
> > trace_begin, process_event and trace_end. Using the sampling
> > mechanism, as shown in Gautum's patches, it is pretty easy to migrate
> > them to being stand alone bits of python.
>
> > > That looks interesting indeed, that way we would stop linking with
> > > libpython, etc.
>
> > > I wonder if there are out of tree scripts using the current tools/per=
f/util/scripting-engines/trace-event-python.c
> > > mechanism...
>
> > > But even that can fallback to a python based mechanism, right?
>
> > I think so. Like I said about the use of a Dict for process_event, we
> > may want to streamline things so there is a tension with what the API
> > should be and compatibility. We can always have 2 APIs and try to
> > deprecate one of them.
>
> > > Import the script, if it has a given structure, use the new way, if n=
ot,
> > > call a glue that reads the events and feed to the old style code.
>
> > > Seems doable and would save code on the main perf binary and headache=
s
> > > with the libpython and libperl build processes.
>
> > So I see this for libpython, and I think it'd be pretty cool if we
> > could have things work like this for say "perf script ilist" and
>
> I think we could even try to, not having a builtin-ilist.c convert
> 'perf ilist' to 'perf script ilist' automagically.
>
> > Alice's textual flamegraph work. I worry what the work for libperl
> > would be like and whether it is worth it (hence sending the patch to
> > at least start to make it opt-in rather than opt-out).
>
> Maybe we should be a tad more cautious and start with emitting a warning
> that "libperl is deprecated (holler if you disagree if you use it!)" and
> then make it opt-in, and then remove it.

Not sure I follow, let's move the conversation to that patch.

> > Do you need my tags for these changes or wdyt about making the
> > kwlist/API surface smaller?
>
> Lemme look at the original post...

Thanks,
Ian

> - Arnaldo
