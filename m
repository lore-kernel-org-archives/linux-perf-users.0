Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE71A7058
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576299; cv=none; b=MMr2V9wFxE5TBp2SkM7F4ZbQujTQpcGGfYr01ZLakJwkKSKa2PTaoDJ5vJp6gS3Up+oggzo2X+lfPV5Gb+oo16UWSDdeNoPjTnWr5jxG7MfHNzJVMwr1IQ4W78GFJYraYOmKhezpZx6H4LVRHTca5ApZyIqDvPrnzH4oEeXPNvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576299; c=relaxed/simple;
	bh=0akCB2lUXwXXL4c4nPCxosaE3I857/U47hgI91ToH8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze/77pwc6PlFn8zYsYLMYEbIJUD7Sly0kaJwNCvxWWfZXQr4xFOIvgHc55HzjrpN2zzlmjpwZUyFhEHxsyzVYvIymxXC00N64Gt+xPtfCS4gBOfflAw3/XZ8QvYMVtLfUOrvxOS5ATRQicfSsHagoGqRprR9sAIR5u4qCoIVRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B729vSPr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B729vSPr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd657c9199so185ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723576297; x=1724181097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0akCB2lUXwXXL4c4nPCxosaE3I857/U47hgI91ToH8w=;
        b=B729vSPrcNEGQKlsKDz6guarSKr345ecj6c36vuXCOJpMRNeIm5yyy6dnYwAmStzAw
         JTju1PSEx2fGmj+e9HHOJ8x1xj6Hkxt/WktJ5cNPZ4zy9+itvTiF0BLZB79I7hnG70XE
         STa7LCS/ddZD0UPZ7SD8S7atBtMdqpC3VdDTzS9L5libqZmgm9a7g2Kw5kOZgzZpHrSX
         TdlDhT172CdZ30wccrS7Ak1Bq5xt8UwJwJXEHgancPaMFL98Pot83SBaIAdeH032mTUd
         Gw8+b5KOh24PXehk9ZAtbKMfVYuGXAFhS2f4Lbm9+Q/sFKM9ShTR8N7Wwgn3WOIfnJOQ
         yTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576297; x=1724181097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0akCB2lUXwXXL4c4nPCxosaE3I857/U47hgI91ToH8w=;
        b=HO2JSt3IpMARPaOJNssFpjcIZ0Ft+wPWcrrnRspDlJj93lGojjwxphksKu2k0aZ9xF
         RWm/9zyi+iu8aNOhefNgigvNhzMRC7CB0vrjPTtjhH1HMtKJ0rvzsedpI8zKReaX2JcR
         1Qwt9A/Qtd0bJTwZ6YssMxDlvCUEkdNs3GWj2L0R0vibhb7q+UNm01j4XIztsjEd6iyI
         kLWGWx0XO+cKp3k5ee/dKzulTHa6+tJIDHakoCV1Hqor9d+KEoASyMpRcXYucAb99/xA
         IS0u2y9c7zYVJX+LGlEvSWHcCRBZQIO0YFw6JDx+3gRmcJghcy6smmQod0ZDW3rOggAz
         CFVw==
X-Forwarded-Encrypted: i=1; AJvYcCV0VvG8enNoo1mRExdC7FV6HN4xNDoIU90x7uAxC66TCIX8NKhq4wzOExAACBlwoVgUx9yf5H+KbKpKDsk2NVhA544VEG5fIsYS4fcI+iaDbA==
X-Gm-Message-State: AOJu0YxgRZvkaPPfOYv0KyI/Dl6W5vGvNy1gJ2ODUHWpcmB37KI+vsEG
	VgwXYRrwLLrDOtDWgmb+ZjY7usT/GSHOkljCLS6vjjBOzGxfsd1TO2XLay/5SDy27P5u6PsemwB
	Y8yUq/cZk8fbog8oezkx/T2tGsGTVRexneBk7
X-Google-Smtp-Source: AGHT+IHdvTrBByfKnXhhh6zwnJjdbwU4J5mMe1EDQZ4dHX8vp3horZ6QsjNBJr6Goj6FpxG/8/69jGclyK5ceJGotzY=
X-Received: by 2002:a17:902:a515:b0:1fd:d807:b29d with SMTP id
 d9443c01a7336-201d747b187mr219165ad.28.1723576297094; Tue, 13 Aug 2024
 12:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813040613.882075-1-irogers@google.com> <ZrtzTTHim_vGX1ma@x1>
 <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com> <ZruhsN4i6xtc59nJ@x1>
In-Reply-To: <ZruhsN4i6xtc59nJ@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 12:11:21 -0700
Message-ID: <CAP-5=fXVrhanvW6vrUJsubuWUC4jBM5v_NOFp40cqTsqdHHNaw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:11=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Aug 13, 2024 at 09:04:57AM -0700, Ian Rogers wrote:
> > On Tue, Aug 13, 2024 at 7:53=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> > > > lock__parse calls disasm_line__parse passing
> > > > &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> > > > lock__delete.
> > > >
> > > > Found with lock/leak sanitizer.
> >
> > Ooops, I meant address/leak sanitizer.
> >
> > > Applied both patches to perf-tools-next.
> >
> > Thanks, could you fix the commit message.
>
> Sure,

Also, it'd be good if maybe Namhyung could take a look. I did things
this way as it made sense to me, but we have nested things going on
and potentially the free would be more natural in ins_ops__delete.

Thanks,
Ian
