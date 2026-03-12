Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B62229D27D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349125; cv=pass; b=Ee2Hu+eeEVOUxJ2bv5uqJDAxhbk+3w92BzzsgsxXN70t9fV8KOHjv1sQB+QCtKCHn104HjA6yxXT4WJQ6F5XWiZ88FYuEvs83EZ8aKV5sc8Cp6+J1pFqtgmk3k5xlQ6Gov+1Im3OU8Iw4HJSR4HV3TuW3LcxArxO7B+2HTHrdi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349125; c=relaxed/simple;
	bh=eeaVoLOt5LBrY6LChRQZm1JmNRslbWvvZSlXo+VXhtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0yhNjlmyvUbsNma/lKT5hLGFVNBS/isyi0US9Fq5CxcSbcbS/UmvP7TueB2LrWfajM/nCu2NkDPUG0S6hDe6rnB6m+JpjO3yON3Rn4pXY6IGhJi+/18bPjxWcriiKxXmzLDjngoni5V//gbtu7epKA/bP+nlOu4qQg6UVp6FTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVj1M28F; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVj1M28F"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae49120e97so25245ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 13:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773349123; cv=none;
        d=google.com; s=arc-20240605;
        b=h0nQfOKIKNsp1WX3oUM7zXYEs/xedaj3NV1tdmAoDiOc7mI06c1Bl60dA+s3TOkhdX
         S4cvM104Zq30F03AamsKKXviXiPiQPEmZhGjN4flPTVhOMSo3wLsAy200EB5RKmPu6GO
         JOEb3xD4AknMzer5H8ZH/kr8o6UEZKbLSAQrlVDe5XA6cWlhHvGwuo/9Ur5/wAJPvT25
         J+vjXlokSYzgm0CCdOmroAs4znjOrms9SO2EC4tUvqG92a24q68B23VfAUIYFHwXHOa0
         JqlNpCe7AujwG1AN+SV6ijKd6zatAKVs0PuYnkPw7XEhNEGTOePopkRjcx2mLw4pufj0
         g7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eeaVoLOt5LBrY6LChRQZm1JmNRslbWvvZSlXo+VXhtU=;
        fh=i/O/Kpy1EIlrOafkkUy6RIQA2ojIir2Kmw1Az2y/kl4=;
        b=IjtCrcjfhqxHQ+zI391cXk42MNRB6ilwOg7zQ7Z/lkEVouTb8cyCz1HxKdWh26RQWV
         a5nlit10x6uKvFVX3qD2Ph8MDWIBLF3mpZZPkCz8fxNSkMAJTsS+GLYm5+0YZtDG5H/F
         mXq6ZQ9Iv5kJ6DnrAt1n5ELCKvi3h0N2X54yCDl7UTN6/xldoF67u6CGcjHDtD29nY6K
         CX6T8P4sOPoiUnPWN9J0EpOruqhgvsfIblb6F/ZrUe5jaz13r2yoYk22SppsKcUdxdQ2
         VZ45gl0wG6Sp4ULpR2luaKyAurDMn3Q9Dx7wJ+Txz3ldIurHGhg5Ez1vZGXiHTuPkeba
         nIUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773349123; x=1773953923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeaVoLOt5LBrY6LChRQZm1JmNRslbWvvZSlXo+VXhtU=;
        b=gVj1M28FUEsiyN5rJS+wzCcw/3H7ZRiBhgglJJ+NH0iFhGtVsomDLXD3ss6iOxa1X8
         S8vGlfZ1StqHNEnitbDJU0Jhr/H88Z+lCn3BLrvjnKIZ4fAL0TT2p/O/FuQN8IxRLvad
         fvinVvDtyd5P3rHKkgIXLxydi1KioBhNh7gwEv4MdOQzjesUac7PU15+cnHfh4u3sjAb
         iEqfqwB1bGSLQE+6JItSRlZ+zZmIXu0DPwIIeqc9DoLzpiSQZ4ZBZonE1iKcm039Rqyg
         VmtYcTT1PNFjGhrM2alfR0THjr1hRZEc93s7a1rTtR80UatTQ19wyxpbG76BUZjSSEGn
         IQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349123; x=1773953923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eeaVoLOt5LBrY6LChRQZm1JmNRslbWvvZSlXo+VXhtU=;
        b=Rn9bWVer3SIAzXt854R5eIDpZKFIZBtfRls2SpndcQQ4nzTz5xOACPkhVrDETUpDBJ
         vvly5JJc2g2iTLisdxRpVilcpdIMCibU6Yp/2InD32JrE+/6TXCIMK6ovV2f7nR2XBHf
         y/8/QvaGvg3zGyta1VYCBzXXH1ze78MLdjXcjj3h666a0aoLLxfsq/cpzT+tURfGGxZO
         3v/LXaJ850Vlbnsrc69PtcjsqUWdVW+/7Tc1FHrhyj03eW3OK6etqx07ApJPS4ESYVpe
         MA0Ztnp4CgSEx4AlPWTXho1d86Se6zdBbTTpv02kTUwiMMEtzwNN9VkoVRjESY8dKSxP
         nIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwOyUX8gcvpoKctM0KaihXAR66PXXbOKgn4aNLKZ3Qz3otxc6t7a0PRlBNl8pfZ8c3MVzMLLB2dUwH871BqeJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YwbC+xXslrj4oYlBmrZpK2xHsJ8fxu9haWSZAkzrxgKaklAlSE7
	0nulUOVioeNFF/5Ktvm2On6s4oyru+Xc0juFk7j5bpzAIDJv7IKfobzFKnLIUpLn5oLQxH7xd5n
	Sl7gcVVAOHMCQr4JvlcnMv51DvwfyAfPgbs1rrLQP
