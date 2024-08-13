Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BEE1A0AEA
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565112; cv=none; b=rMdwGKsGkH/E9PROO8LCoQL/eR8Oaq5Sju4Zsiagl11SLbj/6fF512DJDCQJgzj5ILCLaTCXgMgE4lPfeoGO+X4sJOhvoNwfjlz6PFRNuk0CANiTE3c53QtCD4sFklwh1Ww0UTxRQV0wQrLQTd6sb8EXgVOz2IMDdcqy+34ozsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565112; c=relaxed/simple;
	bh=dsnEFrXQEe30129gATA65SKh4tPfceYgp5NXlRzsf+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWRzdSUFs0zcq2enheJ6OFtYd5/L11swU+R1QBtFCOUjbep86U0P2w/DQQCijwC1LYK28c4RTMiDU2S88NuHzGFCotVktPOYCe/iwjvgj74p4YQCnMoGW/vcqXIp1ZkMUYB04NjBVxo/SIFuyrhnA/wSzy8G3ae8Kcxqd53JcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0aOVX3Hz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0aOVX3Hz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-200aa53d6d2so113275ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723565110; x=1724169910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYWzJyvpTQNIlST/TNx5IAt/1qpwACIOgkuhkXZEt38=;
        b=0aOVX3Hz9czVpRqT+ewLN0sKVAbXC/UdzZGHVoKKPJcF3N2vatmszAPxh/udHq2iwi
         cNVfZ7z/Ip8807GXyVpmUTl972pvJeCqvQ6ubOm4Hkd4rSS6d03FMKMDTdO/nl/4LWXH
         gq01qezG0fcrEmM+LzYrE8ygvcZU2W6b/hdwvdwrf5eenHcbjSZVy17zEhTHljWZUmD0
         TnQ67n/eKYeAye45uqX5QP8JPmcAgQY7gwczoyc6hJmRDm8VEl+XgihZr6kg0he+pgtV
         ww1MFggGvTjLeCB0jLb/xEq1fVWbOUEg5NrQIKoQ7OlBDyJg84P24NzNt+7vM5UpUzvT
         LsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565110; x=1724169910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYWzJyvpTQNIlST/TNx5IAt/1qpwACIOgkuhkXZEt38=;
        b=wx8wbs68zUQJVIJmIQ6Vd7+zLBOmj1jC21zgDrsX8R8S2T3PuJwKsP7gihwx/LZFZX
         mMY8kKpISDtnzQqALuWrheAuTLlLYij/9Q+daW6y7rETDiD8zv7F+I3cGO7gpb++3BBF
         R+vodj52OiGvf9gbNvCqdPEvri4E+RM0it416xlVLhfnQEhI2O6gFyb2GMnbXIQgU0g5
         KXoyvJummq8OripQ+jfcalzhSspYJ3lKLUzv39l68yzXopXr4cvuTmpckxeUfr95t3/l
         WhoUFpl0KCJEHlK4K/hTNtn4dPL/a0zzTSoOCA4ZcLqqclxqogyT2dS5DB8z+1rTlJ2M
         E4mw==
X-Forwarded-Encrypted: i=1; AJvYcCVhyK9W1GpasOB/QBQEzFtS0nt8JCoONB6thiL3gJNlAg1GU251O+BKH3nMrvBOg+C/7fjbjYpSirxDG/NgqUllSrRwHZKDcrR1dg6XTe2bog==
X-Gm-Message-State: AOJu0YxPfyECuXEFhwl+10X2JRjk2v4QUBN0gA2eF2XjSxbm9RATPV9B
	TGiry2A8wsepfrMUObcxiaTcgK1vTTXV+j9Bu4oIXbQxk1yWNwJQ/IQHp7sCyOhsRgXzwLJEzwv
	3HbnZSPOy4T1ijpZddaAmXkzAcpXpILhRM9ec
X-Google-Smtp-Source: AGHT+IEub4FIB+lio4i4nkw8sW+gRiszAfxdnYj0Bw1TMl0dWkbkwnfXacTcpG2yDl8Cz2lsKatOfYpP8MFyLU5J8so=
X-Received: by 2002:a17:902:c40c:b0:1f3:3ede:9b0 with SMTP id
 d9443c01a7336-201ccba5f3fmr1740695ad.10.1723565110178; Tue, 13 Aug 2024
 09:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813040613.882075-1-irogers@google.com> <ZrtzTTHim_vGX1ma@x1>
In-Reply-To: <ZrtzTTHim_vGX1ma@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 09:04:57 -0700
Message-ID: <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:53=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> > lock__parse calls disasm_line__parse passing
> > &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> > lock__delete.
> >
> > Found with lock/leak sanitizer.

Ooops, I meant address/leak sanitizer.

> Applied both patches to perf-tools-next.

Thanks, could you fix the commit message.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/disasm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 22289003e16d..226d2181f694 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -566,6 +566,7 @@ static void lock__delete(struct ins_operands *ops)
> >               ins_ops__delete(ops->locked.ops);
> >
> >       zfree(&ops->locked.ops);
> > +     zfree(&ops->locked.ins.name);
> >       zfree(&ops->target.raw);
> >       zfree(&ops->target.name);
> >  }
> > --
> > 2.46.0.76.ge559c4bf1a-goog
