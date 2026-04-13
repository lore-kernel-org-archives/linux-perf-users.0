Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62C38CFE5
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113502; cv=pass; b=D+0WxAARP++Orl8GgMb5DB6VOKXdac9b0Z+6T5mdr+ClBXp7DEEeHEVOEEuj4X8m+g7bDyJnQmmB3THM2UrcH5lvmio+5hkiV249aMxqQP0EsQbfFNX2AhAmP6CoSS68TMQD6o8JvP4QP9nqZWw9IG9XDIgVdGwk95iwA2mDT9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113502; c=relaxed/simple;
	bh=gpMQ5iKYu3WwPug898u6IdNN5n6pgsa0CVJe4i0JSgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7KCdkDjby3I5x8Iz8L6XA79URzvrlckfwneHI9quhFwJRq7s4KpMen75luygIMMkclUq+jfha6CwJGkepyjTa+YfbkHxWTrcuACiXwW9bXe/vLRbKZFVRYatYldILdxwi/35ljMlt/025hZLrshug8oPwaU2MZ6nptsb+7WtkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvB4uecc; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvB4uecc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b462bd12afso100695ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 13:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776113501; cv=none;
        d=google.com; s=arc-20240605;
        b=Cx6TP99tAcGy6YiFfuJKsXHl11yutQwXvv6Zpgem3fWncI9DdFfTKlWAqisZI8h1+D
         knI2JcRwXixw5CheECxU1w0JeuBsUmRhGYL5givBfs8Z6fG9VEAaRvNlkzxRLNVBqckN
         hQSRbBNLX8xHKJTy9uwB7JZmr2OzMPMxBjIi2RQXMKUSotEEwAoMyGdRnirlrzN/ekKk
         ovYc0LRjiRtkxFdhVP5kikCStHQydIuThH1LUzVFDZz3d0PX8BGRJCZ+N2Ou9HAanwWf
         bcNqHwiOssnvorUHrah1u2R+m3yXnzPS3ZTrjn/8ljaQfJyHMKbUAlj8Y+4urRkb1WZ3
         ynmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H6b5Ekq3sqFNROrahUHBFKrK/MC9S0Vefc3TjiNsJCg=;
        fh=qrhn68ou9pxVIwh5PTDjFuZS/gClSS1CRjnmIVJ4i4E=;
        b=T18NxTX86kD0tEbFBDy4gHkRSyDH7l9epNHXfjOtCewpuSeCcR35PST2zRsRh+7KJz
         4VrOht9FKQ13ptQYgp27+LJM9uwlPNFp3kHeZYqZuRayBNT/HKM0boRp96f661keVK7S
         CPQn0wPJhQtFzJbIGOYwv/sMhL2SkmguWZootLOsgSJOPJ//GYFf9XFRaKbRWBiss9gD
         sWYDpGMP2n6kY3QAMbgcS4f0yyUIUEnFNkyJpQY984eSYuUX6TA1Cia8RkQ2QFbxcCjT
         EHhkQrLi4QIB7095OzUcim9pXBZ6sUwihvM6J7semAEbadY06+h1xv782vMQzAv8BlOY
         R30Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776113501; x=1776718301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6b5Ekq3sqFNROrahUHBFKrK/MC9S0Vefc3TjiNsJCg=;
        b=KvB4ueccIFifD3OvXtXetMFXJh3sO6pFX+KTrXx++T0rtiebuMuSwIGrg79MX1q1OF
         3GUZhfasXimgE6kAJ07J34j8UdocjzTyhTwOZ+WOxX/bs7UoM3AbvIOC0IbF6JMG3OmB
         OEGmao5JY9e3OtE+FCUTGgRqpsS/sQmp/gAV2S88M35vXefbbU5QiHWpNM2jlS6T//UD
         Vy5iBbFk+teA5JaLewT1ZsmQw9sqPBq4m6QVGZqchSWzmf+oVbphp75UdLFuAhYD1Lf9
         KAoXxrACAk1iPfk3edliJMUHPVOTHi/jSsuvdUolX/lt5+3vRwnwPZ4vFQBV5fmF+zsy
         3muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776113501; x=1776718301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6b5Ekq3sqFNROrahUHBFKrK/MC9S0Vefc3TjiNsJCg=;
        b=Gti5/0cDx/4YHzAZ5NOB0lKA3lCdsx3sGmTTK/xc31iJWk9EkxVI5N8AFlpDJc+AFn
         qzhAXBbaTbsqEdZFx6QsgjyP0Dqmx95NTC2eMzUU7GWr7ciCG3gSmALqvbBYw38ujZUr
         hUaQZ60LA2GYq5xd7L0L+tXN6K98dKkm9QsT9LDnIO1y65THwSYmmFNQQOwB2/OF+XCb
         OAeXYNsn+sYvFVfB4G3C8HBp/00KH8K0FTcbzGVjV03+PvaU6ggdvCZ8CQ8vbnCsH3Fs
         NO+gAvrj7Kvx6Jdws/yE5y+FdqHzKlV/nKciUJDZWd9buJgRWL7f+6CzmvG84M4ou1MS
         nU/w==
