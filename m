Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58E136E1A;
	Fri, 24 May 2024 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716592942; cv=none; b=qmcCCB4JtzCRBZNW84vhvpCgFS+O/ibXlYfiSIrZ9kgxLRDcKfatBbWylszBq++KJS8kwn4SsmS0CftF14B/gzLJbDKFZD8YPdwfOSsJyTc62ysfnigfUWZCqZrsmnq3BEvSowO9LF2SmipKrtWdBOWALGTLOLVTTY8vAonryjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716592942; c=relaxed/simple;
	bh=cUDEBCsesqZf2kuqchuJi0nye24O5SCy2CSipBLBdQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHC0E32L3pXIG4CUTvySAk6bCd4t4LRym+VAWIHeJTCXECEMRQ3KjYrQ/33VSLs10X66uNYpzLb/XsrMbrOPzl6Ak66PlwQwoD7HYBSKXk0mFK0WUERLJblwp5pDWyBB0KH8+FLCn09vVtay7xW5o1dbh9SGkNN8ddNY519qJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2bf5bd50afcso1173367a91.3;
        Fri, 24 May 2024 16:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716592941; x=1717197741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUDEBCsesqZf2kuqchuJi0nye24O5SCy2CSipBLBdQw=;
        b=gMF7q8zOStaJ60CZ6E1PnWOBYNF5ERzXXVoDFVMVWZaGL66BN0sSDP42A2oZ/RcQD1
         ZGSmDwWxL6Oq4iqQx8rwQWT/Lf4YJyXG6o/VwdpI4nE3+vcE5m7A0K+a/wS6CLAYAEpa
         iHRACWBpWgu8kVyjN+xqWlQU1o84OXEazTefXKWisiBDoMPLt3HM5i3wGsA+kUzTzVKJ
         lgmZnWqcyHc46XIAmYbr6eH9eE2MM03DDeqhS7s28fg74BYvhJPCk13QxYfMcBMQGnyb
         8L+jbJij2ufBTgL8dvNzzTErnsP66z4y8WGgBgI3L2RETba/AD9B2sWL6X0QSi4OzgkR
         dnKw==
X-Forwarded-Encrypted: i=1; AJvYcCWMhBLsWPleKdhac54GlvIGde6D7V27uDwlA0UX7SsSU4iLkBDbQ0pK+ZyVtrvQhFRXE/zX3f+vNs1cBf8Jg6Q3uy3A3h0H5IPrO9rde+djAQsU1C8Q0dU2PzOHoU33MmC2qkGK7VSpXJbs7+i+/g==
X-Gm-Message-State: AOJu0YzomXxK6vgwyJx718AayXUqAYNV5Q6bvsbMz6Qv3DjErxU54NeY
	FkvImUoHu+NkErRA3lEegGxBDrMlYogCx6xfOFcGrGa5o06ZqEJSiNNI3NLQwT3RKTtccN6mlRa
	HlzwvifKYr0L/hFNdZ8vyBSB0G2k=
X-Google-Smtp-Source: AGHT+IGlLeBlOcrMl1gYHHn3xpR0Idlu/GR0A9No/TU+RZSj011H8nS0o6fI1y/ai0PvpQ595DXQBpPsKM93y1Tw2ZM=
X-Received: by 2002:a17:90b:90f:b0:2bd:e304:1b27 with SMTP id
 98e67ed59e1d1-2bf5e1697d8mr3440349a91.27.1716592940809; Fri, 24 May 2024
 16:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521173952.3397644-1-weilin.wang@intel.com>
 <20240521173952.3397644-6-weilin.wang@intel.com> <CAM9d7cg7Xg=pxc5sxfGo7Om2qh3zoj2nbtyAyu6D5MOedfJ6SQ@mail.gmail.com>
In-Reply-To: <CAM9d7cg7Xg=pxc5sxfGo7Om2qh3zoj2nbtyAyu6D5MOedfJ6SQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 24 May 2024 16:22:09 -0700
Message-ID: <CAM9d7ciET=UYyVD3ubPJjjqWOXzqoaD5N_JP+tKC4aq7moeZ5w@mail.gmail.com>
Subject: Re: [RFC PATCH v9 5/7] perf stat: Add command line option for
 enabling tpebs recording
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 4:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, May 21, 2024 at 10:40=E2=80=AFAM <weilin.wang@intel.com> wrote:
> >
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > With this command line option, tpebs recording is turned off in perf st=
at on
> > default. It will only be turned on when this option is given in perf st=
at
> > command.

It'd be nice to include an example command line and output.

Thanks,
Namhyung

> >
> > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
