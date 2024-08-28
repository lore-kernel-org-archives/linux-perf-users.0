Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C591A4F0F
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865256; cv=none; b=fySW48BzAH1g5HIJG5bDNRuv1t+oH8ieX0sJrg7/LMcCwLBEpDK1BFzFLyPSY0ea4BXtSIwo80ZBseaPFSzZig75VLKHwwxDxnHDm8YMcPTx7qjQ3gFwvA4QEbk1Y8voojxWUz6mJTqpwJK2dYdlQPbKgOhtU69qVTUQ9xmXfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865256; c=relaxed/simple;
	bh=XuU6lfnAXc7wBWZXO3LoSeJokR3ZvXf1xIXUsa6plnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD/uCKbJ4gfTUd0V8Vlo/lDA8h5msP4n/SqMXGK/5OwywnTLfn/50m5LhOCwlaT91/ntAM2HoWHeXluZbDifhvMOj0+16wV7RKRA7cVfnDnHQTR/CKxLrgl1nABY1ofA+cycAHONdBqa09jZ9c4Hu/a8WTazZSGs3YsL2OaTp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBLCCn7E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBLCCn7E"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20260346ca1so13455ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724865254; x=1725470054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgsg9KYlOPgnINZ9GfyD+BBUo6PvUfKigYVEMj5LYlU=;
        b=VBLCCn7Ezc56gL7vPp1OxXFkJWx8jAiTv0mUjPaAAvyu9Q54RSTGZk5WYPf5/Cuney
         HmVvgHK1gmRL+MqRrQ1UFyzR8ClsYgByXUcVolKD+HheNu8dhHOY4rn9WbWn94O7dDXd
         CMHvJkiiH5oTL+0juR0ZVOdwbAN5pY/1owU+grTKXK/THk+hntu6WO+94/ASNyoVIKsW
         MBGqoEqkH4baLsuvXhV2oeLX/2R82hUckXEge9H/w0X1RCQUnwBDu2USW6ivrxgch3M4
         RjZyzr23IxbzV3RzmBbCxgVStk7lWg6xGOWF3XM96LeNfZvk4cxAMVhSu5Hul1V5h2zx
         wpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724865254; x=1725470054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgsg9KYlOPgnINZ9GfyD+BBUo6PvUfKigYVEMj5LYlU=;
        b=d4LXKyRkJkImbfbYFfrZPyVRR2oJBtexP5XnFjj1XZU5bg72WfeGD1pjtJBYQJhKf4
         cNPmnhA6DuhvlLh2Kh2IJxhn1E0jnvntHUZzBrSlGR5iXLjteq5Lhvd1EzcZVnXx1kMv
         i9FRnnFZILiF9Dw68o2kqG9JAgXhs66h1CUbO3lvp9MNBrFvkJe7QqYe31kGk/y/WwZK
         z9tM768zMsTedX+JXXkyVeEZoHn7fNh4bK0Kk0qbLGJGV802t9QOR+0Bt+QaNZ7lJNSp
         wHPAueXH3j2tJgbLtShN2BWCNCRjQyrlS+C5EjKutMrf5KLPhLUDybnRzFFn4vIXnkVv
         RMlg==
X-Forwarded-Encrypted: i=1; AJvYcCXbRlFoGiVXbqp20K0S4Kzms5+YLBatIZ57jJ+GQQtCX5aqKLyWUvYV2Fx3MV4rXEKcNTQjKm7VfOEwiUWdVcVG@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHnBNmDqFPG/8urBnZAcW0mizn+0leJXm3oR6XSHFBVxj6GL0
	nw+pehOIOaXZkU966OE+ekExteSGFaNabwMxkdy5kE0eoU5oQxfOE1BcuJVozJpzosnNnss8ml4
	FUy1wLDoB2HgVa/lWEYwBZmdKS1VtBeyz+Fto
X-Google-Smtp-Source: AGHT+IEclezY9FbFmYOMIJpk7h1+XOP+3gwZEglT1ovqH0RFwg8+37NHUTVC2VrWG5GzhCh5VftM3Q+HdyA8/UzsKJM=
X-Received: by 2002:a17:902:d512:b0:201:e2db:7be3 with SMTP id
 d9443c01a7336-204f960ea01mr3339395ad.21.1724865253338; Wed, 28 Aug 2024
 10:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828140736.156703-1-james.clark@linaro.org> <Zs9YGP4d0_QanpoA@tassilo>
In-Reply-To: <Zs9YGP4d0_QanpoA@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Aug 2024 10:14:01 -0700
Message-ID: <CAP-5=fW=eYuKQtnd=1gM3wh7MubZ+P56ZCHn9dwvkhUn_NQZMQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Event parsing fixes
To: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	kan.liang@linux.intel.com, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Ze Gao <zegao2021@gmail.com>, Yunseong Kim <yskelg@gmail.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:02=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> On Wed, Aug 28, 2024 at 03:07:14PM +0100, James Clark wrote:
> > I rebased this one and made some other fixes so that I could test it,
> > so I thought I'd repost it here in case it's helpful. I also added a
> > new test.
> >
> > But for the testing it all looks ok.
> >
> > There is one small difference where it now hides _all_ <not supported>
> > events, when previously it would only hide some selected subset of
> > events like "stalled-cycles-frontend". I think this is now more
> > consistent across platforms because, for example, Apple M only has
> > cycles and instructions, and the rest of the default events would
> > always show as <not supported> there.
>
> I'm not a big fan of hiding all of <unsupported>, when they are explicitl=
y
> specified on the command line they should be absolutely shown.
>
> I do have tools that specify events on the command line and expect
> the same order/events in the output. This might well cause breakage.

The patch series doesn't do this, it just doesn't display unsupported
events that came from the set of default events - default evsels have
a "skippable" flag set. In patch 3 James has added to
should_skip_zero_counter in stat-display.c:

+       /*
+        * Skip unsupported default events when not verbose. (default event=
s
+        * are all marked 'skippable').
+        */
+       if (verbose =3D=3D 0 && counter->skippable && !counter->supported)
+               return true;

Thanks,
Ian
