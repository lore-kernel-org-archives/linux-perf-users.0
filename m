Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2A2E4264
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794746; cv=none; b=IDX7bU2lMiTmVxP+2dwOtUWw363h5xgol75caynlnpV6u0RvTC8rbfJqOyDanulzKrmKiUzSUaNNvDuaap6sDsxiBy0mplc3XLO05AWFs/60lRpP0uW/guAo5Lh9QbseTOvODK4fj2Nb7IjwNtEGccdXh/UAsxpfQLH30C3NKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794746; c=relaxed/simple;
	bh=MhG6HxqKpezhCtJQ2gfazEz5am5SvJZx5BGlHvwcFv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zq/6kb+ckBawGOI8mSQE06tSwNOM9fW/gDfpDBH0x4Jofr3zvZyFnQfuxjmEzs6yMJGiUwXctbkQ1uAd7dplJm22OFqktujnFkjQCD824YtwLu2c1rZOBJmrbe5GS3k9uTvur+ai9oUGyqLiMG5W/VmnFUVw95/Ly4KviroYBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6SET56j; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6SET56j"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24611734e50so835ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794745; x=1756399545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtcRwK56gAR8ZwI/7e//HivvdSeZfhowhjhRYyj31VI=;
        b=X6SET56jXmXBmRB20NuZDESqGfovDMkNsS5DWNA6lF8y+neLUqTEuhvXMVkgVA3YzZ
         UV5MzUHdsRngbq33zKqDNlTQRY/p4Y4ukH5FrEy3G6QflyKu+6Y92BWCQoFHVgfMC/ow
         2yDsVRFe8l2FMKwKBgFEZ7bdAQIebtWmEvsU0IB2Yz4ZAh/GyUMBhu0LDMPerAwIv4so
         h9BqfcFlMaGyszRrwkhqdw/UyT5yNddaGfAM/getCRA2lIqeJGwJyShpxyvVnEU+bQde
         Vq4g4jhbSVEYtHb0oc0UG9+3nAN3Jjf0UHBdxiWJ4SY+eQHPttTcdrgrl7Fy173gdMiZ
         FRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794745; x=1756399545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtcRwK56gAR8ZwI/7e//HivvdSeZfhowhjhRYyj31VI=;
        b=GQSCKNauAqhgvNqvihi5ahYWpFOxW7aiKRtJZPYPf8mqaO/MS34VI9UMFiRCR4QAUb
         llmzdE+3ejKfwA9l3D/FfJl43cSMjaVsK/mJnBqHJM3FnXOVCccI2n5XOHWIoo6g9Ydb
         fe5XGn50VvVPzX90DENavPJQULlzEbWD6XN9Cx05ImExEGVMkR86L0GGwjM6CIaYb80b
         KKUuuHmI9HEqM0OXqc9gts4ldxnmVdRTm3qaaapzVjBj8BwXNsfkC+E2cOJhHLoA1rSj
         1Ajun2xm9YBXHh7ziDwwhXA8I7I7xTXa+plLx1PeNxu7o+ujFEQtN5DTUCQs/voBWS/M
         Iarg==
X-Forwarded-Encrypted: i=1; AJvYcCUtSu14ePXGyDlTUbH11ft0RKhVeLekNEOOBbu6DdFsMaeqY/n3TbLrTmoRkCvu3K85gjppeX9TEAyT/TmGKkx+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gqNLGcrbHCo+JJMvIOu7UK02PIIA4TdpX/aqVFpQdC8YiV77
	/Xe3yZALSo+LQuvnLHv2DozFRM3ntmlwUfxNm/3Ih3/fo0eM4ck+8DCCspjNFuidJSao5nYHZQ6
	74Q4xjL7JUrSdc4Sy9lZUZig5Qt5OqxrwPBzqVMUp
X-Gm-Gg: ASbGncsABVvalLYEbjeA12/J0UYnDFd2oy8E/MJLP9QzHc5y9YFP9l5y7aVelLMJW9R
	dYno7AybPkyNP+8YpwiDaqawxAW3OR7LPqOBDTbvpcziEsdTtECoUxiaB0fhkF35L1tL8DS+Ite
	zokWqK5sL6OkuZ4egll4f14/T3+M0qse2/XrJBq2V7n957VYQ+ubhbmhUPT4qJZ4Sg7pDvAeZZw
	2RfE5wGIZSHmAdkrJVSJP+KI79mNg89qKltfp4tQJs=
X-Google-Smtp-Source: AGHT+IGc5M2pH+JuphSt7Wrta4P/SsO44cJ6Mc9+TzDooWaV+WIJJPFwCe1ixQlSizXmDs/0AaMxJ6grKNm5ZGhx0QA=
X-Received: by 2002:a17:902:f552:b0:245:f7a8:bc60 with SMTP id
 d9443c01a7336-245ffa76584mr4413645ad.16.1755794744597; Thu, 21 Aug 2025
 09:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519232539.831842-1-namhyung@kernel.org> <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com> <aCz-wD2Syq8mj2_0@google.com>
In-Reply-To: <aCz-wD2Syq8mj2_0@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 21 Aug 2025 09:45:33 -0700
X-Gm-Features: Ac12FXwUBrTyS3oSzZtgEAH-YrEQkY0lFhTx9npzI33o1HnplYpkYxpBT8BeAbM
Message-ID: <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 3:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> > On Mon, May 19, 2025 at 4:36=E2=80=AFPM Howard Chu <howardchu95@gmail.c=
om> wrote:
> > >
> > > Hello Namhyung,
> > >
> > > On Mon, May 19, 2025 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c h=
as
> > > > max entries of 512.  Usually syscall numbers are smaller than this =
but
> > > > x86 has x32 ABI where syscalls start from 512.
> > > >
> > > > That makes trace__init_syscalls_bpf_prog_array_maps() fail in the m=
iddle
> > > > of the loop when it accesses those keys.  As the loop iteration is =
not
> > > > ordered by syscall numbers anymore, the failure can affect non-x32
> > > > syscalls.
> > > >
> > > > Let's increase the map size to 1024 so that it can handle those ABI=
s
> > > > too.  While most systems won't need this, increasing the size will =
be
> > > > safer for potential future changes.
> >
> > Do we need to worry about MIPS where syscalls can be offset by 1000s?
> > https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.f=
astmail.com/
>
> Argh..
>
> > We could do with a map that combines BPF_MAP_TYPE_HASH with the tails
> > calls of BPF_MAP_TYPE_PROG_ARRAY.
>
> Right, it'd complicate things but I think it's doable.

Should we merge the x32 fix while waiting for the hash fix?

Thanks,
Ian