X-Gm-Gg: ATEYQzx2Bn3G8Gr6fV7lNi+MPYpSPawq/Ipxr02tE5JtG4xEODRPozAXx/yhkwiJYek
	Y3C2tAyhBPdGQbO/Hho8vdU/R0hzwDn1yWsBb4p8tPLZiIPX6ihrddpwlSUj9IDJy5YqwprhLwZ
	P4x94UPUFLfSDY6lFMbfKNnkC4zY2bLa6VbsALmxtivis04yRTHo2/ZswI8Y26pEqVUXFpASlmn
	LmBd8snGqIstQReffhe6G09oRfVtD4Lr8h1MaDZ2NIXqxXKQ3uZVHWbUIXuIVXsGtJUz0WEyuZO
	LqukVf5YEWGh9qIfWzsZZeSah9HFvKxx+ZEuQJNAVLUQ9bM=
X-Received: by 2002:a17:902:e94f:b0:2a7:4151:2c74 with SMTP id
 d9443c01a7336-2aecb6beb82mr919355ad.16.1773349123017; Thu, 12 Mar 2026
 13:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904174430.1414548-1-irogers@google.com> <20250904204117.GC4067720@noisy.programming.kicks-ass.net>
 <20250904205924.GO4068168@noisy.programming.kicks-ass.net> <CAP-5=fXneV5fawTncLH13p_8-9OAxwpTERXk5ty=8m0s8U1ANg@mail.gmail.com>
In-Reply-To: <CAP-5=fXneV5fawTncLH13p_8-9OAxwpTERXk5ty=8m0s8U1ANg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 13:58:31 -0700
X-Gm-Features: AaiRm50zMmldWsp-VnF-_lS2lwKhAsVX1S2I90fhDsWLpm35dSqAKJK4WZahgmU
Message-ID: <CAP-5=fUod99LkN6mX0iNizracGaHCtuDZQzU8iE7Ua61Vkb9bw@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Revert "enable -fno-strict-aliasing"
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:33=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
> Anyway, the intent with adding -fno-strict-aliasing was that it was
> temporary as part of removing the libcrypto dependency and when the
> unaligned code landed we'd do this revert.

Ping.

Thanks,
Ian