X-Forwarded-Encrypted: i=1; AFNElJ/Y42bejP3WQ9IQl9H8qf8bOVg6GUoneUf9+ei9V+TlbvnhciHpUm3N+EO5SEnW2XI5XaYiRrHmiPUslRzH5aAC@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqIXL8o6e21yXL4xNuJETNMzojeXODshMic/C3KTDSQwOrHbn
	laqWLcv/P763uk89VtXBM6avPgIkmRQZ+W3WB3O2nZ4dTZc4Reo7m4AkTFLORq521rvMJLcuDWG
	deKZ0Iz7iOsDDsUOddBY8M8SKWJ27mEIulPzu1EuK
X-Gm-Gg: AeBDieunh+cZsmvmxK0kvVFeyzwLvMBLBWxNECfPPaLuLJoUBp7WlFRWotkfx7aVz+T
	2nIyYUBtYoKPyuFUmuc7muNcUnmGfOmQD2ZeKdT/ni+6gDzjnGJUrOMqkLoT6jYrmK61+yzKhsO
	+l+DQa4rKfQq1xshKlK0zoKm07BqB7q3t08IX4254UhyJ06X8IzDyP1p0kigE57dH4wWj9+wVlE
	RRWfahhWPexWiusV64Nh1IG6rl+l/uHJv8NAiF0VZttpX9LxI/GW2GTTAndBXgs0SWT2R8s4TAR
	GZe9IXhtsxEmv8pupwlIpb6CEz5AXvtjDC2h0wu/EtN3163xycp3a0dZNb0=
X-Received: by 2002:a17:903:3848:b0:2ae:80a3:98a9 with SMTP id
 d9443c01a7336-2b2c8c669c5mr12946535ad.11.1776113500521; Mon, 13 Apr 2026
 13:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
 <20260412020833.641177-23-irogers@google.com> <ad0cxk1PJ4EcZi_H@google.com>
 <CAP-5=fUjXQgQWYZGQthYAcABn-rXtSGC4U2=OkaYMgjLif2x6g@mail.gmail.com> <ad1QYOR7DYgjVKKM@google.com>
In-Reply-To: <ad1QYOR7DYgjVKKM@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Apr 2026 13:51:29 -0700
X-Gm-Features: AQROBzAy7B-Gp4UFjdmNuk_1OV9NW_OuzG7dmSyxitLxMi6BcI-yfgitaFIHLss
Message-ID: <CAP-5=fW-wwpn-gy5q_PFnUOaLYgLHcnRp11bu9K9bPKKBPCX=A@mail.gmail.com>
Subject: Re: [PATCH v10 22/29] perf s390-sample-raw: Don't pass evsel or its
 PMU with sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 1:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Apr 13, 2026 at 09:59:56AM -0700, Ian Rogers wrote:
> > On Mon, Apr 13, 2026 at 9:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Sat, Apr 11, 2026 at 07:08:25PM -0700, Ian Rogers wrote:
> > > > The sample contains the evsel and its PMU so it is unnecessary to p=
ass
> > > > the evsel as well.
> > >
> > > This patch is changed to minimize the diff.
> >
> > I'm not sure what this means as the patch already attempted to
> > minimize the diff. I'm worried that not sending changes to my patches
> > via the list introduces errors because they don't go through Sashiko.
>
> Please take a look at the tmp.perf-tools-next branch.  I kept the local
> evsel variable.

Right, your change looks okay. However, based on past Sashiko reviews
(you may get similar results if you post the patches) I had been
avoiding having sample->evsel and evsel, especially when the evsel was
mutated. This happened because one would get out of sync with the
other, and then Sashiko would (rightly) warn about the divergence. You
don't diverge if there's only one. I think in this case there are
about 6 lines changing `evsel` to `sample->evsel`, while you need one
line to reassign the evsel back to `sample->evsel`=E2=80=94the error prone
pattern I was prompted to remove.

Thanks,
Ian

> Thanks,
> Namhyung
>
