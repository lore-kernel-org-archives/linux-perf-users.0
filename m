Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2662882CE
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547731; cv=pass; b=D2QaTvJi/mEzYDOx91VsmJfmr3uvKoM0Cuz1DZsOjMyIQGmanOwzG/nXKXm62kDC7p+Pg66svPNXQlWDHAGlxyeec4y6Fx6+IfnSbYLppHz7vznOTQMDmvIREAgjrNIVsW18BlkRjsE5ZRXQrlqBUngV+l6l8Fd3a6k8I5xxBjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547731; c=relaxed/simple;
	bh=KNHweNGDpGm4ZnN7aPhScDNOmJdoPwpco4xhVuTp8Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ+q7z8mU/xmsMf0f8OswhBpqSxhKYXfGjWMzaKYTx4n/WJYaLRhiunNEvcMpcMFDDfY8fOPZH1FxRikoMMJEVIiPRzNLJponAUPO0NNmSqLsir9feg36avHJda2zuyegTjYmTCdTFczxOxiputp92OAy0aM2MAqXI8O3EAyKME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW8G5L6O; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW8G5L6O"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a12ed4d205so40745945ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 13:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769547730; cv=none;
        d=google.com; s=arc-20240605;
        b=j0UtW6PHDNeQPEvdRwcDAOeLwJ2yELF6twCL9tnfiz37JDowS6SU06t1KI/gSz6pr3
         SIKIvUQMOn1/gRt36hDifjt4sN4nI8cQk6a57uBV/iWJwYMO/bflWMV33vREJzVrC2hf
         8gIfCFQ6wtq/bsXaSumFg5r+EjR7LBNmHfy8Y0bVjt9su53jZapOJNBqkHfFlTJX25BU
         BkFk/LsmMWOyfUdSHejC3X/Z5gYf0OT+fGhZeOe/7CAuHHymU/EpuW2RINQE8AEi94Gl
         OlUp9CQTkKcG94h0RyOivfmQxrTYnU7mj/hy3mpTPZ8dtC29uN5SjpRZ2oGOSZ+6nv/t
         dY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w7j3CPHQIsc5Yl3UjDGx4jct6io3dDzxCr4YX/1yUAg=;
        fh=IXgV547CY1EJCIoTrWiK9C0EceeFzOdj3Iefx1cYaPA=;
        b=Caebq9HkfIWfngsBp9LQnq0Ff1sFwb520Vsnn55yxsfDHi2pIInEiD2d+Fa6cwP+bX
         qLfCTkL8VxN6sU2klzHHEmjwKgZX4LWC2orOyBpMT7MyDQ1pHJAQn6mrxivky/VE0VHH
         3Eab0oiWKmbgZ/EraPTKnCwrtWyN28ugOy3NJ4d2jetC4xN7stMpKhVKLAdDEdP0D3LU
         3Gf6S9KljIkQqBkTYxGe2F62JRi/EY9jqyljcIr1Kx9me8izoE6UwXo6EhR4uktq6wiE
         OY7KikslGue/MPzgBP3y1QPtkONaZ2xVPozz6XL1CZUUE7iT21AwxKvpXpGTTz2H1lti
         oEHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769547730; x=1770152530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7j3CPHQIsc5Yl3UjDGx4jct6io3dDzxCr4YX/1yUAg=;
        b=kW8G5L6OGTDC2fT71IgmhdQlmnnY3WcCSBJi7VMyPbyjSH5XIPCRpgP5LnigLZiJnv
         Sb540/QrLr9BIGVr5sOQVPsh5uPqPEpP+earoA6vsAWFAEB9a1kH2hG7dWY/IhWJhYdf
         /Dxt5bE4uz1FkEE+eK9oLSIX+KAuOmRFpLS2L1RErGyTqnc+ymNSd7Wy3WgQpdWfx9U0
         tM/AlVZ9sQKFbCkLd28siJg9gJ5au2jG3133nd0TysVxHormt2DnDC3FYxEDIcPI3s+n
         u9n6VWH1D73oElT3zWB7W2dYejeo+pCT+mXauqTqMjhc+0LL++qCy+bW43TUIP1p3rYG
         Jnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769547730; x=1770152530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w7j3CPHQIsc5Yl3UjDGx4jct6io3dDzxCr4YX/1yUAg=;
        b=YbElrS8olfROLsmf/BWiHFJ9rno7va3ZTqXgWBtqgMJV29SDYlxe9ORKWw9hxXuXll
         FR2ITJJksaKhNFXlFsK315qvQ/ObznipJbAgBl2BsSN3iIOFYcjtgea4xAzvglh0zasJ
         a1zlTGebh72EIbMVOFq9TXMs76pre+uJ4RT4b6DbSIFHQEi5B3i2VAOrAWBiTZAHzulz
         PhErB84eLMZ6eBFGh/YGxGUGjfTJyOaw18uh9lUVxHP1ZeJMscdn72ZBXVloZ5ifrg1e
         4s9RfJHbnQleaY9hWRvH49PVCmpAcrLB5ik9Qr0+5gDlQYomKXODP8D2C5DUvk0xMOb7
         Ly9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4c8az15qT+ZROwDdJTnKbsn2gQ7x+tTIlwqfaLaLJxXEKOSVEbvpsisiVB2e3COfhHlJ5fgkC4hytpI8RKBdZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9nwAIKaepXUuXnFEvDT1L3AqXapIxy+5SIKit2j+h0c4s/K8r
	uI5VZY7A9VZIqHH6oDWTno38N8Nj9fAa1PvR1FXjvmIA1Ag3SaoN1Zzg3V+tsuuxP7zBMo97J8z
	ZsfRIejeRZ229KzESA6hPMRewjzPIsXs=
