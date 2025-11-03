Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8F286D40
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Nov 2025 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186559; cv=none; b=GzcJ2sHS0/e+Q3BkZNRGo28jAldjeYESWRwva/sA3eaaYxLYnsrYMAFbpiq01PDRSoueU6Vgo4SdoXrekkNub5UVuLVacU6mKlYWkPDQfuzmt+GC9/8GoO87nGZn4x/jHPCLs95uzHL0flKORoE5MlNKp9i7UefJ5zWyqJiaDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186559; c=relaxed/simple;
	bh=eJqBobj4OytscvmhKPZl0zP0AFVmYk+5BUqlFCRdi3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRM8m7JSShmww2hEpN42cL6bCv/gKlxDsrjUHhiXbsPorIUvVDToDagA0QqxJP/RuYeFlCEOk+m5r+rchETEhy3ZuoqdfbQKNXA5r5d7iiiLXIuvgicsJBRWGkzScRnX4RwBplILQc2XVvsZGn7EoPUlyplRXoiMXtKe8GRLlHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjEEQcQB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjEEQcQB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295c64cb951so204325ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Nov 2025 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186557; x=1762791357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJqBobj4OytscvmhKPZl0zP0AFVmYk+5BUqlFCRdi3A=;
        b=AjEEQcQBYsdYoJaRyq3irTJM1xX6gTWJtCzlkZqQ+b/iSVmut5ljmsE3/BeH9B9WrR
         nj65BNtNfSqRC+qrAq0sGzE3rgTi5CO5AsUJDmlGSVHGRbSWhFYESDfvKp6LE0ELAJig
         5t6JU4c0c/dJ5SmZHqIRH6FMe1i+qtoti8ExeGKilrrlISbwU5GtdTasThexRC0jOZbt
         EKM6Tw9bxCJTTiV/6CyFctS5aGggSB6kAGdnDEfg6zwXY7OP6QhMiEWlIW4Q9DqrZYJr
         t4Mt44nLrC6DsJ/Rg39xOkxLL48wM3HcfCBU1WnGWJJkVWVx5KijLZUOX5+XE8a2gtqV
         2hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186557; x=1762791357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJqBobj4OytscvmhKPZl0zP0AFVmYk+5BUqlFCRdi3A=;
        b=al6Hbt50RFmBYiEfEft7wnBYPAd7M0xTH2UlAS+KgaltN/3t8DBnIozU0WRJHJtauU
         UTbTB1LnHeCBFzGv1HGCyyVGuH2/rwBIqjgMTvy2P5RyGWvCWEIF/VbVH45+LGhNRcx9
         bQo/9LnnY80VnaKIPdzrAIMWF6BEGYrD0zpG8u/e4fuUuQmhADlJxn3YgbEyGqLi+s15
         WnVK71y8USoL3QMSh2R2KsjaAHp6zRpv20lflJ3WutxcFcJQdUgo+z67ORAoCVTH+w0C
         XejZajo+O6c5SJbk9v1x/b1iPMEHBNbfvKoKAAO8JXoX7GHYPsNrgo4p3itm4ittiB+R
         sPNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXORkcQ+ashLoVu4S/MkmDCO/Xra33mj7fon4bxmdLjnbqImyREnW9LLHRs9/EO9kiYfWLA+ISDau+hbcX2qPce@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcXg+zTD6JXs1gtzZP31o0Fk8Eh+KfjgGCLtSMmnDLldVUySh
	VCJxDX8hC8SivBAmPFqhCsk8r6EfOLP7iFMiF/fC4rJrQYqSCShF81W1w1P2w1MK6YA8BAAkE50
	SDDEA2BwJIzwHkKkEAW8kyv1D4zLcxrQvdgr0cb7q
X-Gm-Gg: ASbGnctpokY5W2FZ/ro8uIsqr5Po0LEmSEz9V2B6y1ev4ezy32OuEMC2Y3l1i3DfvLM
	UO5o2xD1E9r5UMKvVYWS2bxYZS+fCiCrWQQ3ptppAj39bp2/Y3PIR4RAogr81Q4XaUOu+wu8xan
	S3Au+t/NZfgZECtxrQhzJh+rFl4Zi0KG8oBvpUeGd8vrDh50D5h/Qgddk9EOHJUyTBPluK1RtDW
	oPq6UtDh8P50kBxa4faHM8LFqIjLYjaS3GLh0slmIS6vas81lFuMWslhrYQ1NkQkjpohLj9Pwfy
	Y20pUFHSwBkWhdZo5nCtzW1Jsw==
X-Google-Smtp-Source: AGHT+IESkpVff0fTrWG6+qbua5DBKANFmK98G6/eOT2NsvwR+nXJHjYIfFHT0CWbeA3guuxRSguPyBipiQOLvR+/ViQ=
X-Received: by 2002:a17:902:d4cf:b0:295:5405:46be with SMTP id
 d9443c01a7336-295f8c8fbe9mr274955ad.1.1762186556373; Mon, 03 Nov 2025
 08:15:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQjCEfiFLJwApdlj@x1> <20251103151912.GW281971@e132581.arm.com>
In-Reply-To: <20251103151912.GW281971@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Nov 2025 08:15:45 -0800
X-Gm-Features: AWmQ_blVKwqOT3MpSdCINIgTWdpTjuwwg78TioInmeu2jRMq4fTdiOyTs1xPGF8
Message-ID: <CAP-5=fWcjoz_iNyMM6xSqkyDzmOmar-zaejSOn1L6Dta061kEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Add James Clark as a perf tools reviewer
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 7:19=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Mon, Nov 03, 2025 at 11:54:09AM -0300, Arnaldo Carvalho de Melo wrote:
> > Just FYI, I'm carrying this on the perf tools tree.
> >
> > James Clark has been actively reviewing patches and contributing
> > to perf tools. Reflect this by adding him as a reviewer in the
> > MAINTAINERS file.
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> > Acked-by: Ingo Molnar <mingo@kernel.org>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Well deserved, James. Congrats!

Great, we need more code reviews!

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
