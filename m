Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6F1E492D
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072151; cv=none; b=hAW1Qmj5zwctLm/lggD534vCfw7hwqLm4Rmi4iOIJqfB2aKcEc74OcHj/7MLFcToa8RjX7hSMvc/eHtukh8GgRa2Fy9j5Aju9jsTYY9URzVvHZomAx9h0owTGaUO2RwZL9No+/ckd5DREsXqUkFNZ7M0rBGCJSluYlnXiFWfgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072151; c=relaxed/simple;
	bh=rUwYUfEVwgtherHE5w2Lq98za4Mn+0GYvGErylseNA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4dJ1Fx4e9nKHpf/D0/YwJ1Q42ZYnbZktZ4ZJPakJlLy+qheCw1DCqSa2HN2StnyfpRncKTdQPTCmPTqXMqNkasF92CGtIeXxgUtNv1BvYsRfleQSKi7+u86SOks9l/qx+EO/ffI59J6iEggx1z0RHuvlBK6rbOvCQ7I9qS0UPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l12U35td; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l12U35td"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so8702474a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 18:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758072148; x=1758676948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtvpRw2skwIDYeLYnJtYbENzaRocLr8itc+rc0AxN3I=;
        b=l12U35tdBy+CEfeOgwSa5RZGhG9ps4GzXotEeYBCc743an7P0JKRekUBh4TFcmg5ij
         70WRaJEAHcXuH/A5Ws2ozJJoinRs2JEE0+FosZ8Q4sigaAOkM7XiBP1GV4ch4zVXxjMm
         1PpdcLa6uw9i7NZ01xPshNc9qC4kFqlk2wGg6ZP+xxOZ/1l7lyrFhBdA196TcQW1K89A
         ZQHDvGi94kbVW4MUx7kKmRbNEYZ6L6+xaY74m7h8iC5XXgRmJyShayfMkH8KqDBP13M2
         GArTdTLdbRh0w7zNXWL9zUn3KLt0eJpYz89KI94FxWqwoEUmOyQJefjWn9OYmV2JWBOI
         Tz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758072148; x=1758676948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtvpRw2skwIDYeLYnJtYbENzaRocLr8itc+rc0AxN3I=;
        b=UjqKyvaVpE37d7cneKAHWzUjjtKywnvm+hXzuO1DbJkNwNGjK4e0NH3jHyvzk9Lsug
         rYuUWhE9VUjgNEoGhzBC685G4J1TOdaI+xNa937tKrnxald3KXH1PkTbvvpmCVNxz5EV
         YahZTSKNM3J4PxdgyLg1zK/vUdmpegbcAyuDAjtIJMhpbXAw1FhWKPIbzE3gn4LvDG69
         LNMts+Emc63frxr3xHq4qVY8qJaA0bCqGCI5RU8BNSiOua3hNYx2W9eXbyN3Pp5tnfIJ
         xzojp27iGUmy+2P+85CmPswjy5sZ0SpkU/Bt20wZPsnc22ycxxw+gYHBEGZeAs9qr8YU
         7psA==
X-Forwarded-Encrypted: i=1; AJvYcCXezhV+S79lDsAvGFm0sCQzIlsDHq9n0BECy5NqltpVVPmMThW0MJxcvWv0sHhe8p2/7hDU1boZl6nJrorz3BKo@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSWZmn0BKgU9Q56XbZaBN37v493e8sT4WB0fTfzDYFtK7whu9
	NW/Uqzehy0278TcOFyQxBsbpT7s3qtYOPMAerptmhq/qSpMLT5jRsob1gppC3UmuLb4ph3q1TZW
	gmgWZve8/j6IIjBTiJsk7Wdfqypn+stUdocvswYEc
X-Gm-Gg: ASbGncuMjDuOjjvrV0io84Q1FxNyZHIAsxepCBm0/ts5J+QqRJh13SWBMb4PCLUK+xr
	egbYQwU2SV7rQOgnzz2y2BsNmr5BVEb+gHF26Lh+B4pzb70pKFEMLbkO64eorK5Mv7nfNcYi8RY
	YfZU7IrglH2vGk0S7ZvXcner2LjAD2roQlJ1eOqS9xcJOP0+1hkzwOavWRy+4vS+vc2g/r9O7AA
	Nb5oqZLohrpL8qAXJSb93rJp70hh18LRNRB1nSrO/rcsTwe532CkxGxi6I9BAvsiBMr
X-Google-Smtp-Source: AGHT+IF3cY3woTYDfHAOdf6v8U3gfZQ2LkEiVSJvH8VmNjR6wN91SZk1ZTmjg3Ky/uZkx3qvCsBnZl9tkp2OSOIY83A=
X-Received: by 2002:a17:907:3f10:b0:b07:dcc9:1186 with SMTP id
 a640c23a62f3a-b1bc30239acmr45850066b.60.1758072148051; Tue, 16 Sep 2025
 18:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195833.226839-1-zecheng@google.com> <aLKpmcHtdyaqzunq@google.com>
In-Reply-To: <aLKpmcHtdyaqzunq@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Tue, 16 Sep 2025 21:22:15 -0400
X-Gm-Features: AS18NWCAA8jZTc1dXpHLv__FqTlwongv36MmfPHCHni_ZGI0wWlu5HxlQrx28O4
Message-ID: <CAJUgMy+wP7t3Ss=JLOXDaxkLTZZHkirT5CJrz27K=HYiKU0ocw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] perf dwarf-aux: support DW_OP_piece expressions
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:34=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Aug 25, 2025 at 07:58:33PM +0000, Zecheng Li wrote:
> > Support variables split across multiple registers or stack locations by
> > handling DW_OP_piece in DWARF expressions. This enables correct matchin=
g
> > of such variables by iterating over all pieces in the expression.
>
> Can you show me a real world example of these variables?

An optimizing compiler can sometimes split a struct (mostly stack
variable) to multiple locations, or even optimized out. DW_OP_piece
describes the location of each part. For example,

DW_OP_reg2 RCX, DW_OP_piece 0x4, DW_OP_breg7 RSP+28, DW_OP_piece 0x4

The first part is in RCX, the second part is in the memory location
RSP+28, each of size 0x4 byte. Memory access on 0(RCX) corresponds to
case 2 and 28(RSP) corresponds to case 1.

> >
> > There are two cases for matching memory access on the target register:
> >
> > 1. Accessing a struct member:
> >    - The type is the original variable's type.
> >    - The offset is the sum of the piece's offset and the operand's
> >      offset.
> > 2. Dereferencing a member:
> >    - The type is the member of the original variable (the member must b=
e
> >      a pointer).
> >    - The size must match the piece size.
> >    - The access offset is the operand's offset.
> >
> > This change improves support for piece-wise variable locations in DWARF
> > expressions.
