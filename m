Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16927CCF2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720292; cv=none; b=DukGsyoZW/fvlKM22cYIhrUSffHZwa2bpFfesDbV9wyrP4khSGvgD2ybzvXTBWX5V4kJlHOGHntmEqtRBe7qHbwkktMw0O8+nt9+Fpzm8u3v/9NaIdFD1xXPW6VqnSj7OVs6YIlUSI4LQ0scGYZly128S0sDJHI3XRnyFyTJQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720292; c=relaxed/simple;
	bh=I+IeUdWxiLjTU2csSrANPnlDmQ68oXdaxJe8wwbFp/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJlg+ua1AKLpBIR6eMd+P4LA8TYYIFpHSxTgqIZ3sDTDGdJxLCe9mbTUw9KQ+TNC6LJoGr932BWYd24zEhKxt05ybzIieG059my/qJ/uTTkWT/huCCcLZqnKTm8tGogypP75SGDEnwB5j048Br7KxjVM9TTHMz7CfxPnPrtEwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pw93jVhR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pw93jVhR"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24b2d018f92so37045ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 16:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757720291; x=1758325091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+IeUdWxiLjTU2csSrANPnlDmQ68oXdaxJe8wwbFp/U=;
        b=Pw93jVhRkAUIa57brajtHtLosLAh+uejWt//QEEhctWTr3rvan+Sz02ep9izvdvhLn
         nPhRyDVO80lQ29nYoVJDjEHoZMa50UPAw1+1rWELIm3tZt8Hi0VSyYz7+aLr/DQj2BdB
         I1H3j5+IX9HZVCh/uhtXN39ZAXMDnPhA/CGhprG81/GBadWV9WHe6iDGlnJW1Y2J5bPS
         gwp//ncF6Mw71pCpCZl9wdE4kJTFHxE8NqJGR4sOvq2U27YWfPT2Zgo26MsWKMZByp67
         1AGQcoRByDW5JX6FOaGtOAqVt8JbDR+o4O7BHXzPlchO+mIzJNNEEmU/Mztx3wOIt93s
         WfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757720291; x=1758325091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+IeUdWxiLjTU2csSrANPnlDmQ68oXdaxJe8wwbFp/U=;
        b=LMskN64TeDZsdHfgKNxTSJzgJfk25TYdr0smlzmbe6DrYAvaTVXJYC8mgR3KUC2Dul
         QCqra8y9ltq5AOZmltixhxNPXfC6G3roId8jL5nyfzmLeT51Mab8clB6i68HK99I9+Rd
         nT402Ciw1ZHU113OevDp7KPAfVwjDFw4Ur3XFWbs7Y69NWayK1xT8nCLLdiVsOlnRCxk
         GHmhReqU9zICraJIrjc/KCdJYtoWX1712FJlzLQDOhGZWIWjDvSgfXpi99vRXBpNyQtc
         PLc5hczDgk11sfLE2ojPnhiFIIE4SXiCAbxArfPqJkM9vcRfAOH976MdeSOHrl0OK4sX
         7CQw==
X-Forwarded-Encrypted: i=1; AJvYcCVH4aTksOhG6VuP07sWrHvuPvdSS/mJzonsjZYF/axET9Fz6f/ItWzKjJ0blduYMWYW8ELHHhMMtKZ1df1AcsfA@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjEWDlMI4egOrYzxXP9c0DhVMg8jV9PgHCfqI7jaYkUG/5X0P
	9x9si9lulqOCDGKnOZqFCQYkcrOmXqwuhIlPKEX4dRLFMbW36vwwVY9uqGYE9fgeDU/Bh1qvcOr
	psVVonLl+kpAO5dYenR9d+cSprQJ2GF3WsIshh32L
X-Gm-Gg: ASbGncu1PPqMfQxydK4U0eIcpfCLYmkumSyJvlNrzjujqHGHyUPrG4b4OB96z2VxaXV
	kV4twMjBUinyjR8DnmmRG8yo+MC/Nb6bap/dyx7qv51xcnX/CsZGvOG6VUf3mCexgkjJfL3EqiU
	SZd7J03H97UwE25x4PhW8sX2DoBuMyfrLwwjU9jKjgy3mY44ZaH31B248Gen4FFnQNrbpSDaFjS
	oJ9tuF4kv+Qz0J0FUdXNq54og==
X-Google-Smtp-Source: AGHT+IFXZpKmsBxNh/q0fzirmyD/w1U2dM9umZvCp77k9wnf3KmFys6i1BPz4WTLGTUOjHzqhU7Z7y4G4ImJlUVDVQo=
X-Received: by 2002:a17:902:e548:b0:24c:7be9:85b9 with SMTP id
 d9443c01a7336-260e5f75787mr1104205ad.14.1757720290078; Fri, 12 Sep 2025
 16:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908221727.3635572-1-irogers@google.com> <aL9oL8aAMam676Ra@google.com>
 <aMSWbjo-qY7JYAoY@x1>
In-Reply-To: <aMSWbjo-qY7JYAoY@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 12 Sep 2025 16:37:59 -0700
X-Gm-Features: Ac12FXyLvWrzlQdYTNqU0M2z-GvSe0s21WQqEMk6u9-FCWExAloYLbzvnl48ack
Message-ID: <CAP-5=fWQUE4YxbAK4-qV44WFXYjo_EPy1XcVSrOYVP=rTspKnQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: AMD IBS swfilt skip kernel tests if
 paranoia is >1
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Collin Funk <collin.funk1@gmail.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:53=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Sep 08, 2025 at 04:35:11PM -0700, Namhyung Kim wrote:
> > Hi Ian,
> >
> > On Mon, Sep 08, 2025 at 03:17:27PM -0700, Ian Rogers wrote:
> > > If not root and the perf_event_paranoid is set >1 swfilt will fail to
> > > open the event failing the test. Add check to skip the test in that
> > > case.
> >
> > Thanks for the fix!
>
> I'm taking this as an Acked-by, ok?

I have a new version but I'm discovering quite a few other issues on
the way. There are 7 patches on top of this here:
https://github.com/googleprodkernel/linux-perf/commits/google_tools_master/
I'll send the new version now, but I'd been tardy as it wasn't clear I
was done with fixes yet.

Thanks,
Ian