X-Gm-Gg: AZuq6aLJmLqqCrdQ4XXkDmVj05B/h7Pe8aWiw1GcAAdVIjYDAOn9gtOOR6RVViGmALz
	KDA6TlhbnxfHBSm19wHAjQBtxyXBeE+Ao/LoyX/yOBKWYnbRpb5hS1rHj+hjThv4wRmFxUaLPPW
	4Vk0k/Gh3Mki1j2JLPJVZWvFaI2eMYr7H8s5LF+uOZ7X4+IFxQry7hTOZX37TJ6i5HkrGDEmLTB
	GikvTOFvN/XeknRE30Ohw6vVE+RrWmYyZOJ4bO5kBZPLbEZ57+RTOGMTuUFiOw0L12w+8TMuQ4Z
	BBysj1Pg3MA=
X-Received: by 2002:a17:902:e552:b0:2a7:683c:afd0 with SMTP id
 d9443c01a7336-2a870d64dcdmr28661495ad.14.1769547729520; Tue, 27 Jan 2026
 13:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-2-chen.dylane@linux.dev>
 <89d94076412b6fc7e05e4d4884f3830601b390d3dcbee91aff2ec214117411fb@mail.kernel.org>
 <0b02943b-4ec7-4be3-b0e2-6c77531c4cbe@linux.dev>
In-Reply-To: <0b02943b-4ec7-4be3-b0e2-6c77531c4cbe@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 13:01:57 -0800
X-Gm-Features: AZwV_Qiafbe3wvAF3yuuyiNfBzRGkFBNphWOyUKpFvlJjyIdmXRufFUurygsAkg
Message-ID: <CAEf4Bzb776Sc7ByYF=AEFYw7mXoXVJTGAD-3QY49yBtuqrchuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
To: Tao Chen <chen.dylane@linux.dev>
Cc: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 12:51=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> =E5=9C=A8 2026/1/26 16:03, bot+bpf-ci@kernel.org =E5=86=99=E9=81=93:
> >> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> >> index 9ded2e582c60..0330f265173d 100644
> >> --- a/include/linux/perf_event.h
> >> +++ b/include/linux/perf_event.h
> >> @@ -57,6 +57,7 @@
> >>   #include <asm/local.h>
> >>
> >>   struct perf_callchain_entry {
> >> +    int                             rctx;
> >>      u64                             nr;
> >>      u64                             ip[]; /* /proc/sys/kernel/perf_ev=
ent_max_stack */
> >>   };
> >
> > Adding rctx before nr changes the structure layout in a way that
> > appears to break the perf userspace ABI.
> >
> > In perf_output_sample() in kernel/events/core.c, when PERF_SAMPLE_CALLC=
HAIN
> > is set, the code does:
> >
> >      int size =3D 1;
> >      size +=3D data->callchain->nr;
> >      size *=3D sizeof(u64);
> >      __output_copy(handle, data->callchain, size);
> >
> > This copies (1 + nr) * 8 bytes starting from the beginning of the
> > structure. Before this patch, offset 0 contained nr (u64), followed
> > by ip[]. After this patch, offset 0 contains rctx (int) + 4 bytes
> > padding, then nr at offset 8, then ip[] at offset 16.
> >
> > With the new layout, this copy sends the following to userspace:
> > - First 8 bytes: rctx + padding (kernel-internal data) instead of nr
> > - Remaining bytes: nr + ip[0..nr-2] instead of ip[0..nr-1]
> >
> > This means the callchain data sent to userspace is shifted by 8 bytes,
> > the last IP is truncated, and the rctx value is leaked to userspace.
> >
> > Is there a plan to update perf_output_sample() to output starting from
> > &entry->nr instead of the structure start? Or am I missing something
> > about how this structure is used for userspace output?
> >
>
> As AI said, this change shifts the memory layout, which effectively
> breaks the userspace ABI.
>
> Maybe we can use __output_copy(handle, &data->callchain->nr, size);

yep, very impressive for AI to notice this. I agree that
&data->callchain->nr seems like the best way forward.

>
> > [ ... ]
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2135=
0234831
>
>
> --
> Best Regards
> Tao Chen
